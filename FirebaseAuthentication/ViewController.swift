//
//  ViewController.swift
//  ContactNoWithFireBase
//
//  Created by Arpit iOS Dev. on 17/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var textFileView: UIView!
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFileView.layer.borderWidth = 1
        textFileView.layer.cornerRadius = 12
        myView.layer.cornerRadius = 30
        myView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    
    @IBAction func sendOTPButtonTapped(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberTextField.text else {
            return
        }
        sendOTP(to: phoneNumber)
    }
    
    func sendOTP(to phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error sending OTP : \(error.localizedDescription)")
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VerifyOTPViewController") as! VerifyOTPViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

