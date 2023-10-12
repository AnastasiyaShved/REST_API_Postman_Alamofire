//
//  AddresModel.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Goe?
}

struct Goe: Codable {
    let lat: String?
    let lng: String?
}
