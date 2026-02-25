# 🚁 AjouFly: Intelligent Drone Control &  AI Vision System

## 📌 Project Overview & Evolution
AjouFly는 드론 비행 제어를 넘어, 실시간 비전 AI 결과를 모바일 엣지(Edge) 기기에서 수신하고 맵 상에 시각화하고자 만든 앱입니다. 

## 🏗️ System Architecture (Edge-to-Cloud)
모바일 앱과 AI 서버가 역할을 분담하여 실시간으로 통신하는 구조로 설계되었습니다.

1. Edge Device - Flutter App - 드론 카메라의 가상 영상 프레임을 주기적(3초)으로 캡처하여 바이트 데이터로 변환 후 서버로 전송합니다.
2. HTTP POST - 네트워크 통신을 통해 이미지를 AI 백엔드 서버로 전달합니다.
3. Cloud Server - FastAPI & YOLOv8- 전송된 2D 이미지를 기반으로 실시간 객체 탐지(Object Detection)를 수행하여, '조난자(Person)' 등의 타겟 객체를 식별합니다.
4. Edge Device - UI/UX - 서버의 응답(200 OK & JSON)을 트리거로 삼아, 즉각적인 경고 알림, 지도 위 위치 마킹, 사후 AI 브리핑 리포트 생성을 수행합니다.

##  Key Features

1. 실시간 위험 객체/조난자 탐지 및 경고 (AI Vision)
- 카메라 화면 송출 중 AI 서버와 통신하여 전방의 특정 객체(사람, 차량 등)를 탐지.
- 객체 인식 시 UI 테두리 경고등 점멸 및 실시간 알림 팝업 제공.

2. SAR (Search and Rescue) 관제 매핑 시뮬레이션
- AI가 객체를 탐지한 순간의 가상 GPS 좌표를 계산.
- 2D 관제 지도(Map) 상에 조난자의 위치를 마커(Marker)로 찍고, 현재 드론 위치부터의 최단 구조 경로(Polyline)를 실시간으로 시각화.

3. 사후 AI 비행 브리핑 리포트 (Data Logging)
- 비행 중 탐지된 모든 객체의 종류, Confidence Score, 발견 시간 및 좌표 데이터를 전역 상태(Global State)로 축적.
- 비행 종료 후, 수집된 로그를 바탕으로 비행 구역 내의 안전 및 탐지 통계를 제공하는 리포트 화면 구현.

위 프로젝트는 Mock data로 만들었으며, 실제 프로젝트에서 드론을 이용하지 못했기 때문에 시뮬레이션 구현 단계에 머물렀습니다. 
