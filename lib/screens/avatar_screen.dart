import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  // In a complete app, this level value would be computed based on user performance.
  final int avatarLevel = 3;

  String _getAvatarAsset() {
    // Return the asset path for the current level.
    return 'assets/avatars/avatar_level_$avatarLevel.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Avatar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getAvatarAsset(),
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text('Level $avatarLevel Avatar'),
            // Optionally add progress details here.
          ],
        ),
      ),
    );
  }
}
