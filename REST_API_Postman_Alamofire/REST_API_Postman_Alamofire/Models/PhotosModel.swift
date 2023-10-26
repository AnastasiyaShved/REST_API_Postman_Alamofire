//
//  PhotosModel.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 19.10.23.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
