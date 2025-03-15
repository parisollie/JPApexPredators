//
//  Predators.swift
//  JPApexPredators
//
//  Created by Paul F on 25/10/24.
//

import Foundation

/*
  Class sirve mas para la manipulación de los datos.
  V-32,Paso 1.2, decodificamos el json.
 */
class Predators{
    //Paso 1.3, creammos una variable para poder decodificarlo, le ponemos var porque va a cambiar.
    var apexPredators: [ApexPredator] = []
    
    //V-37,paso 64
    var allApexPredators: [ApexPredator] = []

    
    //Paso 1.5,creamos una instancia para poder llamarlos,siempre va.
    init(){
        decodeApexPredatorData()
    }
    
    //Paso 1.4,creamos nuestra función de decodificación.
    func decodeApexPredatorData(){
        
        //Le mandamos un archivo para codificar el json.
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                //bot question mark needed.
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                /*
                   a esto se le llama snake case "movie_Scenes",pero swfit lo hace en camelCase
                   Paso 1.6,Importante tenemos "movie_Scenes" en el Json ,pero debe ser igual a
                   "movieScenes"
                */
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                //Paso 65,cambiamos a allApexPredators
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                //Paso 66
                apexPredators = allApexPredators
                
            }catch{
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    
    //V-35,Paso 1.34, creamos la función que buscara dinosaurios,esto regresa la colección de ->[ApexPredator]
    func search (for searchTerm: String) ->[ApexPredator]{
        //V-34,Paso 1.31, sino han escrito nada
        if searchTerm.isEmpty{
            //regresamé todos los dinosarios.
            return apexPredators
        }else{
            //Paso 1.32,regresa los predator filtrados.
            return apexPredators.filter{predator in predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    //Paso 1.36,función,para ordenar alfábeticamente los dinosaurios.
    func sort (by alphabetical : Bool){
        //necesitamos 2 propiedades para poder comparar.
        apexPredators.sort{ predator1,predator2 in
            
            if alphabetical{
                predator1.name < predator2.name
            }else{
                predator1.id < predator2.id
            }
        }
    }
    
    //V-36, Paso 1.44
    func filter(by type:PredatorType){
        //Paso 63, ,sino se filtra nada ,no hagas nada pon todo los dinosarios.
        if type == .all{
            //Paso 67,ponemos esto , ver video
            apexPredators = allApexPredators
        }else {
            //Paso 1.47,ver el video
            //Paso 68, ponemos el allApexPredators
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
        
    }
}
