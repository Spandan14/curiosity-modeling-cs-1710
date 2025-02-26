const segments = Segment.tuples().map(tuple => tuple.atoms()[0]);  

const lines = [];
const SCALE = 20;

segments.forEach(seg => {
    // Extract x1, y1, x2, y2
    let x1_val = seg.join(x1).tuples().map(t => t.atoms()[0].id())[0];
    let y1_val = seg.join(y1).tuples().map(t => t.atoms()[0].id())[0];
    let x2_val = seg.join(x2).tuples().map(t => t.atoms()[0].id())[0];
    let y2_val = seg.join(y2).tuples().map(t => t.atoms()[0].id())[0];

    x1_val *= SCALE;
    x2_val *= SCALE;
    y1_val *= SCALE;
    y2_val *= SCALE;

    // Store the coordinates as line segments
    lines.push([{ x: x1_val, y: y1_val }, { x: x2_val, y: y2_val }]);
});

const stage = new Stage()

// Add lines for each segment
lines.forEach(lineData => {
    let line = new Line({
        points: lineData, 
        color: 'black', 
        width: 2, 
        labelColor: "blue",
        arrow: true,
        style: "dotted"
    });
    
    stage.add(line);
});

// render
stage.render(svg);






