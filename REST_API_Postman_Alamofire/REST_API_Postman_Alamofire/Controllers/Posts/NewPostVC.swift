//
//  NewPostVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewPostVC: UIViewController {
 
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var babyTV: UITextView!
    
    var user: User?
    
    //запрос: получаем id user,извлекаем URL
    @IBAction func postURLSession(_ sender: Any) {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = babyTV.text,
           let url = ApiConstans.postsURL {
            // setup request
            var request = URLRequest(url: url)
            // header
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //baby
            let postBadyJSON: [String: Any] = [
                "userId": userId,
                "title": title,
                "body": body
            ]
            //словарь преобразовываем в data
            let httpBady = try? JSONSerialization.data(withJSONObject: postBadyJSON)
            //обращаемся к реквесту и вкидывыем новое свойство
            request.httpBody = httpBady
            
            // created dataTask and seмnd Post
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response)
                if let data = data {
                    print(data)
                    let json = JSON(data)
                    print(json)
                    let userId = json["userId"]
                    let title = json["title"]
                    let body = json["body"]
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func postAlamofire(_ sender: Any) {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = babyTV.text,
           let url = ApiConstans.postsURL {
            let parametrs: Parameters = [
                "userId": userId,
                "title": title,
                "body": body
            ]
            
            AF.request(url, method: .post, parameters: parametrs, encoding: JSONEncoding.default)
              // что хотим получть в ответе
                .response { [weak self] response in
                    /// тут уже в главном потоке
                    debugPrint(response)
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                    
                }
        }
    }
}
