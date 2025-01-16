import 'package:hive/hive.dart';
import '../model/comment_model.dart';

class LocalDatabaseServices {
  static const String commentBoxName = 'comments';
  
  // Initialize Hive and open box
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

  // Delete comments for specific video
  Future<void> deleteCommentsForVideo(int videoIndex) async {
    try {
      final box = await _openCommentBox();
      final keysToDelete = box.values
          .where((comment) => comment.videoIndex == videoIndex)
          .map((comment) => comment.key)
          .toList();
      
      for (var key in keysToDelete) {
        await box.delete(key);
      }
    } catch (e) {
      throw Exception('Failed to delete comments: $e');
    }
  }
}
