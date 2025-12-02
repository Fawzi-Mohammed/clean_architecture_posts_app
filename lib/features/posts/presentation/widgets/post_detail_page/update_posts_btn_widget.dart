import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:flutter/material.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // no rounding → rectangle
          ),
        ),
        backgroundColor: WidgetStateProperty.all(Color(0xff082659)),
        iconColor: WidgetStateProperty.all(Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(isUpdatePost: true, post: post),
          ),
        );
      },
      icon: Icon(Icons.edit),
      label: Text("Edit", style: TextStyle(color: Colors.white)),
    );
  }
}
