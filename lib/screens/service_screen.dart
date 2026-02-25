import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "고객 지원",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // FAQ 섹션
          const Text(
            "자주 묻는 질문",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildFAQItem(
            "드론 연결이 자주 끊깁니다.",
            "1. Wi-Fi 신호 강도를 확인해주세요.\n2. 드론과의 거리를 확인해주세요.\n3. 주변 전파 간섭을 확인해주세요.",
          ),
          _buildFAQItem(
            "배터리가 빨리 소모됩니다.",
            "1. 배터리 상태를 확인해주세요.\n2. 비행 환경(바람, 기온)을 확인해주세요.\n3. 과도한 기동을 자제해주세요.",
          ),
          _buildFAQItem(
            "GPS 신호가 잡히지 않습니다.",
            "1. 실외 개활지에서 시도해주세요.\n2. 주변 장애물을 확인해주세요.\n3. GPS 캘리브레이션을 진행해주세요.",
          ),

          const SizedBox(height: 32),

          // 서비스 요청 섹션
          const Text(
            "서비스 요청",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceRequestButton(
            "기술 지원 요청",
            Icons.build,
                () {
              _showServiceRequestDialog(context, "기술 지원");
            },
          ),
          const SizedBox(height: 12),
          _buildServiceRequestButton(
            "피드백 보내기",
            Icons.feedback,
                () {
              _showServiceRequestDialog(context, "피드백");
            },
          ),
          const SizedBox(height: 12),
          _buildServiceRequestButton(
            "문의하기",
            Icons.mail,
                () {
              _showServiceRequestDialog(context, "문의");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRequestButton(String title, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showServiceRequestDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$type 요청'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: '내용',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              // 여기에 제출 로직 추가
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$type 요청이 접수되었습니다.')),
              );
            },
            child: Text('제출'),
          ),
        ],
      ),
    );
  }
}