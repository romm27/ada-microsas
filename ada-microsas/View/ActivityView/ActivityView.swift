import SwiftUI

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State var showCompletionAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Você tá\namassando!")
                .padding(.top, 84)
                .padding(.bottom, 40)
                .padding(.horizontal, 100)
                .multilineTextAlignment(.center)
        }
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .background(.roxo)
        .cornerRadius(20)
        .ignoresSafeArea(.all)
        
        Spacer()
        
        VStack{
            ProgressBarView()
                .frame(width: 300, height: 300)
                .padding(100)
                .alert("Parabéns!", isPresented: $timerViewModel.isFinished) {
                    Button("Ok") {
                        dismiss()
                    }
                } message: {
                    Text("Você concluiu a atividade!")
                }
        }
        
        Spacer()
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.dark)
            .onAppear{
                timerViewModel.setTimerConfig(seconds: DataTrainingModel.shared.trainingList[planViewModel.userLevel].seconds)
                timerViewModel.startTimer()
            }
    }
}

#Preview {
    ActivityView()
        .environmentObject(TimerViewModel())
        .environmentObject(PlanViewModel())
}
