//
//  Alert.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import UIKit

protocol Alertable {
    var description: String? { get }
    var actionType: UIAlertAction.Style { get }
    var floatingType: UIAlertController.Style { get }
    var actions: [UIAlertAction] { get }
    var title: String? { get }
}

struct Alert {
    static func showAlert(with waring: Alertable) {
        let vc = UIApplication.topViewController()
        let alert = UIAlertController(title: waring.title, message: waring.description, preferredStyle: waring.floatingType)
        for action in waring.actions {
            alert.addAction(action)
        }
        vc?.present(alert, animated: true)
    }
}
