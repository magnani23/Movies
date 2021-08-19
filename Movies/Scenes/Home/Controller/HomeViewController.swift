//
//  HomeViewController.swift
//  Movies
//
//  Created by Victor Magnani on 15/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeTableView = UITableView()
    var moviesViewModel = [MovieViewModel]()
    
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
    
    private func prepareLayout() {
        view.addSubview(homeTableView)
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
        Service.loadMovies { (moviesResult) in
            self.moviesViewModel = moviesResult.results.map({return MovieViewModel(movieResult: $0)})
            self.prepareLayout()
            self.homeTableView.reloadData()
        } onError: { (error) in
            print(error)
        }
    }
}



//MARK: - DataSource and Delegate

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        let movieList = moviesViewModel[indexPath.row]
        cell.prepare(movie: movieList)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewController = MoviesViewController(movie: (moviesViewModel[indexPath.row]))
//        self.navigationController?.pushViewController(viewController, animated: true)
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



