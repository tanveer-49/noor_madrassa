// lib/services/audio_service.dart
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../models/audio_model.dart';

class AudioService extends GetxService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final Rx<AudioTrack?> currentTrack = Rx<AudioTrack?>(null);
  final RxBool isPlaying = false.obs;
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final RxDouble playbackSpeed = 1.0.obs;
  final RxList<AudioTrack> queue = <AudioTrack>[].obs;
  final RxInt currentIndex = 0.obs;

  AudioPlayer get player => _audioPlayer;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
      }
    });
  }

  Future<void> playTrack(AudioTrack track, {List<AudioTrack>? playlist}) async {
    try {
      if (playlist != null) {
        queue.value = playlist;
        currentIndex.value = playlist.indexWhere((t) => t.id == track.id);
      }

      currentTrack.value = track;

      // For demo, we'll simulate playback since we don't have real audio URLs
      // In production, use: await _audioPlayer.setUrl(track.audioUrl);

      // Simulate total duration
      totalDuration.value = track.duration;

      // Start simulated playback
      await _audioPlayer.play();
      isPlaying.value = true;

      // Simulate position updates
      _simulatePlayback();
    } catch (e) {
      Get.snackbar('Error', 'Could not play audio: $e');
    }
  }

  void _simulatePlayback() {
    // Simulate position updates for demo
    Future.delayed(const Duration(seconds: 1), () {
      if (isPlaying.value && currentTrack.value != null) {
        currentPosition.value = currentPosition.value + const Duration(seconds: 1);
        if (currentPosition.value < totalDuration.value) {
          _simulatePlayback();
        }
      }
    });
  }

  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await _audioPlayer.pause();
      isPlaying.value = false;
    } else {
      await _audioPlayer.play();
      isPlaying.value = true;
      _simulatePlayback();
    }
  }

  Future<void> seekForward() async {
    final newPosition = currentPosition.value + const Duration(seconds: 15);
    if (newPosition < totalDuration.value) {
      currentPosition.value = newPosition;
      await _audioPlayer.seek(newPosition);
    }
  }

  Future<void> seekBackward() async {
    final newPosition = currentPosition.value - const Duration(seconds: 15);
    if (newPosition > Duration.zero) {
      currentPosition.value = newPosition;
      await _audioPlayer.seek(newPosition);
    } else {
      currentPosition.value = Duration.zero;
      await _audioPlayer.seek(Duration.zero);
    }
  }

  Future<void> seekTo(Duration position) async {
    currentPosition.value = position;
    await _audioPlayer.seek(position);
  }

  Future<void> setSpeed(double speed) async {
    playbackSpeed.value = speed;
    await _audioPlayer.setSpeed(speed);
  }

  Future<void> playNext() async {
    if (queue.isEmpty) return;

    if (currentIndex.value < queue.length - 1) {
      currentIndex.value++;
      await playTrack(queue[currentIndex.value]);
    }
  }

  Future<void> playPrevious() async {
    if (queue.isEmpty) return;

    if (currentIndex.value > 0) {
      currentIndex.value--;
      await playTrack(queue[currentIndex.value]);
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    currentTrack.value = null;
    currentPosition.value = Duration.zero;
    totalDuration.value = Duration.zero;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}