//
//  ListView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/04.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI

struct ListView: View {
    @State var displayingText: String = ""
    @EnvironmentObject var capManager:CaptionManager
    
    private func deleteRow(at indexSet: IndexSet) {
        for index in indexSet {
            let reversedIndex = capManager.memos.count - index - 1
            capManager.memos.remove(at: reversedIndex)
        }
        capManager.save()
    }
    
    var body: some View {
        NavigationView {
            List{
                // ToDo: reverse
                ForEach((0..<capManager.memos.count).reversed(), id: \.self){ id in
                    TextView(text: self.$capManager.memos[id].text)
                }.onDelete(perform: self.deleteRow)
            }.navigationBarTitle(Text("メモ一覧"),displayMode: .inline)
        }.onAppear(perform:{
            self.capManager.decode()
            print("appear2")
        })
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let captionManager = CaptionManager()
        return ListView().environmentObject(captionManager)
    }
}
