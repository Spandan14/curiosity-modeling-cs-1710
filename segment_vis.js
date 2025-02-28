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

    // Store the coordinates as line segments
    lines.push([{ x: x1_val, y: y1_val }, { x: x2_val, y: y2_val }]);
    atomNames.push(seg.id());
});

const stage = new Stage()

// Add lines for each segment
lines.forEach((lineData, index) => {
    let drawData = [{ x: lineData[0].x, y: lineData[0].y }, { x: lineData[1].x, y: lineData[1].y }];
    
    drawData[0].x *= SCALE;
    drawData[1].x *= SCALE;
    drawData[0].y *= SCALE;
    drawData[1].y *= SCALE;

    drawData[0].x += X_OFFSET;
    drawData[1].x += X_OFFSET;
    drawData[0].y += Y_OFFSET;
    drawData[1].y += Y_OFFSET;

    let line = new Line({
        points: drawData, 
        color: 'black', 
        width: 2,
        arrow: true,
        style: "dotted"
    });
    
    stage.add(line);

    // Create a new text label with the atom name (e.g., `Segment0`)
    const atomName = atomNames[index]; 

    // Position the text slightly offset from the line's midpoint
    const midX = (drawData[0].x + drawData[1].x) / 2;
    const midY = (drawData[0].y + drawData[1].y) / 2;

    // Adjust the position of the text if needed (e.g., a bit offset from the line midpoint)
    const offsetX = 10; // Horizontal offset
    const offsetY = -10; // Vertical offset

    let text = new TextBox({
        text: atomName,
        coords: { x: midX + offsetX, y: midY + offsetY },
        color: 'black',
        fontSize: 12
    });

    let nextSegment = `Segment${(parseInt(atomName[7]) + 1) % lines.length}`; 
    let nextLineData = lines[atomNames.indexOf(nextSegment)];

    console.log(lineData)
    console.log(nextLineData)
    let dotProduct = (lineData[0].x - lineData[1].x) * (nextLineData[1].x - nextLineData[0].x) 
                    + (lineData[0].y - lineData[1].y) * (nextLineData[1].y - nextLineData[0].y);

    let dotPText = new TextBox({
        text: `${atomName[7]} -> ${nextSegment[7]}: ${dotProduct}\n
                (${lineData[0].x}, ${lineData[0].y}) to (${lineData[1].x}, ${lineData[1].y})\n 
                (${nextLineData[0].x}, ${nextLineData[0].y}) to (${nextLineData[1].x}, ${nextLineData[1].y})`,
        coords: { x: 400, y: 500 + 25 * atomName[7] },
        color: 'black',
        fontSize: 12
    });

    let distText = new TextBox({
        text: `sqdist: ${Math.pow(lineData[0].x - lineData[1].x, 2) + Math.pow(lineData[0].y - lineData[1].y, 2)}`,
        coords: { x: 200, y: 500 + 25 * atomName[7] },
        color: 'black',
        fontSize: 12
    });

    stage.add(text);
    stage.add(dotPText);
    stage.add(distText);
});

// render
stage.render(svg);



