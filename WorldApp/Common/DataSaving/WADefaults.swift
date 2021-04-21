//
//  WADefaults.swift
//  WorldApp
//
//  Created by Alex on 29.03.21.
//

import Foundation

// Singleton
class WADefaults {
    static let sh = WADefaults()

    private enum Keys {
        static let places = "WAPlaces"
    }

    var places: [WAPlace] {
        get {
            self.loadPlaces()
        }
        set(newPlaces) {
            self.savePlaces(newPlaces)
        }
    }

//    тестовый код
//    lazy var test: Int = self.loadTestValue()
//
//    private init() {}
//
//    func saveTestValue() {
//        UserDefaults.standard.setValue(test, forKey: "TestValueKey")
//    }
//
//    func loadTestValue() -> Int {
//        let value = UserDefaults.standard.value(forKey: "TestValueKey") as? Int
//        return value ?? 1
//    }

    // пробуем закодировать сохранить places в defaults
    private func savePlaces(_ places: [WAPlace]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(places) {
            UserDefaults.standard.setValue(data, forKey: Keys.places)
        }
    }

    private func loadPlaces() -> [WAPlace] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Keys.places),
        let places = try? decoder.decode([WAPlace].self, from: data) {
            return places
        } else {
            return [
                WAPlace(title: "Chicago",
                        description: "The City of Chicago covers an area of 60,000 hectares and sits 176 meters (578 feet) above sea level on the southwestern shore of Lake Michigan. At 190 km wide and 495 km long, its the 5th largest body of fresh water in the world.",
                        imageUrl: "https://media.timeout.com/images/105658075/image.jpg)",
                        isFavourite: false),
                WAPlace(title: "Minsk",
                        description: nil,
                        imageUrl: "https://www.toursoyuz.by/wp-content/uploads/2019/05/minsk.jpg",
                        isFavourite: true),
                WAPlace(title: "Gomel",
                        description: nil,
                        imageUrl: "https://planetabelarus.by/upload/medialibrary/a45/a4509b7c9d54bdc9a20886c9ab9e981f.jpg",
                        isFavourite: false),
                WAPlace(title: "Cardiff",
                        description: nil,
                        imageUrl: "https://cw-gbl-gws-prod.azureedge.net/-/media/cw/emea/united-kingdom/offices/hero-image-emea-office-cardiff-small.jpg",
                        isFavourite: false),
                WAPlace(title: "Moscow",
                        description: "Is the capital and largest city of Russia.",
                        imageUrl: "https://media.istockphoto.com/photos/st-basils-cathedral-and-golden-first-rays-of-the-sun-picture-id1062947134?k=6&m=1062947134&s=612x612&w=0&h=8_QdIz8qrp76_KWjduddK4YZsXW0_e61FQCz0o2a_ns=",
                        isFavourite: false),
                WAPlace(title: "Paris",
                        description: nil,
                        imageUrl: "",
                        isFavourite: false),
                WAPlace(title: "Kyiv",
                        description: nil,
                        imageUrl: "https://images11.popmeh.ru/upload/custom/e26/e26f37f51198bf3c494bc15f674051a3.jpg",
                        isFavourite: true),
                WAPlace(title: "Cairo",
                        description: nil,
                        imageUrl: "https://specials-images.forbesimg.com/imageserve/466090186/960x0.jpg",
                        isFavourite: false)
            ]
        }
    }
}
