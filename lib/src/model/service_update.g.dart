// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceUpdate _$ServiceUpdateFromJson(Map<String, dynamic> json) =>
    ServiceUpdate()
      ..serviceUpdateId = json['serviceUpdateId'] as String?
      ..description = json['description'] as String?
      ..updateDate = json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String)
      ..updateAuthor = json['updateAuthor'] == null
          ? null
          : User.fromJson(json['updateAuthor'] as Map<String, dynamic>);

Map<String, dynamic> _$ServiceUpdateToJson(ServiceUpdate instance) =>
    <String, dynamic>{
      'serviceUpdateId': instance.serviceUpdateId,
      'description': instance.description,
      'updateDate': instance.updateDate?.toIso8601String(),
      'updateAuthor': instance.updateAuthor?.toJson(),
    };
