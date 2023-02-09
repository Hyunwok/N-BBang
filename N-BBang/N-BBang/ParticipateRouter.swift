//
//  ParticipateRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/08.
//

import RIBs

protocol ParticipateInteractable: Interactable {
    var router: ParticipateRouting? { get set }
    var listener: ParticipateListener? { get set }
}

protocol ParticipateViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ParticipateRouter: ViewableRouter<ParticipateInteractable, ParticipateViewControllable>, ParticipateRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ParticipateInteractable, viewController: ParticipateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
