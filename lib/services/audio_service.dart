import 'package:audioplayers/audioplayers.dart';
import 'dart:developer';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache? _audioCache;
  
  // Sound file names
  static const String eatingSoundFile = 'food.mp3';
  static const String directionChangeSoundFile = 'move.mp3';
  static const String collisionSoundFile = 'gameover.mp3';
  
  void loadSounds() {
    _audioCache = AudioCache(prefix: 'assets/audio/');
  }
  
  Future<void> playEatingSound() async {
    await _playSound(eatingSoundFile);
  }
  
  Future<void> playDirectionChangeSound() async {
    await _playSound(directionChangeSoundFile);
  }
  
  Future<void> playCollisionSound() async {
    await _playSound(collisionSoundFile);
  }
  
  Future<void> _playSound(String soundFile) async {
    try {
      if (_audioCache != null) {
        // Use the audio filename directly since the prefix is already set in AudioCache
        await _audioPlayer.play(AssetSource('audio/$soundFile'));
      }
    } catch (e) {
      log('Error playing sound: $e');
    }
  }
  
  void dispose() {
    _audioPlayer.dispose();
  }
}
