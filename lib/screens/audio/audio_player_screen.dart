// lib/screens/audio/audio_player_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/audio_model.dart';
import 'package:noor_madrassa/services/audio_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class AudioPlayerScreen extends StatelessWidget {
  final AudioTrack track;

  const AudioPlayerScreen({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final audioService = Get.find<AudioService>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (audioService.currentTrack.value?.id != track.id) {
        audioService.playTrack(track);
      }
    });

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.warmCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? AppColors.white : AppColors.textPrimary,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Now Playing',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
            color: isDark ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(  // ✅ Added to prevent overflow
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Album Art
                _buildAlbumArt(context, isDark),

                const SizedBox(height: 30),

                // Track Info
                _buildTrackInfo(context, isDark),

                const SizedBox(height: 30),

                // Progress Bar
                _buildProgressBar(context, isDark, audioService),

                const SizedBox(height: 20),

                // Controls
                _buildControls(context, isDark, audioService),

                const SizedBox(height: 24),

                // ✅ Speed Control - Fully Responsive
                _buildSpeedControl(context, isDark, audioService),

                const SizedBox(height: 24),

                // Queue Button
                _buildQueueButton(context, isDark),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumArt(BuildContext context, bool isDark) {
    // ✅ Responsive size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final artSize = screenWidth * 0.6; // 60% of screen width
    final maxArtSize = 250.0;
    final finalSize = artSize > maxArtSize ? maxArtSize : artSize;

    return Container(
      width: finalSize,
      height: finalSize,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.4),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            track.titleArabic,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 42),
              fontFamily: 'Uthmanic',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            track.title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackInfo(BuildContext context, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 24)),
      child: Column(
        children: [
          Text(
            track.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 22),
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            track.reciter,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, bool isDark, AudioService audioService) {
    return Obx(() {
      final position = audioService.currentPosition.value;
      final duration = audioService.totalDuration.value;

      final maxValue = duration.inSeconds.toDouble();
      final currentValue = position.inSeconds.toDouble().clamp(0.0, maxValue > 0 ? maxValue : 1.0);

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 20)),
        child: Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.emerald,
                inactiveTrackColor: isDark ? AppColors.darkCard : Colors.grey.shade300,
                thumbColor: AppColors.emerald,
                overlayColor: AppColors.emerald.withOpacity(0.2),
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                value: currentValue,
                max: maxValue > 0 ? maxValue : 1.0,
                onChanged: (value) {
                  audioService.seekTo(Duration(seconds: value.toInt()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    audioService.formatDuration(position),
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    audioService.formatDuration(duration),
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildControls(BuildContext context, bool isDark, AudioService audioService) {
    // ✅ Responsive button sizes
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;

    final bigButtonSize = isSmall ? 60.0 : 70.0;
    final smallButtonSize = isSmall ? 28.0 : 36.0;
    final mediumButtonSize = isSmall ? 26.0 : 32.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Previous
          IconButton(
            icon: Icon(
              Icons.skip_previous,
              size: smallButtonSize,
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
            onPressed: () => audioService.playPrevious(),
          ),

          // Backward 15s
          IconButton(
            icon: Icon(
              Icons.replay_10,
              size: mediumButtonSize,
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
            onPressed: () => audioService.seekBackward(),
          ),

          // Play/Pause
          Obx(() => GestureDetector(
            onTap: () => audioService.togglePlayPause(),
            child: Container(
              width: bigButtonSize,
              height: bigButtonSize,
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emerald.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                audioService.isPlaying.value ? Icons.pause : Icons.play_arrow,
                size: bigButtonSize * 0.5,
                color: Colors.white,
              ),
            ),
          )),

          // Forward 15s
          IconButton(
            icon: Icon(
              Icons.forward_10,
              size: mediumButtonSize,
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
            onPressed: () => audioService.seekForward(),
          ),

          // Next
          IconButton(
            icon: Icon(
              Icons.skip_next,
              size: smallButtonSize,
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
            onPressed: () => audioService.playNext(),
          ),
        ],
      ),
    );
  }

  // ✅ FULLY RESPONSIVE SPEED CONTROL - No Overflow
  Widget _buildSpeedControl(BuildContext context, bool isDark, AudioService audioService) {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Speed Label
          Padding(
            padding: EdgeInsets.only(left: Responsive.padding(context, 4), bottom: 8),
            child: Text(
              'Playback Speed',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Speed Buttons - Wrap instead of Row
          Wrap(
            spacing: isSmall ? 4 : 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: speeds.map((speed) {
              return Obx(() {
                final isSelected = audioService.playbackSpeed.value == speed;
                return GestureDetector(
                  onTap: () => audioService.setSpeed(speed),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? 8 : 12,
                      vertical: isSmall ? 5 : 7,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.emerald : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.emerald
                            : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${speed}x',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, isSmall ? 10 : 12),
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.grey.shade400 : AppColors.textSecondary),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueButton(BuildContext context, bool isDark) {
    return TextButton.icon(
      onPressed: () => _showQueueSheet(context, isDark),
      icon: Icon(
        Icons.queue_music,
        color: isDark ? AppColors.white : AppColors.textPrimary,
      ),
      label: Text(
        'View Queue',
        style: TextStyle(
          color: isDark ? AppColors.white : AppColors.textPrimary,
        ),
      ),
    );
  }

  void _showQueueSheet(BuildContext context, bool isDark) {
    final audioService = Get.find<AudioService>();

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(Responsive.padding(context, 20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Queue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No tracks in queue',
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}