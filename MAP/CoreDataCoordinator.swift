//
//  CoreDataCoordinator.swift
//  MAP
//
//  Created by Dmitry Kulakoff on 15.10.15.
//  Copyright © 2015 Dmitriy Kulakov. All rights reserved.
//
import UIKit
import CoreData
import MagicalRecord

class CoreDataCoordinator: NSObject {
    static let sharedInstance = CoreDataCoordinator()
    let defaultContext = NSManagedObjectContext.MR_defaultContext()
    var companiesData = [["id" : 001, "name" : "Apple", "address" : "Moscow 1","longitude" : 37.617414,"latitude" : 55.756051],["id" : 002, "name" : "Microsoft", "address" : "Moscow 2","longitude" : 37.617895,"latitude" : 55.755903],["id" : 003, "name" : "Google", "address" : "Moscow 3","longitude" : 37.617311,"latitude" : 55.755498],["id" : 004, "name" : "Facebook", "address" : "Moscow 4","longitude" : 37.617633,"latitude" : 55.755786]]

    func createCompanies(){
        for var i = 0; i < companiesData.count; i++ {
          let company  = Company.MR_createEntity()
            company.id = companiesData[i]["id"] as? NSNumber
            company.name = companiesData[i]["name"] as? String
            company.address = companiesData[i]["address"] as? String
            company.longitude = companiesData[i]["longitude"] as? NSNumber
            company.latitude = companiesData[i]["latitude"] as? NSNumber

            defaultContext.MR_saveToPersistentStoreAndWait()

        }
    }
    
    func allCompanies() -> NSArray{
        let companies = Company.MR_findAll() as NSArray
         //print(companies.firstObject?.latitude)
        return companies
    }
}
