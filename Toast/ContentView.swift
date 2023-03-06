//
//  ContentView.swift
//  Toast
//
//  Created by Juan Camilo Marín Ochoa on 6/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var items = Array(repeating: "Item", count: 30)
    
    // Determina si mostrar o no la alerta
    @State private var isVisible = false
    
    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                Text(item)
            }
            .navigationBarTitle("Lista de items")
            // Inicio implementación de Toast
            .overlay(
                Group {
                    if isVisible {
                        ToastView(
                            title: "AirPods Pro",
                            message: "Conectados",
                            image: "airpodspro",
                            time: 1,
                            isVisible: $isVisible
                        )
                    }
                }
            )
            // Fin implementación de Toast
            .navigationBarItems(trailing: Button {
                isVisible = true
            } label: {
                Image(systemName: "airpodspro")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ToastView(
            title: "AirPods Pro",
            message: "Conectados",
            image: "exclamationmark.triangle.fill",
            time: 999,
            isVisible: .constant(true)
        )
    }
}
