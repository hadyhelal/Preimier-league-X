//
//  MatchesListVC.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//

import UIKit

typealias MatchesScheduals = [ PremierMatch ]
typealias PremierMatch     = (Date,[Match])



enum DisplayMatchType  {
    case matches
    case favoriteMatches
}

class MatchesListVC: BaseViewController {

    //Outlets
    @IBOutlet weak var matchesTableView: UITableView!
    
    
    //Properties
    lazy var viewModel = MatchesListVM(matchesAPI: MatchesAPI())
    
    var matches = [MatchesSection]()
    var favoritematches = [Match]()
    
    var displayMatchType: DisplayMatchType = .matches
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMatchesTableView()
        
        binding()
        
        viewModel.getMatches()

    }

    //Buttons Actions
    @IBAction func matchSelectSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            displayMatchType = .matches
            
        case 1:
            displayMatchType = .favoriteMatches
        default:
            break
        }
        
        matchesTableView.reloadData()

    }
    
    //UI Configurations
    fileprivate func configureMatchesTableView() {
        matchesTableView.registerCell(cell: DailyMatchesCell.self)
        matchesTableView.rowHeight = DailyMatchesCell.rowHeight
    }
    
    
    //Binding Logic
    func binding() {
        viewModel.loadingView = { [weak self] manageLoading in
            self?.loading(manageLoading)
        }
        
        viewModel.successMessage = { [weak self] successMessage in
            self?.showSuccessMessage(message: successMessage)
        }
                
        viewModel.observeMatches = { [weak self] matches in
            self?.matches = matches
            DispatchQueue.main.async {
                self?.matchesTableView.reloadData()
            }
        }
        
        
    }
    
}


