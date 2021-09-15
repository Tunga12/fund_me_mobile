import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_page_two.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_label_text.dart';
import 'package:crowd_funding_app/widgets/form_progress.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateFundraiserPageOne extends StatefulWidget {
  const CreateFundraiserPageOne({Key? key}) : super(key: key);

  @override
  _CreateFundraiserPageOneState createState() =>
      _CreateFundraiserPageOneState();
}

class _CreateFundraiserPageOneState extends State<CreateFundraiserPageOne> {
  final _formKey = GlobalKey<FormState>();
  String _category = '0';
  bool btnEnabled = false;
  String locationValue = LocaleKeys.choose_your_label_text.tr();
  Map<String, dynamic> _fundraiseInfo = {};
  @override
  void initState() {
    super.initState();
  }

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
    print("category is $categories");

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                  ),
                  FormProgress(
                    size: size,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
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
                    LocaleKeys.step_1_of_3_label_text.tr(),
                    style: stepTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withAlpha(180)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    LocaleKeys.fundraiser_detail_lable_text.tr(),
                    style: bodyHeaderTextStyle.copyWith(
                      color:
                          Theme.of(context).secondaryHeaderColor.withAlpha(250),
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: () {
                      setState(() {
                        btnEnabled = _formKey.currentState!.validate();
                      });
                    },
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabelText(
                            text: LocaleKeys.how_much_would_label_text.tr()),
                        TextFormField(
                          key: Key("goal_amount_mount_field"),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _fundraiseInfo['goalAmount'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.amount_required_label_text.tr();
                            }
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 0.0),
                            hintText:
                                "\$ ${LocaleKeys.enter_amount_label_text.tr()}",
                            suffixIcon: buildCustomSuffixIcon(
                              LocaleKeys.usd_label_text.tr(),
                            ),
                          ),
                        ),
                        FormLabelText(
                            text: LocaleKeys.what_kind_of_fundrsing_label_text
                                .tr()),
                        DropdownButtonFormField<String>(
                          key: Key("category_selection_field"),
                          value: _category,
                          onChanged: (value) {
                            setState(() {
                              _category = value!;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _fundraiseInfo['category'] =
                                  Category(categoryID: value);
                            });
                          },
                          validator: (value) {
                            if (value == '0') {
                              return LocaleKeys.select_category_label_text.tr();
                            }
                          },
                          items: categories
                              .map(
                                (category) => DropdownMenuItem<String>(
                                  child: Text(
                                    "${category.categoryName}",
                                    key: Key('${category.categoryID}'),
                                  ),
                                  value: category.categoryID,
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              key: Key("choose_location_button"),
                              onPressed: () async {
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                Location locationObject = Location(
                                  latitude: position.latitude.toString(),
                                  longitude: position.longitude.toString(),
                                );
                                setState(() {
                                  locationValue = locationObject.latitude +
                                      " " +
                                      locationObject.longitude;

                                  _fundraiseInfo['location'] = locationObject;
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
                        SizedBox(height: 70.0),
                        btnEnabled && locationValue != "choose your location"
                            ? ContinueButton(
                                key: Key("continue_create_button"),
                                title: LocaleKeys.continue_button_text.tr(),
                                isValidate: true,
                                onPressed: () {
                                  _formKey.currentState!.save();
                                 
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CreateFundraiserPageTwo(
                                        fundraiseInfo: _fundraiseInfo,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ContinueButton(
                                title: LocaleKeys.continue_button_text.tr(),
                                isValidate: false,
                                onPressed: () {},
                              )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCustomSuffixIcon(String title) {
    return Container(
      width: 0,
      alignment: Alignment(-0.99, 0.0),
      child: Text(
        title,
        style: labelTextStyle.copyWith(
          color: Theme.of(context).secondaryHeaderColor.withOpacity(
                0.6,
              ),
        ),
      ),
    );
  }

  Widget buildCustomPrifixIcon(Widget child) {
    return Container(width: 0, alignment: Alignment(-0.99, 0.0), child: child);
  }
}
