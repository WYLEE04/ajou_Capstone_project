import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ajou_capstone_project/screens/album_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  Timer? _timer;
  bool _isPressed = false;
  int _pressDuration = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 상단 상태 바
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "연결 상태: ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Icon(
                          Icons.wifi,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "배터리 상태: ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          "75%",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 카메라 화면 (위아래 여백 추가)
            Positioned(
              top: 60,  // 상단 여백
              bottom: 60,  // 하단 여백
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[800]!, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/street_view.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 왼쪽 컨트롤 버튼들
            Positioned(
              left: 20,
              top: screenHeight * 0.5 - 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControlButton(Icons.arrow_upward, "이륙"),
                  SizedBox(height: 20),
                  _buildControlButton(Icons.arrow_downward, "RTH"),
                ],
              ),
            ),

            // 오른쪽 촬영 버튼
            Positioned(
              right: 20,
              top: screenHeight * 0.5 - 40,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            // 앨범 버튼 (오른쪽 하단)
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlbumScreen()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () => _showActionDialog(context, label),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black54,
              border: Border.all(color: Colors.white30),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showActionDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          contentPadding: EdgeInsets.all(30),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onLongPressStart: (_) {
                  setState(() => _isPressed = true);
                  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                    _pressDuration++;
                    if (_pressDuration >= 3) {
                      timer.cancel();
                      Navigator.of(context).pop();
                      _executeAction(action);
                    }
                  });
                },
                onLongPressEnd: (_) {
                  setState(() => _isPressed = false);
                  _timer?.cancel();
                  _pressDuration = 0;
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800],
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        action == "이륙" ? Icons.arrow_upward : Icons.arrow_downward,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        action,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                action == "이륙"
                    ? "자동 이륙: 기체가 자동으로 1.2m 고도로 이륙합니다.\n제한된 공간이나 사람들이 많은 곳에서는 이륙하지 마세요"
                    : "RTH: 기체가 이륙 위치로 자동 복귀합니다.\n장애물이 있는 경우 주의하세요",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void _executeAction(String action) {
    // 실제 이륙/RTH 동작을 수행할 코드
    print('$action 실행');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}