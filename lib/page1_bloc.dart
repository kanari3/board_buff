import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Page1Bloc extends Bloc {

  final _count = BehaviorSubject<int>.seeded(0);

  Stream<int> get countStream => _count.stream;

  int get countValue => _count.value;

  @override
  void dispose() {
    _count;
  }

}