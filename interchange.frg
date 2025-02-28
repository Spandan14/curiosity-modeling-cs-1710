#lang forge

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

sig Dx {
    dx: one Int
}

sig Dy {
    dy: one Int
}

pred segmentLength[minLength: Int, maxLength: Int] {
    all s: Segment | {
        one ddx : Dx | one ddy : Dy | {
            s.x2 = add[s.x1, ddx.dx]
            s.y2 = add[s.y1, ddy.dy]
            ddx.dx >= multiply[maxLength, -1]
            ddy.dy >= multiply[maxLength, -1]
            ddx.dx <= maxLength
            ddy.dy <= maxLength
            add[multiply[ddx.dx, ddx.dx], multiply[ddy.dy, ddy.dy]] <= multiply[maxLength, maxLength]
            add[multiply[ddx.dx, ddx.dx], multiply[ddy.dy, ddy.dy]] >= multiply[minLength, minLength]
        }
    }
}

pred next_connected {
    all s: Segment | some p: Segment | (s.next = p implies (p.x1 = s.x2 and p.y1 = s.y2))
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

pred curvature {
    // {sum s : Segment | sum[divide[multiply[10, subtract[s.y2, s.y1]], subtract[s.x2, s.x1]]]} = 0
    all s : Segment | {
        let dx1 = s.x1 - s.x2, dy1 = s.y1 - s.y2,
            dx2 = s.next.x2 - s.next.x1, dy2 = s.next.y2 - s.next.y1 | {
                add[multiply[dx1, dx2], multiply[dy1, dy2]] < 0
            }
    }
}

inst segmentBounds {
    Segment = `Segment0 + `Segment1 + `Segment2 + `Segment3 + `Segment4 + `Segment5 + `Segment6 + `Segment7 + `Segment8 + `Segment9

    Dx = `DxM5 + `DxM4 + `DxM3 + `DxM2 + `DxM1 + `Dx0 + `Dx1 + `Dx2 + `Dx3 + `Dx4 + `Dx5
    Dy = `DyM5 + `DyM4 + `DyM3 + `DyM2 + `DyM1 + `Dy0 + `Dy1 + `Dy2 + `Dy3 + `Dy4 + `Dy5

    `DxM5.dx = -5
    `DxM4.dx = -4
    `DxM3.dx = -3
    `DxM2.dx = -2
    `DxM1.dx = -1
    `Dx0.dx = 0
    `Dx1.dx = 1
    `Dx2.dx = 2
    `Dx3.dx = 3
    `Dx4.dx = 4
    `Dx5.dx = 5

    `DyM5.dy = -5
    `DyM4.dy = -4
    `DyM3.dy = -3
    `DyM2.dy = -2
    `DyM1.dy = -1
    `Dy0.dy = 0
    `Dy1.dy = 1
    `Dy2.dy = 2
    `Dy3.dy = 3 
    `Dy4.dy = 4
    `Dy5.dy = 5
    

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
    // curvature
    segmentLength[1, 5]
} for 10 Segment, 10 Int for {segmentBounds}
