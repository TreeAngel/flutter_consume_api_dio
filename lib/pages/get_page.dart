import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/api_helper.dart';

class GetPage extends StatefulWidget {
  const GetPage({super.key});

  @override
  State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
  late Future<List<PostModel>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = ApiHelper.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futurePosts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              PostModel post = snapshot.data![index];
              return Column(
                children: [
                  ListTile(
                    title: Text(post.title.toString()),
                    subtitle: Text(post.body.toString()),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Gagal mengambil data: ${snapshot.error}'),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
