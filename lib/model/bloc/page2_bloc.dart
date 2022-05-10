import 'package:bloc_provider/bloc_provider.dart';
import 'package:board_buff/model/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../network/api_client.dart';

class Page2Bloc implements Bloc {
  final _zipRepository = ZipRepository(client: ApiClient());

  // 住所
  final _address = BehaviorSubject<String>.seeded('');
  Stream<String> get addressStream => _address.stream;

  // 入力
  final _input = BehaviorSubject<String>.seeded('');
  Sink<String> get addressInputAction => _input.sink;

  Future<void> _getAddressFromZip(String zip) async {
    final result = await _zipRepository.getAddressFromZipCode(zip);
    final displayString =
        '${result.address1}${result.address2}${result.address3}';
    _address.add(displayString);
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
