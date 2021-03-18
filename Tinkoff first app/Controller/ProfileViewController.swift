//
//  ProfileViewController.swift
//  Tinkoff first app
//
//  Created by Ash on 21.02.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var infoLabel: UITextView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var secondNameLabel: UILabel!
    @IBOutlet var saveButtons: UIStackView!
    
    let jsonManager = SaveDataManager()
    
    
    
    
     let gcd = GCDUploader()
    let optionals = OperationUploader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kB()
        
        profileImage.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap(_:)))
        profileImage.addGestureRecognizer(imageGesture)
        profileImage.layer.masksToBounds = false
        
        profileImage.clipsToBounds = true
        editButton.layer.cornerRadius = 14
        profileImage.backgroundColor = #colorLiteral(red: 0.8927419782, green: 0.9104283452, blue: 0, alpha: 1)
        firstNameLabel.adjustsFontSizeToFitWidth = true
        secondNameLabel.adjustsFontSizeToFitWidth = true
        saveButtons.isHidden = true
        
        let colorAssets = ThemesManager.shared.theme
        view.backgroundColor = colorAssets?.backgroundColor
        nameLabel.textColor = colorAssets?.labelTextColor
        infoLabel.textColor = colorAssets?.labelTextColor
        
        nameLabel.text = "Marina Dudarenko"
        infoLabel.text = "UX/UI designer, web-designer Moscow, Russia"
        
       
        
        
//        print(jsonManager.saveData(name: "Hi-hi", info: "hihi"))
//        print("ViewDidLoad", editButton.frame)
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        print("Info!!!", editButton?.frame as Any)
//
//        //будет nil так как кнопка еще не появилсь на view и будет только после метода loadView()
//    }
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidAppear", editButton.frame)
        // изначально приложение берет размеры из устрайства выбранном в .storyboard и то, какие значения frame там заданы. В данном методе уже значения размеров устройств, в котором запустили приложение.
//        profileImage.layer.cornerRadius = profileImage.frame.height/2
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
    @IBAction func editProfileAction(_ sender: Any) {
        saveButtons.isHidden = false
        editButton.isHidden = true
    }
    
    
    @IBAction func gcdActionButton(_ sender: Any) {
        saveGCD()
    }
    
    
    @IBAction func optionalSave(_ sender: Any) {
        saveOptionals()
    }
    
    
    @IBAction func cancelSave(_ sender: Any) {
        saveButtons.isHidden = true
        editButton.isHidden = false
    }
    
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension ProfileViewController {
    
     func saveGCD() {
       
        gcd.uploadData(data: .init(name: nameLabel.text ?? "", info: infoLabel.text ?? "")) { result in
            switch result {
            case .success(let string):
                print("Super success!", string)
            case .failure:
                print("GCD. Somethin was going wrong...")
            }
            
        }
    }
    
    func saveOptionals(){
        optionals.uploadData(data: .init(name: nameLabel.text ?? "", info: infoLabel.text ?? "")) { result in
            switch result {
            case .success(let string):
                print(string)
            case .failure:
                print("UUUPs")
            }
        }
        
      
    }
    
}

extension ProfileViewController {

    func kB(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
          // if keyboard size is not available for some reason, dont do anything
          return
        }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
      }

      @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
      }
    
    
    
    //    deinit {
//        removeKeyboardNotifications()
//    }
    
//    func registerForKeyboardNotifivations(){
//        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//    }
//    func removeKeyboardNotifications(){
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc func kbWillShow(_ notification: Notification) {
//        let userInfo = notification.userInfo
//        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//        self.scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize?.height ?? 1000)
//    }
//    @objc func kbWillHide(){
//        scrollView.contentOffset = CGPoint.zero
//    }
   
}
