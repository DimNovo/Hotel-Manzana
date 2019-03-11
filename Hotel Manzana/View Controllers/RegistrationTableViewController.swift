//
//  RegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 02/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController
{
    // MARK: - ... @IBOutlet
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    // MARK: - ... Properties
    let checkInLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkInPickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutLabelIndexPath = IndexPath(row: 2, section: 1)
    let checkOutPickerIndexPath = IndexPath(row: 3, section: 1)
    
    let generator = UINotificationFeedbackGenerator()
    
    var guestToFirstName: String?
    var guestToLastName: String?
    
    var isCheckInPickerShow: Bool = false
    {
        didSet
        {
            checkInDatePicker.isHidden = !isCheckInPickerShow
        }
    }
    var isCheckOutPickerShow: Bool = false
    {
        didSet
        {
            checkOutDatePicker.isHidden = !isCheckOutPickerShow
        }
    }
    
    var roomType: RoomType?
    {
        didSet
        {
            roomTypeLabel.text = roomType?.name
        }
    }
    
    // MARK: - ... UIViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        doneBarButtonItem.isEnabled = false
        updateDateViews()
        updateNumberOfGuests()
        hideKeyboardWhenTappedAround()
        
        self.firstNameTextField!.text = guestToFirstName
        self.lastNameTextField!.text = guestToLastName
    }
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let roomType = roomType else
        {
            return
        }
        guard segue.identifier == "RoomSelectionSegue" else
        {
            return
        }
        
        let controller = segue.destination as! RoomSelectionTableViewController
        controller.selectedRoomType = roomType
        
    }
    
    // MARK: - ... Methods
    func updateDateViews()
    {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dataFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dataFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests()
    {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    // MARK: - ... @IBAction
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem)
    {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let emailAddress = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let wifi = wifiSwitch.isOn
        
        guard let roomType = roomType else
            
        {
            return
        }
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAddress: emailAddress,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdults: numberOfAdults,
            numberOfChildren: numberOfChildren,
            wifi: wifi,
            roomType: roomType
        )
        
        let alertController = UIAlertController(
            title: "Registration Done Successfully",
            message: "For: \(firstName) \(lastName)\nAdults: \(numberOfAdults) Children: \(numberOfChildren)\nRoom: \(roomType.name)\nDate: Check In: \(checkInDateLabel.text!)\n Date: Check Out: \(checkOutDateLabel.text!)\n",
            preferredStyle: .actionSheet)
        
        let doneAction = UIAlertAction(title: "Thank you for your order!",
                                       style: .destructive, handler: nil)
        
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        print(#function, registration)
        
        firstNameTextField.text!.removeAll()
        lastNameTextField.text!.removeAll()
        emailTextField.text!.removeAll()
        
        doneBarButtonItem.isEnabled.toggle()
        generator.notificationOccurred(.success)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker)
    {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper)
    {
        updateNumberOfGuests()
    }
    
    @IBAction func textFieldsCheck(_ sender: UITextField)
    {
        if !(firstNameTextField.text?.isEmpty)!,
            !(lastNameTextField.text?.isEmpty)!,
            !(emailTextField.text?.isEmpty)!
        {
            doneBarButtonItem.isEnabled = true
        }
            
        else
            
        {
            doneBarButtonItem.isEnabled = false
        }
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "SaveRoomSegue" else { return }
        
        let controller = segue.source as! RoomSelectionTableViewController
        roomType = controller.selectedRoomType
        
    }
}

// MARK: - ... RegistrationTableViewController Extensions
extension RegistrationTableViewController
{
    // MARK: - ... UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath
        {
        case checkInLabelIndexPath:
            
            if !isCheckInPickerShow
            {
                isCheckInPickerShow.toggle()
            }
            else
            {
                isCheckOutPickerShow.toggle()
            }
            
        case checkOutLabelIndexPath:          // муть мутная...
            
            if  isCheckOutPickerShow
            {
                isCheckOutPickerShow.toggle()
            }
            else
            {
                isCheckInPickerShow.toggle()
            }
            
        default:
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath
        {
        case checkInPickerIndexPath:
            return isCheckInPickerShow ? 216 : 0
        case checkOutPickerIndexPath:
            return isCheckOutPickerShow ? 216 : 0
        default:
            return 44
        }
    }
}
