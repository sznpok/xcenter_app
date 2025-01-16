import 'package:hive/hive.dart';

import '../model/comment_model.dart';

class LocalDatabaseServices {
  static final LocalDatabaseServices instance = LocalDatabaseServices._init();

  LocalDatabaseServices._init();

  static const String commentBoxName = 'comments';

  // Initialize Hive and open box for comments
  Future<Box<CommentModel>> _openCommentBox() async {
    if (!Hive.isBoxOpen(commentBoxName)) {
      return await Hive.openBox<CommentModel>(commentBoxName);
    }
    return Hive.box<CommentModel>(commentBoxName);
  }

  // Add a new comment for specific video
  Future<void> addComment(CommentModel comment) async {
    try {
      final box = await _openCommentBox();
      await box.add(comment);
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  // Get comments for specific video
  Future<List<CommentModel>> getCommentsForVideo(int videoIndex) async {
    try {
      final box = await _openCommentBox();
      return box.values
          .where((comment) => comment.videoIndex == videoIndex)
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }
}
