//
//  PhotosCVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 19.10.23.
//

import UIKit

class PhotosCVC: UICollectionViewController {
    
    var album: Album?
    var photos: [Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PhotoCVCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let size = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: size, height: size)
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVCell
        cell.thumbnailURL = photo?.thumbnailUrl
        return cell
    }
    // MARK: - Private func
    private func fetchPhotos() {
        guard let album = album else { return }
        NetworkService.fetchPhotos(albumId: album.id) { [weak self]  photos, error in
            if let error = error {
                print(error)
            }  else if let photos = photos {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }
}

    
 



