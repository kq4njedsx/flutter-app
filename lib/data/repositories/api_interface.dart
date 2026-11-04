import 'package:proj1/domain/models/card.dart';

abstract class ApiInterface {
  Future<List<CardData>?> loadData({String? q});
}