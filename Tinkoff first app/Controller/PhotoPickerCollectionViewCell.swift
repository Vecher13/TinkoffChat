//
//  PhotoPickerCollectionViewCell.swift
//  Tinkoff first app
//
//  Created by Ash on 21.04.2021.
//

import UIKit
class PhotoPickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageForCell: UIImageView!
    
    func setImage(image: UIImage) {
//        imageView.image = image
    }
    func configCell(with image: ImageURL) {
//        imageForCell.contentMode = .scaleAspectFill
        self.imageForCell.clipsToBounds = true
        NetworkService().getImage(url: image.largeImageURL) { image in
            DispatchQueue.main.async {
                self.imageForCell.image = image
                
            }
            
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageForCell.image = nil
    }
    
}
