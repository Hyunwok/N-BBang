//
//  ConnectingAlert.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/06.
//

import UIKit

enum ContactAlert: String, Alertable {
    case unAuthorized = "연락처 사용이 거절되었습니다."
    case rejectRequest = "연락처 사용 요청이 거절되었습니다."
    case failFetch = "연락처를 가져오기에 실패했습니다."
    
    var description: String? {
        switch self {
        case .unAuthorized: return "연락처 사용이 거절되었습니다."
        case .rejectRequest: return "연락처 사용 요청이 거절되었습니다."
        case .failFetch: return "연락처를 가져오기에 실패했습니다."
        }
    }
    
    var actionType: UIAlertAction.Style {
        return .default
    }
    
    var floatingType: UIAlertController.Style {
        return .alert
    }
    
    var title: String? {
        return "실패"
    }
    
    var actions: [UIAlertAction] {
        return [UIAlertAction(title: "OK", style: .default, handler: nil)]
    }
}
