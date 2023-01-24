//
//  I18nRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs

protocol I18nInteractable: Interactable {
    var router: I18nRouting? { get set }
    var listener: I18nListener? { get set }
}

protocol I18nViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class I18nRouter: Router<I18nInteractable>, I18nRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: I18nInteractable, viewController: I18nViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: I18nViewControllable
}
