import 'package:drill_2/src/models/hero_model.dart';

abstract class HomeViewModel {
  Future<List<HeroModel>> getAllHeroes();
  List<HeroModel> getAgiHero(int count);
  List<HeroModel> getIntHero(int count);
  List<HeroModel> getStrHero(int count);
  List<HeroModel> getMeleeHero({int page = 1});
}
