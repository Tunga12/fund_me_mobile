import 'package:crowd_funding_app/Models/update.dart';
import 'package:crowd_funding_app/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class UpdateBody extends StatelessWidget {
  final Update update;
  UpdateBody({required this.update});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Html(
            data: update.content,
            style: {
              "body": Style(
                  fontSize: FontSize.larger,
                  fontWeight: FontWeight.w400,
                  color:
                      Theme.of(context).secondaryHeaderColor.withOpacity(0.6))
            },
          ),
          if (update.image != null)
            Container(
              width: size.width,
              height: size.height * 0.35,
              child: CachedImage(image: update.image!),
            )
        ],
      ),
    );
  }
}
