//
//  AddView.swift
//  Habbits
//
//  Created by mac on 07.05.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import SwiftUI

struct AddView: View {
    //свойство для закрытия вью после добавления элемента
    @Environment(\.presentationMode) var presentationMode
    
    //подключаем наш класс с массивом
    @ObservedObject var habbits: Habbits
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false

    static let types = ["Bad Habbit", "Good Habbit"]
    
    @State var item = HabbitItem(name: "", type: "", amount: 1)
    
    
    var body: some View {
        NavigationView {
            Form {
                //выбираем имя
                TextField("Name", text: $name)
                //выбираем тип
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                //указываем цену
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new habbit")
                //Кнопка для сохранения новых данных
            .navigationBarItems(trailing:
            Button("Save"){
                if let actualAmount = Int(self.amount)
                {
                    self.item = HabbitItem(name: self.name, type: self.type, amount: actualAmount)
                    self.habbits.items.append(self.item)
                    //закрывает вью после нажания кнопки Save
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingAlert = true
                }
            }
            //Сообщение об ошибке, если в поле Amount введен неправильный тип данных
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Wrong type of amount"), dismissButton: .default(Text("OK!")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habbits: Habbits())
    }
}
