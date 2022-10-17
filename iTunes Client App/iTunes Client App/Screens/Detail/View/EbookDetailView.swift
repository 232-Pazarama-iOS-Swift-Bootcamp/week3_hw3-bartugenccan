//
//  EbookDetailView.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 16.10.2022.
//

import UIKit
import CoreData

final class EbookDetailView: UIView {
    // Core Data Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var trackName: String? {
        didSet {
            trackNameKeyLabel.text = "Track Name:"
            trackNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            trackNameLabel.text = trackName ?? "-"
        }
    }
    
    var releaseDate: String? {
        didSet {
            releaseDateKeyLabel.text = "Release Date:"
            releaseDateKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            releaseDateLabel.text = releaseDate ?? "-"
        }
    }
    
    var artistName: String? {
        didSet {
            artistNameKeyLabel.text = "Artist Name:"
            artistNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            artistNameLabel.text = artistName ?? "-"
        }
    }
    
    var country: String? {
        didSet {
            countryKeyLabel.text = "Country:"
            countryKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            countryLabel.text = country ?? "-"
        }
    }
    
    var genres: String? {
        didSet {
            genresKeyLabel.text = "Genres:"
            genresKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            genresLabel.text = genres ?? "-"
        }
    }
    
    private(set) var imageView = UIImageView()
    
    private let releaseDateKeyLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, UIView(), releaseDateLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var artistNameKeyLabel = UILabel()
    private var artistNameLabel = UILabel()
    private lazy var artistNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistNameKeyLabel, UIView(), artistNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var countryKeyLabel = UILabel()
    private var countryLabel = UILabel()
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryKeyLabel, UIView(), countryLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var genresKeyLabel = UILabel()
    private var genresLabel = UILabel()
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genresKeyLabel, UIView(), genresLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let trackNameKeyLabel = UILabel()
    private let trackNameLabel = UILabel()
    private lazy var trackNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackNameKeyLabel, UIView(), trackNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    
    private var addToFavoritesButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        releaseDateLabel.numberOfLines = .zero
        artistNameLabel.numberOfLines = .zero
        countryLabel.numberOfLines = .zero
        genresLabel.numberOfLines = .zero
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            imageView.heightAnchor.constraint(equalToConstant: .screenWidth)
        ])
        imageView.layer.cornerRadius = 39
        imageView.clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [trackNameStackView ,releaseDateStackView,
                                                       artistNameStackView,
                                                       countryStackView,
                                                       genresStackView])
        
       
        stackView.axis = .vertical
        stackView.spacing = 8.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
        
        addSubview(addToFavoritesButton)
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToFavoritesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            addToFavoritesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 50)])
        addToFavoritesButton.layer.cornerRadius = 20
        addToFavoritesButton.setTitle("Add To Favorites", for: .normal)
        addToFavoritesButton.backgroundColor = .systemBlue
        addToFavoritesButton.addTarget(self, action: #selector(addEbookToFavorites), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Methods
    @objc func addEbookToFavorites() {
            let favEbook = NSEntityDescription.insertNewObject(forEntityName: "FavProducts", into: context)


        favEbook.setValue(trackNameLabel.text, forKey: "trackName")
        favEbook.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            
        } catch {
            print("Error")
        }
        
    }
}
