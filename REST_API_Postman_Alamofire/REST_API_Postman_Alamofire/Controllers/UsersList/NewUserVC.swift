//
//  NewUserVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 16.10.23.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewUserVC: UIViewController {

    // MARK: - properties
    @IBOutlet weak var userIdTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var suiteTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var latTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    @IBOutlet weak var lngTF: UITextField!
    @IBOutlet weak var nameCompanyTF: UITextField!
    @IBOutlet weak var catchPhraseTF: UITextField!
    @IBOutlet weak var bsTF: UITextField!
    
    var user: User?
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        guard let idString = userIdTF.text,
           let id = Int(idString),
           let name = nameTF.text,
           let username = userNameTF.text,
           let email = emailTF.text,
           let phone = phoneTF.text,
           let website = websiteTF.text,
           let street = streetTF.text,
           let suite = suiteTF.text,
           let city = cityTF.text,
           let lat = latTF.text,
           let lng = lngTF.text,
           let zipcode = zipcodeTF.text,
           let nameCompany = nameCompanyTF.text,
           let catchPhrase = catchPhraseTF.text,
           let bs = bsTF.text,
           let url = ApiConstans.usersURL else { return }
        
        // собираем модельки
        let geo = Geo(
            lat: lat,
            lng: lng)
            
        let address = Address(
            street: street,
            suite: suite,
            city: city,
            zipcode: zipcode,
            geo: geo)
            
        let company = Company(
            name: nameCompany,
            catchPhrase: catchPhrase,
            bs: bs)
        
        let user = User(
            id: id,
            name: name,
            username: username,
            email: email,
            phone: phone,
            website: website,
            address: address,
            company: company)
            
        do {
            //пробуем сконвертировать user в json
            let parameters = try user.toJSON()
            
            AF.request(url,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default
            ).response { [weak self] response in
                //получаем результат нашего запроса на добавление нового пользователя в БД и обрабатываем ответ
                switch response.result {
                case .success:
                    //при успешном ответе - возвращаемся к списку юзеров (закрываем экран добавления юзера)
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    //при ошибке - принтим ошибку в кансоль
                    print(error)
                }
            }
        } catch let error as NSError {
            ///принтим эту ошибку, если не смогли собрать json, т.к. JSONEncoder() и JSONSerialization может выбрасывать ошибку в случае не успеха
            print("Failed to create json: \(error.localizedDescription)")
        }
    }
}

/// для упрощения конвертации Encodable object-ов в json
/// что бы не создавать отдельные json для каждой модели,
/// напишем расширение для всех объектов которые реализуют протокол Encodable (наши модельки подписаны под Codable. Codable = Encodable + Codable)
/// теперь у каждой модели появится возможность конвертироваться в json вызовом метода toJSON()

extension Encodable {

    func toJSON() throws -> [String: Any]? {
        do {
            ///пробуем сконвертировать нашу  Encodable модель в data, данный метод может выбрасывать ошибку, в случаем ошибки мы попадем в блок catch
            let data = try JSONEncoder().encode(self)
            ///пробуем создать JSON из полученной data,  данный метод может выбрасывать ошибку, в случаем ошибки мы попадем в блок catch
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            
            return json
        } catch let error as NSError {
            //передаем полученную ошибку вверх по цепочке
            throw error
        }
    }
}
