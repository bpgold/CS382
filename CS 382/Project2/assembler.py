#Breona Pizzuta and Ben Carpenter
# "I pledge my honor that I have abided by the Stevens Honor System"

# Function to convert a decimal number to a binary string with padding
def decToBin(n, count=8):
    """Convert a decimal number n into a binary string.
    Pads the result to ensure it is 'count' bits long.
    Example: decToBin(5, 8) -> "00000101"
    """
    if n == 0 and count <= 0:  # Base case
        return ""
    elif n == 0:  # Continue adding zeroes for padding
        return decToBin(n, count-1) + "0"
    return decToBin(n // 2, count-1) + str(n % 2)  # Recursive division by 2 to get binary digits

# Function to convert a binary string to a hexadecimal string
def binToHex(binary):
    """Convert a binary string to a hexadecimal string.
    Pads the result to ensure it is 2 characters long.
    Example: binToHex("00000101") -> "05"
    """
    return hex(int(binary, 2))[2:].zfill(2)
    #.zfill used to add zeros until len 2

# Function to map register names (e.g., X0, X1) to their binary codes
def encode_register(register):
    """ Encode a register name X0, X1, X2, X3 into a 2-bit binary string.
    Example: encode_register("X1") -> "01"
    """
    mapping = {"X0": "00", "X1": "01", "X2": "10", "X3": "11"}
    return mapping.get(register.upper(), "00")  # In case of error, default to "00" if the register is not recognized

# Function to encode an LDR instruction
def LDR(Rd, Rn, imm):
    """Generate a binary representation of an LDR instruction.
    Rd: Destination register
    Rn: Source register
    imm: Immediate value (a constant)
    Example: LDR("X1", "X2", 5) -> "00 01 10 000101"
    """
    opcode = "00"  # Opcode for LDR is "00"
    return opcode + encode_register(Rd) + encode_register(Rn) + '00' + decToBin(int(imm), 8)

# Function to encode an STR instruction
def STR(Rd, Rn, imm):
    """Generate a binary representation of an STR instruction.
    Rd: Source register
    Rn: Destination register
    imm: Immediate value (a constant)
    Example: STR("X0", "X1", 10) -> "01 00 01 001010"
    """
    opcode = "01"  # Opcode for STR is "01"
    return opcode + encode_register(Rd) + encode_register(Rn) + '00' +decToBin(int(imm), 8)

# Function to encode an ADD instruction
def ADD(Rd, Rn, Rm):
    """Generate a binary representation of an ADD instruction.
    Rd: Destination register
    Rn: Source register 1
    Rm: Source register 2
    Example: ADD("X2", "X3", "X0") -> "11 10 11 00"
    """
    opcode = "11"  # Opcode for ADD is "11"
    return opcode + encode_register(Rd) + encode_register(Rn) + encode_register(Rm) + '00000000'

# Function to encode a SUB instruction
def SUB(Rd, Rn, Rm):
    """Generate a binary representation of a SUB instruction.
    Rd: Destination register
    Rn: Source register 1
    Rm: Source register 2
    Example: SUB("X3", "X0", "X1") -> "10 11 00 01"
    """
    opcode = "10"  # Opcode for SUB is "10"
    return opcode + encode_register(Rd) + encode_register(Rn) + encode_register(Rm) + '00000000'

# Main function to assemble an input assembly file into a machine code image
def assemble(file):
    """Parse an assembly file and generate machine code for .text and .data (EC)
    The output is written to two files, code_image.txt and data_image.txt
    """
    data_section = {}  # Dictionary to store variable names and their values from the .data section
    text_section = []  # List to store instruction lines from the .text section
    in_text = False  # Indicate if we're inside the .text section
    in_data = False  # Indicate if we're inside the .data section

    # Step 1: Read and parse the input file
    with open(file, "r") as f:
        for line in f:
            line = line.strip()  # Remove whitespace around the line
            if not line or line.startswith(";"):  # Skip comments and empty lines
                continue

            # Switch between .text and .data sections
            if line == ".text":
                in_text = True
                in_data = False
                continue
            elif line == ".data":
                in_text = False
                in_data = True
                continue

            # Parse .data section: variable definitions
            if in_data:
                if ":" in line:  # Example: "var1: 1010"
                    var, value = line.split(":")
                    data_section[var.strip()] = binToHex(value.strip())

            # Parse .text section: instructions
            elif in_text:
                text_section.append(line)

    # Step 2: Generate code memory output for instructions
    code_out = "v3.0 hex words addressed\n"
    adr = "00"  # Starting address for instructions
    count = 0  # Track the number of instructions in the current memory line
    adr_num = 0  # Numerical address for memory increment
    for line in text_section:
        parts = line.split()  # Split instruction into parts
        if len(parts) < 2:
            continue

        op = parts[0]  # Operation (e.g., "LDR", "ADD")
        parts[1] += parts[2].replace("[", "")
        parts[1] += parts[3].replace("]", "")

        args = parts[1].split(",")  # Arguments (e.g., "X1,X2,5")
        
        # Translate instructions into binary machine code
        if op == "LDR":
            instruction = binToHex(LDR(args[0], args[1], args[2]))
            if (len(instruction) != 4): # fixes error when Rn = X0, and only applies here since opcode is 00
                instruction = (4 - len(instruction)) * "0" + instruction
        elif op == "STR":
            instruction = binToHex(STR(args[0], args[1], args[2]))
        elif op == "ADD":
            instruction = binToHex(ADD(args[0], args[1], args[2]))
        elif op == "SUB":
            instruction = binToHex(SUB(args[0], args[1], args[2]))
        else:
            continue  # Ignore unrecognized instructions

        # Add instruction to output
        if count == 0:  # Start a new line with an address
            code_out += f"{adr}: "
        code_out += instruction + " "
        count += 1

        # Increment address after 16 instructions per line
        if count == 16:
            code_out += '\n'
            count = 0
            adr_num += 16
            adr = binToHex(decToBin(adr_num))

    # Step 3: Generate data memory output
    data_out = "v3.0 hex words addressed\n"
    adr = "00"  # Starting address for data memory
    adr_num = int(adr, 16)
    for var, value in data_section.items():
        data_out += f"{binToHex(decToBin(adr_num, 16))}: {' '.join(value[i:i+2] for i in range(0, len(value), 2))}"
        data_out +=  "0" * (len(value) % 2) + "\n"
        adr_num += len(value)//2 + 2

    # Step 4: Write outputs to files
    with open("code_image.txt", "w") as code_file:
        code_file.write(code_out.strip())

    with open("data_image.txt", "w") as data_file:
        data_file.write(data_out.strip())

    # Step 5: Print outputs for debugging
    print("Code Memory:")
    print(code_out.strip())
    print("\nData Memory:")
    print(data_out.strip())

# Entry point of the program
def main():
    """ Main function to assemble a sample assembly file."""
    assemble("instructions.txt")  # Replace with your input file

if __name__ == "__main__":
    main()





