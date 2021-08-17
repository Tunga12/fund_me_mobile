import 'package:crowd_funding_app/Models/fundraise.dart';
import 'package:crowd_funding_app/widgets/preview_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class SharePage extends StatelessWidget {
  SharePage({Key? key, required this.fundraise}) : super(key: key);
  final String fundraise;

  final String _link =
      "https://shrouded-bastion-52038.herokuapp.com/fundraiser/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Share"),
            SizedBox(
              height: 10.0,
            ),
            Text("Help Dave continued his journey")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                      "Share as much as possible",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Fundraise shared on social networks raise up to 10x more.',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.link,
                  // color: Colors.lin,
                ),
                title: Text(
                  "Fundraise link",
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 50.0,
                    child: TextFormField(
                      initialValue: _link,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        suffix: TextButton(
                          onPressed: () {},
                          child: Text("copy Link"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                child: PreviewTextButton(
                  title: "Share",
                  backgroundColor: Theme.of(context).buttonColor.withAlpha(100),
                  onPressed: () {
                    Share.share(_link + fundraise);
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
