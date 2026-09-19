// lib/services/achievement_service.dart
import 'package:get/get.dart';
import '../models/achievement_model.dart';
import '../data/achievements_data.dart';

class AchievementService extends GetxService {
  final RxList<AchievementBadge> badges = <AchievementBadge>[].obs;
  final RxList<Certificate> certificates = <Certificate>[].obs;
  final Rx<BadgeType?> selectedType = Rx<BadgeType?>(null);
  final RxString selectedTab = 'Badges'.obs;

  @override
  void onInit() {
    super.onInit();
    badges.value = dummyBadges;
    certificates.value = dummyCertificates;
  }

  void filterByType(BadgeType? type) {
    selectedType.value = type;
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  List<AchievementBadge> getFilteredBadges() {
    var filtered = badges.toList();
    if (selectedType.value != null) {
      filtered = filtered.where((b) => b.type == selectedType.value).toList();
    }
    return filtered;
  }

  Map<String, int> getStats() {
    return {
      'total': badges.length,
      'earned': badges.where((b) => b.isEarned).length,
      'inProgress': badges.where((b) => !b.isEarned && b.progress > 0).length,
      'certificates': certificates.length,
    };
  }

  List<AchievementBadge> getEarnedBadges() {
    return badges.where((b) => b.isEarned).toList();
  }

  List<AchievementBadge> getInProgressBadges() {
    return badges.where((b) => !b.isEarned && b.progress > 0).toList();
  }
}