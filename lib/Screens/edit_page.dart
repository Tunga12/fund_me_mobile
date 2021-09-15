import 'dart:io';

import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/constants/actions.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/services/provider/fundraise.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/custom_cached_network_image.dart';
import 'package:crowd_funding_app/widgets/custom_card.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EditPage extends StatefulWidget {
  final Fundraise fundraise;
  EditPage(this.fundraise);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  String? _category;
  String locationValue = "";
  File? image;

  getCategories() async {
    // await context.read<CategoryModel>().getAllCategories();
    setState(() {
      _category = widget.fundraise.category!.categoryID;
      locationValue = widget.fundraise.location!.latitude +
          " " +
          widget.fundraise.location!.latitude;
    });
  }

  File? _image;
  _chooseSource() {
    return AlertDialog(
      title: Text(LocaleKeys.choose_method_label_text.tr()),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () async {
                // _getImage(ImageSource.camera);
                var file =
                    await pickImageFormFile(ImageSource.camera, _imagePicker);
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

  Map<String, dynamic> _fundraiseDetail = {};
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Response response = context.watch<CategoryModel>().response;
    if (response.status == ResponseStatus.LOADING) {
      return LoadingScreen();
    } else if (response.status == ResponseStatus.CONNECTIONERROR) {
      return ResponseAlert(response.message);
    } else if (response.status == ResponseStatus.FORMATERROR) {
      return ResponseAlert(response.message);
    }
    List<Category> categories = response.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.edit_bottom_bar_button.tr(),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    locationValue != 'choose location') {
                  _formKey.currentState!.save();

                  UserPreference userPreference = UserPreference();
                  PreferenceData preferenceData =
                      await userPreference.getUserToken();

                  Fundraise fundraise = widget.fundraise.copyWith(
                    title: _fundraiseDetail['title'],
                    goalAmount: int.parse(_fundraiseDetail['goalAmount']),
                    story: _fundraiseDetail['story'],
                    category: _fundraiseDetail['category'],
                    location: _fundraiseDetail['location'],
                  );
                  loadingProgress(context);
                  if (_image == null)
                    await context
                        .read<FundraiseModel>()
                        .updateFundraise(fundraise, preferenceData.data);
                  else
                    await context.read<FundraiseModel>().updateFundraise(
                        fundraise, preferenceData.data,
                        image: _image);
                  Response response = context.read<FundraiseModel>().response;
                  if (response.status == ResponseStatus.SUCCESS) {
                    Fluttertoast.showToast(
                        msg: "Successfully Updated!",
                        toastLength: Toast.LENGTH_LONG);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName, (route) => false);
                  } else {
                    Navigator.pop(context);
                    authShowDialog(context, Text(response.message),
                        close: true, error: true);
                  }
                }
              },
              child: Text(LocaleKeys.save_button_text.tr()))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.35,
                    child: _image == null
                        ? CustomCachedNetworkImage(
                          isTopBorderd: false,
                            image: widget.fundraise.image!)
                        : Image.file(
                            _image!,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                      bottom: 10.0,
                      right: 20.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.2)),
                        child: Text(LocaleKeys.change_cover_button_text.tr(),
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => _chooseSource());
                        },
                      ))
                ],
              ),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1.0,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.campaign_overview_label_text.tr(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              TextFormField(
                                initialValue: widget.fundraise.title,
                                onSaved: (value) {
                                  setState(() {
                                    _fundraiseDetail['title'] = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Title required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: LocaleKeys.title_label_text.tr(),
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              TextFormField(
                                initialValue:
                                    widget.fundraise.goalAmount.toString(),
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  setState(() {
                                    _fundraiseDetail['goalAmount'] = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Goal Amount required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: LocaleKeys.goal_amount_label_text.tr(),
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              TextFormField(
                                initialValue: widget.fundraise.story,
                                maxLines: 5,
                                onSaved: (value) {
                                  setState(() {
                                    _fundraiseDetail['story'] = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Story required!";
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: LocaleKeys.story_label_text.tr(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1.0,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.campaign_detail_label_text.tr(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              // TextFormField(
                              //   initialValue: "https://go.fundme.com/sample",
                              //   maxLines: 2,
                              //   onChanged: (value) {},
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return "Campaign Link required!";
                              //     }
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Campaign Link",
                              //   ),
                              // ),
                              SizedBox(
                                height: 18.0,
                              ),
                              DropdownButtonFormField<String>(
                                value: _category,
                                onChanged: (value) {
                                  setState(() {
                                    _category = value;
                                  });
                                },
                                items: categories
                                    .map(
                                      (category) => DropdownMenuItem<String>(
                                        child: Text("${category.categoryName}"),
                                        value: category.categoryID,
                                      ),
                                    )
                                    .toList(),
                                onSaved: (value) {
                                  setState(() {
                                    _fundraiseDetail['category'] =
                                        Category(categoryID: value);
                                  });
                                },
                                validator: (value) {
                                  if (value == "0") {
                                    return 'select category';
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: LocaleKeys.category_label_text.tr(),
                                ),
                              ),
                              SizedBox(
                                height: 18.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      // );

                                      Position position =
                                          await Geolocator.getCurrentPosition(
                                              desiredAccuracy:
                                                  LocationAccuracy.high);
                                      Location locationObject = Location(
                                        latitude: position.latitude.toString(),
                                        longitude:
                                            position.longitude.toString(),
                                      );
                                      setState(() {
                                        locationValue =
                                            locationObject.latitude +
                                                " " +
                                                locationObject.longitude;

                                        _fundraiseDetail['location'] =
                                            locationObject;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.place,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "$locationValue",
                                    style: labelTextStyle.copyWith(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor
                                            .withOpacity(0.6)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                LocaleKeys.campaign_created_label_text.tr(),
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.grey.withOpacity(0.4),
              //           spreadRadius: 1.0,
              //           blurRadius: 1.0,
              //           offset: Offset(0, 3))
              //     ],
              //   ),
              //   padding: EdgeInsets.symmetric(
              //     vertical: 20.0,
              //     horizontal: 20.0,
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Team",
              //         style: Theme.of(context).textTheme.bodyText1,
              //       ),
              //       SizedBox(
              //         height: 15.0,
              //       ),
              //       Text(
              //         "Fundraise with a team will display their name(s) on your campaign page, allow them to thank donors and keep them updated.",
              //         style: Theme.of(context)
              //             .textTheme
              //             .bodyText1!
              //             .copyWith(height: 1.5),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.grey.withOpacity(0.4),
              //           spreadRadius: 1.0,
              //           blurRadius: 1.0,
              //           offset: Offset(0, 3))
              //     ],
              //   ),
              //   padding: EdgeInsets.all(20.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Fundraise Settings",
              //         style: Theme.of(context).textTheme.bodyText1,
              //       ),
              //       FundraiseSettingItem(
              //         title: 'Allow donors to leave comments on my fundraiser.',
              //       ),
              //       FundraiseSettingItem(
              //         title: "Allow donations to my fundraiser",
              //       ),
              //       FundraiseSettingItem(
              //         title: "Allow my fundraiser to appear in search results",
              //       ),
              //       Text(
              //         "Your fundraiser will appear in GoFundMe search results and other online search engines (if this is turned off people will still be able to view your fundraiser if you have the link). ",
              //         style: Theme.of(context).textTheme.bodyText1,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10.0,
              ),
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.team_title_text.tr(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                LocaleKeys.you_will_nolonger_have_access_label_text.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15.0),
                          ),
                  
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 50.0,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 1.5, color: Colors.red.shade900),
                          ),
                        ),
                        onPressed: () async {
                          UserPreference userPreference = UserPreference();
                          PreferenceData preferenceData =
                              await userPreference.getUserToken();
                          loadingProgress(context);
                          await context.read<FundraiseModel>().deleteFundraise(
                              widget.fundraise.id!, preferenceData.data);
                          Response response =
                              context.read<FundraiseModel>().response;
                          if (response.status == ResponseStatus.SUCCESS) {
                            Fluttertoast.showToast(
                                msg: "Successfully Deleted!",
                                toastLength: Toast.LENGTH_LONG);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomePage.routeName, (route) => false);
                          } else {
                            Navigator.pop(context);
                            authShowDialog(context, Text(response.message),
                                close: true, error: true);
                          }
                        },
                        child: Text(
                         LocaleKeys.delete_fundraiser_button_text.tr(),
                          style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
