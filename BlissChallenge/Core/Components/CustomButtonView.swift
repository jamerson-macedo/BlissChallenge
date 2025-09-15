//
//  LoadingButtonView.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//


import SwiftUI

struct CustomButtonView: View {
    var isLoading : Bool = false
    var text: String
    var action : () -> Void
  
    var body: some View {
        VStack{
            Button(action: {
                action()
            }, label: {
                
                Text(text).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical,14)
                    .padding(.horizontal,16)
                    .font(Font.system(.title3).bold())
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(4.0)
                    .overlay(alignment: .trailing){
                        if isLoading{
                            ProgressView() .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1)
                                .padding(.trailing, 30)
                        }
                    }
                    
                    
            })
        }
    }
}

#Preview {
    CustomButtonView(isLoading:true, text: "Loading", action:{
        
    })
}
