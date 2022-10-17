//
//  DetailViewController.swift
//  iTunes Client App
//
//  Created by Pazarama iOS Bootcamp on 2.10.2022.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    private let musicDetailView = MusicDetailView()
    private let ebookDetailView = EbookDetailView()
    
    var podcast: Podcast? {
        didSet {
            title = podcast?.trackName
            detailView.imageView.downloadImage(from: podcast?.artworkLarge)
            detailView.trackName = podcast?.trackName
            detailView.releaseDate = podcast?.releaseDate
            detailView.artistName = podcast?.artistName
            detailView.country = podcast?.country
            detailView.genres = podcast?.genres?.reduce("") { $1 + ", " + $0 }
        }
    }
    
    var ebook: Ebook? {
        didSet {
            title = ebook?.trackName
            ebookDetailView.imageView.downloadImage(from: ebook?.artworkLarge)
            ebookDetailView.trackName = ebook?.trackName
            ebookDetailView.releaseDate = ebook?.releaseDate
            ebookDetailView.artistName = ebook?.artistName
            ebookDetailView.country = ebook?.country
            ebookDetailView.genres = ebook?.genres?.reduce("") { $1 + ", " + $0 }
        }
    }
    
    var music: Music? {
        didSet {
            title = music?.trackName
            
            musicDetailView.imageView.downloadImage(from: music?.artwork)
            musicDetailView.primaryGenreName = music?.primaryGenreName
            musicDetailView.trackName = music?.trackName
            musicDetailView.artistName = music?.artistName
            musicDetailView.country = music?.country
        }
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        if music != nil {
            view = musicDetailView
        }
        if podcast != nil {
            view = detailView
        }
        if ebook != nil {
            view = ebookDetailView
        }
    }
}
