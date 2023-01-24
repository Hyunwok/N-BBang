//
//  I18nBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs

protocol I18nDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var I18nViewController: I18nViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class I18nComponent: Component<I18nDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var I18nViewController: I18nViewControllable {
        return dependency.I18nViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol I18nBuildable: Buildable {
    func build(withListener listener: I18nListener) -> I18nRouting
}

final class I18nBuilder: Builder<I18nDependency>, I18nBuildable {

    override init(dependency: I18nDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: I18nListener) -> I18nRouting {
        let component = I18nComponent(dependency: dependency)
        let interactor = I18nInteractor()
        interactor.listener = listener
        return I18nRouter(interactor: interactor, viewController: component.I18nViewController)
    }
}
