//
//  AlbumsModel.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import Foundation

struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String?
}
