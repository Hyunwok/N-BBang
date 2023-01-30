//
//  CameraRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs

protocol CameraInteractable: Interactable {
    var router: CameraRouting? { get set }
    var listener: CameraListener? { get set }
}

protocol CameraViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class CameraRouter: ViewableRouter<CameraInteractable, CameraViewControllable>, CameraRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: CameraInteractable, viewController: CameraViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
