part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final PageController pageController;
  final int currentIndex;
  final String? commentName;
  final TextEditingController? commentController;
  final List<CommentModel> comments;
  final bool isLoading;

  const HomeState({
    required this.pageController,
    this.currentIndex = 0,
    this.commentName,
    this.comments = const [],
    this.isLoading = false,
    this.commentController,
  });

  HomeState copyWith({
    PageController? pageController,
    int? currentIndex,
    String? commentName,
    List<CommentModel>? comments,
    bool? isLoading,
    TextEditingController? commentController,
  }) {
    return HomeState(
      pageController: pageController ?? this.pageController,
      currentIndex: currentIndex ?? this.currentIndex,
      commentName: commentName ?? this.commentName,
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      commentController: commentController ?? this.commentController,
    );
  }

  @override
  List<Object?> get props => [
        pageController,
        currentIndex,
        commentName,
        comments,
        isLoading,
        commentController,
      ];
}
