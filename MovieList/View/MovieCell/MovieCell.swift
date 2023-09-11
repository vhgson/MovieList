//
//  MovieCell.swift
//  MovieList
//
//  Created by Son Vu on 09/09/2023.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var imageViewPoster: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelWatchList: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(movie: MovieItem) {
        resetCell()
        setupUI()
        imageViewPoster.image = UIImage(named: movie.poster)
        labelTitle.text = movie.title
        let description = "\(movie.duration) - \(movie.genre)"
        labelDescription.text = description
        labelWatchList.text = "ON MY WATCHLIST"
        labelWatchList.isHidden = !movie.isOnWatchList
    }
    
    private func resetCell() {
        imageViewPoster.image = nil
        labelTitle.text = ""
        labelDescription.text = ""
        labelWatchList.text = ""
    }
    
    private func setupUI() {
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelDescription.font = UIFont.systemFont(ofSize: 16)
        labelDescription.textColor = .lightGray
        labelWatchList.font = UIFont.boldSystemFont(ofSize: 12)
        labelWatchList.textColor = .gray
        
        labelTitle.numberOfLines = 0
        labelDescription.numberOfLines = 0
    }
}
