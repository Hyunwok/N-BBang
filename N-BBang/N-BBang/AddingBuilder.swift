//
//  AddingBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs

protocol AddingDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AddingComponent: Component<AddingDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AddingBuildable: Buildable {
    func build(withListener listener: AddingListener) -> AddingRouting
}

final class AddingBuilder: Builder<AddingDependency>, AddingBuildable {

    override init(dependency: AddingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddingListener) -> AddingRouting {
        let component = AddingComponent(dependency: dependency)
        let viewController = AddingViewController()
        let camera = CameraBuilder(dependency: component)
        let interactor = AddingInteractor(presenter: viewController)
        interactor.listener = listener
        return AddingRouter(interactor: interactor, viewController: viewController, cameraBuildable: camera)
    }
}

extension AddingComponent: CameraDependency {} 
