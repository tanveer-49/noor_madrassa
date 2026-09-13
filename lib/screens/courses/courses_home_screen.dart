// lib/screens/courses/courses_home_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/courses_data.dart';
import 'package:noor_madrassa/models/course_model.dart';
import 'package:noor_madrassa/screens/courses/course_detail_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class CoursesHomeScreen extends StatefulWidget {
  const CoursesHomeScreen({super.key});

  @override
  State<CoursesHomeScreen> createState() => _CoursesHomeScreenState();
}

class _CoursesHomeScreenState extends State<CoursesHomeScreen> {
  String _selectedCategory = 'All';
  List<Course> _filteredCourses = [];
  List<Course> _enrolledCourses = [];

  @override
  void initState() {
    super.initState();
    _filteredCourses = dummyCourses;
    _enrolledCourses = dummyCourses.where((c) => c.isEnrolled).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Madrassa Courses',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: context.textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Continue Learning Section
          if (_enrolledCourses.isNotEmpty) _buildContinueLearning(context),

          // Category Chips
          _buildCategoryChips(context),

          const SizedBox(height: 16),

          // All Courses Grid
          Expanded(
            child: _buildCoursesGrid(context),
          ),
        ],
      ),
    );
  }

  // ✅ Continue Learning Card - Premium
  Widget _buildContinueLearning(BuildContext context) {
    final course = _enrolledCourses.first;
    final isDark = context.isDarkMode;

    return Container(
      margin: EdgeInsets.all(Responsive.padding(context, 16)),
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Continue Learning',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 8),
                  vertical: Responsive.padding(context, 4),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  course.level,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 10),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 8)),
          Row(
            children: [
              Container(
                width: Responsive.width(context, 50),
                height: Responsive.height(context, 50),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    course.icon,
                    style: TextStyle(fontSize: Responsive.fontSize(context, 24)),
                  ),
                ),
              ),
              SizedBox(width: Responsive.padding(context, 12)),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${course.completedLessons}/${course.totalLessons} lessons',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // Progress Circle
              SizedBox(
                width: Responsive.width(context, 50),
                height: Responsive.width(context, 50),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: course.progress,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.islamicGold,
                      ),
                      strokeWidth: 4,
                    ),
                    Text(
                      '${(course.progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 11),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 12)),
          // Continue Button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(course: course),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: Responsive.padding(context, 10),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: Responsive.width(context, 18),
                  ),
                  SizedBox(width: Responsive.padding(context, 6)),
                  Text(
                    'Continue Lesson',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final categories = getCourseCategories();
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == _selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _filteredCourses = getCoursesByCategory(category);
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: Responsive.padding(context, 8)),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context, 16),
                vertical: Responsive.padding(context, 8),
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.emerald : context.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.emerald
                      : (context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : context.textSecondaryColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: Responsive.fontSize(context, 13),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoursesGrid(BuildContext context) {
    if (_filteredCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 64,
              color: context.textSecondaryColor,
            ),
            SizedBox(height: Responsive.height(context, 16)),
            Text(
              'No courses in this category',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.gridColumns(context),
        crossAxisSpacing: Responsive.padding(context, 12),
        mainAxisSpacing: Responsive.padding(context, 12),
        childAspectRatio: 0.78,
      ),
      itemCount: _filteredCourses.length,
      itemBuilder: (context, index) {
        final course = _filteredCourses[index];
        return _buildCourseCard(context, course);
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    final color = Color(int.parse(course.color.replaceFirst('#', 'FF'), radix: 16));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: course),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Responsive.padding(context, 12)),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Icon with Individual Color
            Container(
              height: Responsive.height(context, 70),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  course.icon,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 32)),
                ),
              ),
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              course.title,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
                fontWeight: FontWeight.w600,
                color: context.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 2)),
            Text(
              course.instructor,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 10),
                color: context.textSecondaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 6)),
            // Level + Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? AppColors.darkBackground : AppColors.lightMint,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    course.level,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 8),
                      color: AppColors.emerald,
                    ),
                  ),
                ),
                if (course.isEnrolled)
                  Text(
                    '${(course.progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 10),
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            if (course.isEnrolled) ...[
              SizedBox(height: Responsive.height(context, 4)),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: course.progress,
                  minHeight: 3,
                  backgroundColor: context.isDarkMode ? AppColors.darkBackground : Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emerald),
                ),
              ),
            ] else ...[
              SizedBox(height: Responsive.height(context, 4)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Responsive.padding(context, 4)),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'Enroll',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 9),
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}