#lang forge/froglet

option no_overflow true
option run_sterling "segment_vis.js"

sig Segment {
    x1: one Int,
    y1: one Int,
    x2: one Int,
    y2: one Int,
    // prev: one Segment,
    next: one Segment
}

pred wellformed {
    // some s : Segment | {}
    // all s: Segment | {
    //     one s.next
    //     some s.prev
    // }
}

pred segmentLength[minLength: Int, maxLength: Int] {
    all s: Segment | {
        one dx : Int | one dy : Int | {
            s.x2 = add[s.x1, dx]
            s.y2 = add[s.y1, dy]
            dx >= multiply[minLength, -1]
            dy >= multiply[minLength, -1]
            dx <= maxLength
            dy <= maxLength
            add[multiply[dx, dx], multiply[dy, dy]] <= multiply[maxLength, maxLength]
            add[multiply[dx, dx], multiply[dy, dy]] >= multiply[minLength, minLength]
        }
    }
}

pred next_connected {
    all s, p: Segment | s.next = p implies {
        p.x1 = s.x2
        p.y1 = s.y2
    }
}

pred no_self_connection {
    no s: Segment | {
        s.next = s
        // s.prev != s
    }
}

pred disj_endpoints {
    all disj p, q : Segment | {
        p.x2 != q.x2
        p.y2 != q.y2
    }
}

inst segmentBounds {
    Segment = `Segment0 + `Segment1 + `Segment2 + `Segment3 + `Segment4 + `Segment5 + `Segment6 + `Segment7 + `Segment8 + `Segment9

    `Segment0.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment0.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment0.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment0.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment1.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment1.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment1.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment1.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment2.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment2.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment2.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment2.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment3.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment3.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment3.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment3.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment4.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment4.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment4.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment4.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment5.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment5.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment5.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment5.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment6.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment6.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment6.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment6.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment7.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment7.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment7.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment7.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment8.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment8.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment8.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment8.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment9.x1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment9.x2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment9.y1 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)
    `Segment9.y2 in (0+1+2+3+4+5+6+7+8+9+10+11+12+13+14+15)

    `Segment0.next = `Segment1
    `Segment1.next = `Segment2
    `Segment2.next = `Segment3
    `Segment3.next = `Segment4
    `Segment4.next = `Segment5
    `Segment5.next = `Segment6
    `Segment6.next = `Segment7
    `Segment7.next = `Segment8
    `Segment8.next = `Segment9
    `Segment9.next = `Segment0
}

run {
    // wellformed
    // prev_connected
    next_connected
    no_self_connection
    disj_endpoints
    segmentLength[5, 5]
} for 10 Segment, 6 Int for {segmentBounds}
