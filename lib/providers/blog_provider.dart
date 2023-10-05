import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace_assignment/models/blog.dart';

class BlogProvider extends ChangeNotifier {
  List<Blog> _blogs = [];
  List<Blog> get blogs => _blogs;
  final Box _box = Hive.box('blogs');
  void setBlogs(List<Blog> blogs) async {
    _blogs = blogs;
    await _box.clear();
    await _box.put('blogs', _blogs);
    notifyListeners();
  }

  void toggleSave(int index) async {
    _blogs[index].saved = !_blogs[index].saved;
    await _box.clear();
    await _box.put('blogs', _blogs);
    notifyListeners();
  }
}
