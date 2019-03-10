//
//  GuestListTableViewController.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 08/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class GuestListTableViewController: UITableViewController
{
    // MARK: - ... Properties
     private var guestFirstName: String?
     private var guestLastName: String?
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "GuestRegistrationSegue" else
        {
            return
        }
        
        let controller = segue.destination as! UINavigationController
        let rootController = controller.viewControllers.first as! RegistrationTableViewController
        
        print(#function, "\(String(describing: guestFirstName)) \(String(describing: guestLastName))")
        
        rootController.guestToFirstName = guestFirstName
        rootController.guestToLastName = guestLastName
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue) {}
    
    // MARK: - ... Methods
    func configure(cell: UITableViewCell, with guestRegistration: Registration)
    {
        cell.textLabel?.text = guestRegistration.firstName
        cell.detailTextLabel?.text = guestRegistration.lastName
    }
}

// MARK: - ... GuestListTableViewController Extensions
extension GuestListTableViewController
{
    // MARK: - ... UITabelViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guestFirstName = Registration.allGuests[indexPath.row].firstName
        guestLastName = Registration.allGuests[indexPath.row].lastName
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - ... UITabelViewDataSource Protocol
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Registration.allGuests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestRegistrationCell")!
        let guest = Registration.allGuests[indexPath.row]
        
        configure(cell: cell, with: guest)
        
        return cell
    }
}
