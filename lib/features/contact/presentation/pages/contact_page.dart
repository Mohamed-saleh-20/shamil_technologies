import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:shamil_technologies/features/contact/presentation/widgets/custom_text_field.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedBudget;
  String? _selectedSource;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return MainLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: isDesktop ? 3 : 0,
                      child: FadeInLeft(child: _buildContactForm()),
                    ),
                    if (isDesktop) const SizedBox(width: 50),
                    if (!isDesktop) const SizedBox(height: 50),
                    Expanded(
                      flex: isDesktop ? 2 : 0,
                      child: FadeInRight(child: _buildContactInfo()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              'تواصل معنا',
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'نحن هنا للمساعدة في أي أسئلة أو طلبات',
            style: TextStyle(fontSize: 18, color: AppColors.lightGray),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder.withOpacity(0.5)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'هل أنت مستعد لتحويل فكرتك إلى حقيقة؟',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 24),
            CustomTextField(hintText: 'الاسم الكامل', icon: Icons.person_outline, controller: _nameController),
            const SizedBox(height: 16),
            CustomTextField(hintText: 'البريد الإلكتروني', icon: Icons.email_outlined, controller: _emailController),
            const SizedBox(height: 16),
            CustomTextField(hintText: 'كيف يمكننا مساعدتك؟', icon: Icons.help_outline, maxLines: 4, controller: _messageController),
            const SizedBox(height: 24),
            _buildChoiceChipSection(
              title: 'الميزانية المتوقعة (اختياري)',
              choices: ['أقل من 20 ألف \$', '20-50 ألف \$', '50-100 ألف \$', 'أكثر من 100 ألف \$', 'غير محدد'],
              selectedValue: _selectedBudget,
              onSelected: (value) => setState(() => _selectedBudget = value),
            ),
            const SizedBox(height: 24),
            _buildChoiceChipSection(
              title: 'كيف سمعت عنا؟ (اختياري)',
              choices: ['Clutch', 'Google', 'Upwork', 'Dribbble', 'توصية'],
              selectedValue: _selectedSource,
              onSelected: (value) => setState(() => _selectedSource = value),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: AppColors.primaryGradientStart,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                label: const Text('إرسال الطلب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChipSection({
    required String title,
    required List<String> choices,
    required String? selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: AppColors.lightGray)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: choices.map((choice) {
            final isSelected = selectedValue == choice;
            return ChoiceChip(
              label: Text(choice),
              selected: isSelected,
              onSelected: (_) => onSelected(choice),
              backgroundColor: AppColors.glassBackground,
              selectedColor: AppColors.primaryGradientStart,
              labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.lightGray),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isSelected ? Colors.transparent : AppColors.glassBorder),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.location_on_outlined, 'موقعنا', 'واحة دبي للسيليكون، دبي، الإمارات العربية المتحدة'),
          const Divider(color: AppColors.glassBorder, height: 40),
          _buildInfoRow(Icons.email_outlined, 'البريد الإلكتروني', 'sales@shamil-tech.com'),
          const Divider(color: AppColors.glassBorder, height: 40),
          _buildInfoRow(Icons.phone_outlined, 'الهاتف', '+971 50 123 4567'),
          const Divider(color: AppColors.glassBorder, height: 40),
          const Text('تابعنا على', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          const Row(
            children: [
              // Using the new _SocialIcon widget
              _SocialIcon(icon: Icons.facebook),
              SizedBox(width: 16),
              _SocialIcon(icon: Icons.camera_alt), // Placeholder for Instagram
              SizedBox(width: 16),
              _SocialIcon(icon: Icons.code), // Placeholder for LinkedIn
              SizedBox(width: 16),
              _SocialIcon(icon: Icons.flutter_dash), // Placeholder for X/Twitter
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryGradientStart, size: 24),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: AppColors.lightGray)),
          ],
        ),
      ],
    );
  }
}

/// A new stateful widget for social media icons with a hover effect.
class _SocialIcon extends StatefulWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  State<_SocialIcon> createState() => __SocialIconState();
}

class __SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered ? AppColors.primaryGradientStart : AppColors.glassBackground,
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? Colors.white : AppColors.lightGray,
            size: 20,
          ),
        ),
      ),
    );
  }
}