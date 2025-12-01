import 'package:clean_architecture/core/util/snackbar_message.dart';
import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/add_delete_update_post_block/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/posts_add_update_page/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});
  final Post? post;
  final bool isUpdatePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() =>
      AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackbarMessage.showSuccessSnackBar(
                message: state.message,
                context: context,
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PostsPage()),
                (route) => false,
              );
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackbarMessage.showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return LoadingWidget();
            }
            return FormWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      ),
    );
  }
}
