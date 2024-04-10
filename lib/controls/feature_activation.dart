import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'videoplayer.dart';
import 'package:video_player/video_player.dart';

class FeatureActivationPage extends StatefulWidget {
  final String featureName;

  FeatureActivationPage({required this.featureName});

  @override
  _FeatureActivationPageState createState() => _FeatureActivationPageState();
}

class _FeatureActivationPageState extends State<FeatureActivationPage> {
  bool? _isActivated;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    // Simulate feature activation process
    Timer(Duration(seconds: 2), () {
      final isSuccess = _random.nextBool(); // Randomly decide if activation is successful
      setState(() {
        _isActivated = isSuccess;
        if (_isActivated == true) {
          _startVideoTimer(); // Start the timer to navigate to the video screen
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.featureName} Activation'),
      ),
      body: Center(
        child: _isActivated == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Please wait: The feature is initiating'),
                ],
              )
            : _isActivated == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 60),
                      SizedBox(height: 20),
                      Text('Feature Activated', style: TextStyle(fontSize: 24, color: Colors.green)),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 60),
                      SizedBox(height: 20),
                      Text('Feature Failed', style: TextStyle(fontSize: 24, color: Colors.red)),
                    ],
                  ),
      ),
    );
  }

  void _startVideoTimer() {
    // Start a timer to navigate to the video screen after some duration
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VideoScreen()));
    });
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller and set the video file path
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );
    // Initialize the video player
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the video player controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Video Screen'),
      // ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the video player has finished initialization, display the video
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              // Otherwise, display a loading spinner
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Play or pause the video when the FAB is pressed
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
