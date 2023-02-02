//
//  ContactBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs

protocol ContactDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var ContactViewController: ContactViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class ContactComponent: Component<ContactDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var ContactViewController: ContactViewControllable {
        return dependency.ContactViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ContactBuildable: Buildable {
    func build(withListener listener: ContactListener) -> ContactRouting
}

final class ContactBuilder: Builder<ContactDependency>, ContactBuildable {

    override init(dependency: ContactDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ContactListener) -> ContactRouting {
        let component = ContactComponent(dependency: dependency)
        let interactor = ContactInteractor()
        interactor.listener = listener
        return ContactRouter(interactor: interactor, viewController: component.ContactViewController)
    }
}
