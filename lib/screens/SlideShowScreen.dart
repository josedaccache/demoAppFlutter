import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/slideshow/slide_show_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../apiresponses/ImageResponse.dart';
import '../classes/ImageItem.dart';

class SlideShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlideShowState();
  }
}

class _SlideShowState extends State<SlideShow> {
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SlideShowBloc(),
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    return BlocBuilder<SlideShowBloc, SlideShowState>(
      builder: (context, state) {
        if (state is SlideShowInitial) {
          BlocProvider.of<SlideShowBloc>(context)
            ..add(StartLoading())
            ..add(ImageLoad());
        }
        if (state is Loading) {
          return loadingView();
        }
        return populate();
      },
    );
  }

  Widget loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget populate() {
    return BlocBuilder<SlideShowBloc, SlideShowState>(
      buildWhen: (previous, current) => current is Success,
      builder: (context, state) {
        if (state is Success) {
          ImageResponse data = state.response;
          if (data.imageData.length > 0) {
            return _buildCarousel(context, data);
          }
        }
        return Container();
      },
    );
  }

  Widget _buildCarousel(BuildContext context, ImageResponse imageResponse) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
}
