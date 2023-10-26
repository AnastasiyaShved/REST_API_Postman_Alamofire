//
//  AlbumsTVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit

class AlbumsTVC: UITableViewController {

    var user: User?
    var albums: [Album]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlboms()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let alb = albums?[indexPath.row]
        cell.textLabel?.text = alb?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let albumId = albums?[indexPath.row].id else { return }
            NetworkService.deletePost(postId: albumId) { [weak self] in
                self?.albums?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = albums?[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: albom)
    }
    
    // MARK: - private func
    private func fetchAlboms() {
        guard let user = user else { return }
        NetworkService.fetchAlbums(userID: user.id) { [weak self] albums, error in
            if let error = error {
                print(error)
            }  else if let albums = albums {
                self?.albums = albums
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
           let vc = segue.destination as? PhotosCVC,
           let album = sender as? Album {
            vc.album = album
        }
    }
}
    
