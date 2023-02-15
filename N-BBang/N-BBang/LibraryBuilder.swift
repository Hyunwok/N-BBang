//
//  PhotoBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import RIBs

protocol LibraryDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LibraryComponent: Component<LibraryDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LibraryBuildable: Buildable {
    func build(withListener listener: LibraryListener) -> LibraryRouting
}

final class LibraryBuilder: Builder<LibraryDependency>, LibraryBuildable {

    override init(dependency: LibraryDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LibraryListener) -> LibraryRouting {
        let component = LibraryComponent(dependency: dependency)
        let viewController = LibraryViewController()
        let interactor = LibraryInteractor(presenter: viewController)
        interactor.listener = listener
        return LibraryRouter(interactor: interactor, viewController: viewController)
    }
}
