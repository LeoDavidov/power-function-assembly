
.text
welcome: .asciz "Names: Leonid, Yuri \nNetIDs: leoniddavidov, ipoteluev \npower \n"
msg_base: .asciz "Enter the base:\n"
msg_exp: .asciz "Enter the exponent:\n"

input: .asciz "%lds" // specify input format

output_string: .asciz "%ld\n"

.global main

main:
    # prologue ///////////////////// creating the stack frame
    pushq %rbp                   #// set bp
    movq %rsp, %rbp              #//  allign sp and bp
    # //////////////////////////////
    

    # print Welcome 👋
    movq $0, %rax
    movq $welcome, %rdi
    call printf

    # message to input base 📝
    movq $0, %rax
    movq $msg_base, %rdi
    call printf
    # user inputs base
    subq $16 , %rsp  # Reserve stack space for variable
    movq $0 , %rax   # no vector registers for scanf
    movq $input, %rdi   # load first argument of scanf
    leaq -16(%rbp) , %rsi # Load address of stack var in rsi
    call scanf


    # message to input exp 📝
    movq $0, %rax
    movq $msg_exp, %rdi
    call printf
    # input exp
    subq $16 , %rsp  # Reserve stack space for variable
    movq $0 , %rax   # no vector registers for scanf
    movq $input, %rdi   # load first argument of scanf
    leaq -8(%rbp) , %rsi # Load address of stack var in rsi
    call scanf
    # save the scanned value
    movq -16(%rbp ), %rdi # copy the base to rdi (first param)
    movq -8(%rbp), %rsi  # copy the exp to rdi (second param)
    
    # call the subroutine
    call pow

   #print result of the multiplication ✍
    movq %rax, %rsi
    movq $0, %rax
    movq $output_string, %rdi
    call printf 


    # epilogue /////////////////////
    movq %rbp, %rsp              #//
    popq %rbp                    #//
    # //////////////////////////////
end: # load the program exit code end exit
    movq $0, %rdi
    call exit


# the power subroutine which raises the base to the given power ////////
# and prints the result to console /////////////////////////////////////
pow:
    # prologue /////////////////////
    pushq %rbp                   #//
    movq %rsp, %rbp              #//
    # //////////////////////////////


    # doing the math
    movq $1, %rax   # set the initial multiplier to 1
    cmp $0, %rsi     # comparing exp to 0
    je toEnd



        # the multiplying loop
    loopTop:
                
        imul %rdi  #result *= base
        dec %rsi         # decrease exp
        cmp $0, %rsi     # comparing exp to 0
        jg loopTop       # while its > - return to Top
    toEnd:


    # epilogue /////////////////////
    movq %rbp, %rsp              #//
    popq %rbp                    #//
    # //////////////////////////////

    ret # return from the f











