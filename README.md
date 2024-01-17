Basic assembly calculator

This code reads whatever is the input string is up to 10 bytes and is named input for
the buffer. After this we load the first byte from input onto rax and then we subtract 48
to convert the ASCII value to its respective integer value.
From the code we first set clear our rdx for division, from there we set r10 to 10 and
then divide and store the answer in rax and remainder in rdx. From add we add the
result buffer with ASCII from the division and add the digit to the buffer. From there we
load this onto r8.
We can also see from our forloop we load each symbol and perform the ASCII
conversion based on whatever was loaded onto the bl, cl registers using r10 as the
index.
