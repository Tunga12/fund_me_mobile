import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/update.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import "package:provider/provider.dart";
import 'package:easy_localization/easy_localization.dart';

class UpdateCameraPage extends StatefulWidget {
  const UpdateCameraPage({Key? key, required this.fundraiseId})
      : super(key: key);
  final String fundraiseId;

  @override
  _UpdateCameraPageState createState() => _UpdateCameraPageState();
}

class _UpdateCameraPageState extends State<UpdateCameraPage> {
  File? _image;
  final _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _post = false;
  String _updateData = "";
  _chooseSource() {
    return AlertDialog(
      title: Text(LocaleKeys.choose_method_label_text.tr()),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () async {
                // _getImage(ImageSource.camera);
                File? file =
                    await pickImageFormFile(ImageSource.camera, _imagePicker);
                // File? croppedFile = await cropImage(file!);
                setState(() {
                  _image = file!;
                });

                Navigator.of(context).pop();
              },
              leading: Icon(Icons.add_a_photo),
              title: Text(LocaleKeys.take_photo_label_text.tr()),
            ),
            ListTile(
              onTap: () async {
                File? file =
                    await pickImageFormFile(ImageSource.gallery, _imagePicker);
                // File? croppedFile = await cropImage(file!);
                setState(() {
                  _image = file!;
                });
                Navigator.of(context).pop();
              },
              leading: Icon(Icons.collections),
              title: Text(LocaleKeys.choose_gallary_label_text.tr()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_image != null) {
      print("the image size is");
      final size = _image!.lengthSync();
      final sizeInMb = size / (1024 * 1024);
      print("${sizeInMb}MB");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.story_label_text.tr()),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (_post && _image != null)
            // if (!isBigger(_image!))
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    loadingProgress(context);
                    UserPreference userPreference = UserPreference();
                    PreferenceData preferenceData =
                        await userPreference.getUserToken();
                    Update update = Update(content: _updateData);
                    await context.read<UpdateModel>().createUpdate(
                        update, preferenceData.data, widget.fundraiseId,
                        image: _image);
                    Response response = context.read<UpdateModel>().response;
                    if (response.status == ResponseStatus.SUCCESS) {
                      Fluttertoast.showToast(
                          msg: "Successfully Updated!",
                          toastLength: Toast.LENGTH_LONG);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomePage.routeName, (route) => false,
                          arguments: 2);
                    } else {
                      Navigator.pop(context);
                      authShowDialog(context, Text("failed to update"),
                          close: true, error: true);
                    }
                  }
                },
                child: Text(
                  LocaleKeys.post_label_label_text.tr(),
                ),
              ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: size.width,
          child: Column(
            children: [
              _image == null
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: DottedBorder(
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
                                    LocaleKeys.add_photoo_button_text.tr(),
                                    style: bodyTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: size.height * 0.5,
                      child: Column(
                        children: [
                          
                          Container(
                            height: size.width * 0.6,
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: GestureDetector(
                                  onTap: () async {
                                    File? croppedFile =
                                        await cropImage(_image!);
                                    setState(() {
                                      _image = croppedFile!;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    child: Icon(
                                      Icons.crop,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      LocaleKeys.change_photo_label_text.tr(),
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
                                    _post = false;
                                  });
                                },
                                child: Text(LocaleKeys.remove_button_text.tr()),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                    ),
              Form(
                key: _formKey,
                onChanged: () {
                  setState(() {
                    _post = _formKey.currentState!.validate();
                  });
                },
                child: TextFormField(
                  onSaved: (value) {
                    setState(() {
                      _updateData = value!;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.story_required_label_text.tr();
                    }
                  },
                  maxLines: 8,
                  decoration: InputDecoration(
                      labelText: LocaleKeys.add_story_label_text.tr(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              width: 1.2,
                              color: Theme.of(context).secondaryHeaderColor))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
