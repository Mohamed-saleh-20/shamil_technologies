import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shamil_technologies/app/constants/app_colors.dart';
import 'package:shamil_technologies/app/utils/responsive.dart';
import 'package:shamil_technologies/features/contact/presentation/widgets/custom_text_field.dart';
import 'package:shamil_technologies/features/shared/widgets/main_layout.dart';

class CreativeContactPage extends StatefulWidget {
  const CreativeContactPage({super.key});

  @override
  State<CreativeContactPage> createState() => _CreativeContactPageState();
}

class _CreativeContactPageState extends State<CreativeContactPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _progressController;
  late AnimationController _floatingController;
  
  int _currentStep = 0;
  final int _totalSteps = 4;
  
  // Form data
  final Map<String, dynamic> _formData = {
    'name': '',
    'email': '',
    'phone': '',
    'company': '',
    'projectType': '',
    'budget': '',
    'timeline': '',
    'description': '',
    'priority': '',
    'source': '',
    'features': <String>[],
    'contactMethod': '',
  };

  // Controllers
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'company': TextEditingController(),
    'description': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    _floatingController.dispose();
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _progressController.animateTo((_currentStep + 1) / _totalSteps);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _progressController.animateTo((_currentStep + 1) / _totalSteps);
    }
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
              _buildAnimatedHeader(),
              const SizedBox(height: 50),
              _buildProgressIndicator(),
              const SizedBox(height: 30),
              _buildStepForm(isDesktop),
              const SizedBox(height: 30),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return FadeInDown(
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatingController.value * 10),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGradientStart.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: const Text(
              'رحلة مشروعك تبدأ هنا',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'خطوة بخطوة نحو تحقيق رؤيتك الرقمية',
            style: TextStyle(fontSize: 18, color: AppColors.lightGray),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSlate.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_totalSteps, (index) {
              final isActive = index <= _currentStep;
              final isCompleted = index < _currentStep;
              
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index < _totalSteps - 1 ? 8 : 0),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppColors.primaryGradientStart
                              : AppColors.glassBackground,
                          border: Border.all(
                            color: isActive
                                ? AppColors.primaryGradientStart
                                : AppColors.glassBorder,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          isCompleted
                              ? Icons.check_rounded
                              : _getStepIcon(index),
                          color: isActive ? Colors.white : AppColors.lightGray,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getStepTitle(index),
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? Colors.white : AppColors.lightGray,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressController.value,
                backgroundColor: AppColors.glassBackground,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryGradientStart,
                ),
                minHeight: 4,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStepForm(bool isDesktop) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: isDesktop ? 600 : 700,
      decoration: BoxDecoration(
        color: AppColors.darkSlate.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorder.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentStep = index);
          _progressController.animateTo((index + 1) / _totalSteps);
        },
        children: [
          _buildPersonalInfoStep(),
          _buildProjectDetailsStep(),
          _buildRequirementsStep(),
          _buildFinalStep(),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '👋 دعنا نتعرف عليك',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'معلوماتك الشخصية آمنة معنا',
                  style: TextStyle(fontSize: 16, color: AppColors.lightGray),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                _buildAnimatedTextField(
                  controller: _controllers['name']!,
                  label: 'الاسم الكامل',
                  icon: Icons.person_outline,
                  delay: 100,
                ),
                const SizedBox(height: 20),
                _buildAnimatedTextField(
                  controller: _controllers['email']!,
                  label: 'البريد الإلكتروني',
                  icon: Icons.email_outlined,
                  delay: 200,
                ),
                const SizedBox(height: 20),
                _buildAnimatedTextField(
                  controller: _controllers['phone']!,
                  label: 'رقم الهاتف',
                  icon: Icons.phone_outlined,
                  delay: 300,
                ),
                const SizedBox(height: 20),
                _buildAnimatedTextField(
                  controller: _controllers['company']!,
                  label: 'اسم الشركة (اختياري)',
                  icon: Icons.business_outlined,
                  delay: 400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDetailsStep() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🚀 أخبرنا عن مشروعك',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ما نوع المشروع الذي تريد إنشاءه؟',
                  style: TextStyle(fontSize: 16, color: AppColors.lightGray),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                _buildProjectTypeSelection(),
                const SizedBox(height: 24),
                _buildBudgetSelection(),
                const SizedBox(height: 24),
                _buildTimelineSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsStep() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🎯 متطلبات المشروع',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ما هي الميزات التي تحتاجها؟',
                  style: TextStyle(fontSize: 16, color: AppColors.lightGray),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                _buildFeaturesSelection(),
                const SizedBox(height: 24),
                _buildAnimatedTextField(
                  controller: _controllers['description']!,
                  label: 'وصف المشروع',
                  icon: Icons.description_outlined,
                  maxLines: 4,
                  delay: 0,
                ),
                const SizedBox(height: 24),
                _buildPrioritySelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '✨ الخطوة الأخيرة',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'كيف تفضل التواصل معنا؟',
                  style: TextStyle(fontSize: 16, color: AppColors.lightGray),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                _buildContactMethodSelection(),
                const SizedBox(height: 24),
                _buildSourceSelection(),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    int delay = 0,
  }) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glassBorder.withOpacity(0.5)),
          color: AppColors.glassBackground.withOpacity(0.5),
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: AppColors.lightGray),
            prefixIcon: Icon(icon, color: AppColors.primaryGradientStart),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectTypeSelection() {
    final projectTypes = [
      {'title': 'تطبيق موبايل', 'icon': Icons.phone_android, 'value': 'mobile'},
      {'title': 'موقع إلكتروني', 'icon': Icons.web, 'value': 'website'},
      {'title': 'تطبيق ويب', 'icon': Icons.web_asset, 'value': 'webapp'},
      {'title': 'تطبيق سطح المكتب', 'icon': Icons.desktop_windows, 'value': 'desktop'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نوع المشروع',
          style: TextStyle(fontSize: 16, color: AppColors.lightGray),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: projectTypes.map((type) {
            final isSelected = _formData['projectType'] == type['value'];
            return _buildSelectableCard(
              title: type['title'] as String,
              icon: type['icon'] as IconData,
              isSelected: isSelected,
              onTap: () => setState(() => _formData['projectType'] = type['value']),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBudgetSelection() {
    final budgets = [
      'أقل من 10 آلاف \$',
      '10-25 ألف \$',
      '25-50 ألف \$',
      '50-100 ألف \$',
      'أكثر من 100 ألف \$',
    ];

    return _buildChipSelection(
      title: 'الميزانية المتوقعة',
      options: budgets,
      selectedValue: _formData['budget'],
      onSelected: (value) => setState(() => _formData['budget'] = value),
    );
  }

  Widget _buildTimelineSelection() {
    final timelines = [
      'خلال شهر',
      '2-3 أشهر',
      '3-6 أشهر',
      'أكثر من 6 أشهر',
      'غير محدد',
    ];

    return _buildChipSelection(
      title: 'الجدول الزمني',
      options: timelines,
      selectedValue: _formData['timeline'],
      onSelected: (value) => setState(() => _formData['timeline'] = value),
    );
  }

  Widget _buildFeaturesSelection() {
    final features = [
      'تصميم UI/UX',
      'قاعدة البيانات',
      'API التطوير',
      'الدفع الإلكتروني',
      'التحليلات',
      'الأمان',
      'الإشعارات',
      'التكامل مع وسائل التواصل',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الميزات المطلوبة (يمكن اختيار أكثر من واحد)',
          style: TextStyle(fontSize: 16, color: AppColors.lightGray),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: features.map((feature) {
            final isSelected = (_formData['features'] as List<String>).contains(feature);
            return FilterChip(
              label: Text(feature),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    (_formData['features'] as List<String>).add(feature);
                  } else {
                    (_formData['features'] as List<String>).remove(feature);
                  }
                });
              },
              backgroundColor: AppColors.glassBackground,
              selectedColor: AppColors.primaryGradientStart,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.lightGray,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPrioritySelection() {
    final priorities = ['عادي', 'مهم', 'عاجل'];

    return _buildChipSelection(
      title: 'أولوية المشروع',
      options: priorities,
      selectedValue: _formData['priority'],
      onSelected: (value) => setState(() => _formData['priority'] = value),
    );
  }

  Widget _buildContactMethodSelection() {
    final methods = [
      {'title': 'الهاتف', 'icon': Icons.phone, 'value': 'phone'},
      {'title': 'البريد الإلكتروني', 'icon': Icons.email, 'value': 'email'},
      {'title': 'واتساب', 'icon': Icons.message, 'value': 'whatsapp'},
      {'title': 'اجتماع أونلاين', 'icon': Icons.video_call, 'value': 'meeting'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'طريقة التواصل المفضلة',
          style: TextStyle(fontSize: 16, color: AppColors.lightGray),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: methods.map((method) {
            final isSelected = _formData['contactMethod'] == method['value'];
            return _buildSelectableCard(
              title: method['title'] as String,
              icon: method['icon'] as IconData,
              isSelected: isSelected,
              onTap: () => setState(() => _formData['contactMethod'] = method['value']),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSourceSelection() {
    final sources = [
      'Google',
      'LinkedIn',
      'Facebook',
      'توصية من صديق',
      'البحث المباشر',
      'أخرى',
    ];

    return _buildChipSelection(
      title: 'كيف سمعت عنا؟',
      options: sources,
      selectedValue: _formData['source'],
      onSelected: (value) => setState(() => _formData['source'] = value),
    );
  }

  Widget _buildSelectableCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGradientStart.withOpacity(0.2)
              : AppColors.glassBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGradientStart
                : AppColors.glassBorder,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryGradientStart : AppColors.lightGray,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.lightGray,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipSelection({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.lightGray),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => onSelected(option),
              backgroundColor: AppColors.glassBackground,
              selectedColor: AppColors.primaryGradientStart,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.lightGray,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return FadeInUp(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGradientStart.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.rocket_launch, color: Colors.white),
          label: const Text(
            'إطلاق المشروع! 🚀',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton.icon(
              onPressed: _previousStep,
              icon: const Icon(Icons.arrow_back, color: AppColors.lightGray),
              label: const Text(
                'السابق',
                style: TextStyle(color: AppColors.lightGray),
              ),
            )
          else
            const SizedBox(),
          if (_currentStep < _totalSteps - 1)
            ElevatedButton.icon(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGradientStart,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: const Text(
                'التالي',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Collect all form data
    _formData['name'] = _controllers['name']!.text;
    _formData['email'] = _controllers['email']!.text;
    _formData['phone'] = _controllers['phone']!.text;
    _formData['company'] = _controllers['company']!.text;
    _formData['description'] = _controllers['description']!.text;

    // Here you would typically send the data to your backend
    print('Form Data: $_formData');
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم إرسال طلبك بنجاح! سنتواصل معك قريباً'),
        backgroundColor: AppColors.primaryGradientStart,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  IconData _getStepIcon(int index) {
    switch (index) {
      case 0:
        return Icons.person_outline;
      case 1:
        return Icons.work_outline;
      case 2:
        return Icons.settings_outlined;
      case 3:
        return Icons.send_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  String _getStepTitle(int index) {
    switch (index) {
      case 0:
        return 'المعلومات الشخصية';
      case 1:
        return 'تفاصيل المشروع';
      case 2:
        return 'المتطلبات';
      case 3:
        return 'الإرسال';
      default:
        return '';
    }
  }
}