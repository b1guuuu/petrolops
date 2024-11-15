// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service()
  ..serviceId = json['serviceId'] as String?
  ..title = json['title'] as String?
  ..description = json['description'] as String?
  ..status = $enumDecodeNullable(_$StatusEnumMap, json['status'])
  ..area = json['area'] == null
      ? null
      : Area.fromJson(json['area'] as Map<String, dynamic>)
  ..team = (json['team'] as List<dynamic>?)
      ?.map((e) => User.fromJson(e as Map<String, dynamic>))
      .toList()
  ..updates = (json['updates'] as List<dynamic>?)
      ?.map((e) => ServiceUpdate.fromJson(e as Map<String, dynamic>))
      .toList()
  ..supervisor = json['supervisor'] == null
      ? null
      : User.fromJson(json['supervisor'] as Map<String, dynamic>);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'serviceId': instance.serviceId,
      'title': instance.title,
      'description': instance.description,
      'status': _$StatusEnumMap[instance.status],
      'area': instance.area?.toJson(),
      'team': instance.team?.map((e) => e.toJson()).toList(),
      'updates': instance.updates?.map((e) => e.toJson()).toList(),
      'supervisor': instance.supervisor?.toJson(),
    };

const _$StatusEnumMap = {
  Status.open: 'open',
  Status.inProgress: 'inProgress',
  Status.validation: 'validation',
  Status.finished: 'finished',
  Status.canceled: 'canceled',
};

ServiceConvertHelper _$ServiceConvertHelperFromJson(
        Map<String, dynamic> json) =>
    ServiceConvertHelper(
      Service.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceConvertHelperToJson(
        ServiceConvertHelper instance) =>
    <String, dynamic>{
      'service': instance.service.toJson(),
    };
