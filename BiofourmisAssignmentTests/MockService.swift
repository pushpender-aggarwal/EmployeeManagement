//
//  MockService.swift
//  BiofourmisAssignmentTests
//
//  Created by Pushpender on 28/06/21.
//

import XCTest
@testable import BiofourmisAssignment

public class MockService: XCTestCase, EmployeeUseCaseType {
    
    public func getEmployeeList(pageNumber: Int, completion: @escaping (Result<EmployeeListResponse?, APIError>) -> Void) {
        completion(.success(fetchEmployeeSuccessMockResult()))
    }
    
    public func userLoginWith(reuqest: [String : Any], completion: @escaping (Result<LoginResponse?, APIError>) -> Void) {
        completion(.success(fetchLoginSuccessMockResult()))
    }
    
    public func getEmployeeListError(pageNumber: Int, completion: @escaping (Result<EmployeeListResponse?, APIError>) -> Void) {
        completion(.failure(.requestFailed))
    }
    
    public func userLoginWithError(reuqest: [String : Any], completion: @escaping (Result<LoginResponse?, APIError>) -> Void) {
        completion(.failure(.responseUnsuccessful))
    }
    
    //MARK: Mock Methods
    func fetchEmployeeSuccessMockResult() -> EmployeeListResponse {
        let employee1 = Employee(id: 7, email: "michael.lawson@reqres.in", first_name: "Michael", last_name: "Lawson", avatar: "https://reqres.in/img/faces/7-image.jpg")
        let employee2 = Employee(id: 8, email: "lindsay.ferguson@reqres.in", first_name: "Lindsay", last_name: "Ferguson", avatar: "https://reqres.in/img/faces/8-image.jpg")
        let supportObj = Support(url: "", text: "")
        return EmployeeListResponse(page: 1, per_page: 6, total: 12, total_pages: 2, data: [employee1,employee2], support: supportObj)
    }
    
    func fetchLoginSuccessMockResult() -> LoginResponse {
        return LoginResponse(token: "QpwL5tke4Pnpja7X4")
    }
    
}
