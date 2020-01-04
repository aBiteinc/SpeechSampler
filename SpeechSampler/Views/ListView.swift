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
    
    private func deleteRow(at indexSet: IndexSet) {
        for index in indexSet {
            let reversedIndex = userData.memos.count - 1 - index
            print("remove", reversedIndex)
            userData.memos.remove(at: reversedIndex)
        }
        userData.save()
    }
    
    var body: some View {
        List {
            ForEach(userData.memos.reversed()) {
                memo in
                TextFieldView(text:
                    self.$userData.memos[
                        self.userData.memos.firstIndex(of: memo)!
                    ].text
                )
            }.onDelete(perform: self.deleteRow)
        }.environment(\.defaultMinListRowHeight, 100)
    }
}

/*
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        // userData.memos.append(Memo.init(text: "asb"))
        return ListView().environmentObject(userData)
    }
}
*/
