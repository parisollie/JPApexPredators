//
//  PredatorMapView.swift
//  JPApexPredators
//
//  Created by Paul F on 27/10/24.
//

//V-42,Pso 3.0 creamos esta vista
import SwiftUI
import MapKit

struct PredatorMapView: View {
    //Paso 3.1, para que tengamos todos los dinosarios en el mapa
    let predators = Predators()
    //Paso 3.2,trae todo los dinosaurios al mapa
    @State var position: MapCameraPosition
    //Paso 3.3
    @State var satellite = false
    var body: some View {
        //Paso 3.4
        Map(position: $position){
            //Paso 3.5,Hacemos un ForEach , para que recorra cada uno de los dinosaruios
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
        //Paso 3.6,sattellite is es true muestra la imagen sino muestra la estandar
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
        //Paso 3.7
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //Paso 3.8
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
