//
//  CameraBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import RIBs

protocol CameraDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CameraComponent: Component<CameraDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CameraBuildable: Buildable {
    func build(withListener listener: CameraListener) -> CameraRouting
}

final class CameraBuilder: Builder<CameraDependency>, CameraBuildable {

    override init(dependency: CameraDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CameraListener) -> CameraRouting {
        let component = CameraComponent(dependency: dependency)
        let viewController = CameraViewController()
        let interactor = CameraInteractor(presenter: viewController)
        interactor.listener = listener
        return CameraRouter(interactor: interactor, viewController: viewController)
    }
}
