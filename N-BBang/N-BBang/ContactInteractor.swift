//
//  ContactInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs
import RxSwift
import Contacts

protocol ContactRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ContactListener: AnyObject {
    func alert(with reason: ContactAlert)
    
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ContactInteractor: Interactor, ContactInteractable {
    
    public var contact: CNContact? {
        get {
            return privateContact
        } set {
            privateContact = newValue
        }
    }
    
    private var privateContact: CNContact?
    
    private let store = CNContactStore()
    weak var router: ContactRouting?
    weak var listener: ContactListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {
        super.init()
        if !isAuthorizationed() {
            Task.init {
                await requestContactAuthorization()
                getAr()
            }
        } else {
            listener?.alert(with: .unAuthorized)
        }
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    private func getAr() {
        do {
            let request = getContactRequest()
            try store.enumerateContacts(with: request) { [weak self] contact, stop in
                self?.privateContact = contact
            print(contact)
            }
        } catch {
            listener?.alert(with: .failFetch)
        }
    }
    
    private func isAuthorizationed() -> Bool {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized: return true
        default: return false
        }
    }
    
    private func requestContactAuthorization() async -> Bool {
        do {
            try await store.requestAccess(for: .contacts)
            return true
        } catch {
            
            listener?.alert(with: .rejectRequest)
            return false
        }
    }
    
    private func getContactRequest() ->  CNContactFetchRequest {
        let keys = [CNContactGivenNameKey,
                    CNContactFamilyNameKey,
                    CNContactPhoneNumbersKey,
                    CNContactThumbnailImageDataKey,
                    CNContactImageDataKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        request.unifyResults = true
        request.sortOrder = .familyName
        return request
    }
}
