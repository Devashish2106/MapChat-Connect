//
//  ChatViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 17/06/24.
//

import UIKit

protocol ChatViewControllerDelegate: AnyObject {
    func displayVC(_ vc: ChatViewController, updatedInfo : Info)
}

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var info : Info?
    weak var delegate : ChatViewControllerDelegate?
    var messages: [Message] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatCon: UITextField!
    @IBOutlet weak var selectorLR: UISwitch!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        chatCon.delegate = self
        
        tableView.separatorStyle = .none
        tableView.backgroundView = UIImageView(image: UIImage(named: "bgimage.jpg"))
        
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        displayName.text = info?.name
        displayImg.image = info?.image ?? UIImage(named: info!.name)
        displayImg.layer.cornerRadius = displayImg.frame.height / 2
    }
    
    @IBSegueAction func dispDVC(_ coder: NSCoder) -> DisplayViewController? {
        let vc = DisplayViewController(coder: coder)
        
        vc?.a = info!
        vc?.delegate = self
        
        vc?.modalPresentationStyle = .fullScreen
        
        return vc
    }
    
    @IBAction func done(_ sender: Any) {
        delegate?.displayVC(self, updatedInfo: info!)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        
        guard let text = chatCon.text, !text.isEmpty else { return false }
                
        let side: MessageSide = selectorLR.isOn ? .right : .left
        let message = Message(text: text, side: side)
        messages.append(message)
                
        tableView.reloadData()
        chatCon.text = ""
        
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.side == .left {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftViewCell") as! LeftViewCell
            cell.configureCell(message: message)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightViewCell") as! RightViewCell
            cell.configureCell(message: message)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}

extension ChatViewController: DisplayViewControllerDelegate {
    func displayVC(_ vc: DisplayViewController, didSave: Info) {
        
        info = didSave
        
        dismiss(animated: true, completion: nil)
        
        updateUI()
    }
}
