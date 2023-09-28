import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Colors/colors.dart' as AppColors;

import '../Audio_File/audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({Key? key, this.booksData, required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {

  late AudioPlayer advandcePlayer;
  @override
  void initState(){
    super.initState();
    advandcePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight/3,
              child: Container(
                color: AppColors.audioBlueBackground,
           )
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    advandcePlayer.stop();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  IconButton(
                    onPressed: () { },
                    icon: Icon(Icons.search_outlined),
                  ),
                ],
              )
          ),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight*0.2,
              height: screenHeight*0.36,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.1,),
                    Text(this.widget.booksData[this.widget.index]["title"],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir"
                      ),
                    ),
                    Text(this.widget.booksData[this.widget.index]["text"],
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Avenir"
                      ),
                    ),
                    AudioFile(advancedPlayer: advandcePlayer, audioPath : this.widget.booksData[this.widget.index]["audio"]),
                  ],
                ),
              )
          ),
          Positioned(
            top: screenHeight*0.12,
              left: (screenWidth-150)/2,
              right: (screenWidth-150)/2,
              child: Container(
                height: screenHeight*0.16,
                decoration: BoxDecoration(
                    color: AppColors.audioGreyBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2)
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                       // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      image: DecorationImage(
                        image: AssetImage(this.widget.booksData[this.widget.index]["img"],),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
