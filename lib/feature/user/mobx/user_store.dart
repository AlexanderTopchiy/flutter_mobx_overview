import 'package:flutter_mobx_overview/core/di.dart';
import 'package:flutter_mobx_overview/data/data_repository.dart';
import 'package:flutter_mobx_overview/data/model/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final _repository = DI.get<DataRepository>();

  @observable
  ObservableFuture<List<User>> userListFuture = ObservableFuture.value([]);

  @action
  Future<List<User>> fetchUserList() => userListFuture = ObservableFuture(_repository.fetchUserList());
}
