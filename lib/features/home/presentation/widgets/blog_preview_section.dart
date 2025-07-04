import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:go_router/go_router.dart';

class BlogPreviewSection extends StatelessWidget {
  const BlogPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final blogPosts = [
      _BlogPost('أحدث اتجاهات تطوير تطبيقات الموبايل لعام 2025', 'التطوير', 'assets/images/blog/post1.jpg'),
      _BlogPost('كيف تختار التقنية المناسبة لمشروعك القادم؟', 'الأعمال', 'assets/images/blog/post2.jpg'),
      _BlogPost('أهمية تصميم واجهة المستخدم في نجاح التطبيقات', 'التصميم', 'assets/images/blog/post3.jpg'),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          FadeInDown(
            child: const Text(
              'أحدث المقالات',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: List.generate(blogPosts.length, (index) {
              return FadeInUp(
                delay: Duration(milliseconds: 150 * index),
                child: _BlogPostCard(post: blogPosts[index]),
              );
            }),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => context.go('/blog'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('عرض كل المقالات'),
          )
        ],
      ),
    );
  }
}

class _BlogPost {
  final String title;
  final String category;
  final String imagePath;
  _BlogPost(this.title, this.category, this.imagePath);
}

class _BlogPostCard extends StatelessWidget {
  final _BlogPost post;
  const _BlogPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: AppColors.darkSlate,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(post.imagePath, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.category.toUpperCase(), style: const TextStyle(color: AppColors.primaryGradientStart, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white), maxLines: 2),
                  const SizedBox(height: 16),
                  const Text('اقرأ المزيد...', style: TextStyle(color: AppColors.mediumGray)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}