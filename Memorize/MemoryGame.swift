//
//  MemoryGame.swift
//  Memorize
//
//  Created by Mubariz Ali on 03/01/2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards:Array<Card>=[]
    private var firstCardIndex:Int?{
        get{
            cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
        }
        set{
            cards.indices.forEach{cards[$0].isFaceUp = ($0==newValue)}
            
        }
    }
    private(set) var score:Int=0
    
    
    init(numPairs:Int,createCardContentFunc:(Int)->CardContent) {
        for i in 0..<numPairs
        {
            let content = createCardContentFunc(i)
            cards.append(Card(content:content,id:i*2))
            cards.append(Card(content:content,id:i*2+1))
            
        }
        cards = cards.shuffled()
    }
    mutating func choose(_ card:Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id==card.id
            
        }), !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = firstCardIndex
            {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content
                {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched=true
                    score+=2
                    
                    
                }
                
                else if cards[chosenIndex].isSeen{
                    score-=1
                }
                cards[chosenIndex].isFaceUp=true
                
                
                
            } else{
                firstCardIndex = chosenIndex
            }
            
            cards[chosenIndex].isSeen = true
            
        }
        
    }
    
    
    
    struct Card: Identifiable{
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        var content:CardContent
        var id: Int
        
    }
    
    
}
extension Array{
    var oneAndOnly:Element? {
        if count==1{
            return first
        }
        else{
            return nil
        }
        
    }
}
