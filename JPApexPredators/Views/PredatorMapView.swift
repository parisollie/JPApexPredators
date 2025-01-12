//
//  PredatorMapView.swift
//  JPApexPredators
//
//  Created by Paul F on 27/10/24.
//

//Vid 42
import SwiftUI
import MapKit

struct PredatorMapView: View {
    //Paso 86,trae todo los dinosaurios al mapa
    let predators = Predators()
    @State var position: MapCameraPosition
    //Paso 89
    @State var satellite = false
    var body: some View {
        //Paso 85
        Map(position: $position){
            //Paso 87,Hacemos un ForEach , para que recorra cada uno de los dinosaruios
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
        //Paso 88,sattellite is es true muestra la imagen sino muestra la estandar
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
        //Paso 89
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //Paso 86
    PredatorMapView(position: .camera(MapCamera(centerCoordinate:Predators().apexPredators[10].location,distance: 1000,heading: 250,pitch: 80)))
        .preferredColorScheme(.dark)
}
