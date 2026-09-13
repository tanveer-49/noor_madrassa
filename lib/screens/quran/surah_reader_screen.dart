// lib/screens/quran/surah_reader_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/quran_data.dart';
import 'package:noor_madrassa/models/surah_model.dart';
import 'package:noor_madrassa/models/verse_model.dart';
import 'package:noor_madrassa/models/audio_model.dart';  // ✅ Added
import 'package:noor_madrassa/screens/audio/audio_player_screen.dart';  // ✅ Added
import 'package:noor_madrassa/utils/theme_extensions.dart';  // ✅ Added

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
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,  // ✅ Dynamic
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.surah.nameArabic,
              style: TextStyle(
                fontSize: 18,
                color: context.textColor,  // ✅ Dynamic
              ),
            ),
            Text(
              widget.surah.nameEnglish,
              style: TextStyle(
                fontSize: 12,
                color: context.textSecondaryColor,  // ✅ Dynamic
              ),
            ),
          ],
        ),
        backgroundColor: context.backgroundColor,  // ✅ Dynamic
        elevation: 0,
        iconTheme: IconThemeData(color: context.textColor),  // ✅ Dynamic
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
              _showReaderSettings(context, isDark);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Reader Controls
          _buildReaderControls(context, isDark),

          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),

          // Verses
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: verses.length,
              itemBuilder: (context, index) {
                final verse = verses[index];
                return _buildVerseCard(context, isDark, verse);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReaderControls(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isDark ? AppColors.darkCard : AppColors.white,  // ✅ Dynamic
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Font Size Control
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 20,
                  color: context.textColor,  // ✅ Dynamic
                ),
                onPressed: () {
                  setState(() {
                    if (_fontSize > 16) _fontSize -= 2;
                  });
                },
              ),
              Text(
                '${_fontSize.toInt()}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: context.textColor,  // ✅ Dynamic
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: context.textColor,  // ✅ Dynamic
                ),
                onPressed: () {
                  setState(() {
                    if (_fontSize < 32) _fontSize += 2;
                  });
                },
              ),
            ],
          ),

          Container(
            height: 30,
            width: 1,
            color: isDark ? Colors.grey.shade700 : Colors.grey[300],
          ),

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
                  color: _showTranslation
                      ? AppColors.emerald
                      : context.textSecondaryColor,  // ✅ Dynamic
                ),
                const SizedBox(width: 4),
                Text(
                  'Translation',
                  style: TextStyle(
                    color: _showTranslation
                        ? AppColors.emerald
                        : context.textSecondaryColor,  // ✅ Dynamic
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 30,
            width: 1,
            color: isDark ? Colors.grey.shade700 : Colors.grey[300],
          ),

          // ✅ Audio - Working
          GestureDetector(
            onTap: () {
              _playAudio(context);
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

  // ✅ Play Audio Function
  void _playAudio(BuildContext context) {
    // Create audio track from surah
    final track = AudioTrack(
      id: widget.surah.id.toString(),
      title: widget.surah.nameEnglish,
      titleArabic: widget.surah.nameArabic,
      reciter: 'Mishary Rashid Alafasy',
      reciterArabic: 'مشاري راشد العفاسي',
      surahName: widget.surah.nameEnglish,
      surahNumber: widget.surah.id,
      audioUrl: 'https://example.com/audio/${widget.surah.id}.mp3',
      duration: Duration(minutes: 5 + widget.surah.id),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioPlayerScreen(track: track),
      ),
    );
  }

  Widget _buildVerseCard(BuildContext context, bool isDark, Verse verse) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.white,  // ✅ Dynamic
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
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
                  color: isDark ? AppColors.darkBackground : AppColors.lightMint,  // ✅ Dynamic
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
                    icon: Icon(
                      Icons.bookmark_border,
                      size: 20,
                      color: context.textSecondaryColor,  // ✅ Dynamic
                    ),
                    onPressed: () {
                      // Bookmark verse
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 20,
                      color: context.textSecondaryColor,  // ✅ Dynamic
                    ),
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
              color: isDark ? AppColors.white : AppColors.deepForest,  // ✅ Dynamic
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
                color: isDark ? AppColors.darkBackground : AppColors.lightMint,  // ✅ Dynamic
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    verse.translation,
                    style: TextStyle(
                      fontSize: 15,
                      color: context.textColor,  // ✅ Dynamic
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    verse.transliteration,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textSecondaryColor,  // ✅ Dynamic
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

  void _showReaderSettings(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.white,  // ✅ Dynamic
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reader Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.textColor,  // ✅ Dynamic
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Font Size
                  Text(
                    'Font Size',
                    style: TextStyle(
                      color: context.textColor,  // ✅ Dynamic
                    ),
                  ),
                  Slider(
                    value: _fontSize,
                    min: 16,
                    max: 32,
                    divisions: 8,
                    label: _fontSize.toInt().toString(),
                    activeColor: AppColors.emerald,
                    onChanged: (value) {
                      setModalState(() {
                        _fontSize = value;
                      });
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  // Translation Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Translation',
                        style: TextStyle(
                          color: context.textColor,  // ✅ Dynamic
                        ),
                      ),
                      Switch(
                        value: _showTranslation,
                        onChanged: (value) {
                          setModalState(() {
                            _showTranslation = value;
                          });
                          setState(() {});
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
      },
    );
  }
}