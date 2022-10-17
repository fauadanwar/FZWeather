//
//  FZWeatherDatabaseHandler.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation

protocol FZWeatherDatabaseHandlerProtocol {
    func addItem() -> String?
    func deleteItems(offsets: IndexSet) -> Bool
}

class FZWeatherDatabaseHandler
{
//    private var viewContext = PersistenceController.preview.container.viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    var items: FetchedResults<Item>
//    
//    private let itemFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .medium
//        return formatter
//    }()
//    
//    func addItem() -> String? {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//            do {
//                try viewContext.save()
//                return  itemFormatter.string(from: newItem.timestamp!)
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    func deleteItems(offsets: IndexSet) -> Bool {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//            do {
//                try viewContext.save()
//                return true
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}
