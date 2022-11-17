import 'package:drill_2/src/models/hero_model.dart';
import 'package:drill_2/src/models/hero_page_model.dart';
import 'package:drill_2/src/repositories/hero_repository.dart';
import 'package:drill_2/src/view_models/home_view_model.dart';

class HomeViewModelImpl implements HomeViewModel {
  final HeroRepository heroRepository;

  late List<HeroModel> _agiHeroes;
  late List<HeroModel> _intHeroes;
  late List<HeroModel> _strHeroes;
  late List<HeroPageModel> _meleeHeroes;

  List<HeroModel> _heroes = [];

  HomeViewModelImpl({
    required this.heroRepository,
  }) {
    _agiHeroes = [];
    _intHeroes = [];
    _strHeroes = [];
    _meleeHeroes = [];
  }

  @override
  Future<List<HeroModel>> getAllHeroes() async {
    _heroes = await heroRepository.getAllHeroes();
    _manageHeroes();
    return _heroes;
  }

  void _manageHeroes() {
    for (HeroModel hero in _heroes) {
      if (hero.primaryAttribute == 'agi') {
        _agiHeroes.add(hero);
      } else if (hero.primaryAttribute == 'str') {
        _strHeroes.add(hero);
      } else if (hero.primaryAttribute == 'int') {
        _intHeroes.add(hero);
      }
      if (hero.attackType == 'Melee') {
        if (_meleeHeroes.isEmpty) {
          _meleeHeroes.add(HeroPageModel(hero: [hero]));
          continue;
        }
        if (_meleeHeroes.last.hero.length == 8) {
          _meleeHeroes.add(
            HeroPageModel(
              page: _meleeHeroes.last.page + 1,
              hero: [hero],
            ),
          );
          continue;
        }
        if (_meleeHeroes.last.hero.length < 8) {
          _meleeHeroes.last.hero.add(hero);
        }
      }
    }
  }

  @override
  List<HeroModel> getAgiHero(int count) {
    return _agiHeroes.sublist(0, count);
  }

  @override
  List<HeroModel> getIntHero(int count) {
    return _intHeroes.sublist(0, count);
  }

  @override
  List<HeroModel> getStrHero(int count) {
    return _strHeroes.sublist(0, count);
  }

  @override
  List<HeroModel> getMeleeHero({int page = 1}) {
    if (_meleeHeroes.isNotEmpty) {
      return _meleeHeroes[page - 1].hero;
    }
    return [];
  }
}
