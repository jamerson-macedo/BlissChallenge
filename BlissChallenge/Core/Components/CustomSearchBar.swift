//
//  SearchBar.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(18)
                .padding(.horizontal, 24)
            
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .overlay {
                    HStack {
                        if text.isEmpty {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.blue)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                                .transition(.blurReplace)
                        } else {
                            Button {
                                withAnimation(.easeInOut) {
                                    self.text = ""
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                    .transition(.blurReplace)
                            }
                        }
                    }
                    .animation(.spring(), value: text)
                }
        }
        
    }
}

#Preview {
    SearchBar(text: .constant("Jamerson"))
}

