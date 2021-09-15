import 'package:crowd_funding_app/Screens/update_camera_page.dart';
import 'package:crowd_funding_app/Screens/update_text_page.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdatePage extends StatefulWidget {
  final String fundraiseId;
  UpdatePage(this.fundraiseId);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String content = "";
  int _currentIndex = 0;

  @override
  // GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  Widget build(BuildContext context) {
    List<Widget> _body = [
      UpdateCameraPage(
        fundraiseId: widget.fundraiseId,
      ),
      UpdateTextView(fundraiseId: widget.fundraiseId),
    ];
    return Scaffold(
      body: _body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: LocaleKeys.photo_label_text.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: LocaleKeys.test_label_text.tr(),
          )
        ],
      ),
    );
  }
}
