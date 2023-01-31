//
//  DetailViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs
import RxSwift
import UIKit

protocol DetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DetailViewController: UIViewController, DetailPresentable, DetailViewControllable {

    weak var listener: DetailPresentableListener?
}
