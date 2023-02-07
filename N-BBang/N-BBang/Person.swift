//
//  Person.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import Foundation

struct Person: Equatable {
    private let uuid = UUID().uuidString
    var name: String
    var loan: Int
    var isPaid: Bool
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
