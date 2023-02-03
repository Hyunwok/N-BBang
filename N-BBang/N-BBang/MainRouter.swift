//
//  MainRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs

protocol MainInteractable: Interactable, AddingListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    func push(_ viewcontrollerable: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    private let addingBuilder: AddingBuilder
    private var main: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MainInteractable, viewController: MainViewControllable, addingBuilder: AddingBuilder) {
        self.addingBuilder = addingBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func adding() {
        let component = addingBuilder.build(withListener: interactor)
        main = component
        attachChild(component)
        viewController.push(component.viewControllable)
    }
}
