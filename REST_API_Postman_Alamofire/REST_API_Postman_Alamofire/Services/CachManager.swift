//
//  CachManager.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 19.10.23.
//

import Foundation
import Alamofire
import AlamofireImage

final class CachManager {
    
    private init() {}
    static let shared = CachManager()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
