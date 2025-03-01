import argparse

SIG_NAME = "Segment"
PROPERTIES = ["x1", "x2", "y1", "y2"]

DX_SIG_NAME = "Dx"
DY_SIG_NAME = "Dy"

def instbd_gen(min_coord, max_coord, seg_count, min_d, max_d):
    forge = ""

    atom_names = [f"`{SIG_NAME}{i}" for i in range(seg_count)]
    forge += f"{SIG_NAME} = {' + '.join(atom_names)}\n"

    forge += "\n"
    
    coord_set = "+".join(map(str, [*range(min_coord, max_coord+1)]))
    for atom in atom_names:
        for prop in PROPERTIES:
            forge += f"{atom}.{prop} in ({coord_set})\n"
    
    forge += "\n"
    dx_atom_names = [f"`{DX_SIG_NAME}{'M' + str(abs(i)) if i < 0 else i}" for i in range(min_d, max_d+1)]
    dy_atom_names = [f"`{DY_SIG_NAME}{'M' + str(abs(i)) if i < 0 else i}" for i in range(min_d, max_d+1)]

    forge += f"{DX_SIG_NAME} = {' + '.join(dx_atom_names)}\n"
    forge += f"{DY_SIG_NAME} = {' + '.join(dy_atom_names)}\n"

    forge += "\n"
    for atom, i in zip(dx_atom_names, range(min_d, max_d+1)):
        forge += f"{atom}.dx = {i}\n"

    forge += "\n"
    for atom, i in zip(dy_atom_names, range(min_d, max_d+1)):
        forge += f"{atom}.dy = {i}\n"

    return forge


def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Generate instbd code for segments.")
    parser.add_argument("min_coord", type=int, help="Minimum coordinate value")
    parser.add_argument("max_coord", type=int, help="Maximum coordinate value")
    parser.add_argument("seg_count", type=int, help="Number of segments")
    parser.add_argument("min_d", type=int, help="Minimum dx/dy value") 
    parser.add_argument("max_d", type=int, help="Maximum dx/dy value")

    # Parse the arguments
    args = parser.parse_args()

    # Generate the instbd code
    result = instbd_gen(args.min_coord, args.max_coord, args.seg_count, args.min_d, args.max_d)
    
    # Print the result
    print(result)


if __name__ == "__main__":
    main()
