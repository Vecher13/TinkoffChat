//
//  ProfileViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 21.02.2021.
//

import UIKit

class ProfileViewController: UIViewController, DidUpdatePhoto {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var infoLabel: UITextView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var secondNameLabel: UILabel!
    @IBOutlet var saveButtons: UIStackView!
    @IBOutlet var saveGCDButton: UIButton!
    @IBOutlet var saveOptionalsButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let emitterLayer = EmitterLayer()
    
    let jsonManager = SaveDataManager()
    var saveButtonPosition = CGPoint()
    var photoManager = PhotoPickerViewController()
    let gcd = GCDUploader()
    let optionals = OperationUploader()
    let netService = NetworkService.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        kB()
        loadDataGCD()
        //        photoManager.photoDelegate = self
        profileImage.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap(_:)))
        profileImage.addGestureRecognizer(imageGesture)
        profileImage.layer.masksToBounds = false
        
        profileImage.clipsToBounds = true
        editButton.layer.cornerRadius = 14
        saveGCDButton.layer.cornerRadius = 14
        cancelButton.layer.cornerRadius = 14
        profileImage.backgroundColor = #colorLiteral(red: 0.8927419782, green: 0.9104283452, blue: 0, alpha: 1)
        firstNameLabel.adjustsFontSizeToFitWidth = true
        secondNameLabel.adjustsFontSizeToFitWidth = true
        saveButtons.isHidden = true
        
        let colorAssets = ThemesManager.shared.theme
        view.backgroundColor = colorAssets?.backgroundColor
        nameLabel.textColor = colorAssets?.labelTextColor
        infoLabel.textColor = colorAssets?.labelTextColor
        nameLabel.isUserInteractionEnabled = false
        infoLabel.isUserInteractionEnabled = false
        profileImage.isUserInteractionEnabled = false
        nameLabel.text = "Marina Dudarenko"
        infoLabel.text = "UX/UI designer, web-designer Moscow, Russia"
        
        activityIndicator.isHidden = true
        saveOptionalsButton.isHidden = true
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        saveButtonPosition = saveGCDButton.layer.position
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidAppear", editButton.frame)
        
        //        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    // gerb animation
    lazy var particleEmitter: CAEmitterLayer = {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .point
        emitter.renderMode = .additive
        return emitter
    }()
    
    lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer
            .addTarget(self, action: #selector(handleTap))
        return gestureRecognizer
    }()
    
    @objc func imageTap(_ sender: UITapGestureRecognizer) {
        
        let center: CGPoint = .init(x: profileImage.frame.width / 2, y: profileImage.frame.height / 2)
        let location = sender.location(in: profileImage)
        let radius = profileImage.frame.width / 2
        let distance: CGFloat = sqrt(CGFloat(powf((Float(center.x - location.x)), 2) + powf((Float(center.y - location.y)), 2)))
        if distance < radius {
            allert()
        }
        
    }
    @IBAction func editProfileAction(_ sender: Any) {
        
        saveButtons.isHidden = false
        editButton.isHidden = true
        self.nameLabel.isUserInteractionEnabled = true
        self.infoLabel.isUserInteractionEnabled = true
        profileImage.isUserInteractionEnabled = true
        shaking()
    }
    
    func updatePhoto(url: ImageURL) {
        secondNameLabel.isHidden = true
        firstNameLabel.isHidden = true
        let ph = url.largeImageURL
        print("URL URL", url)
        netService.getImage(url: ph) { (image) in
            guard let photo = image else {return print("Fail take photo")}
            DispatchQueue.main.async {
                print("URL URL", url)
                self.profileImage.image = photo
            }
            
        }
    }
    
    @IBAction func gcdActionButton(_ sender: Any) {
        saveGCD()
        //        saveGCDButton.isUserInteractionEnabled = false
        //        saveOptionalsButton.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        stopAnimation()
    }
    
    @IBAction func optionalSave(_ sender: Any) {
        saveOptionals()
        saveGCDButton.isUserInteractionEnabled = false
        saveOptionalsButton.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    @IBAction func cancelSave(_ sender: Any) {
        optionals.queue.cancelAllOperations()
        //        saveButtons.isHidden = true
        //        editButton.isHidden = false
        nameLabel.isUserInteractionEnabled = false
        infoLabel.isUserInteractionEnabled = false
        profileImage.isUserInteractionEnabled = false
        stopAnimation()
        
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func cameraAlert() {
        let cameraAlert = UIAlertController(title: "Camera issue", message: "Sorry, some error with camera. Use photo frome library", preferredStyle: .alert)
        cameraAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(cameraAlert, animated: true)
    }
    
    func allert() {
        let alert = UIAlertController(title: "Choose a picture from...", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose from Photo Library", style: .default, handler: { _ in
            self.didTapUIImage(from: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Choose from Internet", style: .default, handler: { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let photoPicker = storyboard.instantiateViewController(withIdentifier: "ShowPhotoPicker") as? PhotoPickerViewController else { return }
            photoPicker.photoDelegate = self
            //            self.show(photoPicker, sender: nil)
            self.present(photoPicker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Take Picture with Camera", style: .default, handler: {_ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.didTapUIImage(from: .camera)
            } else {
                self.cameraAlert()
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    enum SaveOptional {
        case gcd
        case optionals
        
    }
    func errorAllert(save: SaveOptional) {
        let alert = UIAlertController(title: "Проблемы с загрузгой", message: "Может еще раз?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Забить", style: .default, handler: {_ in
            self.saveOptionalsButton.isUserInteractionEnabled = true
            self.saveGCDButton.isUserInteractionEnabled = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            switch save {
            case .gcd:
                self.saveGCD()
                self.saveOptionalsButton.isUserInteractionEnabled = true
                self.saveGCDButton.isUserInteractionEnabled = true
            case .optionals:
                self.saveOptionals()
                self.saveOptionalsButton.isUserInteractionEnabled = true
                self.saveGCDButton.isUserInteractionEnabled = true
            }
            
        }))
        self.present(alert, animated: true)
        
    }
    func successAllert() {
        let alert = UIAlertController(title: "Успешно засейвелись!", message: "Можно спать спокойно, денные в безопасности!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    func didTapUIImage(from source: UIImagePickerController.SourceType) {
        let ipc = UIImagePickerController()
        ipc.sourceType = source
        ipc.delegate = self
        ipc.allowsEditing = true
        present(ipc, animated: true)
        
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
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

extension ProfileViewController {
    
    func saveGCD() {
        
        gcd.uploadData(data: .init(name: nameLabel.text ?? "", info: infoLabel.text ?? "")) { result in
            switch result {
            case .success(let string):
                print("Super success!", string)
                self.saveGCDButton.isUserInteractionEnabled = true
                self.saveOptionalsButton.isUserInteractionEnabled = true
                self.successAllert()
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.saveGCDButton.layer.removeAllAnimations()
            case .failure:
                print("GCD. Somethin was going wrong...")
                self.errorAllert(save: .gcd)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
            }
            
        }
    }
    
    func saveOptionals() {
        optionals.uploadData(data: .init(name: nameLabel.text ?? "", info: infoLabel.text ?? "")) { result in
            switch result {
            case .success(let string):
                print(string)
                self.successAllert()
                self.saveOptionalsButton.isUserInteractionEnabled = true
                self.saveGCDButton.isUserInteractionEnabled = true
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            case .failure:
                print("UUUPs")
                self.errorAllert(save: .optionals)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
            }
        }
        
    }
    
    func loadDataGCD() {
        gcd.loadData { userData in
            switch userData {
            case .success(let data):
                self.nameLabel.text = data.name
                self.infoLabel.text = data.info
            case .failure:
                print("Could not read data")
            }
        }
    }
    
}

extension ProfileViewController {
    
    func kB() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
}

// MARK: - animation

extension ProfileViewController: CAAnimationDelegate {
    func shaking() {
        
        let angle = 0.18
        
        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        wiggle.autoreverses = true
        wiggle.repeatCount = Float.infinity
        
        let buttonPosition = saveGCDButton.layer.position
        
        let position = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        position.values = [buttonPosition,
                           CGPoint(x: buttonPosition.x + 5, y: buttonPosition.y),
                           CGPoint(x: buttonPosition.x, y: buttonPosition.y + 5),
                           CGPoint(x: buttonPosition.x - 5, y: buttonPosition.y),
                           CGPoint(x: buttonPosition.x, y: buttonPosition.y - 5)
        ]
        
        position.autoreverses = true
        position.repeatCount = Float.infinity
        
        let group = CAAnimationGroup()
        group.duration = 0.3
        group.repeatCount = .infinity
        group.autoreverses = true
        group.animations = [position, wiggle]
        
        saveGCDButton.layer.add(group, forKey: nil)
        
    }
    
    func stopAnimation() {
        saveGCDButton.layer.removeAllAnimations()
        
        let transformAnim = CABasicAnimation(keyPath: "transform")
        transformAnim.fromValue = saveGCDButton.layer.presentation()?.transform
        transformAnim.toValue = saveGCDButton.layer.transform
        transformAnim.duration = 0.3
        transformAnim.autoreverses = false
        saveGCDButton.layer.add(transformAnim, forKey: "transform")
        
        let position = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        guard let startPosition = saveGCDButton.layer.presentation()?.position else { return }
        position.values = [startPosition, saveGCDButton.layer.position]
        position.duration = 0.7
        position.autoreverses = false
        position.delegate = self
        saveGCDButton.layer.add(position, forKey: "position")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        saveButtons.isHidden = true
        editButton.isHidden = false
    }
    
    func showGerb() {
        particleEmitter.emitterCells = [emitterLayer]
        view.layer.addSublayer(particleEmitter)
    }
    
    @objc func handleTap(sender: UIPanGestureRecognizer) {
        particleEmitter.emitterPosition = sender.location(in: self.view)
        
        if sender.state == .ended {
            particleEmitter.lifetime = 0
            print("tap!!")
        } else if sender.state == .began {
            showGerb()
            particleEmitter.lifetime = 1.0
        }
    }
}
