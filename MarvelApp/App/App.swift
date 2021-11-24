//
//  App.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 24.11.2021.
//

import Foundation
import SwiftyJSON

struct App {
    static var user_data = UserDefaults.standard
    static var serviceurl = "https://gateway.marvel.com/v1/public/"
    static var apikey = "1f31ca8fc2d5965c42b2dcf8b185d77b"
    static var hash = "834b37230bbf6cc915f58e81c16bf664"
    static var ts = "1636673714"
    static var charactersJSON = JSON()
    static var comicsJSON = JSON()
}

