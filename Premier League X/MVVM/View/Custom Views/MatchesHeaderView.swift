//
//  MatchesHeaderView.swift
//  Premier League X
//
//  Created by WAITEG on 17/10/2023.
//

import UIKit

class MatchesHeaderView: UIView {
    
    let headerTextLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchesHeader()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpMatchesHeader() {
        backgroundColor = .secondarySystemBackground
        headerTextLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        headerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerTextLabel)
        NSLayoutConstraint.activate([
            headerTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
}
