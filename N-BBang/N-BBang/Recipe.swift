//
//  Recipe.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import Foundation

struct Recipe {
    static let empty = Recipe(calculates: [Calculate.empty], title: "", isCleared: false, totalPrice: 0)
    
    var calculates: [Calculate]
    var title: String
    var isCleared: Bool
    var totalPrice: Int
}
