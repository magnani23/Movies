//
//  HomeViewController.swift
//  Movies
//
//  Created by Victor Magnani on 15/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeTableView = UITableView()
    let moviesName = ["John Wick", "The Matrix", "Constantine"]
    
    override func loadView() {
        super.loadView()
        self.title = "Home"
        self.prepareLayout()
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
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        cell.movieTitleLabel.text = moviesName[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MovieDetailViewController()
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

