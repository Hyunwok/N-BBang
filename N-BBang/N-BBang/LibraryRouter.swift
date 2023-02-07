//
//  PhotoRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import RIBs

protocol LibraryInteractable: Interactable {
    var router: LibraryRouting? { get set }
    var listener: LibraryListener? { get set }
}

protocol LibraryViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LibraryRouter: ViewableRouter<LibraryInteractable, LibraryViewControllable>, LibraryRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LibraryInteractable, viewController: LibraryViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
