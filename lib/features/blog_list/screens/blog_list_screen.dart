import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subspace_assignment/features/blog/screens/blog_screen.dart';
import 'package:subspace_assignment/features/blog_list/services/blog_list_service.dart';
import 'package:subspace_assignment/providers/blog_provider.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});
  static const String routeName = '/blogListScreen';
  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  late BlogListService blogListService;
  @override
  void initState() {
    super.initState();
    blogListService = BlogListService();
    blogListService.getBlogs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blogs and Articles'),
        ),
        body: Consumer<BlogProvider>(
          builder: (context, blogProvider, child) {
            if (blogProvider.blogs.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: blogProvider.blogs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, BlogScreen.routeName,
                          arguments: {
                            'blog': blogProvider.blogs[index],
                            'index': index
                          });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: LinearProgressIndicator(
                                    minHeight: 200,
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey.shade300,
                                    ),
                                    value: downloadProgress.progress,
                                  ),
                                ),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: Colors.grey,
                                  );
                                },
                                imageUrl: blogProvider.blogs[index].imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              blogProvider.blogs[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
