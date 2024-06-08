//
//  WeatherModel.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/8/24.
//

import UIKit



struct WeatherModel: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let coord: Coord
    let name: String
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon : String
    
   
}

struct Main: Decodable {
    
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
    let sea_level : Double
    let grnd_level: Double
    
    var dehumidity: String {
        let humid = Int(humidity)
        return "\(humid)% 만큼 습해요!"
    }
    
    var temperature: String {
        let tempCelsius = Int(round(temp))
        return "지금은 \(tempCelsius)℃ 에요"
    }
    
}

//"visibility": 10000,
struct Wind: Decodable {
    let speed: Double
    
    var windSpped: String {
        return "\(speed)m/s의 바람이 불어요"
    }
}
