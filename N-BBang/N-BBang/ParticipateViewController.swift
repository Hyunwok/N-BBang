//
//  ParticipateViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/08.
//

import RIBs
import RxSwift
import UIKit

protocol ParticipatePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ParticipateViewController: UIViewController, ParticipatePresentable, ParticipateViewControllable {

    weak var listener: ParticipatePresentableListener?
}
