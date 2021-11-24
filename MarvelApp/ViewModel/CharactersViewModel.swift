//
//  CharactersViewModel.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 24.11.2021.
//

import Foundation

struct CharactersViewModel{
    
    let charactersList : [MarvelCharactersModel]
    
}

extension CharactersViewModel{
    func numberOfRowInSection() -> Int{
        return 15
    }
    
    /*func cryptoAtIndex(_ index: Int) -> CryptoViewModel{
        let crypto = self.crytpoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }*/
}

/*struct crmodel  {
    let crmode : MarvelCharactersModel
}

extension crmodel {
    var name : String{
        return self.crmode.data.results.count
    }
    
    var price : String{
        return self.cryptoCurrency.price
    }
}*/


