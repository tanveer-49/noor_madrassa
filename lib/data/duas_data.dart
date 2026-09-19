// lib/data/duas_data.dart
import '../models/dua_model.dart';

List<Dua> dummyDuas = [
  // MORNING DUAS
  Dua(
    id: '1',
    title: 'Morning Remembrance',
    titleArabic: 'ذكر الصباح',
    arabicText: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ',
    transliteration: 'Allahumma bika asbahna, wa bika amsayna, wa bika nahya, wa bika namutu, wa ilaykan-nushur',
    translation: 'O Allah, by You we enter the morning and by You we enter the evening, by You we live and by You we die, and to You is the final return.',
    reference: 'Tirmidhi 3391',
    category: DuaCategory.morning,
  ),
  Dua(
    id: '2',
    title: 'Morning Protection',
    titleArabic: 'حماية الصباح',
    arabicText: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    transliteration: 'Bismillahil-ladhi la yadurru ma\'asmihi shay\'un fil-ardi wa la fis-sama\'i wa huwas-sami\'ul-\'alim',
    translation: 'In the name of Allah, with whose name nothing can cause harm in the earth nor in the heaven, and He is the All-Hearing, the All-Knowing.',
    reference: 'Abu Dawud 5088',
    category: DuaCategory.morning,
  ),

  // EVENING DUAS
  Dua(
    id: '3',
    title: 'Evening Remembrance',
    titleArabic: 'ذكر المساء',
    arabicText: 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ',
    transliteration: 'Allahumma bika amsayna, wa bika asbahna, wa bika nahya, wa bika namutu, wa ilaykal-masir',
    translation: 'O Allah, by You we enter the evening and by You we enter the morning, by You we live and by You we die, and to You is the final destination.',
    reference: 'Tirmidhi 3391',
    category: DuaCategory.evening,
  ),

  // PRAYER DUAS
  Dua(
    id: '4',
    title: 'Before Prayer',
    titleArabic: 'قبل الصلاة',
    arabicText: 'اللَّهُمَّ بَاعِدْ بَيْنِي وَبَيْنَ خَطَايَايَ كَمَا بَاعَدْتَ بَيْنَ الْمَشْرِقِ وَالْمَغْرِبِ',
    transliteration: 'Allahumma ba\'id bayni wa bayna khatayaya kama ba\'adta baynal-mashriqi wal-maghrib',
    translation: 'O Allah, distance me from my sins as You have distanced the East from the West.',
    reference: 'Bukhari 744',
    category: DuaCategory.prayer,
  ),
  Dua(
    id: '5',
    title: 'After Prayer',
    titleArabic: 'بعد الصلاة',
    arabicText: 'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
    transliteration: 'Allahumma a\'inni \'ala dhikrika wa shukrika wa husni \'ibadatik',
    translation: 'O Allah, help me to remember You, to thank You, and to worship You in the best manner.',
    reference: 'Abu Dawud 1522',
    category: DuaCategory.prayer,
  ),

  // TRAVEL DUAS
  Dua(
    id: '6',
    title: 'Travel Dua',
    titleArabic: 'دعاء السفر',
    arabicText: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
    transliteration: 'Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun',
    translation: 'Glory to Him who has subjected this to us, and we could never have it by our efforts. And indeed, to our Lord we will surely return.',
    reference: 'Muslim 1342',
    category: DuaCategory.travel,
  ),

  // PROTECTION DUAS
  Dua(
    id: '7',
    title: 'Protection from Evil',
    titleArabic: 'الحماية من الشر',
    arabicText: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    transliteration: 'A\'udhu bikalimatillahit-tammati min sharri ma khalaq',
    translation: 'I seek refuge in the perfect words of Allah from the evil of what He has created.',
    reference: 'Muslim 2708',
    category: DuaCategory.protection,
  ),
  Dua(
    id: '8',
    title: 'Protection from Anxiety',
    titleArabic: 'الحماية من الهم',
    arabicText: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ',
    transliteration: 'Allahumma inni a\'udhu bika minal-hammi wal-hazan, wal-\'ajzi wal-kasal',
    translation: 'O Allah, I seek refuge in You from worry and grief, from incapacity and laziness.',
    reference: 'Bukhari 6369',
    category: DuaCategory.protection,
  ),

  // FORGIVENESS DUAS
  Dua(
    id: '9',
    title: 'Seeking Forgiveness',
    titleArabic: 'طلب المغفرة',
    arabicText: 'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
    transliteration: 'Rabbighfir li wa tub \'alayya innaka Antat-Tawwabur-Rahim',
    translation: 'My Lord, forgive me and accept my repentance. Indeed, You are the Accepter of Repentance, the Most Merciful.',
    reference: 'Tirmidhi 3434',
    category: DuaCategory.forgiveness,
  ),
  Dua(
    id: '10',
    title: 'Sayyidul Istighfar',
    titleArabic: 'سيد الاستغفار',
    arabicText: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ',
    transliteration: 'Allahumma Anta Rabbi la ilaha illa Anta, khalaqtani wa ana \'abduk',
    translation: 'O Allah, You are my Lord, there is no deity except You. You created me and I am Your servant.',
    reference: 'Bukhari 6306',
    category: DuaCategory.forgiveness,
  ),

  // GRATITUDE DUAS
  Dua(
    id: '11',
    title: 'Thanking Allah',
    titleArabic: 'شكر الله',
    arabicText: 'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
    transliteration: 'Allahumma a\'inni \'ala dhikrika wa shukrika wa husni \'ibadatik',
    translation: 'O Allah, help me to remember You, to thank You, and to worship You in the best manner.',
    reference: 'Abu Dawud 1522',
    category: DuaCategory.gratitude,
  ),

  // DAILY DUAS
  Dua(
    id: '12',
    title: 'Before Eating',
    titleArabic: 'قبل الطعام',
    arabicText: 'بِسْمِ اللَّهِ وَعَلَى بَرَكَةِ اللَّهِ',
    transliteration: 'Bismillahi wa \'ala barakatillah',
    translation: 'In the name of Allah and with the blessings of Allah.',
    reference: 'Abu Dawud 3767',
    category: DuaCategory.daily,
  ),
  Dua(
    id: '13',
    title: 'After Eating',
    titleArabic: 'بعد الطعام',
    arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
    transliteration: 'Alhamdulillahil-ladhi at\'amana wa saqana wa ja\'alana muslimin',
    translation: 'All praise is due to Allah who has fed us, given us drink, and made us Muslims.',
    reference: 'Tirmidhi 3457',
    category: DuaCategory.daily,
  ),
  Dua(
    id: '14',
    title: 'Before Sleeping',
    titleArabic: 'قبل النوم',
    arabicText: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
    transliteration: 'Bismika Allahumma amutu wa ahya',
    translation: 'In Your name, O Allah, I die and I live.',
    reference: 'Bukhari 6324',
    category: DuaCategory.daily,
  ),
  Dua(
    id: '15',
    title: 'Upon Waking Up',
    titleArabic: 'عند الاستيقاظ',
    arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
    transliteration: 'Alhamdulillahil-ladhi ahyana ba\'da ma amatana wa ilayhin-nushur',
    translation: 'All praise is due to Allah who gave us life after death, and to Him is the return.',
    reference: 'Bukhari 6312',
    category: DuaCategory.daily,
  ),
];

// Get duas by category
List<Dua> getDuasByCategory(DuaCategory? category) {
  if (category == null) return dummyDuas;
  return dummyDuas.where((d) => d.category == category).toList();
}

// Get all categories
List<DuaCategory> getDuaCategories() {
  return DuaCategory.values;
}

// Get favorite duas
List<Dua> getFavoriteDuas() {
  return dummyDuas.where((d) => d.isFavorite).toList();
}