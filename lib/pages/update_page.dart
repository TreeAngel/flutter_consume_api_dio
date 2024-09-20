import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/api_helper.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late Future<PostModel> _futurePost;

  @override
  void initState() {
    super.initState();
    _futurePost = ApiHelper.getPost(10);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: FutureBuilder<PostModel>(
            future: _futurePost,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data!.title.toString()),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Title',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data!.body.toString()),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _bodyController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Body',
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final updatePost = PostModel(
                              id: 1,
                              userId: 1,
                              title: _titleController.text,
                              body: _bodyController.text,
                            );
                            _futurePost = ApiHelper.updatePosts(updatePost);
                          });
                        },
                        child: const Text('Update Data'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}