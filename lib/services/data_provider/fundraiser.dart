import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:http/http.dart' as http;

class FundraiseDataProvider {
  final http.Client httpClient;

  FundraiseDataProvider({required this.httpClient});

  // creating a fundraise
  Future<bool> createFundraise(
      Fundraise fundraise, String token, File image) async {
    http.Response? response;
     await getImage(token, image).then((imageResp) async {
      print("the response image is $imageResp");
      response = await httpClient.post(
        Uri.parse(EndPoints.fundraises),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(<String, dynamic>{
          'title': fundraise.title,
          'image': imageResp,
          'goalAmount': fundraise.goalAmount,
          'story': fundraise.story,
          'category': fundraise.category!.categoryID,
          'location': <String, dynamic>{
            'latitude': fundraise.location!.latitude,
            'longitude': fundraise.location!.longitude
          },
          'isPublished': true,
        }),
      );
    });
    // print("create fundraise status ${response!.statusCode}");
    if (response!.statusCode == 201) {
      return true;
    } else {
      print("Error happening at ${response!.body}");
      throw Exception(response!.body);
    }
  }

  // Get popular fundraisers
  Future<HomeFundraise> getPopularFundraises(int page) async {
    print("geting popular fundraisers");
    // var url = Uri.parse(EndPoints.popularFundraisers + '?page=$page');
    final response = await httpClient.get(
      Uri.parse(EndPoints.popularFundraisers + '?page=$page'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    print("error");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success popular fundraisers");
      final popularFundraises =
          jsonDecode(response.body) as Map<String, dynamic>;
      print("success popular fundraisers");
      return HomeFundraise.fromJson(popularFundraises);
    } else {
      print("The exception is ");
      print(response.body);
      throw Exception(response.body);
    }
  }

  // Get single fundraise
  Future<Fundraise> getSingleFundraise(String id) async {
    print('fundraise Id is $id');
    print(
      Uri.parse(EndPoints.fundraises + id),
    );
    final response = await httpClient.get(
      Uri.parse(EndPoints.fundraises + id),
    );

    // print("response status");
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      // print('jsonDecoded');
      // print(jsonDecode(response.body));
      final singleFundraise = jsonDecode(response.body);
      return Fundraise.fromJson(singleFundraise);
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  // Update fundraise
  Future<bool> updateFundraise(Fundraise fundraise, String token,
      {File? image}) async {
    print(" Update image is  $image");

    http.Response? response;
    image == null
        ? response = await httpClient.put(
            Uri.parse(
              EndPoints.fundraises + fundraise.id.toString(),
            ),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token,
            },
            body: jsonEncode(<String, dynamic>{
              "location": <String, dynamic>{
                "latitude": fundraise.location!.latitude,
                "longitude": fundraise.location!.longitude,
              },
              "totalRaised": fundraise.totalRaised,
              "isPublished": fundraise.isPublished,
              "totalShareCount": fundraise.totalSharedCount,
              "likeCount": fundraise.likeCount,
              if (fundraise.beneficiary != null)
                'beneficiary': fundraise.beneficiary!.id,
              "title": fundraise.title,
              "image": fundraise.image,
              "goalAmount": fundraise.goalAmount,
              "story": fundraise.story,
              "organizer": fundraise.organizer!.id,
              "likedBy": fundraise.likedBy,
              "category": fundraise.category!.categoryID,
            }),
          )
        : await getImage(token, image).then((imageResponse) async {
            response = await httpClient.put(
              Uri.parse(
                EndPoints.fundraises + fundraise.id.toString(),
              ),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': token,
              },
              body: jsonEncode(<String, dynamic>{
                "location": <String, dynamic>{
                  "latitude": fundraise.location!.latitude,
                  "longitude": fundraise.location!.longitude,
                },
                "totalRaised": fundraise.totalRaised,
                "isPublished": fundraise.isPublished,
                "totalShareCount": fundraise.totalSharedCount,
                "likeCount": fundraise.likeCount,
                "title": fundraise.title,
                "image": imageResponse,
                "goalAmount": fundraise.goalAmount,
                "story": fundraise.story,
                "organizer": fundraise.organizer!.id,
                "likedBy": fundraise.likedBy,
                "category": fundraise.category!.categoryID,
              }),
            );
          });
    print("update status code ${response!.statusCode}");
    print("update body  ${response!.body}");
    if (response!.statusCode == 200) {
      return true;
    } else {
      print("Update exceptin ${response!.body}");
      throw Exception(response!.body);
    }
  }

  // delete fundraise
  Future<String> deleteFundraise(String id, String token) async {
    final response = await httpClient
        .delete(Uri.parse(EndPoints.fundraises + id), headers: <String, String>{
      'x-auth-token': token,
    });

    if (response.statusCode == 200) {
      return "successfull";
    } else {
      throw Exception('Failed to delete fundraise');
    }
  }

  // get User fundraisers

  // get all user fundraises

  // get fundraisers created by a user
  Future<HomeFundraise> getUserFundaisers(String token, int page) async {
    var url = Uri.parse(EndPoints.fundraises + "user/?page=$page");
    print(url);
    final response = await httpClient.get(url, headers: <String, String>{
      'x-auth-token': token,
    });
    if (response.statusCode == 200) {
      final popularFundraises =
          jsonDecode(response.body) as Map<String, dynamic>;
      return HomeFundraise.fromJson(popularFundraises);
    } else {
      throw Exception("Faild to get popular fundraises");
    }
  }

  // get fundraisers created by a member
  Future<HomeFundraise> getMemberFundrases(String token, int page) async {
    var url = Uri.parse(EndPoints.teamMemberFundraises + "?page=$page");
    print(url);
    final response = await httpClient.get(url, headers: <String, String>{
      'x-auth-token': token,
    });
    if (response.statusCode == 200) {
      final popularFundraises =
          jsonDecode(response.body) as Map<String, dynamic>;
      return HomeFundraise.fromJson(popularFundraises);
    } else {
      throw Exception(response.body);
    }
  }

  // search fundraiser
  Future<HomeFundraise> searchFundraises(String title, int pageNumber) async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.searchURL + title + "/?page=$pageNumber"),
    );

    if (response.statusCode == 200) {
      return HomeFundraise.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // beneficiary fundraisers
  Future<HomeFundraise> beneficiaryFundraisers(
      String token, int pageNumber) async {
    print(Uri.parse(EndPoints.benficiaryFundraiserURL + "/?page=$pageNumber"));
    final response = await httpClient.get(
        Uri.parse(EndPoints.benficiaryFundraiserURL + "/?page=$pageNumber"),
        headers: <String, String>{
          'x-auth-token': token,
        });
        
    if (response.statusCode == 200) {
      return HomeFundraise.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
