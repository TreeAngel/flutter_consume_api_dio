import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/api_helper.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  late Future<PostModel> _futurePost;

  @override
  void initState() {
    super.initState();
    _futurePost = ApiHelper.getPost(10);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: FutureBuilder<PostModel>(
          future: _futurePost,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Title'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(snapshot.data?.title ?? 'Post Deleted'),
                    const Divider(),
                    const Text('Body'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(snapshot.data?.body ?? 'Post Deleted'),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futurePost = ApiHelper.deletePosts(snapshot.data);
                        });
                      },
                      child: const Text('Delete Post'),
                    )
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
    );
  }
}
