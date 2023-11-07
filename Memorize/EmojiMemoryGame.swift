//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mubariz Ali on 03/01/2023.
//

import SwiftUI

class EmojiMemoryGame:ObservableObject{
    typealias Card = MemoryGame<String>.Card
    enum GameState {
        case IN_MENU
        case IN_GAME
        
    }
    @Published var gameState = GameState.IN_MENU
    @Published var currentTheme:ThemeHandler.Theme
    @Published var currentColor:Color
    @Published var score:Int = 0
    @Published private var model:MemoryGame<String>?
    var cards:Array<Card> { model?.cards ?? []}
    private var themeHandler:ThemeHandler = ThemeHandler()
    var themes:Array<ThemeHandler.Theme>{themeHandler.themes}
    
    init() {
        let theme = themeHandler.getRandomTheme()
        self.currentTheme = theme
        self.currentColor = EmojiMemoryGame.getColor(color: theme.color)
    }
    
    func createMemoryGame(numPairs:Int,emojis:Array<String>)->MemoryGame<String>{
        let shuffledEmojis = emojis.shuffled()
        let unqiueEmojis = Array(Set(shuffledEmojis))
        
        return MemoryGame<String>(numPairs: min(numPairs,unqiueEmojis.count)) {
            index in unqiueEmojis[index]
        }
    }
    
    func choose(_ card:Card){
        model!.choose(card)
        score = model!.score
    }
    
    
    
    
    static func getColor(color:ThemeHandler.MyColors)->Color
    {
        switch color {
        case .BLUE:
            return .blue
        case .RED:
            return .red
        case .YELLOW:
            return .yellow
            
        }
    }
    
    func startGame(theme:ThemeHandler.Theme){
        self.currentTheme = theme
        self.currentColor = EmojiMemoryGame.getColor(color: theme.color)
        self.model = createMemoryGame(numPairs: theme.numPairs, emojis: theme.emojis)
        self.gameState = .IN_GAME
        self.score = 0
        
        
    }
    func startNewGame(){
        let theme = themeHandler.getRandomTheme()
        startGame(theme: theme)
    }
    
    func backToMenu(){
        self.gameState = .IN_MENU
    }
    
    
    //MARK: - intent
    
    
}

