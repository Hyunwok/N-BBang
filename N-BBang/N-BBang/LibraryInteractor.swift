//
//  LibraryInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import RIBs
import RxSwift

protocol LibraryRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LibraryPresentable: Presentable {
    var listener: LibraryPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LibraryListener: AnyObject {
    func selectedLibraryImage(_ image: UIImage?)
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LibraryInteractor: PresentableInteractor<LibraryPresentable>, LibraryInteractable, LibraryPresentableListener {

    weak var router: LibraryRouting?
    weak var listener: LibraryListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LibraryPresentable) {
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
    
    func selectedLibraryImage(_ image: UIImage?) {
        listener?.selectedLibraryImage(image)
    }
}
