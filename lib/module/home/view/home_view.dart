import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_video/module/auth/repo/auth_repo.dart';
import 'package:tiktok_video/module/home/bloc/home_bloc.dart';
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
                          onPressed: () {
                            final homeBloc = context.read<HomeBloc>();
                            homeBloc.add(
                                LoadCommentsEvent(homeBloc.state.currentIndex));
                            showCustomBottomSheet(
                              child: BlocProvider.value(
                                value: homeBloc,
                                child: BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Comments',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        10.verticalSpace,
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.sp),
                                          child: Expanded(
                                            child: CustomTextFormField(
                                              name: "comment",
                                              hintText: "Add a comment",
                                              controller:
                                                  state.commentController,
                                              onChanged: (value) {
                                                if (value != null) {
                                                  context.read<HomeBloc>().add(
                                                        ChangeCommentNamedEvent(
                                                            commentName: value),
                                                      );
                                                }
                                              },
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  if (state.commentName
                                                          ?.isNotEmpty ??
                                                      false) {
                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          AddCommentEvent(
                                                            videoIndex: state
                                                                .currentIndex,
                                                            comment: state
                                                                .commentName!,
                                                          ),
                                                        );
                                                    context.read<HomeBloc>().add(
                                                        ClearCommentEvent());
                                                  }
                                                },
                                                icon: const Icon(Icons.send),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: state.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : state.comments.reversed
                                                      .toList()
                                                      .isEmpty
                                                  ? Center(
                                                      child: Text(
                                                        'No comments yet',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    )
                                                  : ListView.builder(
                                                      itemCount: state
                                                          .comments.reversed
                                                          .toList()
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final comment = state
                                                            .comments.reversed
                                                            .toList()[index];
                                                        return ListTile(
                                                          title: Text(comment
                                                                  .commentName ??
                                                              ''),
                                                        );
                                                      },
                                                    ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
