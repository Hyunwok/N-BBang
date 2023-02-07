//
//  FinishInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs
import RxSwift

protocol FinishRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FinishPresentable: Presentable {
    var listener: FinishPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FinishListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FinishInteractor: PresentableInteractor<FinishPresentable>, FinishInteractable, FinishPresentableListener {

    weak var router: FinishRouting?
    weak var listener: FinishListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FinishPresentable) {
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
