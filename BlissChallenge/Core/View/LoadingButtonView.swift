//
//  LoadingButtonView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//


import SwiftUI

struct CustomButtonView: View {
    var showProgress : Bool = false
    var text: String
    var action : () -> Void
    var body: some View {
        ZStack{
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? "" : text ).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical,14)
                    .padding(.horizontal,16)
                    .font(Font.system(.title3).bold())
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(4.0)
                    
                    
            })
            
            ProgressView().progressViewStyle(CircularProgressViewStyle()).opacity(showProgress ? 1 : 0)
        }
    }
}

#Preview {
    CustomButtonView(text: "Loading", action:{
        
    })
}
