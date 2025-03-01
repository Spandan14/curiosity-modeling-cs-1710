# Curiosity Modeling | Vector Pathfinding

Made by Stanley Ndichu and Spandan Goel.

## Introduction/Objective

This project is a Forge model of an arbitrary set of line segments that can be programmed to follow a variety of guidelines, based on different predicates.

The point of this is to see how well Forge performs on geometric tasks that can be used to model real-world scenarios. There are predicates that constraint on where paths go, there are predicates on the distances paths take, and also predicates on the amount of curvature paths can have. These can be used to model speed vs distance trade-offs, model the behavior of certain entities (cars, aircraft) when following a path, or just be used to prove certain geometry concepts.

## Model Design

Our model has a few fundamental signatures and predicates that allow it to run the model.

### `sig`s

`sig Segment` - Represents a line segment in the model. It has a start coordinates `x1` and `y1`, and an end coordinates `x2` and `y2`. It also has a `next` `lone Segment` that represents a potential next segment.

`sig Dx` - Represents the change in x-coordinates between two segments. It has a `dx` field that represents the change in x-coordinates between two segments. This is mainly used to prune the search space for Forge, as we can set instance bounds on this signature to be between say, -5 and 5.

`sig Dy` - Represents the change in y-coordinates between two segments. It has a `dy` field that represents the change in y-coordinates between two segments. This is mainly used to prune the search space for Forge, as we can set instance bounds on this signature to be between say, -5 and 5.

### `pred`s

`pred SegmentLength[minLength: Int, maxLength: Int]` - This predicate constraints the Euclidean length of every segment.

`pred next_connected` - this predicate ensures that segments connected by `next` share the end/start point, so that they are truly connected.

`pred no_self_connnection` - this predicate ensures that no segment is connected to itself.

`pred disj_endpoints` - this predicate ensures that no two segments share the same end points.

`pred hit_endpoint[x: Int, y: Int]` - this predicate ensures that a segment passes through a point (x, y) as its endpoint.

`pred hit_startpoint[x: Int, y: Int]` - this predicate ensures that a segment passes through a point (x, y) as its start point.

`pred hit_point[x: Int, y: Int]` - this predicate ensures that a segment passes through a point (x, y) as either its start or end point.

`pred overall_start[x: Int, y: Int]` - this predicate ensures that the first segment starts at a point (x, y). The first segment corresponds to some segment that is not the `next` of any other segment.

`pred overall_end[x: Int, y: Int]` - this predicate ensures that the last segment ends at a point (x, y). The last segment corresponds to some segment has no `next` segment.

`pred curvature[maxDotProduct: Int]` - this predicate ensures that the angle between two consecutive segments is less than a certain amount. By consecutive segments, we mean a segment and its `next` segment. This constraint makes users supply the maximum _dot product_ between the two segments, which is a proxy for the angle between them. This is necessary as all our math is in integers, and we want to avoid division. Note that setting this to 1 will mean that all segments have to be at right or obtuse angles, which is something we tested extensively in our manual runs.

`pred distance[maxDistance: Int]` - this predicate ensures that the total Euclidean distance of all segments is less than a certain amount. This is useful for modeling scenarios where the path has to be short, and creates some interesting behaviors.

### Utilities

We also have a visualization script in `segment_vis.js` that shows all the segments on a grid.

We have a Python file called `instbd_gen.py` that generates instance bounds for our model so that we can prune the search space for Forge. This is necessary as Forge can take a long time to converge when the bit width is large, which is required for our complex math operations.

### `inst` bounds

We need instance bounds in order to prune the search space. Most of these are limits on the x and y coordinates of the segments. In our tests, we keep these between 0 and 15. There are also limits on the `Dx` and `Dy` signatures, so that Forge does not spend a lot of time looking for segment deviations that would move them out of the 16 x 16 grid we have set up in the previous bounds.

## Results

We have included a variety of images in this submission which show our visualizer in action. The file names correspond to some of the constraints used, and you can see some interesting patterns as the model tries to go from (0, 0) to (15, 15), hitting (10, 5) and (5, 10) along thee way.

## Testing

We experimented with the different test approaches for our model, including example based tests, asserts and expect.
These tests cover various aspects of the model, including segment lengths, connectivity, and geometric constraints.

#### `segmentLength`

This test suite verifies that the length of each segment falls within the specified range. We have examples for both valid and invalid segment lengths:

- `validLength`: We used a straight horizontal segment of length 2.
- `invalidLength`: We used a diagonal segment with length sqrt(50), which is valid but violates the instance boundary.

#### `next_connected`

This test suite ensures that segments connected by the `next` field share the end/start point, making them truly connected:

- `validChain`: Tests a chain of two connected segments.
- Assertion: Ensures that no segment is connected to itself and that there is at least one segment with a `next` connection.

#### `no_self_connection`

This test suite ensures that no segment is connected to itself:

- `validCase`: Tests a segment with no `next` connection.
- Expectation: Ensures that no segment is connected to itself. If there is then it should be unsat.

#### `disj_endpoints`

This test suite ensures that no two segments share the same endpoints:

- `validEndpoints`: Tests two segments with distinct endpoints.
- Expectation: Ensures that no two segments share the same endpoints.

#### `curvature`

This test suite verifies the angle between two consecutive segments:

- Expectation: Allows orthogonal segments (dot product 0).
- Expectation: Forbids aligned segments (dot product 25).

#### `distance`

This test suite ensures that the total Euclidean distance of all segments is within a specified limit:

- Expectation: Ensures that the total distance is less than or equal to 200.
- Expectation: Ensures that the total distance is greater than 50.

#### `hit_endpoint`

This test suite ensures that a segment passes through a specified endpoint:

- `hitValid`: Tests a segment that passes through the point (5, 5).
- Assertion: Ensures consistency with the `overall_start` predicate.

#### `fully_connected`

This test suite ensures that all segments form a fully connected chain:

- `validChain2`: Tests a chain of three connected segments.

#### `overall_start`

This test suite ensures that the first segment starts at a specified point:

- `validStart`: Tests a segment that starts at the point (0, 0).
- Assertion: Ensures consistency with the `fully_connected` predicate.

#### `overall_end`

This test suite ensures that the last segment ends at a specified point:

- `validEnd`: Tests a segment that ends at the point (15, 15).

The choice of which test approach to use was informed by the expected behaviour of the predicat ein question. For example, it was difficult to write example test cases for our curvature predicate so we went with expect unsat cases for instances we knew were invalid.
