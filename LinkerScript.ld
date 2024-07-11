


/* End of stack Address */
_estack = ORIGIN(RAM) + LENGTH(RAM) ;

/* Minimum amount of stack and heap to avoid allocate .data section on them */
_Min_Heap_Size  = 0X200 ;
_Min_Stack_Size = 0X400 ;


MEMORY
{
    CCMRAM    (xrw)  :  ORIGIN  =  0x10000000   ,  LENGTH  =  64k
    RAM       (xrw)  :  ORIGIN  =  0x20000000   ,  LENGTH  =  128k
    FLASH     (rx)   :  ORIGIN  =  0x80000000   ,  LENGTH  =  1024k
}

SECTIONS
{
/*Create section for vector table at start of Flash */    
    .isr_vector :
    {
        . = ALIGN(4) ;
        *(.isr_vector)
        *(.isr_vector*)
        . = ALIGN(4) ;
    } >FLASH


    .text :
    {
        . = ALIGN(4) ;
        *(.text)
        *(.text*)
        . = ALIGN(4) ;
        _etext = . ;
    } >FLASH

    .rodata :
    {
        . = ALIGN(4) ;
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4) ;
    } >FLASH

    /* Used by Startup code to intialize data segment from start of Flash data segment  */
    _sidata = LOADADDR(.data) ;                   

    .data :
    {
        . = ALIGN(4) ;
        _sdata = . ;
        *(.data)
        *(.data*)
        . = ALIGN(4) ;
        _edata = . ;
    } >RAM AT>FLASH

    .bss :
    {
        _sbss = . ;
        *(.bss)
        *(.bss*)
        . = ALIGN(4) ;
        _ebss = . ;
    } >RAM

    .heap :
    {
        _sheap = . ;
        . = ALIGN(4) ;
        *(.heap)
        *(.heap*)
        . = ALIGN(4) ;
        _eheap = . ;
    } >RAM
}