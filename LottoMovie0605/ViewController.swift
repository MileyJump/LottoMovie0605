//
//  ViewController.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.text = "893"
        textField.placeholder = "회차를 입력하세요"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }()
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨 번호 안내"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-05-30 추정"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "893회"
        label.textColor = .systemYellow
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨결과"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let firstNumberLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemYellow
        label.text = "6"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let secondNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.text = "6"
        label.textAlignment = .center
        return label
    }()
    
    let thirdNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.textAlignment = .center
        label.text = "6"
        return label
    }()
    
    let fourthNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.text = "6"
        label.textAlignment = .center
        return label
    }()
    
    let fifthNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.text = "6"
        return label
    }()
    
    let sixthNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .lightGray
        label.text = "6"
        label.textAlignment = .center
        return label
    }()
    
    let pluslabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textAlignment = .center
        return label
    }()
    
    let seventhNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        label.text = "6"
        return label
    }()
    
    let bonusNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "보너스"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNumberLabel, secondNumberLabel, thirdNumberLabel, fourthNumberLabel, fifthNumberLabel, sixthNumberLabel, pluslabel, seventhNumberLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
//        stackView.backgroundColor = .blue
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [firstNumberLabel, secondNumberLabel, thirdNumberLabel, fourthNumberLabel, fifthNumberLabel, sixthNumberLabel, pluslabel, seventhNumberLabel].forEach { label in
               label.layer.cornerRadius = label.frame.height / 2
               label.clipsToBounds = true
           }
    }
    
    func configureHierarchy() {
        view.addSubview(numberTextField)
        view.addSubview(guideLabel)
        view.addSubview(dateLabel)
        view.addSubview(lineView)
        view.addSubview(numberLabel)
        view.addSubview(resultLabel)
        view.addSubview(labelStackView)
        view.addSubview(bonusNumberLabel)
    }
    
    func configureConstraints() {
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.leading.equalTo(numberTextField.snp.leading)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(numberTextField.snp.trailing)
            make.top.equalTo(guideLabel.snp.top)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(numberTextField)
            make.height.equalTo(1)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.45)
            make.leading.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.top)
            make.leading.equalTo(numberLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(numberTextField)
            make.height.equalTo(70)
        }
        
        [firstNumberLabel, secondNumberLabel, thirdNumberLabel, fourthNumberLabel, fifthNumberLabel, sixthNumberLabel, pluslabel, seventhNumberLabel].forEach { label in
                 label.snp.makeConstraints { make in
                     make.height.equalTo(label.snp.width)
                 }
             }
        bonusNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(seventhNumberLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(seventhNumberLabel)
        }
    }
    
    func configureAddTarget() {
        numberTextField.addTarget(self, action: #selector(numberTextFieldTapped), for: .touchUpInside)
    }
    
    @objc func numberTextFieldTapped() {
        print("==")
    }
}
