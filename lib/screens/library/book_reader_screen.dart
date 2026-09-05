// lib/screens/library/book_reader_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/book_model.dart';
import 'package:noor_madrassa/utils/responsive.dart';

class BookReaderScreen extends StatefulWidget {
  final Book book;

  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  double _fontSize = 16;
  bool _isBookmarked = false;
  int _currentChapterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: Text(
          widget.book.title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
          ),
        ),
        backgroundColor: AppColors.warmCream,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? AppColors.islamicGold : null,
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Book Info Bar
          _buildBookInfoBar(),

          const Divider(height: 1),

          // Reader Controls
          _buildReaderControls(),

          const Divider(height: 1),

          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookInfoBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padding(context, 16),
        vertical: Responsive.padding(context, 8),
      ),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.book.title,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepForest,
                ),
              ),
              Text(
                widget.book.author,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 12),
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.lightMint,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${widget.book.currentPage}/${widget.book.pages}',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                color: AppColors.emerald,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReaderControls() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padding(context, 16),
        vertical: Responsive.padding(context, 8),
      ),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Font Size
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove, size: Responsive.width(context, 20)),
                onPressed: () {
                  setState(() {
                    if (_fontSize > 12) _fontSize -= 1;
                  });
                },
              ),
              Text(
                '${_fontSize.toInt()}',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, size: Responsive.width(context, 20)),
                onPressed: () {
                  setState(() {
                    if (_fontSize < 24) _fontSize += 1;
                  });
                },
              ),
            ],
          ),

          Container(height: 30, width: 1, color: Colors.grey.shade300),

          // Chapters
          GestureDetector(
            onTap: () {
              _showChaptersDialog();
            },
            child: Row(
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: Responsive.width(context, 20),
                  color: AppColors.emerald,
                ),
                const SizedBox(width: 4),
                Text(
                  'Chapters',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: AppColors.emerald,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final chapters = widget.book.chapters;
    final content = chapters.isNotEmpty
        ? chapters[_currentChapterIndex % chapters.length]
        : 'No content available for this book.';

    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.padding(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chapters.isNotEmpty) ...[
            Text(
              chapters[_currentChapterIndex % chapters.length],
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: AppColors.deepForest,
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Placeholder content
          Text(
            _getDummyContent(),
            style: TextStyle(
              fontSize: Responsive.fontSize(context, _fontSize),
              color: AppColors.textPrimary,
              height: 1.8,
            ),
          ),

          const SizedBox(height: 30),

          // Continue/Next Button
          if (chapters.isNotEmpty && _currentChapterIndex < chapters.length - 1)
            _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _currentChapterIndex++;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.emerald,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.padding(context, 40),
            vertical: Responsive.padding(context, 12),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Next Chapter →',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _showChaptersDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: Responsive.height(context, 400),
          padding: EdgeInsets.all(Responsive.padding(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chapters',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.book.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = widget.book.chapters[index];
                    final isCurrent = index == _currentChapterIndex;
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(
                        chapter,
                        style: TextStyle(
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          color: isCurrent ? AppColors.emerald : null,
                        ),
                      ),
                      trailing: isCurrent
                          ? const Icon(Icons.check_circle, color: AppColors.emerald)
                          : null,
                      onTap: () {
                        setState(() {
                          _currentChapterIndex = index;
                        });
                        Navigator.pop(context);
                      },
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

  String _getDummyContent() {
    return '''
In the name of Allah, the Most Gracious, the Most Merciful.

All praise is due to Allah, Lord of the worlds. The Most Gracious, the Most Merciful. Master of the Day of Judgment. You alone we worship, and You alone we ask for help. Guide us to the straight path. The path of those upon whom You have bestowed favor, not of those who have evoked Your anger or of those who are astray.

This is a book of guidance for the righteous. Those who believe in the unseen, establish prayer, and spend from what We have provided for them. And those who believe in what has been revealed to you and what was revealed before you, and of the Hereafter they are certain.

These are the ones who are on guidance from their Lord, and they are the successful ones.

Indeed, those who disbelieve - it is all the same for them whether you warn them or do not warn them - they will not believe. Allah has sealed their hearts and their hearing, and over their vision is a veil. And for them is a great punishment.

And of the people are some who say, "We believe in Allah and the Last Day," but they are not believers. They seek to deceive Allah and those who believe, but they deceive not except themselves and perceive not.

In their hearts is disease, so Allah has increased their disease, and for them is a painful punishment because they used to lie.

And when it is said to them, "Do not cause corruption on the earth," they say, "We are only reformers." Unquestionably, they are the corrupters, but they perceive not.

And when it is said to them, "Believe as the people have believed," they say, "Should we believe as the foolish have believed?" Unquestionably, it is they who are the foolish, but they know not.

And when they meet those who believe, they say, "We believe"; but when they are alone with their evil ones, they say, "Indeed, we are with you; we were only mockers."

Allah mocks them and prolongs them in their transgression while they wander blindly.

Those are the ones who have purchased error with guidance, so their transaction has brought no profit, and they were not guided.
''';
  }
}