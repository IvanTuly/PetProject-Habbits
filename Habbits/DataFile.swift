//
//  DataFile.swift
//  DataFile
//
//  Created by mac on 04.09.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import SwiftUI

//структура, сохраняющая отдельную привычку
// Identifible - протокол для идентификации, требованием является наличие свойста с именем id
//Codable - для архивации данных в userDefaults
struct HabbitItem: Identifiable, Codable {
    let id = UUID() //уникальный номер для идентификации строки, при такой записи он генерируется самостоятельно
    let name: String
    let type: String
    var amount: Int
    
}

//класс для хранения массива элементов привычек
class Habbits: ObservableObject {
    @Published var items = [HabbitItem](){
        
        //didSet - при удалении или добавлении отслеживает изменения
        didSet {
            let encoder = JSONEncoder() //преобразует данные в JSON
            //записываем данные по ключу Items
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    //загружает данные из UserDefaults
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items")
        {
            let decoder = JSONDecoder() //преобразует данные из JSON
            //загружаем объеты в массив, если объетов нет, устанавливаем пустой массив
            if let decoded = try? decoder.decode([HabbitItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
