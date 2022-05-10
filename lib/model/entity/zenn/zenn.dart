// ignore_for_file: invalid_annotation_target

import 'package:board_buff/model/entity/article/article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'zenn.freezed.dart';
part 'zenn.g.dart';

@freezed
abstract class Zenn with _$Zenn {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Zenn({
    required List<Article> articles,
    int? nextPage,
  }) = _Zenn;
  Zenn._();

  factory Zenn.fromJson(Map<String, dynamic> json) => _$ZennFromJson(json);
}
