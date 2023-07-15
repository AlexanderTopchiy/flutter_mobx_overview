import 'package:flutter_mobx_overview/data/data_repository.dart';
import 'package:flutter_mobx_overview/data/model/post.dart';
import 'package:flutter_mobx_overview/data/network_exception.dart';
import 'package:flutter_mobx_overview/feature/post/mobx/post_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mob_x;
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('PostStore -', () {
    const postList = [
      Post(
        id: 0,
        title: 'first',
        body: 'body',
      ),
      Post(
        id: 1,
        title: 'second',
        body: 'body',
      ),
    ];
    const exception = NetworkException();

    late final MockDataRepository repository;

    setUpAll(() {
      repository = MockDataRepository();
      GetIt.I.registerLazySingleton<DataRepository>(() => repository);
    });

    test(
        'when called fetchPostList(), postListFuture status should '
        'become fulfilled with fetched post list as result', () async {
      // GIVEN
      when(repository.fetchPostList).thenAnswer((_) async => postList);

      // WHEN
      final postStore = PostStore();
      await postStore.fetchPostList();

      // THEN
      verify(repository.fetchPostList).called(1);

      expect(postStore.postListFuture.status, mob_x.FutureStatus.fulfilled);
      expect(postStore.postListFuture.result, postList);
    });

    test(
        'when called fetchPostList() and received an error, postListFuture status should '
        'become rejected with NetworkException as result', () async {
      // GIVEN
      when(repository.fetchPostList).thenAnswer((_) async => throw exception);

      // WHEN
      final postStore = PostStore();

      try {
        await postStore.fetchPostList();
      } catch (_) {
        // THEN
        verify(repository.fetchPostList).called(1);

        expect(postStore.postListFuture.status, mob_x.FutureStatus.rejected);
        expect(postStore.postListFuture.result, exception);
      }
    });
  });
}
