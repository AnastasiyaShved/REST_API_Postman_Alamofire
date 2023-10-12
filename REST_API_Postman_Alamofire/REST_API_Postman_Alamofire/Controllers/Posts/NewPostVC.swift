//
//  NewPostVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit

class NewPostVC: UIViewController {
 
    

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var babyTV: UITextView!
    
    var user: User?

    
    //запрос
    @IBAction func postURLSession(_ sender: Any) {
        // получаем id user
        if let userId = user?.id,
           let title = titleTF.text,
           let body = babyTV.text,
            // извлекаем URL
        let url = ApiConstans.postsURL {
            //setup request
            var request = URLRequest(url: url)
            
            // heder
            request.httpMethod = "POST"
            request.addValue("applocation/json", forHTTPHeaderField: "Content-Type")
            
            //baby
             let postBadyJSON: [String: Any] = [
                "userId": userId,
                "title": title,
                "body": body
            ]
            
            //словарь преобразовываем в data
            let httpBady = try? JSONSerialization.data(withJSONObject: postBadyJSON)
            //образаемся к реквесту и вкирывыем новое свойство
            request.httpBody = httpBady
            
            // created dataTask and sedn Post
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response)
                if let data = data
                    
            }.resume()
        }
    }
    
    @IBAction func postAlamofire(_ sender: Any) {
    }
}
