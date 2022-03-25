// ignore_for_file: unnecessary_lambdas


import 'dart:convert';


import 'package:my_app/models/form_data.dart';
import 'package:my_app/models/post.dart';
import 'package:my_app/utils/network_utils.dart';
class DataService {
  //https://jsonplaceholder.typicode.com/posts
  Future<List<Post>> getPosts() async {
    try {
      final response = await NetworkService().getRequest('/posts');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        final posts = json
            .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
        // ignore: avoid_print
        print(posts.toString());
        return posts;
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> postData(FormModel form) async {
    try {
      final response = await NetworkService().postRequest('/albums', form);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        final posts = json
            .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
        // ignore: avoid_print
        print(posts.toString());
        return posts;
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      rethrow;
    }
  }
}

