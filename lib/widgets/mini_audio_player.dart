// lib/widgets/mini_audio_player.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/services/audio_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';  // ✅ Added
import 'package:noor_madrassa/screens/audio/audio_player_screen.dart';

class MiniAudioPlayer extends StatelessWidget {
  const MiniAudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final audioService = Get.find<AudioService>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final track = audioService.currentTrack.value;

      if (track == null) {
        return const SizedBox.shrink();
      }

      return GestureDetector(
        onTap: () {
          Get.to(() => AudioPlayerScreen(track: track));
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Responsive.padding(context, 12),
            vertical: Responsive.padding(context, 8),
          ),
          padding: EdgeInsets.all(Responsive.padding(context, 12)),
          decoration: BoxDecoration(
            gradient: AppGradients.primaryGradient,  // ✅ Now imported
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.emerald.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Album Art
                  Container(
                    width: Responsive.width(context, 44),
                    height: Responsive.width(context, 44),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        track.titleArabic,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 18),
                          fontFamily: 'Uthmanic',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Track Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          track.title,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          track.reciter,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 11),
                            color: Colors.white70,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Play/Pause
                  IconButton(
                    icon: Icon(
                      audioService.isPlaying.value ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: Responsive.width(context, 28),
                    ),
                    onPressed: () => audioService.togglePlayPause(),
                  ),

                  // Close
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white70,
                      size: Responsive.width(context, 20),
                    ),
                    onPressed: () => audioService.stop(),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Progress Bar
              Obx(() {
                final position = audioService.currentPosition.value;
                final duration = audioService.totalDuration.value;
                final progress = duration.inSeconds > 0
                    ? position.inSeconds / duration.inSeconds
                    : 0.0;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 3,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}