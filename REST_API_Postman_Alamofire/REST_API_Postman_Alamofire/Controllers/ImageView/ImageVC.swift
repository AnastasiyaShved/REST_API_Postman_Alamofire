//
//  ImageVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 11.10.23.
//

import UIKit

class ImageVC: UIViewController {
    
//MARK: - prorerties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
   
    private let imageURL = "https://www.imgonline.com.ua/examples/bee-on-daisy.jpg"
    
//MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        fechImage()
    }
    
    //MARK: - private funcs -
    // метод для загрузки картинки
    private func  fechImage() {
        //cоздаем URL request
        guard let url = URL(string: imageURL) else { return }
        let urlReqest = URLRequest(url: url)
        /// создаем  URLSession (ессли не требуется останавливать запрос можно  не  создавать новое свойство)
        
        URLSession.shared.dataTask(with: urlReqest) { [weak self] data, response, error in
            print(data)
            print(response)
            print(error)
    
            ///DispatchQueue - объект, позволяющий работать с многопоточкой
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
           
               if let error = error {
                   print (error.localizedDescription)
                   return
               }
               
               if let response = response {
                   print(response)
               }
               
               if let data = data,
               let image  = UIImage(data: data) {
                   self?.imageView.image = image
               } else {
               
               }
           }
        }
        ///обязательно добааить метод resume() для запуска запроса
        .resume()
    }
}
