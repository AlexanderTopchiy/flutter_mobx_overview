import 'package:dio/dio.dart';
import 'package:flutter_mobx_overview/data/api_constants.dart';
import 'package:flutter_mobx_overview/data/data_repository.dart';
import 'package:get_it/get_it.dart';

abstract class DI {
  static final _di = GetIt.I;

  static T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
    Type? type,
  }) =>
      _di.get<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
        type: type,
      );

  static void register() {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    final dataRepository = DataRepository(client: dio);
    _di.registerLazySingleton<DataRepository>(() => dataRepository);
  }
}
