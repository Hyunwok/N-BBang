//
//  MainBuilder.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs

protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency> {
    let rootViewController: MainViewController

    init(dependency: MainDependency,
         rootViewController: MainViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        let viewController = MainViewController()
        let component = MainComponent(dependency: dependency, rootViewController: viewController)
        let adding = AddingBuilder(dependency: component)
        let contact = ContactBuilder(dependency: component)
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        return MainRouter(interactor: interactor, viewController: viewController, addingBuilder: adding)
    }
}

extension MainComponent: ContactDependency {
    var ContactViewController: ContactViewControllable {
        return rootViewController
    }
}

extension MainComponent: AddingDependency {
    
}
