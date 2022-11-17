import 'package:dio/dio.dart';
import 'package:drill_2/src/models/hero_model.dart';
import 'package:drill_2/src/repositories/hero_repository.dart';
import 'package:drill_2/src/services/api_service.dart';

class HeroRepositoryImpl implements HeroRepository {
  final ApiService apiService;

  HeroRepositoryImpl({required this.apiService});

  @override
  Future<List<HeroModel>> getAllHeroes() async {
    Response response = await apiService.get(path: '/heroes');
    return List.from(
      (response.data as List<dynamic>).map(
        (e) => HeroModel.fromJson(e),
      ),
    );
  }
}
