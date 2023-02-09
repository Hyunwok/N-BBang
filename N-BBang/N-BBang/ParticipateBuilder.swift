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

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ParticipateBuildable: Buildable {
    func build(withListener listener: ParticipateListener) -> ParticipateRouting
}

final class ParticipateBuilder: Builder<ParticipateDependency>, ParticipateBuildable {

    override init(dependency: ParticipateDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ParticipateListener) -> ParticipateRouting {
        let component = ParticipateComponent(dependency: dependency)
        let viewController = ParticipateViewController()
        let interactor = ParticipateInteractor(presenter: viewController)
        interactor.listener = listener
        return ParticipateRouter(interactor: interactor, viewController: viewController)
    }
}
