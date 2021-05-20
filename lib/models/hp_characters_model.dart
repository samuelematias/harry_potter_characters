import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hp_characters_model.g.dart';

@JsonSerializable()
class HpCharactersModel extends Equatable {
  const HpCharactersModel({this.name, this.image, this.house});

  factory HpCharactersModel.fromJson(Map<String, Object> json) =>
      _$HpCharactersModelFromJson(json);

  Map<String, dynamic> toJson() => _$HpCharactersModelToJson(this);

  final String name;
  final String image;
  final String house;

  @override
  List<Object> get props => [name, image, house];
}
