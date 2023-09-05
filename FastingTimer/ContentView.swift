//
//  ContentView.swift
//  FastingTimer
//
//  Created by Ashkan Amin on 4/25/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManager = FastingManager()
    
    var title : String {
        switch fastingManager.fastingState {
            
        case .notStarted:
            return "Lets's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            Color(#colorLiteral(red: 0.050241400328, green: 0.006751002744, blue: 0.08163713664, alpha: 1))
                .ignoresSafeArea()
            content
            
        }
    }
    var content: some View {
        ZStack {
            VStack(spacing: 40) {
                // MARK: title
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.3892687261, green: 0.5173650384, blue: 0.9921018481, alpha: 1)))
                // MARK: Fasting plan
                
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal,24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                Spacer()
            }
            .padding()
            VStack(spacing: 40) {
                // MARK: Progress Ring
                
                ProgressRing()
                    .environmentObject(fastingManager)
                
                HStack(spacing: 60){
                    //MARK: start time
                    
                    VStack(spacing:5){
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    //MARK: End time
                    
                    VStack(spacing:5){
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                // MARK: Button
                
                Button {
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fast": "start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal,24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
                
            }
            .padding()
            
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
