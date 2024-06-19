//
//  WeatherViewController.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/8/24.
//

import UIKit
import CoreLocation
import Alamofire
import Kingfisher

class WeatherViewController: UIViewController {
    
    let locationManager = CLLocationManager()
 
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = nowDate()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "서울, 신림동"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    let temperatureUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "지금은 9도 예요"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let humidityUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "78% 만큼 습해요"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let windUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    let windLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.layer.cornerRadius = 4
        label.textColor = .black
        label.text = "1m/s의 바람이 불어요"
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        
        
        
//        imageView.image = UIImage(systemName: "sun.min.fill")
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let mentUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    
    let mentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.text = "오늘도 행복한 하루 보내세요❤️"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        locationManager.delegate = self
        configureHierarchy()
        configureConstraints()
//        weatherAPI()
        
        checkDeviceLocationAuthorization()
    }
    
    func weatherAPI(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let url = "\(APIURL.weatherURL)lat=\(lat)&lon=\(lon)&lang=kr&units=metric&appid=\(APIKey.weatherKey)"
        
        AF.request(url).responseDecodable(of: WeatherModel.self) { response in
            switch response.result {
            case .success(let value):
//                print(value)
                self.locationLabel.text = "\(value.name)"
                let url = URL(string: "\(APIURL.weatherIcon)\(value.weather[0].icon)@2x.png")
                self.weatherImageView.kf.setImage(with: url)
                self.humidityLabel.text = value.main.dehumidity
                self.windLabel.text = value.wind.windSpped
                self.temperatureLabel.text = value.main.temperature
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func nowDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM월 dd일 HH시 mm분"
        let saveDateformatter = dateformatter.string(from: Date())
        return saveDateformatter
    }
    
    func configureHierarchy() {
        view.addSubview(dateLabel)
        view.addSubview(locationImageView)
        view.addSubview(shareButton)
        view.addSubview(refreshButton)
        view.addSubview(locationLabel)
        view.addSubview(temperatureUIView)
        temperatureUIView.addSubview(temperatureLabel)
        view.addSubview(humidityUIView)
        humidityUIView.addSubview(humidityLabel)
        view.addSubview(windUIView)
        windUIView.addSubview(windLabel)
        view.addSubview(weatherImageView)
        view.addSubview(mentUIView)
        mentUIView.addSubview(mentLabel)
    }
    
    func configureConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(35)
            make.height.equalTo(20)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.size.equalTo(25)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.size.equalTo(refreshButton)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-25)
            
        }
        
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.leading.equalTo(view).inset(28)
            make.size.equalTo(30)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImageView)
            make.leading.equalTo(locationImageView.snp.trailing).offset(10)
        }
        
        temperatureUIView.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.bottom).offset(15)
            make.leading.equalTo(locationImageView.snp.leading)
            make.height.equalTo(40)
            
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        humidityUIView.snp.makeConstraints { make in
            make.top.equalTo(temperatureUIView.snp.bottom).offset(15)
            make.leading.equalTo(locationImageView.snp.leading)
            make.height.equalTo(40)
            
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        windUIView.snp.makeConstraints { make in
            make.top.equalTo(humidityUIView.snp.bottom).offset(15)
            make.leading.equalTo(locationImageView.snp.leading)
            make.height.equalTo(40)
            
        }
        
        windLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(windUIView.snp.bottom).offset(15)
            make.height.equalTo(150)
            make.width.equalTo(weatherImageView.snp.height).multipliedBy(1.4)
            make.leading.equalTo(locationImageView.snp.leading)
        }
        
        mentUIView.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(15)
            make.leading.equalTo(locationImageView.snp.leading)
            make.height.equalTo(40)
            
        }
        
        mentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        
    }
    
}

extension WeatherViewController {
    
    func checkDeviceLocationAuthorization()
    {
        if CLLocationManager.locationServicesEnabled() {
            
            //2) 현재 사용자 위치 권한 상태 확인
            checkCurrentLocationAuthorization()
            
        } else {
            print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없어요.")
        }
    }
    
    func checkCurrentLocationAuthorization() {
        
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus // 현재 상태
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print("이 권한에서만 권한 문구를 띄울 수 있음")
            // 정확도, 위치 정보를 알려달라고 할 때 업데이트 주기
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            
            
        case .denied:
            print("iOS 설정 창으로 이동하라는 얼럿을 띄워주기")
        case .authorizedWhenInUse:
            print("위치 정보  알려달라고 로직을 구성할 수 있다")
    
            locationManager.startUpdatingLocation() // 현재 위치 정보에 대해 주세요 라는 메서드
            
        // 추후에 알려지지 않은 케이스를 떨이 처리 하기 위해 (Ex. 나중에 애플에서 새로운 버전의 위치 권한(case)이 생길 수 있고.. 등)
        default:
            print(status)
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
//            print(coordinate)
            print("======\(coordinate.latitude)")
            print("\(coordinate.longitude)-----")
//            lat = coordinate.latitude
//            lon = coordinate.longitude
//            print("lat: \(lat) lon: \(lon)")
            weatherAPI(lat: coordinate.latitude, lon: coordinate.longitude)
            
        }
        
        //stopUpdatingLocation을 했으면 더 이상 위치를 안 받아도 되는 시점에서 stop을 해준다.
        locationManager.stopUpdatingLocation()
    }
    
    // 6. 사용자 위치를 가지고 오지 못 했거나
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 7. 사용자 권한 상태가 변경이 될 때(iOS14) + 인스턴스가 생성이 될 때도 호출이 된다.
    // -> 사용자가 허용했었는데 아이폰 설정에서 나중에 허용을 거부한다면..
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkDeviceLocationAuthorization()
    }
    
    // 동일한 코드지만, iOS버전에 따라 사용되는게 다름
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14-")
    }
}
