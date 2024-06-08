//
//  MovieModel.swift
//  LottoMovie0605
//
//  Created by 최민경 on 6/8/24.
//

import UIKit

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
