import 'package:petrolops/src/model/area.dart';
import 'package:petrolops/src/model/service_update.dart';
import 'package:petrolops/src/model/user.dart';
import 'package:petrolops/src/enum/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable(explicitToJson: true)
class Service {
  String? serviceId;
  String? title;
  String? description;
  Status? status;
  Area? area;
  List<User>? team;
  List<ServiceUpdate>? updates;
  User? supervisor;

  Service() : super();
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int get hashCode => serviceId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Service ? other.serviceId == serviceId : false;

  static List<User> buildTeamFromJson(dynamic json) {
    List<User> team = List.empty();
    for (dynamic userJson in json) {
      team.add(User.fromJson(userJson));
    }
    return team;
  }

  static List<ServiceUpdate> buildUpdatesFromJson(dynamic json) {
    List<ServiceUpdate> updates = List.empty();
    for (dynamic userJson in json) {
      updates.add(ServiceUpdate.fromJson(userJson));
    }
    return updates;
  }
}

@JsonSerializable(explicitToJson: true)
class ServiceConvertHelper {
  const ServiceConvertHelper(this.service);

  final Service service;

  factory ServiceConvertHelper.fromJson(Map<String, Object?> json) =>
      _$ServiceConvertHelperFromJson(json);

  Map<String, Object?> toJson() => _$ServiceConvertHelperToJson(this);
}
