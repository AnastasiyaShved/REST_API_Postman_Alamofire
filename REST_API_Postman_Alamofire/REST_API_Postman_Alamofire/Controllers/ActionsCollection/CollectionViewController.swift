//
//  CollectionViewController.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 11.10.23.
//

import UIKit

//MARK: - enum
enum UserActions: String, CaseIterable {
    case downloadImage = "Download image"
    case users = "Open users list"
///CaseIterable - создает массив из enum, чтобы его выягуть в свойство дополнить методом .allCases
}

class CollectionViewController: UICollectionViewController {

    //MARK: - properties
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCVC
        let userAction = userActions[indexPath.row].rawValue
        cell.infoLbl.text = userAction
        
        return cell
    }

    // MARK: - UICollectionViewDelegate
    /// отлавливание нажатие ячейки
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "goToImageView", sender: nil)
        case .users: performSegue(withIdentifier: "openUsersList", sender: nil) 
        }
    }
}
// c помощью расширения хадаем раземер ячейке
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       //делаем ширину ячейки = ширине экрана - 50р
        CGSize(width: UIScreen.main.bounds.width - 50 , height: 80)
    }
}
