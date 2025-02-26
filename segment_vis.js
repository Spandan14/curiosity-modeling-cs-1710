const segments = Segment.tuples().map(tuple => tuple.atoms()[0]);  

const lines = [];
const atomNames = [];
const SCALE = 25;
const X_OFFSET = 50;
const Y_OFFSET = 50;

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

    x1_val += X_OFFSET;
    x2_val += X_OFFSET;
    y1_val += Y_OFFSET;
    y2_val += Y_OFFSET;

    // Store the coordinates as line segments
    lines.push([{ x: x1_val, y: y1_val }, { x: x2_val, y: y2_val }]);
    atomNames.push(seg.id());
});

const stage = new Stage()

// Add lines for each segment
lines.forEach((lineData, index) => {
    let line = new Line({
        points: lineData, 
        color: 'black', 
        width: 2,
        arrow: true,
        style: "dotted"
    });
    
    stage.add(line);

    // Create a new text label with the atom name (e.g., `Segment0`)
    const atomName = atomNames[index]; 

    // Position the text slightly offset from the line's midpoint
    const midX = (lineData[0].x + lineData[1].x) / 2;
    const midY = (lineData[0].y + lineData[1].y) / 2;

    // Adjust the position of the text if needed (e.g., a bit offset from the line midpoint)
    const offsetX = 10; // Horizontal offset
    const offsetY = -10; // Vertical offset

    let text = new TextBox({
        text: atomName,
        coords: { x: midX + offsetX, y: midY + offsetY },
        color: 'black',
        fontSize: 12
    });

    // Add the text label to the stage
    stage.add(text);
});

// render
stage.render(svg);



