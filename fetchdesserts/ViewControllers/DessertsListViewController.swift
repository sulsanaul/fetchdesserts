//
//  ViewController.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/17/22.
//

import UIKit

class DessertsListViewController: UIViewController {
    let tableView = UITableView()
    let dessertsViewModel = DessertsListViewModel()
    
    lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // rudimentary loading indication
    var state = ListViewState.fetchingData {
        didSet {
            switch state {
            case .fetchingData:
                activityIndicator.startAnimating()
            case .fetchStopped:
                activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addFullscreenSubview(tableView)
        title = Constants.dessertsListViewTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DessertTableViewCell.self,
                           forCellReuseIdentifier: "DessertTableViewCell")
        tableView.tableFooterView = activityIndicator
        state = .fetchingData
        
        dessertsViewModel.fetchDesserts {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.state = .fetchStopped
            }
        }

    }
}

// MARK: Table View Conformance
extension DessertsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dessertsViewModel.desserts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DessertTableViewCell",
            for: indexPath) as? DessertTableViewCell else {
            return DessertTableViewCell()
        }
        let dessert = dessertsViewModel.desserts[indexPath.row]
        cell.configure(with: dessert)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dessert = dessertsViewModel.desserts[indexPath.row]
        let detailViewController = DessertDetailViewController(dessert: dessert)
        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.dessertCellHeight
    }
}

enum ListViewState {
    case fetchingData
    case fetchStopped
}
