//
//  ThemeHandler.swift
//  Memorize
//
//  Created by Mubariz Ali on 06/01/2023.
//

import Foundation



struct ThemeHandler{
    static let faces = ["😘","😭","😊","😂","🥰","😉","🤭","😅","😀","🥺","🥵","😏","😳",]
    static let birds = ["🦜","🦢","🦩","🕊️","🕊️"]
    
    enum MyColors {
        case RED,BLUE,YELLOW
            
    }
    
    struct Theme:Identifiable{
        var id:Int
        var name:String
        var emojis:Array<String>
        var numPairs:Int
        var color:MyColors
        
    }
    static let PREBUILT_THEMES:Array<Theme> = [
        Theme(id: 1,name:"Faces", emojis:faces,numPairs: 4,color: .RED ),
        Theme(id: 2,name:"Birds", emojis:birds,numPairs: 7,color: .BLUE )
    ]
    private(set) var themes:Array<Theme> = PREBUILT_THEMES
    
    func getRandomTheme()->Theme{
        let randomInt = Int.random(in: 0..<themes.count)
        return themes[randomInt]
    }
   
}
