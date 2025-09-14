//
//  EmojiListView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct EmojiListView: View {
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(0..<100) { index in
                        Image("preview")
                            
                    }
                    
                }
            }
        }
    }
}

#Preview {
    EmojiListView()
}
