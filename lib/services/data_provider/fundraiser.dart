import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class FundraiseDataProvider {
  final http.Client httpClient;

  FundraiseDataProvider({required this.httpClient});

  // creating a fundraise
  Future<bool> createFundraise(
      Fundraise fundraise, String token, File image) async {
    print("create token $token");
    http.Response? response;
    final imageResponse = await getImage(token, image).then((image) async {
      response = await httpClient.post(
        Uri.parse(EndPoints.baseURL + '/api/fundraisers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode(<String, dynamic>{
          'title': fundraise.title,
          'image': image,
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

    print("create fundraise status ${response!.statusCode}");

    if (response!.statusCode == 201 &&
        imageResponse.toString().startsWith("http")) {
      return true;
    } else {
      print("Error happening at ${response!.body}");
      throw Exception(response!.body);
    }
  }

  // Get popular fundraisers
  Future<HomeFundraise> getPopularFundraises() async {
    var url = Uri.https(
        "shrouded-bastion-52038.herokuapp.com", '/api/fundraisers/popular');
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final popularFundraises =
          jsonDecode(response.body) as Map<String, dynamic>;
      return HomeFundraise.fromJson(popularFundraises);
    } else {
      throw Exception("Faild to get popular fundraises");
    }
  }

  // Get single fundraise
  Future<Fundraise> getSingleFundraise(String id) async {
    final response = await httpClient.get(
      Uri.parse(EndPoints.fundraises + id),
    );

    if (response.statusCode == 200) {
      final singleFundraise = jsonDecode(response.body);
      return Fundraise.fromJson(singleFundraise);
    } else {
      throw Exception('Failed to get fundraise');
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
  Future<HomeFundraise> getUserFundaisers(String token) async {
    var url = Uri.parse(EndPoints.baseURL + "/api/fundraisers/user");
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
  Future<HomeFundraise> getMemberFundrases(String token) async {
    var url = Uri.parse(EndPoints.teamMemberFundraises);
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
}
