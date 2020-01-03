//
//  UserData.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/02.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI
import Combine

struct Memo: Identifiable,Codable {
    var id = UUID()
    var text:String = ""
}
