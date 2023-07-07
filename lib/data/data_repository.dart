import 'package:dio/dio.dart';
import 'package:flutter_mobx_overview/data/api_constants.dart';
import 'package:flutter_mobx_overview/data/model/post.dart';
import 'package:flutter_mobx_overview/data/model/user.dart';
import 'package:flutter_mobx_overview/data/network_exception.dart';

class DataRepository {
  final Dio client;

  const DataRepository({
    required this.client,
  });

  Future<List<User>> fetchUserList() async {
    final response = await client.get(ApiConstants.getUsers);

    if (response.statusCode != 200) {
      throw const NetworkException();
    }

    return [for (final json in response.data) User.fromJson(json)];
  }

  Future<List<Post>> fetchPostList() async {
    final response = await client.get(ApiConstants.getPosts);

    if (response.statusCode != 200) {
      throw const NetworkException();
    }

    return [for (final json in response.data) Post.fromJson(json)];
  }
}
