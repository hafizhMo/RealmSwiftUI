//
//  AppAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Foundation

protocol Assembler: MemberAssembler,
                    MainAssembler {}

class AppAssembler: Assembler {}
