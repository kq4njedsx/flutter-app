import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:proj1/data/dtos/characters_dto.dart';
import 'package:proj1/data/mappers/character_mapper.dart';
import 'package:proj1/data/repositories/api_interface.dart';
import 'package:proj1/domain/models/home.dart';

class PotterRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  static const String _baseUrl = 'https://api.potterdb.com';

  @override
  Future<HomeData?> loadData({Function(String?)? onError, String? q, int page = 1}) async {
    try {
      const String url = '$_baseUrl/v1/characters';

      final Response response = await _dio.get(
        url,
        queryParameters: {
          if (q != null && q.isNotEmpty) 'filter[name_cont]': q,
          'page[number]': page,
          'page[size]': 25,
        },
      );

      if (response.data != null) {
        final CharactersDto dto = CharactersDto.fromJson(response.data as Map<String, dynamic>);
        final HomeData data = dto.toDomain();
        return data;
      }
      return null;
    } on DioException catch (e) {
      onError?.call(e.error?.toString());
      return null;
    }
  }
}
