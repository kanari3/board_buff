import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Page1Bloc extends Bloc {

  final count = BehaviorSubject<int>.seeded(0);

  Stream<int> get countStream => count.stream;

  @override
  void dispose() {

  }

}