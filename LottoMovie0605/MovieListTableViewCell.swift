//
//  MovieListTableViewCell.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/6/24.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    static let id = "MovieListTableViewCell"
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierarchy() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureConstraints(){
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.verticalEdges.equalTo(contentView).inset(10)
            make.height.equalTo(40)
            make.width.equalTo(numberLabel.snp.height).multipliedBy(1.2)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.verticalEdges.equalTo(numberLabel)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(25)
            make.verticalEdges.equalTo(numberLabel)
            make.trailing.equalTo(dateLabel.snp.leading)
        }
    }
    

}
