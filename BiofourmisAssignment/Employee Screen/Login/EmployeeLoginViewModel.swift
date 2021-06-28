//
//  EmployeeLoginViewModel.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 26/06/21.
//

import Foundation

typealias errorAlert = (Bool?, String?)
class EmployeeLoginViewModel {
    
    let usecase: EmployeeUseCaseType
    let storage: LocalStorageType
    
    private(set) var loginSuccesful: LoginResponse? {
        didSet {
            self.bindResponseViewModelToController?()
        }
    }
    
    private(set) var showAlert : errorAlert? {
        didSet {
            self.bindAlertViewModelToController?()
        }
    }
    
    var email: String? = nil
    var password: String? = nil
    
    var bindResponseViewModelToController : (() -> ())?
    var bindAlertViewModelToController : (() -> ())?
    
    init(usecase: EmployeeUseCaseType, storage: LocalStorageType) {
        self.usecase = usecase
        self.storage = storage
    }
    
    private func setLoginStatus() {
        storage.setUserLoginStatusFor(value: true)
    }
    
    func getRequestData() -> [String : Any] {
        return ["email" : email ?? "", "password": password ?? ""]
    }
    
    func putloginRequest() {
        let requestData = getRequestData()
        self.usecase.userLoginWith(reuqest: requestData, completion: {[weak self] result in
            guard let weakSelf = self else {return}
            switch result {
            case .success:
                weakSelf.setLoginStatus()
                weakSelf.bindResponseViewModelToController?()
            case .failure(let error):
                weakSelf.showAlert = (true, error.localizedDescription)
            }
        })
    }
    
}
