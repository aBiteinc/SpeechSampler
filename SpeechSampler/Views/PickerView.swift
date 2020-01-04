//
//  PickerView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/04.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI

struct PickerView: View {
    let texts = ["日本語", "英語", "中国語"]
    let contents = ["ja-JP","en-US","zh-Hans"]
    @EnvironmentObject var userData: UserData

    var body: some View {
        VStack{
        Text(userData.identifier)
        Picker(selection: $userData.identifier, label: Text("Strength")) {
            ForEach(0 ..< texts.count) {
                Text(self.texts[$0]).tag(self.contents[$0])
            }
        }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView().environmentObject(UserData())
    }
}
