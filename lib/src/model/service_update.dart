import 'package:petrolops/src/model/user.dart';

import 'package:json_annotation/json_annotation.dart';

part 'service_update.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceUpdate {
  String? serviceUpdateId;
  String? description;
  DateTime? updateDate;
  User? updateAuthor;

  ServiceUpdate() : super();
  factory ServiceUpdate.fromJson(Map<String, dynamic> json) =>
      _$ServiceUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceUpdateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int get hashCode => serviceUpdateId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ServiceUpdate ? other.serviceUpdateId == serviceUpdateId : false;
}
