import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import '../../feature/main/cubit/main_cubit.dart';
import '../../feature/main/data/repo/main_repo.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // MARK: - Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // MARK: -main
  getIt.registerLazySingleton<MainRepo>(() => MainRepo(getIt()));
  getIt.registerFactory<MainCubit>(() => MainCubit(getIt()));
}
