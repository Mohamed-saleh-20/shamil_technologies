import 'package:flutter/material.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Text(
            'Blog Page - Content Coming Soon!',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}