//
//  UsersTVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit

class UsersTVC: UITableViewController {

    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username
    
        return cell
    }
    
    override func tableView(_ tebleView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let user = users[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailUserVC") as! DetailUserVC
            vc.user = user
        navigationController?.pushViewController(vc, animated: true)
        }
    
    //MARK: - private func
    private func fetchUsers() {
        guard let usersURL = ApiConstans.usersURL else { return }
        URLSession.shared.dataTask(with: usersURL) { [weak self] data, response, error in
            guard let response = response else { return }
            print(response)
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    self?.users = try JSONDecoder().decode([User].self, from: data)
                    print(self?.users)
                } catch  {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                //заполняем таблицу данными и массива
                self?.tableView.reloadData()
            }
        }.resume()
    }
}
//decode -  в каком формате нужны данные
 
