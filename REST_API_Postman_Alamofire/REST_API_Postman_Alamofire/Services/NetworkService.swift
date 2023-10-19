//
//  NetworkService.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import SwiftUI

class NetworkService {
    ///@escaping  - избегающее забыкание, уходит в другой поток
    static func deletePost(postId: Int,
                           callback: @escaping() -> ()) {
        let urlPath = "\(ApiConstans.postsPath)/\(postId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
            }
    }
    
    static func fetchComments(postID: Int,
                              callback: @escaping (_ result: [Comment]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstans.commentsPath)?postId=\(postID)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                
                var value: [Comment]?
                var err: Error?
                
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        value = try JSONDecoder().decode([Comment].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    
    static func fetchAlbums(userID: Int,
                            callback: @escaping (_ result: [Album]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstans.albumsPath)?userId=\(userID)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                
                var value: [Album]?
                var err: Error?
                
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        value = try JSONDecoder().decode([Album].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    static func fetchPhotos(albumId: Int,
                            callback: @escaping (_ result: [Photo]?, _ error: Error?) -> ()) {
        let urlPath = "\(ApiConstans.photosPath)?albumId=\(albumId)"
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in
                
                var value: [Photo]?
                var err: Error?
                
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    print(JSON(data))
                    do {
                        value = try JSONDecoder().decode([Photo].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    static func getThumbnail(thumbnailUrl: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> ()) {
        AF.request(thumbnailUrl).responseImage { response in
            switch response.result {
            case .success(let image): callback(image, nil)
            case .failure(let error): callback(nil, error)
            }
        }
    }
}



