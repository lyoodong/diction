
<img src="Snapshot/딕션스냅샷.png" align="left">  

# diction

> 핵심 기능
- Speech 프레임워크 기반 **실시간 STT(Speech To Text)** 기능 구현
- AVFoundation 프레임워크 기반 **AudioPlayer, AudioRecorder, AVCaptureVideoPreviewLayer** 기능 구현
- Realm DB를 활용해 **N:M 스키마** 대응
- FileManager를 활용해 **녹음 파일 관리**
- **DIP**를 통한 의존성 역전
- 샘플레이트 핸들링을 통한 **오디오 품질 및 용량 최적화**

> 기술 스택
- **언어**: Swift
- **프레임워크**: AVFoundation, Speech, UIkit
- **디자인패턴**: MVVM, Singleton, Repository
- **라이브러리**: RealmSwift,SnapKit, Then, Lottie, SkyFloatingLabelTextField, IQKeyboardManager

> 적용한 CS 지식
- **데이터통신**: 오디오 용량/품질 핸들링을 위한 기초적인 오디오 데이터 개념
- **데이터베이스**: Realm을 통한 DB관리에 필요한 기초 개념

> 서비스
- **최소 버전**: iOS 16.0
- **개발 인원**: 1인
- **개발 기간** : 2023.09.25 ~ 2022.10.26, 현재 지속적으로 서비스 운영 중(ver 1.0.1)
- **iOS 앱스토어:** [딕션바로가기](https://www.notion.so/b0524f98433846f98e9cad8ddec4df8c?pvs=21)
- **협업**: Git, Figma

> Version History
- ver 1.0.0
  - (23.10.24) 1차 리젝 사유: 권한 요청 시 좀 더 자세한 사용 목적을 명시하라는 요청
  - (23.10.25) 수정 후 제출, 심사 통과
- ver 1.0.1 
  - (23.10.26) 업데이트 내용: 다크모드 블락
  
> 세부 개발 공수
  - Iteration 1 (2023.09.25 ~ 09.27): 
  - Iteration 2 (2023.09.28 ~ 10.01):
  - Iteration 3 (2023.10.02 ~ 10.04):
  - Iteration 4 (2023.10.05 ~ 10.08):
  - Iteration 5 (2023.10.09 ~ 10.11):
  - Iteration 6 (2023.10.12 ~ 10.15):
  - Iteration 7 (2023.10.16 ~ 10.18):
  - Iteration 8 (2023.10.19 ~ 10.22):
  - Iteration 9 (2023.10.23 ~ 10.25):
  - 종료 (2023.10.26)

> 트러블 슈팅
- 오디오 용량/품질 핸들링



## 📒 커밋 메시지 형식

| 유형      | 설명                                                    | 예시                                |
|-----------|---------------------------------------------------------|-------------------------------------|
| FIX       | 버그 또는 오류 해결                                     | [FIX] #10 - 콜백 오류 수정            |
| ADD       | 새로운 코드, 라이브러리, 뷰, 또는 액티비티 추가        | [ADD] #11 - LoginActivity 추가         |
| FEAT      | 새로운 기능 구현                                        | [FEAT] #11 - Google 로그인 추가         |
| DEL       | 불필요한 코드 삭제                                      | [DEL] #12 - 불필요한 패키지 삭제        |
| REMOVE    | 파일 삭제                                               | [REMOVE] #12 - 중복 파일 삭제         |
| REFACTOR  | 내부 로직은 변경하지 않고 코드 개선 (세미콜론, 줄바꿈 포함) | [REFACTOR] #15 - MVP 아키텍처를 MVVM으로 변경 |
| CHORE     | 그 외의 작업 (버전 코드 수정, 패키지 구조 변경, 파일 이동 등) | [CHORE] #20 - 불필요한 패키지 삭제      |
| DESIGN    | 화면 디자인 수정                                         | [DESIGN] #30 - iPhone 12 레이아웃 조정  |
| COMMENT   | 필요한 주석 추가 또는 변경                               | [COMMENT] #30 - 메인 뷰컨 주석 추가     |
| DOCS      | README 또는 위키 등 문서 내용 추가 또는 변경            | [DOCS] #30 - README 내용 추가          |
| TEST      | 테스트 코드 추가                                        | [TEST] #30 - 로그인 토큰 테스트 코드 추가  |
