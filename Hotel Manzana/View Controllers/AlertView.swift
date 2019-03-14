//
//  AlertView.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 12/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class AlertView: UIView
{
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertMessageLable: UILabel!
    @IBOutlet weak var alertDoneButton: UIButton!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not implemented")
    }
    
    private func commonInit()
    {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        parentView.backgroundColor = .clear
        
        alertView.layer.cornerRadius = 8
        alertDoneButton.layer.cornerRadius = 8
        alertDoneButton.layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        alertDoneButton.layer.borderWidth = 2
        
        alertImage.layer.cornerRadius = 30
        alertImage.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        alertImage.layer.borderWidth = 2
    }
    
    func showAlert(title: String, message: String)
    {
        alertImage.image = UIImage(named: "success")
        self.alertTitleLabel.text = title
        self.alertMessageLable.text = message
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func alertDoneButtonPressed(_ sender: UIButton)
    {
        parentView.removeFromSuperview()
    }
}

