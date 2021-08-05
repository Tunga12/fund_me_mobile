import 'package:crowd_funding_app/Models/category.dart';
import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_page_two.dart';
import 'package:crowd_funding_app/Screens/loading_screen.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/category.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_label_text.dart';
import 'package:crowd_funding_app/widgets/form_progress.dart';
import 'package:crowd_funding_app/widgets/response_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
  String locationValue = 'choose your location';
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
                    'STEP 1 OF 3',
                    style: stepTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withAlpha(180)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Fundraiser details",
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
                            text: "How much would you like to raise ?"),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _fundraiseInfo['goalAmount'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "amount required!";
                            }
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 0.0),
                            hintText: "\$ Enter amount",
                            suffixIcon: buildCustomSuffixIcon("USD"),
                          ),
                        ),
                        FormLabelText(
                            text: 'what kind of fundraiser are you creating?'),
                        DropdownButtonFormField<String>(
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
                              return "select a category";
                            }
                          },
                          items: categories
                              .map(
                                (category) => DropdownMenuItem<String>(
                                  child: Text("${category.categoryName}"),
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
                                title: "continue",
                                isValidate: true,
                                onPressed: () {
                                  _formKey.currentState!.save();
                                  print("fundraise info$_fundraiseInfo");
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
                                title: "continue",
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
