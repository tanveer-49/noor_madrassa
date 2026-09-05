// lib/screens/library/books_home_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/books_data.dart';
import 'package:noor_madrassa/models/book_model.dart';
import 'package:noor_madrassa/screens/library/book_reader_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class BooksHomeScreen extends StatefulWidget {
  const BooksHomeScreen({super.key});

  @override
  State<BooksHomeScreen> createState() => _BooksHomeScreenState();
}

class _BooksHomeScreenState extends State<BooksHomeScreen> {
  String _selectedCategory = 'All';
  List<Book> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _filteredBooks = dummyBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Islamic Library',
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
          // Category Chips
          _buildCategoryChips(context),

          const SizedBox(height: 16),

          // Featured Books -
          _buildFeaturedBooks(context),

          const SizedBox(height: 16),

          // All Books Grid -
          Expanded(
            child: _buildBooksGrid(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final categories = getCategories();
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                if (category == 'All') {
                  _filteredBooks = dummyBooks;
                } else {
                  _filteredBooks = dummyBooks
                      .where((book) => book.category == category)
                      .toList();
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.emerald : context.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.emerald : Colors.grey.shade300,
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : context.textSecondaryColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedBooks(BuildContext context) {
    final featuredBooks = dummyBooks.take(2).toList();
    return SizedBox(
      height: Responsive.height(context, 160),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: featuredBooks.length,
        itemBuilder: (context, index) {
          final book = featuredBooks[index];
          return _buildFeaturedBookCard(context, book);
        },
      ),
    );
  }


  Widget _buildFeaturedBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookReaderScreen(book: book),
          ),
        );
      },
      child: Container(
        width: Responsive.width(context, 280),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              width: Responsive.width(context, 60),
              height: Responsive.height(context, 80),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  book.icon,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 32)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      book.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  if (book.progress > 0) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: book.progress,
                        minHeight: 4,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(book.progress * 100).toInt()}% read',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBooksGrid(BuildContext context) {
    if (_filteredBooks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.library_books,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'No books in this category',
              style: TextStyle(
                fontSize: 16,
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.gridColumns(context),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: _filteredBooks.length,
      itemBuilder: (context, index) {
        final book = _filteredBooks[index];
        return _buildBookCard(context, book);
      },
    );
  }

  Widget _buildBookCard(BuildContext context, Book book) {

    final color = Color(int.parse(book.coverColor.replaceFirst('#', 'FF'), radix: 16));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookReaderScreen(book: book),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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

            Container(
              height: Responsive.height(context, 80),
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
                  book.icon,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 36)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                fontWeight: FontWeight.w600,
                color: context.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              book.author,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 11),
                color: context.textSecondaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? AppColors.darkCard : AppColors.lightMint,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    book.category,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 9),
                      color: AppColors.emerald,
                    ),
                  ),
                ),
                if (book.progress > 0)
                  Text(
                    '${(book.progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 10),
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
            if (book.progress > 0) ...[
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: book.progress,
                  minHeight: 3,
                  backgroundColor: context.isDarkMode ? AppColors.darkCard : Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emerald),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}