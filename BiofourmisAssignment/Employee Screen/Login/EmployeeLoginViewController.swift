//
//  ViewController.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 25/06/21.
//

import UIKit

class EmployeeLoginViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    private var loginViewModel =  EmployeeLoginViewModel(usecase: EmployeeUseCase(), storage: UserDefaultsLocalStorage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTF.isSecureTextEntry = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.iconImageView.image = UIImage(named: "login_logo")
        setupUI()
        self.addTapGesture()
        callToViewModelForUIUpdate()
    }
    
    private func setupUI() {
        self.emailTF.placeholder = "Email"
        self.passwordTF.placeholder = "Password"
        self.nextButton.setTitle("Login", for: .normal)
        self.nextButton.backgroundColor = UIColor(red: 57/255.0, green: 134/255.0, blue: 176/255.0, alpha: 1.0)
        self.nextButton.tintColor = UIColor.white
        self.activity.isHidden = true
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.loginViewModel.email = self.emailTF.text
        self.loginViewModel.password = self.passwordTF.text
        self.activity.isHidden = false
        self.loginViewModel.putloginRequest()
    }
    
    func callToViewModelForUIUpdate() {
        self.loginViewModel.bindResponseViewModelToController = { [weak self] in
            guard let weakSelf = self else {return}
            let storyboard = UIStoryboard(name: StoryBoardName.main, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.employeeList)
            weakSelf.navigationController?.pushViewController(vc, animated: true)
            weakSelf.activity.isHidden = true
        }
        
        self.loginViewModel.bindAlertViewModelToController = { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.activity.isHidden = true
            let alert = UIAlertController(title: AppConstant.alertTitle, message: self?.loginViewModel.showAlert?.1, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: AppConstant.alertButtonTitle, style: UIAlertAction.Style.default, handler: nil))
            weakSelf.present(alert, animated: true, completion: nil)
        }
    }

}

