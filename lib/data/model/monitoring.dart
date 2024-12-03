import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'monitoring.g.dart';

@JsonSerializable()
@Entity()
class Monitoring {
  @JsonKey(includeFromJson: false)
  @Id(assignable: true)
  int id = 0;
  final String timestamp;
  final int value;
  @JsonKey(includeFromJson: false)
  final String? type;

  Monitoring({required this.timestamp, this.value = 0, this.type}) {
    id = '$timestamp$type'.hashCode; //generate unique id for the table item
  }

  factory Monitoring.fromJson(Map<String, dynamic> json) =>
      _$MonitoringFromJson(json);
  Map<String, dynamic> toJson() => _$MonitoringToJson(this);
}
