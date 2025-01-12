//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Paul F on 25/10/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    //Vid 34,Paso 6 , hacemos una instancia
    let predators = Predators()
    //Paso 18
    @State var searchText = ""
    //Paso 28
    @State var alphabetical = false
    //Paso 42
    @State var currentSelection = PredatorType.all
    //Paso 21,computer property
    var filteredDinos: [ApexPredator]{
        //Paso 49
        predators.filter(by: currentSelection)
        //Paso 29
        predators.sort(by: alphabetical)
        //Paso 25,llama a la funcion que los busca 
        return predators.search(for: searchText)
    }
    
    var body: some View {
        //Vid 35,paso 15 ,ponemos el  NavigationStack
        NavigationStack {
            //Vid 34, Paso 7
            //List(predators.apexPredators){ predator in
            //Text(predator.name)
            //Vid 49, creamos nuestra lista
            List(filteredDinos){ predator in
                //Paso 17, pongo el NavigationLink que sera esto (>)
                NavigationLink{
                    //Vid 38,paso 54
                    //Paso 56, le mandamos el predator:predator
                    
                    PredatorDetailView(predator:predator,
                                       //Paso 76
                                       position:.camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                   /*Vid 35, Image(predator.image)
                        .resizable()
                        .scaledToFit()*/
                    
                }label:{
                    HStack{
                        //Paso 10,Dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .shadow(color:.white,radius: 1)
                        // (alignment: .leading), movera el texto a la izq
                        VStack(alignment: .leading){
                            //Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            //Paso 13,Type, como no string ahora debemos poner rawValue
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                //Paso 14
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            //Paso 16, ponemos el navigationTitle
            .navigationTitle("Apex Predators")
            //Paso 19, para poner el buscador
            .searchable(text: $searchText)
            //Paso 20,para deshabilitarlo el autocorrector
            .autocorrectionDisabled()
            //Paso 23,cuando cambie el texto se iran moviendo
            .animation(.default,value:searchText)
            //Vid 51
            .toolbar{
                //Vid 36,paso 27, botón para ordenar alfabeticamente
                ToolbarItem(placement:.topBarLeading){
                    Button{
                        //Paso 32, le ponemos la animacion
                        withAnimation{
                            //Paso 30, cambiaremos el valor de false a true
                            alphabetical.toggle()
                        }
                    }label:{
                        /*if alphabetical{
                         Image(systemName: "film")
                         }else{
                         Image(systemName: "textformat")
                         }*/
                        //Paso 31, Forma ternaria
                        //si alfphabetical es true pon film sino pon el de letras
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce,value: alphabetical)
                    }
                }
                //Paso 40
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        //Paso 43
                        Picker("Filter", selection:
                                $currentSelection.animation()){
                            ForEach(PredatorType.allCases){
                                //Paso 45, ponemos el type in 
                                type in
                                //Paso 48
                                Label(type.rawValue.capitalized,systemImage: type.icon)
                            }
                        }
                    }label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            //Paso 11,para poner el fondo negro
            .preferredColorScheme(.dark)
        }
    }
        
}

#Preview {
    ContentView()
}
