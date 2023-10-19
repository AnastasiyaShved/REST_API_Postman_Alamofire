//
//  PhotoCVCell.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 19.10.23.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCVCell: UICollectionViewCell {

   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var thumbnailURL: String? {
        didSet {
            getThumbnail()
        }
    }
    
    private func getThumbnail() {
        guard let thumbnailURL = thumbnailURL else {
            return
        }
        NetworkService.getThumbnail(thumbnailUrl: thumbnailURL) {[weak self] image, error in
            self?.activityIndicatorView.stopAnimating()
            self?.imageView.image = image
        }
    }
}
