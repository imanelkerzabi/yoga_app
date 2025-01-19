import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({Key? key}) : super(key: key);

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late VideoPlayerController _videoController;
  late Timer _timer;
  int _secondsElapsed = 0;
  bool _isPaused = false;
  final int _totalDuration = 13 * 60; // 13 minutes

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/yoga_session.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      }).catchError((error) {
        print('Error loading video: $error');
      });
    _videoController.setLooping(true);
    _startTimer();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _secondsElapsed < _totalDuration) {
        setState(() {
          _secondsElapsed++;
        });
      } else if (_secondsElapsed >= _totalDuration) {
        _endSession(autoEnd: true);
      }
    });
  }


  Future<void> _endSession({bool autoEnd = false}) async {
    if (!autoEnd) {
      final shouldEnd = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('End Session'),
            content: const Text('Are you sure you want to end this session?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('End'),
              ),
            ],
          );
        },
      );
      if (shouldEnd != true) return;
    }

    Navigator.pop(context, {
      'duration': _secondsElapsed,
      'calories': _calculateCaloriesBurned(),
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  int _calculateCaloriesBurned() {
    const caloriesPerMinute = 8;
    return (_secondsElapsed ~/ 60) * caloriesPerMinute;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Session'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      body: Center(
        child: _videoController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _formatTime(_secondsElapsed),
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: _secondsElapsed / _totalDuration,
                    color: const Color(0xFF6C63FF),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
