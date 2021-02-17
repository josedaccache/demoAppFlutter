part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class Loading extends NewsState {}

class Success extends NewsState {
  final NewsResponse response;
  Success({@required this.response}) : assert(response != null);
}

class Fail extends NewsState {
  final String error;
  Fail({@required this.error}) : assert(error != null);
}