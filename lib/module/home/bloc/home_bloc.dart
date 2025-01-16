import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/comment_model.dart';
import '../services/local_database_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TextEditingController _commentController = TextEditingController();
  final LocalDatabaseServices _localDb = LocalDatabaseServices.instance;

  HomeBloc()
      : super(HomeState(
          pageController: PageController(initialPage: 0),
          commentController: TextEditingController(),
        )) {
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
    emit(state.copyWith(isLoading: true));
    try {
      final comment = CommentModel(
        videoIndex: event.videoIndex,
        commentName: event.comment,
      );

      await _localDb.addComment(comment);
      await _loadComments(event.videoIndex, emit);
      
      state.commentController?.clear();
      emit(state.copyWith(
        commentName: '',
        isLoading: false,
      ));
    } catch (e) {
      print('Error adding comment: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearComment(ClearCommentEvent event, Emitter<HomeState> emit) {
    state.commentController?.clear();
    emit(state.copyWith(commentName: ''));
  }

  @override
  Future<void> close() {
    state.commentController?.dispose();
    state.pageController.dispose();
    return super.close();
  }
}
