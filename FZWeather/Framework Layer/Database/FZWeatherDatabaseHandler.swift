//
//  FZWeatherDatabaseHandler.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import Foundation
import CoreData

protocol FZWeatherCoreDataHandlerProtocol: FZWeatherBaseDataHandlerProtocol
{
    func insertWeatherRecords(records: FZCityWeather) -> Bool
}

struct FZWeatherCoreDataHandler : FZWeatherCoreDataHandlerProtocol {
    
    func insertWeatherRecords(records: FZCityWeather) -> Bool {
        
        PersistenceController.shared.container.performBackgroundTask { privateManagedContext in
            //insert code
                let cityWeather = FZCDCityWeather(context: privateManagedContext)
                cityWeather.convertToCDCityWeather(cityWeather: records)
            
            if(privateManagedContext.hasChanges){
                try? privateManagedContext.save()
                debugPrint("AnimalDataRepository: Insert record operation is completed")
            }
        }
        
        return true
    }
    
    func getWeather(location: String, completion: @escaping (Result<FZCityWeather, FZWeatherError>) -> Void) {
                
        let fetchRequest = NSFetchRequest<FZCDCityWeather>(entityName: "FZCDCityWeather")
        let predicate = NSPredicate(format: "location==%@", location as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(fetchRequest).first

            guard let result = result else {
                completion(.failure(.error(NSLocalizedString("No weather data present.", comment: ""))))
                return
            }
            completion(.success(result.convertToCityWeather()))

        } catch let error {
            completion(.failure(.error(error.localizedDescription)))
        }        
    }
}
