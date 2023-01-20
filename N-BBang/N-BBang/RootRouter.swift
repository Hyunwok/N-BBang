//
//  RootRouter.swift
//  
//
//  Created by 이현욱 on 2023/01/19.
//

import RIBs

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private var main: ViewableRouting?
    private let mainBuildable: MainBuildable

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  mainBuildable: MainBuildable) {
        self.mainBuildable = mainBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routeToMain()
    }
    
    private func routeToMain() {
        let main = mainBuildable.build(withListener: interactor)
        self.main = main
        attachChild(main)
        viewController.replaceModal(viewController: main.viewControllable)
    }
}
