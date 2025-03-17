.data
  m: .space 4 #linii
  n: .space 4 #coloane
  p: .space 4  #nrcelulevii
  cop_edx: .space 4
  cop_ecx: .space 4
  cop_ebx: .space 4
  cop_eax: .space 4
  lineIndex: .space 4
  coloanaIndex : .space 4
  line :.space 4
  col :.space 4
  colIndex :.space 4
  matrix : .zero 1600
  k: .space 4
  x: .space 4
  y: .space 4
  v: .space 4
  i: .space 4
  j: .space 4
  n1: .space 4 #coloanecu2
  m1: .space 4  #liniicu2
  sum: .space 4
  matrix2 :.zero 1600
  
  formatScanf : .asciz "%d"
  formatPrintf : .asciz "%d "
  endl : .asciz "\n"
.text
.global main


main:
  push $m 
  push $formatScanf
  call scanf
  pop %ebx
  pop %ebx
     push $n
     push $formatScanf
     call scanf
     pop %ebx
     pop %ebx
   push $p
   push $formatScanf
   call scanf
   pop %ebx
   pop %ebx
   
 
   
   movl n,%ecx
   movl %ecx,n1
   incl n1
   incl n1
   movl m,%ecx
   movl %ecx,m1
   incl m1
   incl m1
   mov $0,%ecx
   mov $matrix,%edi
   
   
et_for_cel:
     cmp %ecx,p
     je et_citirek
     
     
      pushl %ecx
      pushl $x
      push $formatScanf
      call scanf
      pop %ebx
      popl %ebx
      
       
       
       pushl $y
       push $formatScanf
       call scanf
       pop %ebx
       popl %ebx
       popl %ecx
       
       
       incl x
       incl y
       
       
      
      movl x,%eax   #x*n+y
      mull n1
      addl y,%eax
      
      lea matrix,%edi
      movl $1,(%edi,%eax,4)
     
      inc %ecx
      jmp et_for_cel
      
et_citirek:
      pushl %ecx
      pushl $k
      push $formatScanf
      call scanf
      pop %ebx
      popl %ebx
      popl %ebx
      
     
       
      
   
   
et_calcul:
   lea matrix,%edi
   
   movl k,%edx
  cmp $0,%edx #while k
  je et_afisarema
     
     movl %edx,cop_edx
     
      
       movl $1,lineIndex
       
       for_lcal:  
        movl m,%ebx
        cmp lineIndex,%ebx #for i,m
        jl et_mutare
        
        movl %ebx,cop_ebx     
        movl $1,colIndex
       
        for_cal:
         
         movl n,%ecx
         cmp colIndex,%ecx #for j,n
         jl for_lcal_cont
         
         movl cop_ecx,%ecx
         
         
           movl $0,sum
     	   # v[i+1][j]
           movl lineIndex,%eax
           incl %eax
           mull n1
           addl colIndex,%eax
           lea matrix,%edi
           movl (%edi,%eax,4),%ebx
           addl %ebx,sum
           
           #v[i-1][j] 
           movl lineIndex,%eax
           decl %eax
           mull n1
           addl colIndex,%eax
           lea matrix,%edi
           movl (%edi,%eax,4),%ebx
           addl %ebx,sum
           
           
           #v[i+1][j+1]
           movl lineIndex,%eax
           incl %eax
           mull n1
           addl colIndex,%eax
           incl %eax
           lea matrix,%edi 
           movl (%edi,%eax,4),%ebx
           add %ebx,sum
            
           
           #v[i+1][j-1]
           movl lineIndex,%eax
           incl %eax
           mull n1
           addl colIndex,%eax
           decl %eax
           lea matrix,%edi
           movl (%edi,%eax,4),%ebx
           add %ebx,sum
           
           
           #v[i-1][j-1]
           movl lineIndex,%eax
           decl %eax
           mull n1
           addl colIndex,%eax
           decl %eax
           lea matrix,%edi 
           movl (%edi,%eax,4),%ebx
           add %ebx,sum
           
           
           #v[i-1][j+1]
           movl lineIndex,%eax
           decl %eax
           mull n1
           addl colIndex,%eax
           incl %eax
           movl (%edi,%eax,4),%ebx
           add %ebx,sum
           
           
           #v[i][j+1]
           movl lineIndex,%eax
           mull n1
           addl colIndex,%eax
           incl %eax
           lea matrix,%edi
           movl (%edi,%eax,4),%ebx 
           add %ebx,sum
           
            #v[i][j-1]
           movl lineIndex,%eax
           mull n1
           addl colIndex,%eax 
           decl %eax
           lea matrix,%edi  
           movl (%edi,%eax,4),%ebx 
           add %ebx,sum
           
         vecini:
         mov $matrix,%edi
         addl $1,%eax
         movl (%edi,%eax,4),%ebx
         mov $3,%edx
         cmp $1,%ebx #verific daca elem e 1
         je etverific 
         
         cmp sum,%edx #dc e 0 si are 3 vecini il creez dc a ajuns aici inseamna ca nu e 1
         je et_creere
         
         
         jmp et_moare
     et_creere:
      lea matrix2,%edi
      movl $1,(%edi,%eax,4)
      jmp et_increase
      
   etverific: #dc elem e 1 verific dc are >3 vecini si atunci moare 
      movl $3,%edx
      cmp sum,%edx
      jl et_moare
       
       movl $2,%edx #verific dc are<2 vecini si atunci iar moare
       cmp sum,%edx
       jg et_moare
       jmp et_creere
       
     jmp et_ramane1
       
      et_moare: 
       lea matrix2,%edi
       movl $0,(%edi,%eax,4) 
       jmp et_increase
     et_ramane1:
       lea matrix2,%edi
       movl $1,(%edi,%eax,4) 
     
       
       
       et_increase:     
          incl colIndex
          jmp for_cal
        
          
       for_lcal_cont:
          incl lineIndex
          movl cop_ebx,%ebx
          movl cop_edx,%edx
          jmp for_lcal
        
     et_mutare: 
       
       
       movl $0,line
       et_f:
        movl m1,%ebx
        cmp line,%ebx
        je decrease_k
         
         movl $0,col
         movl n1,%ecx
         et_c:
         cmp col,%ecx
         je et_f_cont
          
           
           movl line,%eax
           mull n1
           addl col,%eax
           lea matrix2,%edi
           movl (%edi,%eax,4),%ebx
           lea matrix,%edi
           mov %ebx,(%edi,%eax,4)
           
           incl col
           
           jmp et_c
           
      et_f_cont:
           incl line
           jmp et_f
      
       
       decrease_k:
       decl k
       
       decl %edx 
       jmp et_calcul
      
et_afisarema:
   
   movl $1,lineIndex
for_lines:
    mov lineIndex,%ecx
    cmp %ecx,m
    jl et_exit
    movl $1,coloanaIndex
      for_col:
        mov coloanaIndex,%ecx
        cmp %ecx,n
        jl afisez
       
        movl lineIndex,%eax
        mull n1
        addl coloanaIndex,%eax
        
        lea matrix,%edi
        movl (%edi,%eax,4),%ebx
        
        push %ebx
        push $formatPrintf
        call printf
        pop %ebx
        pop %ebx
        pushl $0
        call fflush 
        popl %ebx
        incl coloanaIndex
        jmp for_col 
afisez:
  
  push $endl
  call printf
  add $4,%esp
  
  incl lineIndex
  jmp for_lines
      
      
et_exit:
   push $0
   call fflush
   addl $4,%esp
    mov $1,%eax
    mov $0,%ebx
    int $ 0x80

