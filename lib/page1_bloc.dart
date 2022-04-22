import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Page1Bloc extends Bloc {
  // カウント
  final _count = BehaviorSubject<int>.seeded(0);
  Stream<int> get countStream => _count.stream;
  // Sink<int> get countSink => _count.sink;
  // int get countValue => _count.value;

  // エラー通知
  final err = BehaviorSubject<String>.seeded('');

  void increment() {
    final temp = _count.value + 1;
    _count.add(temp);

    if (_count.value >= 10) {
      err.add('一桁を超えました');
    }
  }

  @override
  void dispose() {
    _count;
    err;
  }
}
