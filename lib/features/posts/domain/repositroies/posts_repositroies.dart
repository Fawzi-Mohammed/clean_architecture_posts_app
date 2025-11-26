import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepositories {
  Future<Either<Failures, List<Post>>> getAllPosts();
  Future<Either<Failures, Unit>> deletePost(int id);
  Future<Either<Failures, Unit>> updatePost(Post post);
  Future<Either<Failures, Unit>> addPost(Post post);
}
