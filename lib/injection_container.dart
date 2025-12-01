import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_local_data_sources.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/repositroies/post_repositories_impl.dart';
import 'package:clean_architecture/features/posts/domain/repositroies/posts_repositroies.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post_use_case.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts_use_case.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post_use_case.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/add_delete_update_post_block/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //features - posts

  //Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl.call()));
  sl.registerFactory(
    () => AddDeleteUpdatePostBloc(
      addPost: sl.call(),
      deletePost: sl.call(),
      updatePost: sl.call(),
    ),
  );
  //UseCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(repositories: sl.call()));
  sl.registerLazySingleton(() => AddPostUseCase(repositories: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repositories: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repositories: sl.call()));

  //Repository
  sl.registerLazySingleton<PostsRepositories>(
    () => PostsRepositoriesImpl(
      remoteDataSource: sl.call(),
      localDataSource: sl.call(),
      networkInfo: sl.call(),
    ),
  );
  //DataSources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client: sl.call()),
  );
  sl.registerLazySingleton<PostLocalDataSources>(
    () => PostLocalDataSourceImpl(sharedPreferences: sl.call()),
  );
  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetWorkInfoImpl(connectionChecker: sl.call()),
  );
  //External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
