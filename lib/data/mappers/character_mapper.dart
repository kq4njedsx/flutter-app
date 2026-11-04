import 'package:proj1/data/dtos/characters_dto.dart';
import 'package:proj1/domain/models/card.dart';

const String _imagePlaceholder =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Ko1YCURBO1IUZuN6dyMpxrshbMtwhjQr0noR0_0XDg&s=10';

extension CharacterDataDtoToModel on CharacterDataDto {
  CardData toDomain() => CardData(
    attributes?.name ?? 'UNKNOWN',
    imageUrl: attributes?.image ?? _imagePlaceholder,
    detailsImageUrl: attributes?.image ?? _imagePlaceholder,
    descriptionText: _makeDescriptionText(attributes?.born, attributes?.died),
    detailsText: 'Информация о персонаже из вселенной Гарри Поттера.',
  );
}

String _makeDescriptionText(String? born, String? died) {
  if (born != null && died != null) {
    return '$born - $died';
  } else if (born != null) {
    return 'born: $born';
  } else if (died != null) {
    return 'died: $died';
  }
  return '';
}