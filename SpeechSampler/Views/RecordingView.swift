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
            Text("マイクに音声をどうぞ")
                .font(.title)
            Spacer()
            Text(captionManager.caption)
                .font(.title)
                .fontWeight(.bold)
               .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1))
            Spacer()
            HStack{
            Spacer()
            Button(action: {
                self.captionManager.stopRecording()
                self.isPresented.toggle()
            }){
                Text("RESET")
                .foregroundColor(Color.gray)
                .bold()
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 5))
                }
            Spacer()
            Button(action: {
                self.isPresented.toggle()
            }){
                Text(" SAVE ").foregroundColor(Color.pink)
                    .bold()
                    .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.pink, lineWidth: 5))
                }
            Spacer()
            }
            }.padding()
        .onAppear(
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
