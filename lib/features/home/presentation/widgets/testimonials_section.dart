import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final testimonials = [
      _Testimonial('علي أحمد', 'المدير التنفيذي لشركة انطلاق', 'كان العمل مع فريق شامل تجربة فريدة. الاحترافية والجودة العالية للمنتج النهائي فاقت كل توقعاتنا.'),
      _Testimonial('فاطمة سالم', 'مؤسسة منصة إبداع', 'الدقة في المواعيد والدعم الفني المستمر جعلا عملية تطوير تطبيقنا سلسة وناجحة.'),
    ];

    return Container(
      width: double.infinity,
      color: AppColors.darkSlate,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          FadeInDown(
            child: const Text(
              'ماذا يقول عملاؤنا',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: List.generate(testimonials.length, (index) {
              return FadeInUp(
                delay: Duration(milliseconds: 150 * index),
                child: _TestimonialCard(testimonial: testimonials[index]),
              );
            }),
          )
        ],
      ),
    );
  }
}

class _Testimonial {
  final String name;
  final String title;
  final String text;

  _Testimonial(this.name, this.title, this.text);
}

class _TestimonialCard extends StatelessWidget {
  final _Testimonial testimonial;
  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote_rounded, size: 40, color: AppColors.primaryGradientStart),
          const SizedBox(height: 12),
          Text(
            testimonial.text,
            style: const TextStyle(fontSize: 16, color: AppColors.lightGray, height: 1.6),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.primaryGradientStart,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(testimonial.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(testimonial.title, style: const TextStyle(fontSize: 12, color: AppColors.mediumGray)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}