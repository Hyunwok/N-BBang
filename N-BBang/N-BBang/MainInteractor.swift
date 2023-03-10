//
//  MainInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs
import RxSwift

protocol MainRouting: ViewableRouting {
    func adding()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MainPresentable) {
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
    
    func alert(with reason: ContactAlert) {
        print("asd")
        Alert.showAlert(with: reason)
    }
    
    func setting() {
        print("Setting")
    }
    
    func adding() {
        router?.adding()
    }
}
