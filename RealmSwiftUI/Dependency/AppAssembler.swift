//
//  AppAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Foundation

protocol Assembler: MainAssembler, AlbumAssembler, MemberAssembler {}

class AppAssembler: Assembler {}
