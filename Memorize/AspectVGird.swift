//
//  AspectVGird.swift
//  Memorize
//
//  Created by Mubariz Ali on 15/03/2023.
//

import SwiftUI

struct AspectVGird<Item,ItemView>: View where ItemView:View, Item:Identifiable {
    var items:[Item]
    var aspectRatio: CGFloat
    var content: (Item)->ItemView
    var body: some View {
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 100))])
        {
            ForEach(items) {
                item in content(item)
            }
            
        }
        
    }
}


//struct AspectVGird_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGird()
//    }
//}


