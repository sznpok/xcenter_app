import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<InitializeVideoEvent>(_onInitializeVideo);
    on<PlayVideoEvent>(_onPlayVideo);
    on<PauseVideoEvent>(_onPauseVideo);
    on<SeekToStartVideoEvent>(_onSeekToStartVideo);
    on<OnPageChangedEvent>(_onOnPageChanged);
  }

  void _onInitializeVideo(
      InitializeVideoEvent event, Emitter<HomeState> emit) async {
    final videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(event.videoUrl));
    await videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        add(SeekToStartVideoEvent());
      }
    });
    emit(state.copyWith(
      videoPlayerController: videoPlayerController,
      isInitialized: true,
    ));
  }

  void _onOnPageChanged(OnPageChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  void _onPlayVideo(PlayVideoEvent event, Emitter<HomeState> emit) {
    state.videoPlayerController?.play();
    emit(state.copyWith(isPlaying: true));
  }

  void _onPauseVideo(PauseVideoEvent event, Emitter<HomeState> emit) {
    state.videoPlayerController?.pause();
    emit(state.copyWith(isPlaying: false));
  }

  void _onSeekToStartVideo(
      SeekToStartVideoEvent event, Emitter<HomeState> emit) {
    state.videoPlayerController?.seekTo(Duration.zero);
    state.videoPlayerController?.play();
    emit(state.copyWith(isPlaying: true));
  }

  @override
  Future<void> close() {
    state.videoPlayerController?.dispose();
    return super.close();
  }
}
