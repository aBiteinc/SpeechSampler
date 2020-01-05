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
        NavigationView {
            VStack {
                ListView().environmentObject(userData)
                Button(action: { self.isRecording.toggle() }){
                    Image(systemName: "mic")
                    .resizable()
                    .frame(width:30, height: 30)
                    .padding()
                    .border(Color.blue, width: 5)
                }
                PickerView().environmentObject(userData)
            }.navigationBarTitle("音声メモ")
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
