import 'package:flutter/material.dart';

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
            labelText: "Comment(Optional)",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      ),
    );
  }
}
