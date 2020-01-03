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

  @State var displayingText: String = ""
  @EnvironmentObject var capManager:CaptionManager
 
  private func deleteRow(at indexSet: IndexSet) {
    capManager.memos.remove(atOffsets: indexSet)
    capManager.save()
  }
  var body: some View {
   NavigationView {
    List{
        Section(header:Text("入力中")){
             Text(capManager.caption)
        }
        Section(header:Text("メモ一覧"),
                footer:
                    Button(capManager.recordButtonText) {
                       self.capManager.switchRecording()
                    }.disabled(!self.capManager.isEnabledRecordButton)
        ){
            ForEach(capManager.memos.reversed()){memo in
            NavigationLink(destination: DetailView(memo: memo )) {
                Text(memo.text)
            }}.onDelete(perform: self.deleteRow)
        }
    }
   }.onAppear(perform:{
            self.capManager.decode()
})
}
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(CaptionManager())
  }
}
