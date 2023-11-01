import SwiftUI

struct Bubble: View {
    var text: String
    var left: Bool
    
    var body: some View {
        HStack {
            if(!left) {
                Spacer()
            }
            Text("\(text)")
                .foregroundColor(.white)
                .cornerRadius(5)
                .padding()
                .background(left ? .blue : .green)
            if(left) {
                Spacer()
            }
        }
    }
}

struct ContentView: View {
    @State var question: String = ""
    @State var bubbles: Array<String> = []
    @State var thinking: Bool = false
    
    var body: some View {
        VStack {
            Image("assistant")
            ForEach(Array(bubbles.enumerated()), id: \.offset) { index, bubble in
                Bubble(text: bubble, left: (index % 2 == 0))
            }
            
            if(thinking) {
                ProgressView().onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        thinking = false
                        bubbles.append("I don't know, Marc hasn't implemented this part yet.")
                    }
                }
            }
            Spacer()
            Text("How can I help you?")
            TextField(
                    "Hello, ...",
                    text: $question
            ).padding()
                .border(.gray)
                .padding()
            Button(action: submit) {
                Text("Send")
            }
        }
        .padding()
    }
    
    func submit() {
        bubbles.append(question)
        thinking = true
        question = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
