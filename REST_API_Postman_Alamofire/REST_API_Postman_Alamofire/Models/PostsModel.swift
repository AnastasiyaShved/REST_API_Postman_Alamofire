//
//  PostsModel.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let body: String?
}
