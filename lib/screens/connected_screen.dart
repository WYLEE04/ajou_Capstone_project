import 'package:flutter/material.dart';

class ConnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('드론 연결됨'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          "드론이 연결되었습니다!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
