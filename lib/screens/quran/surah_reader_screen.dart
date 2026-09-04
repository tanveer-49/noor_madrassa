// lib/screens/quran/surah_reader_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/quran_data.dart';
import 'package:noor_madrassa/models/surah_model.dart';
import 'package:noor_madrassa/models/verse_model.dart';

class SurahReaderScreen extends StatefulWidget {
  final Surah surah;

  const SurahReaderScreen({super.key, required this.surah});

  @override
  State<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends State<SurahReaderScreen> {
  double _fontSize = 22;
  bool _showTranslation = true;
  List<Verse> verses = [];

  @override
  void initState() {
    super.initState();
    // Filter verses for this surah
    verses = dummyVerses.where((v) => v.surahId == widget.surah.id).toList();
    if (verses.isEmpty) {
      // If no verses found, show some dummy data for Al-Kahf
      verses = _getDummyVersesForSurah();
    }
  }

  List<Verse> _getDummyVersesForSurah() {
    // For demo purposes, if surah is Al-Kahf
    if (widget.surah.id == 18) {
      return [
        Verse(
          id: 1,
          surahId: 18,
          verseNumber: 1,
          arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَنْزَلَ عَلَىٰ عَبْدِهِ الْكِتَابَ وَلَمْ يَجْعَلْ لَهُ عِوَجًا',
          translation: 'All praise is due to Allah who revealed the Book to His servant and did not make in it any crookedness.',
          transliteration: 'Alhamdu lillahil-ladhi anzala \'ala \'abdihil-kitaba wa lam yaj\'al lahu \'iwaja',
        ),
        Verse(
          id: 2,
          surahId: 18,
          verseNumber: 2,
          arabicText: 'قَيِّمًا لِيُنْذِرَ بَأْسًا شَدِيدًا مِنْ لَدُنْهُ وَيُبَشِّرَ الْمُؤْمِنِينَ الَّذِينَ يَعْمَلُونَ الصَّالِحَاتِ أَنَّ لَهُمْ أَجْرًا حَسَنًا',
          translation: 'That He may warn of severe punishment from Him and give good tidings to the believers who do righteous deeds that they will have a good reward.',
          transliteration: 'Qayyimal liyundhira ba\'san shadidan min ladunhu wa yubashshiral-mu\'mininal-ladhina ya\'malunas-salihati anna lahum ajran hasana',
        ),
        Verse(
          id: 3,
          surahId: 18,
          verseNumber: 23,
          arabicText: 'وَلَا تَقُولَنَّ لِشَيْءٍ إِنِّي فَاعِلٌ ذَٰلِكَ غَدًا',
          translation: 'And never say about anything, "I will do that tomorrow,"',
          transliteration: 'Wa la taqulanna lishay\'in inni fa\'ilun dhalika ghada',
        ),
      ];
    }
    return dummyVerses.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.surah.nameArabic,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              widget.surah.nameEnglish,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.warmCream,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // Bookmark surah
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share surah
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showReaderSettings();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Reader Controls
          _buildReaderControls(),

          const Divider(height: 1),

          // Verses
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: verses.length,
              itemBuilder: (context, index) {
                final verse = verses[index];
                return _buildVerseCard(verse);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReaderControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Font Size Control
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 20),
                onPressed: () {
                  setState(() {
                    if (_fontSize > 16) _fontSize -= 2;
                  });
                },
              ),
              Text(
                '${_fontSize.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: () {
                  setState(() {
                    if (_fontSize < 32) _fontSize += 2;
                  });
                },
              ),
            ],
          ),

          Container(height: 30, width: 1, color: Colors.grey[300]),

          // Toggle Translation
          GestureDetector(
            onTap: () {
              setState(() {
                _showTranslation = !_showTranslation;
              });
            },
            child: Row(
              children: [
                Icon(
                  _showTranslation ? Icons.translate : Icons.translate_outlined,
                  color: _showTranslation ? AppColors.emerald : AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Translation',
                  style: TextStyle(
                    color: _showTranslation ? AppColors.emerald : AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(height: 30, width: 1, color: Colors.grey[300]),

          // Audio
          GestureDetector(
            onTap: () {
              // Play audio
            },
            child: const Row(
              children: [
                Icon(Icons.play_circle_outline, color: AppColors.emerald),
                SizedBox(width: 4),
                Text(
                  'Audio',
                  style: TextStyle(
                    color: AppColors.emerald,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseCard(Verse verse) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Verse Number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightMint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${verse.verseNumber}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.emerald,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.bookmark_border, size: 20),
                    onPressed: () {
                      // Bookmark verse
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, size: 20),
                    onPressed: () {
                      // Share verse
                    },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Arabic Text
          Text(
            verse.arabicText,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: _fontSize,
              fontFamily: 'Uthmanic',
              color: AppColors.deepForest,
              height: 2.0,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 12),

          // Translation
          if (_showTranslation) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightMint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    verse.translation,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    verse.transliteration,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showReaderSettings() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reader Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Font Size
              const Text('Font Size'),
              Slider(
                value: _fontSize,
                min: 16,
                max: 32,
                divisions: 8,
                label: _fontSize.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Translation Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Show Translation'),
                  Switch(
                    value: _showTranslation,
                    onChanged: (value) {
                      setState(() {
                        _showTranslation = value;
                      });
                    },
                    activeColor: AppColors.emerald,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppColors.emerald),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emerald,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}