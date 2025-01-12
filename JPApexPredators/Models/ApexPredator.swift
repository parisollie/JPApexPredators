//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Paul F on 25/10/24.
//

import Foundation
import SwiftUI
import MapKit

/*V-31
 Paso 1 copiamos la estructura del JSON: "jpapexpredators"
 ponemos Decodable para que transforme la información del JSON.
 Paso 8, le ponemos el Identifiable. */
struct ApexPredator: Decodable, Identifiable {
    
    let id : Int
    let name : String
    let type : PredatorType
    let latitude : Double
    let longitude : Double
    //movies, es una colección de strings.
    let movies : [String]
    //movieScenes,es una colección de diccionarios.
    let movieScenes: [MovieScene]
    let link : String
    
    //Vid 34,Paso 9, para poder leer el nombre de las imágenes.
    var image : String{
        //compuer propertys
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    //Vid 41, Paso 73 maps.
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /*
     Paso 2, creamos las propiedades de MovieScene,también debe ser Decodable para que no marque error.
     Paso 67, ponemos el Identifiable*/
    struct MovieScene:Decodable, Identifiable {
        
        let id : Int
        let movie: String
        let sceneDescription: String
    }
}

/*Paso 11, hacemos esto para poder poner el color de cada tipo del dinosaruio en letras
le ponemos string para que no cause problema y porque así viene en el JSON y tambien debe ser decodable
Paso 38, quitamos el PredatorType fuera
Paso 44, agregamos CaseIterable, para agregar todos los casos
Paso 46 , pon Identifiable*/
enum PredatorType: String, Decodable,CaseIterable,Identifiable{
    //Paso 41, pongo el all
    case all
    case land
    case air
    case sea
    
    //Paso 47
    var id : PredatorType{
        self
    }
    //Paso 12, creamos el computer property.
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
    //Paso 41
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
