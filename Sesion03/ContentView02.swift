//
//  ContentView02.swift
//  Sesion03
//
//  Created by DAMII on 19/11/24.
//

import SwiftUI

struct Persona : Codable, Identifiable {
    let id: UUID
    let nombre: String
    
    init (id: UUID = UUID(), nombre: String) {
        self.id = id
        self.nombre = nombre
    }
}

struct ContentView02 : View {
    
    @State private var listaPersonas: [Persona] = [] // Array Personas
    
    var body: some View {
        VStack {
            List(listaPersonas) { item in
                Text(item.nombre)
            }
            Button("Agregar persona") {
                let newPosition = listaPersonas.count + 1
                let nuevaPersona = Persona(nombre: "Persona #\(newPosition)")
                listaPersonas.append(nuevaPersona)
                guardarDatos()
            }
        }.onAppear{
            cargarDatos()
        }
    }
    private func archivoURL() -> URL {
        let documentos = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return documentos.appendingPathExtension("personas.json")
    }
    
    private func guardarDatos() {
        do {
            let datos = try JSONEncoder().encode(listaPersonas) // datos -> texto plano
            try datos.write(to: archivoURL())
        } catch {
            print("error al guardar: \(error)")
        }
    }
    
    private func cargarDatos() {
        do {
            let datos = try Data(contentsOf: archivoURL()) // datos -> texto plano
            listaPersonas = try JSONDecoder().decode([Persona].self, from: datos)
        } catch {
            print("error al cargar: \(error)")
        }
    }
}

// Array Persona -> Texto plano
// Texto plano -> Array Persona

struct ContentView02_Previews: PreviewProvider {
    static var previews: some View {
        ContentView02()
    }
}
