//
//  ContentView.swift
//  Memorize
//
//  Created by Mubariz Ali on 01/01/2023.
//

import SwiftUI

struct ContentView: View {
    var emojis = [    "😘",
                      "😭",
                      "😊",
                      "😂",
                      "🥰",
                      "❤️",
                      "💀",
                      "😎",
                      "😍",
                      "💋",
                      "😉",
                      "👍",
                      "🤭",
                      "😅",
                      "✨",
                      "😀",
                      "🥺",
                      "🥵",
                      "😏",
                      "😳",]

    @State var emojiCount = 6
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 100))])
                {
                    ForEach(emojis[0..<emojiCount], id:\.self) {emoji in CardView(content: emoji, isFaceUp: true).aspectRatio(2/3, contentMode: .fit)
                        
                    }
                    
                }
            }
            Spacer()
            HStack{
                Button {
                    if (emojiCount<emojis.count)
                    {
                        emojiCount+=1
                    }
                } label: {
                    Image(systemName: "plus.circle")
                    
                }
                Spacer()
                Button {
                    if(emojiCount>1)
                    {emojiCount-=1}
                } label: {
                    Image(systemName: "minus.circle")
                    
                }
            }.font(.largeTitle).padding(.horizontal)
                
            
        }
        
    }
}


struct CardView: View{
    var content:String
    @State var isFaceUp:Bool
    var body: some View
    {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                shape
                    .fill(.white)
                shape
                    .strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else{
                shape
                    .fill(.blue)
            }
        }.padding(.horizontal, 1.0)
            .foregroundColor(.blue).onTapGesture {
                isFaceUp = !isFaceUp
            }
        
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
