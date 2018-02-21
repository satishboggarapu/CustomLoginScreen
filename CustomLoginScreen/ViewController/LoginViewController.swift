//
//  LoginViewController.swift
//  CustomLoginScreen
//
//  Created by Satish Boggarapu on 2/20/18.
//  Copyright © 2018 Satish Boggarapu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
//import MaterialComponents

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: UI Elements
    private var scrollView: UIScrollView!
    private var backgroundImageView: UIImageView!
    private var iconView: UIView!
    private var iconImageView: UIImageView!
    private var nameView: UIView!
    private var nameTextField: UITextField!
    private var nameSeperator: UIView!
    private var passwordView: UIView!
    private var passwordTextField: UITextField!
    private var passwordSeperator: UIView!
    private var signInButton: UIButton!
    private var signUpButton: UIButton!
    
    // MARK: Attributes
    var ref: DatabaseReference!
    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        initializeBackgroudImageView()
        initializeIconView()
        initializeIconImageView()
        initializeScrollView()
        initializeNameView()
        initializePasswordView()
        initializeSignInButton()
        initializeSignUpButton()
        
    }
    
    // MARK: Initializer Fuctions
    
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
    
    private func initializeIconView() {
        iconView = UIView()
        let width = view.bounds.width * 0.40
        let y = ((view.bounds.height * 0.5) - width) / 2
        iconView.frame = CGRect(x: (view.bounds.width - width)/2, y: y, width: width, height: width)
        iconView.backgroundColor = UIColor.white
        iconView.layer.cornerRadius = width/2
        self.view.addSubview(iconView)
        
        // add blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = iconView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = iconView.bounds.width/2
        blurEffectView.clipsToBounds = true
        iconView.addSubview(blurEffectView)
    }
    
    private func initializeIconImageView() {
        iconImageView = UIImageView()
        iconImageView.frame = CGRect(x: -1, y: -1, width: iconView.frame.width+2 , height: iconView.frame.height+2)
        iconImageView.image = UIImage(named: "safe_travels")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
        iconImageView.clipsToBounds = true
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor.white.cgColor
        iconView.addSubview(iconImageView)
    }
    
    private func initializeScrollView() {
        scrollView = UIScrollView()
        let y: CGFloat = Constraints.getLoginScreenNameViewY(iconView: iconView.frame, view: view.frame)
        scrollView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height - y)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - y)
        self.view.addSubview(scrollView)
    }
    
    private func initializeNameView() {
        nameView = UIView()
        let y: CGFloat = Constraints.getLoginScreenNameViewY(iconView: iconView.frame, view: view.frame)
        nameView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        scrollView.addSubview(nameView)
        
        // icon
        let icon = UIImageView()
        icon.frame = CGRect(x: 25, y: 0, width: 30, height: 30)
        icon.image = UIImage(named: "ic_account_circle_48dp")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .white
        nameView.addSubview(icon)
        
        // name label
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: icon.frame.origin.x + icon.frame.width + 25, y: 0, width: 50, height: 20)
        nameLabel.text = "NAME"
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 15)
        nameLabel.textColor = .white
        nameView.addSubview(nameLabel)
        
        // textfield
        nameTextField = UITextField()
        nameTextField.frame = CGRect(x: nameLabel.frame.origin.x, y: 26, width: self.view.frame.width - nameLabel.frame.origin.x*2, height: 36)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        nameTextField.textColor = .white
        nameTextField.font = UIFont(name: (nameTextField.font?.fontName)!, size: 20)
        nameTextField.delegate = self
        nameView.addSubview(nameTextField)
        
        // seperator
        nameSeperator = UIView()
        nameSeperator.frame = CGRect(x: 0, y: nameView.frame.origin.y + nameView.frame.height + 10, width: self.view.frame.width, height: 0.7)
        let imageview = UIImageView()
        imageview.frame = nameSeperator.bounds
        imageview.image = UIImage(named: "seperator_3")!
        nameSeperator.addSubview(imageview)
        scrollView.addSubview(nameSeperator)
    }
    
    private func initializePasswordView() {
        passwordView = UIView()
        let y = nameView.frame.origin.y + nameView.frame.height + 35
        passwordView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 64)
        scrollView.addSubview(passwordView)
        
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
        passwordTextField.delegate = self
        passwordView.addSubview(passwordTextField)
        
        // seperator
        passwordSeperator = UIView()
        passwordSeperator.frame = CGRect(x: 0, y: passwordView.frame.origin.y + passwordView.frame.height + 10, width: self.view.frame.width, height: 0.7)
        let imageview = UIImageView()
        imageview.frame = passwordSeperator.bounds
        imageview.image = UIImage(named: "seperator_3")!
        passwordSeperator.addSubview(imageview)
        scrollView.addSubview(passwordSeperator)
    }
    
    private func initializeSignInButton() {
        signInButton = UIButton()
        let y = Constraints.getLoginScreenSignInButtonY(passwordView: passwordView.frame)
        let width: CGFloat = self.view.frame.width - 50
        signInButton.frame = CGRect(x: 25, y: y, width: width, height: 50)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.layer.cornerRadius = 25
        signInButton.titleLabel?.font = UIFont(name: (signInButton.titleLabel?.font.fontName)!, size: 15)
        signInButton.addTarget(self, action: #selector(signInButtonAction(_:)), for: .touchUpInside)
        scrollView.addSubview(signInButton)
    }
    
    private func initializeSignUpButton() {
        signUpButton = UIButton()
        
        let y = Constraints.getLoginScreenSignUpButtonY(view: self.view.frame)
        let width: CGFloat = self.view.frame.width - 40
        signUpButton.frame = CGRect(x: 20, y: y, width: width, height: 30)
        
        let main_string = "Don't have an account? Sign Up"
        var attribute = NSMutableAttributedString()
        attribute = NSMutableAttributedString(string: main_string as String, attributes: [NSAttributedStringKey.font:UIFont(name: (signUpButton.titleLabel?.font.fontName)!, size: 15)!])
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white , range: NSRange(location: 23, length: 7))
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.gray , range: NSRange(location: 0, length: 23))
        
        signUpButton.setAttributedTitle(attribute, for: .normal)
        //        signUpButton.setTitle("DON'T HAVE AN ACCOUNT? SIGN UP", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: (signUpButton.titleLabel?.font.fontName)!, size: 15)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction(_:)), for: .touchUpInside)
        scrollView.addSubview(signUpButton)
    }
    
    // MARK:
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addObservers()
        // listener gets called whenever the user's sign-in state changes
        //        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        //            // ...
        //        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeObservers()
        // detach the listener
        //        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @objc func signInButtonAction(_ sender: UIButton) {
        //        let email = nameTextField.text!
        //        let password = passwordTextField.text!
        let email = "satish@gmail.com"
        let password = "satish99"
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("invalid login")
                return
            }
            print("logged in")
            self.performSegue(withIdentifier: "tabBarControllerSegue", sender: nil)
        }
    }
    
    @objc func signUpButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpViewController", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: ScrollView Functions for keyboard
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



