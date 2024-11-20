//  ContentView04.swift
//  Sesion03
//
//  Created by DAMII on 19/11/24.
//

import SwiftUI

struct Usuario: Identifiable {
    let id = UUID()
    let nombre: String
    let email: String
}

class ModelUsuarios: ObservableObject {
    @Published var listaUsuarios: [Usuario] = [Usuario(nombre: "Adrian", email: "adrian@gmail.com")]
}

struct ContentView04  : View {
    @ObservedObject var modeloGlobal = ModelUsuarios()
    
    var body: some View {
        NavigationView {
            ListaUsuarios(modelo: modeloGlobal)
        }
    }
}

struct ListaUsuarios: View {
    @ObservedObject var modelo: ModelUsuarios  // Usar el modelo que se pasa como parámetro
    @State private var mostrarSheet = false
    
    var body: some View {
        VStack {
            List(modelo.listaUsuarios) { item in
                VStack {
                    Text(item.nombre).font(.headline)
                    Text(item.email).font(.subheadline).foregroundColor(.gray)
                }
            }
            .navigationTitle("Usuarios")
            .toolbar {
                Button(action: {
                    mostrarSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $mostrarSheet) {
                RegistroUsuario(modelo: modelo, mostrarSheet: $mostrarSheet)  // Pasar el modelo correctamente
            }
        }
    }
}

struct RegistroUsuario: View {
    @ObservedObject var modelo: ModelUsuarios  // Usar el modelo que se pasa como parámetro
    @Binding var mostrarSheet: Bool
    
    @State private var nombre: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre", text: $nombre)
                TextField("Email", text: $email)
                
                Button("Guardar") {
                    let nuevo = Usuario(nombre: nombre, email: email)
                    modelo.listaUsuarios.append(nuevo)
                    mostrarSheet = false
                }
            }
            .navigationTitle("Registro de Usuario")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        mostrarSheet = false
                    }
                }
            }
        }
    }
}

