//
//  PhotoPickerDataModel.swift
//  Tinkoff first app
//
//  Created by Ash on 20.04.2021.
//

import Foundation

struct ResponseData: Decodable {
    let hits: [ImageURL]
}

struct ImageURL: Decodable {
    let largeImageURL: String
}
