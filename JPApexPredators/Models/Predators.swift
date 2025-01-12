//
//  Predators.swift
//  JPApexPredators
//
//  Created by Paul F on 25/10/24.
//

import Foundation

/*Class sirve mas para la manipulación de los datos.
V-32,Paso 3, decodificamos el json.*/
class Predators{

    //Paso 50
    var allApexPredators: [ApexPredator] = []
    //Paso 4, creammos una variable para poder decodificarlo, le ponemos var porque va a cambiar.
    var apexPredators: [ApexPredator] = []

    
    //Paso 7,creamos una instancia para poder llamarlos,siempre va.
    init(){
        decodeApexPredatorData()
    }
    
    //Paso 5,creamos nuestra función de decodificación.
    func decodeApexPredatorData(){
        
        //Le mandamos un archivo para codificar el json.
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                //bot question mark needed.
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                /*a esto se le llama snake case "movie_Scenes",pero swfit lo hace en camelCase
                Paso 6,Importante tenemos "movie_Scenes" en el Json ,pero debe ser igual a "movieScenes"*/
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                //Paso 52
                apexPredators = allApexPredators
                
            }catch{
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    
    //Vid 36, Paso 24 , creamos la función,esto regresa la colección de ->[ApexPredator]
    
    func search (for searchTerm: String) ->[ApexPredator]{
        //Paso 22, sino han escrito nada
        if searchTerm.isEmpty{
            //regresame todo los dinosarios.
            return apexPredators
        }else{
            //regresa los predator filtrados.
            return apexPredators.filter{predator in predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    //Paso 26,para ordenar alfabeticamente los dinosaurios.
    func sort (by alphabetical : Bool){
        //necesitamos 2 propiedades para poder comparar
        apexPredators.sort{ predator1,predator2 in
            
            if alphabetical{
                predator1.name < predator2.name
            }else{
                predator1.id < predator2.id
            }
        }
    }
    
    //Vid 37, Paso 32
    func filter(by type:PredatorType){
        //Paso 50
        if type == .all{
            //Paso 53,sino se filtra nada pon todo los dinosarios
            apexPredators = allApexPredators
        }else {
            //Paso 39,
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
        
    }
}
