import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subspace_assignment/models/blog.dart';
import 'package:subspace_assignment/providers/blog_provider.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key, required this.blog, required this.index});
  static const String routeName = '/blog';
  final Blog blog;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog',
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<BlogProvider>().toggleSave(index);
            },
            icon: Consumer<BlogProvider>(
              builder: (context, blogProvider, child) => Icon(
                blogProvider.blogs[index].saved
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: blog.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              blog.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            // add description
          ],
        ),
      ),
    );
  }
}
