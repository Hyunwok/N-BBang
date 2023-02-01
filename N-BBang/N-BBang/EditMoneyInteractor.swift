//
//  EditMoneyInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs
import RxSwift

protocol EditMoneyRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EditMoneyPresentable: Presentable {
    var listener: EditMoneyPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EditMoneyListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditMoneyInteractor: PresentableInteractor<EditMoneyPresentable>, EditMoneyInteractable, EditMoneyPresentableListener {

    weak var router: EditMoneyRouting?
    weak var listener: EditMoneyListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EditMoneyPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
