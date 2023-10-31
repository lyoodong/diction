
<img src="Snapshot/딕션스냅샷.png" align="left">  

# diction

> 핵심 기능
- Speech 프레임워크 기반 **실시간 STT(Speech To Text)** 기능 구현
- AVFoundation 프레임워크 기반 **AudioPlayer, AudioRecorder, AVCaptureVideoPreviewLayer** 기능 구현
- Realm DB를 활용해 **N:M 스키마** 대응
- FileManager를 활용해 **녹음 파일 관리**
- **DIP**를 통한 의존성 역전
- 샘플레이트 핸들링을 통한 **오디오 품질 및 용량 최적화**
---

> 기술 스택
- **언어**: Swift
- **프레임워크**: AVFoundation, Speech, UIkit
- **디자인패턴**: MVVM, Singleton, Repository
- **라이브러리**: RealmSwift,SnapKit, Then, Lottie, SkyFloatingLabelTextField, IQKeyboardManager
---

> 적용한 CS 지식
- **데이터통신**: 오디오 용량/품질 핸들링을 위한 기초적인 오디오 데이터 개념
- **데이터베이스**: Realm을 통한 DB관리에 필요한 기초 개념
---

> 서비스
- **최소 버전**: iOS 16.0
- **개발 인원**: 1인
- **개발 기간** : 2023.09.25 ~ 2022.10.26, 현재 지속적으로 서비스 운영 중(ver 1.0.1)
- **iOS 앱스토어:** [딕션바로가기](https://www.notion.so/b0524f98433846f98e9cad8ddec4df8c?pvs=21)
- **협업**: Git, Figma
---

> 트러블 슈팅
**오디오 품질/용량 핸들링**

**Issue**
- 1분 기준 200KB내외의 용량으로 들을 만한 음성 녹음하기 
- 질문에 대해 사용자가 자신의 목소리를 녹음하기 때문에, 외부 잡음이 개입할 가능성은 낮아 보임
- 필요 이상의 음성 품질은 용량이 과다하다는 문제가 발생 
- 따라서 적절한 품질과 용량의 협의점을 찾는 것이 핵심

**Solution**
- `AVAudioRecorder`를 통해 녹음 파일 생성 시 여려 세팅값을 핸들링해 용량 및 품질 최적화

1. AVFormatIDKey(오디오 코덱)

일반적으로 우리가 익히 들은 오디오 코덱의 종류로는 MP3, AAC, FLAC, Ogg Vorbis, WAV등이 있다. 각 형식에서 따라 제공하는 용량, 품질, 압축 알고리즘 등이 상이하기 때문에 **요구되는 오디오 스펙에 맞게 이를 선택**한다. 

무손실 압축의 경우, 용량 이슈 때문에 우선적으로 제외했다. 손실 압축 포맷 중 압축률에 비해 가장 우수한 음질을 보장하는 `AAC`양식으로 선택

2. AVSampleRateKey(샘플레이트)

**초당 샘플 기록 횟수**를 말한다. 표준적인 샘플레이트는 `44.1khz`이며 값이 나이퀴스트 이론에 의해 가청 주파수의 2배 정도의 값을 가지는것이 이상적이다.

3. AVNumberOfChannelsKey(오디오 채널의 수)

스테레오를 통한 입체감은 요구된 스펙에서 굳이 필요없을 것 같아 용량 측면에서 이점이 있는 `모노`로 지정

```swift
//용량 및 품질에 대한 핵심 설정코드
func startRecording() {
    
    audioFileURL = createAudioFileURL(answerID: answerID)
    
    let settings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 44100,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    do {
        audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
        audioRecorder.record()
    } catch {
        print("Recording setup error: \(error.localizedDescription)")
    }
}
.
.
.
// 오디오 확장자 및 파일URL 생성
func createAudioFileURL(answerID: String) -> URL? {
    if let dictionFolderURL = createDictionFolder() {
        print(dictionFolderURL)
        return dictionFolderURL.appendingPathComponent("\(answerID).mp3")
    }
    return nil
}
```

**Result**
|  | AAC | WAV |
| --- | --- | --- |
| AVFormatIDKey | kAudioFormatMPEG4AAC | kAudioFormatLinearPCM |
| AVSampleRateKey | 44.1khz | 44.1khz |
| AVNumberOfChannelsKey | 1 | 1 |
| AVEncoderAudioQualityKey | high | high |
| 음성 품질 | WAV에 비해 저품질 | 우수 |
| **용량(1분 기준)** | **496KB** | **5.4MB** |



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
