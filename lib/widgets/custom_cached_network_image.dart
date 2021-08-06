
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      errorWidget: (context, url, error) => Center(
          child: Icon(
        Icons.image,
        size: 50.0,
      )),
      progressIndicatorBuilder:
          (context, url, downloadProgress) => Center(
        child: SpinKitCircle(
          color: Theme.of(context).accentColor,
          duration: Duration(
              seconds: downloadProgress.progress == null
                  ? 2
                  : downloadProgress.progress!.toInt()),
        ),
      ),
      // CircularProgressIndicator(
      //     value: downloadProgress.progress),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
