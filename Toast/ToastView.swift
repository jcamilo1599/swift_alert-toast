//
//  ToastView.swift
//  Toast
//
//  Created by Juan Camilo Marín Ochoa on 6/03/23.
//

import SwiftUI

struct ToastView: View {
    let title: String
    let message: String
    let image: String?
    let time: Double
    
    // Viene desde donde se consume la vista y determina si Toast es visible
    @Binding var isVisible: Bool
    
    // Determina si se puede mostrar Toast y acciona la animación
    @State private var showToast = false
    
    // Duración de la animación
    private let animationDuration = 0.3
    
    init(title: String, message: String, image: String? = nil, time: Double = 3, isVisible: Binding<Bool>) {
        self.title = title
        self.message = message
        self.image = image
        self.time = time
        self._isVisible = isVisible
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 16) {
                if image != nil {
                    Image(systemName: image!)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(message)
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
            .shadow(radius: 10)
            .animation(.easeInOut(duration: animationDuration), value: showToast)
            .offset(y: showToast ? 0 : 200)
        }
        .padding(.horizontal)
        .onAppear(perform: animateViews)
    }
    
    private func animateViews(){
        if !showToast && isVisible {
            showToast = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                withAnimation {
                    showToast = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    isVisible = false
                }
            }
        }
    }
    
}
