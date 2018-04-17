//
//  ContactManager.swift
//  Contacts101
//
//  Created by Wilson Sanchez on 4/15/18.
//  Copyright © 2018 Wilson Sanchez. All rights reserved.
//

import Foundation
import Contacts

final class ContactManager {
    
    var contacts:[CNContact] = [CNContact]()
    var contactStore: CNContactStore = CNContactStore()
    var isContactsFetching = false
    static let shared = ContactManager()
    
    private init() {
        print("ContactManager Initialized")
    }
    
    func loadContacts() -> Void{
        
        self.isContactsFetching = false
        
        NotificationCenter.default.post(name: Notifications.CONTACTS_LOAD_DONE, object: nil)
        
        
        AppDelegate.getAppDelegate().requestForContactAccess(completionHandler: {
            accessGranted in
            self.isContactsFetching = true
            self.contacts = [CNContact]()
            if(accessGranted){
                let keys:[CNKeyDescriptor] = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                do {
                    try self.contactStore.enumerateContacts(with: request) {
                        (contact, stop) in
                        self.contacts.append(contact)
                        //
                    }
                }
                catch {
                    print("unable to fetch contacts")
                }
            }else {
                
            }
            self.isContactsFetching = false
        })
    }
    
}

