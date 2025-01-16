part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitializeVideoEvent extends HomeEvent {
  final String videoUrl;

  InitializeVideoEvent(this.videoUrl);
}

class PlayVideoEvent extends HomeEvent {}

class PauseVideoEvent extends HomeEvent {}

class SeekToStartVideoEvent extends HomeEvent {}

class OnPageChangedEvent extends HomeEvent {
  final int index;

  OnPageChangedEvent(this.index);
}

class ChangeCommentNamedEvent extends HomeEvent {
  final String commentName;

  ChangeCommentNamedEvent({required this.commentName});
}
