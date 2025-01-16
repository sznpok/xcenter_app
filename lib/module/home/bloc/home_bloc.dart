import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/comment_model.dart';
import '../services/local_database_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalDatabaseServices _localDb = LocalDatabaseServices();

  HomeBloc()
      : super(HomeState(pageController: PageController(initialPage: 0))) {
    on<OnPageChangedEvent>(_onPageChanged);
    on<ChangeCommentNamedEvent>(_onChangeCommentName);
    on<LoadCommentsEvent>(_onLoadComments);
    on<AddCommentEvent>(_onAddComment);
    on<ClearCommentEvent>(_onClearComment);
  }

  void _onPageChanged(OnPageChangedEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentIndex: event.index, isLoading: true));
    await _loadComments(event.index, emit);
    emit(state.copyWith(isLoading: false));
  }

  void _onChangeCommentName(
      ChangeCommentNamedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(commentName: event.commentName));
  }

  Future<void> _onLoadComments(
      LoadCommentsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _loadComments(event.videoIndex, emit);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _loadComments(int videoIndex, Emitter<HomeState> emit) async {
    try {
      final comments = await _localDb.getCommentsForVideo(videoIndex);
      emit(state.copyWith(comments: comments));
    } catch (e) {
      print('Error loading comments: $e');
    }
  }

  Future<void> _onAddComment(
      AddCommentEvent event, Emitter<HomeState> emit) async {
    if (state.commentName?.isNotEmpty ?? false) {
      emit(state.copyWith(isLoading: true));
      try {
        await _localDb.addComment(
          CommentModel(
            commentName: state.commentName,
            videoIndex: event.videoIndex,
          ),
        );
        await _loadComments(event.videoIndex, emit);
        emit(state.copyWith(commentName: ''));
      } catch (e) {
        print('Error adding comment: $e');
      }
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearComment(ClearCommentEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(commentName: ''));
  }

  @override
  Future<void> close() {
    state.pageController.dispose();
    return super.close();
  }
}
