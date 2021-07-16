import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("New Update"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          child: SizedBox(
            height: size.height,
            child: TextFormField(
              maxLines: size.height.toInt(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText:
                    "Share new developments or progress updares about your GoFundMe...",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
