//
//  DetailImageInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs
import RxSwift

protocol DetailImageRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailImagePresentable: Presentable {
    var listener: DetailImagePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailImageListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailImageInteractor: PresentableInteractor<DetailImagePresentable>, DetailImageInteractable, DetailImagePresentableListener {

    weak var router: DetailImageRouting?
    weak var listener: DetailImageListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: DetailImagePresentable) {
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
