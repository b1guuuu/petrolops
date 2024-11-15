import 'package:json_annotation/json_annotation.dart';

part 'area.g.dart';

@JsonSerializable(explicitToJson: true)
class Area {
  String? areaId;
  String? name;

  Area(this.areaId, this.name);

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int get hashCode => areaId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Area ? other.areaId == areaId : false;
}
