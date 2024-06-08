//
//  EditViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 08/06/24.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func EditVC (_ vc: EditViewController, didSave: Info)
}

class EditViewController: UIViewController {
    
    var inf: Info?
        
    @IBOutlet weak var editName: UITextField!
    
    @IBOutlet weak var editAge: UITextField!
    
    @IBOutlet weak var editAdd: UITextField!
    
    weak var delegate: EditViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        editName.text = inf?.name
        editAge.text = inf?.age
        editAdd.text = inf?.add
    }
    
    @IBAction func saveBt(_ sender: Any) {
        let infd = Info(name: editName.text!, add: editAdd.text!, age: editAge.text!)
        delegate?.EditVC(self, didSave: infd)
        
    }
    
    
}


