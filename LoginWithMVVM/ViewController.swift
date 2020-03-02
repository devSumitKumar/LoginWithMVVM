//
//  ViewController.swift
//  LoginWithMVVM
//
//  Created by KHAMARI, SUMIT on 3/2/20.
//  Copyright © 2020 KHAMARI, SUMIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets -
    @IBOutlet weak var txtFldUserName: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var loginViewModel: LoginVCModel!

    //MARK: - View LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpVIewComponents()
    }
    
    //MARK: - Design After StoryBoard -
    private func setUpVIewComponents(){
        loginViewModel = LoginVCModelDelegate.init(delegate: self)
    }
    
    private func showAlertToUser(strMsg : String, strTilte : String){
        let alertView = UIAlertController(title: strTilte, message: strMsg, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok" , style: .default) {
            UIAlertAction in
        }
        
        //Button Two
        alertView.addAction(btnOk)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - Button Actions -
    @IBAction func btnLoginAction(_ sender: Any) {
        
        loginViewModel.login(withUsername: txtFldUserName.text, password: txtFldPassword.text)
        
    }
    
    
}

//MARK: - TextField Delegate Method -
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
}

//MARK: - LoginViewModel Delegate Method -
extension ViewController : LoginActionService {

    func loginSuccessfull() {
        
    }
    
    func handle(error: Error) {
        
        if  error.localizedDescription == STRING_CONSTANT.ERROR_USERNAME{
            showAlertToUser(strMsg: STRING_CONSTANT.ERROR_USERNAME, strTilte: "Error")
        }else{
        //blank passowrd
            showAlertToUser(strMsg: STRING_CONSTANT.ERROR_PASSWORD, strTilte: "Error")
        }
    }

    func loginResponseStatus(loginreponseStatus: Int) {
        if loginreponseStatus == 1{
            //show success to user
        }else{
            
        }
    }

    
}
