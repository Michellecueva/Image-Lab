//
//  ComicAPIHelper.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/7/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct  ComicAPIHelper {
    private init() {}
    
    static var shared = ComicAPIHelper()
    
    var defaultStr = "https://xkcd.com/info.0.json"
    
    var urlStr = "https://xkcd.com/info.0.json"
    
    func getUrl(num:Int) -> String {
        return "https://xkcd.com/\(num)/info.0.json"
    }
    
    
    mutating func getComic(num: Int?, completionHandler: @ escaping (Result<Comic, AppError>) -> ()) {
        
        if num != nil {
            urlStr = getUrl(num: num!)
        } else {
            urlStr = defaultStr
        }
        
        NetworkManager.shared.fetchData(urlString: urlStr) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let comicInfo = try JSONDecoder().decode(Comic.self, from: data)
                    completionHandler(.success(comicInfo))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
