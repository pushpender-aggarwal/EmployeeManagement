//
//  EmployeeListViewModelTest.swift
//  BiofourmisAssignmentTests
//
//  Created by Pushpender on 28/06/21.
//

import XCTest
@testable import BiofourmisAssignment

class EmployeeListViewModelTest: XCTestCase {
    var useCase: EmployeeUseCaseType!
    var storage: LocalStorageType!
    var sut: EmployeeListViewModel!
    
    override func setUp() {
        super.setUp()
        useCase = MockService() // Mock service
        storage = UserDefaultsLocalStorage() //Here we can also use any mock class
        sut = EmployeeListViewModel(usecase: useCase, storage: storage)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        useCase = nil
        sut = nil
        storage = nil
    }
    
    func testGetEmployeeDataSuccess() {
        sut.getEmployeeData()
        XCTAssertEqual(sut.employeeList?.count, 2)
    }
    
    func testGetFullName() {
        XCTAssertEqual(sut.getFullName(firstName: "Pushpender", lastName: "Aggarwal"), "Pushpender Aggarwal")
    }
    
}
