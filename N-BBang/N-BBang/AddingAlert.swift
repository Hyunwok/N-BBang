//
//  AddingAlert.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import UIKit

enum AddingAlert: Alertable {
    case camera
    case library
    
    var description: String? {
        return nil
    }
    
    var actionType: UIAlertAction.Style {
        return .default
    }
    
    var floatingType: UIAlertController.Style {
        return .actionSheet
    }
    
    var actions: [UIAlertAction] {
        guard let vc = UIApplication.topViewController() as? AddingViewController else { return [] }
        return [UIAlertAction(title: "사진 촬영", style: .default, handler: { _ in
            vc.listener?.camera()
        }), UIAlertAction(title: "기존 항목 선택", style: .default, handler: { _ in
            vc.listener?.library()
        }), UIAlertAction(title: "취소", style: .cancel)]
    }
    
    var title: String? {
        return "영수증 추가"
    }
}
