part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {

  @override
  String toString() {
    return 'NewsInitial';
  }
}

class Success extends NewsState {
  final List<NewsItem> newsList;
  int max =3;
  int current = 0;
  bool hasReachedMax = false;

  Success({@required this.newsList, this.hasReachedMax, this.current, this.max}) : assert(newsList != null);

  Success copyWith({List<NewsItem> articles, bool hasReachedMax, int currentPage, int maxPage}) {
    return Success(
      current: currentPage ?? this.current,
      newsList: articles ?? this.newsList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      max: maxPage?? this.max,
    );
  }

  @override
  List<Object> get props => [newsList, hasReachedMax, current];

  @override
  String toString() {
    return 'Success';
  }
}

class Fail extends NewsState {
  final String error;
  Fail({@required this.error}) : assert(error != null);

  @override
  String toString() {
    return 'Fail';
  }
}