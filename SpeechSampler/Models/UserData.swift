//
//  UserData.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/02.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject  {
    @Published var memos:[Memo] = []
}

struct Memo: Identifiable {
    var id = UUID()
    var text:String = ""
}
