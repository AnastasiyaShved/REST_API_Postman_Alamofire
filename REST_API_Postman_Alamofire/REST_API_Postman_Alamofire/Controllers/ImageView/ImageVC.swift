//
//  ImageVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 11.10.23.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
   
    private let imageURL = "http://wallpapers-image.ru/2560x1600/nature/wallpapers/wallpapers-nature-9.jpg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fechImage()

        
    }

    // метод для загрузки картинки
    private func  fechImage() {
        //cоздаем URL request
        guard let url = URL(string: imageURL) else { return }
        let urlReqest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlReqest) { data, response, error in
            print(data)
            print(response)
            print(error)
        }
        
    }
}
