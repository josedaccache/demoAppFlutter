part of 'slide_show_bloc.dart';

abstract class SlideShowEvent extends Equatable {
  const SlideShowEvent();

  @override
  List<Object> get props => [];
}

class StartLoading extends SlideShowEvent {}

class ImageLoad extends SlideShowEvent {}
