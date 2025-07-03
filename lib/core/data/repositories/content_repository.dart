// lib/core/data/repositories/content_repository.dart

import 'package:shamil_technologies/core/domain/entities/service.dart';

class ContentRepository {
  static const List<Service> services = [
    Service(
      iconAsset: 'assets/icons/custom_software.svg', // Replace with your actual asset path
      title: 'تطوير برمجيات مخصصة',
      description: 'نصمم حلولاً برمجية فريدة تتناسب تمامًا مع متطلبات عملك، مما يضمن الكفاءة والنمو.',
    ),
    Service(
      iconAsset: 'assets/icons/web_dev.svg',
      title: 'تطوير الويب',
      description: 'نبني مواقع وتطبيقات ويب حديثة وسريعة الاستجابة توفر تجربة مستخدم استثنائية.',
    ),
    Service(
      iconAsset: 'assets/icons/mobile_app.svg',
      title: 'تطبيقات الموبايل',
      description: 'نطور تطبيقات أصلية (Native) وهجينة (Hybrid) لأنظمة iOS و Android تصل إلى جمهورك أينما كانوا.',
    ),
    Service(
      iconAsset: 'assets/icons/enterprise.svg',
      title: 'حلول المؤسسات',
      description: 'نوفر أنظمة قوية وقابلة للتطوير لإدارة الموارد البشرية، والمالية، وعلاقات العملاء.',
    ),
    Service(
      iconAsset: 'assets/icons/ui_ux.svg',
      title: 'تصميم واجهة وتجربة المستخدم',
      description: 'نصنع تصميمات جذابة وسهلة الاستخدام تضمن تفاعل المستخدمين ورضاهم عن منتجك الرقمي.',
    ),
    Service(
      iconAsset: 'assets/icons/cloud.svg',
      title: 'التكامل السحابي',
      description: 'نساعدك على ترحيل وإدارة بنيتك التحتية على منصات سحابية رائدة مثل AWS و Azure.',
    ),
    Service(
      iconAsset: 'assets/icons/support.svg',
      title: 'الدعم والصيانة',
      description: 'نقدم خدمات دعم فني وصيانة مستمرة لضمان عمل أنظمتك بسلاسة وأمان على مدار الساعة.',
    ),
  ];
}