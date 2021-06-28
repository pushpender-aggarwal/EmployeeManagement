//
//  EmployeeListViewController.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 26/06/21.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    private var employeeListViewModel =  EmployeeListViewModel(usecase: EmployeeUseCase(), storage: UserDefaultsLocalStorage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.employeeTableView.dataSource = self
        self.employeeTableView.delegate = self
        addLogoutButton()
        callToViewModelForUIUpdate()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
        self.title = "Employee List"
        self.employeeTableView.tableFooterView = UIView()
    }
    
    private func addLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutClicked))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc private func logoutClicked() {
        showLogoutAlert()
        self.employeeListViewModel.logout()
        navigateToLogin()
    }
    
    //TODO: Navigation Should also be part of Viewmodel. Need to a Protocol that will take care of screen movement
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: StoryBoardName.main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.login)
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    func showLogoutAlert() {
        let alert = UIAlertController(title: "Important Alert", message: "You will be logout from the application.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.employeeListViewModel.logout()
            self.navigateToLogin()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func callToViewModelForUIUpdate() {
        self.employeeListViewModel.bindEmployeeResponseViewModelToController = { [weak self] in
            guard let weakSelf = self else {return}
            weakSelf.activity.isHidden = true
            weakSelf.employeeTableView.reloadData()
        }
        
        self.employeeListViewModel.bindAlertViewModelToController = { [weak self] in
            guard let weakSelf = self else {return}
            let alert = UIAlertController(title: AppConstant.alertTitle, message: weakSelf.employeeListViewModel.showAlert?.1, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: AppConstant.alertButtonTitle, style: UIAlertAction.Style.default, handler: nil))
            weakSelf.present(alert, animated: true, completion: nil)
        }
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (employeeListViewModel.employeeList?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let employee = employeeListViewModel.employeeList?[indexPath.row]
        cell.textLabel?.text = (employee?.first_name ?? "") + (employee?.last_name ?? "")
        cell.detailTextLabel?.text = employee?.email
        cell.imageView?.image = UIImage(named: "placeholder")
        if let avatarUrl = employee?.avatar, let url = URL(string: avatarUrl) {
            cell.imageView?.load(url: url)
        }
        return cell
    }
    
    
}

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
