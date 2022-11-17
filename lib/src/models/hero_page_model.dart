import 'package:drill_2/src/models/hero_model.dart';

class HeroPageModel {
  final int page;
  final List<HeroModel> hero;

  HeroPageModel({
    this.page = 1,
    this.hero = const [],
  });
}
