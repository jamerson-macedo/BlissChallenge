//
//  HomeViewModel.swift
//  BlissChallenge
//
//  Created by Jamerson Macedo on 13/09/25.
//

import Foundation
import Observation
@Observable
final class HomeViewModel {
    
    var goToList : Bool = false
    var goToAvatar : Bool = false
    var gotoRepo : Bool = false
    var search = ""
    
    func loadEmojis() async {
        do{
            let emojis = try await WebService.shared.fetchEmojis()
            print(emojis)
        }catch{
            print("Error")
        }
     
    }
}
