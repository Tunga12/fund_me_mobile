import 'dart:convert';
import 'dart:io';

import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/Screens/fundraiser_preview.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/form_progress.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/preview_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateFundraiserPageThree extends StatefulWidget {
  final Map<String, dynamic> fundraiseInfo;
  CreateFundraiserPageThree({required this.fundraiseInfo});

  @override
  _CreateFundraiserPageThreeState createState() =>
      _CreateFundraiserPageThreeState();
}

class _CreateFundraiserPageThreeState extends State<CreateFundraiserPageThree> {
  File? _image;
  final _imagePicker = ImagePicker();

  // image picker
  _getImage(ImageSource imageSource) async {
    XFile? imageFile = await _imagePicker.pickImage(source: imageSource);

    if (imageFile == null) return;
    setState(() {
      _image = File(imageFile.path);
    });
  }

  // Choose whether to take image from gallery or take picture using camera.
  _chooseSource() {
    return AlertDialog(
      title: Text("choose method"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                _getImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              leading: Icon(Icons.add_a_photo),
              title: Text("take a photo"),
            ),
            ListTile(
              onTap: () {
                _getImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              leading: Icon(Icons.collections),
              title: Text("choose from gallery"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Response response = Provider.of<FundraiseModel>(context).response;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormProgress(
                      size: size,
                      color: Theme.of(context).accentColor,
                    ),
                    FormProgress(
                      size: size,
                      color: Theme.of(context).accentColor,
                    ),
                    FormProgress(
                      size: size,
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STEP 3 OF 3',
                      style: stepTextStyle.copyWith(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withAlpha(180)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Almost done. Add a fundraiser photo",
                      style: bodyHeaderTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withAlpha(250),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "A feature photo or video helps tell your story. you can also edit or add more photos later.",
                      style: bodyTextStyle.copyWith(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _image == null
                        ? DottedBorder(
                            radius: Radius.circular(12.0),
                            strokeWidth: 1.5,
                            dashPattern: [8, 4],
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.4),
                            child: SizedBox(
                              width: size.width,
                              height: size.height * 0.36,
                              child: TextButton(
                                style: TextButton.styleFrom(),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => _chooseSource());
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Add photo or video",
                                      style: bodyTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: size.width,
                            height: size.height * 0.36,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                            image: FileImage(_image!),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10.0,
                                      right: 10.0,
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        child: Icon(
                                          Icons.crop,
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _image = null;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (context) => _chooseSource(),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          Text(
                                            "change photo",
                                            style: bodyTextStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        print("Remove");
                                        setState(() {
                                          _image = null;
                                        });
                                      },
                                      child: Text("Remove"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 50.0,
                    ),
                    _image == null
                        ? PreviewButton(
                            isActive: false,
                            onPressed: () {
                              print("hello");
                            },
                          )
                        : PreviewButton(
                            isActive: true,
                            onPressed: () async {
                              print("done");
                              print(_image);
                              PreferenceData userInfo =
                                  await UserPreference().getUserInfromation();
                              User user = userInfo.data;
                              final info = {
                                'title': widget.fundraiseInfo['title'],
                                'story': widget.fundraiseInfo['story'],
                                'location': widget.fundraiseInfo['location'],
                                'goalAmount':
                                    widget.fundraiseInfo['goalAmount'],
                                'category': widget
                                    .fundraiseInfo['category'].categoryName,
                                'image': _image,
                                'user': user,
                              };

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FundraiserPreview(info: info),
                                ),
                              );
                            },
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _image == null
                        ? CompleteButton(
                            child: Text("Complete fundraiser",
                                style: labelTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(
                                        0.6,
                                      ),
                                )),
                            isValidate: false,
                            onPressed: () {
                              print("done");
                            },
                          )
                        : CompleteButton(
                            child: Text(
                              'Complete fundraiser',
                              style: labelTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Theme.of(context).backgroundColor),
                            ),
                            isValidate: true,
                            onPressed: () async {
                              loadingProgress(context);
                              PreferenceData userInfo =
                                  await UserPreference().getUserInfromation();

                              String byte64Image =
                                  base64Encode(_image!.readAsBytesSync());
                              String fileImage = _image!.path.split('/').last;

                              Fundraise fundraise = Fundraise(
                                title: widget.fundraiseInfo['title'],
                                story: widget.fundraiseInfo['story'],
                                location: widget.fundraiseInfo['location'],
                                category: widget.fundraiseInfo['category'],
                                image: byte64Image + ":" + fileImage,
                                goalAmount: int.parse(
                                    widget.fundraiseInfo['goalAmount']),
                                beneficiary: userInfo.data,
                              );
                              PreferenceData tokenInfo =
                                  await UserPreference().getUserToken();
                              String token = tokenInfo.data;

                              await context
                                  .read<FundraiseModel>()
                                  .createFundraise(fundraise, token);
                              if (response.status ==
                                  ResponseStatus.CONNECTIONERROR) {
                                authShowDialog(context, Text(response.message),
                                    error: true, close: true);
                                return;
                              } else if (response.status ==
                                  ResponseStatus.FORMATERROR) {
                                authShowDialog(context, Text(response.message),
                                    error: true, close: true);
                                return;
                              } else if (response.status ==
                                  ResponseStatus.MISMATCHERROR) {
                                authShowDialog(
                                    context,
                                    Text(
                                      response.message,
                                    ),
                                    error: true,
                                    close: true);
                                return;
                              } else if (response.status ==
                                  ResponseStatus.SUCCESS) {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Successfully created!",
                                    toastLength: Toast.LENGTH_LONG);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomePage.routeName,
                                  (Route<dynamic> route) => false,
                                );
                                return;
                              } else {}
                              authShowDialog(
                                  context,
                                  Text(
                                    response.message,
                                  ),
                                  error: true,
                                  close: true);

                              return;
                            },
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CompleteButton extends StatelessWidget {
  CompleteButton({
    required this.isValidate,
    required this.onPressed,
    required this.child,
  });
  Function onPressed;
  bool isValidate;
  Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 45.0,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: isValidate
                ? Theme.of(context).accentColor
                : Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
          ),
          onPressed: () {
            onPressed();
          },
          child: child),
    );
  }
}
