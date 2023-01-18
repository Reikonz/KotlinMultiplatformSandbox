import SwiftUI
import shared

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel

	let greet = Greeting().greet()

	var body: some View {
		Text(viewModel.text)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var text = "Loading..."
            init() {
                Greeting().greeting { greeting, error in
                    DispatchQueue.main.async {
                        if let greeting = greeting {
                            self.text = greeting
                        } else {
                            self.text = error?.localizedDescription ?? "error"
                        }
                    }
                }
    }
}