//
//  RegisterViewController.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 03/09/2020.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - Vars
    var isMale = true
    var datePicker = UIDatePicker()
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()
        setupDatePicker()
    }
    
    //MARK: - IBActions
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if isTextDataInputed() {
            if passwordTextField.text! == confirmPasswordTextField.text! {
                registerUser()
            } else {
                ProgressHUD.showError("Passwords don't match!")
            }
        } else {
            ProgressHUD.showError("All fields are required!")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func genderSegmentValueChanged(_ sender: UISegmentedControl) {
        isMale = sender.selectedSegmentIndex == 0 ? true : false
    }
    
    //MARK: - Setup
    private func setupDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        dateOfBirthTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor().primary()
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        dateOfBirthTextField.inputAccessoryView = toolBar
    }
    
    
    
    private func setupBackgroundTouch() {
        backgroundImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        backgroundImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func backgroundTap() {
        dismissKeyboard()
    }
    
    //MARK: - Helpers
    @objc private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    @objc func handleDatePicker() {
        dateOfBirthTextField.text = datePicker.date.longDate()
    }
    
    private func isTextDataInputed() -> Bool {
        return usernameTextField.text != "" && emailTextField.text != "" && cityTextField.text != "" && dateOfBirthTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""
    }
    
    //MARK: - RegisterUser
    private func registerUser() {
        
        ProgressHUD.show()
        
        FUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!, userName: usernameTextField.text!, city: cityTextField.text!, isMale: isMale, dateOfBirth: Date(), completion: { error in
            
            if error == nil {
                ProgressHUD.showSuccess("Verification email sent")
                self.dismiss(animated: true, completion: nil)
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
        })
    }
}
