import 'package:clean_architecture/features/posts/domain/enities/post.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/post_detail_page/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  AppBar _buildAppBar() => AppBar(
    title: Text('Post Detail', style: TextStyle(color: Colors.white)),
  );
  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
