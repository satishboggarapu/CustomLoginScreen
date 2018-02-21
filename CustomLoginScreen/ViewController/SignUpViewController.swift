//
//  SignUpViewController.swift
//  CustomLoginScreen
//
//  Created by Satish Boggarapu on 2/20/18.
//  Copyright © 2018 Satish Boggarapu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // MARK: UIElements
    private var backgroundImageView: UIImageView!
    private var backButton: UIButton!
    
    private var nameView: UIView!
    private var nameTextField: UITextField!
    private var nameSeperator: UIView!
    private var emailView: UIView!
    private var emailTextField: UITextField!
    private var emailSeperator: UIView!
    private var passwordView: UIView!
    private var passwordTextField: UITextField!
    private var passwordSeperator: UIView!
    private var signUpButton: UIButton!
    
    // MARK: Attributes
    var ref: DatabaseReference!
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initializeBackgroudImageView()
        initializeBackButton()
        initializeNameView()
        initializeEmailView()
        initializePasswordView()
        initializeSignUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref = Database.database().reference()
    }
    
    private func initializeBackgroudImageView() {
        backgroundImageView = UIImageView()
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.image = UIImage(named: "background_image_4")
        self.view.insertSubview(backgroundImageView, at: 0)
        
        // add blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)
    }
    
    private func initializeBackButton() {
        backButton = UIButton()
        backButton.frame = CGRect(x: 25, y: 35, width: 30, height: 30)
        backButton.setImage(UIImage(named: "ic_arrow_left_48dp")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .white
        backButton.setTitle("", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    private func initializeNameView() {
        nameView = UIView()
        let y: CGFloat = self.view.frame.height * 0.25
        nameView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 64)
        self.view.addSubview(nameView)
        
        // icon
        let icon = UIImageView()
        icon.frame = CGRect(x: 25, y: 0, width: 30, height: 30)
        icon.image = UIImage(named: "ic_account_circle_48dp")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .white
        nameView.addSubview(icon)
        
        // name label
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: icon.frame.origin.x + icon.frame.width + 25, y: 0, width: 100, height: 20)
        nameLabel.text = "USERNAME"
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 15)
        nameLabel.textColor = .white
        nameView.addSubview(nameLabel)
        
        // textfield
        nameTextField = UITextField()
        nameTextField.frame = CGRect(x: nameLabel.frame.origin.x, y: 26, width: self.view.frame.width - nameLabel.frame.origin.x*2, height: 36)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        nameTextField.textColor = .white
        nameTextField.font = UIFont(name: (nameTextField.font?.fontName)!, size: 20)
        nameView.addSubview(nameTextField)
        
        // seperator
        nameSeperator = UIView()
        nameSeperator.frame = CGRect(x: 0, y: nameView.frame.origin.y + nameView.frame.height + 10, width: self.view.frame.width, height: 0.7)
        let imageview = UIImageView()
        imageview.frame = nameSeperator.bounds
        imageview.image = UIImage(named: "seperator_3")!
        nameSeperator.addSubview(imageview)
        self.view.addSubview(nameSeperator)
    }
    
    private func initializeEmailView() {
        emailView = UIView()
        let y = nameView.frame.origin.y + nameView.frame.height + 35
        emailView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 64)
        self.view.addSubview(emailView)
        
        // icon
        let icon = UIImageView()
        icon.frame = CGRect(x: 25, y: 0, width: 30, height: 30)
        icon.image = UIImage(named: "ic_email_48dp")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .white
        emailView.addSubview(icon)
        
        // name label
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: icon.frame.origin.x + icon.frame.width + 25, y: 0, width: 100, height: 20)
        nameLabel.text = "EMAIL"
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 15)
        nameLabel.textColor = .white
        emailView.addSubview(nameLabel)
        
        // textfield
        emailTextField = UITextField()
        emailTextField.frame = CGRect(x: nameLabel.frame.origin.x, y: 26, width: self.view.frame.width - nameLabel.frame.origin.x*2, height: 36)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        emailTextField.textColor = .white
        emailTextField.font = UIFont(name: (nameTextField.font?.fontName)!, size: 20)
        emailView.addSubview(emailTextField)
        
        // seperator
        emailSeperator = UIView()
        emailSeperator.frame = CGRect(x: 0, y: emailView.frame.origin.y + emailView.frame.height + 10, width: self.view.frame.width, height: 0.7)
        let imageview = UIImageView()
        imageview.frame = emailSeperator.bounds
        imageview.image = UIImage(named: "seperator_3")!
        emailSeperator.addSubview(imageview)
        self.view.addSubview(emailSeperator)
    }
    
    private func initializePasswordView() {
        passwordView = UIView()
        let y = emailView.frame.origin.y + emailView.frame.height + 35
        passwordView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 64)
        self.view.addSubview(passwordView)
        
        // icon
        let icon = UIImageView()
        icon.frame = CGRect(x: 25, y: 0, width: 30, height: 30)
        icon.image = UIImage(named: "ic_lock_48dp")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .white
        passwordView.addSubview(icon)
        
        // name label
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: icon.frame.origin.x + icon.frame.width + 25, y: 0, width: 100, height: 20)
        nameLabel.text = "PASSWORD"
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 15)
        nameLabel.textColor = .white
        passwordView.addSubview(nameLabel)
        
        // textfield
        passwordTextField = UITextField()
        passwordTextField.frame = CGRect(x: nameLabel.frame.origin.x, y: 26, width: self.view.frame.width - nameLabel.frame.origin.x*2, height: 36)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        passwordTextField.textColor = .white
        passwordTextField.font = UIFont(name: (nameTextField.font?.fontName)!, size: 20)
        passwordTextField.isSecureTextEntry = true
        passwordView.addSubview(passwordTextField)
        
        // seperator
        passwordSeperator = UIView()
        passwordSeperator.frame = CGRect(x: 0, y: passwordView.frame.origin.y + passwordView.frame.height + 10, width: self.view.frame.width, height: 0.7)
        let imageview = UIImageView()
        imageview.frame = passwordSeperator.bounds
        imageview.image = UIImage(named: "seperator_3")!
        passwordSeperator.addSubview(imageview)
        self.view.addSubview(passwordSeperator)
    }
    
    private func initializeSignUpButton() {
        signUpButton = UIButton()
        let y = Constraints.getLoginScreenSignInButtonY(passwordView: passwordView.frame)
        let width: CGFloat = self.view.frame.width - 50
        signUpButton.frame = CGRect(x: 25, y: y, width: width, height: 50)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.white.cgColor
        signUpButton.layer.cornerRadius = 25
        signUpButton.titleLabel?.font = UIFont(name: (signUpButton.titleLabel?.font.fontName)!, size: 15)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(signUpButton)
    }
    
    @objc func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signUpButtonAction(_ sender: UIButton) {
        let userName = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        print("email is already in use")
                    case .invalidEmail:
                        print("invalid email")
                    case .weakPassword:
                        print("weak password")
                    default:
                        print("Create User Error: \(error!)")
                    }
                }
                
                print("could not save username")
                return
            }
            print("succesfully saved")
            print(user)
            self.saveUserInfo(user!, withUsername: userName)
            self.performSegue(withIdentifier: "tabBarControllerSegue", sender: nil)
        }
    }
    
    
    
    func saveUserInfo(_ user: User, withUsername username: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        
        changeRequest?.commitChanges() { (error) in
            if error != nil {
                print(error)
                return
            }
            
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

