//
//  HomeViewController.swift
//  Movies
//
//  Created by Victor Magnani on 15/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let homeTableView = UITableView()
    private let moviesViewModel = MovieViewModel()
    
    //MARK: - Life Cicle

    override func viewDidLoad() {
        self.fetchMovies()
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Home"
        self.homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        self.homeTableView.dataSource = self
        self.homeTableView.delegate   = self
    }
    
    //MARK: - Methods
    
    private func prepareLayout() {
        self.view.addSubview(homeTableView)
        self.setTableViewConstraints()
        self.homeTableView.removeExtraCellLines()
    }
    
    private func setTableViewConstraints() {
        self.homeTableView.translatesAutoresizingMaskIntoConstraints = false
        self.homeTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.homeTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.homeTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func fetchMovies() {
        self.moviesViewModel.fetchData {
            DispatchQueue.main.async {
                self.prepareLayout()
                self.homeTableView.reloadData()
            }
            
        } failure: { (error) in
            //Add error screen
            print(error)
        }
    }
}


//MARK: - DataSource and Delegate

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.movies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieList = moviesViewModel.movies?.results[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.prepare(movie: movieList)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moviesViewModel.selectedMovie = moviesViewModel.movies?.results[indexPath.row]
        let viewController = MoviesViewController(movie: moviesViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension UITableView {
    func removeExtraCellLines() {
        tableFooterView = UIView(frame: .zero)
    }
}



