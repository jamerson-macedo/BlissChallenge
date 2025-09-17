//
//  ErrorMessageView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 15/09/25.
//

import SwiftUI

struct ErrorMessageView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .font(.title)
            .bold()
            .padding()
    }
}
