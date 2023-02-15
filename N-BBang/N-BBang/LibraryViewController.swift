//
//  LibraryViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import RIBs
import RxSwift
import UIKit
import PhotosUI
import Mantis

protocol LibraryPresentableListener: AnyObject {
    func selectedLibraryImage(_ image: UIImage?)
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LibraryViewController: UIViewController, LibraryPresentable, LibraryViewControllable {
    
    let phPickerVC: PHPickerViewController
    weak var listener: LibraryPresentableListener?
    
    init() {
        var c = PHPickerConfiguration()
        c.selectionLimit = 1
        c.filter = .any(of: [.images])
        self.phPickerVC = PHPickerViewController(configuration: c)
        super.init(nibName: nil, bundle: nil)
        self.addChild(phPickerVC)
        self.phPickerVC.delegate = self
        self.view.addSubview(phPickerVC.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit LibraryViewController")
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

extension LibraryViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        var config = Config()
                        config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1)
                        config.ratioOptions = .square
                        let c = Mantis.cropViewController(image: image, config: config)
                        c.delegate = self
                        c.modalPresentationStyle = .fullScreen
                        self?.present(c, animated: true)
                    }
                } else {
                    picker.dismiss(animated: true)
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }
}

extension LibraryViewController: CropViewControllerDelegate {
    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        cropViewController.dismiss(animated: true)
        self.dismiss(animated: true)
        listener?.selectedLibraryImage(cropped)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        cropViewController.dismiss(animated: true)
    }
}
