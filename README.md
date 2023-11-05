<img src="Snapshot/딕션스냅샷.png" align="left">  

# diction 

> 핵심 기능
- AVFoundation 프레임워크 기반 AudioPlayer, AudioRecorder를 통해
  **음성 녹음, 기록 재생 기능** 구현
- Speech 프레임워크 기반 speechRecognizer를 통해 녹음과 동시에
  **실시간 STT(Speech To Text)기능** 구현
- AVFoundation 프레임워크 기반 AVCaptureVideoPreviewLayer를 통해 실시간으로
  **말하는 표정, 동작을 확인**하는 기능 구현
- Realm DB를 활용해 **N:M 스키마** 대응
- FileManager를 활용해 **녹음 파일 관리**
- **DIP**를 통한 의존성 역전
- 샘플레이트 핸들링을 통한 **오디오 품질 및 용량 최적화**

---

> 기술 스택
- **언어**: Swift
- **프레임워크**: AVFoundation, Speech, UIkit
- **디자인패턴**: MVVM, Singleton, Repository
- **라이브러리**: RxSwift, RxCocoa, RealmSwift, SnapKit, Then, Lottie, SkyFloatingLabelTextField, IQKeyboardManager
---

> 적용한 CS 지식
- **MIDI - 데이터**: 오디오 용량/품질 최적화 위한 기초적인 오디오 데이터 개념
- **데이터베이스**: Realm을 통한 DB관리에 필요한 기초 개념
---

> 서비스
- **최소 버전**: iOS 16.0
- **개발 인원**: 1인
- **개발 기간** : 2023.09.25 ~ 2022.10.26, 현재 지속적으로 서비스 운영 중(ver 1.0.1)
- **iOS 앱스토어:** [딕션바로가기](https://www.notion.so/b0524f98433846f98e9cad8ddec4df8c?pvs=21)
- **협업**: Git, Figma
---

### 트러블 슈팅

**1. 숙련도 점수 수정 시 마지막으로 수정한 값만 Realm에 저장**

**Issue**

- 모의 면접 화면에서 사용자가 질문에 대한 숙련도를 수정할 수 있음
- 하지만, 기존 코드에서는 숙련도만 클릭하면 그 즉시 값을 Realm DB에 업로드
- 사용자가 마지막으로 선택한 값만 Realm DB에 저장함으로써 **불필요한 DB 연산 제거**

**Solution**

- `RxSwift`의 `AsyncSubject` 활용해, 마지막으로 수정한 값만 Realm DB에 저장
- `onCompleted` 시점을 아래와 같이 적용
  1. 다음 질문으로 이동 → `nextButtonTapped()`
  2. 이전 질문으로 이동 → `backuttonTapped()`
  3. 다른 뷰로 이동 → `viewDidDisappear()`

**Result**

- 불필요한 DB 연산 제거, **마지막으로 방출한 값만 DB에 저장**

```swift
//개선된 코드
func uploadSelectedFamiliarityDegree() {
    familiaritySubject
        .subscribe(with: self) { owner, value in
            let realm = try! Realm()
            try! realm.write {
                owner.questions[owner.currnetQuestionIndex.value].familiarityDegree = value
            }
            
            print("uploadSelectedFamiliarityDegree 실행")
            owner.repo.realmFileLocation()
        }
        .disposed(by: disposeBag)
}

//1. 다음 질문으로 이동
@objc func nextButtonTapped() {
    cameraViewModel.familiaritySubject.onCompleted()
    cameraViewModel.currnetQuestionIndex.value += 1
    cameraViewModel.fetchCurrentFamilarDegree()
}

//2. 이전 질문으로 이동
@objc func backButtonTapped() {
    cameraViewModel.familiaritySubject.onCompleted()
    cameraViewModel.currnetQuestionIndex.value -= 1
    cameraViewModel.fetchCurrentFamilarDegree()
}

//3. 다른 뷰로 이동
override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		cameraViewModel.familiaritySubject.onCompleted()
}
```
---

**2. 오디오 품질/용량 핸들링**

**Issue**
- 1분 기준 **200KB**내외의 용량으로 음성 파일 최적화하기
- 질문에 대해 사용자가 자신의 목소리를 녹음하기 때문에, 외부 잡음이 개입할 가능성은 낮아 보임
- 필요 이상의 음성 품질은 용량이 지나치게 클 수 있음
- 따라서, **적절한 품질과 용량의 협의점을 찾아 이를 최적화하는 것이 핵심**

**Solution**
- `AVAudioRecorder settings`을 통해 녹음 파일 생성 시 여려 세팅값을 핸들링해 용량 및 품질 최적화
- 오디오 용량 = 비트레이트(샘플레이트 * 비트 뎁스) * 시간(초)
- 추가적으로 코덱의 압축률에 따라 용량이 상이해질 수 있다.

1. AVFormatIDKey(오디오 코덱)

일반적으로 우리가 익히 들은 오디오 코덱의 종류로는 MP3, AAC, FLAC, Ogg Vorbis, WAV등이 있다. 각 형식에서 따라 제공하는 용량, 품질, 압축 알고리즘 등이 상이하기 때문에 **요구되는 오디오 스펙에 맞게 이를 선택**한다. 

무손실 압축의 경우, 용량 이슈 때문에 우선적으로 제외했다. 손실 압축 포맷 중 압축률에 비해 가장 우수한 음질을 보장하는 `AAC`양식으로 선택

2. AVSampleRateKey(샘플레이트)

**초당 샘플 기록 횟수**를 말한다. 표준적인 샘플레이트는 `44.1khz`이며 나이퀴스트 이론에 의해 가청 주파수의 2배 정도의 값을 가지는것이 이상적이다.

3. AVNumberOfChannelsKey(오디오 채널의 수)

스테레오를 통한 입체감은 요구된 스펙에서 굳이 필요없을 것 같아 용량 측면에서 이점이 있는 `모노`로 지정

```swift
//용량 및 품질에 대한 핵심설정 코드
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
        return dictionFolderURL.appendingPathComponent("\(answerID).aac")
    }
    return nil
}
```

**Result**
|  | CASE 1 | CASE 2 | CASE 3 |
| --- | --- | --- | --- |
| 확장자 | AAC | AAC | WAV |
| AVFormatIDKey | kAudioFormatMPEG4AAC | kAudioFormatMPEG4AAC | kAudioFormatLinearPCM |
| AVSampleRateKey | 12.0khz | 44.1khz | 44.1khz |
| AVNumberOfChannelsKey | 1 | 1 | 1 |
| AVEncoderAudioQualityKey | high | high | high |
| **음성 품질** | **적절** | **적절** | **우수** |
| **용량(1분 기준)** | **160KB** | **496KB** | **5.4MB** |

<img width="860" alt="스크린샷 2023-10-31 오후 11 11 41" src="https://github.com/lyoodong/diction/assets/115209527/b25b7ffd-7e6e-4e01-b20a-512e562f0d76">

- 오디오 코덱 양식을 독립 변수로 테스트한 결과, 무손실 WAV와 AAC의 용량 차이는 약 10배였다. 아무리 음질이 우수하더라도 1분 내외의 녹음파일이 5MB 이상 차지하는 것은 사용자 입장에서 큰 부담일 것이라 생각해 **WAV 대신 AAC를 선택했다.**
- 샘플 레이트를 독립 변수로 테스트한 결과 Case 1과 Case 2의 용량 차이는 약 3배였다. Case 1의 경우, 목표했던 기준치를 충족하였지만, Case 2의 경우 목표했던 기준를 한참 상회하는 용량(약 500KB)이 나왔기 때문에 최종적으로 **Case 2 또한 선택하지 않았다.**
- 물론, 샘플 레이트가 44.1khz 이하일 경우 주파수 정보에 손실이 일어날 수 있다. 당연히, 오디오 품질에 있어서 어느정도 손실을 감수해야한다. 하지만 직접 육성으로 테스트해본 결과, 자신이 **이전에 말한 내용을 명확하게 인지할 수 있었다.** 따라서, 최초에 목표했던 비지니스적 요구사항(**200KB 이하 용량** / **들을만한 음질**)을 고려했을 때 두 가지 기준을 충족하는 **Case 1을 선택했다.**

---
  
> Version History
- ver 1.0.0
  - (23.10.24) 1차 리젝 사유: 권한 요청 시 좀 더 자세한 사용 목적을 명시하라는 요청
  - (23.10.25) 수정 후 제출, 심사 통과
- ver 1.0.1 
  - (23.10.26) 업데이트 내용: 다크모드 블락
 
---
> 회고
**What I Learned**

- Sppech 프레임 워크 기반, 실시간 STT 서비스 구현 경험
- 오디오 관련 CS 지식과 이를 적용해, AVFoudation 기반 오디오 처리
- RealmSwift와 fileManager를 통한 파일 관리
- 전체 코드에 MVVM 패턴 적용
- DIP를 통해, 코드 간 결합도를 낮추고 유지보수성 증대

**Areas for Improvement**

- 미흡한 런타임 에러 대응
- audioEngine에 대한 더욱 확실한 이해도

이번 프로젝트에서는 이전 프로젝트에서 부족했던 점들을 보완할 수 있었다. MVVM, RxSwift, DIP 등 개선된 패턴 또는 기술을 도입해 코드의 질을 높이려고 노력했다. 다만, 이러한 적용에 대해서 아직 미숙한 점이 많다는 것 또한 느꼈다. RxSwift는 일부만 적용되어 리펙토링을 통해, RxSwift를 활용할 수 있는 많은 부분에 대해 개선이 필요하다고 생각한다. 또한, Swinject과 같은 라이브러리를 활용해 좀 더 엄격한 의미의 DIP를 구현해보고 싶은 욕심도 생겼다. 

프로젝트에서 구현한 기술적 난이도가 이전 프로젝트에 비해 꽤나 커졌다. 출시 후에도 런타임 에러나, 사용성을 방해하는 요소들이 일부 있다고 피드백을 받았다. 이러한 점들을 빠르게 개선해야 되겠다고 생각한다. 


> 📒 커밋 메시지 형식

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
