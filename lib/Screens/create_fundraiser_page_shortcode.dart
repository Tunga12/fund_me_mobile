import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Screens/create_fundraiser_page_one.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:crowd_funding_app/services/provider/paymentInfo.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/child_unorderd_list.dart';
import 'package:crowd_funding_app/widgets/continue_button.dart';
import 'package:crowd_funding_app/widgets/form_label_text.dart';
import 'package:crowd_funding_app/widgets/form_progress.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:crowd_funding_app/widgets/unorderd_list.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFundraiserPageShortcode extends StatefulWidget {
  CreateFundraiserPageShortcode() : super();

  @override
  _CreateFundraiserPageShortcodeState createState() =>
      _CreateFundraiserPageShortcodeState();
}

class _CreateFundraiserPageShortcodeState
    extends State<CreateFundraiserPageShortcode> {
  final _formKey = GlobalKey<FormState>();
  bool btnEnabled = false;
  Map<String, dynamic> _fundraiseInfo = {};

  bool _isChecking = false;
  dynamic _validationMsg;
  final _shortcodeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
                FormProgress(
                  size: size,
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.step_1_of_4_label_text.tr(),
                    style: stepTextStyle.copyWith(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withAlpha(180)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Shortcode",
                    style: bodyHeaderTextStyle.copyWith(
                      color:
                          Theme.of(context).secondaryHeaderColor.withAlpha(250),
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
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
                                  text:
                                      "Enter the shortcode you received from telebirr"),
                              TextFormField(
                                key: Key("shortcode_field"),
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  _fundraiseInfo['paymentInfo'] = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "shortcode is required";
                                  }
                                },
                                textAlignVertical: TextAlignVertical.center,
                              ),
                              SizedBox(height: 70.0),
                              btnEnabled
                                  ? ContinueButton(
                                      key: Key("continue_create_button"),
                                      title:
                                          LocaleKeys.continue_button_text.tr(),
                                      isValidate: true,
                                      onPressed: () async {
                                        _formKey.currentState!.save();

                                        if (_formKey.currentState!.validate()) {
                                          loadingProgress(context);
                                          var shortcode =
                                              _fundraiseInfo['paymentInfo'];
                                          await context
                                              .read<PaymentInfoProvider>()
                                              .searchShortcode(shortcode);

                                          Response response = context
                                              .read<PaymentInfoProvider>()
                                              .response;

                                          if (response.status ==
                                                  ResponseStatus.SUCCESS &&
                                              response.data != null) {
                                            _fundraiseInfo['paymentInfo'] =
                                                response.data;
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateFundraiserPageOne(
                                                  fundraiseInfo: _fundraiseInfo,
                                                ),
                                              ),
                                            );
                                          } else {
                                            Navigator.of(context).pop();
                                            authShowDialog(context,
                                                Text('Invalid Shortcode'),
                                                error: true, close: true);
                                          }
                                        }
                                      },
                                    )
                                  : ContinueButton(
                                      title:
                                          LocaleKeys.continue_button_text.tr(),
                                      isValidate: false,
                                      onPressed: () {},
                                    ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "If you don't have a shortcode yet, Email us the following documents at",
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14)),
                                      TextSpan(
                                        text: " legasfund@gmail.com ",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      TextSpan(
                                          text:
                                              "and we will send you the shortcode from telebirr within a maximum of 5 working days:",
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14))
                                    ])),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    ChildUnorderedList(
                                        text:
                                            "If you are a business, charity or religious organization",
                                        color: Colors.grey[700]),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UnorderedList(
                                              text: "Business License",
                                              color: Colors.grey[700]),
                                          UnorderedList(
                                              text: "Business Registration",
                                              color: Colors.grey[700]),
                                          UnorderedList(
                                              text: "Business TIN",
                                              color: Colors.grey[700]),
                                          UnorderedList(
                                              text:
                                                  "A letter specifying the reason for fundraising with the company stamp",
                                              color: Colors.grey[700]),
                                        ],
                                      ),
                                    ),
                                    ChildUnorderedList(
                                        text: "If you are an individual",
                                        color: Colors.grey[700]),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UnorderedList(
                                              text: "Renewed ID or passport",
                                              color: Colors.grey[700]),
                                          UnorderedList(
                                              text:
                                                  "A legal document stating your condition: for example medical record from a hospital",
                                              color: Colors.grey[700]),
                                          UnorderedList(
                                              text:
                                                  "A letter specifying the reason for fundraising with your signature",
                                              color: Colors.grey[700]),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
}
