// lib/data/courses_data.dart
import '../models/course_model.dart';

List<Course> dummyCourses = [
  Course(
    id: '1',
    title: 'Qur\'an Nazra',
    titleArabic: 'قرآن ناظرہ',
    description: 'Learn to read the Qur\'an with proper pronunciation and fluency.',
    instructor: 'Qari Abdul Basit',
    instructorArabic: 'قاری عبد الباسط',
    category: 'Qur\'an',
    level: 'Beginner',
    totalLessons: 20,
    completedLessons: 9,
    progress: 0.45,
    icon: '📖',
    color: '#0F5C4D',
    isEnrolled: true,
  ),
  Course(
    id: '2',
    title: 'Tajweed Rules',
    titleArabic: 'قواعد التجويد',
    description: 'Master the rules of Tajweed for beautiful Qur\'an recitation.',
    instructor: 'Sheikh Mishary Alafasy',
    instructorArabic: 'الشيخ مشاري العفاسي',
    category: 'Tajweed',
    level: 'Intermediate',
    totalLessons: 15,
    completedLessons: 5,
    progress: 0.33,
    icon: '🎯',
    color: '#187A64',
    isEnrolled: true,
  ),
  Course(
    id: '3',
    title: 'Seerah Chapters',
    titleArabic: 'فصول السيرة',
    description: 'Explore the life of Prophet Muhammad (PBUH) in detail.',
    instructor: 'Dr. Yasir Qadhi',
    instructorArabic: 'د. ياسر قاضي',
    category: 'Seerah',
    level: 'Beginner',
    totalLessons: 25,
    completedLessons: 15,
    progress: 0.60,
    icon: '📚',
    color: '#C7A44A',
    isEnrolled: true,
  ),
  Course(
    id: '4',
    title: 'Islamic Studies',
    titleArabic: 'الدراسات الإسلامية',
    description: 'Comprehensive Islamic studies covering Aqeedah, Fiqh, and Akhlaq.',
    instructor: 'Mufti Menk',
    instructorArabic: 'مفتي منك',
    category: 'Islamic Studies',
    level: 'Intermediate',
    totalLessons: 30,
    completedLessons: 22,
    progress: 0.73,
    icon: '🎓',
    color: '#8B6B3D',
    isEnrolled: true,
  ),
  Course(
    id: '5',
    title: 'Fiqh of Salah',
    titleArabic: 'فقه الصلاة',
    description: 'Learn the proper way to perform Salah according to Sunnah.',
    instructor: 'Sheikh Assim Al-Hakeem',
    instructorArabic: 'الشيخ عاصم الحكيم',
    category: 'Fiqh',
    level: 'Beginner',
    totalLessons: 12,
    completedLessons: 0,
    progress: 0.0,
    icon: '🕌',
    color: '#4A5A55',
    isEnrolled: false,
  ),
  Course(
    id: '6',
    title: 'Hadith Sciences',
    titleArabic: 'علوم الحديث',
    description: 'Introduction to the science of Hadith and its authentication.',
    instructor: 'Dr. Zakir Naik',
    instructorArabic: 'د. زاكر نايك',
    category: 'Hadith',
    level: 'Advanced',
    totalLessons: 18,
    completedLessons: 0,
    progress: 0.0,
    icon: '📜',
    color: '#2E7D32',
    isEnrolled: false,
  ),
];

// Get modules for a course
List<Module> getModulesForCourse(String courseId) {
  switch (courseId) {
    case '1': // Qur'an Nazra
      return [
        Module(
          id: '1-1',
          courseId: '1',
          title: 'Introduction to Qur\'an',
          titleArabic: 'مقدمة القرآن',
          moduleNumber: 1,
          totalLessons: 5,
          completedLessons: 5,
          lessons: _getLessonsForModule('1-1'),
        ),
        Module(
          id: '1-2',
          courseId: '1',
          title: 'Basic Rules',
          titleArabic: 'القواعد الأساسية',
          moduleNumber: 2,
          totalLessons: 6,
          completedLessons: 4,
          lessons: _getLessonsForModule('1-2'),
        ),
        Module(
          id: '1-3',
          courseId: '1',
          title: 'Short Surahs',
          titleArabic: 'السور القصيرة',
          moduleNumber: 3,
          totalLessons: 5,
          completedLessons: 0,
          lessons: _getLessonsForModule('1-3'),
        ),
        Module(
          id: '1-4',
          courseId: '1',
          title: 'Practice & Fluency',
          titleArabic: 'الممارسة والطلاقة',
          moduleNumber: 4,
          totalLessons: 4,
          completedLessons: 0,
          lessons: _getLessonsForModule('1-4'),
        ),
      ];
    case '2': // Tajweed Rules
      return [
        Module(
          id: '2-1',
          courseId: '2',
          title: 'Introduction to Tajweed',
          titleArabic: 'مقدمة التجويد',
          moduleNumber: 1,
          totalLessons: 5,
          completedLessons: 5,
          lessons: _getLessonsForModule('2-1'),
        ),
        Module(
          id: '2-2',
          courseId: '2',
          title: 'Makharij al-Huroof',
          titleArabic: 'مخارج الحروف',
          moduleNumber: 2,
          totalLessons: 5,
          completedLessons: 3,
          lessons: _getLessonsForModule('2-2'),
        ),
        Module(
          id: '2-3',
          courseId: '2',
          title: 'Rules of Noon & Meem',
          titleArabic: 'أحكام النون والميم',
          moduleNumber: 3,
          totalLessons: 5,
          completedLessons: 0,
          lessons: _getLessonsForModule('2-3'),
        ),
      ];
    case '3': // Seerah
      return [
        Module(
          id: '3-1',
          courseId: '3',
          title: 'Pre-Islamic Arabia',
          titleArabic: 'شبه الجزيرة قبل الإسلام',
          moduleNumber: 1,
          totalLessons: 6,
          completedLessons: 6,
          lessons: _getLessonsForModule('3-1'),
        ),
        Module(
          id: '3-2',
          courseId: '3',
          title: 'Birth & Early Life',
          titleArabic: 'المولد والنشأة',
          moduleNumber: 2,
          totalLessons: 6,
          completedLessons: 5,
          lessons: _getLessonsForModule('3-2'),
        ),
        Module(
          id: '3-3',
          courseId: '3',
          title: 'Prophethood',
          titleArabic: 'النبوة',
          moduleNumber: 3,
          totalLessons: 6,
          completedLessons: 4,
          lessons: _getLessonsForModule('3-3'),
        ),
        Module(
          id: '3-4',
          courseId: '3',
          title: 'Migration to Madinah',
          titleArabic: 'الهجرة إلى المدينة',
          moduleNumber: 4,
          totalLessons: 7,
          completedLessons: 0,
          lessons: _getLessonsForModule('3-4'),
        ),
      ];
    case '4': // Islamic Studies
      return [
        Module(
          id: '4-1',
          courseId: '4',
          title: 'Aqeedah (Belief)',
          titleArabic: 'العقيدة',
          moduleNumber: 1,
          totalLessons: 8,
          completedLessons: 8,
          lessons: _getLessonsForModule('4-1'),
        ),
        Module(
          id: '4-2',
          courseId: '4',
          title: 'Fiqh (Jurisprudence)',
          titleArabic: 'الفقه',
          moduleNumber: 2,
          totalLessons: 8,
          completedLessons: 7,
          lessons: _getLessonsForModule('4-2'),
        ),
        Module(
          id: '4-3',
          courseId: '4',
          title: 'Akhlaq (Character)',
          titleArabic: 'الأخلاق',
          moduleNumber: 3,
          totalLessons: 7,
          completedLessons: 7,
          lessons: _getLessonsForModule('4-3'),
        ),
        Module(
          id: '4-4',
          courseId: '4',
          title: 'Islamic History',
          titleArabic: 'التاريخ الإسلامي',
          moduleNumber: 4,
          totalLessons: 7,
          completedLessons: 0,
          lessons: _getLessonsForModule('4-4'),
        ),
      ];
    default:
      return [];
  }
}

// Get lessons for a module
List<Lesson> _getLessonsForModule(String moduleId) {
  final moduleNum = int.tryParse(moduleId.split('-').last) ?? 1;
  return List.generate(5, (index) {
    final lessonNum = index + 1;
    return Lesson(
      id: '$moduleId-$lessonNum',
      moduleId: moduleId,
      title: 'Lesson $lessonNum',
      titleArabic: 'الدرس $lessonNum',
      lessonNumber: lessonNum,
      duration: Duration(minutes: 10 + (lessonNum * 2)),
      isCompleted: lessonNum <= 2,
      isLocked: lessonNum > 3,
      content: _getDummyContent(lessonNum),
      teacher: 'Qari Abdul Basit',
      teacherArabic: 'قاری عبد الباسط',
      quiz: _getDummyQuiz(lessonNum),
    );
  });
}

String _getDummyContent(int lessonNum) {
  return '''
Lesson $lessonNum Content

In the name of Allah, the Most Gracious, the Most Merciful.

This lesson covers the fundamental concepts of the course. You will learn the basic rules and principles that form the foundation of your Islamic education.

Key Points:
1. Understanding the importance of this topic
2. Practical application in daily life
3. Common mistakes to avoid
4. Best practices for improvement

The Prophet (PBUH) said: "The best among you are those who learn the Qur'an and teach it." (Bukhari)

This lesson is designed to provide you with a comprehensive understanding of the subject matter. Take your time to absorb the information and practice regularly.
''';
}

List<QuizQuestion> _getDummyQuiz(int lessonNum) {
  return [
    QuizQuestion(
      id: 'q1-$lessonNum',
      question: 'What is the primary focus of this lesson?',
      options: [
        'Understanding the basic concepts',
        'Memorizing the text',
        'Writing the text',
        'None of the above',
      ],
      correctAnswerIndex: 0,
      explanation: 'The primary focus is to understand the basic concepts thoroughly.',
    ),
    QuizQuestion(
      id: 'q2-$lessonNum',
      question: 'Which hadith emphasizes the importance of learning?',
      options: [
        'Actions are judged by intentions',
        'The best among you are those who learn the Qur\'an',
        'Allah is the Most Merciful',
        'None of the above',
      ],
      correctAnswerIndex: 1,
      explanation: 'The hadith "The best among you are those who learn the Qur\'an and teach it" emphasizes learning.',
    ),
    QuizQuestion(
      id: 'q3-$lessonNum',
      question: 'What is the recommended practice for this lesson?',
      options: [
        'Read once',
        'Practice regularly',
        'Memorize completely',
        'Skip it',
      ],
      correctAnswerIndex: 1,
      explanation: 'Regular practice is recommended for mastery.',
    ),
  ];
}

List<String> getCourseCategories() {
  return ['All', 'Qur\'an', 'Tajweed', 'Seerah', 'Islamic Studies', 'Fiqh', 'Hadith'];
}

List<Course> getCoursesByCategory(String category) {
  if (category == 'All') return dummyCourses;
  return dummyCourses.where((c) => c.category == category).toList();
}