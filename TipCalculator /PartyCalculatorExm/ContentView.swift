
import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 10.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalPerPersonWoTip: Double {
        let peopleCountWoTip = Double(numberOfPeople)
        
        let grandTotalWoTip = checkAmount
        let amountPerPersonWoTip = grandTotalWoTip / peopleCountWoTip
        
        return amountPerPersonWoTip
    }
    
    var body: some View {
        
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format:.currency(code: "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            }
        header: {
            Text("Enter your bill")
        }
            
            Section {
                
                TextField("Number of Guests", value: $numberOfPeople, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            }
        header: {
            Text("Enter number of guests")
        }
            
            Section {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.segmented)
            }
        header: {
            Text("How much tip do you want to leave?")
        }
            
            Section {
                Text(totalPerPerson, format:.currency(code: Locale.current.currencyCode ?? "USD"))
            }
        header: {
            Text("Your bill with tips")
        }
            
            Section {
                Text(totalPerPersonWoTip, format:.currency(code: Locale.current.currencyCode ?? "USD"))
            }
        header: {
            Text("Your bill without tips")
        }
            
        }
        
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
