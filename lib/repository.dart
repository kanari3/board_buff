import 'dart:async';
import 'dart:convert';

import 'package:board_buff/address.dart';
import 'package:board_buff/api_client.dart';

abstract class ZipRepositoryInterface {
  Future<Address> getAddressFromZipCode(String zipCode);
}

class ZipRepository implements ZipRepositoryInterface {
  final Client _client;

  ZipRepository({
    required Client client,
  }) : _client = client;

  @override
  Future<Address> getAddressFromZipCode(String zipCode) async {
    try {
      final response = await _client.getAddressFromZip(zipCode);
      final jsonResponse = json.decode(response.body);
      final jsonData = jsonResponse['results'][0] as Map<String, dynamic>;
      return Address.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }
}
