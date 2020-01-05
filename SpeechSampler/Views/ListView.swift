//
//  ListView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/04.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var userData: UserData
    
    private func deleteRow(at offsets: IndexSet) {
        userData.memos.remove(atOffsets: offsets)
        userData.save()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.memos) {memo in
                    NavigationLink(destination: DetailView(index: self.userData.memos.firstIndex(of: memo)!).environmentObject(self.userData)) {
                        Text(
                            self.userData.memos[
                                self.userData.memos.firstIndex(of: memo)!
                            ].text
                        ).lineLimit(3)
                    }
                }.onDelete(perform: deleteRow)
            }.environment(\.defaultMinListRowHeight, 100)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        userData.memos.append(Memo.init(text: "今度内閣府でデモをします。内閣府は永田町にあります。"))
        userData.memos.append(Memo.init(text: "asb"))
        return ListView().environmentObject(userData)
    }
}
