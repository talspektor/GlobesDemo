//
//  UserViewModel.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import Foundation

class UserViewModel: BaseViewModel {
    
    let userName: String = "Tal Spektor"
    var currentTime: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - hh:mm:ss"
        return dateFormatter.string(from: date)
    }
    var lastSelection: String?
    
    
}
