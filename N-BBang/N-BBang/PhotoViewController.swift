//
//  PhotoViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import RIBs
import RxSwift
import UIKit
import Photos

protocol PhotoPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PhotoViewController: UIViewController, PhotoPresentable, PhotoViewControllable {

    weak var listener: PhotoPresentableListener?
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
