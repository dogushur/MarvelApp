//
//  Webservice.swift
//  CryptoCrazy
//
//  Created by Doğuş Hür on 23.11.2021.
//

import Foundation

class MarvelService{
    
    let url = URL(string: "https://gateway.marvel.com/v1/public/characters?&apikey=1f31ca8fc2d5965c42b2dcf8b185d77b&hash=834b37230bbf6cc915f58e81c16bf664&ts=1636673714")!
    
    /*func getCharacters(completion: @escaping ([MarvelCharactersModel]?) -> ()){
        AF.request(url).validate().responseDecodable(of: MarvelCharactersModel.self) { data in
            
            print("dogi:\(data)")
            
            completion(data)
            
        }
    }*/
    
    func getCharacters(completion: @escaping ([MarvelCharactersModel]?) -> ()){
        let api = URL(string: "https://gateway.marvel.com/v1/public/characters?&apikey=1f31ca8fc2d5965c42b2dcf8b185d77b&hash=834b37230bbf6cc915f58e81c16bf664&ts=1636673714")
        
        URLSession.shared.dataTask(with: api!){
            data,response,error in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(MarvelCharactersModel.self, from: data!)
                print(result)
            } catch {
                
            }
        }.resume()
    }
    
    /*func getCharacters(completion: @escaping ([MarvelCharactersModel]?) -> ()){
        
        let url = URL(string: "")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                
                let characterList = try? JSONDecoder().decode([MarvelCharactersModel].self, from: data)
                
                print("dogi:\(characterList)")
                
                if let characterList = characterList{
                    completion(characterList)
                }
            
            }
        }.resume()
        
    }*/
    
}
