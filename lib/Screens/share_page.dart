import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/preview_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:easy_localization/easy_localization.dart';

class SharePage extends StatelessWidget {
  SharePage({Key? key, required this.fundraise}) : super(key: key);
  final Fundraise fundraise;

  final String _link = "https://www.legasfund.com/fundraiser/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.Help_listtile_text.tr()),
            SizedBox(
              width: 5.0,
            ),
            Text(
              fundraise.title!,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.share_as_much_as_possible_label_text.tr(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      LocaleKeys.fundraise_shared_on_social_label_text.tr(),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.fundraise_link_label_text.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.grey.shade800,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.link,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                            height: 50.0,
                            child: TextFormField(
                              initialValue: _link,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: PreviewTextButton(
                  title: LocaleKeys.share_lable_text.tr(),
                  backgroundColor: Theme.of(context).buttonColor.withAlpha(100),
                  onPressed: () {
                    Share.share(_link + fundraise.id!);
                  },
                  leadingChild: Container(
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Theme.of(context).secondaryHeaderColor),
                      child: Icon(
                        Icons.ios_share,
                        color: Theme.of(context).backgroundColor,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
