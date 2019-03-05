//
//  keyboardHideByTapAroundExtension.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 05/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

extension RegistrationTableViewController
{
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self,
                                   action: #selector(RegistrationTableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
        
    {
        view.endEditing(true)
    }
}
