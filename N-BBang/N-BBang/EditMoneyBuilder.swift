//
//  EditMoneyBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs

protocol EditMoneyDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditMoneyComponent: Component<EditMoneyDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditMoneyBuildable: Buildable {
    func build(withListener listener: EditMoneyListener) -> EditMoneyRouting
}

final class EditMoneyBuilder: Builder<EditMoneyDependency>, EditMoneyBuildable {

    override init(dependency: EditMoneyDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditMoneyListener) -> EditMoneyRouting {
        let component = EditMoneyComponent(dependency: dependency)
        let viewController = EditMoneyViewController()
        let interactor = EditMoneyInteractor(presenter: viewController)
        interactor.listener = listener
        return EditMoneyRouter(interactor: interactor, viewController: viewController)
    }
}
