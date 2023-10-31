---
### Outline
<p align="left">
  <img src="Snapshot/딕션스냅샷.png" align="left">
</p>

<br><br><br><br><br><br><br><br><br><br><br><br>
### 기술 스택
- **언어**: Swift
- **프레임워크**: UIkit, AVFoundation, Speech
- **디자인패턴**: MVVM, Singleton

### 서비스
- **최소 버전**: iOS 16.0
- **개발 인원**: 1인
- **개발 기간** : 2023.1  0 ~ 2022.11 현재 지속적으로 서비스 운영 중(ver 1.0.1)
- **iOS 앱스토어:** [딕션바로가기](https://www.notion.so/b0524f98433846f98e9cad8ddec4df8c?pvs=21)
- **협업**: Git, Figma

### 핵심 기능
- Speech 프레임워크 기반 실시간 STT(Speech To Text) 기능 구현
- AVFoundation 프레임워크 기반 AudioPlayer, AudioRecorder, AVCaptureVideoPreviewLayer 기능 구현
- Realm DB를 활용해 N:M 스키마 대응
- FileManager를 활용해 녹음 파일 관리
- DIP를 통한 의존성 역전
- 샘플레이트 컨트롤을 통한 오디오 품질 및 용량 최적화

### Experience
> **UI**
> 
- 셀 클릭 시 커스텀한 에니메이션 추가
- 디자인 시스템에 따른 표준화된 구성(쉐도우, 폰트, 이미지, 칼라 등)

> **Business Logic**
> 
- 오디오 용량 핸들링
- audio engine STT 구현
- audio player 구현
- audio recorder 구현

### 사용 라이브러리

- **Realm:** 데이터베이스
- **SnapKit**: Layout
- **Then**: initializers syntax
- **Lottie**: Gif 에니메이션 활용
- **SkyFloatingLabelTextField**: 커스텀 텍스트 필드
- **IQKeyboardManager**: 키보드 설정

---


## 개발 기간
- 전체 개발 기간: 2023.09.25 ~ 2023.10.26
- 세부 개발 공수
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

## 📑 개인일지 
| 날짜      | 제목                | 링크                                            |
|-----------|---------------------|-------------------------------------------------|
| 2022.09.27 | 실시간 STT 테스트 | [📄](https://www.notion.so/lyoodong/0927-cc4fe2a7580b4c30aec5b7bbf088f8e0#d890860f310f4212b167a0adff4a78b8) |
| 2022.10.02 | 1차 디자인 피드백 | [📄](https://www.notion.so/lyoodong/1002-9f6ab740a49040089487127a6fd0512a) |
| 2022.10.03 | 네비게이션 바 레이아웃 및 음성 일시 정지 | [📄](https://www.notion.so/lyoodong/1003-c771cb7d71b54092b1fec8062e50bb77) |
| 2023.10.04 | 새로운 기능 추가 | [📄](링크 추가) |
| 2023.10.05 | 버그 수정 | [📄](링크 추가) |
| 2023.10.06 | 테스트 코드 작성 | [📄](링크 추가) |
| 2023.10.07 | 레이아웃 디자인 수정 | [📄](링크 추가) |

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

