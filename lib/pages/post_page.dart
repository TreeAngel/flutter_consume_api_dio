import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/api_helper.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  Future<PostModel>? _futurePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: _futurePost == null
            ? _createPostColumn()
            : _showCreatedPostBuilder(),
      ),
      floatingActionButton: _futurePost != null
          ? FloatingActionButton(
              onPressed: () {
                _futurePost = null;
              },
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }

  Widget _createPostColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(hintText: 'Post title'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _bodyController,
          decoration: const InputDecoration(hintText: 'Post body'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              final newPost = PostModel(
                userId: 1,
                title: _titleController.text,
                body: _bodyController.text,
              );
              _futurePost = ApiHelper.createPosts(newPost);
            });
          },
          child: const Text('Create new post'),
        ),
      ],
    );
  }

  Widget _showCreatedPostBuilder() {
    return FutureBuilder(
      future: _futurePost,
      builder: (BuildContext context, snapshot) {
        return FutureBuilder<PostModel>(
          future: _futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Divider(),
                  const Text('Post created'),
                  ListTile(
                    title: Text('Title: ${snapshot.data!.title}'),
                    subtitle: Text('Body: ${snapshot.data!.body}'),
                  ),
                  const Divider(),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error creating post: ${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
