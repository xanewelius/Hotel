//
//  ViewController.swift
//  Hotel
//
//  Created by Max Kuzmin on 11.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var hotel: Hotel?
    private let network        = NetworkService()
    private let collectionView = CustomPhotoCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
        setupUI()
        layout()
    }
    
    private func getPhotos() {
        Task {
            do {
                hotel = try await network.getHotel()
                collectionView.setPhotos(photoUrls: hotel?.imageUrls ?? [])
            } catch is NetworkError {
                dialog()
            }
        }
    }
    
    private func dialog() {
        let alert = UIAlertController(title: "Error while loading data",
                                      message: "Would you like to try again?",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again",
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in self.getPhotos() } ))
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Hotel"
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 353),
            collectionView.heightAnchor.constraint(equalToConstant: 257),
        ])
    }
}

