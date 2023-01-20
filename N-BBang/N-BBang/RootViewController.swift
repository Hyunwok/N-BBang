//
//  RootViewController.swift
//  
//
//  Created by 이현욱 on 2023/01/19.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    private var targetViewController: ViewControllable?
    weak var listener: RootPresentableListener?
    private var animationInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
    func replaceModal(viewController: ViewControllable) {
        targetViewController = viewController
        
        guard !animationInProgress else {
            return
        }

        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                if self?.targetViewController != nil {
                    self?.presentTargetViewController()
                } else {
                    self?.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }
    
    private func presentTargetViewController() {
        if let targetViewController = targetViewController {
            animationInProgress = true
            let vc = navgi( targetViewController.uiviewController)
          vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: false) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
    
    private func navgi(_ view: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: view)
    }
}
