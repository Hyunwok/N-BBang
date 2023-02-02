//
//  ContactRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs

protocol ContactInteractable: Interactable {
    var router: ContactRouting? { get set }
    var listener: ContactListener? { get set }
}

protocol ContactViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class ContactRouter: Router<ContactInteractable>, ContactRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: ContactInteractable, viewController: ContactViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: ContactViewControllable
}
