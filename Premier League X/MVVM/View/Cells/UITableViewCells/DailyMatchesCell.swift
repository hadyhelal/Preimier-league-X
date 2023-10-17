//
//  DailyMatchesCell.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import UIKit

class DailyMatchesCell: UITableViewCell {

    static let id = String(describing: DailyMatchesCell.self)
    static let rowHeight: CGFloat =  125
    
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    @IBOutlet weak var matchResultView: UIView!
    @IBOutlet weak var matchSchedualView: UIView!
    
    @IBOutlet weak var matchStartsTime: UILabel!
    
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        homeTeamImage.image = nil
        awayTeamImage.image = nil
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(match: Match) {
        
        matchSchedualView.isHidden = true
        matchResultView.isHidden   = true
        
        DispatchQueue.main.async {
            self.homeTeamImage.downloadImage(url: match.homeTeam?.crest)
            self.awayTeamImage.downloadImage(url: match.awayTeam?.crest)
        }
        homeTeamNameLabel.text = match.homeTeam?.shortName
        
        awayTeamName.text      = match.awayTeam?.shortName
        
        configureMatch(match: match)
    }
    
    private func configureMatch(match: Match) {
        guard let matchStatus = match.status else {return}
        switch matchStatus {
        case .finished:
            matchSchedualView.isHidden = true
            matchResultView.isHidden   = false
            
            homeTeamScoreLabel.text = "\(match.score?.fullTime?.home ?? 0)"
            awayTeamScoreLabel.text = "\(match.score?.fullTime?.away ?? 0)"
            
        case .scheduled, .timed:
            matchSchedualView.isHidden = false
            matchResultView.isHidden   = true
            
            matchStartsTime.text = DateFormatterManager.convertToAmBm(match.utcDate ?? "")
        }
    }
    
}

struct DateFormatterManager {
    
    static func convertToAmBm(_ dateStr: String) -> String {
        let date = getLeagueDate(dateStr)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date)
        return date24
    }
    
    static func getLeagueDate(_ dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateStr) else {
            return Date()
        }
        
        return date
    }
    
    static func getLeagueDateStr(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
                
        return dateFormatter.string(from: date)
    }
    
    
    
}


