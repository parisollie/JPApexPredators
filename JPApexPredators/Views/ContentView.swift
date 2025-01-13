//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Paul F on 25/10/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    //V-33,Paso 8 , hacemos una instancia para acceder a nuestros datos.
    let predators = Predators()
    //Paso 26,para el search
    @State var searchText = ""
   
    //V-34,Paso 29 ,computer property, para buscar a los dinosauritos
    var filteredDinos: [ApexPredator]{
        //Paso 62
        predators.filter(by: currentSelection)
        //Paso 42
        predators.sort(by: alphabetical)
        //Paso 36,llama a la funcion que los busca
        return predators.search(for: searchText)
    }
    
    //Paso 41
    @State var alphabetical = false
    //Paso 53,variable para seleccionar el tipo de predator
    @State var currentSelection = PredatorType.all
    
    var body: some View {
        //V-34,paso 22 ,ponemos el  NavigationStack que es para navegar a otra página.
        NavigationStack {
            //Paso 9,ponemos la lista de pretadors.
            //List(predators.apexPredators){ predator in
            //Text(predator.name)
            ///Paso 30 le ponemos el (filteredDinos)
            //Vid 49, creamos nuestra lista
            List(filteredDinos){ predator in
                //Paso 24, pongo el NavigationLink que será esto (>)
                NavigationLink{
                    //Vid 38,paso 54
                    //Paso 56, le mandamos el predator:predator
                    //V-38,Paso 70, creamos el PredatorDeatilView
                    PredatorDetailView(
                        //Paso 74,ponemos el predator
                        predator:predator,
                        //Paso 103,le mandamos la direccion del dino
                        position:.camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                        /*Paso 25, Image(predator.image)
                        .resizable()
                        .scaledToFit()*/
                }label:{
                    //Paso 10,ponemos el HStack
                    HStack{
                        //Paso 13,ponemos la imágen del dinosaurio.
                        Image(predator.image)
                            //Le ponemos sus modifiers.
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .shadow(color:.white,radius: 1)
                        //Paso 11,ponemos el VStack,el (alignment: .leading), movera el texto a la izq
                        VStack(alignment: .leading){
                            //Paso 14,ponemos el nombre del dinosario
                            Text(predator.name)
                                .fontWeight(.bold)
                            //Paso 16,le ponemos el type del predator
                            //Paso 21,como ya no es tipon string y es tipo "PredatorType", ahora debemos poner rawValue.
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                //Paso 20,le ponemos el color de acuerdo al tipo de dinosaurio.
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }//Final Label y navigationLink
            //Paso 23, ponemos el navigationTitle
            .navigationTitle("Apex Predators")
            //Paso 27, para poner el buscador
            .searchable(text: $searchText)
            //Paso 28,para deshabilitarlo el autocorrector
            .autocorrectionDisabled()
            //Paso 33,ponemos la animación,cuando cambie el texto se irán moviendo.
            .animation(.default,value:searchText)
            //Paso 38 ponemos el toolbar
            .toolbar{
                //Paso 39, ponemos el ToolbarItem,botón para ordenar alfábeticamente
                ToolbarItem(placement:.topBarLeading){
                    //Paso 40, ponemos el boton
                    Button{
                        //Paso 45, le ponemos la animación.
                        withAnimation{
                            //Paso 43, cambiaremos el valor de false a true
                            alphabetical.toggle()
                        }
                    }label:{
                        /*if alphabetical{
                         Image(systemName: "film")
                         }else{
                         Image(systemName: "textformat")
                         }*/
                        //Forma ternaria:
                        //si alfphabetical es true pon film simbolo sino pon el simbolo de letras.
                        //Paso 44
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce,value: alphabetical)
                    }
                }
                //Paso 49, agregamos otro ToolbarItem
                ToolbarItem(placement: .topBarTrailing){
                    //Paso 50 ,ponemos un Menu
                    Menu{
                        //Paso 54,ponemos el Picker
                        Picker("Filter", selection:
                                //Paso 55, seleccionamos el dinosaurio por tipo.
                                //Paso 69,le ponemos la animación.
                                $currentSelection.animation()){
                            //Paso 56, hacemos un Foreach para seleccionarlos
                            ForEach(PredatorType.allCases){
                                //Paso 59, ponemos el type in
                                type in
                                //Paso 61
                                Label(type.rawValue.capitalized,systemImage: type.icon)
                            }
                        }
                    }label:{
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            //Paso 15,para poner el fondo negro.
            .preferredColorScheme(.dark)
        }
    }
        
}

#Preview {
    ContentView()
}
