import 'package:crowd_funding_app/Screens/create_fundraiser_page_three.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_label_text.dart';
import 'package:crowd_funding_app/widgets/form_progress.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
                      LocaleKeys.step_2_of_label_text.tr(),
                      style: stepTextStyle.copyWith(
                          color: Theme.of(context)
                              .secondaryHeaderColor
                              .withAlpha(180)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      LocaleKeys.describe_why_you_are_label_text.tr(),
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
                          FormLabelText(text: LocaleKeys.give_your_fundraiser_title_label_text.tr()),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.title_required_label_text.tr();
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                _fundraiseInfo['title'] = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: LocaleKeys.help_gabriel_attend_label_text.tr()),
                          ),
                          FormLabelText(
                              text: LocaleKeys.desctibe_your_need_label_text.tr()),
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
                                return LocaleKeys.description_required_label_text.tr();
                              } else if (value.length < 30) {
                                return LocaleKeys.desctipion_must_bea_atleast_30_label_text.tr();
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
                                  title: LocaleKeys.continue_button_text.tr(),
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
      ),
    );
  }
}
