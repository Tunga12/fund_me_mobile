import 'package:flutter/material.dart';

class FundraiserCard extends StatelessWidget {
  const FundraiserCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.6,
      width: size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(
              40.0,
            ),
            child: Column(
              children: [
                Text(
                  "Help your local community. Explore the fundraisers around you.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Use current location",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Text("or enter a location",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/car.jpg'),
                      fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}
