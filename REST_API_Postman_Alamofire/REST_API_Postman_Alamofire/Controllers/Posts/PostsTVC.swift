//
//  PostsTVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit

class PostsTVC: UITableViewController {

    var user: User?
    var posts: [Post] = []

    override func viewWillAppear(_ animated: Bool) { fetchPosts() }
    
    @IBAction func addNewPost(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createNewPost", sender: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postId = posts[indexPath.row].id
            NetworkService.deletePost(postId: postId) { [weak self] in
                self?.posts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }    
    }
    // MARK: - private func
    private func fetchPosts() {
        let userId = user?.id.description ?? ""
        let urlPath = "\(ApiConstans.postsPath)?userId=\(userId)"
        guard let url = URL(string: urlPath) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            do {
                self?.posts = try JSONDecoder().decode([Post].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToComments", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewPostVC {
            vc.user = user
        } else if let vc = segue.destination as? CommentsTVC,
                  let indexPath = tableView.indexPathForSelectedRow {
            let  postID = posts[indexPath.row].id
            vc.postID = postID
        }
    }
}
