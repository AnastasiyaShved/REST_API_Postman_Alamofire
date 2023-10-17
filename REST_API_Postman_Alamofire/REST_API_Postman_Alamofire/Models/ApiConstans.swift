//
//  ApiConstans.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit

struct ApiConstans {
    private static let serverPath = "http://localhost:3000/"
    
    private static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
    
    static let postsPath = serverPath + "posts"
    static let postsURL = URL(string: postsPath)
    
    static let todosPath = serverPath + "todos"
    static let todosURL = URL(string: todosPath)
    
    static let albumsPath = serverPath + "albums"
    static let albumsURL = URL(string: albumsPath)
    
    static let photosPath = serverPath + "photos"
    static let photosURL = URL(string: photosPath)
    
    static let commentsPath = serverPath + "comments"
    static let commentsURL = URL(string: commentsPath)
    

    
    
    
}
