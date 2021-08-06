import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/Screens/home_page.dart';
import 'package:crowd_funding_app/Screens/update_camera_page.dart';
import 'package:crowd_funding_app/Screens/update_text_page.dart';
import 'package:crowd_funding_app/config/utils/user_preference.dart';
import 'package:crowd_funding_app/services/provider/update.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  Widget build(BuildContext context) {
    List<Widget> _body = [
      UpdateCameraPage(
        fundraiseId: widget.fundraiseId,
      ),
      UpdateTextView(fundraiseId: widget.fundraiseId),
    ];
    final size = MediaQuery.of(context).size;

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
            label: "photo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: "text",
          )
        ],
      ),
    );
  }
}
