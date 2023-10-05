import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:subspace_assignment/api.dart';
import 'package:subspace_assignment/models/blog.dart';
import 'package:subspace_assignment/providers/blog_provider.dart';

class BlogListService {
  Box box = Hive.box('blogs');
  final String baseUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
  void getBlogs(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Internet Connection'),
          ),
        );
      }
      List<Blog> blogs = [];
      for (Blog blog in box.get('blogs')) {
        blogs.add(blog);
      }
      if (context.mounted) context.read<BlogProvider>().setBlogs(blogs);
      return;
    }
    (String?, dynamic) response =
        await Api.getRequest(baseUrl, {'x-hasura-admin-secret': adminSecret});
    if (response.$1 == null) {
      List<Blog> blogs = [];
      for (var blog in response.$2['blogs']) {
        blogs.add(Blog.fromMap(blog));
      }
      if (context.mounted) context.read<BlogProvider>().setBlogs(blogs);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.$1!),
          ),
        );
      }
    }
  }
}
