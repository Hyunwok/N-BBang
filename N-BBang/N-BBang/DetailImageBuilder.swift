//
//  DetailImageBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/07.
//

import RIBs

protocol DetailImageDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DetailImageComponent: Component<DetailImageDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DetailImageBuildable: Buildable {
    func build(withListener listener: DetailImageListener, image: UIImage) -> DetailImageRouting
}

final class DetailImageBuilder: Builder<DetailImageDependency>, DetailImageBuildable {

    override init(dependency: DetailImageDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailImageListener, image: UIImage) -> DetailImageRouting {
        let component = DetailImageComponent(dependency: dependency)
        let viewController = DetailImageViewController(image: image)
        let interactor = DetailImageInteractor(presenter: viewController)
        interactor.listener = listener
        return DetailImageRouter(interactor: interactor, viewController: viewController)
    }
}
