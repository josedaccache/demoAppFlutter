import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../classes/ImageItem.dart';
import '../apiresponses/ImageResponse.dart';
import '../network/APIClient.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SlideShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideShowState();
  }
}

class _SlideShowState extends State<SlideShow> {
  int _current = 0;
  ImageResponse imageResponse;
  final client = APIClient(Dio(BaseOptions(contentType: "application/json")));

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    ImageResponse response = await client.getImages();
     setState(() {
       imageResponse = response;
     });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCarousel(context);
  }

  Widget _buildCarousel(BuildContext context) {
    return imageResponse == null ?
    Center(
      child: CircularProgressIndicator(),
    ) :
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CarouselSlider(
        items: imageSliders(imageResponse.imageData),
        options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 16.0 / 9.0,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageResponse.imageData.map((url) {
          int index = imageResponse.imageData.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  List<Widget> imageSliders(List<ImageItem> imgList) {
    return imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item.source,
                          fit: BoxFit.fitWidth,
                          width: 1000.0,
                          height: 1000.0,
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }


  void _showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
