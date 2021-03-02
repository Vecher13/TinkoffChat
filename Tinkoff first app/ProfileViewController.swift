//
//  ProfileViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 21.02.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var secondNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap(_:)))
        profileImage.addGestureRecognizer(imageGesture)
        profileImage.layer.masksToBounds = false
        
        profileImage.clipsToBounds = true
        editButton.layer.cornerRadius = 14
        profileImage.backgroundColor = #colorLiteral(red: 0.8927419782, green: 0.9104283452, blue: 0, alpha: 1)
        firstNameLabel.adjustsFontSizeToFitWidth = true
        secondNameLabel.adjustsFontSizeToFitWidth = true
        
        
        nameLabel.text = "Marina Dudarenko"
        infoLabel.text = "UX/UI designer, web-designer Moscow, Russia"
        
        
        
        print("ViewDidLoad", editButton.frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("Info!!!", editButton?.frame as Any)
        
        //будет nil так как кнопка еще не появилсь на view и будет только после метода loadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidAppear", editButton.frame)
        // изначально приложение берет размеры из устрайства выбранном в .storyboard и то, какие значения frame там заданы. В данном методе уже значения размеров устройств, в котором запустили приложение.
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    @objc func imageTap(_ sender: UITapGestureRecognizer) {
        
        let center: CGPoint = .init(x: profileImage.frame.width / 2, y: profileImage.frame.height / 2)
        let location = sender.location(in: profileImage)
        let radius = profileImage.frame.width / 2
        let distance:CGFloat = sqrt(CGFloat(powf((Float(center.x - location.x)), 2) + powf((Float(center.y - location.y)), 2)))
        if(distance < radius) {
            allert()
            
        }
        
    }
    func cameraAlert(){
        let cameraAlert = UIAlertController(title: "Camera issue", message: "Sorry, some error with camera. Use photo frome library", preferredStyle: .alert)
        cameraAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(cameraAlert, animated: true)
    }
    
    func allert(){
        let alert = UIAlertController(title: "Choose a picture from...", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose from Photo Library", style: .default, handler:{action in
            self.didTapUIImage(from: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Take Picture with Camera", style: .default, handler: {action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.didTapUIImage(from: .camera)
            } else {
                self.cameraAlert()
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func didTapUIImage(from source: UIImagePickerController.SourceType){
        let ipc = UIImagePickerController()
        ipc.sourceType = source
        ipc.delegate = self
        ipc.allowsEditing = true
        present(ipc, animated: true)
        
    }
    
    
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
            if profileImage.image != nil {
                firstNameLabel.isHidden = true
                secondNameLabel.isHidden = true
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

