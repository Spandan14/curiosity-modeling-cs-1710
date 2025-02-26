#lang forge/froglet

// sig Point {
//     x: lone Int,
//     y: lone Int,
// }
option no_overflow true
option run_sterling "segment_vis.js"

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

inst segmentBounds {
    Segment = `Segment0 + `Segment1 + `Segment2 + `Segment3 + `Segment4 + `Segment5 + `Segment6 + `Segment7 + `Segment8 + `Segment9
    `Segment0.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment0.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment0.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment0.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment1.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment1.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment1.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment1.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment2.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment2.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment2.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment2.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment3.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment3.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment3.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment3.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment4.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment4.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment4.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment4.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment5.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment5.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment5.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment5.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment6.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment6.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment6.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment6.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment7.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment7.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment7.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment7.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment8.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment8.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment8.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment8.y2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment9.x1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment9.x2 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment9.y1 in (0+1+2+3+4+5+6+7+8+9+10)
    `Segment9.y2 in (0+1+2+3+4+5+6+7+8+9+10)
}

run {
    wellformed
    segmentLength[5, 5]
} for 10 Segment, 6 Int for {segmentBounds}
