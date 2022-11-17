import 'package:dio/dio.dart';
import 'package:drill_2/src/repositories/hero_repository.dart';
import 'package:drill_2/src/repositories/hero_repository_impl.dart';
import 'package:drill_2/src/services/api_service.dart';
import 'package:drill_2/src/services/api_service_impl.dart';
import 'package:drill_2/src/view_models/home_view_model.dart';
import 'package:drill_2/src/view_models/home_view_model_impl.dart';
import 'package:kiwi/kiwi.dart';

class DependencyInjection {
  static final KiwiContainer _container = KiwiContainer();

  static Future<void> configure() async {
    Dio httpClient = Dio(
      BaseOptions(
        baseUrl: 'https://api.opendota.com/api',
      ),
    );
    _container.registerSingleton<ApiService>(
      (_) => ApiServiceImpl(
        httpClient: httpClient,
      ),
    );
    _container.registerInstance<HeroRepository>(
      HeroRepositoryImpl(
        apiService: _container.resolve<ApiService>(),
      ),
    );
    _container.registerInstance<HomeViewModel>(
      HomeViewModelImpl(
        heroRepository: _container.resolve<HeroRepository>(),
      ),
    );
  }

  static KiwiContainer get container => _container;
}
