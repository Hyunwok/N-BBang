//
//  ContactInteractor.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/26.
//

import RIBs
import RxSwift
import Contacts
import ContactsUI

protocol ContactRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ContactListener: AnyObject {
    func contacts(with: [Person])
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ContactInteractor: Interactor, ContactInteractable {
    private let store = CNContactStore()
    weak var router: ContactRouting?
    weak var listener: ContactListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {
        super.init()
        
        if isAuthorizationed() {
            getContacts()
        } else {
            Task.init {
                if await requestContactAuthorization() {
                    getContacts()
                } else {
                    Alert.showAlert(with: ContactAlert.unAuthorized)
                }
            }
        }
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    private func getContacts() {
        DispatchQueue.global().async {
            do {
                var contacts = [Person]()
                let request = self.getContactRequest()
                try self.store.enumerateContacts(with: request) { contact, stop in
                    let person = Person(name: contact.familyName + contact.givenName,
                                        loan: 0,
                                        isPaid: false,
                                        image: contact.thumbnailImageData)
                    contacts.append(person)
                }
                self.listener?.contacts(with: contacts)
            } catch {
                Alert.showAlert(with: ContactAlert.failFetch)
            }
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
            return try await store.requestAccess(for: .contacts)
        } catch {
            Alert.showAlert(with: ContactAlert.rejectRequest)
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
