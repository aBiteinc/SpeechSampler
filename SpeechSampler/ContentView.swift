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
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            InputView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "mic.fill")
                        Text("音声入力")
                    }
            }
            .tag(0)
            ListView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "doc.plaintext")
                        Text("メモ一覧")
                    }
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CaptionManager())
    }
}
