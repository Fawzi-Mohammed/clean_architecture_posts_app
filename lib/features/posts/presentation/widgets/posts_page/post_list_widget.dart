import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key, required this.posts});
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(posts[index].body, style: TextStyle(fontSize: 16)),
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}
