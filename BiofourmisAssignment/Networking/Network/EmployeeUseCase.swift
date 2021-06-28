//
//  EmployeeUseCase.swift
//  BiofourmisAssignment
//
//  Created by Pushpender on 27/06/21.
//

import Foundation

//public enum UseCaseEndpoints {
//    case login
//    case employeeList
//}
//
//extension UseCaseEndpoints {
//    public var path: String {
//        switch self {
//        case .getPictureOfDay: return "api_key"
//        }
//    }
//}

public protocol Endpoint {
    var base: String { get }
    var loginPath: String { get }
    var employeeListPath: String { get }
}

extension Endpoint {
    
    public var base: String {
        return ServiceConstant.baseURL
    }
    
    var loginPath: String {
        return ServiceConstant.Login
    }
    
    var employeeListPath: String {
        return ServiceConstant.EmployeeList
    }
}




public protocol EmployeeUseCaseType {
    func getEmployeeList(pageNumber: Int, completion: @escaping (Result<EmployeeListResponse?, APIError>) -> Void)
    func userLoginWith(reuqest: [String: Any], completion: @escaping (Result<LoginResponse?, APIError>) -> Void)
}

class  EmployeeUseCase: EmployeeUseCaseType, NetworkServiceManagerProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
        self.init(configuration: .default)
    }
    
    func getEmployeeList(pageNumber: Int, completion: @escaping (Result<EmployeeListResponse?, APIError>) -> Void) {
        let path = ServiceConstant.baseURL + ServiceConstant.EmployeeList + String(pageNumber)
        let url = URL(string: path)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.GET
        
        fetch(with: request, decode: { json -> EmployeeListResponse? in
            guard let employeeListModel = json as? EmployeeListResponse else {return  nil}
            return employeeListModel
        }, completion: { value in
            switch value {
            case .success(let model):
                completion(.success(model))
            case .failure:
                completion(.failure(.responseUnsuccessful))
            }
        })
        
    }
    
    func userLoginWith(reuqest: [String: Any], completion: @escaping (Result<LoginResponse?, APIError>) -> Void) {
        let path = ServiceConstant.baseURL + ServiceConstant.Login
        let jsonData = try? JSONSerialization.data(withJSONObject: reuqest, options: .prettyPrinted)
        let url = URL(string: path)
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.POST
        request.httpBody = jsonData
        
        //TODO: This task should be done in Adaptar
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        fetch(with: request, decode: { json -> LoginResponse? in
            guard let employeeListModel = json as? LoginResponse else {return  nil}
            return employeeListModel
        }, completion: { value in
            switch value {
            case .success(let model):
                completion(.success(model))
                print(model)
            case .failure:
                    completion(.failure(.responseUnsuccessful))
            }
        })
    }
}
