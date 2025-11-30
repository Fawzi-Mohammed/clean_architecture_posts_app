import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/strings/string_failures.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts.call();
        emit(_mapFailureOrPostsState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts.call();
        emit(_mapFailureOrPostsState(failureOrPosts));
      }
    });
  }
  PostsState _mapFailureOrPostsState(Either<Failures, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),

      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
