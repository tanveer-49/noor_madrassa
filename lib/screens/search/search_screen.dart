// lib/screens/search/search_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/search_data.dart';
import 'package:noor_madrassa/models/search_model.dart';
import 'package:noor_madrassa/services/search_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchService _searchService = Get.put(SearchService());
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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
          'Search',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Field
          _buildSearchField(context, isDark),

          // Content
          Expanded(
            child: Obx(() {
              if (_searchService.currentQuery.value.isEmpty) {
                return _buildInitialContent(context, isDark);
              }

              if (_searchService.isLoading.value) {
                return _buildLoadingState(context, isDark);
              }

              if (_searchService.results.isEmpty) {
                return _buildEmptyState(context, isDark);
              }

              return _buildResults(context, isDark);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, bool isDark) {
    return Container(
      margin: EdgeInsets.all(Responsive.padding(context, 16)),
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        autofocus: true,
        style: TextStyle(
          color: context.textColor,
          fontSize: Responsive.fontSize(context, 15),
        ),
        decoration: InputDecoration(
          hintText: 'Search Qur\'an, Hadith, Books...',
          hintStyle: TextStyle(
            color: context.textSecondaryColor,
            fontSize: Responsive.fontSize(context, 14),
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: context.textSecondaryColor),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: context.textSecondaryColor),
            onPressed: () {
              _searchController.clear();
              _searchService.clearResults();
            },
          )
              : null,
        ),
        onChanged: (value) {
          _searchService.search(value);
          setState(() {});
        },
      ),
    );
  }

  // ✅ Initial Content - Recent + Suggested
  Widget _buildInitialContent(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          Obx(() {
            if (_searchService.recentSearches.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.w600,
                        color: context.textColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _searchService.clearRecentSearches(),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 13),
                          color: AppColors.emerald,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height(context, 8)),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _searchService.recentSearches.map((query) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = query;
                        _searchService.search(query);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.padding(context, 12),
                          vertical: Responsive.padding(context, 8),
                        ),
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.history,
                              size: Responsive.width(context, 14),
                              color: context.textSecondaryColor,
                            ),
                            SizedBox(width: Responsive.padding(context, 6)),
                            Text(
                              query,
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 13),
                                color: context.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: Responsive.height(context, 24)),
              ],
            );
          }),

          // Suggested Topics
          Text(
            'Suggested Topics',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              fontWeight: FontWeight.w600,
              color: context.textColor,
            ),
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestedTopics.map((topic) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = topic;
                  _searchService.search(topic);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 14),
                    vertical: Responsive.padding(context, 8),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.emerald.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    topic,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ✅ Loading State
  Widget _buildLoadingState(BuildContext context, bool isDark) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Responsive.height(context, 12)),
          padding: EdgeInsets.all(Responsive.padding(context, 16)),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Responsive.width(context, 120),
                height: Responsive.height(context, 14),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: Responsive.height(context, 8)),
              Container(
                width: double.infinity,
                height: Responsive.height(context, 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
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
                color: AppColors.emerald.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off,
                size: Responsive.width(context, 50),
                color: AppColors.emerald,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            Text(
              'No Results Found',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              'Try searching with different keywords\nor browse suggested topics',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: ['Qur\'an', 'Hadith', 'Books', 'Duas'].map((topic) {
                return GestureDetector(
                  onTap: () {
                    _searchController.text = topic;
                    _searchService.search(topic);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.padding(context, 14),
                      vertical: Responsive.padding(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      topic,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: AppColors.emerald,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Results
  Widget _buildResults(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Type Filter Tabs
        _buildTypeTabs(context, isDark),

        // Results List
        Expanded(
          child: Obx(() {
            final results = _searchService.results;
            if (results.isEmpty) {
              return _buildEmptyState(context, isDark);
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return _buildResultCard(context, isDark, results[index]);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTypeTabs(BuildContext context, bool isDark) {
    final types = <SearchContentType?>[
      null,
      SearchContentType.quran,
      SearchContentType.hadith,
      SearchContentType.book,
      SearchContentType.dua,
    ];

    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: Responsive.height(context, 12)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          return Obx(() {
            final isSelected = _searchService.selectedType.value == type;
            return GestureDetector(
              onTap: () => _searchService.filterByType(type),
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
                  type?.label ?? 'All',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
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

  Widget _buildResultCard(BuildContext context, bool isDark, SearchResult result) {
    final color = Color(int.parse(result.type.color.replaceFirst('#', 'FF'), radix: 16));

    return GestureDetector(
      onTap: () {
        // Navigate to detail based on type
        _navigateToDetail(context, result);
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
                // Icon
                Container(
                  width: Responsive.width(context, 40),
                  height: Responsive.width(context, 40),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      result.icon,
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
                        result.title,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        result.subtitle,
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
                // Type Badge
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
                    result.type.label,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 10),
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (result.arabicText != null) ...[
              SizedBox(height: Responsive.height(context, 10)),
              Text(
                result.arabicText!,
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
              result.content,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
                color: context.textSecondaryColor,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (result.reference != null) ...[
              SizedBox(height: Responsive.height(context, 6)),
              Text(
                result.reference!,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11),
                  color: AppColors.emerald,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, SearchResult result) {
    // Navigate based on type
    switch (result.type) {
      case SearchContentType.quran:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Qur\'an: ${result.title}')),
        );
        break;
      case SearchContentType.hadith:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Hadith: ${result.title}')),
        );
        break;
      case SearchContentType.book:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Book: ${result.title}')),
        );
        break;
      case SearchContentType.dua:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Dua: ${result.title}')),
        );
        break;
      case SearchContentType.course:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Course: ${result.title}')),
        );
        break;
      case SearchContentType.lesson:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening Lesson: ${result.title}')),
        );
        break;
    }
  }
}