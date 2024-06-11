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

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentQuery : String = ""
    
    var results : [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    var arr: [UIImage] = []
    var totalPg = 0
    var curPg = 1
    
    weak var delegate: SearchViewControllerDelegate?
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchBar.resignFirstResponder()
            results = []
            arr = []
            currentQuery = text
            curPg = 1
            collectionView.reloadData()
            fetchPhotos(query: text, page: curPg)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image: UIImage = arr[indexPath.row]
        delegate?.editSC(self, search: image)
    }
    
    func fetchPhotos(query : String, page: Int) {
        
        guard page <= totalPg || page == 1 else { return }
        
        let urlString = "https://api.unsplash.com/search/photos?page=\(page)&per_page=30&query=\(query)&client_id=s94OAY6V3ulSyVUxuj_a6_BJUUWbpeL_u3v_BYhl4EE"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
            guard let data = data, err == nil else {
                return
            }
                
            do {
                let jsonResult = try JSONDecoder().decode(Response.self, from: data)
                self?.results.append(contentsOf: jsonResult.results)
                self?.totalPg = jsonResult.total_pages
                for result in jsonResult.results {
                    self?.configure(with: result.urls.regular)
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
                    self?.arr.append(image!)
                    self?.collectionView.reloadData()
                }
            }
            task.resume()
        }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return totalPg
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        cell.displayImage.image = arr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arr.count - 1 && curPg < totalPg {
            curPg += 1
            fetchPhotos(query: currentQuery, page: curPg)
        }
    }
}
