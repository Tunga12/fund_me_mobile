import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DonationCommentBox extends StatefulWidget {
  DonationCommentBox({Key? key, required this.commentCallback})
      : super(key: key);
  final Function(String value) commentCallback;

  @override
  _DonationCommentBoxState createState() => _DonationCommentBoxState();
}

class _DonationCommentBoxState extends State<DonationCommentBox> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          onChanged: (value) {
            widget.commentCallback(value);
          },
          maxLines: 5,
          decoration: InputDecoration(
            labelText: LocaleKeys.comment_optional_label_text.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      ),
    );
  }
}
