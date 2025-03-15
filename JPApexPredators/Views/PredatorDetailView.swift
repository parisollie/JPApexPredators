//
//  PredatorDetailView.swift
//  JPApexPredators
//
//  Created by Paul F on 27/10/24.
//

import SwiftUI
import MapKit

//V-38,Paso 2.0 creamos esta vista
struct PredatorDetailView: View {
    //Paso 2.3
    let predator : ApexPredator
    //Paso 2.28
    @State var position: MapCameraPosition
    //Paso 3.9,para animacion
    @Namespace var namespace
    
    
    var body: some View {
        //Paso 2.9,Ponemos el  GeometryReader,es para que se vea bien en todas las pantallas.
        GeometryReader{geo in
            //Paso 2.1, add el ScrollView
            ScrollView{
                //Paso 2.2,ponemos el Z
                //Paso 2.11, movemos la imágen del dinosaurio ->,(alignment:.bottomTrailing)
                ZStack(alignment:.bottomTrailing){
                    //Paso 2.6, Background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        //V-40,Paso 2.27 gradiente
                        .overlay{
                            LinearGradient(stops:[
                                //Podemos poner los gradient que queramos
                                Gradient.Stop(color: .clear, location:0.8),
                                Gradient.Stop(color: .black, location:1),
                            ],startPoint: .top,endPoint: .bottom)
                        }
                    
                    //Paso 2.8,Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        //Paso 2.10
                        .frame(width:geo.size.width/1.5,height: geo.size.height/3)
                        //para voltear la imagén en modo espejo.
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 7)
                        //Paso 2.12,lo movemos abajo de la isla dinámica.
                        .offset(y:20)
                        //El border es para guiarnos con los tamaños
                        //.border(.blue,width: 7)
                }
                /*
                 -- Para saber el tamaño de las pantallas
                Text("\(geo.size.width)")
                Text("\(geo.size.height)")*/
            
                //Paso 2.14,ponemos el Vstack para poder alinear el texto,(alignment:.leading)
                VStack(alignment:.leading){
                    //V-39,Paso 2.13,ponemos el nombre del dinosaurio
                    Text(predator.name)
                        .font(.largeTitle)
                    //V-41,Paso 2.38,ponemos el NavigationLink,Current location
                    NavigationLink{
                        //V-43,Paso 3.10
                        PredatorMapView(position:
                                .camera(MapCamera(centerCoordinate:predator.location,
                                         distance : 1000,
                                         heading: 250,
                                         pitch: 80
                                        )))
                        //Paso 3.11
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                        
                    }label:{
                        //Paso 2.35, agregamos (position: $position)
                        Map(position: $position){
                            //Paso 2.36, le ponemos un pin a la ubicacion.
                            Annotation(predator.name, coordinate: predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            //Paso 2.37, escondemos el nombre del dinosario en el pin.
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        //Paso 2.41 ,ponemos el overlays
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing,5)
                        }
                        //Paso 2.42,ponemos el overlays
                        .overlay(alignment: .topLeading){
                            Text("Current location")
                                .padding([.leading,.bottom],5)
                                .padding(.trailing,8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        //Paso 2.43 ,le ponemos sombra al current location FIN
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    //Paso 3.14,FIN
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    
                    //Paso 2.17,agregamos Appears in
                    Text("Appears in: ")
                        .font(.title3)
                        //Paso
                        .padding(.top)
                    //paso 2.18, agregamos un for each
                    //Paso 2.19, necesita un  identifiable así que ponemos,id: \.self)
                    ForEach(predator.movies,id: \.self){
                        movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    //Paso 2.20, Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.vertical,15)
                    //Paso 2.22,ponemos el for each
                    ForEach(predator.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical,1)
                        //Paso 2.23
                        Text(scene.sceneDescription)
                            .padding(.bottom,15)
                    }
                    
                    //Paso 2.24, Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    //Paso 2.25,ponemos el link y ponemos un (!), porque es un opcional para URL
                    Link(predator.link,destination: URL(string:predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                //Paso 2.16, agregamos padding
                .padding()
                //Paso 2.26,para que haya mas espacio en la parte de abajo del link
                .padding(.bottom)
                //Paso 2.15,lo alineamos todo a la izquierda
                .frame(width: geo.size.width,alignment: .leading)
                
            }
            //Paso 2.7
            .ignoresSafeArea()
        }
        //Paso 2.39, ponemos el toolbar
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //Paso 2.40, ponemos el NavigationStack
    NavigationStack{
        //Paso
        PredatorDetailView(
            //V-38,paso 2.5, creamos una instancia del predator,predator: Predators().apexPredators[2]
            //y queremos el dinosaurio 3
            predator: Predators().apexPredators[10],
            //V-41,Paso 2.29, le ponemos las posiciones del dinosario
            position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[10].location, distance: 30000))
        )
            .preferredColorScheme(.dark)
    }
}
