//
//  PhotoPickerViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 20.04.2021.
//

import UIKit

protocol DidUpdatePhoto {
    func updatePhoto(url: ImageURL)
}
class PhotoPickerViewController: UIViewController {
 
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var photoDelegate: DidUpdatePhoto?
    let netService = NetworkService.shared
    var urls: [ImageURL] = []
    let url = URL(string: "https://pixabay.com/api/?key=21253606-98d421b3e604aef323d0129f0&q=animal&image_type=%20photo&pretty=true&per_page=200")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        collectionView.delegate = self
        collectionView.dataSource = self
       fetchData()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func fetchData() {
        guard let url = url else { fatalError("Ooopsie")}
        netService.getURL(url: url) { (comlition) in
            switch comlition {
            case .success(let data):
                self.urls = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PhotoPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return urls.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell",
                                                        for: indexPath) as? PhotoPickerCollectionViewCell else {return UICollectionViewCell()}
        let url = self.urls[indexPath.row]
        let imagURL = url.largeImageURL
        netService.getImage(url: imagURL) { image in
            cell.imageForCell.image = image

            }
//        cell.imageForCell.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width / 3) - 5,
            height: (view.frame.size.width / 3) - 5
            )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = self.urls[indexPath.row]

        self.photoDelegate?.updatePhoto(url: url)
        dismiss(animated: true) {
            print("Dismiss")

        }
    
    }
   
}
