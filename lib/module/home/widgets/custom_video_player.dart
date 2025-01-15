import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../bloc/home_bloc.dart';

class CustomVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final bool isCurrentPage;

  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.isCurrentPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(InitializeVideoEvent(videoUrl)),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (!state.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          final bloc = context.read<HomeBloc>();
          if (isCurrentPage && !state.isPlaying) {
            bloc.add(PlayVideoEvent());
          } else if (!isCurrentPage && state.isPlaying) {
            bloc.add(PauseVideoEvent());
          }
          return GestureDetector(
            onTap: () {
              if (state.isPlaying) {
                bloc.add(PauseVideoEvent());
              } else {
                bloc.add(PlayVideoEvent());
              }
            },
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: state.videoPlayerController!.value.size.width,
                  height: state.videoPlayerController!.value.size.height,
                  child: VideoPlayer(state.videoPlayerController!),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
