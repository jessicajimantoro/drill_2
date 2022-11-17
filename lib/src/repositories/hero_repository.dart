import 'package:drill_2/src/models/hero_model.dart';

abstract class HeroRepository {
  Future<List<HeroModel>> getAllHeroes();
}
