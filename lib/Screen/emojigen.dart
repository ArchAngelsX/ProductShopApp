import 'dart:math';

import 'package:flutter/material.dart';

class EmojiGenerator extends StatefulWidget {
  const EmojiGenerator({super.key});

  @override
  State<EmojiGenerator> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmojiGenerator> {
  final List<String> _emojiList = [
  '😂',
  '😘',
  '😎',
  '💋',
  '🎂',
  '👻',
  '🤢',
  '😍', 
  '🥳', 
  '🤖', 
  '🐶', 
  '🌈', 
  '🍕', 
  '🎉', 
  '💖', 
  '✨', 
  '🌟', 
  '🍀', 
  '🎈', 
  '🦄', 
  '🐱', 
  '🍩', 
  '🌻', 
  '🌊', 
  '🚀', 
  '🎶', 
  '🧁', 
  '🔥', 
  '👑', 
  '🦋', 
  '🍉', 
  '🍓', 
  '🌼', 
  '⚡', 
];
    final Random _random = Random();
    List<String> _randomEmoji = [];

    void _generateRandomEmoji() {
      setState(() {
        _randomEmoji = List.generate(1, (index) => _emojiList[_random.nextInt(_emojiList.length)]);

      });
    }

  @override
  void initState() {
    _generateRandomEmoji();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _randomEmoji.map(
                (emoji)=>Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 100.0,
                  ),
                  )).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                _generateRandomEmoji();
              }  ,
              child: Text('Generate Random Emoji'),
              )
          ],
        )
      ),
    );
  }
}