//
//  ResultViewController.swift
//  BlackJack
//
//  Created by macbookp on 08.08.2021.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultTableView: UITableView!

    var resultList: [Any] {
        guard let results = TopResults.resultsArray else { return [Int]() }
        return results
    }

    var nameList: [Any] {
        guard let names = TopResults.namesArray else { return [String]() }
        return names
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1269071996, green: 0.3554212451, blue: 0.2191436887, alpha: 1)
    }

    override func viewDidLoad() {
        super .viewDidLoad()
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.allowsSelection = false
        resultTableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "resultCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return resultList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        if indexPath.section == 0 {
            cell.cofigure(name: "NAME", result: "SCORE", firstCell: true)
            return cell
        }

        cell.cofigure(name: nameList[indexPath.row] as! String, result: "\(resultList[indexPath.row])",firstCell: false)
        return cell
    }

}
