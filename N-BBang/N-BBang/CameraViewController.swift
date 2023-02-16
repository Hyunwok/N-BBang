//
//  CameraViewController.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/30.
//

import UIKit
import AVFoundation

import RIBs
import RxSwift

protocol CameraPresentableListener: AnyObject {
    func seleteImage(_ image: UIImage?)
}

final class CameraViewController: UIImagePickerController, CameraPresentable, CameraViewControllable {
    
    weak var listener: CameraPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let _ = UIImagePickerController()
        self.allowsEditing = true
        self.mediaTypes = ["public.image"]
        self.sourceType = .camera
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit CameraViewController")
    }
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                UserDefaults.standard.set(true, forKey: "IsAlbum")
            } else {
                DispatchQueue.main.async {
                    Alert.showAlert(with: FailCamearaPhtoo.failToCameraPermission)
                }
            }
        })
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            listener?.seleteImage(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

enum FailCamearaPhtoo: Alertable {
    case failToAlbumPermission
    case failToCameraPermission
    
    var description: String? {
        switch self {
        case .failToAlbumPermission: return "앨범 사용의 요청이 거부되었습니다"
        case .failToCameraPermission: return "카메라 사용의 요청이 거부되었습니다."
        }
    }
    
    var actionType: UIAlertAction.Style {
        return .default
    }
    
    var floatingType: UIAlertController.Style {
        return .alert
    }
    
    var actions: [UIAlertAction] {
        switch self {
        case .failToCameraPermission:
            let asd = UIAlertAction(title: "확인", style: .default) { _ in
                Task {
                    if let url = await URL(string: UIApplication.openSettingsURLString) {
                        // Ask the system to open that URL.
                        await UIApplication.shared.open(url)
                    }
                }
            }
        return [asd]
        case .failToAlbumPermission:
//            UIApplication.openSettingsURLString
            return []
//            UIApplicationOpenNotificationSettingsURLString
        }
    }
    
    var title: String? {
        return "요청 거부"
    }
}
