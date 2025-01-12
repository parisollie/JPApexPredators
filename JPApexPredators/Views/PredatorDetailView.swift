//
//  PredatorDetailView.swift
//  JPApexPredators
//
//  Created by Paul F on 27/10/24.
//

import SwiftUI
import MapKit

//Vid 53
struct PredatorDetailView: View {
    //Paso 55
    let predator : ApexPredator
    //Paso 75
    @State var position: MapCameraPosition
    
    var body: some View {
        //Paso 58,Es para que se vea bien en todas las pantallas el Geometry
        GeometryReader{geo in
            //paso 54, add el ScrollView
            ScrollView{
                //Paso 60, movemos la imágen del dinosaurio,(alignment:.bottomTrailing)
                ZStack(alignment:.bottomTrailing){
                    //Paso 56, Background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        //Vid 40,paso 72 gradiente
                        .overlay{
                            LinearGradient(stops:[
                                Gradient.Stop(color: .clear, location:0.8),
                                Gradient.Stop(color: .black, location:1),
                            ],startPoint: .top,endPoint: .bottom)
                        }
                    
                    //Paso 57,Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        //Paso 59
                        .frame(width:geo.size.width/1.5,height: geo.size.height/3)
                        //para voltear la imagen en modo espejo
                        .scaleEffect(x:-1)
                        .shadow(color: .black, radius: 7)
                        //Paso 61, lo movemos abajo de la isla
                        .offset(y:20)
                        //El border es para guiarnos con los tamaños
                        //.border(.blue,width: 7)
                }
                //Para saber el tamaño de las pantallas
                //Text("\(geo.size.width)")
                //Text("\(geo.size.height)")
            
                //Paso 63,(alignment:.leading)
                VStack(alignment:.leading){
                    //Vid 39,Dino Name,paso 62
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    //Paso 81, el  NavigationLink,Current location
                    NavigationLink{
                        //Vid 42, paso 90
                        PredatorMapView(position:
                                .camera(MapCamera(centerCoordinate:predator.location,
                                         distance : 1000,
                                         heading: 250,
                                         pitch: 80
                                        )))
                    }label:{
                        //Paso 74
                        //Paso 77, agregamos (position: $position)
                        Map(position: $position){
                            //Paso 79
                            Annotation(predator.name, coordinate: predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            //Paso 80
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        //Paso 82
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing,5)
                        }
                        //Paso 83
                        .overlay(alignment: .topLeading){
                            Text("Current location")
                                .padding([.leading,.bottom],5)
                                .padding(.trailing,8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        //Paso 84
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    //Paso 65, Appears in
                    Text("Appears in: ")
                        .font(.title3)
                        //Paso 78
                        .padding(.top)
                    //paso 66
                    ForEach(predator.movies,id: \.self){
                        movie in
                        Text("•" + movie).font(.subheadline)
                    }
                    
                    //Paso 68, Movie moments
                    
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.vertical,15)
                    //Paso 69
                    ForEach(predator.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical,1)
                        Text(scene.sceneDescription)
                            .padding(.bottom,15)
                    }
                    
                    //Paso 70, Link to webpage
                    
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link,destination: URL(string:predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                        
                    
                
                }
                .padding()
                //Paso 71,para que haya mas espacio en la parte de abajo del link 
                .padding(.bottom)
                //Paso 64
                .frame(width: geo.size.width,alignment: .leading)
                
            }
            .ignoresSafeArea()
        }
        //paso 82
        .toolbarBackground(.automatic)
    }
}

#Preview {
    //Paso 82, navigation
    NavigationStack{
        //Paso 56
        //Vid 41 ,paso 77
        PredatorDetailView(predator: Predators().apexPredators[2], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
