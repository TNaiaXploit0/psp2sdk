OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)

ENTRY(module_info)

module_start = DEFINED(module_start) ? module_start : 0;
module_stop = DEFINED(module_stop) ? module_stop : 0;

PHDRS
{
	text PT_LOAD FLAGS(5);
	data PT_LOAD FLAGS(6);
	rela 0x60000000;
}

SECTIONS
{
	.text : { *(.text) } :text
	.sceStub.text : { *(.sceStub.text.*) } :text

	.sceModuleInfo.rodata : { *(.sceModuleInfo.rodata) } :text

	.sceLib.ent : { *(.sceLib.ent) } :text
	.sceLib.stub : { *(.sceLib.stub) } :text

	.sceExport.rodata : { *(.sceExport.rodata) } :text
	.sceImport.rodata : { *(.sceImport.rodata) } :text

	.sceFNID.rodata : { KEEP(*(.sceFNID.rodata)) } :text
	.sceVNID.rodata : { KEEP(*(.sceVNID.rodata)) } :text

	.sceFStub.rodata : { KEEP(*(.sceFStub.rodata)) } :text
	.sceVStub.rodata : { KEEP(*(.sceVStub.rodata)) } :text

	.rodata : { *(.rodata) } :text

	.ARM.extab : { *(.ARM.extab* .gnu.linkonce.armextab.*) } :text

	.ARM.exidx :
	{
		PROVIDE_HIDDEN (__exidx_start = .);
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		PROVIDE_HIDDEN (__exidx_end = .);
	} :text

	.ctors :
	{
		KEEP(*ctrbegin.o(.ctors))
		KEEP(*ctrbegin?.o(.ctors))
		*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors)
		*(SORT(.ctors.*))
		*(.ctors)
	} :text

	.dtors :
	{
		KEEP(*crtbegin.o(.dtors))
		KEEP(*crtbegin?.o(.dtors))
		*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors)
		*(SORT(.dtors.*))
		*(.dtors)
	} :text

	.data : { *(.data) } :data
	.bss : { *(.bss) } :data

	.rel.text : { *(.rel.text) } :rela
	.rel.sceModuleInfo.rodata : { *(.rel.sceModuleInfo.rodata) } :rela

	.rel.sceLib.ent : { *(.rel.sceLib.ent) } :rela
	.rel.sceLib.stub : {
		*(.rel.sceLib.stub)
		. = .;
	} :rela

	.rel.sceExport.rodata : { *(rel.sceExport.rodata) } :rela
	.rel.sceFStub.rodata :
	{
		*(.rel.sceFStub.rodata)
		. = .;
	} :rela

	.rel.sceVStub.rodata :
	{
		*(.rel.sceVStub.rodata)
		. = .;
	} :rela

	.rel.rodata : { *(.rel.rodata) } :rela

	.rel.data : { *(.rel.data) } :rela

	.sce_libgen_mark : { KEEP(*(.sce_libgen_mark)) }
	.rel.sce_libgen_mark (NOLOAD) : { KEEP(*(.rel.sce_libgen_mark)) }
}
