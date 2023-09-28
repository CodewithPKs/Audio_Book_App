
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'package:just_audio/just_audio.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  //final player = AudioPlayer();
  const AudioFile({Key? key, required this.advancedPlayer, required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {

  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isReapet = false;
  Color color = Colors.black;
  final List<IconData> _icon = [Icons.play_circle_fill, Icons.pause_circle_filled];

  @override
  void initState() {
    super.initState();

    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    widget.advancedPlayer.setSourceUrl(widget.audioPath);

    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if(isReapet== true){
          isPlaying = false;
        } else {
          isPlaying = false;
          isReapet = false;
        }
      });
    });
  }


  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget slider(){
    return Slider(
        value: _position.inSeconds.toDouble(),
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  Widget btnStart() {
    //isPlaying = bool
    return IconButton(
      padding:  const EdgeInsets.only(bottom: 10),
      icon: isPlaying==false?Icon(_icon[0], size: 50, color: Colors.blue,):Icon(_icon[1], size: 50, color: Colors.blue,),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(UrlSource(widget.audioPath));
          setState(() {
            isPlaying = true;
          });
        } else if(isPlaying == true){
          setState(() {
            widget.advancedPlayer.pause();
            isPlaying = false;
          });
        }
      }
    );
  }

  Widget loadAssets(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        btnRepeat(),
        btnSlow(),
        btnStart(),
        btnFast(),
        btnLoop(),
      ],
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: const ImageIcon(
        AssetImage('assets/forward.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: (){
          widget.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: (){
          this.widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: const ImageIcon(
          AssetImage("assets/backword.png"),
          size: 15,
          color: Colors.black,
        )
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: const ImageIcon(
        AssetImage('assets/loop.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: (){

      },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        const AssetImage('assets/repeat.png'),
        size: 15,
        color: color,
      ),
      onPressed: (){
        if(isReapet == false){
          widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isReapet = true;
            color = Colors.blue;
          });
        } else if (isReapet == true){
          widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          color = Colors.black;
          isReapet = false;
          isPlaying= false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split('.')[0],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(_duration.toString().split('.')[0],
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          slider(),
          loadAssets(),
        ],
      ),
    );
  }
}
