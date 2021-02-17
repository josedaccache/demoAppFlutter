part of 'slide_show_bloc.dart';

abstract class SlideShowState extends Equatable {
  const SlideShowState();

  @override
  List<Object> get props => [];
}

class SlideShowInitial extends SlideShowState {}

class Loading extends SlideShowState {}

class Success extends SlideShowState {
  final ImageResponse response;
  Success({@required this.response}) : assert(response != null);
}

class Fail extends SlideShowState {
  final String error;
  Fail({@required this.error}) : assert(error != null);
}
