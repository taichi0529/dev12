//
//  LoginViewController.swift
//  todo
//
//  Created by 中村太一 on 2019/02/09.
//  Copyright © 2019 中村太一. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UserDelegate {
    
    let user = User.shared

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchRegisterButton(_ sender: Any) {
        if let credential = getCredential() {
            user.create(credential: credential)
        }
    }
    
    @IBAction func didTouchLoginButton(_ sender: Any) {
        if let credential = getCredential() {
            user.login(credential: credential)
        }
    }
    // delegate
    func didCreate(error: Error?) {
        if let error = error {
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTaskList()
    }
    // delegate
    func didLogin(error: Error?) {
        if let error = error {
            print (error.localizedDescription)
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTaskList()
    }
    
    func getCredential() -> Credential?{
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if (email.isEmpty) {
            self.alert("エラー", "メールアドレスを入力して下さい", nil)
            return nil
        }
        if (password.isEmpty) {
            self.alert("エラー", "パスワードを入力して下さい", nil)
            return nil
        }
        return Credential(email: email, password: password)
    }
    
    func presentTaskList () {
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TaskNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
    
}
