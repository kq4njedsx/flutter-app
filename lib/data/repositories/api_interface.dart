import 'package:proj1/domain/models/home.dart';

abstract class ApiInterface {
  Future<HomeData?> loadData({Function(String?)? onError, String? q, int page = 1});
}
