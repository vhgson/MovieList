//
//  DataManager.swift
//  MovieList
//
//  Created by Son Vu on 10/09/2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    func getListMovies() -> MoviesList? {
        guard let movieURL = Bundle.main.url(forResource: "MoviesList", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: movieURL)
            let movieList = try JSONDecoder().decode(MoviesList.self, from: data)
            return movieList
        } catch let error {
            debugPrint("Error loading file: \(error)")
        }
        return nil
    }
}
