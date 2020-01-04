//
//  InputView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/04.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI


struct InputView: View {
    @State var displayingText: String = ""
    @EnvironmentObject var capManager:CaptionManager
   
    var body: some View {
       VStack {
                 Text("マイクに話してください")
                 Text(capManager.caption)
                    .padding()
                    .border(Color.black)
                    .fixedSize(horizontal: false, vertical: true)
       }.onAppear(perform:{
             self.capManager.decode()
             self.capManager.switchRecording()
       }).onDisappear(perform:{
             self.capManager.switchRecording()
       })
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView().environmentObject(CaptionManager())
    }
}
