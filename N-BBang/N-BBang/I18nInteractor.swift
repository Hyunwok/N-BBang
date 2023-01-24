//
//  I18nInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs
import RxSwift

protocol I18nRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol I18nListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class I18nInteractor: Interactor, I18nInteractable {

    weak var router: I18nRouting?
    weak var listener: I18nListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
}
