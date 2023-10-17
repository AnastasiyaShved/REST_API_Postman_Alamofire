//
//  CommentsModel.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 17.10.23.
//

import UIKit

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
