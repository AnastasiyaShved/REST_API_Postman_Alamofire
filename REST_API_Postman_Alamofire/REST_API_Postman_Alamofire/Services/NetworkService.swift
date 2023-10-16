//
//  NetworkService.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage

class NetworkService {
   
    static func deletePost(postId: Int,
                           callback: @escaping() -> ()) {
        let urlPath = "\(ApiConstans.postsPath)/\(postId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
            }
    }
}
//@escaping  - избегающее забыкание, уходит в другой поток

/// сделать по максимому приложение
/// создание удаление рекдактирование (put poast)
