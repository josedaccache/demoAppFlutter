import 'package:flutter/material.dart';
import 'package:flutter_app/classes/NewsItem.dart';
import '../utils/Utils.dart';

class NewsDetails extends StatelessWidget {
  final NewsItem item;

  // In the constructor, require a Todo.
  NewsDetails({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.network(
      item.urlToImage,
      fit: BoxFit.cover,
    );

    return Scaffold(
      appBar: new AppBar(
        // We will dynamically display title of selected page
        title: new Text("Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Text(
                item.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              )),
          SizedBox(height: 5.0),
          Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: Text(Utils.getNewsFormattedDate(item.publishedAt),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontSize: 14.0,
                      color: Colors.black.withOpacity(0.8)))),
          SizedBox(height: 5.0),
          imageWidget,
          SizedBox(height: 5.0),
          Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: Text(
                item.content,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
              )),
        ],
      ),
    );
  }
}
