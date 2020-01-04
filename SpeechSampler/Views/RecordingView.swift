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
    
    var body: some View {
        VStack {
            Text("マイクに話してください")
            Text(captionManager.caption)
            Button("終了", action: {
                self.isPresented.toggle()
            })
        }.onAppear(
            perform: {
                self.captionManager.safelyStartRecording(self.userData.identifier)
        }).onDisappear(perform: {
            if let text:String = self.captionManager.stopRecording() {
                self.userData.addMemo(text)
            }
        })
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        return RecordingView(isPresented: .constant(true))
            .environmentObject(CaptionManager())
            .environmentObject(UserData())
    }
}
