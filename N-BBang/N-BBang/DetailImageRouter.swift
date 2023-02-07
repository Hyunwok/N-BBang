//
//  DetailImageRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs

protocol DetailImageInteractable: Interactable {
    var router: DetailImageRouting? { get set }
    var listener: DetailImageListener? { get set }
}

protocol DetailImageViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DetailImageRouter: ViewableRouter<DetailImageInteractable, DetailImageViewControllable>, DetailImageRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DetailImageInteractable, viewController: DetailImageViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
