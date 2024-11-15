import 'package:petrolops/src/model/area.dart';
import 'package:petrolops/src/enum/role.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String? userId;
  String? name;
  Role? role;
  String? password;
  String? passwordSalt;
  int? registration;
  Area? area;

  User(this.userId, this.name, this.role, this.password, this.passwordSalt,
      this.registration, this.area);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int get hashCode => userId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is User ? other.userId == userId : false;
}
