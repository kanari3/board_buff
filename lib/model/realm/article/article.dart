import 'package:realm/realm.dart';

part 'article.g.dart';

@RealmModel()
class _ArticleModel {
  late int? id;
  late String? title;
  late String? slug;
  late String? username;
}
