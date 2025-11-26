import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositroies/posts_repositroies.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase {
  PostsRepositories repositories;
  AddPostUseCase({required this.repositories});
  Future<Either<Failures, Unit>> call(Post post) async {
    return await repositories.addPost(post);
  }
}
