//
//  CaptionManager.swift
//  SpeechSampler
//
//  Created by Fumiya Yamanaka on 2019/12/02.
//  Copyright © 2019 mtfum. All rights reserved.
//

import Foundation
import Speech

final class CaptionManager: NSObject, ObservableObject {

  @Published var caption: String = ""
  @Published var isEnabledRecordButton = false
  @Published var recordButtonText = ""

  private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?
  private let audioEngine = AVAudioEngine()

  override init() {
    super.init()
    speechRecognizer.delegate = self

    SFSpeechRecognizer.requestAuthorization { authStatus in

      OperationQueue.main.addOperation {
        switch authStatus {
        case .authorized:
          self.isEnabledRecordButton = true
          self.recordButtonText = "音声認識を開始"
        case .denied:
          self.isEnabledRecordButton = false
          self.recordButtonText = "音声認識への許可を与えてください"

        case .restricted:
          self.isEnabledRecordButton = false
          self.recordButtonText = "この端末では音声認識が禁止されています"

        case .notDetermined:
          self.isEnabledRecordButton = false
          self.recordButtonText = "Speech recognition not yet authorized"

        default:
          self.isEnabledRecordButton = false
          self.recordButtonText = "なんでもないです"
        }
      }
    }
  }

  private func startRecording() throws {

    // Cancel the previous task if it's running.
    recognitionTask?.cancel()
    self.recognitionTask = nil

    // Configure the audio session for the app.
    let audioSession = AVAudioSession.sharedInstance()
    try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    let inputNode = audioEngine.inputNode

    // Create and configure the speech recognition request.
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
    recognitionRequest.shouldReportPartialResults = true

    if speechRecognizer.supportsOnDeviceRecognition {
      recognitionRequest.requiresOnDeviceRecognition = true
    }

    // Create a recognition task for the speech recognition session.
    // Keep a reference to the task so that it can be canceled.
    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
      var isFinal = false

      if let result = result {
        // Update the text view with the results.
        self.caption = result.bestTranscription.formattedString
        isFinal = result.isFinal
        print("Text: \(result.bestTranscription.formattedString)")

        let formattedString = result.bestTranscription.formattedString
        let speakingRate = result.bestTranscription.speakingRate
        let averagePauseDuration = result.bestTranscription.averagePauseDuration

        print(formattedString, speakingRate, averagePauseDuration)

        for segment in result.bestTranscription.segments {
          let jitter = segment.voiceAnalytics?.jitter.acousticFeatureValuePerFrame
          let shimmer = segment.voiceAnalytics?.shimmer.acousticFeatureValuePerFrame
          let pitch = segment.voiceAnalytics?.pitch.acousticFeatureValuePerFrame
          let voicing = segment.voiceAnalytics?.voicing.acousticFeatureValuePerFrame

          print("jitter:", jitter,
                "\nshimmer:", shimmer,
                "\n voicing:", voicing,
                "\npitch:",pitch)
        }
      }

      if error != nil || isFinal {
        // Stop recognizing speech if there is a problem.
        self.audioEngine.stop()
        inputNode.removeTap(onBus: 0)

        self.recognitionRequest = nil
        self.recognitionTask = nil

        self.isEnabledRecordButton = true
        self.recordButtonText = "Start Recording"
      }
    }

    // Configure the microphone input.
    let recordingFormat = inputNode.outputFormat(forBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
      self.recognitionRequest?.append(buffer)
    }

    audioEngine.prepare()
    try audioEngine.start()

    // Let the user know to start talking.
    caption = "（喋ってください。私は聞いてますよ！）"
    recordButtonText = "音声認識を停止"
  }

  func switchRecording() {
    if audioEngine.isRunning  {
      audioEngine.stop()
      recognitionRequest?.endAudio()
      isEnabledRecordButton = false
      recordButtonText = "Stopping"
    } else {
      do {
        try startRecording()
        recordButtonText = "Stop Recording"
      } catch {
        recordButtonText = "Recording Not Available"
      }
    }
  }
}

extension CaptionManager: SFSpeechRecognizerDelegate {
  func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
    if available {
      isEnabledRecordButton = true
      recordButtonText = "音声認識を開始"
    } else {
      isEnabledRecordButton = false
      recordButtonText = "Recognition Not Available"
    }
  }
}
