import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Page1Bloc extends Bloc {

  // カウント
  final _count = BehaviorSubject<int>.seeded(0);
  Stream<int> get countStream => _count.stream;
  // Sink<int> get countSink => _count.sink;
  // int get countValue => _count.value;

  void increment() {
    final temp = _count.value + 1;
    _count.add(temp);
  }

  @override
  void dispose() {
    _count;
  }

}