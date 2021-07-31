import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:http/http.dart' as http;

class FundraiseDataProvider {
  final http.Client httpClient;

  FundraiseDataProvider({required this.httpClient});

  // creating a fundraise
  Future<void> createFundraise(Fundraise fundraise, String token) async {
    http.Response response;
    response = await httpClient.post(
      Uri.parse(EndPoints.baseURL + '/api/fundraisers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'title': fundraise.title,
        'image':
            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
        'goalAmount': fundraise.goalAmount,
        'story': fundraise.story,
        'category': fundraise.category!.categoryID,
        'location': <String, dynamic>{
          'latitude': fundraise.location!.latitude,
          'longitude': fundraise.location!.longitude
        },
        'beneficiary': fundraise.beneficiary!.id,
        'isPublished': true,
      }),
    );
    // await getImage(token, fundraise.image!).then((image) async {});

    if (response.statusCode == 201) {
      print(response.body);
    } else {
      print("Error happening at ${response.body}");
      throw Exception(response.body);
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
  Future<Fundraise> updateFundraise(Fundraise fundraise, String token) async {
    print("fundraise title ${fundraise.title}");
    print("fundraise title ${jsonEncode(fundraise.id)}");
    print("token $token");
    final update = fundraise.updates!.map((update) => update.id).toList();
    print("update is $update");
    final response = await httpClient.put(
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
        "category": fundraise.category!.categoryID,
        "beneficiary": fundraise.beneficiary!.id,
        "organizer": fundraise.organizer!.id,
      }),
    );
    print("update status code ${response.statusCode}");
    print("update body  ${response.body}");
    if (response.statusCode == 200) {
      return fundraise;
    } else {
      print("Update exceptin ${response.body}");
      throw Exception(response.body);
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

  Future<String> getImage(String token, String image) async {
    print("Uploading image $image");
    print(token);
    String image1 = image.split(":").first;
    String image2 = image.split(":").last;
    print(image1);
    print(image2);
    final response = await httpClient.post(
      Uri.parse(EndPoints.imageURL),
      headers: <String, String>{'x-auth-token': token},
      body: {'image': image1, 'name': image2},
    );
    if (response.statusCode == 200) {
      String image = jsonDecode(response.body);
      print('response image $image');
      return image;
    } else {
      print("image upload exception ${response.reasonPhrase}");
      print("image upload exception ${response.headers}");
      print("image upload exception ${response.statusCode}");
      print("image upload exception ${response.body}");

      throw Exception(response.reasonPhrase);
    }
  }

  // get fundraisers created by a user
  Future<HomeFundraise> getUserFundaisers(String token, String userId) async {
    print(userId);
    var url = Uri.parse(EndPoints.baseURL + "/api/fundraisers/user/$userId");
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
}
