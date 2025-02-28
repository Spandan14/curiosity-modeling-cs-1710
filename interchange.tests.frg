#lang forge/froglet

open "interchange.frg"

test suite for wellformed {
    // Test that a single segment is well-formed
    example singleSegment is {wellformed} for {
        Segment = `Segment0
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment0.next = `Segment0
    }

    // Test that multiple segments are well-formed
    example multipleSegments is {wellformed} for {
        Segment = `Segment0 + `Segment1
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment0.next = `Segment1
        `Segment1.x1 = 1
        `Segment1.y1 = 1
        `Segment1.x2 = 2
        `Segment1.y2 = 2
        `Segment1.next = `Segment0
    }
}

test suite for segmentLength {
    // Test that segment length is within bounds
    // example validSegmentLength is {segmentLength[1, 5]} for {
    //     Segment = `Segment0
    //     `Segment0.x1 = 0
    //     `Segment0.y1 = 0
    //     `Segment0.x2 = 3
    //     `Segment0.y2 = 2
    // }

    // Test that segment length is out of bounds
    example invalidSegmentLength is {not segmentLength[1, 5]} for {
        Segment = `Segment0
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 6
        `Segment0.y2 = 6
    }
}

test suite for next_connected {
    // Test that segments are correctly connected
    example validNextConnected is {next_connected} for {
        Segment = `Segment0 + `Segment1
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment1.x1 = 1
        `Segment1.y1 = 1
        `Segment1.x2 = 2
        `Segment1.y2 = 2
        `Segment0.next = `Segment1
    }

    // Test that segments are not correctly connected
    example invalidNextConnected is {not next_connected} for {
        Segment = `Segment0 + `Segment1
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment1.x1 = 2
        `Segment1.y1 = 2
        `Segment1.x2 = 3
        `Segment1.y2 = 3
        `Segment0.next = `Segment1
    }
}

test suite for no_self_connection {
    // Test that no segment is self-connected
    example validNoSelfConnection is {no_self_connection} for {
        Segment = `Segment0
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment0.next = `Segment1
    }

    // Test that a segment is self-connected
    example invalidSelfConnection is {not no_self_connection} for {
        Segment = `Segment0
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment0.next = `Segment0
    }
}

test suite for disj_endpoints {
    // Test that segments have disjoint endpoints
    example validDisjEndpoints is {disj_endpoints} for {
        Segment = `Segment0 + `Segment1
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment1.x1 = 2
        `Segment1.y1 = 2
        `Segment1.x2 = 3
        `Segment1.y2 = 3
    }

    // Test that segments do not have disjoint endpoints
    example invalidDisjEndpoints is {not disj_endpoints} for {
        Segment = `Segment0 + `Segment1
        `Segment0.x1 = 0
        `Segment0.y1 = 0
        `Segment0.x2 = 1
        `Segment0.y2 = 1
        `Segment1.x1 = 1
        `Segment1.y1 = 1
        `Segment1.x2 = 2
        `Segment1.y2 = 2
    }
}