//
//  DetailView.swift
//  DetailView
//
//  Created by mac on 04.09.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var habbits: Habbits
    
    //текущая привычка
    @State var selectedItem: HabbitItem

    var body: some View {
        Form {
            Section(header: Text("Habbit Name")){
                Text("\(selectedItem.name)")
            }
            
            Section(header: Text("It's a")){
                Text("\(selectedItem.type)!")
            }
            
            Section(header: Text("Complited times:")){
                HStack{
                Text("\(selectedItem.amount)")
                Spacer()
                
                    //при добавление и убавлении, вызывается функция для сохранения данных
                Stepper("Logged", onIncrement: {
                    self.selectedItem.amount += 1
                    self.saveHabit()
                }, onDecrement: {
                    self.selectedItem.amount -= 1
                    self.saveHabit()
                })
                .labelsHidden()
                }
            }
        }//: FORM
    }
    
    //функция для сохранения обновленных данных
    func saveHabit() {
        //получаем индекс привычке в массиве всех привычек
        guard let index = habbits.items.firstIndex(where: {$0.id == selectedItem.id }) else { return }
        //по индексу обновляем данные
        habbits.items[index].amount = selectedItem.amount
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habbits: Habbits(), selectedItem: HabbitItem(name: "Name", type: "Type", amount: 0))
    }
}
