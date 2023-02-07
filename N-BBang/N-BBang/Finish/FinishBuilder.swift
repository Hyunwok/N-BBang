//
//  FinishBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs

protocol FinishDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FinishComponent: Component<FinishDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FinishBuildable: Buildable {
    func build(withListener listener: FinishListener) -> FinishRouting
}

final class FinishBuilder: Builder<FinishDependency>, FinishBuildable {

    override init(dependency: FinishDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FinishListener) -> FinishRouting {
        let component = FinishComponent(dependency: dependency)
        let viewController = FinishViewController()
        let interactor = FinishInteractor(presenter: viewController)
        interactor.listener = listener
        return FinishRouter(interactor: interactor, viewController: viewController)
    }
}
