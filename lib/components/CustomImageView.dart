import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageView extends StatefulWidget {
  final String imageUrl;

  const CustomImageView({Key key, this.imageUrl}) : super(key: key);

  @override
  _CustomImageViewState createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) =>  Center(
          child: CircularProgressIndicator()
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageUrl: this.widget.imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
