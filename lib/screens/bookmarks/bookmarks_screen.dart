// lib/screens/bookmarks/bookmarks_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/bookmark_model.dart';
import 'package:noor_madrassa/services/bookmark_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final BookmarkService _bookmarkService = Get.put(BookmarkService());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 60),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bookmarks',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: context.textColor),
            onPressed: () {
              // Search in bookmarks
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Folder Chips
          _buildFolderChips(context, isDark),

          // Bookmarks List
          Expanded(
            child: Obx(() {
              final bookmarks = _bookmarkService.getFilteredBookmarks();
              if (bookmarks.isEmpty) {
                return _buildEmptyState(context, isDark);
              }
              return _buildBookmarksList(context, isDark, bookmarks);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFolderChips(BuildContext context, bool isDark) {
    final folders = _bookmarkService.getFolders();

    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: Responsive.height(context, 8)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return Obx(() {
            final isSelected = _bookmarkService.selectedFolder.value == folder;
            return GestureDetector(
              onTap: () => _bookmarkService.filterByFolder(folder),
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
                        : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                  ),
                ),
                child: Text(
                  folder,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 13),
                    color: isSelected ? Colors.white : context.textSecondaryColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildBookmarksList(BuildContext context, bool isDark, List<Bookmark> bookmarks) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        return _buildBookmarkCard(context, isDark, bookmarks[index]);
      },
    );
  }

  Widget _buildBookmarkCard(BuildContext context, bool isDark, Bookmark bookmark) {
    final color = _getColorForType(bookmark.type);

    return GestureDetector(
      onTap: () {
        // Navigate to detail
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening: ${bookmark.title}')),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Responsive.height(context, 12)),
        padding: EdgeInsets.all(Responsive.padding(context, 14)),
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
            Row(
              children: [
                // Type Icon
                Container(
                  width: Responsive.width(context, 40),
                  height: Responsive.width(context, 40),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      bookmark.icon,
                      style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.padding(context, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookmark.title,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        bookmark.subtitle,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
                          color: context.textSecondaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Delete Button
                IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: AppColors.islamicGold,
                    size: Responsive.width(context, 22),
                  ),
                  onPressed: () {
                    _bookmarkService.removeBookmark(bookmark.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bookmark removed')),
                    );
                  },
                ),
              ],
            ),
            if (bookmark.arabicText != null) ...[
              SizedBox(height: Responsive.height(context, 10)),
              Text(
                bookmark.arabicText!,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 18),
                  fontFamily: 'Uthmanic',
                  color: context.textColor,
                  height: 1.6,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              bookmark.content,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
                color: context.textSecondaryColor,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 8),
                    vertical: Responsive.padding(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    bookmark.type.label,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 10),
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _formatDate(bookmark.savedAt),
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 10),
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Empty State
  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.padding(context, 32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Responsive.width(context, 100),
              height: Responsive.width(context, 100),
              decoration: BoxDecoration(
                color: AppColors.islamicGold.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_border,
                size: Responsive.width(context, 50),
                color: AppColors.islamicGold,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            Text(
              'No Bookmarks Yet',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              'Save your favorite Qur\'an verses,\nHadith, and books here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.emerald,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 24),
                  vertical: Responsive.padding(context, 12),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Reading',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForType(BookmarkType type) {
    switch (type) {
      case BookmarkType.quran:
        return AppColors.emerald;
      case BookmarkType.hadith:
        return AppColors.softEmerald;
      case BookmarkType.book:
        return AppColors.islamicGold;
      case BookmarkType.dua:
        return const Color(0xFF8B6B3D);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}