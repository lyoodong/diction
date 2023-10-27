# GreenLight
---

### O**utline**

![Simulator Screenshot - iPhone 14 - 2023-10-27 at 19.46.22.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f10ba715-b66d-41e7-8fe0-785d96f7142e/8044ac8b-2f6d-4be7-a06d-a6eabf4db1e7/Simulator_Screenshot_-_iPhone_14_-_2023-10-27_at_19.46.22.png)

![Simulator Screenshot - iPhone 14 - 2023-10-27 at 19.47.07.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f10ba715-b66d-41e7-8fe0-785d96f7142e/cb41e69f-7b80-454b-9a04-05a32d406593/Simulator_Screenshot_-_iPhone_14_-_2023-10-27_at_19.47.07.png)

![Simulator Screenshot - iPhone 14 - 2023-10-20 at 22.26.39.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f10ba715-b66d-41e7-8fe0-785d96f7142e/6c3e9ccf-5297-4bd8-b4f0-e9b09b7269cf/Simulator_Screenshot_-_iPhone_14_-_2023-10-20_at_22.26.39.png)

![Simulator Screenshot - iPhone 14 - 2023-10-20 at 22.30.53.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f10ba715-b66d-41e7-8fe0-785d96f7142e/ea11c60d-758f-4725-b772-eb11d26ea5b3/Simulator_Screenshot_-_iPhone_14_-_2023-10-20_at_22.30.53.png)

![Simulator Screenshot - iPhone 14 - 2023-10-27 at 19.47.24.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f10ba715-b66d-41e7-8fe0-785d96f7142e/d820a17e-87aa-4ab3-b932-9883027e2db5/Simulator_Screenshot_-_iPhone_14_-_2023-10-27_at_19.47.24.png)

![Simulator Screenshot - iPhone 14 - 2023-10-20 at 23.00.21.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f10ba715-b66d-41e7-8fe0-785d96f7142e/50d4b796-2a07-412b-81ad-04debbd29454/Simulator_Screenshot_-_iPhone_14_-_2023-10-20_at_23.00.21.png)

- **언어** : Swift
- **프레임워크**: UIkit, AVFoundation, Speech
- **디자인패턴** : MVVM, Singleton
- **협업** : Git, Figma
- **iOS 앱스토어 링크:** [딕션바로가기](https://www.notion.so/b0524f98433846f98e9cad8ddec4df8c?pvs=21)

- **AVFoundation, Speech** 프레임워크를 활용해 **실시간 STT, 녹음, Player 기능** 구현
- **RealmList**를 활용해 N:M 스키마 대응
- **DIP**를 활용해 의존성 역전

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
- **SnapKit** : Layout
- **Then**: initializers syntax
- **Lottie**: Gif 에니메이션 활용
- **SkyFloatingLabelTextField**: 커스텀 텍스트 필드
- **IQKeyboardManager:** 키보드 설정

---


## 개발 기간
- 전체 개발 기간 : 2023.09.25 ~ 2023.10.26
- 세부 개발 공수
  - Iteration 1(2023.09.25 ~ 09.27) : 
  - Iteration 2(2023.09.28 ~ 10.01) :
  - Iteration 3(2023.10.02 ~ 10.04) :
  - Iteration 4(2023.10.05 ~ 10.08) :
  - Iteration 5(2023.10.09 ~ 10.11) :
  - Iteration 6(2023.10.12 ~ 10.15) :
  - Iteration 7(2023.10.16 ~ 10.18) :
  - Iteration 8(2023.10.19 ~ 10.22) :
  - Iteration 9(2023.10.23 ~ 10.25) :
  - 종료(2023.10.26)

## 📑 개인일지 
| 날짜 | 제목 | 링크 |
|----|----|----|
|2022.09.27| 실시간 STT 테스트 | [📄](https://www.notion.so/lyoodong/0927-cc4fe2a7580b4c30aec5b7bbf088f8e0#d890860f310f4212b167a0adff4a78b8) |
|2022.10.02| 1차 디자인 피드백 | [📄](https://www.notion.so/lyoodong/1002-9f6ab740a49040089487127a6fd0512a) |
|2022.10.03| 네비게이션 바 레이아웃 및 음성 일시 정지 | [📄](https://www.notion.so/lyoodong/1003-c771cb7d71b54092b1fec8062e50bb77) |

https://www.notion.so/lyoodong/1003-c771cb7d71b54092b1fec8062e50bb77


## 📒 커밋 메시지 형식

| 유형     | 설명                                                          | 예시                                     |
|----------|---------------------------------------------------------------|------------------------------------------|
| FIX      | 버그 또는 오류 해결                                           | [FIX] #10 - 콜백 오류 수정                |
| ADD      | 새로운 코드, 라이브러리, 뷰, 또는 액티비티 추가              | [ADD] #11 - LoginActivity 추가             |
| FEAT     | 새로운 기능 구현                                              | [FEAT] #11 - Google 로그인 추가             |
| DEL      | 불필요한 코드 삭제                                            | [DEL] #12 - 불필요한 패키지 삭제            |
| REMOVE   | 파일 삭제                                                     | [REMOVE] #12 - 중복 파일 삭제             |
| REFACTOR | 내부 로직은 변경하지 않고 코드 개선 (세미콜론, 줄바꿈 포함) | [REFACTOR] #15 - MVP 아키텍처를 MVVM으로 변경 |
| CHORE    | 그 외의 작업 (버전 코드 수정, 패키지 구조 변경, 파일 이동 등) | [CHORE] #20 - 불필요한 패키지 삭제          |
| DESIGN   | 화면 디자인 수정                                               | [DESIGN] #30 - iPhone 12 레이아웃 조정      |
| COMMENT  | 필요한 주석 추가 또는 변경                                     | [COMMENT] #30 - 메인 뷰컨 주석 추가         |
| DOCS     | README 또는 위키 등 문서 내용 추가 또는 변경                  | [DOCS] #30 - README 내용 추가              |
| TEST     | 테스트 코드 추가                                              | [TEST] #30 - 로그인 토큰 테스트 코드 추가  |

