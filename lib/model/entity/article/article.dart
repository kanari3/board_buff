// ignore_for_file: invalid_annotation_target

import 'package:board_buff/model/entity/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Article({
    int? id,
    String? postType,
    String? title,
    String? slug,
    bool? published,
    int? commentsCount,
    int? likedCount,
    int? bodyLettersCount,
    int? readingTime,
    String? articleType,
    String? emoji,
    bool? isSuspendingPrivate,
    String? publishedAt,
    String? bodyUpdatedAt,
    String? sourceRepoUpdatedAt,
    User? user,
    bool? publication,
  }) = _Article;
  Article._();

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}
