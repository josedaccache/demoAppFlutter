import 'package:flutter/material.dart';
import 'package:flutter_app/apiresponses/NewsResponse.dart';
import 'package:flutter_app/classes/NewsItem.dart';
import 'package:flutter_app/screens/NewsDetailsScreen.dart';
import '../network/APIClient.dart';
import '../utils/Utils.dart';
import 'package:dio/dio.dart';

class News extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  FutureBuilder<NewsResponse> _buildBody(BuildContext context) {
    final client = APIClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<NewsResponse>(
      future: client.getNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final NewsResponse post = snapshot.data;
          return _buildList(post.itemData);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildList(List<NewsItem> allNews) {
    return ListView.builder(
      itemCount: allNews.length,
      itemBuilder: (context, index) {
        return _buildListItems(context, allNews[index]);
      },
    );
  }

  Widget _buildListItems(BuildContext context, NewsItem item) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewsDetails(item: item)));
        },
        child: Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration:  BoxDecoration(
                      color: Colors.transparent,
                      image:DecorationImage(
                        image: NetworkImage(item.urlToImage),
                        fit: BoxFit.cover),
                    ),
                  )
                  // Image.network(
                  //   item.urlToImage,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5.0),
                    Text(Utils.getNewsFormattedDate(item.publishedAt),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            fontSize: 12.0,
                            color: Colors.black.withOpacity(0.8))),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
