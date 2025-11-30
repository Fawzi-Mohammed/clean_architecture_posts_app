import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_local_data_sources.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositroies/posts_repositroies.dart';
import 'package:dartz/dartz.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoriesImpl implements PostsRepositories {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSources localDataSource;
  final NetworkInfo networkInfo;
  PostsRepositoriesImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failures, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failures, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return await _getMassage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failures, Unit>> deletePost(int postId) async {
    return await _getMassage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failures, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return await _getMassage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failures, Unit>> _getMassage(
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
