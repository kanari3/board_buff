import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
abstract class Address with _$Address {
  factory Address({
    @JsonKey(name: 'address1') required String address1,
    @JsonKey(name: 'address2') required String address2,
    @JsonKey(name: 'address3') required String address3,
  }) = _Address;
  Address._();

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}
