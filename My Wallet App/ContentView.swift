//
//  ContentView.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [WalletItem]
    @State private var isAddingItem = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp)")
                    } label: {
                        WalletItemView(walletData: item)
//                        Text(item.timestamp)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }.sheet(isPresented: $isAddingItem) {
                        AddWalletItemView(isPresented: $isAddingItem)
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation{
            isAddingItem = true
        }
        
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

struct AddWalletItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var usageType: String = ""
    @State private var usageDescription: String = ""
    @State private var amount: Double = 0.0
    @State private var personData: String = ""
    @State private var currency: String = "$"
    @State private var selectedCurrency: String = "Select an Option for currency"
    @State private var selectedUsageType: String = "Select an Option for usage type"
    @State private var showAlert = false
    

    var body: some View {
        NavigationView {
            Form {
//                Section(header: Text("Details")) {
                    
                    Menu {
                        Button("Dollar", action: { selectedCurrency = CurrencyList.dollar.rawValue })
                          Button("INR", action: { selectedCurrency = CurrencyList.inr.rawValue })
                        } label: {
                          Label(selectedCurrency, systemImage: "chevron.down")
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                        }
            
                    TextField("Amt", value: $amount, format: .currency(code: selectedCurrency == CurrencyList.dollar.rawValue ? "USD" : "INR"))
                        .keyboardType(.decimalPad)
                    
                    Menu {
                        Button("Credit", action: { selectedUsageType = UsageType.credit.rawValue })
                        Button("Debit", action: { selectedUsageType = UsageType.debit.rawValue })
                        Button("Lend", action: { selectedUsageType = UsageType.lend.rawValue })
                        Button("Borrow", action: { selectedUsageType = UsageType.borrowed.rawValue })
                    } label: {
                        Label(selectedUsageType, systemImage: "chevron.down")
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                        }
                
                    TextField("Usage Description", text: $usageDescription)
                    
                    if selectedUsageType == UsageType.borrowed.rawValue{
                        TextField("From person name", text: $personData)
                    }else if selectedUsageType == UsageType.lend.rawValue{
                        TextField("To person name", text: $personData)
                    }
                    
//                }
            }
            .navigationTitle("Add Wallet Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if isValid(){
                            addItem()
                            isPresented = false
                        }else{
                            showAlert = true
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }.alert("Incomplete Data", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please fill in all fields before saving.")
            }
        }
    }
    
    private func isValid()-> Bool{
        if selectedCurrency == "Select an Option for currency"{
            return false
        } else if amount == 0.00 && amount < 0{
            return  false
        }else if selectedUsageType == "Select an Option for usage type"{
            return false
        }else if usageDescription.isEmpty{
            return false
        }else if personData.isEmpty && (selectedUsageType.lowercased() == UsageType.lend.rawValue || selectedUsageType.lowercased() == UsageType.borrowed.rawValue){
            return false
        }else {
            return true
        }
    }

    private func addItem() {
        let newItem = WalletItem(
            timestamp: Date().dateToString(),
            usageType: selectedUsageType,
            usageDescription: usageDescription,
            amount: amount,
            personData: personData,
            currency: selectedCurrency
        )
        withAnimation {
            modelContext.insert(newItem)
            try? modelContext.save() // Save the context
        }
    }
}

enum CurrencyList:String,CodingKey{
    case dollar = "$"
    case inr = "₹"
}

#Preview {
    ContentView()
        .modelContainer(for: WalletItem.self, inMemory: true)
}
