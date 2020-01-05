//
//  DetailView.swift
//  SpeechSampler
//
//  Created by HidekiMachida on 2020/01/03.
//  Copyright © 2020 mtfum. All rights reserved.
//

import SwiftUI


struct DetailView: View {
    var index: Int
    @State var text1:String = ""
    @State var text2:String = ""
    @State var text3:String = ""
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView{
            VStack{
            TextField("",text: $text1)
            TextField("",text: $text2)
            TextField("",text: $text3)
            Spacer()
            }
        }
        .onAppear{
            let longText = self.userData.memos[self.index].text
            if longText.count < 22{
            self.text1 = longText
            }else{
                if longText.count < 44{
                    self.text1 = String(longText[0..<23])
                    self.text2 = String(longText[23..<longText.count])
                }else{
                        self.text1 = String(longText[0..<23])
                        self.text2 = String(longText[23..<46])
                        self.text3 = String(longText[46..<longText.count])
                    }
                }
        }
        .onDisappear(perform: {
            print("disappear")
            let longText = self.text1 + self.text2 + self.text3
            self.userData.memos[self.index].text = longText
            self.userData.save()
        })
    }
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        
        myTextView.font = UIFont(name: "HelveticaNeue", size: 30)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
        
        return myTextView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    
    class Coordinator : NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
            }
        }
    }

/*
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(memo: Memo.init(text:"sssssssssssssssssssssssssscsccscscdscdssvsvavdavvdvavdavdvavadvavdava"))
    }
}
*/
