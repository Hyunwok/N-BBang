//
//  DetailBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs

protocol DetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DetailComponent: Component<DetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DetailBuildable: Buildable {
    func build(withListener listener: DetailListener) -> DetailRouting
}

final class DetailBuilder: Builder<DetailDependency>, DetailBuildable {

    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailListener) -> DetailRouting {
        let component = DetailComponent(dependency: dependency)
        let viewController = DetailViewController()
        let interactor = DetailInteractor(presenter: viewController)
        interactor.listener = listener
        return DetailRouter(interactor: interactor, viewController: viewController)
    }
}
