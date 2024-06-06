//
//  ViewController.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let drwNo: Int
    let bnusNo: Int
}

class ViewController: UIViewController {
    
    let pickerView = UIPickerView()
    let numbers = Array(1...1200)
    
    
    
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
        view.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
        numberTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        numberTextField.text = "\(numbers[row])"
        
        let number = numbers[row]
 
        numberLabel.text = "\(number)회"
        
        AF.request("\(APIURL.lottoURL)\(number)").responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.numberTextField.text = "\(value.drwNo)"
                self.firstNumberLabel.text = "\(value.drwtNo1)"
                self.secondNumberLabel.text = "\(value.drwtNo2)"
                self.thirdNumberLabel.text = "\(value.drwtNo3)"
                self.fourthNumberLabel.text = "\(value.drwtNo4)"
                self.fifthNumberLabel.text = "\(value.drwtNo5)"
                self.sixthNumberLabel.text = "\(value.drwtNo6)"
                self.seventhNumberLabel.text = "\(value.bnusNo)"
            case .failure(let error):
                print(error)
            }
        }
        view.endEditing(true)
    }
    
    
}

