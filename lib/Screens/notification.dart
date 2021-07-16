import 'package:crowd_funding_app/widgets/empty_body.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return NotficationItem(size: size);
      },
    );
  }
}

class NotficationItem extends StatelessWidget {
  const NotficationItem({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      decoration:
          BoxDecoration(color: Colors.cyan.withOpacity(0.15), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            offset: Offset(0, 3))
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/favicon.png',
            height: size.height * 0.05,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fasikaw, your GoFundMe is ready! sharing with friends and family is the most important step to get your first donations.",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Share now",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            "JUST NOW",
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
