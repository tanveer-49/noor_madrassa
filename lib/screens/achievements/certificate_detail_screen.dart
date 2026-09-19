// lib/screens/achievements/certificate_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/achievement_model.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class CertificateDetailScreen extends StatelessWidget {
  final Certificate certificate;

  const CertificateDetailScreen({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final color = Color(int.parse(certificate.color.replaceFirst('#', 'FF'), radix: 16));

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Certificate',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 18),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        iconTheme: IconThemeData(color: context.textColor),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: context.textColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download, color: context.textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Column(
          children: [
            // Certificate Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Responsive.padding(context, 24)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Certificate Icon
                  Container(
                    width: Responsive.width(context, 80),
                    height: Responsive.width(context, 80),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        certificate.icon,
                        style: TextStyle(fontSize: Responsive.fontSize(context, 36)),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 16)),

                  // Title
                  Text(
                    certificate.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 22),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 8)),

                  // Subtitle
                  Text(
                    'This certificate is proudly presented to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 8)),

                  // Student Name
                  Text(
                    'Ahmed Khan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.islamicGold,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 8)),

                  // Course Name
                  Text(
                    'For completing "${certificate.courseName}"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 20)),

                  // Certificate Number
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.padding(context, 12),
                      vertical: Responsive.padding(context, 6),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      certificate.certificateNumber,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height(context, 24)),

            // Details Section
            _buildDetailSection(
              context,
              isDark,
              'Course Details',
              [
                _buildDetailRow(context, 'Course', certificate.courseName),
                _buildDetailRow(context, 'Instructor', certificate.instructor),
                _buildDetailRow(context, 'Issued On', _formatDate(certificate.issuedAt)),
                _buildDetailRow(context, 'Certificate No', certificate.certificateNumber),
              ],
            ),
            SizedBox(height: Responsive.height(context, 16)),

            // Description
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Responsive.padding(context, 16)),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w600,
                      color: AppColors.emerald,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 8)),
                  Text(
                    certificate.description,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      color: context.textColor,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height(context, 24)),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share, color: AppColors.emerald),
                    label: Text(
                      'Share',
                      style: TextStyle(color: AppColors.emerald),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.padding(context, 14),
                      ),
                      side: const BorderSide(color: AppColors.emerald),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.padding(context, 12)),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      'Download',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emerald,
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.padding(context, 14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height(context, 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(
      BuildContext context,
      bool isDark,
      String title,
      List<Widget> children,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: AppColors.emerald,
            ),
          ),
          SizedBox(height: Responsive.height(context, 12)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.padding(context, 6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              color: context.textSecondaryColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                fontWeight: FontWeight.w500,
                color: context.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}