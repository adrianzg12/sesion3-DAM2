//
//  ContentView01.swift
//  Sesion03
//
//  Created by DAMII on 19/11/24.
//

import SwiftUI

struct ContentView01 : View {
    
    @AppStorage("nombreDeUsuario") private var nombre: String = ""
    
    var body: some View {
        VStack {
            TextField("Ingresa tu nombre", text: $nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("Hola, \(nombre)")
                .font(.title)
        }
    }
}

struct ContentView01_Previews: PreviewProvider {
    static var previews: some View {
        ContentView01()
    }
}
