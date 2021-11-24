//
//  Characters.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 23.11.2021.
//

import Foundation

struct MarvelCharactersModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    /*let description: String
    let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription
        case modified, thumbnail, resourceURI, comics
    }*/
}

/*
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}*/
