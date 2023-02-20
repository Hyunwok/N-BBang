//
//  AddingInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import RIBs
import RxSwift

protocol AddingRouting: ViewableRouting {
    func routeToPhoto()
    func routeToLibrary()
    func routeToDetailImage(_ image: UIImage)
    func routeToEditMoney(_ calculate: Calculate)
    func detachedAll()
    func routeToParticipate(before: [String])
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddingPresentable: Presentable {
    var listener: AddingPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    
    func selectedImage(_ image: UIImage?)
    func deleteImage()
    func done(with contacts: [Person])
}

protocol AddingListener: AnyObject {
    
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AddingInteractor: PresentableInteractor<AddingPresentable>, AddingInteractable, AddingPresentableListener {

    weak var router: AddingRouting?
    weak var listener: AddingListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AddingPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func camera() {
        router?.routeToPhoto()
    }
    
    func library() {
        router?.routeToLibrary()
    }
    
    func selectCameraImage(_ image: UIImage) {
        presenter.selectedImage(image)
    }
    
    func selectedLibraryImage(_ image: UIImage?) {
        router?.detachedAll()
        presenter.selectedImage(image)
    }
    
    func detailImage(_ image: UIImage) {
        router?.routeToDetailImage(image)
    }
    
    func editMoney(_ calculate: Calculate) {
        router?.routeToEditMoney(calculate)
    }
    
    func deleteImage() {
        presenter.deleteImage()
    }
    
    func addParticipate(before: [String]) {
        router?.routeToParticipate(before: before)
    }
    
    func done(with contacts: [Person]) {
        presenter.done(with: contacts)
    }
}
