import 'package:crowd_funding_app/widgets/help_card.dart';
import 'package:crowd_funding_app/widgets/unorderd_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.09,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  // spreadRadius: 5,
                  blurRadius: 0.3,
                  offset: Offset(0, 3),
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 30.0,
                ),
                SizedBox(
                  width: size.width * 0.2,
                ),
                Image.asset(
                  "assets/images/gofundme.png",
                  width: size.width * 0.35,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Text(
                  "How can we help?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      hintText: "Search the GoFundMe Help Center",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Click here ",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      TextSpan(
                        text: "if you're looking for a GoFundMe fundraiser.",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).secondaryHeaderColor),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Looking to connect?",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Visit the GoFundMe Community",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.5, color: Colors.grey),
                            children: [
                              TextSpan(
                                text:
                                    "We're better together. Our community connects you with other organizers to share knowledge, tips, and advice. Join the conversation in the ",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                  text: 'GoFundMe community.',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {})
                            ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            color: Colors.pink.shade50,
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: ListView.builder(
              primary: true,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return HelpCard();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Popular Articles",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 20.0,
                ),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                UnorderedList(text: "Changing Your Phone Number"),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  thickness: 1.5,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5.0,
                    offset: Offset(0, 3))
              ],
            ),
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                child: Text(
                  "Get Help",
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/gofundme.png",
                  height: size.height * 0.1,
                ),
                DropdownButton(
                  onChanged: (value) {},
                  value: "English(US)",
                  items: ['English(US)', 'Amharic', 'Oromigna', 'Tirgigna']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Text(
                  'FUNDRAISE FOR',
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
