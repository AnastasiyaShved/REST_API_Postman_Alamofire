//
//  PhotoVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 19.10.23.
//

import UIKit

class PhotoVC: UIViewController {
    var photo: Photo?
    
    // lazy отложеная инициализация
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        // попробовать сделать через  extation UIView
        //переопеределить сам  init
        activityIndicatorView.style = .large
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // попробовать сделать через  extation UIView
        //переопеределить сам  init
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "Unknown.jpeg")
        return imageView
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .darkGray
        view.addSubview(imageView)
        imageView.addSubview(activityIndicatorView)
        set()
        getPhoto()
        
    }
    
    private func getPhoto() {
        guard let photo = photo,
              let imagePath = photo.url,
              let url = URL(string: imagePath) else { return }
        NetworkService.downloadImage(from: url) { [ weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image
                self?.activityIndicatorView.stopAnimating()
            }
        }
              //если ошибка создавать аллер сонтраллер
    }
    
    private func set() {
        let margins = view.layoutMarginsGuide
        imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        activityIndicatorView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive=true
        activityIndicatorView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive=true
        
    }
    
//    private func set2() {
//        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: CGFloat, constant: <#T##CGFloat#>)
//    }
    

}
