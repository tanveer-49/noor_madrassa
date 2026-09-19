// lib/data/achievements_data.dart
import '../models/achievement_model.dart';


List<AchievementBadge> dummyBadges = [
  AchievementBadge(
    id: 'b1',
    title: 'Qur\'an Beginner',
    description: 'Read your first Surah',
    icon: '📖',
    color: '#0F5C4D',
    type: BadgeType.quran,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 30)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b2',
    title: 'Qur\'an Reader',
    description: 'Read 10 Surahs',
    icon: '📚',
    color: '#187A64',
    type: BadgeType.quran,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 15)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b3',
    title: 'Qur\'an Master',
    description: 'Read 50 Surahs',
    icon: '🏆',
    color: '#C7A44A',
    type: BadgeType.quran,
    isEarned: false,
    progress: 0.45,
  ),
  AchievementBadge(
    id: 'b4',
    title: 'Hadith Seeker',
    description: 'Read 5 Hadiths',
    icon: '📜',
    color: '#0F5C4D',
    type: BadgeType.hadith,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 20)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b5',
    title: 'Hadith Scholar',
    description: 'Read 50 Hadiths',
    icon: '🎓',
    color: '#8B6B3D',
    type: BadgeType.hadith,
    isEarned: false,
    progress: 0.6,
  ),
  AchievementBadge(
    id: 'b6',
    title: 'First Steps',
    description: 'Complete your first lesson',
    icon: '🎯',
    color: '#187A64',
    type: BadgeType.course,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 25)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b7',
    title: 'Dedicated Student',
    description: 'Complete 10 lessons',
    icon: '📝',
    color: '#2E7D32',
    type: BadgeType.course,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 10)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b8',
    title: 'Course Champion',
    description: 'Complete a full course',
    icon: '🏅',
    color: '#C7A44A',
    type: BadgeType.course,
    isEarned: false,
    progress: 0.73,
  ),
  AchievementBadge(
    id: 'b9',
    title: 'Consistent Learner',
    description: '7 day streak',
    icon: '🔥',
    color: '#0F5C4D',
    type: BadgeType.streak,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 8)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b10',
    title: 'Dedicated Believer',
    description: '30 day streak',
    icon: '💪',
    color: '#187A64',
    type: BadgeType.streak,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 2)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b11',
    title: 'Unstoppable',
    description: '100 day streak',
    icon: '⭐',
    color: '#C7A44A',
    type: BadgeType.streak,
    isEarned: false,
    progress: 0.15,
  ),
  AchievementBadge(
    id: 'b12',
    title: 'Collector',
    description: 'Save 10 items',
    icon: '🔖',
    color: '#8B6B3D',
    type: BadgeType.bookmark,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 5)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b13',
    title: 'Curator',
    description: 'Save 50 items',
    icon: '📂',
    color: '#4A5A55',
    type: BadgeType.bookmark,
    isEarned: false,
    progress: 0.9,
  ),
  AchievementBadge(
    id: 'b14',
    title: 'Early Bird',
    description: 'Join in the first month',
    icon: '🌅',
    color: '#C7A44A',
    type: BadgeType.special,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 35)),
    progress: 1.0,
  ),
  AchievementBadge(
    id: 'b15',
    title: 'Ramadan Warrior',
    description: 'Complete Ramadan goals',
    icon: '🌙',
    color: '#0B1F1A',
    type: BadgeType.special,
    isEarned: false,
    progress: 0.0,
  ),
];

List<Certificate> dummyCertificates = [
  Certificate(
    id: 'c1',
    title: 'Qur\'an Nazra Completion',
    description: 'Successfully completed the Qur\'an Nazra course with excellent performance.',
    courseName: 'Qur\'an Nazra',
    instructor: 'Qari Abdul Basit',
    issuedAt: DateTime.now().subtract(const Duration(days: 60)),
    certificateNumber: 'NM-QN-2026-001',
    icon: '📖',
    color: '#0F5C4D',
  ),
  Certificate(
    id: 'c2',
    title: 'Tajweed Rules Mastery',
    description: 'Successfully completed the Tajweed Rules course with excellent performance.',
    courseName: 'Tajweed Rules',
    instructor: 'Sheikh Mishary Alafasy',
    issuedAt: DateTime.now().subtract(const Duration(days: 30)),
    certificateNumber: 'NM-TJ-2026-002',
    icon: '🎯',
    color: '#187A64',
  ),
  Certificate(
    id: 'c3',
    title: 'Seerah Knowledge',
    description: 'Successfully completed the Seerah Chapters course with excellent performance.',
    courseName: 'Seerah Chapters',
    instructor: 'Dr. Yasir Qadhi',
    issuedAt: DateTime.now().subtract(const Duration(days: 10)),
    certificateNumber: 'NM-SR-2026-003',
    icon: '📚',
    color: '#C7A44A',
  ),
];

// ✅ Change: List<Badge> → List<AchievementBadge>
List<AchievementBadge> getBadgesByType(BadgeType? type) {
  if (type == null) return dummyBadges;
  return dummyBadges.where((b) => b.type == type).toList();
}

List<AchievementBadge> getEarnedBadges() {
  return dummyBadges.where((b) => b.isEarned).toList();
}

List<AchievementBadge> getInProgressBadges() {
  return dummyBadges.where((b) => !b.isEarned && b.progress > 0).toList();
}

List<BadgeType> getBadgeTypes() {
  return BadgeType.values;
}

Map<String, int> getAchievementStats() {
  return {
    'total': dummyBadges.length,
    'earned': dummyBadges.where((b) => b.isEarned).length,
    'inProgress': dummyBadges.where((b) => !b.isEarned && b.progress > 0).length,
    'certificates': dummyCertificates.length,
  };
}