import 'package:flutter_mobx_overview/core/di.dart';
import 'package:flutter_mobx_overview/data/data_repository.dart';
import 'package:flutter_mobx_overview/data/model/post.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  final _repository = DI.get<DataRepository>();

  @observable
  ObservableFuture<List<Post>> postListFuture = ObservableFuture.value([]);

  @action
  Future<List<Post>> fetchPostList() => postListFuture = ObservableFuture(_repository.fetchPostList());
}
