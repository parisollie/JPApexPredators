//
//  PredatorMapView.swift
//  JPApexPredators
//
//  Created by Paul F on 27/10/24.
//

//V-42, creamos esta vista
import SwiftUI
import MapKit

struct PredatorMapView: View {
    //Paso 113, para que tengamos todos los dinosarios en el mapa
    let predators = Predators()
    //Paso 114,trae todo los dinosaurios al mapa
    @State var position: MapCameraPosition
    //Paso 115
    @State var satellite = false
    var body: some View {
        //Paso 116
        Map(position: $position){
            //Paso 117,Hacemos un ForEach , para que recorra cada uno de los dinosaruios
            ForEach(predators.apexPredators){
                predator in Annotation (predator.name, coordinate: predator.location){
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color:.white,radius: 3)
                        .scaleEffect(x:-1)
                }
            }
        }
        //Paso 118,sattellite is es true muestra la imagen sino muestra la estandar
        .mapStyle(satellite ? .imagery(elevation: .realistic)
                  : .standard(elevation:.realistic))
        .overlay(alignment:.bottomTrailing){
            Button{
                satellite.toggle()
            }label:{
                Image(systemName: satellite ?
                      "globe.americas.fill" : "globe.americas")
                .font(.largeTitle)
                .imageScale(.large)
                .padding(3)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 7))
                .shadow(radius: 3)
                .padding()
            }
        }
        //Paso 119
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //Paso 120
    PredatorMapView(
        position: .camera(MapCamera(
                centerCoordinate:
                    Predators().apexPredators[10].location,
                distance: 1000,
                heading: 250,
                pitch: 80))
    )
        .preferredColorScheme(.dark)
}
