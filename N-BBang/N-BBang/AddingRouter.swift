//
//  AddingRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs

protocol AddingInteractable: Interactable, CameraListener {
    var router: AddingRouting? { get set }
    var listener: AddingListener? { get set }
}

protocol AddingViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddingRouter: ViewableRouter<AddingInteractable, AddingViewControllable>, AddingRouting {

    private let cameraBuildable: CameraBuildable
    private var loggedOut: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AddingInteractable, viewController: AddingViewControllable, cameraBuildable: CameraBuildable) {
        self.cameraBuildable = cameraBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToPhoto() {
        let camera = cameraBuildable.build(withListener: interactor)
        loggedOut = camera
        attachChild(camera)
        viewController.present(camera.viewControllable)

    }
    
//    private func 
}
