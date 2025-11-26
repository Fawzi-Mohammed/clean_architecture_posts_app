import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/posts/domain/repositroies/posts_repositroies.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepositories repositories;

  DeletePostUseCase({required this.repositories});
  Future<Either<Failures, Unit>> call(int postId) async {
    return await repositories.deletePost(postId);
  }
}
