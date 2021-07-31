import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '';

class NotficationItem extends StatelessWidget {
  final String content;
  NotficationItem({required this.content});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                Html(
                  style: {
                    "body": Style(
                        fontSize: FontSize.larger,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.6))
                  },
                  data: content,
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
