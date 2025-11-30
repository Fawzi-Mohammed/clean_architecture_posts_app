import 'dart:convert';

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSources {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const String CACHED_POSTS = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSources {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) async {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((PostModel) => PostModel.toJson())
        .toList();
    await sharedPreferences.setString(
      CACHED_POSTS,
      json.encode(postModelsToJson),
    );
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
