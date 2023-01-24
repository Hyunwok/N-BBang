//
//  Calculate.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import UIKit

struct Calculate: Equatable {
    static let empty = Calculate(price: 0, members: [], memberCnt: 0, place: "")
    
    private let id = UUID().uuidString
    var price: Int
    var members: [String]
    var memberCnt: Int
    var recipe: UIImage?
    var place: String
    
    static func == (lhs: Calculate, rhs: Calculate) -> Bool {
        return lhs.id == rhs.id
    }
}
