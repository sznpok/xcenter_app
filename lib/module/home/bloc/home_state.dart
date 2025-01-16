part of 'home_bloc.dart';

class HomeState extends Equatable {
  final VideoPlayerController? videoPlayerController;
  final bool isPlaying;
  final bool isInitialized;
  final int currentIndex;
  final PageController? pageController;
  final String commentName;

  const HomeState({
    this.videoPlayerController,
    this.isPlaying = false,
    this.isInitialized = false,
    this.currentIndex = 0,
    this.pageController,
    this.commentName = '',
  });

  HomeState copyWith({
    VideoPlayerController? videoPlayerController,
    bool? isPlaying,
    bool? isInitialized,
    int? currentIndex,
    PageController? pageController,
    String? commentName,
  }) {
    return HomeState(
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      isPlaying: isPlaying ?? this.isPlaying,
      isInitialized: isInitialized ?? this.isInitialized,
      currentIndex: currentIndex ?? this.currentIndex,
      pageController: pageController ?? this.pageController,
      commentName: commentName ?? this.commentName,
    );
  }

  @override
  List<Object?> get props => [
        videoPlayerController,
        isPlaying,
        isInitialized,
        currentIndex,
        pageController,
        commentName,
      ];
}
