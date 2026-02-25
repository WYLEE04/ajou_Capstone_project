import 'package:flutter/material.dart';
import 'screens/loading_screen.dart'; // 로딩 화면 가져오기

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      title: 'AjouFly',
      home: LoadingScreen(), // 앱 실행 시 로딩 화면으로 시작
    );
  }
}