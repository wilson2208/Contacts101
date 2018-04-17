//
//  ContactsListViewController.swift
//  Contacts101
//
//  Created by Wilson Sanchez on 4/15/18.
//  Copyright © 2018 Wilson Sanchez. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class ContactsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    var indicator = UIActivityIndicatorView()
    let contactListCellReuseIdentifier = "ContactListCell"
    var contacts :[CNContact] = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator()
        contacts = ContactManager.shared.contacts
        
        NotificationCenter.default.addObserver(self, selector: #selector(contactsLoadDone), name: Notifications.CONTACTS_LOAD_DONE, object: nil)
 
    }
    
    func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @objc func contactsLoadDone() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addContactPressed(_ sender: Any) {
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "addContactViewController")
        //navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func showActivityIndicator() {
        if !indicator.isAnimating{
            print("Activity Indicator in ContactsViewController Showing")
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            indicator.startAnimating()
            indicator.backgroundColor = UIColor.white
        }
    }
    
    func hideActivityIndicator() {
        if indicator.isAnimating{
            print("Activity Indicator in ContactsViewController hiding")
            tableView.isScrollEnabled = true
            tableView.allowsSelection = true
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
        }
    }
    
}

//MARK : Extending the viewController to add the methods numberOfRowsInSection, cellForRowAtIndex, and didSelectRowAt
extension ContactsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ContactListCellTableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: contactListCellReuseIdentifier) as? ContactListCellTableViewCell{
            cell = reuseCell
        }else{
            cell = ContactListCellTableViewCell(style: .default, reuseIdentifier: contactListCellReuseIdentifier)
        }
        let contactName:String? = ("\(contacts[indexPath.row].givenName) \(contacts[indexPath.row].familyName)")
        
        cell.contactName?.text = contactName
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "contactsDetailViewController") as! ContactsDetailTableViewController
        vc.viewedContact = contacts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
         */
    }
}
