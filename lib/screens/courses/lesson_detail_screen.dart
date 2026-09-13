// lib/screens/courses/lesson_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/course_model.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  bool _isCompleted = false;
  double _fontSize = 16;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.lesson.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.lesson.title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        iconTheme: IconThemeData(color: context.textColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Responsive.padding(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Teacher Info
                  _buildTeacherCard(context, isDark),

                  SizedBox(height: Responsive.height(context, 16)),

                  // Video Placeholder
                  _buildVideoPlaceholder(context, isDark),

                  SizedBox(height: Responsive.height(context, 16)),

                  // Lesson Content
                  _buildLessonContent(context, isDark),

                  SizedBox(height: Responsive.height(context, 20)),

                  // Quiz Button
                  if (widget.lesson.quiz.isNotEmpty) _buildQuizButton(context, isDark),

                  SizedBox(height: Responsive.height(context, 20)),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          _buildBottomBar(context, isDark),
        ],
      ),
    );
  }

  Widget _buildTeacherCard(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 14)),
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
      child: Row(
        children: [
          Container(
            width: Responsive.width(context, 50),
            height: Responsive.width(context, 50),
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                widget.lesson.teacher.isNotEmpty ? widget.lesson.teacher[0] : 'T',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 22),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.padding(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lesson.teacher,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: context.textColor,
                  ),
                ),
                Text(
                  'Instructor',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.verified,
            color: AppColors.emerald,
            size: Responsive.width(context, 20),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlaceholder(BuildContext context, bool isDark) {
    return Container(
      height: Responsive.height(context, 180),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(16),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Responsive.width(context, 60),
            height: Responsive.width(context, 60),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow,
              size: Responsive.width(context, 36),
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context, 8)),
          Text(
            'Video Lesson',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonContent(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lesson Content',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, size: Responsive.width(context, 18), color: context.textSecondaryColor),
                    onPressed: () {
                      setState(() {
                        if (_fontSize > 12) _fontSize -= 2;
                      });
                    },
                  ),
                  Text(
                    '${_fontSize.toInt()}',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, size: Responsive.width(context, 18), color: context.textSecondaryColor),
                    onPressed: () {
                      setState(() {
                        if (_fontSize < 24) _fontSize += 2;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Text(
            widget.lesson.content,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, _fontSize),
              color: context.textColor,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizButton(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        _showQuizSheet(context, isDark);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        decoration: BoxDecoration(
          color: AppColors.islamicGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.islamicGold.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.width(context, 44),
              height: Responsive.width(context, 44),
              decoration: BoxDecoration(
                color: AppColors.islamicGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.quiz,
                color: AppColors.islamicGold,
                size: Responsive.width(context, 24),
              ),
            ),
            SizedBox(width: Responsive.padding(context, 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Take Quiz',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w600,
                      color: context.textColor,
                    ),
                  ),
                  Text(
                    '${widget.lesson.quiz.length} questions',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.width(context, 14),
              color: AppColors.islamicGold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Complete Button
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isCompleted = !_isCompleted;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isCompleted ? 'Lesson Completed! 🎉' : 'Marked as incomplete',
                      ),
                      backgroundColor: _isCompleted ? AppColors.emerald : Colors.grey,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.padding(context, 14),
                  ),
                  decoration: BoxDecoration(
                    gradient: _isCompleted ? null : AppGradients.primaryGradient,
                    color: _isCompleted ? AppColors.emerald.withOpacity(0.2) : null,
                    borderRadius: BorderRadius.circular(12),
                    border: _isCompleted
                        ? Border.all(color: AppColors.emerald)
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                        color: _isCompleted ? AppColors.emerald : Colors.white,
                        size: Responsive.width(context, 20),
                      ),
                      SizedBox(width: Responsive.padding(context, 8)),
                      Text(
                        _isCompleted ? 'Completed' : 'Mark Complete',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: _isCompleted ? AppColors.emerald : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: Responsive.padding(context, 12)),
            // Next Button
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.padding(context, 14),
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBackground : AppColors.lightMint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: AppColors.emerald,
                        ),
                      ),
                      SizedBox(width: Responsive.padding(context, 4)),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.emerald,
                        size: Responsive.width(context, 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuizSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(Responsive.padding(context, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 20),
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),
              SizedBox(height: Responsive.height(context, 4)),
              Text(
                '${widget.lesson.quiz.length} questions',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 13),
                  color: context.textSecondaryColor,
                ),
              ),
              SizedBox(height: Responsive.height(context, 16)),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.lesson.quiz.length,
                  itemBuilder: (context, index) {
                    final question = widget.lesson.quiz[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: Responsive.height(context, 12)),
                      padding: EdgeInsets.all(Responsive.padding(context, 14)),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBackground : AppColors.lightMint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${index + 1}. ${question.question}',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 14),
                              fontWeight: FontWeight.w600,
                              color: context.textColor,
                            ),
                          ),
                          SizedBox(height: Responsive.height(context, 8)),
                          ...question.options.asMap().entries.map((entry) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: Responsive.height(context, 6)),
                              child: Container(
                                padding: EdgeInsets.all(Responsive.padding(context, 10)),
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 13),
                                    color: context.textColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}