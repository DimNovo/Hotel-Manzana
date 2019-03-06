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

    // MARK: - ... Properties
    let checkInLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkInPickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutLabelIndexPath = IndexPath(row: 2, section: 1)
    let checkOutPickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInPickerShow: Bool = true // Пикер ввода даты въезда открыт изначально
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
    }
    
    // MARK: - ... Methods
    func updateDateViews()
    {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dataFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "GMT")
        dataFormatter.timeZone = (timeZone! as TimeZone)
        dataFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dataFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dataFormatter.string(from: checkInDatePicker.date)
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
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAddress: emailAddress,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdults: numberOfAdults,
            numberOfChildren: numberOfChildren
        )
        
        print(#function, registration)
        firstNameTextField.text!.removeAll()
        lastNameTextField.text!.removeAll()
        emailTextField.text!.removeAll()
        doneBarButtonItem.isEnabled.toggle()
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
            doneBarButtonItem.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            doneBarButtonItem.isEnabled = true
        }
            
        else
            
        {
            doneBarButtonItem.isEnabled = false
        }
    }
}

// MARK: - ... UITableViewDelegate
extension RegistrationTableViewController/*: UITableViewDelegate*/
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath
        {
        case checkInLabelIndexPath:
            isCheckInPickerShow.toggle()
            
            isCheckOutPickerShow.toggle() // Закрывает Picker даты выезда
            
        case checkOutLabelIndexPath:
            isCheckOutPickerShow.toggle()
            
            isCheckInPickerShow.toggle() // Закрывает Picker даты въезда
            
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
