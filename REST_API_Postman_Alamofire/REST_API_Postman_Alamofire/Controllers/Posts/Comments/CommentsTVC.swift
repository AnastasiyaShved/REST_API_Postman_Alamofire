//
//  CommentsTVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 17.10.23.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var postID: Int?
    var commetns: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComments()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commetns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        let com = commetns[indexPath.row]
        cell.textLabel?.text = com.name
        cell.detailTextLabel?.text = com.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commentId = commetns[indexPath.row].id
            NetworkService.deletePost(postId: commentId) { [weak self] in
                self?.commetns.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    private func fetchComments() {
        guard let postId = postID else { return }
        NetworkService.fetchComments(postID: postId) { [weak self] commetns, error in
            if let error = error {
                print(error)
            }  else if let comments = commetns {
                self?.commetns = comments
                self?.tableView.reloadData()
            }
        }
    }
}
