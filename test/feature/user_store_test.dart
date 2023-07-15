import 'package:flutter_mobx_overview/data/data_repository.dart';
import 'package:flutter_mobx_overview/data/model/user.dart';
import 'package:flutter_mobx_overview/data/network_exception.dart';
import 'package:flutter_mobx_overview/feature/user/mobx/user_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mob_x;
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('UserStore -', () {
    const userList = [
      User(
        id: 0,
        name: 'first',
      ),
      User(
        id: 1,
        name: 'second',
      ),
    ];
    const exception = NetworkException();

    late final MockDataRepository repository;

    setUpAll(() {
      repository = MockDataRepository();
      GetIt.I.registerLazySingleton<DataRepository>(() => repository);
    });

    test(
        'when called fetchUserList(), userListFuture status should '
        'become fulfilled with fetched user list as result', () async {
      // GIVEN
      when(repository.fetchUserList).thenAnswer((_) async => userList);

      // WHEN
      final userStore = UserStore();
      await userStore.fetchUserList();

      // THEN
      verify(repository.fetchUserList).called(1);

      expect(userStore.userListFuture.status, mob_x.FutureStatus.fulfilled);
      expect(userStore.userListFuture.result, userList);
    });

    test(
        'when called fetchUserList() and received an error, userListFuture status should '
        'become rejected with NetworkException as result', () async {
      // GIVEN
      when(repository.fetchUserList).thenAnswer((_) async => throw exception);

      // WHEN
      final userStore = UserStore();

      try {
        await userStore.fetchUserList();
      } catch (_) {
        // THEN
        verify(repository.fetchUserList).called(1);

        expect(userStore.userListFuture.status, mob_x.FutureStatus.rejected);
        expect(userStore.userListFuture.result, exception);
      }
    });
  });
}
