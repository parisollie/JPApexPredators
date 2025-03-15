//
//  MainView.swift
//  JPApexPredators
//
//  Created by Paul F on 14/03/25.
//

import SwiftUI
import MapKit

struct MainView: View {
    //V-33,Paso 1.7 , hacemos una instancia para acceder a nuestros datos.
    let predators = Predators()
    //Paso 1.26,para el searchbar
    @State var searchText = ""
   
    //V-34,Paso 1.29 ,computer property, para buscar a los dinosauritos
    var filteredDinos: [ApexPredator]{
        //Paso 1.62
        predators.filter(by: currentSelection)
        //Paso 1.41
        predators.sort(by: alphabetical)
        //Paso 1.35,llama a la funcion que los busca
        return predators.search(for: searchText)
    }
    
    //Paso 1.40,propiedad para saber si esta ordenado o no
    @State var alphabetical = false
    //Paso 1.53,variable para seleccionar el tipo de predator
    @State var currentSelection = PredatorType.all
    
    var body: some View {
        //V-34,paso 1.22 ,ponemos el  NavigationStack que es para navegar a otra página.
        NavigationStack {
            /*
              Paso 1.8,ponemos la lista de pretadors.
            //List(predators.apexPredators){ predator in
            //Text(predator.name)
            
             Paso 1.30 le ponemos el (filteredDinos)
            //Vid 49, creamos nuestra lista*/
            List(filteredDinos){ predator in
                //Paso 1.24, pongo el NavigationLink que será esto (>)
                NavigationLink{
                    /*
                      Paso 56?, le mandamos el predator:predator
                      V-38,Paso 1.69, mandamos a llamar PredatorDeatilView //FINAL PASOS
                     */
                    PredatorDetailView(
                        //Paso 2.4,ponemos el predator
                        predator:predator,
                        //Paso 2.30,le mandamos la direccion del dino
                        position:.camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                        /*
                          Paso 1.25, Image(predator.image)
                          .resizable()
                          .scaledToFit()
                        */
                }label:{
                    //Paso 1.10,ponemos el HStack
                    HStack{
                        //Paso 1.13,ponemos la imágen del dinosaurio.
                        Image(predator.image)
                            //Le ponemos sus modifiers.
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            //Pone una sombra de color blanca alrededor de la imágen
                            .shadow(color:.white,radius: 1)
                        //Paso 1.11,ponemos el VStack,el (alignment: .leading), movera el texto a la izq
                        VStack(alignment: .leading){
                            //Paso 1.14,ponemos el nombre del dinosario
                            Text(predator.name)
                                .fontWeight(.bold)
                            //Paso 1.16,le ponemos el type del predator
                            //Paso 1.21,como ya no es tipon string y es tipo "PredatorType", ahora debemos poner rawValue.
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal,13)
                                .padding(.vertical,5)
                                //Paso 1.20,le ponemos el color de acuerdo al tipo de dinosaurio.
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }//Final Label y navigationLink
            //Paso 1.23, ponemos el navigationTitle
            .navigationTitle("Apex Predators")
            //Paso 1.27, para poner el buscador
            .searchable(text: $searchText)
            //Paso 1.28,para deshabilitarlo el autocorrector
            .autocorrectionDisabled()
            //Paso 1.33,ponemos la animación,cuando cambie el texto se irán moviendo.
            .animation(.default,value:searchText)
            //Paso 1.37 ponemos el toolbar
            .toolbar{
                //Paso 1.38, ponemos el ToolbarItem,botón para ordenar alfábeticamente
                ToolbarItem(placement:.topBarLeading){
                    //Paso 1.39, ponemos el boton
                    Button{
                        //Paso 1.45, le ponemos la animación.
                        withAnimation{
                            //Paso 1.42, cambiaremos el valor de false a true
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
                        //Paso 1.43
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce,value: alphabetical)
                    }
                }
                //Paso 1.48, agregamos otro ToolbarItem
                ToolbarItem(placement: .topBarTrailing){
                    //Paso 1.49 ,ponemos un Menu
                    Menu{
                        //Paso 1.54,ponemos el Picker
                        Picker("Filter", selection:
                                //Paso 1.55, seleccionamos el dinosaurio por tipo.,con ($currentSelection)
                                //Paso 1.68,le ponemos la animación.
                                $currentSelection.animation()){
                            //Paso 1.56, hacemos un Foreach para seleccionarlos
                            ForEach(PredatorType.allCases){
                                //Paso 1.60, ponemos el type in
                                type in
                                //Paso 1.61
                                Label(type.rawValue.capitalized,systemImage: type.icon)
                            }
                        }
                    }label:{
                        //Paso 1.50
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            //Paso 1.15,para poner el fondo negro.
            .preferredColorScheme(.dark)
        }
    }
       
}

#Preview {
    MainView()
}
