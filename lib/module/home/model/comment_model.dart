import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 1)
class CommentModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? commentName;

  @HiveField(2)
  int? videoIndex;

  CommentModel({
    this.id,
    this.commentName,
    this.videoIndex,
  });

  CommentModel copyWith({
    String? id,
    String? commentName,
    int? videoIndex,
  }) {
    return CommentModel(
      id: id ?? this.id,
      commentName: commentName ?? this.commentName,
      videoIndex: videoIndex ?? this.videoIndex,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'] as String?,
        commentName: json['commentName'] as String?,
        videoIndex: json['videoIndex'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'commentName': commentName,
        'videoIndex': videoIndex,
      };

  @override
  String toString() {
    return 'CommentModel(id: $id, commentName: $commentName, videoIndex: $videoIndex)';
  }
}
