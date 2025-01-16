part of 'home_bloc.dart';

abstract class HomeEvent {}

class OnPageChangedEvent extends HomeEvent {
  final int index;
  OnPageChangedEvent(this.index);
}

class ChangeCommentNamedEvent extends HomeEvent {
  final String commentName;
  ChangeCommentNamedEvent({required this.commentName});
}

class LoadCommentsEvent extends HomeEvent {
  final int videoIndex;
  LoadCommentsEvent(this.videoIndex);
}

class AddCommentEvent extends HomeEvent {
  final int videoIndex;
  final String comment;
  AddCommentEvent({required this.videoIndex, required this.comment});
}

class ClearCommentEvent extends HomeEvent {}

