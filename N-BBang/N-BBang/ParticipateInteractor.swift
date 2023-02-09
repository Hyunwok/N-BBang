//
//  ParticipateInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/08.
//

import RIBs
import RxSwift

protocol ParticipateRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ParticipatePresentable: Presentable {
    var listener: ParticipatePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ParticipateListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ParticipateInteractor: PresentableInteractor<ParticipatePresentable>, ParticipateInteractable, ParticipatePresentableListener {

    weak var router: ParticipateRouting?
    weak var listener: ParticipateListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ParticipatePresentable) {
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
