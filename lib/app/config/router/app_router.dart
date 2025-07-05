import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shamil_technologies/features/contact/presentation/pages/contact_page.dart';
import 'package:shamil_technologies/features/home/presentation/pages/home_page.dart';
import 'package:shamil_technologies/features/services/presentation/pages/services_page.dart';
// Import the new pages
import 'package:shamil_technologies/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:shamil_technologies/features/blog/presentation/pages/blog_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: '/portfolio',
        builder: (context, state) => const PortfolioPage(),
      ),
      GoRoute(
        path: '/blog',
        builder: (context, state) => const BlogPage(),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => const CreativeContactPage(),
      ),
    ],
  );
});