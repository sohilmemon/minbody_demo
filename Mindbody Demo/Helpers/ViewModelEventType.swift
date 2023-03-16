//
//  ViewModelEventType.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import Foundation

//Types of Events where UI needs to be updated
enum ViewModelObservableEvent {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}
