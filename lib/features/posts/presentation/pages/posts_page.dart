import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/posts_page/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),

      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
