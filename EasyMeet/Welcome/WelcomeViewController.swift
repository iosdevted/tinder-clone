//
//  WelcomeViewController.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 03/09/2020.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        setupBackgroundTouch()

    }
    //MARK: - IBActions
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        
        if emailTextField.text != "" {
            //reset password
            FUser.resetPassword(email: emailTextField.text!) { (error) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                } else {
                    ProgressHUD.showSuccess("Please check your email!")
                }
            }
        } else {
            //show error
            ProgressHUD.showError("Please insert your email address.")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            ProgressHUD.show()
            
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error, isEmailVerified) in
                
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                } else if isEmailVerified {
                    // enter the application
                    ProgressHUD.dismiss()
                    
                    self.goToApp()
                } else {
                    ProgressHUD.showError("Please verify your email")
                }
            }
            
        } else {
            //show error
            ProgressHUD.showError("All fields are required")
        }
    }
    
    //Mark: - Setup
    
    private func setupBackgroundTouch() {
        backgroundImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        backgroundImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func backgroundTap() {
        dismissKeyboard()
    }
    
    //Mark: - Helpers
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    //MARK: - Navigation
    private func goToApp() {
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
    
}
