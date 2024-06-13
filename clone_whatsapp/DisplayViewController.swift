//
//  DisplayViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 08/06/24.
//

import UIKit

protocol DisplayViewControllerDelegate: AnyObject {
    func displayVC (_ vc: DisplayViewController, didSave: Info)
}

class DisplayViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var a = Info(name: "a", add: "a", age: "0", image: nil)
    
    weak var delegate: DisplayViewControllerDelegate?

    @IBOutlet weak var InsideCity: UILabel!
    @IBOutlet weak var InsideAge: UILabel!
    @IBOutlet weak var InsideName: UILabel!
    @IBOutlet weak var InsideImage: UIImageView!
    
    var setI: Bool = false
    
    
    let userDefalutsKey = "savedImagePath"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateUI()
        
        
    }
    
    func updateUI() {
        InsideAge.text = a.age
        InsideName.text = a.name
        InsideCity.text = a.add
        
        InsideImage.image = a.image ?? UIImage(named: a.name)
    }
    
    @IBSegueAction func EditVCSegue(_ coder: NSCoder) -> EditViewController? {
        let vc = EditViewController(coder: coder)
        
        
        vc?.inf = a
        
        vc?.delegate = self
        
        return vc
    }
    @IBAction func done(_ sender: Any) {
        print(a)
        delegate?.displayVC(self, didSave: a)
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            InsideImage.image = image
            saveImage(image)
            a = a.imgCh(image)
            print(a)
        }
    }
    
    @IBSegueAction func searchVCSegue(_ coder: NSCoder) -> SearchViewController? {
        let vc = SearchViewController(coder: coder)
        
        
        vc?.delegate = self
        return vc
    }
    func saveImage(_ image: UIImage) {
        guard let data = image.pngData() else { return }
        let filename = getDocumentsDirectory().appendingPathComponent("savedImage.png")
            
        do {
            try data.write(to: filename)
            UserDefaults.standard.set(filename.path, forKey: userDefalutsKey)
        } catch {
            print("Unable to save image")
        }
    }
        
        func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
}

extension DisplayViewController: EditViewControllerDelegate{
    
    func EditVC(_ vc: EditViewController, didSave: Info) {
        a = didSave
        
        updateUI()
        dismiss(animated: true, completion: nil)
    }
}

extension DisplayViewController: SearchViewControllerDelegate{
    
    func editSC(_ vc: SearchViewController, search: UIImage) {
        InsideImage.image = search
        saveImage(search)
        a = a.imgCh(search)
        dismiss(animated: true, completion: nil)
    }
}

