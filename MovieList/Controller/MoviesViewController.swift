//
//  MoviesViewController.swift
//  MovieList
//
//  Created by Son Vu on 09/09/2023.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var moviesTableView: UITableView!
    
    // MARK: -  Properties
    private var listMovies: MoviesList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(sortListMovies))
        
        navigationController?.navigationBar.tintColor = .black
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        setupData()
        moviesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupData() {
        listMovies = DataManager.shared.getListMovies()
    }
    
    @objc
    private func sortListMovies() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let titleAction = UIAlertAction(title: "Title", style: .default) { action in
            if let listMovie = self.listMovies {
                self.listMovies?.listMovie = listMovie.listMovie.sorted(by: { $0.title < $1.title })
                self.moviesTableView.reloadData()
            }
        }
        let releaseDateAction = UIAlertAction(title: "Released Date", style: .default, handler: { action in
            if let listMovie = self.listMovies {
                self.listMovies?.listMovie = listMovie.listMovie.sorted(by: { $0.releasedDate < $1.releasedDate })
                self.moviesTableView.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(titleAction)
        alert.addAction(releaseDateAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listMovies = self.listMovies, !listMovies.listMovie.isEmpty else {
            return 0
        }
        return listMovies.listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        guard let listMovies = self.listMovies, !listMovies.listMovie.isEmpty else {
            return UITableViewCell()
        }
        let movieItem = listMovies.listMovie[indexPath.item]
        cell.selectionStyle = .none
        cell.setupCell(movie: movieItem)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listMovies = self.listMovies, !listMovies.listMovie.isEmpty else {
            return
        }
        guard let detailMovieVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        let movieItem = listMovies.listMovie[indexPath.item]
        detailMovieVC.movieItem = movieItem
        detailMovieVC.delegate = self
        navigationController?.pushViewController(detailMovieVC, animated: true)
    }
}

// MARK: - MovieDetailViewControllerProtocol
extension MoviesViewController: MovieDetailViewControllerProtocol {
    func updateMovieItem(movieItem: MovieItem?) {
        guard let movie = movieItem,
              let listMovies = self.listMovies, !listMovies.listMovie.isEmpty else {
            return
        }
        if let foundMovieIndex = listMovies.listMovie.firstIndex(where: { ($0.title == movie.title) && ($0.releasedDate == movie.releasedDate)
        }) {
            self.listMovies?.listMovie.remove(at: foundMovieIndex)
            self.listMovies?.listMovie.insert(movie, at: foundMovieIndex)
            moviesTableView.reloadData()
        }
    }
}
