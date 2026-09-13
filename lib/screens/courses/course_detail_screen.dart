// lib/screens/courses/course_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/courses_data.dart';
import 'package:noor_madrassa/models/course_model.dart';
import 'package:noor_madrassa/screens/courses/lesson_detail_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final modules = getModulesForCourse(course.id);
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          course.title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 18),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        iconTheme: IconThemeData(color: context.textColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Header Card
            _buildCourseHeader(context, isDark),

            // Modules List
            Padding(
              padding: EdgeInsets.all(Responsive.padding(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Content',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 18),
                      fontWeight: FontWeight.bold,
                      color: context.textColor,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 4)),
                  Text(
                    '${modules.length} modules • ${course.totalLessons} lessons',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      color: context.textSecondaryColor,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 16)),
                  ...modules.map((module) => _buildModuleCard(context, isDark, module)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseHeader(BuildContext context, bool isDark) {
    return Container(
      margin: EdgeInsets.all(Responsive.padding(context, 16)),
      padding: EdgeInsets.all(Responsive.padding(context, 20)),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Responsive.width(context, 60),
                height: Responsive.height(context, 60),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    course.icon,
                    style: TextStyle(fontSize: Responsive.fontSize(context, 30)),
                  ),
                ),
              ),
              SizedBox(width: Responsive.padding(context, 14)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Responsive.height(context, 4)),
                    Text(
                      course.instructor,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 16)),
          Text(
            course.description,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 13),
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          SizedBox(height: Responsive.height(context, 16)),
          // Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: course.progress,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.islamicGold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Responsive.padding(context, 12)),
              Text(
                '${(course.progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 8)),
          Text(
            '${course.completedLessons} of ${course.totalLessons} lessons completed',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, bool isDark, Module module) {
    final progress = module.totalLessons > 0
        ? module.completedLessons / module.totalLessons
        : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height(context, 12)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: Responsive.padding(context, 16),
            vertical: Responsive.padding(context, 4),
          ),
          childrenPadding: EdgeInsets.zero,
          leading: Container(
            width: Responsive.width(context, 40),
            height: Responsive.height(context, 40),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBackground : AppColors.lightMint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${module.moduleNumber}',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: AppColors.emerald,
                ),
              ),
            ),
          ),
          title: Text(
            module.title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: context.textColor,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: Responsive.padding(context, 4)),
            child: Text(
              '${module.completedLessons}/${module.totalLessons} lessons',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                color: context.textSecondaryColor,
              ),
            ),
          ),
          children: module.lessons.map((lesson) => _buildLessonItem(context, isDark, lesson)).toList(),
        ),
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, bool isDark, Lesson lesson) {
    return GestureDetector(
      onTap: () {
        if (!lesson.isLocked) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonDetailScreen(lesson: lesson),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.padding(context, 12),
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            ),
          ),
        ),
        child: Row(
          children: [
            // Lesson Status Icon
            Container(
              width: Responsive.width(context, 32),
              height: Responsive.width(context, 32),
              decoration: BoxDecoration(
                color: lesson.isCompleted
                    ? AppColors.emerald.withOpacity(0.15)
                    : (lesson.isLocked
                    ? Colors.grey.withOpacity(0.1)
                    : AppColors.islamicGold.withOpacity(0.15)),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  lesson.isCompleted
                      ? Icons.check
                      : (lesson.isLocked ? Icons.lock : Icons.play_arrow),
                  size: Responsive.width(context, 16),
                  color: lesson.isCompleted
                      ? AppColors.emerald
                      : (lesson.isLocked ? Colors.grey : AppColors.islamicGold),
                ),
              ),
            ),
            SizedBox(width: Responsive.padding(context, 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      fontWeight: FontWeight.w500,
                      color: lesson.isLocked
                          ? context.textSecondaryColor
                          : context.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${lesson.duration.inMinutes} min',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 11),
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (lesson.quiz.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 8),
                  vertical: Responsive.padding(context, 2),
                ),
                decoration: BoxDecoration(
                  color: AppColors.islamicGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 9),
                    color: AppColors.islamicGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}