import 'package:clean_architecture/core/util/snackbar_message.dart';
import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/add_delete_update_post_block/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // no rounding → rectangle
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.redAccent),
        iconColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: Icon(Icons.delete_outline),
      label: Text("Delete", style: TextStyle(color: Colors.white)),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
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
                MaterialPageRoute(builder: (_) => PostsPage()),
                (route) => false,
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
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }
}
