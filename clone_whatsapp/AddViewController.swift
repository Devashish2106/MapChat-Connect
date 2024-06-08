//
//  AddViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 08/06/24.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func addvc (_ vc: AddViewController, didSave: Info)
}

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var addField: UITextField!
    
    var inf : Info?
    
    weak var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveBtn(_ sender: Any) {
        
        let inf = Info(name: nameField.text!, add: addField.text!, age: ageField.text!)
        delegate?.addvc(self, didSave: inf)
    }
}


