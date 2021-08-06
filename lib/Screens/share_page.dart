import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class SharePage extends StatelessWidget {
  SharePage({Key? key}) : super(key: key);

  final String _link = "https/go.fundme.com/sample";

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
                          )),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  // FlutterSocialContentShare.share(
                  //   type: ShareType.facebookWithoutImage,
                  //   url: _link,
                  //   quote: "captions",
                  // );
                  Share.share(_link);
                },
                leading: Icon(
                  FontAwesomeIcons.facebookSquare,
                  color: Colors.blue,
                ),
                title: Text("Facebook"),
              ),
              ListTile(
                onTap: () async {
                  Share.share(_link);
                },
                leading: Icon(
                  FontAwesomeIcons.instagramSquare,
                  color: Colors.pink.shade500,
                ),
                title: Text("Instagram"),
              ),
              ListTile(
                onTap: () {
                  Share.share(_link);
                },
                leading: Icon(
                  Icons.chat_outlined,
                  // color: Colors.blue,
                ),
                title: Text("Text"),
              ),
              ListTile(
                onTap: () {
                  Share.share(_link);
                },
                leading: Icon(
                  FontAwesomeIcons.envelope,
                  // color: Colors.blue,
                ),
                title: Text("Email"),
              ),
              ListTile(
                onTap: () {
                  Share.share(_link);
                },
                leading: Icon(
                  FontAwesomeIcons.whatsappSquare,
                  color: Colors.green,
                ),
                title: Text("Facebook"),
              ),
              ListTile(
                onTap: () {
                  Share.share(_link);
                },
                leading: Icon(
                  FontAwesomeIcons.twitterSquare,
                  color: Colors.blue,
                ),
                title: Text("Twitter"),
              ),
              ListTile(
                onTap: () {
                  Share.share(_link);
                },
                leading: Icon(
                  Icons.person_add_alt,
                  // color: Colors.blue,
                ),
                title: Text("Invite Contacts"),
              ),
              ListTile(
                onTap: () {
                  Share.share(_link);
                },
                leading: Icon(
                  Icons.more_horiz_outlined,
                  // color: Colors.blue,
                ),
                title: Text("More"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
