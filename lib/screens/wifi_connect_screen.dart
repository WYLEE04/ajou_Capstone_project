import 'package:flutter/material.dart';
import 'package:ajou_capstone_project/screens/wifi_search_screen.dart';

class WifiConnectScreen extends StatefulWidget {
  const WifiConnectScreen({Key? key}) : super(key: key);

  @override
  State<WifiConnectScreen> createState() => _WifiConnectScreenState();
}

class _WifiConnectScreenState extends State<WifiConnectScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WifiSearchScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi 연결 중'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '기기 검색 중...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // 로딩 표시
            const SizedBox(height: 20),
            const Text(
              '잠시만 기다려 주세요',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
