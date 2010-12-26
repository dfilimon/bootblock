
BOOT_SEGMENT    equ     07c0h
DISPLAY_SEGMENT equ     0b800h

segment .text
        global _start
bits 16                         ; real mode? 16bit
        
;; _start must be here! linker expects to find it
        
_start:
        jmp     over

        os_size dw 0, 0         

        ;; Over prints a single character to the screen

over:  

        ;; Setting the video mode to VGA 320x200 256 colors
        mov     ah, 0ah
        mov     al, 'a'
        int     10h
        jmp     forever

        ;; Draw the square
        mov     ah, 0ch
        mov     al, 50

        ;; Start drawing
        ;; indices
start_drawing:  
        mov     cx, 0           ; x coord
        mov     dx, 0           ; y coord

pixel_loop:
        int     10h
        inc     cx
        cmp     cx, 50
        jl     next_line
        jmp     pixel_loop

next_line:        
        inc     dx
        mov     cx, 0           ; for a new line, x = 0
        cmp     dx, 50          ; if we reached the end of our rectangle
        jl     start_drawing
        jmp     pixel_loop

forever:
        hlt
        jmp     forever
        


;; creste_linia:
;;     incw    %dx
;;     movw    $0, %cx
;;     cmpw    $50,%dx
;;     jge     start_drawing
;;     jmp     forever

;; forever: 
;;     # Loop forever
;;     hlt
;;     jmp     forever

