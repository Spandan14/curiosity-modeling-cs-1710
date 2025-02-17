#lang forge/froglet

// sig Point {
//     x: lone Int,
//     y: lone Int,
// }

sig Segment {
    x1: one Int,
    y1: one Int,
    x2: one Int,
    y2: one Int,
    prev: lone Segment,
    next: lone Segment
}

// Segment in {
//     s.x1 >= 0
//     s.y1 >= 0
//     s.x2 >= 0
//     s.y2 >= 0
//     s.x1 <= 10
//     s.y1 <= 10
//     s.x2 <= 10
//     s.y2 <= 10
// }

pred wellformed {
    some s : Segment | {}
    all s: Segment | {
        no s.next
        no s.prev
    }
}

pred segmentLength[minLength: Int, maxLength: Int] {
    all s: Segment | {
        one dx : Int | one dy : Int | {
            s.x2 = add[s.x1, dx]
            s.y2 = add[s.y1, dy]
            dx <= maxLength
            dx >= 0
            dy <= maxLength
            dy >= 0
            add[multiply[dx, dx], multiply[dy, dy]] <= multiply[maxLength, maxLength]
            add[multiply[dx, dx], multiply[dy, dy]] >= multiply[minLength, minLength]
        }
    }
}

run {
    wellformed
    segmentLength[0, 3]
} for 1 Segment, 10 Int