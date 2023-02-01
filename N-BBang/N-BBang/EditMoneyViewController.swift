//
//  EditMoneyViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs
import RxSwift
import UIKit

protocol EditMoneyPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class EditMoneyViewController: UIViewController, EditMoneyPresentable, EditMoneyViewControllable {

    weak var listener: EditMoneyPresentableListener?
}
