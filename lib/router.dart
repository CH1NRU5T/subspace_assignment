import 'package:flutter/material.dart';
import 'package:subspace_assignment/features/blog/screens/blog_screen.dart';
import 'package:subspace_assignment/features/blog_list/screens/blog_list_screen.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case BlogListScreen.routeName:
      return MaterialPageRoute(builder: (_) => const BlogListScreen());
    case BlogScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => BlogScreen(
          blog: args['blog']!,
          index: args['index']!,
        ),
        settings: settings,
      );
    default:
      return MaterialPageRoute(builder: (_) => const BlogListScreen());
  }
}
