import '../models/post_model.dart';
import 'api_controller.dart';

class ApiHelper {
  static Future<List<PostModel>> getPosts() async {
    List<dynamic> response = await ApiController.getData('posts');
    List<PostModel> data = [];
    for (var post in response) {
      data.add(PostModel.fromMap(post));
    }
    return data;
  }

  static Future<PostModel> createPosts(PostModel data) async {
    final response = await ApiController.postData('posts', data.toJson());
    return PostModel.fromMap(response);
  }
}