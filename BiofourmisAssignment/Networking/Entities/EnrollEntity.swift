//
//  EnrollEntity.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 27/06/21.
//

import Foundation

public struct LoginRequest: Codable {
    public let email: String
    public let password: String
}

public struct LoginResponse: Codable {
    public let token: String
}
