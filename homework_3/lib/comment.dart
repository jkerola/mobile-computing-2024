import 'package:hive_flutter/adapters.dart';

part "comment.g.dart";

@HiveType(typeId: 0)
class Comment extends HiveObject {
  @HiveField(0)
  String comment;
  @HiveField(1)
  String imageUrl;

  Comment({required this.comment, required this.imageUrl});
}
