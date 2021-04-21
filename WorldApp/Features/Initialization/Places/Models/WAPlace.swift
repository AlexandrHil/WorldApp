//
//  WAPlace.swift
//  WorldApp
//
//  Created by Alex on 22.03.21.
//

import Foundation

struct WAPlace: Codable {
    var id = UUID()
    let title: String
    let description: String?
    let imageUrl: String
    var isFavourite: Bool
}
