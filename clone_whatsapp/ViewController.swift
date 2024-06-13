//
//  ViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 08/06/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var infos = [
    Info(name: "Dev", add: "Jaipur", age: "20"),
    Info(name: "Modi", add: "Delhi", age: "71"),
    Info(name: "Amitabh", add: "Mumbai", age: "75"),
    ]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    @IBSegueAction func dspvc(_ coder: NSCoder) -> DisplayViewController? {
        let vc =  DisplayViewController(coder: coder)
        
        if let indexpath = tableView.indexPathForSelectedRow{
            let inf = infos[indexpath.row]
            print(inf)
            vc?.a = inf
        }
        
        vc?.delegate = self
        
        vc?.modalPresentationStyle = .fullScreen
        
        
        return vc
    }
    
    
    
    @IBSegueAction func addVC(_ coder: NSCoder) -> AddViewController? {
        let vc = AddViewController(coder: coder)
        
        vc?.delegate = self
        return vc
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let vc = infos.remove(at: sourceIndexPath.row)
        infos.insert(vc, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        let info = infos[indexPath.row]
        cell.pName.text = info.name
        cell.pImage.image = info.image ?? UIImage(named: info.name)
        
        cell.pImage.layer.cornerRadius = cell.pImage.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            infos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

extension ViewController: AddViewControllerDelegate{
    func addvc(_ vc: AddViewController, didSave: Info) {
        infos.append(didSave)
        tableView.insertRows(at: [IndexPath(row: infos.count-1, section: 0)], with: .automatic)
        dismiss(animated: true, completion: nil)
    }
}


extension ViewController: DisplayViewControllerDelegate {
    func displayVC(_ vc: DisplayViewController, didSave: Info) {
        
        if let index = tableView.indexPathForSelectedRow{
            infos[index.row] = didSave
            tableView.reloadRows(at: [index], with: .none)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

