
JMP main
    
isr:
    MOV A, 2 ; Set the second bit to clear the interrupt.
    OUT 2 ; Clear the interrupt (A -> IRQEOI).
     
      PUSH [index]		
      PUSH 16			
      PUSH strr    		
      CALL funkcija		
      
      PUSH 0			
      PUSH [index] 		
      PUSH strr			
      CALL funkcija		
            
      MOV A, [index]	
      CMP A, 15			
      JB iret			
      MOV A, 0			
            
iret:
    INC A						
    MOV [index], A				
    MOV [drawPos], 0x0EE0   	
    IRET 
main:
    MOV SP, 0x0edf ; Initialize stack.     								 
    MOV A, 16000; 250 ciklov * 64 = 16000
    OUT 3 ; Preload counter to 500.
    MOV A, 2 ; Set the second bit to enable timer interrupts.
    OUT 0 ; Enable timer interrupts (A -> IRQMASK).
    

    
    
    stop:
    STI ; Enable interrupts globally (M = 1).
    HLT ; Halt and let interrupts do the rest.
    
    
funkcija:
	
    POP D		
    POP C		
    POP B		
    POP A		
    PUSH D 		
   	ADDB CL, AL 
for:
    MOVB DL, [C]		
    MOVB DH, AL  		
    MOV A, [drawPos]	
    MOVB [A], DL 		
    INC A 				
    INC C 				
    MOV [drawPos], A 	
 	MOVB AL, DH 		
    INC A 				
    CMPB AL, BL 		
    JAE exit 			
    JMP for 			
   	exit: 
    	RET 
    
    
strr: DB "Hello world!    "  ;string dolžine 16
DB 0 
drawPos: DW 0x0EE0			 
index: DW 8					 

