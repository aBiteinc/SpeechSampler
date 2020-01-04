//
//  InputView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/04.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI


struct RecordingView: View {
    @EnvironmentObject var captionManager: CaptionManager
    @EnvironmentObject var userData: UserData
    @Binding var isPresented: Bool
    // @State var
    
    var body: some View {
        VStack {
            Text("マイクに話してください")
            Text(captionManager.caption)
            Button("終了", action: {
                self.isPresented.toggle()
            })
        }.onAppear(
            perform: {
                do {
                    try self.captionManager.startRecording("ja-JP")
                } catch {
                    print("Recording Not Available")
                }
        }).onDisappear(perform: {
            if let text:String = self.captionManager.stopRecording() {
                self.userData.addMemo(text)
            }
        })
    }
}

/*
 struct InputView_Previews: PreviewProvider {
 static var previews: some View {
 let userData = UserData()
 return InputView(memos: $userData.memos).environmentObject(CaptionManager())
 }
 }
 */
