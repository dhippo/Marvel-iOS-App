//
//  ViewModel.swift
//  trainingApp
//
//  Created by reda.mimouni.ext on 27/10/2023.
//

import Foundation

class ViewModel {
    func onClick(login: String?, password: String?) -> Bool {
        if login == "JOHN DOE", password == "OMNES" {
            return true
        } else {
            return false
        }
    }
}
