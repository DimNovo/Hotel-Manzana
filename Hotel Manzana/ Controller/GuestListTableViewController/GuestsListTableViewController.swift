//
//  GuestListTableViewController.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 08/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class GuestsListTableViewController: UITableViewController
{
    // MARK: - ... Properties
    var registrations = [Registration]()
    
    // MARK: - ... UIViewController Methods
    override func viewDidLoad()
        {
            super.viewDidLoad()
            registrations = Registration.loadData() ?? []
        }
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "EditSegue" else { return }
        
        let controller = segue.destination as! UINavigationController
        let destination = controller.viewControllers.first as! RegistrationTableViewController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        
        destination.registration = registrations[index]
        destination.navigationItem.title = "Edit"
        
        print(#function, destination.registration)
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "SaveSegue" else { return }
        let sourse = segue.source as! RegistrationTableViewController
        let registration = sourse.registration
        
        if sourse.navigationItem.title == "Edit",
            let indexPath = tableView.indexPathForSelectedRow
        {
            registrations[indexPath.row] = registration
            
            print(#function, "Edit: \(registration)")
        }
            
        else if sourse.navigationItem.title == "New Registration",
            !sourse.registration.firstName.isEmpty &&
                !sourse.registration.lastName.isEmpty &&
                !sourse.registration.emailAddress.isEmpty
        {
            let indexPath = IndexPath(row: registrations.count, section: 0)
            registrations.append(registration)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            print(#function, "New Registration: \(registration)")
        }
        tableView.reloadData()
    }
    
    // MARK: - ... Methods
    func configure(cell: UITableViewCell, with registration: Registration)
    {
        cell.textLabel?.text = (registration.firstName + " " + registration.lastName)
        cell.detailTextLabel?.text = registration.emailAddress
    }
}
