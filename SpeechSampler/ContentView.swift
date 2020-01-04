//
//  ContentView.swift
//  SpeechSampler
//
//  Created by Fumiya Yamanaka on 2019/12/02.
//  Copyright © 2019 mtfum. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var isRecording: Bool = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            ListView().environmentObject(userData)
            Button("音声認識", action: { self.isRecording.toggle() })
        }.sheet(
            isPresented: $isRecording,
            content: {
                RecordingView(isPresented: self.$isRecording)
                    .environmentObject(CaptionManager())
                    .environmentObject(self.userData)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}
