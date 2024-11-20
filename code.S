.data
	matrix: .space 1296
	parola: .space 20
	matrixBordat: .space 1600
        n: .space 4
	n_b: .space 4
	m_b: .space 4
        m: .space 4
	n_parc: .space 4
	m_parc: .space 4
        p: .space 4
        k: .space 4
        elemcurent: .space 4
        suma: .space 4
        index: .long 0
        lineIndex: .space 4
	left_b: .space 4
	right_b: .space 4
        columnIndex: .space 4
        kIndex: .space 4
        formatElemCur: .asciz "Elementul curent este %ld, iar suma este: "
        formatScanf: .asciz "%ld"
        formatPrintf: .asciz "%d "
        newLine: .asciz "\n"
        formatAsciz: .asciz "%s"
	lg: .space 4
	lgbiti: .space 4
	ElemMatrix: .space 4
.text
 
citireMatrice:
        //Citire Numar Linii
        pushl $n
        pushl $formatScanf
        call scanf
        popl %ebx
        popl %ebx
 
        //CItire Numar coloane
        pushl $m
        push $formatScanf
        call scanf
        popl %ebx
        popl %ebx
 
        //Citire Numar Celule Vii
        pushl $p
        push $formatScanf
        call scanf
        popl %ebx
        popl %ebx
 
        ret
 
 
citireCelulaVie:
        //Citire Linie Celula Vie
        pushl $lineIndex
        push $formatScanf
        call scanf
        popl %ebx
        popl %ebx
 
        //Citire Coloana Celula Vie
        pushl $columnIndex
        push $formatScanf
        call scanf
        popl %ebx
        popl %ebx
 
        movl lineIndex, %eax
        movl $0, %edx
	mull m
        addl columnIndex, %eax
 
        lea matrix, %edi
        movl $1, (%edi, %eax, 4)
 
	movl lineIndex, %eax
	movl %eax, left_b
	incl left_b
 
	movl columnIndex, %eax
	movl %eax, right_b
	incl right_b
 
	movl left_b, %eax
	mull m_b
	addl right_b, %eax
 
	lea matrixBordat, %edi
	movl $1, (%edi, %eax, 4)
 
        ret
 
 
et_exit:
        mov $1, %eax
        mov $0, %ebx
        int $0x80
 
 
GasireVecin:
        movl lineIndex, %eax
        mull m_b
        addl columnIndex, %eax
        movl (%edi, %eax, 4), %ebx
        ret
 
 
CopiereMatrice:
movl $0, lineIndex
for_CopiereLinii:
        movl lineIndex, %ecx
        cmp %ecx, n_b
        je Inapoi
 
        movl $0, columnIndex
        for_CopiereColoane:
                movl columnIndex, %ecx
                cmp %ecx, m_b
                je ContinuareLinii
 
                movl lineIndex, %eax
                mull m_b
                addl columnIndex, %eax
 
                movl (%edi, %eax, 4), %ebx
                lea matrix, %edi
                movl %ebx, (%edi, %eax, 4)
                lea matrixBordat, %edi
 
                addl $1, columnIndex
                jmp for_CopiereColoane
 
	ContinuareLinii:
        addl $1, lineIndex
        jmp for_CopiereLinii
 
        Inapoi:
        ret
 
AfisareMatrice:
movl $1, lineIndex
Afisare_Linii:
        movl lineIndex, %ecx
        cmp %ecx, n_parc
        je terminare
 
        movl $1, columnIndex
        Afisare_Coloane:
                movl columnIndex, %ecx
                cmp %ecx, m_parc
                je Continuare_Linii
 
                movl lineIndex, %eax
                mull m_b
                addl columnIndex, %eax
 
                movl (%edi, %eax, 4), %ebx
 
                pushl %ebx
                push $formatPrintf
                call printf
                popl %ebx
                popl %ebx
 
 		pushl $0
                call fflush
                popl %ebx
 
                addl $1, columnIndex
                jmp Afisare_Coloane
 
        Continuare_Linii:
        mov $4,%eax
        mov $1,%ebx
        mov $newLine, %ecx
        mov $2,%edx
        int $0x80
 
        addl $1, lineIndex
        jmp Afisare_Linii
        terminare:
        ret
 
Viu:
        movl lineIndex, %eax
        mull m_b
        addl columnIndex, %eax
 
        movl suma, %ebx
        cmp $2, %ebx
        jb Moare
        cmp $2, %ebx
        je RamaneVie
        cmp $3, %ebx
        je RamaneVie
        jmp Moare
        Moare:
                lea matrixBordat, %edi
                movl $0, (%edi, %eax, 4)
                lea matrix, %edi
                ret
        RamaneVie:
                lea matrixBordat, %edi
                movl $1, (%edi, %eax, 4)
                lea matrix, %edi
                ret
 
Mort:
        movl lineIndex, %eax
        mull m_b
        addl columnIndex, %eax
        movl suma, %ebx
        cmp $3, %ebx
        je Invie
        jmp RamaneMoarta
        Invie:
                lea matrixBordat, %edi
                movl $1, (%edi, %eax, 4)
                lea matrix, %edi
                ret
        RamaneMoarta:
                lea matrixBordat, %edi
                movl $0, (%edi, %eax, 4)
                lea matrix, %edi
                ret
 
 
citireNumarK:
        pushl $k
        push $formatScanf
        call scanf
        popl %ebx
        popl %ebx
        ret
 
citireParola:
	pushl $parola
	pushl $formatAsciz
	call scanf
	popl %ebx
	popl %ebx
	ret
 
aflareLungime:
	lea parola, %edi
        xor %ecx, %ecx
        for:
        cmpb $0, (%edi)
        je final
        inc %ecx
        inc %edi
        jmp for
 
        final:
        lea matrix, %edi
        movl %ecx, lg
        ret
 
incercareXorare:
	lea matrix, %edi
	movl $0, %ecx
	movl %ecx, contor
	decl n
	movl n, %ecx
 
	eticheta:
	cmp $0, %ecx
	jl xorare
	mov (%edi, %ecx, 4), %eax
	cmp $1, %eax
	je E1
	shll $4, %ebx
	jmp continuare
	E1:
	shll $4, %ebx
	orl %eax, %ebx
	continuare:
	decl %ecx
	jmp eticheta
 
	xorare:
	xorl ca, %ebx
 
Condensare:
        call GasireVecin
        addl %ebx, suma
        ret
 
.global main
main:
	call citireMatrice
 
	movl n, %ecx
    	addl $2, %ecx
        movl %ecx, n_b
	subl $1, %ecx
	movl %ecx, n_parc
 
        movl m, %ecx
        addl $2, %ecx
        movl %ecx, m_b
	subl $1, %ecx
	movl %ecx, m_parc
 
        //Citim Coordonatele fiecarei celule vii
        movl $0, index
        movl $0, kIndex
        CeluleVii:
                movl index, %ecx
                cmp %ecx, p
                je continuare
 
                call citireCelulaVie
 
                incl index
                jmp CeluleVii
 
	continuare:
	call citireNumarK
	call citireParola
	call aflareLungime
 
	movl $4, %eax
	movl $1, %ebx
	movl $newLine, %ecx
	movl $2, %edx
	int $0x80
 
	lea matrixBordat, %edi
	call CopiereMatrice
	for_Kevolutii:
                movl k, %ecx
                cmp %ecx, kIndex
         	je continuare_program
 
 
        movl $1, lineIndex
        //Parcurgerea pe linii
        for_lines:
           	movl lineIndex, %ecx
                cmp %ecx, n_parc
                je verificare
 
                movl $1, columnIndex
                //Parcurgerea pe coloane
                for_columns:
                movl columnIndex, %ecx
                cmp %ecx, m_parc
                je cont_for_lines
 
                movl lineIndex, %eax
                mull m_b
 
                addl columnIndex, %eax
 
                movl (%edi, %eax, 4), %ebx
                movl %ebx, elemcurent
 
                movl $0, suma
					//a[i+1][j]
                                        incl lineIndex
                                        call Condensare
                                        decl lineIndex
 
                                        //a[i-1][j]
                                        decl lineIndex
                                        call Condensare
                                        incl lineIndex
 
                                        //a[i][j+1]
                                        incl columnIndex
                                        call Condensare
                                        decl columnIndex
 
                                        decl columnIndex
                                        call Condensare
                                        incl columnIndex
 
                                        //a[i+1][j+1]
                                        incl columnIndex
                                        incl lineIndex
                                        call Condensare
                                        decl lineIndex
					decl columnIndex
 
					//a[i+1][j-1]
                                        incl lineIndex
                                        decl columnIndex
                                        call Condensare
                                        decl lineIndex
                                        incl columnIndex
 
                                        //a[i-1][j+1]
                                        decl lineIndex
                                        incl columnIndex
                                        call Condensare
                                        incl lineIndex
                                        decl columnIndex
 
                                        decl lineIndex
                                        decl columnIndex
                                        call Condensare
                                        incl lineIndex
                                        incl columnIndex
				movl elemcurent, %ebx
                                cmp $1, %ebx
                                je Vie
                                jmp Moarta
                                Vie:
                                call Viu
                                jmp revenire
                                Moarta:
                                call Mort
 
                                revenire:
                                addl $1, columnIndex
                                jmp for_columns
 
                cont_for_lines:
                addl $1, lineIndex
                jmp for_lines
 
	verificare:
	addl $1, kIndex
 
        lea matrixBordat, %edi
        call CopiereMatrice
 
        movl $0, lineIndex
        jmp for_Kevolutii
 
	continuare_program:
	movl lg, %eax
	mull $8
	movl %eax, lgbiti
 
	movl n_b, %eax
	movl m_b, %ebx
	mull %ebx
	movl %eax, ElemMatrix
 
	cmp lgbiti, %eax
	je SuntEgale
	cmp lgbiti, %eax
	jl MesajLung
	jmp CheieLunga
 
	SuntEgale:
	call LgEgale
	jmp terminare_program
 
	MesajLung:
	call MsjLung
	jmp terminare_program
 
	CheieLunga:
	call KeyLung
 
	terminare_program:
	call et_exit
