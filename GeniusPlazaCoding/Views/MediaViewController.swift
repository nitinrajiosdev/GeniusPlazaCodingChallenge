//
//  MediaViewController.swift
//  GeniusPlazaCoding
//
//  Created by Nitin Pabba on 9/3/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    let viewModel = MediaViewModel()

    let mainTableView: UITableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        mainTableView.dataSource = self
        viewModel.notifyWhenDataComplete = { [weak self] in
            //Using weak here, because viewmodel has a strong reference to notifyWhenDataComplete
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
        viewModel.getMedia()
    }
}

//MARK: Private
extension MediaViewController {
    private func configureSubviews() {
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        //constraint
        //The following code unwraps views forcefulle, because we're sure to have a view, as we're carefully only calling this inside viewdidload. which means the view is already available to us, thats why the force unwrapping, if not i'd be using if let or guard let
        let leadingConstraint = NSLayoutConstraint(item: view!, attribute: .leading, relatedBy: .equal, toItem: mainTableView, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: view!, attribute: .trailing, relatedBy: .equal, toItem: mainTableView, attribute: .trailing, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: view!, attribute: .top, relatedBy: .equal, toItem: mainTableView, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: view!, attribute: .bottom, relatedBy: .equal, toItem: mainTableView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
    }
}

//MARK: UITableViewDataSource methods
extension MediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mediaArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        let media = viewModel.mediaArray?[indexPath.row]
        cell?.textLabel?.text = media?.name
        return cell ?? UITableViewCell()
    }
}
