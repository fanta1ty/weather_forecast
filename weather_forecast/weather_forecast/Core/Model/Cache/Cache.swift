//
//  Cache.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit

final class Cache<Value: Codable> {
    private let accessKey = "cachedKey"
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    init(dateProvider: @escaping () -> Date = Date.init, entryLifetime: TimeInterval = 2 * 60) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }
    
    func insert(_ value: Value, forKey key: String) {
        var entries = entryAll()
        
        let expiredDate = dateProvider() + entryLifetime
        let entry = Entry(key: key, value: value)
        
        if let index = entries.find(with: { localEntry in
            return localEntry.key == key
        }) {
            entries[index] = entry
        } else {
            entries.append(entry)
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(entries) {
            let dict: [String: Any] = ["entries": encoded, "expiredDate": expiredDate]
            
            UserDefaults.standard.setValue(dict, forKey: accessKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func value(forKey key: String) -> Value? {
        guard let dict = UserDefaults.standard.dictionary(forKey: accessKey) else {
            return nil
        }
        
        guard let data = dict["entries"] as? Data else {
            return nil
        }
        
        guard let expiredDate = dict["expiredDate"] as? Date else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        guard let decodedEntries = try? decoder.decode([Entry].self, from: data) else {
            return nil
        }
        
        
        guard dateProvider() < expiredDate else {
            removeValue()
            return nil
        }
        
        if let index = decodedEntries.find(with: { localEntry in
            return localEntry.key == key
        }) {
            return decodedEntries[index].value
        } else {
            return nil
        }
    }
    
    func removeValue() {
        UserDefaults.standard.removeObject(forKey: accessKey)
        UserDefaults.standard.synchronize()
    }
}

private extension Cache {
    final private func entryAll() -> [Entry] {
        let entries = [Entry]()
        
        guard let dict = UserDefaults.standard.dictionary(forKey: accessKey) else {
            return entries
        }
        
        guard let data = dict["entries"] as? Data else {
            return entries
        }
        
        let decoder = JSONDecoder()
        
        guard let decodedEntries = try? decoder.decode([Entry].self, from: data) else {
            return entries
        }
        
        return decodedEntries
    }
}

private extension Cache {
    final class Entry: Decodable, Encodable {
        enum JSONKeys: String, CodingKey {
            case key, value
        }
        
        let key: String
        let value: Value
        
        init(key: String,value: Value) {
            self.key = key
            self.value = value
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: JSONKeys.self)
            
            try container.encodeIfPresent(key, forKey: .key)
            try container.encodeIfPresent(value, forKey: .value)
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: JSONKeys.self)
            
            key = try values.decode(String.self, forKey: .key)
            value = try values.decode(Value.self, forKey: .value)
        }
    }
}
