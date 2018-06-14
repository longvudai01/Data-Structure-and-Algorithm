//
//  main.swift
//  Bai2_thayHiep Sap xep cuoc hop
/*  sinh ngau nhien n cuoc hop voi thoi diem bat dau va ket thuc. (tong thoi gian < 2 hours)
    cac cuoc hop trong cung 1 phong phai cach nhau >=15 min.
    cac cuoc hop trong cung 1 ngay.
    require : dua ra Cach xep phong voi so phong nho nhat.
*/
//  Created by Dai Long on 2/4/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

// sinh conference
func createTimeofconference (sizeofArray: Int) {
    let count = 0
    let A: UInt32 = 360 // UInt32 = 32-bit positive integers (unsigned)
    let B: UInt32 = 720
    var Conference:Array<(start: Int,end: Int)>
    Conference = []
    for _ in count..<sizeofArray {
        let startTime = Int(arc4random_uniform(B - A + 1) + A)
        let endTime = startTime + Int(arc4random_uniform(120) + 15)
        Conference.append((startTime,endTime))
    }
    Conference.sort(by: {$0.start < $1.start})
    sortRoom(&Conference, sizeofArray)
}

// Xep phong
func sortRoom (_ Conference: inout Array<(start: Int,end: Int)>, _ n:Int){
    var otherRoom:Array<(start: Int,end: Int)>
    otherRoom = []
    if (n == 0) {}
    else if (n == 1) {
        print("Last Room: \((Conference[0].start)/60)h \((Conference[0].start)%60), end: \((Conference[0].end)/60)h\((Conference[0].end)%60)")
    }
    else {
    for index in Conference.indices {
        let i = index + 1
        if (i == n) {
            break
        }
        
        for id in i..<n {
            if Conference[id].start == -1 { //neu duyet toi phan tu = -1 thi thoat
                break
            }
            if (Conference[id].start - Conference[index].end < 15) {
                otherRoom.append(Conference[id])
                //Conference.remove(at: i+1)
                Conference[id] = (-1,-1)
            }
        }
    }
        
        print("\nRoom:")
    for (s,e) in Conference {
        if (s == -1) {
            continue
        }
        else {
            let tS = (s/60, s%60)
            let tE = (e/60, e%60)
            print("(start: \(tS.0)h\(tS.1), end: \(tE.0)h\(tE.1))")}
    }
    sortRoom(&otherRoom, otherRoom.count)
}
}
//
let A: UInt32 = 15 // UInt32 = 32-bit positive integers (unsigned)
let B: UInt32 = 20
let number = Int(arc4random_uniform(B - A + 1) + A)
// Driver program
//var Conference:Array<(start: Int,end: Int)>
//Conference = [(480,510),(435,480),(360,390),(420,465)]
//sortConference(&Conference, indexof_Conference)

createTimeofconference(sizeofArray: number)

