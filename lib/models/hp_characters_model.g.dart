// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hp_characters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HpCharactersModel _$HpCharactersModelFromJson(Map<String, dynamic> json) {
  return HpCharactersModel(
    name: json['name'] as String,
    image: json['image'] as String,
    house: json['house'] as String,
  );
}

Map<String, dynamic> _$HpCharactersModelToJson(HpCharactersModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'house': instance.house,
    };
