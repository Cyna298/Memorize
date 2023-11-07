//
//  ContentView.swift
//  Memorize
//
//  Created by Mubariz Ali on 01/01/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View{
        switch(game.gameState)
        {
        case .IN_MENU:
            VStack{
                Text("Memorize").font(.largeTitle)
                Text("Choose a theme").font(.headline)
                Spacer()
                
                ScrollView{
                    ForEach(game.themes){
                        theme in ThemeButton(onClick: game.startGame, theme: theme,
                                             color: EmojiMemoryGame.getColor(color: theme.color) )
                    }
                    
                }
            }.padding(.horizontal)
            
            
        case .IN_GAME:
            VStack{
                HStack{
                    Button("Back") {
                        game.backToMenu()
                    }.buttonStyle(.bordered)
                        .foregroundColor(game.currentColor)
                    Spacer()
                    Text(game.currentTheme.name).font(.title).foregroundColor(game.currentColor)
                    Spacer()
                    Button("New Game") {
                        game.startNewGame()
                    }.buttonStyle(.bordered)
                        .foregroundColor(game.currentColor)
                }
                MemorizeGame(cards: game.cards, choose: game.choose,color:game.currentColor)
                HStack{
                    Text("Score:")
                    Text(String(game.score))
                }
                
            }
        }
    }
}

struct ThemeButton:View{
    let onClick:(ThemeHandler.Theme)->Void
    let theme:ThemeHandler.Theme
    let color:Color
    var body: some View{
        
        HStack{
            Text(theme.name)
            Spacer()
            Image(systemName: "chevron.right.circle")
        }.font(.title2).foregroundColor(color).padding(12).background(in: Rectangle()).cornerRadius(12).onTapGesture {
            onClick(theme)
        }
        
    }
}



struct MemorizeGame:View{
    var cards:Array<EmojiMemoryGame.Card>
    var choose:(EmojiMemoryGame.Card)->Void
    var color:Color
    var body: some View {VStack{
        ScrollView{
            AspectVGird(items: cards, aspectRatio: 2/3) { card in
                CardView(card: card,color: color).opacity({card.isMatched ? 0:1}()).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                    choose(card)
                }
                
            }
        }
        
        Spacer()
        
        
    }
        
    }
    
}
struct CardView: View{
    var card:EmojiMemoryGame.Card
    var color:Color
    var body: some View
    {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp{
                    shape
                        .fill(.white)
                    shape
                        .strokeBorder(lineWidth: 4)
                        .foregroundColor(color)
                    Pie(
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 350)).padding(DrawingConstants.timerPadding).foregroundColor(.red).opacity(DrawingConstants.timerOpacity)
                    Text(card.content).font(font(in: geometry.size))
                }
                else{
                    shape
                        .fill(color)
                    
                }
            }.padding(.horizontal, 1.0)
        }
        
        
        
    }
    private func font(in size:CGSize)->Font{
        Font.system(size: min(size.height,size.width)*DrawingConstants.contentScale)
    }
    private struct DrawingConstants{
        static let cornerRadius:CGFloat = 12
        static let contentScale:CGFloat = 0.5
        static let timerPadding:CGFloat = 5
        static let timerOpacity:CGFloat = 0.5
    }
}





struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.startGame(theme: ThemeHandler.PREBUILT_THEMES.first!)
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
        
    }
}
