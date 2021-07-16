import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.56,
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      "New",
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Join the GoFundMe Community",
                    style: TextStyle(
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.9),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Connect with other organizers and learn about fundraising strategies in the GoFundMe Community",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.6)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/community.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: Text("Visit the Community",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
