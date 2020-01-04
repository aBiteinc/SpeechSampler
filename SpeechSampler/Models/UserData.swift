//
//  UserData.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/02.
//  Copyright © 2020 mtfum. All rights reserved.
//

import CoreData


final class UserData: ObservableObject {
    @Published var memos: [Memo]
    @Published var identifier: String
        
    init(){
        self.memos = []
        self.identifier = "ja-JP"
        self.load()
    }

    func addMemo(_ text: String){
        self.memos.append(Memo(text: text))
        self.save()
    }
    
    func load(){
        if let items = UserDefaults.standard.data(forKey: "memos") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Memo].self, from: items) {
                self.memos = decoded
                print("memos decoded", self.memos)
            }
        }
    }
    
    func save(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(memos) {
            UserDefaults.standard.set(encoded, forKey: "memos")
        }
        print("memos saved", memos)
    }
}

struct Memo: Identifiable, Codable, Equatable {
    var id = UUID()
    var text:String = ""
}
