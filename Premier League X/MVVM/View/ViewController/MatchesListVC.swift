//
//  MatchesListVC.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//

import UIKit

class MatchesListVC: BaseViewController {

    @IBOutlet weak var matchesTableView: UITableView!
    
    lazy var viewModel = MatchesListVM(matchesAPI: MatchesAPI())
    
    var matches = [ (Date,[Match]) ]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        matchesTableView.registerCell(cell: DailyMatchesCell.self)
        matchesTableView.rowHeight = DailyMatchesCell.rowHeight
        
        viewModel.loadingView = { [weak self] manageLoading in
            self?.loading(manageLoading)
        }
        
        viewModel.successMessage = { [weak self] successMessage in
            self?.showSuccessMessage(message: successMessage)
        }
        
        viewModel.getMatches()
        
        viewModel.observeMatches = { [weak self] matches in
            self?.matches = matches
            DispatchQueue.main.async {
                self?.matchesTableView.reloadData()
            }
        }
        
        
    }

    @IBAction func matchSelectSegment(_ sender: UISegmentedControl) {
       
    }
    
    
}

extension MatchesListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyMatchesCell.id, for: indexPath) as! DailyMatchesCell
        cell.selectionStyle = .none
        cell.configure(match: matches[indexPath.section].1[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = matches[indexPath.row]
        print("===HOME TEAM===")
        print(match)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let dateLabel = UILabel()
        view.backgroundColor = .secondarySystemBackground
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let date = matches[section].0
        
        dateLabel.text = DateFormatterManager.getLeagueDateStr(date)
        
        return view
    }
}


