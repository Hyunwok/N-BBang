//
//  ParticipateRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/08.
//

import RIBs

protocol ParticipateInteractable: Interactable, ContactListener {
    var router: ParticipateRouting? { get set }
    var listener: ParticipateListener? { get set }
}

protocol ParticipateViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ParticipateRouter: ViewableRouter<ParticipateInteractable, ParticipateViewControllable>, ParticipateRouting {

    private var currentChild: RouterScope?
    private let contactBuildable: ContactBuildable

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: ParticipateInteractable,
         viewController: ParticipateViewControllable,
         contactBuildable: ContactBuildable) {
        self.contactBuildable = contactBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func initContact() {
        let contact = contactBuildable.build(withListener: interactor)
        self.currentChild = contact
        attachChild(contact)
    }
}
