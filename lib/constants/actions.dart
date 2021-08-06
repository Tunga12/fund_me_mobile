import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/endpoints.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/services/provider/team_member.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void acceptInvitation(BuildContext context, String email, String token,
    String fundraiseId) async {
  await context
      .read<TeamMemberModel>()
      .createTeamMember(email, token, fundraiseId);
  Response response = context.read<TeamMemberModel>().response;
  await context
      .read<TeamMemberModel>()
      .verifyTeamMember(true, token, fundraiseId);
  response = context.read<TeamMemberModel>().response;
  if (response.status == ResponseStatus.SUCCESS) {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  } else if (response.status == ResponseStatus.LOADING) {
  } else {
    ResponseAlert(response.message);
  }
}

void declineInvitaion(BuildContext context, String email, String token,
    String fundraiseId) async {
  await Provider.of<TeamMemberModel>(context)
      .createTeamMember(email, token, fundraiseId);
  Response response = context.read<TeamMemberModel>().response;
  await context
      .read<TeamMemberModel>()
      .verifyTeamMember(false, token, fundraiseId);
  response = context.read<TeamMemberModel>().response;
  if (response.status == ResponseStatus.SUCCESS) {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  } else if (response.status == ResponseStatus.LOADING) {
  } else {
    ResponseAlert(response.message);
  }
}

Future<String> getImage(String token, File image) async {
  // print("image ${image.path}");

  // String base64Image = base64Encode(image.readAsBytesSync());
  // String fileName = image.path.split("/").last;
  // var res = await httpClient.post(
  //     Uri.parse(
  //       EndPoints.imageURL,
  //     ),
  //     headers: <String, String>{
  //       'x-auth-token': token,
  //     },
  //     body: {
  //       "image": base64Image,
  //       "name": fileName,
  //     });
  // if (res.statusCode == 201) {
  //   return jsonDecode(res.body);
  // } else {
  //      print("image upload exception ${res.reasonPhrase}");
  //   print("image upload exception ${res.headers}");
  //   print("image upload exception ${res.statusCode}");
  //   print("image upload exception $res");
  //   throw Exception(res.body);
  // }
  print("image path is ${image.path}");

  var headers = {
    'x-auth-token': token,
  };
  var request = http.MultipartRequest('POST', Uri.parse(EndPoints.imageURL));
  request.files.add(await http.MultipartFile.fromPath('image', image.path));
  request.headers.addAll(headers);
  var res = await request.send();

  if (res.statusCode == 201) {
    return await res.stream.bytesToString();
  } else {
    print("image upload exception ${res.reasonPhrase}");
    print("image upload exception ${res.headers}");
    print("image upload exception ${res.statusCode}");
    print("image upload exception $res");

    throw Exception(res.reasonPhrase);
  }
}

Future<File?> pickImageFormFile(
    ImageSource imageSource, ImagePicker imagePicker) async {
  XFile? imageFile = await imagePicker.pickImage(source: imageSource);

  if (imageFile == null) return null;
  return File(imageFile.path);
}

 
// Future<File?> chooseSource() asy {
//     return AlertDialog(
//       title: Text("choose method"),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             ListTile(
//               onTap: () async {
//                 // _getImage(ImageSource.camera);
//                 File? file =
//                     await pickImageFormFile(ImageSource.camera, _imagePicker);
//                     setState(() {
//                   _image = file!;
//                 });

//                 Navigator.of(context).pop();
//               },
//               leading: Icon(Icons.add_a_photo),
//               title: Text("take a photo"),
//             ),
//             ListTile(
//               onTap: () async {
//                 File? file =
//                     await pickImageFormFile(ImageSource.gallery, _imagePicker);
//                 setState(() {
//                   _image = file!;
//                 });
//                 Navigator.of(context).pop();
//               },
//               leading: Icon(Icons.collections),
//               title: Text("choose from gallery"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
