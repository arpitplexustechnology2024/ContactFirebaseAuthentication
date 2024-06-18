//
//  VerifyOTPViewController.swift
//  ContactNoWithFireBase
//
//  Created by Arpit iOS Dev. on 17/06/24.
//

import UIKit
import FirebaseAuth
import AEOTPTextField

class VerifyOTPViewController: UIViewController {
    
    @IBOutlet weak var otpTextField: AEOTPTextField!
    
    var verificationID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFiledSetup()
        verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    }
    
    func textFiledSetup() {
        otpTextField.otpDelegate = self
        otpTextField.otpTextColor = .red
        otpTextField.otpBackgroundColor = .white
        otpTextField.otpFilledBorderColor = .gray
        otpTextField.otpFilledBackgroundColor = .white
        otpTextField.otpCornerRaduis = 5
        otpTextField.configure(with: 6)
        otpTextField.otpFilledBorderWidth = 1
    }
    
    @IBAction func verifyOTPButtonTapped(_ sender: UIButton) {
        guard let verificationID = verificationID,
              let verificationCode = otpTextField.text else {
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error  {
                print("Error verification OTP : \(error.localizedDescription)")
                return
            }
            
            print("User successfully signed in with phone number: \(authResult?.user.phoneNumber ?? "Unknown")")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomePageViewController") as! HomePageViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension VerifyOTPViewController: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
    }
}
