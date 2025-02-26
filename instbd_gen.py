import argparse

SIG_NAME = "Segment"
PROPERTIES = ["x1", "x2", "y1", "y2"]

def instbd_gen(min_coord, max_coord, seg_count):
    forge = ""

    atom_names = [f"`{SIG_NAME}{i}" for i in range(seg_count)]
    forge += f"{SIG_NAME} = {' + '.join(atom_names)}\n"

    coord_set = "+".join(map(str, [*range(min_coord, max_coord+1)]))
    for atom in atom_names:
        for prop in PROPERTIES:
            forge += f"{atom}.{prop} in ({coord_set})\n"

    return forge


def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Generate instbd code for segments.")
    parser.add_argument("min_coord", type=int, help="Minimum coordinate value")
    parser.add_argument("max_coord", type=int, help="Maximum coordinate value")
    parser.add_argument("seg_count", type=int, help="Number of segments")
    
    # Parse the arguments
    args = parser.parse_args()

    # Generate the instbd code
    result = instbd_gen(args.min_coord, args.max_coord, args.seg_count)
    
    # Print the result
    print(result)


if __name__ == "__main__":
    main()
