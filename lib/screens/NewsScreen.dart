import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/news/news_bloc.dart';
import 'package:flutter_app/classes/NewsItem.dart';
import 'package:flutter_app/components/BottomLoader.dart';
import 'package:flutter_app/components/CustomImageView.dart';
import 'package:flutter_app/components/LoadingView.dart';
import 'package:flutter_app/screens/NewsDetailsScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/Utils.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 10.0;
  final loadingCount = 0;
  NewsBloc _newsBloc = NewsBloc();


  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_onScroll);
    return _getBloc();
  }

  _getBloc(){
    return BlocProvider(
      create: (context) => _newsBloc,
      child: _buildPage(),
    );
  }

  _buildPage() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial) {
          _newsBloc = BlocProvider.of<NewsBloc>(context);
          // _newsBloc.add(StartLoading());
          _newsBloc.add(NewsLoad());
          return LoadingView();
        }
        if (state is Success) {
          List<NewsItem> data = state.newsList;
          if (data.length > 0) {
            return _buildList(data, state.hasReachedMax);
          }
        }
        return Container();
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _newsBloc.add(NewsLoad());
    }
  }

  Widget _buildList(List<NewsItem> allNews, bool hasReachedMax) {
    return SafeArea(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return index >= allNews.length && !hasReachedMax
              ? BottomLoader()
              : _buildListItems(context, allNews[index]);
        },
        itemCount: hasReachedMax ? allNews.length : allNews.length + 1,
        controller: _scrollController,
      ),
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
                      // width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: CustomImageView(imageUrl: item.urlToImage),
                      ),
                      // color: Colors.grey.withOpacity(0.3),
                    )),
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
