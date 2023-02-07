//
//  PhotoViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import RIBs
import RxSwift
import UIKit
import PhotosUI

protocol LibraryPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LibraryViewController: UIViewController, LibraryPresentable, PhotoViewControllable {

    let phPickerVC: PHPickerViewController
    weak var listener: LibraryPresentableListener?
    
    init() {
        var c = PHPickerConfiguration()
        c.selectionLimit = 1
        c.selection = .default
        c.filter = .any(of: [.images])
        self.phPickerVC = PHPickerViewController(configuration: c)
        super.init(nibName: nil, bundle: nil)
        self.addChild(phPickerVC)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phPickerVC.view.frame = self.view.frame
    }
    
    private func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                UserDefaults.standard.set(true, forKey: "IsCamera")
            default:
                DispatchQueue.main.async {
                    Alert.showAlert(with: FailCamearaPhtoo.failToAlbumPermission)
                }
            }
        })
    }
}

extension LibraryViewController {
    
}
