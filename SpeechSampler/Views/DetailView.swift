//
//  DetailView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/03.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State var memo:Memo
    @EnvironmentObject var capManager:CaptionManager
   
    var body: some View {
        VStack{
        TextField(" Enter some text", text: $memo.text)
        .border(Color.black)
        }.onDisappear(perform: {
            let i = self.capManager.memos.firstIndex(where: {$0.id == self.memo.id })
            self.capManager.memos[i ?? 0] = self.memo
            self.capManager.save()
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(memo: Memo.init(text:""))
    }
}
