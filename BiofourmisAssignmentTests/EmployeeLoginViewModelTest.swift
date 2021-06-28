//
//  EmployeeLoginViewModelTest.swift
//  BiofourmisAssignmentTests
//
//  Created by Pushpender on 28/06/21.
//

import XCTest
@testable import BiofourmisAssignment

class EmployeeLoginViewModelTest: XCTestCase {

    var useCase: EmployeeUseCaseType!
    var storage: LocalStorageType!
    var sut: EmployeeLoginViewModel!
    
    override func setUp() {
        super.setUp()
        useCase = MockService() // Mock service
        storage = UserDefaultsLocalStorage() //Here we can also use any mock class
        sut = EmployeeLoginViewModel(usecase: useCase, storage: storage)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        useCase = nil
        sut = nil
        storage = nil
    }
    
    func testGetEmployeeDataSuccess() {
        sut.putloginRequest()
        XCTAssertTrue(storage.getUserLoginStatusFor(), "Login should be true")
    }

}
