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
            let reversedIndex = userData.memos.count - index - 1
            var memomemo =  userData.memos
            print(reversedIndex)
            print(userData.memos)
            memomemo.remove(at: reversedIndex)
            userData.memos = memomemo
        }
        userData.save()
    }
    
    var body: some View {
        List {
            ForEach((0..<userData.memos.count).reversed(), id: \.self) {
                id in
                TextFieldView(text: self.$userData.memos[id].text)
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
