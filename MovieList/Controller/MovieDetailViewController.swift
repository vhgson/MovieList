//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Son Vu on 10/09/2023.
//

import UIKit

protocol MovieDetailViewControllerProtocol: AnyObject {
    func updateMovieItem(movieItem: MovieItem?)
}

final class MovieDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var viewSeparator: UIView!
    @IBOutlet private weak var viewSeparatorSecond: UIView!
    @IBOutlet private weak var viewSeparatorThird: UIView!
    @IBOutlet private weak var imageViewPoster: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelRating: UILabel!
    @IBOutlet private weak var buttonAddToWatchlist: UIButton!
    @IBOutlet private weak var buttonWatchTrailer: UIButton!
    @IBOutlet private weak var labelShortDescription: UILabel!
    @IBOutlet private weak var labelMovieDescription: UILabel!
    @IBOutlet private weak var labelDetail: UILabel!
    @IBOutlet private weak var labelGenre: UILabel!
    @IBOutlet private weak var labelReleaseDate: UILabel!
    @IBOutlet private weak var labelGenreValue: UILabel!
    @IBOutlet private weak var labelReleaseDateValue: UILabel!
    
    // MARK: - Properties
    var movieItem: MovieItem?
    weak var delegate: MovieDetailViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        viewSeparator.backgroundColor = .lightGray
        viewSeparatorSecond.backgroundColor = .lightGray
        viewSeparatorThird.backgroundColor = .lightGray
        labelTitle.font = .boldSystemFont(ofSize: 20)
        labelTitle.numberOfLines = 0
        
        buttonAddToWatchlist.setTitle("*ADD TO WATCHLIST", for: .normal)
        buttonAddToWatchlist.titleLabel?.font = .systemFont(ofSize: 12)
        buttonAddToWatchlist.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonAddToWatchlist.setTitleColor(.darkGray, for: .normal)
        buttonAddToWatchlist.layer.cornerRadius = buttonAddToWatchlist.frame.height / 2
        buttonAddToWatchlist.layer.backgroundColor = UIColor.lightGray.cgColor
        
        buttonWatchTrailer.setTitle("WATCH LATER", for: .normal)
        buttonWatchTrailer.titleLabel?.font = .boldSystemFont(ofSize: 13)
        buttonWatchTrailer.setTitleColor(.black, for: .normal)
        buttonWatchTrailer.layer.cornerRadius = buttonWatchTrailer.frame.height / 2
        buttonWatchTrailer.layer.borderColor = UIColor.black.cgColor
        buttonWatchTrailer.layer.borderWidth = 1.0
        
        labelShortDescription.text = "Short description"
        labelShortDescription.font = .boldSystemFont(ofSize: 20)
        labelMovieDescription.numberOfLines = 0
        labelMovieDescription.font = .systemFont(ofSize: 16)
        labelMovieDescription.textColor = UIColor.lightGray
        
        labelDetail.text = "Details"
        labelDetail.font = .boldSystemFont(ofSize: 20)
        labelGenre.text = "Genre"
        labelGenre.font = .boldSystemFont(ofSize: 18)
        labelReleaseDate.text = "Release date"
        labelReleaseDate.font = .boldSystemFont(ofSize: 18)
        
        labelGenreValue.font = .systemFont(ofSize: 16)
        labelGenreValue.textColor = UIColor.lightGray
        labelReleaseDateValue.font = .systemFont(ofSize: 16)
        labelReleaseDateValue.textColor = UIColor.lightGray
    }
    
    private func setupData() {
        guard let movieItem = self.movieItem else {
            return
        }
        imageViewPoster.image = UIImage(named: movieItem.poster)
        labelTitle.text = movieItem.title
        
        let attributeStringRating = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let mutableStringRating = NSMutableAttributedString(string: "\(movieItem.rating)", attributes: attributeStringRating)
        
        let attributedStringSecond = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let mutableStringSecond = NSMutableAttributedString(string: "/10", attributes: attributedStringSecond)
        
        mutableStringRating.append(mutableStringSecond)
        labelRating.attributedText = mutableStringRating
        
        labelMovieDescription.text = movieItem.description
        labelGenreValue.text = movieItem.genre
        labelReleaseDateValue.text = movieItem.releasedDate
        
        buttonAddToWatchlist.setTitle(movieItem.isOnWatchList ? "REMOVE FROM WATCHLIST" : "*ADD TO WATCHLIST", for: .normal)
    }
    
    // MARK: - IBAction
    @IBAction private func invokeButtonAddWatchlist(_ sender: UIButton) {
        guard let movieItem = self.movieItem else {
            return
        }
        var isOnWatchList = movieItem.isOnWatchList
        isOnWatchList.toggle()
        self.movieItem?.isOnWatchList = isOnWatchList
        buttonAddToWatchlist.setTitle(isOnWatchList ? "REMOVE FROM WATCHLIST" : "*ADD TO WATCHLIST", for: .normal)
        delegate?.updateMovieItem(movieItem: self.movieItem)
        
    }
}
