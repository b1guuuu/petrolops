// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['userId'] as String?,
      json['name'] as String?,
      $enumDecodeNullable(_$RoleEnumMap, json['role']),
      json['password'] as String?,
      json['passwordSalt'] as String?,
      (json['registration'] as num?)?.toInt(),
      json['area'] == null
          ? null
          : Area.fromJson(json['area'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'role': _$RoleEnumMap[instance.role],
      'password': instance.password,
      'passwordSalt': instance.passwordSalt,
      'registration': instance.registration,
      'area': instance.area?.toJson(),
    };

const _$RoleEnumMap = {
  Role.worker: 'worker',
  Role.leader: 'leader',
  Role.supervisor: 'supervisor',
};
