import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HelpDetail extends StatelessWidget {
  const HelpDetail({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);
  final String title;
  final String body;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Html(
          data: title,
          style: {
            'body': Style(
              fontSize: FontSize.em(1.2),
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
            ),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  "assets/images/logo_image.PNG",
                ),
                width: size.width * 0.4,
                fit: BoxFit.cover,
              ),
              Divider(thickness: 1.5,),
              SizedBox(
                height: 20.0,
              ),
              Html(
                data: '$title',
                style: {
                  'body': Style(
                    fontSize: FontSize.em(1.8),
                    textAlign: TextAlign.center,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
                  ),
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Html(
                data: body,
                style: {
                  'body': Style(
                    lineHeight: LineHeight.number(1.2),
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
                  )
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
