//
//  FinishRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs

protocol FinishInteractable: Interactable {
    var router: FinishRouting? { get set }
    var listener: FinishListener? { get set }
}

protocol FinishViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FinishRouter: ViewableRouter<FinishInteractable, FinishViewControllable>, FinishRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FinishInteractable, viewController: FinishViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
