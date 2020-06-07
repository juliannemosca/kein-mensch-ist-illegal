	!cpu 6502
	!to "kein-mensch-ist-illegal.prg",cbm

;------------------------------
; Basic loader:
;------------------------------

	*= $0801

	!8 $0d,$08,$d9,$07,$9e,$20,$34,$39
	!8 $31,$35,$32,$00,$00,$00

;------------------------------

	*= $c000

	screen_mem_start_0	= $0400
	color_mem_start_0	= $d800

	screen_mem_start_1	= $0500
	color_mem_start_1	= $d900

	screen_mem_start_2	= $0600
	color_mem_start_2	= $da00

	screen_mem_start_3	= $0700
	color_mem_start_3	= $db00

	col_black			= $00
	; and all the wiphala colors:
	col_white			= $01
	col_yellow			= $07
	col_orange			= $08
	col_red				= $02
	col_purple			= $04
	col_blue			= $06
	col_light_green		= $0d

;------------------------------
; Entry point:
;------------------------------

	jmp main

;------------------------------
; Screen init subroutine:
;------------------------------

init_screen

	ldx		#col_black
	stx		$d021
	stx		$d020

	rts

;------------------------------
; Fill horiz. line subr.
;------------------------------

fill_h_line

	from	= $fb
	to		= $fc
	color	= $fd
	region	= $fe

    ldx		from

fill_h_line_loop
	lda		#$e0

	ldy		region
	cpy		#$00
	beq		fill_h_line_reg_0

	ldy		region
	cpy		#$01
	beq		fill_h_line_reg_1

	ldy		region
	cpy		#$02
	beq		fill_h_line_reg_2

	ldy		region
	cpy		#$03
	beq		fill_h_line_reg_3

fill_h_line_reg_0
	sta		screen_mem_start_0,x
	lda		color
	sta		color_mem_start_0,x
	jmp		fill_h_line_loop_continue

fill_h_line_reg_1
	sta		screen_mem_start_1,x
	lda		color
	sta		color_mem_start_1,x
	jmp		fill_h_line_loop_continue

fill_h_line_reg_2
	sta		screen_mem_start_2,x
	lda		color
	sta		color_mem_start_2,x
	jmp		fill_h_line_loop_continue

fill_h_line_reg_3
	sta		screen_mem_start_3,x
	lda		color
	sta		color_mem_start_3,x
	jmp		fill_h_line_loop_continue

fill_h_line_loop_continue
    inx
    cpx		to
    bne		fill_h_line_loop

	rts

;------------------------------
; macro for output row
;------------------------------

!macro output_row .from, .to, .color, .region {
	lda		#.from
	sta		from
	lda		#.to
	sta		to
	lda		#.color
	sta		color
	lda		#.region
	sta		region
	jsr		fill_h_line
}

;------------------------------
; macro for output char
;------------------------------

!macro output_char .ch, .chmem, .colmem {
	lda		#.ch
	sta		.chmem
	lda		#col_white
	sta		.colmem
}

;------------------------------
; Main subroutine:
;------------------------------	

main

	jsr		init_screen

	;; row 1
	+output_row $00, $06, col_black, $00

	+output_row $06, $0a, col_white, $00
	+output_row $0a, $0e, col_yellow, $00
	+output_row $0e, $12, col_orange, $00
	+output_row $12, $16, col_red, $00
	+output_row $16, $1a, col_purple, $00
	+output_row $1a, $1e, col_blue, $00
	+output_row $1e, $22, col_light_green, $00

	+output_row $22, $28, col_black, $00

	;; row 2
	+output_row $28, $2e, col_black, $00

	+output_row $2e, $32, col_white, $00
	+output_row $32, $36, col_yellow, $00
	+output_row $36, $3a, col_orange, $00
	+output_row $3a, $3e, col_red, $00
	+output_row $3e, $42, col_purple, $00
	+output_row $42, $46, col_blue, $00
	+output_row $46, $4a, col_light_green, $00

	+output_row $4a, $50, col_black, $00

	;; row 3
	+output_row $50, $56, col_black, $00

	+output_row $56, $5a, col_white, $00
	+output_row $5a, $5e, col_yellow, $00
	+output_row $5e, $62, col_orange, $00
	+output_row $62, $66, col_red, $00
	+output_row $66, $6a, col_purple, $00
	+output_row $6a, $6e, col_blue, $00
	+output_row $6e, $72, col_light_green, $00

	+output_row $72, $78, col_black, $00

	;; row 4
	+output_row $78, $7e, col_black, $00

	+output_row $7e, $82, col_light_green, $00
	+output_row $82, $86, col_white, $00
	+output_row $86, $8a, col_yellow, $00
	+output_row $8a, $8e, col_orange, $00
	+output_row $8e, $92, col_red, $00
	+output_row $92, $96, col_purple, $00
	+output_row $96, $9a, col_blue, $00

	+output_row $9a, $a0, col_black, $00

	;; row 5
	+output_row $a0, $a6, col_black, $00

	+output_row $a6, $aa, col_light_green, $00
	+output_row $aa, $ae, col_white, $00
	+output_row $ae, $b2, col_yellow, $00
	+output_row $b2, $b6, col_orange, $00
	+output_row $b6, $ba, col_red, $00
	+output_row $ba, $be, col_purple, $00
	+output_row $be, $c2, col_blue, $00

	+output_row $c2, $c8, col_black, $00

	;; row 6
	+output_row $c8, $ce, col_black, $00

	+output_row $ce, $d2, col_light_green, $00
	+output_row $d2, $d6, col_white, $00
	+output_row $d6, $da, col_yellow, $00
	+output_row $da, $de, col_orange, $00
	+output_row $de, $e2, col_red, $00
	+output_row $e2, $e6, col_purple, $00
	+output_row $e6, $ea, col_blue, $00

	+output_row $ea, $f0, col_black, $00

	;; row 7
	+output_row $f0, $f6, col_black, $00

	+output_row $f6, $fa, col_blue, $00
	+output_row $fa, $fe, col_light_green, $00

	+output_row $fe, $ff, col_white, $00
	+output_row $ff, $00, col_white, $00 ; end region 0
	+output_row $00, $02, col_white, $01 ; begin region 1

	+output_row $02, $06, col_yellow, $01
	+output_row $06, $0a, col_orange, $01
	+output_row $0a, $0e, col_red, $01
	+output_row $0e, $12, col_purple, $01

	+output_row $12, $18, col_black, $01

	;; row 8
	+output_row $18, $1e, col_black, $01

	+output_row $1e, $22, col_blue, $01
	+output_row $22, $26, col_light_green, $01
	+output_row $26, $2a, col_white, $01
	+output_row $2a, $2e, col_yellow, $01
	+output_row $2e, $32, col_orange, $01
	+output_row $32, $36, col_red, $01
	+output_row $36, $3a, col_purple, $01

	+output_row $3a, $40, col_black, $01

	;; row 9
	+output_row $40, $46, col_black, $01

	+output_row $46, $4a, col_blue, $01
	+output_row $4a, $4e, col_light_green, $01
	+output_row $4e, $52, col_white, $01
	+output_row $52, $56, col_yellow, $01
	+output_row $56, $5a, col_orange, $01
	+output_row $5a, $5e, col_red, $01
	+output_row $5e, $62, col_purple, $01

	+output_row $62, $68, col_black, $01

	;; row 10
	+output_row $68, $6e, col_black, $01

	+output_row $6e, $72, col_purple, $01
	+output_row $72, $76, col_blue, $01
	+output_row $76, $7a, col_light_green, $01
	+output_row $7a, $7e, col_white, $01
	+output_row $7e, $82, col_yellow, $01
	+output_row $82, $86, col_orange, $01
	+output_row $86, $8a, col_red, $01

	+output_row $8a, $90, col_black, $01

	;; row 11
	+output_row $90, $96, col_black, $01

	+output_row $96, $9a, col_purple, $01
	+output_row $9a, $9e, col_blue, $01
	+output_row $9e, $a2, col_light_green, $01
	+output_row $a2, $a6, col_white, $01
	+output_row $a6, $aa, col_yellow, $01
	+output_row $aa, $ae, col_orange, $01
	+output_row $ae, $b2, col_red, $01

	+output_row $b2, $b8, col_black, $01

	;; row 12
	+output_row $b8, $be, col_black, $01

	+output_row $be, $c2, col_purple, $01
	+output_row $c2, $c6, col_blue, $01
	+output_row $c6, $ca, col_light_green, $01
	+output_row $ca, $ce, col_white, $01
	+output_row $ce, $d2, col_yellow, $01
	+output_row $d2, $d6, col_orange, $01
	+output_row $d6, $da, col_red, $01

	+output_row $da, $e0, col_black, $01

	;; row 13
	+output_row $e0, $e6, col_black, $01

	+output_row $e6, $ea, col_red, $01
	+output_row $ea, $ee, col_purple, $01
	+output_row $ee, $f2, col_blue, $01
	+output_row $f2, $f6, col_light_green, $01
	+output_row $f6, $fa, col_white, $01
	+output_row $fa, $fe, col_yellow, $01

	+output_row $fe, $ff, col_orange, $01
	+output_row $ff, $00, col_orange, $01 ; end region 1
	+output_row $00, $02, col_orange, $02 ; begin region 2

	+output_row $02, $08, col_black, $02

	;; row 14
	+output_row $08, $0e, col_black, $02

	+output_row $0e, $12, col_red, $02
	+output_row $12, $16, col_purple, $02
	+output_row $16, $1a, col_blue, $02
	+output_row $1a, $1e, col_light_green, $02
	+output_row $1e, $22, col_white, $02
	+output_row $22, $26, col_yellow, $02
	+output_row $26, $2a, col_orange, $02

	+output_row $2a, $30, col_black, $02
	
	;; row 15
	+output_row $30, $36, col_black, $02

	+output_row $36, $3a, col_red, $02
	+output_row $3a, $3e, col_purple, $02
	+output_row $3e, $42, col_blue, $02
	+output_row $42, $46, col_light_green, $02
	+output_row $46, $4a, col_white, $02
	+output_row $4a, $4e, col_yellow, $02
	+output_row $4e, $52, col_orange, $02

	+output_row $52, $58, col_black, $02

	;; row 16
	+output_row $58, $5e, col_black, $02

	+output_row $5e, $62, col_orange, $02
	+output_row $62, $66, col_red, $02
	+output_row $66, $6a, col_purple, $02
	+output_row $6a, $6e, col_blue, $02
	+output_row $6e, $72, col_light_green, $02
	+output_row $72, $76, col_white, $02
	+output_row $76, $7a, col_yellow, $02

	+output_row $7a, $80, col_black, $02

	;; row 17
	+output_row $80, $86, col_black, $02

	+output_row $86, $8a, col_orange, $02
	+output_row $8a, $8e, col_red, $02
	+output_row $8e, $92, col_purple, $02
	+output_row $92, $96, col_blue, $02
	+output_row $96, $9a, col_light_green, $02
	+output_row $9a, $9e, col_white, $02
	+output_row $9e, $a2, col_yellow, $02

	+output_row $a2, $a8, col_black, $02
	
	;; row 18
	+output_row $a8, $ae, col_black, $02

	+output_row $ae, $b2, col_orange, $02
	+output_row $b2, $b6, col_red, $02
	+output_row $b6, $ba, col_purple, $02
	+output_row $ba, $be, col_blue, $02
	+output_row $be, $c2, col_light_green, $02
	+output_row $c2, $c6, col_white, $02
	+output_row $c6, $ca, col_yellow, $02

	+output_row $ca, $d0, col_black, $02

	;; row 19
	+output_row $d0, $d6, col_black, $02

	+output_row $d6, $da, col_yellow, $02
	+output_row $da, $de, col_orange, $02
	+output_row $de, $e2, col_red, $02
	+output_row $e2, $e6, col_purple, $02
	+output_row $e6, $ea, col_blue, $02
	+output_row $ea, $ee, col_light_green, $02
	+output_row $ee, $f2, col_white, $02

	+output_row $f2, $f8, col_black, $02

	;; row 20
	+output_row $f8, $fe, col_black, $02

	+output_row $fe, $ff, col_yellow, $02
	+output_row $ff, $00, col_yellow, $02 ; end region 2
	+output_row $00, $02, col_yellow, $03 ; begin region 3

	+output_row $02, $06, col_orange, $03
	+output_row $06, $0a, col_red, $03
	+output_row $0a, $0e, col_purple, $03
	+output_row $0e, $12, col_blue, $03
	+output_row $12, $16, col_light_green, $03
	+output_row $16, $1a, col_white, $03

	+output_row $1a, $20, col_black, $03

	;; row 21
	+output_row $20, $26, col_black, $03

	+output_row $26, $2a, col_yellow, $03
	+output_row $2a, $2e, col_orange, $03
	+output_row $2e, $32, col_red, $03
	+output_row $32, $36, col_purple, $03
	+output_row $36, $3a, col_blue, $03
	+output_row $3a, $3e, col_light_green, $03
	+output_row $3e, $42, col_white, $03

	+output_row $42, $48, col_black, $03

	;; row 22
	+output_row $48, $70, col_black, $03
	;; row 23
	+output_row $70, $98, col_black, $03
	;; row 24
	+output_row $98, $c0, col_black, $03

	+output_char $0b, $079f, $db9f		; K
	+output_char $05, $07a0, $dba0		; E
	+output_char $09, $07a1, $dba1		; I
	+output_char $0e, $07a2, $dba2		; N

	+output_char $0d, $07a5, $dba5		; M
	+output_char $05, $07a6, $dba6		; E
	+output_char $0e, $07a7, $dba7		; N
	+output_char $13, $07a8, $dba8		; S
	+output_char $03, $07a9, $dba9		; C
	+output_char $08, $07aa, $dbaa		; H

	+output_char $09, $07ad, $dbad		; I
	+output_char $13, $07ae, $dbae		; S
	+output_char $14, $07af, $dbaf		; T

	+output_char $09, $07b2, $dbb2		; I
	+output_char $0c, $07b3, $dbb3		; L
	+output_char $0c, $07b4, $dbb4		; L
	+output_char $05, $07b5, $dbb5		; E
	+output_char $07, $07b6, $dbb6		; G
	+output_char $01, $07b7, $dbb7		; A
	+output_char $0c, $07b8, $dbb8		; L

	;; row 25
	+output_row $c0, $e8, col_black, $03

loop_forever
	jmp loop_forever

	rts

			  
