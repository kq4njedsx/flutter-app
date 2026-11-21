import 'package:proj1/data/dtos/characters_dto.dart';
import 'package:proj1/domain/models/card.dart';
import 'package:proj1/domain/models/home.dart';

const String _imagePlaceholder =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzxjeRoyHKHBUzrGKfTdDq_hR4aL7rCeo62iFBzVUQQQ&s=10';

extension CharacterDataDtoToModel on CharacterDataDto {
  CardData toDomain() {
    final resolvedImageUrl = _resolveImageUrl(attributes?.image);
    final name = _cleanString(attributes?.name) ?? 'UNKNOWN';

    return CardData(
      name,
      id: id,
      imageUrl: resolvedImageUrl,
      detailsImageUrl: resolvedImageUrl,
      descriptionText: _makeDescriptionText(attributes?.born, attributes?.died),
      detailsText: _makeDetailsText(name, attributes?.born, attributes?.died),
    );
  }
}

extension CharactersDtoToModel on CharactersDto {
  HomeData toDomain() => HomeData(
    data: data?.map((e) => e.toDomain()).toList(),
    nextPage: meta?.pagination?.next,
  );
}

String? _cleanString(String? value) {
  if (value == null) return null;
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}

String _resolveImageUrl(String? rawUrl) {
  return _cleanString(rawUrl) ?? _imagePlaceholder;
}

String _makeDescriptionText(String? born, String? died) {
  final cleanBorn = _cleanString(born);
  final cleanDied = _cleanString(died);

  if (cleanBorn != null && cleanDied != null) {
    return '$cleanBorn - $cleanDied';
  }
  if (cleanBorn != null) {
    return 'born: $cleanBorn';
  }
  if (cleanDied != null) {
    return 'died: $cleanDied';
  }
  return '';
}

String _makeDetailsText(String name, String? born, String? died) {
  final cleanBorn = _cleanString(born);
  final cleanDied = _cleanString(died);
  final details = <String>['Персонаж: $name'];

  if (cleanBorn != null) {
    details.add('Дата рождения: $cleanBorn');
  }
  if (cleanDied != null) {
    details.add('Дата смерти: $cleanDied');
  }
  if (cleanBorn == null && cleanDied == null) {
    details.add('Информация о персонаже из вселенной Гарри Поттера.');
  }

  return details.join('\n');
}