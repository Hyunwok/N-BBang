//
//  ParticipateBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/08.
//

import RIBs

protocol ParticipateDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ParticipateComponent: Component<ParticipateDependency> {
    let rootViewController: ParticipateViewController
    
    init(rootViewController: ParticipateViewController, dependency: ParticipateDependency) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ParticipateBuildable: Buildable {
    func build(withListener listener: ParticipateListener, people: [String]) -> ParticipateRouting
}

final class ParticipateBuilder: Builder<ParticipateDependency>, ParticipateBuildable {

    override init(dependency: ParticipateDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ParticipateListener, people: [String]) -> ParticipateRouting {
        let viewController = ParticipateViewController(people: people)
        let component = ParticipateComponent(rootViewController: viewController, dependency: dependency)
        let interactor = ParticipateInteractor(presenter: viewController)
        let contact = ContactBuilder(dependency: component)
        interactor.listener = listener
        return ParticipateRouter(interactor: interactor, viewController: viewController, contactBuildable: contact)
    }
}

extension ParticipateComponent: ContactDependency {
    var ContactViewController: ContactViewControllable {
        return rootViewController
    }
}
