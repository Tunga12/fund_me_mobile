import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

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
                    child: TextField(
                      decoration: InputDecoration(
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
                leading: Icon(
                  FontAwesomeIcons.facebookSquare,
                  color: Colors.blue,
                ),
                title: Text("Facebook"),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.instagramSquare,
                  color: Colors.pink.shade500,
                ),
                title: Text("Instagram"),
              ),
              ListTile(
                leading: Icon(
                  Icons.chat_outlined,
                  // color: Colors.blue,
                ),
                title: Text("Text"),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.envelope,
                  // color: Colors.blue,
                ),
                title: Text("Email"),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.whatsappSquare,
                  color: Colors.green,
                ),
                title: Text("Facebook"),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.twitterSquare,
                  color: Colors.blue,
                ),
                title: Text("Twitter"),
              ),
              ListTile(
                leading: Icon(
                  Icons.person_add_alt,
                  // color: Colors.blue,
                ),
                title: Text("Invite Contacts"),
              ),
              ListTile(
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
