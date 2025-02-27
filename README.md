Use linux operating system

II. Compile and run the program using NASM.

    Save the program in a file, e.g., hello.asm.

    Compile the program using NASM:
    bash
      nasm -f elf32 hello.asm -o hello.o

    Link the object file to create an executable:
    bash
        ld -m elf_i386 hello.o -o hello

    Run the executable:
    bash
        ./hello
       output:
       Hello, World!


2. Hello_segments
Compilation and Execution

    Save the program in a file, e.g., hello_segments.asm.

    Compile the program using NASM:
    bash
    

    nasm -f elf32 hello_segments.asm -o hello_segments.o

    Link the object file to create an executable:
    bash
    

    ld -m elf_i386 hello_segments.o -o hello_segments

    Run the executable:
    bash
    

    ./hello_segments

Expected Output


Hello from .data!
Hello Brom .data!
Hello from .text!

// Explanation
