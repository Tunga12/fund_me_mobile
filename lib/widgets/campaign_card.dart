import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  String image;

  CampaignCard({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/$image'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.ios_share),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              child: Text(
                "Wichita, KS",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "Support For The Russel Family",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "\$93,811 raised of \$75,000",
                style: TextStyle(fontSize: 16.0),
              )),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "Last donation JUST NOW ago",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).secondaryHeaderColor),
              )),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: LinearProgressIndicator(
              value: 0.9,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
