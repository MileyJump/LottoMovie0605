//
//  MovieManager.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/20/24.
//

import UIKit
import Alamofire

class MovieManager {
    
    
    static let shared = MovieManager()
    
    
    private init() { }
    
    func callRequest(text: String, completionHandler: @escaping (String) -> Void) {
        
//        guard let text = searchTextField.text else { return }
        
        AF.request("\(APIURL.movieURL)\(text)").responseDecodable(of: MovieBoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                print("성공!")
//                self.list = value.boxOfficeResult.dailyBoxOfficeList
//                completionHandler(value.boxOfficeResult.dailyBoxOfficeList)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
