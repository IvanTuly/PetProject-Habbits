//
//  ContentView.swift
//  Habbits
//
//  Created by mac on 07.05.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habbits = Habbits()
    
    //необходимо для отслеживания(показывается или нет) второй вью, где можно вводить привычки
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationView{
            List{
                //ForEach используется для того, чтобы можно было удалять через onDelete
                //необходим, чтобы идентифицировать каждую привычку и записать ее в List
                // уникальность значений определена в протоколе Identifiable, поэтому нам не надо id:
                ForEach(habbits.items) { item in
                    NavigationLink(destination: DetailView(habbits: self.habbits, selectedItem: item)){
                    //выводим данные привычек
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }//: VStack
                        Spacer()
                        Text("\(item.amount)")
                           // .foregroundColor(type == "Bad Habbit" ? .green : .red)
                        
                        
                        }//: HSTACK
                    }//: Navigation
                }
                
                //добавляет кнопку Edit, для возможности многократного удаления элементов списка, работает с ForEach
            .onDelete(perform: removeItems)
        }
        .navigationBarTitle("iHabbits")
        //leading EditButton добавляет кнопку Edit, позволяющую удалять сразу много чисел, работает только в navigationView
        //позволяет добавлять новый расход
        .navigationBarItems(leading: EditButton() ,trailing:
            
            //кнопка для открытия второй вью
            Button(action: {
                self.showingAddExpense = true
            }){
                Image(systemName: "plus")
            }
            )
            //открывает нашу вью для ввода расходов
                .sheet(isPresented: $showingAddExpense) {
                    // передает в вью созданный объект, теперь оба вью будут отслеживать его изменения
                    AddView(habbits: self.habbits)
                }
        }
    }
    
    //функция для удаления расхода
    func removeItems(at offsets:IndexSet){
        habbits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
