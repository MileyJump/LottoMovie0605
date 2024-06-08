//
//  MovieListViewController.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

struct BoxOfficeResult: Decodable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [Movie]
}

struct MovieBoxOfficeResult: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct Movie: Decodable {
    let rank: String?
    let openDt: String?
    let movieNm: String?
}

class MovieListViewController: UIViewController {
    
    var list: [Movie] = []
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "수리남")
        imageView.alpha = 1
        return imageView
    }()
 
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "20240607 형식으로 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
        configureTableView()
        configureAddTarget()
    }
    
    func configureAddTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        print("3")
        
        
        
        guard let text = searchTextField.text else { return }
        
        AF.request("\(APIURL.movieURL)\(text)").responseDecodable(of: MovieBoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                print("성공!")
                self.list = value.boxOfficeResult.dailyBoxOfficeList
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        
//        AF.request(url).responseString { response in
//            switch response.result {
//            case .success(let value):
//                print(value)
//            case .failure(let error):
//                print("error")
//            }
//        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.id)
        tableView.separatorStyle = .none

    }
    
    func configureHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(lineView)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.width.equalTo(55)
        }
     
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-15)
            make.bottom.equalTo(searchButton)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(searchTextField)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(backgroundView)
        }
        
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.id, for: indexPath) as! MovieListTableViewCell
        
        cell.configureCell(data: list[indexPath.row])
        
        return cell
    }
    
    
    
    
}
