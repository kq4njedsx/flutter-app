import 'package:json_annotation/json_annotation.dart';

part 'characters_dto.g.dart';

@JsonSerializable(createToJson: false)
class CharactersDto {
  final List<CharacterDataDto>? data;
  final MetaDto? meta;

  const CharactersDto({this.data, this.meta});

  factory CharactersDto.fromJson(Map<String, dynamic> json) => _$CharactersDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MetaDto {
  final PaginationDto? pagination;

  const MetaDto({this.pagination});

  factory MetaDto.fromJson(Map<String, dynamic> json) => _$MetaDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaginationDto {
  final int? current;
  final int? next;
  final int? last;

  const PaginationDto({this.current, this.next, this.last});

  factory PaginationDto.fromJson(Map<String, dynamic> json) => _$PaginationDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class CharacterDataDto {
  final String? id;
  final CharacterAttributesDto? attributes;

  const CharacterDataDto({this.id, this.attributes});

  factory CharacterDataDto.fromJson(Map<String, dynamic> json) => _$CharacterDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class CharacterAttributesDto {
  final String? name;
  final String? image;
  final String? born;
  final String? died;

  const CharacterAttributesDto({this.name, this.image, this.born, this.died});

  factory CharacterAttributesDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterAttributesDtoFromJson(json);
}
