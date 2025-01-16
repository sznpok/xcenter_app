import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_video/module/auth/repo/auth_repo.dart';
import 'package:tiktok_video/module/home/bloc/home_bloc.dart';
import 'package:tiktok_video/module/home/model/comment_model.dart';
import 'package:tiktok_video/module/home/services/local_database_services.dart';
import 'package:tiktok_video/module/home/widgets/custom_bottom_sheet.dart';
import 'package:tiktok_video/widgets/custom_text_form.dart';

import '../../../constants/app_colors.dart';
import '../widgets/custom_video_player.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> videos = [
      "https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4",
      "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "https://www.w3schools.com/html/movie.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
      "https://media.w3.org/2010/05/sintel/trailer_hd.mp4",
      "https://vjs.zencdn.net/v/oceans.mp4",
      "https://www.w3schools.com/html/mov_bbb.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
    ];
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text("Videos"),
          actions: [
            IconButton(
              onPressed: () {
                AuthRepo().signOut();
              },
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: state.pageController,
              itemCount: videos.length,
              onPageChanged: (index) {
                context.read<HomeBloc>().add(OnPageChangedEvent(index));
              },
              itemBuilder: (context, index) {
                String video = videos[index];
                print("VIdeo $video");
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomVideoPlayer(
                      videoUrl: videos[index],
                      isCurrentPage: state.currentIndex == index,
                    ),
                    Positioned(
                      bottom: 160.sp,
                      right: 10.sp,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100.sp,
                      right: 10.sp,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: IconButton(
                          onPressed: () async {
                            final localDb = LocalDatabaseServices();
                            final comments =
                                await localDb.getCommentsForVideo(index);

                            showCustomBottomSheet(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Comments'),
                                  10.verticalSpace,
                                  Expanded(
                                    child: Column(
                                      children: [
                                        // Comment input field
                                        /*Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Add a comment...',
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.send),
                                                onPressed: () async {
                                                  // Get text from controller
                                                  final commentText = _commentController.text;
                                                  if (commentText.isNotEmpty) {
                                                    await localDb.addComment(
                                                      CommentModel(
                                                        id: DateTime.now().toString(),
                                                        commentName: commentText,
                                                        videoIndex: index,
                                                      ),
                                                    );
                                                    final newComments =
                                                        await localDb.getCommentsForVideo(index);
                                                    setState(() {
                                                      comments = newComments;
                                                    });
                                                    _commentController.clear();
                                                  }
                                                },
                                              ),
                                            ),
                                            controller: _commentController,
                                          ),
                                        ),*/

                                        CustomTextFormField(
                                          name: "comment",
                                          initialValue: state.commentName,
                                          onChanged: (value) {
                                            if (value != null) {
                                              context.read<HomeBloc>().add(
                                                  ChangeCommentNamedEvent(
                                                      commentName: value));
                                            }
                                          },
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              localDb.addComment(
                                                CommentModel(
                                                  id: "",
                                                  commentName:
                                                      state.commentName,
                                                  videoIndex: index,
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.send),
                                          ),
                                        ),
                                        // Comments list
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: comments.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(comments[index]
                                                        .commentName ??
                                                    ''),
                                                subtitle: Text(
                                                    'Comment #${index + 1}'),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.comment,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
