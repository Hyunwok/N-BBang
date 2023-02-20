//
//  AddingRouter.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs

protocol AddingInteractable: Interactable, CameraListener, LibraryListener, EditMoneyListener, DetailImageListener, ParticipateListener {
    var router: AddingRouting? { get set }
    var listener: AddingListener? { get set }
}

protocol AddingViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable, _ style: UIModalPresentationStyle)
    func push(_ viewController: ViewControllable)
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddingRouter: ViewableRouter<AddingInteractable, AddingViewControllable>, AddingRouting {
    
    private let cameraBuildable: CameraBuildable
    private let libraryBuildable: LibraryBuildable
    private let editMoneyBuildable: EditMoneyBuildable
    private let detailImageBuildable: DetailImageBuildable
    private let participateBuildable: ParticipateBuildable
    private var currentChild: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: AddingInteractable,
         viewController: AddingViewControllable,
         cameraBuildable: CameraBuildable,
         libraryBuildable: LibraryBuildable,
         editMoneyBuildable: EditMoneyBuildable,
         detailImageBuildable: DetailImageBuildable,
         participateBuildable: ParticipateBuildable) {
        self.cameraBuildable = cameraBuildable
        self.libraryBuildable = libraryBuildable
        self.editMoneyBuildable = editMoneyBuildable
        self.detailImageBuildable = detailImageBuildable
        self.participateBuildable = participateBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToPhoto() {
        detachedChild()
        let camera = cameraBuildable.build(withListener: interactor)
        currentChild = camera
        attachChild(camera)
        viewController.present(camera.viewControllable, .automatic)
    }
    
    func routeToLibrary() {
        detachedChild()
        let library = libraryBuildable.build(withListener: interactor)
        currentChild = library
        attachChild(library)
        viewController.present(library.viewControllable, .automatic)
    }
    
    func routeToEditMoney(_ calculate: Calculate) {
        detachedChild()
        let editMoney = editMoneyBuildable.build(withListener: interactor, calculate: calculate)
        currentChild = editMoney
        attachChild(editMoney)
        viewController.push(editMoney.viewControllable)
    }
    
    func routeToDetailImage(_ image: UIImage) {
        detachedChild()
        let detail = detailImageBuildable.build(withListener: interactor, image: image)
        currentChild = detail
        attachChild(detail)
        viewController.present(detail.viewControllable, .fullScreen)
    }
    
    func routeToParticipate(before: [String]) {
        detachedChild()
        let participate = participateBuildable.build(withListener: interactor, people: before)
        currentChild = participate
        attachChild(participate)
        viewController.present(participate.viewControllable, .automatic)
    }
    
    func detachedAll() {
        detachedChild()
    }
    
    private func detachedChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
        }
    }
}
