//
//  ProfileTableViewController.swift
//  EasyMeet
//
//  Created by Ted Hyeong on 26/09/2020.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var profileCellBackgroundView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var aboutMeView: UIView!
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var cityCountryLabel: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var educationTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var lookingForTextField: UITextField!
    
    //MARK: - Vars
    var editingMode = false
    
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgrounds()
        updateEditingMode()

    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - IBActions
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        editingMode.toggle()
        updateEditingMode()
        
        editingMode ? showKeyboard() : hideKeyboard()
        showSaveButton()
    }
    
    @objc func editUserData() {
        
    }
    
    //MARK: - Setup
    private func setupBackgrounds() {
        
        profileCellBackgroundView.clipsToBounds = true
        profileCellBackgroundView.layer.cornerRadius = 100
        profileCellBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        aboutMeView.layer.cornerRadius = 10
    }
    
    private func showSaveButton() {
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editUserData))
        
        navigationItem.rightBarButtonItem = editingMode ? saveButton : nil
    }
    
    //MARK: - Editing Mode
    private func updateEditingMode() {
        
        aboutMeTextView.isUserInteractionEnabled = editingMode
        jobTextField.isUserInteractionEnabled = editingMode
        educationTextField.isUserInteractionEnabled = editingMode
        genderTextField.isUserInteractionEnabled = editingMode
        cityTextField.isUserInteractionEnabled = editingMode
        countryTextField.isUserInteractionEnabled = editingMode
        heightTextField.isUserInteractionEnabled = editingMode
        lookingForTextField.isUserInteractionEnabled = editingMode
        
    }

    //MARK: - Helpers
    private func showKeyboard() {
        self.aboutMeTextView.becomeFirstResponder()
    }
    
    private func hideKeyboard() {
        self.view.endEditing(false)
    }
}
