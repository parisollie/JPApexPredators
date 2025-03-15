//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Paul F on 25/10/24.
//

import Foundation
import SwiftUI
import MapKit

/*
  V-31
  Paso 1.0 copiamos la estructura del JSON: "jpapexpredators"
  ponemos Decodable para que transforme la información del JSON.
 
  V-33,Paso 1.9, le ponemos el Identifiable para que no nos marque error en el ContentView.
 */
struct ApexPredator: Decodable, Identifiable {
    
    let id : Int
    let name : String
    //Paso 1.19, cambiamos el valor a "PredatorType"
    let type : PredatorType
    let latitude : Double
    let longitude : Double
    //movies, es una colección de strings.
    let movies : [String]
    //movieScenes,es una colección de diccionarios.
    let movieScenes: [MovieScene]
    let link : String
    
    //V-33,Paso 1.12, para poder leer el nombre de las imágenes.
    var image : String{
        //compuer propertys, no tiene espacios y son minúsculas.
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    //V-41, Paso 2.98,configuracion para maps.
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /*
       Paso 1.1, creamos las propiedades de MovieScene,también debe ser Decodable para que no marque error.
       Paso 2.21, ponemos el Identifiable
    */
    struct MovieScene:Decodable, Identifiable {
        
        let id : Int
        let movie: String
        let sceneDescription: String
    }
}

/*
  Paso 1.17,creamos el "PredatorType" hacemos esto para poder poner el
  color de cada tipo del dinosaurio en letras le ponemos "string" para que
  no cause problema y porque así viene en el JSON y tambien debe ser decodable.
 
   Paso 1.46, quitamos el PredatorType fuera ,para que pueda ser utilizado por "Predators"
   Paso 1.57, agregamos CaseIterable, para agregar todos los casos
   Paso 1.58 , ponemos Identifiable para que no marque error.
*/
enum PredatorType: String, Decodable,CaseIterable,Identifiable{
    
    //Paso 1.51, pongo el all
    case all
    case land
    case air
    case sea
    
    //Paso 1.59
    var id : PredatorType{
        self
    }
    //Paso 1.18, creamos el computer property.
    var background:Color{
        
        switch self{
            
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        case .all:
                .black
        }
    }
    
    //Paso 1.52, creamos los icónos
    var icon: String {
        
        switch self{
    
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
