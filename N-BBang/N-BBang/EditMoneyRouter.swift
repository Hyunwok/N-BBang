//
//  EditMoneyRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs

protocol EditMoneyInteractable: Interactable {
    var router: EditMoneyRouting? { get set }
    var listener: EditMoneyListener? { get set }
}

protocol EditMoneyViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditMoneyRouter: ViewableRouter<EditMoneyInteractable, EditMoneyViewControllable>, EditMoneyRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditMoneyInteractable, viewController: EditMoneyViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
