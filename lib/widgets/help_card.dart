import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({Key? key, required this.content, required this.title})
      : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.help,
            size: 120.0,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 20.0,
          ),
          Html(
            data: '$title',
            style: {
              'body': Style(
                fontSize: FontSize.em(1.8),
                textAlign: TextAlign.center,
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
              ),
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Html(
            data: content.length > 150 ? content.substring(0, 150) + "..." : content,
            style: {
              'body': Style(
                textAlign: TextAlign.center,
               lineHeight: LineHeight.number(1.2),
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
              )
            },
          )
        ],
      ),
    );
  }
}
