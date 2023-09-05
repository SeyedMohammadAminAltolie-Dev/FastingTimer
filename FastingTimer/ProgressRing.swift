//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Ashkan Amin on 4/25/22.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    
//    @State var progress = 0.0
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            // MARK: PlaceholderRing
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // MARK: Colore Ring
             Circle()
                .trim(from: 0.0, to: min(fastingManager.progress,1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3892687261, green: 0.5173650384, blue: 0.9921018481, alpha: 1)), Color(#colorLiteral(red: 0.9891201854, green: 0.4376027584, blue: 0.7068929672, alpha: 1)),Color(#colorLiteral(red: 0.5854845643, green: 0.8502452374, blue: 0.8849324584, alpha: 1)),Color(#colorLiteral(red: 0.3840469718, green: 0.5174902081, blue: 1, alpha: 1))]), center: .center),style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
            VStack(spacing: 30) {
                if fastingManager.fastingState == .notStarted {
                    // MARK: Upcoming fast
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }else{
                    // MARK: Elapsed Time
                    VStack(spacing: 5) {
                        Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime,style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    // MARK: Remaining Time
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining time (\((1 - fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        }else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                        
                        Text(fastingManager.endTime,style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
            }
        }
        .frame(width: 250, height: 250)
        .padding()
//        .onAppear {
//            fastingManager.progress = 1
//        }
        .onReceive(timer) { _ in
            fastingManager.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(FastingManager())
    }
}
