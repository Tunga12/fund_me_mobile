import 'package:crowd_funding_app/Screens/create_fundraiser_page_three.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_label_text.dart';
import 'package:crowd_funding_app/widgets/form_progress.dart';
import 'package:crowd_funding_app/widgets/rich_text_editor.dart';
import 'package:flutter/material.dart';

class CreateFundraiserPageTwo extends StatefulWidget {
  CreateFundraiserPageTwo({required this.fundraiseInfo});
  final Map<String, dynamic> fundraiseInfo;

  @override
  _CreateFundraiserPageTwoState createState() =>
      _CreateFundraiserPageTwoState();
}

class _CreateFundraiserPageTwoState extends State<CreateFundraiserPageTwo> {
  final _formKey = GlobalKey<FormState>();

  bool isEnabled = false;

  Map<String, dynamic> _fundraiseInfo = {};
  String _initialStory = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
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
                      'STEP 2 OF 3',
                      style: stepTextStyle.copyWith(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withAlpha(180)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Describe why you're fundraising",
                      style: bodyHeaderTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withAlpha(250),
                      ),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: () {
                        setState(() {
                          isEnabled = _formKey.currentState!.validate();
                        });
                      },
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelText(text: 'Give your fundraise a title.'),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'field required!';
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                _fundraiseInfo['title'] = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'e.g. Help Gabriel attend college'),
                          ),
                          FormLabelText(
                              text: 'Describe your need and situation'),
                          TextFormField(
                            initialValue: _initialStory,
                            // onTap: () async {
                            //   final value = await Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           RichTextEditor(data: _initialStory),
                            //     ),
                            //   );

                            //   print("Story value is $value");
                            //   setState(() {
                            //     _initialStory = value;
                            //   });
                            // },
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            maxLength: 255,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field required!";
                              } else if (value.length < 30) {
                                return "must be atleast 30 chars";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                _fundraiseInfo['story'] = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.5),
                                    width: 1.3),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          isEnabled
                              ? ContinueButton(
                                  title: "continue",
                                  isValidate: true,
                                  onPressed: () {
                                    _formKey.currentState!.save();
                                    final info = {
                                      'title': _fundraiseInfo['title'],
                                      'story': _fundraiseInfo['story'],
                                      'location':
                                          widget.fundraiseInfo['location'],
                                      'goalAmount':
                                          widget.fundraiseInfo['goalAmount'],
                                      'category':
                                          widget.fundraiseInfo['category']
                                    };
                                    print("info $info");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CreateFundraiserPageThree(
                                          fundraiseInfo: info,
                                        ),
                                      ),
                                    );
                                  })
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
      ),
    );
  }
}
