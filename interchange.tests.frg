#lang forge/froglet
open "interchange.frg"

option no_overflow true
// option run_sterling "segment_vis.js"
// option sb 100


test suite for segmentLength {
    example validLength is {segmentLength[1,8]} for {
        // Straight horizontal segment of length 5
        Segment = `S0
        #Int = 10
        Dx = 2
        Dy = 0
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 2
        `S0.y2 = 0
    } 

    example invalidLength is not {segmentLength[1,8]} for {
        // Diagonal segment with length sqrt(50)  (valid) but testing boundary
        Segment = `S0
        #Int = 10
        Dx = `D5
        Dy = `D5
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 5
        `S0.y2 = 5
    } 

    assert (all s: Segment | {
        #Int = 10
        let dx = subtract[s.x2, s.x1], dy = subtract[s.y2, s.y1] |
        add[multiply[dx,dx], multiply[dy,dy]] <= 100
    }) is necessary for segmentLength[1,8]
}

test suite for next_connected {
    example validChain is {next_connected} for {
        Segment = `S0 + `S1
        `S0.next = `S1
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 1
        `S0.y2 = 1
        `S1.x1 = 1
        `S1.y1 = 1
        `S1.x2 = 2
        `S1.y2 = 2
    }
    assert {no_self_connection  and (some s: Segment | some s.next)} is sufficient for next_connected
}

test suite for no_self_connection {
    example validCase is {no_self_connection} for {
        Segment = `S0
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 1
        `S0.y2 = 1
        no `S0.next
    }

    test expect {
        {some s: Segment | s.next = s} is unsat
    }
}
test suite for disj_endpoints {
    example validEndpoints is {disj_endpoints} for {
        Segment = `S0 + `S1
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 5
        `S0.y2 = 5
        `S1.x1 = 1
        `S1.y1 = 1
        `S1.x2 = 6
        `S1.y2 = 6
    }

    test expect {
        { all disj s1,s2: Segment | s1.x2 = s2.x2 and s1.y2 = s2.y2} is unsat
    }
}

test suite for curvature {
    test expect {
        // Should allow orthogonal segments (dot product 0)
        {curvature[1] and (some s: Segment | let dx1=1, dy1=0, dx2=0, dy2=1 |
            add[multiply[dx1,dx2], multiply[dy1,dy2]] = 0)} is sat
    }

    test expect {
        // Should forbid aligned segments (dot product 25)
        {curvature[1] and (some s: Segment | let dx1=5, dy1=0, dx2=5, dy2=0 |
            add[multiply[dx1,dx2], multiply[dy1,dy2]] = 25)} is unsat
    }
}

test suite for distance {
    test expect {
        {distance[200] and segmentLength[1,8]} is sat
    }

    test expect {
        {distance[50] and segmentLength[1,8]} is unsat
    }
}

test suite for hit_endpoint {
    example hitValid is {hit_endpoint[5,5]} for {
        Segment = `S0
         #Int = 10
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 5
        `S0.y2 = 5
    }

    assert hit_endpoint[5,5] is consistent with overall_start
}

test suite for fully_connected {
    example validChain2 is {fully_connected} for {
        Segment = `S0 + `S1 + `S2
        `S0.next = `S1
        `S1.next = `S2
        no `S2.next
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 1
        `S0.y2 = 1
        `S1.x1 = 1
        `S1.y1 = 1
        `S1.x2 = 2
        `S1.y2 = 2
        `S2.x1 = 2
        `S2.y1 = 2
        `S2.x2 = 3
        `S2.y2 = 3
    }

    // assert fully_connected implies (one s: Segment | no s.next)
}

test suite for overall_start {
    example validStart is {overall_start[0,0]} for {
        Segment = `S0
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 1
        `S0.y2 = 1
    }

    assert overall_start[0,0] is consistent with fully_connected
}

test suite for overall_end {
    example validEnd is {overall_end[15,15]} for {
        Segment = `S0
        `S0.x1 = 0
        `S0.y1 = 0
        `S0.x2 = 15
        `S0.y2 = 15
    }

    assert overall_end[15,15] is consistent with segmentLength
}