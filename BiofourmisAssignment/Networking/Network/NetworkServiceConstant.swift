//
//  NetworkServiceConstant.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 27/06/21.
//

import Foundation

public enum ServiceConstant {
    static let baseURL = "https://reqres.in/"
    static let Login = "api/login"
    static let EmployeeList = "api/users?page="
}

public enum HTTPMethod {
    static let GET = "GET"
    static let POST = "POST"
}
