import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class Page2Bloc implements Bloc {

  // 住所
  final _address = BehaviorSubject<String>.seeded('');
  Stream<String> get addressStream => _address.stream;

  // 入力
  final _input = BehaviorSubject<String>.seeded('');
  Sink<String> get addressInputAction => _input.sink;

  Future<void> _getAddressFromZip(String zip) async {
    // TODO: 郵便番号から住所を取得して_addressに住所を入れる
    _address.add("入力された郵便番号: ${zip}");
  }

  Future<void> search() async {
    await _getAddressFromZip(_input.value);
  }

  @override
  void dispose() {
    _address;
    _input;
  }
}
