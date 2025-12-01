import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/presentation/Bloc/add_delete_update_post_block/add_delete_update_post_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/posts_add_update_page/form_submit_btn.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/posts_add_update_page/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.isUpdatePost, this.post});
  final bool isUpdatePost;
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    // TODO: implement initState
    super.initState();
  }

  void validateFromThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(
          context,
        ).add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(
          context,
        ).add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: "Title",
            multiLines: false,
            controller: _titleController,
          ),
          TextFormFieldWidget(
            name: "Body",
            multiLines: true,
            controller: _bodyController,
          ),
          FormSubmitBtn(
            isUpdatePost: widget.isUpdatePost,
            onPressed: validateFromThenUpdateOrAddPost,
          ),
        ],
      ),
    );
  }
}
