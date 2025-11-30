import 'package:clean_architecture/core/app_theme.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/add_delete_update_post_block/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();

  // initialize your SharedPreferences instance here
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: Scaffold(
          appBar: AppBar(title: Text('Posts App')),
          body: Center(child: Text('Hello World!')),
        ),
      ),
    );
  }
}
