import 'package:flutter/material.dart';
import 'package:flutter_app/classes/NewsItem.dart';
import 'package:flutter_app/components/CustomImageView.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Utils.dart';

class NewsDetails extends StatefulWidget {
  final NewsItem item;

  // In the constructor, require a Todo.
  NewsDetails({Key key, @required this.item}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                title: Text("Details",
                style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),),
                backgroundColor: Colors.grey.withOpacity(0.15),
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomImageView(
                    imageUrl: widget.item.urlToImage,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Wrap(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Text(
                          widget.item.title,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                                fontSize: 22.0
                            )
                          ),
                        ),
                      ),
                    ]),
                    Wrap(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                            child: Text(
                                Utils.getNewsFormattedDate(widget.item.publishedAt),
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14.0,
                                    color: Colors.black.withOpacity(0.8))))),
                      ],
                    ),
                    Wrap(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                            child: Text(
                              widget.item.content +
                                  " " +
                                  widget.item.content +
                                  " " +
                                  widget.item.content +
                                  " " +
                                  widget.item.content +
                                  " " +
                                  widget.item.content +
                                  " " +
                                  " " +
                                  widget.item.content,
                              style: GoogleFonts.roboto(
                                textStyle:TextStyle(
                                decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0)),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
