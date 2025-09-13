//
//  ContentView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var search = ""
    var body: some View {
        NavigationStack{
            VStack{
                Image("preview")
                CustomButtonView(text: "Random Emoji") {
                    
                }
                CustomButtonView(text: "Emojis List") {
                    
                }
                HStack{
                    SearchBar(text: $search)
                    
                    CustomButtonView(text: "Search Emoji") {
                        
                    }
                }
                CustomButtonView(text: "Avatar List") {
                    
                }
                CustomButtonView(text: "Apple Repos") {
                    
                }
                
                
            }
            .navigationTitle("Emoji")
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack{
        ContentView()
    }
}
