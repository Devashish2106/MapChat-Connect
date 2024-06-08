//
//  SearchViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 08/06/24.
//

import UIKit

struct Response: Codable{
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable{
    let id: String
    let urls: URLs
}

struct URLs: Codable{
    let regular: String
}

protocol SearchViewControllerDelegate: AnyObject {
    func editSC (_ vc: SearchViewController, search: UIImage)
}

class SearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var results : [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }
    
    weak var delegate: SearchViewControllerDelegate?
    
    @IBAction func exitBtn(_ sender: Any) {
        if let image : UIImage = searchImage.image {
            delegate?.editSC(self, search: image)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchBar.resignFirstResponder()
            results = []
            searchImage.reloadInputViews()
            fetchPhotos(query: text)
        }
    }
    
    
    func fetchPhotos(query : String) {
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=1&query=\(query)&client_id=s94OAY6V3ulSyVUxuj_a6_BJUUWbpeL_u3v_BYhl4EE"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
            guard let data = data, err == nil else {
                return
            }
                
            do {
                let jsonResult = try JSONDecoder().decode(Response.self, from: data)
                self?.results = jsonResult.results
                if let firstResult = jsonResult.results.first {
                    self?.configure(with: firstResult.urls.regular)
                }
            } catch {
                print(error)
            }
        }
            
        task.resume()
    }
    
    func configure(with urlString: String) {
            guard let url = URL(string: urlString) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
                guard let data = data, err == nil else {
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.searchImage.image = image
                }
            }
            task.resume()
        }

    @IBOutlet weak var searchImage: UIImageView!
}
