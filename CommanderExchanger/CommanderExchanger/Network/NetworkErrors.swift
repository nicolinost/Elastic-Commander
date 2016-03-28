//
//  NetworkErrors.swift
//  CommanderExchanger
//
//  Created by Nicolas Sterchele on 27/03/16.
//  Copyright © 2016 ScienceHome. All rights reserved.
//

import Foundation


enum NetworkError : ErrorType {
    case WrongUrl;
    case NoDatasReceived;
}