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
        TextView(text: $memo.text)
        Spacer()
        }.onDisappear(perform: {
            let i = self.capManager.memos.firstIndex(where: {$0.id == self.memo.id })
            self.capManager.memos[i ?? 0] = self.memo
            self.capManager.save()
        })
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
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(memo: Memo.init(text:"sssssssssssssssssssssssssscsccscscdscdssvsvavdavvdvavdavdvavadvavdava"))
    }
}
