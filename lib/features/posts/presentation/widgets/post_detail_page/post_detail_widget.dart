import 'package:clean_architecture/core/util/snackbar_message.dart';
import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/add_delete_update_post_block/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/post_detail_page/delete_post_btn_widget.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/post_detail_page/update_posts_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!)
            ],
          )
        ],
      ),
    );
  }
  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackbarMessage.showSuccessSnackBar(
                message: state.message,
                context: context,
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => PostsPage()),
                (route) => true,
              );
            } else if (state is ErrorAddDeleteUpdatePostState) {
              Navigator.of(context).pop();
              SnackbarMessage.showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(postId: post.id!);
          },
        );
      },
    );
  }


}

  