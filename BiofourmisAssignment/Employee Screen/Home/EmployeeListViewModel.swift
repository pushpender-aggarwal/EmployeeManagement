//
//  EmployeeListViewModel.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 26/06/21.
//

import Foundation

class EmployeeListViewModel {
    
    let usecase: EmployeeUseCaseType
    let storage: LocalStorageType
    
    private(set) var employeeList: [Employee]? {
        didSet {
            self.bindEmployeeResponseViewModelToController?()
        }
    }
    
    private(set) var showAlert : errorAlert? {
        didSet {
            self.bindAlertViewModelToController?()
        }
    }
    
    var bindEmployeeResponseViewModelToController : (() -> ())?
    var bindAlertViewModelToController : (() -> ())?
    
    init(usecase: EmployeeUseCaseType, storage: LocalStorageType) {
        self.usecase = usecase
        self.storage = storage
        self.getEmployeeData()
    }
    
    func getFullName(firstName: String, lastName: String) -> String {
        return firstName + " " + lastName
    }
    
    func logout() {
        storage.setUserLoginStatusFor(value: false)
    }
    
    func getEmployeeData() {
        self.usecase.getEmployeeList(pageNumber: 2, completion: {[weak self] result in
            switch result {
            case .success(let response):
                self?.employeeList = response?.data
            case .failure(let error):
                self?.showAlert = (true, error.localizedDescription)
            }
        })
    }
    
}
