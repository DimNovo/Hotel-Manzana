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
    
    var registration = Registration()

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
        hideKeyboardWhenTappedAround()
        updateNumberOfGuests()
        updateUserRegistrationInfo()
    }
    
    // MARK: - ... Methods
    func updateUserRegistrationInfo()
    {
        guard navigationItem.title == "Edit Registration" else { return }
        doneBarButtonItem.title = "Save"
        
        firstNameTextField.text = registration.firstName
        lastNameTextField.text = registration.lastName
        emailTextField.text = registration.emailAddress
        checkInDatePicker.date = registration.checkInDate
        checkOutDatePicker.date = registration.checkOutDate
        numberOfAdultsStepper.value = Double(registration.numberOfAdults)
        numberOfChildrenStepper.value = Double(registration.numberOfChildren)
        wifiSwitch.isOn = registration.wifi
        roomType = registration.roomType
        
        updateDateViews()
        updateNumberOfGuests()
    }
    
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
        guard let roomType = roomType else { return }
        
            registration = Registration(
            firstName: firstNameTextField.text!,
            lastName: lastNameTextField.text!,
            emailAddress: emailTextField.text!,
            checkInDate: checkInDatePicker.date,
            checkOutDate: checkOutDatePicker.date,
            numberOfAdults: Int(numberOfAdultsStepper.value),
            numberOfChildren: Int(numberOfChildrenStepper.value),
            wifi: wifiSwitch.isOn,
            roomType: roomType
        )
        
        AlertView.instance.showAlert(title: "Success",
                                     message: "For: \(registration.firstName) \(registration.lastName)\nEmail: \(registration.emailAddress)\nAdults: \(registration.numberOfAdults) Children: \(registration.numberOfChildren)\nRoom: \(roomType.name)\nWiFi: \(wifiSwitch.isOn ? "Yes" : "No")\nCheck In: \(checkInDateLabel.text!)\nCheck Out: \(checkOutDateLabel.text!)\n\nApproximate cost: \(Int(((checkOutDatePicker.date.timeIntervalSinceNow - checkInDatePicker.date.timeIntervalSinceNow)/86400))*roomType.price + ((Int(checkOutDatePicker.date.timeIntervalSinceNow - checkInDatePicker.date.timeIntervalSinceNow))/86400)*(wifiSwitch.isOn ? 10 : 0))$")

        dismissKeyboard()
        performSegue(withIdentifier: "SaveSegue", sender: self)
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
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let roomType = roomType else { return }
        guard segue.identifier == "RoomSelectionSegue" else { return }
        
        let controller = segue.destination as! RoomSelectionTableViewController
        controller.selectedRoomType = roomType
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "SaveRoomSegue" else { return }
        
        let controller = segue.source as! RoomSelectionTableViewController
        roomType = controller.selectedRoomType
        
        if navigationItem.title == "Edit"
        {
            doneBarButtonItem.isEnabled = true
        }
    }
}
