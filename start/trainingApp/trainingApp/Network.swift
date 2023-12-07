import Foundation

class Network {
    func fetchMarvelCharacters(completion: @escaping ([Marvel]?) -> Void) {
        let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=10000&apikey=9324990817df03907a237fc52958e4f1&hash=a53826a71981b7eb2bde14709476d4f1")!
        
        //RESULTAT DE LA REQUÊTE
                  
              // "code": 200,
              //    "status": "Ok",
              //    "copyright": "© 2023 MARVEL",
              //    "attributionText": "Data provided by Marvel. © 2023 MARVEL",
              //    "attributionHTML": "<a href=\"http://marvel.com\">Data provided by Marvel. © 2023 MARVEL</a>",
              //    "etag": "e6fcf8ec1fd56fd73e4ff2d62d656718a49d719a",
              //    "data": {
              //        "offset": 0,
              //        "limit": 20,
              //        "total": 1563,
              //        "count": 20,
              //        "results": [
              //            {
              //                "id": 1011334,
              //                "name": "3-D Man",
              //                "description": "",
              //                "modified": "2014-04-29T14:18:17-0400",
              //                "thumbnail": {
              //                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
              //                    "extension": "jpg"
              //                },
              //           [...]
              //
              //            {
              //                    "id": 1017100,
              //                    "name": "A-Bomb (HAS)",
              //                    "description": "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
              //                    "modified": "2013-09-18T15:54:04-0400",
              //                    "thumbnail": {
              //                        "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
              //                        "extension": "jpg"
              //                    },
              //                    "resourceURI": "http://gateway.marvel.com/v1/public/characters/1017100",
              //   [...]
        
        //todo : on peut voir que les images snt présentes sur le site http://i.annihil.us . Malheureusement, les adresses http ne peuvent  pas être supportées. Il faut pour chaque image: rajouter le caractère "s" après les 4 lettres HTTP pour chaque lien d'image avant d'effectuer les opérations avec
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Erreur de réseau ou données manquantes.")
                completion(nil)
                return
            }

            do {
                // Décodez le JSON en un objet de données
                let marvelResponse = try JSONDecoder().decode(MarvelResponse.self, from: data)
               
                let marvels = marvelResponse.data.results.map {
                       Marvel(name: $0.name, description: $0.description, imageURL: $0.thumbnail.url)
                   }
                   completion(marvels)
            } catch {
                print("Erreur de décodage JSON : \(error)")
                completion(nil)
            }
        }

        
        
        task.resume()
    }
}

struct MarvelResponse: Codable {
    let data: MarvelData
}

struct MarvelData: Codable {
    let results: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    let name: String
    let description: String
    let thumbnail: Thumbnail

    struct Thumbnail: Codable {
        let path: String
        let `extension`: String

        enum CodingKeys: String, CodingKey {
            case path
            case `extension` = "extension"
        }

        var url: URL? {
            // Vérifie si le chemin commence par "http" et remplace par "https" si nécessaire
            var securePath = path
            if path.starts(with: "http://") {
                securePath = "https://" + path.dropFirst(7)
            }
            return URL(string: "\(securePath).\(`extension`)")
        }
    }

}

struct Marvel: Codable {
    var name: String
    var description: String
    var imageURL: URL?
}






