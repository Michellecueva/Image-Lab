//
//  UserAPIHelper.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct  UserAPIHelper {
    private init() {}
    
    static let shared = UserAPIHelper()
    
    let urlStr = "https://randomuser.me/api/?results=100"
    
    func getUser(completionHandler: @ escaping (Result<[User], AppError>) -> ()) {
        
        NetworkManager.shared.fetchData(urlString: urlStr) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let userInfo = try JSONDecoder().decode(UserWrapper.self, from: data)
                    completionHandler(.success(userInfo.results))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
