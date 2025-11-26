import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositroies/posts_repositroies.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostsRepositories repositories;

  GetAllPostsUseCase({required this.repositories});
  Future<Either<Failures, List<Post>>> call() async {
    return await repositories.getAllPosts();
  }
}
