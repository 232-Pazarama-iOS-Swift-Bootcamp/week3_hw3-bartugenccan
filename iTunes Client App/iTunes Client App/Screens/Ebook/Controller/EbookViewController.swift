//
//  EbookViewController.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 14.10.2022.
//

import UIKit

final class EbookViewController: UIViewController {

    private let ebookView = EbookView()
    private let networkService = BaseNetworkService()
    private var ebookResponse : EbookResponse? {
        didSet {
            ebookView.refresh()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ebooks"
        view = ebookView
        
        ebookView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Books.."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
      fetchEbooks()
    }
    
// MARK: - Methods
    private func fetchEbooks(with text: String = "Ebook") {
        networkService.request(EbookRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.ebookResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
}

extension EbookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.ebook = ebookResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension EbookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ebookResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ebookCell", for: indexPath) as! EbookCollectionViewCell
        let ebook = ebookResponse?.results?[indexPath.row]
        cell.title = ebook?.trackName
        cell.imageView.downloadImage(from: ebook?.artworkLarge)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    
}

extension EbookViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchEbooks(with: text)
        }
    }
}
