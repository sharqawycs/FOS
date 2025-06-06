
obj/user/tst_buffer_1:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 7f 05 00 00       	call   8005b5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define arrSize PAGE_SIZE*8 / 4
int src[arrSize];
int dst[arrSize];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 58             	sub    $0x58,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80004e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 80 1f 80 00       	push   $0x801f80
  800065:	6a 16                	push   $0x16
  800067:	68 c8 1f 80 00       	push   $0x801fc8
  80006c:	e8 46 06 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800084:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 80 1f 80 00       	push   $0x801f80
  80009b:	6a 17                	push   $0x17
  80009d:	68 c8 1f 80 00       	push   $0x801fc8
  8000a2:	e8 10 06 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 80 1f 80 00       	push   $0x801f80
  8000d1:	6a 18                	push   $0x18
  8000d3:	68 c8 1f 80 00       	push   $0x801fc8
  8000d8:	e8 da 05 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 80 1f 80 00       	push   $0x801f80
  800107:	6a 19                	push   $0x19
  800109:	68 c8 1f 80 00       	push   $0x801fc8
  80010e:	e8 a4 05 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800126:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 80 1f 80 00       	push   $0x801f80
  80013d:	6a 1a                	push   $0x1a
  80013f:	68 c8 1f 80 00       	push   $0x801fc8
  800144:	e8 6e 05 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 80 1f 80 00       	push   $0x801f80
  800173:	6a 1b                	push   $0x1b
  800175:	68 c8 1f 80 00       	push   $0x801fc8
  80017a:	e8 38 05 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800192:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 80 1f 80 00       	push   $0x801f80
  8001a9:	6a 1c                	push   $0x1c
  8001ab:	68 c8 1f 80 00       	push   $0x801fc8
  8001b0:	e8 02 05 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001c8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 80 1f 80 00       	push   $0x801f80
  8001df:	6a 1d                	push   $0x1d
  8001e1:	68 c8 1f 80 00       	push   $0x801fc8
  8001e6:	e8 cc 04 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001fe:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 80 1f 80 00       	push   $0x801f80
  800215:	6a 1e                	push   $0x1e
  800217:	68 c8 1f 80 00       	push   $0x801fc8
  80021c:	e8 96 04 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800234:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 80 1f 80 00       	push   $0x801f80
  80024b:	6a 1f                	push   $0x1f
  80024d:	68 c8 1f 80 00       	push   $0x801fc8
  800252:	e8 60 04 00 00       	call   8006b7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80026a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 80 1f 80 00       	push   $0x801f80
  800281:	6a 20                	push   $0x20
  800283:	68 c8 1f 80 00       	push   $0x801fc8
  800288:	e8 2a 04 00 00       	call   8006b7 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 dc 1f 80 00       	push   $0x801fdc
  8002a4:	6a 21                	push   $0x21
  8002a6:	68 c8 1f 80 00       	push   $0x801fc8
  8002ab:	e8 07 04 00 00       	call   8006b7 <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b0:	e8 c5 15 00 00       	call   80187a <sys_calculate_modified_frames>
  8002b5:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002b8:	e8 d6 15 00 00       	call   801893 <sys_calculate_notmod_frames>
  8002bd:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c0:	e8 1f 16 00 00       	call   8018e4 <sys_pf_calculate_allocated_pages>
  8002c5:	89 45 a8             	mov    %eax,-0x58(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	//cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
	int dummy = 0;
  8002d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  8002dd:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8002e4:	eb 33                	jmp    800319 <_main+0x2e1>
	{
		dst[i] = i;
  8002e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002ec:	89 14 85 40 30 80 00 	mov    %edx,0x803040(,%eax,4)
		dstSum1 += i;
  8002f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f6:	01 45 f0             	add    %eax,-0x10(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8002f9:	e8 95 15 00 00       	call   801893 <sys_calculate_notmod_frames>
  8002fe:	89 c2                	mov    %eax,%edx
  800300:	a1 20 30 80 00       	mov    0x803020,%eax
  800305:	8b 40 4c             	mov    0x4c(%eax),%eax
  800308:	01 c2                	add    %eax,%edx
  80030a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80030d:	01 d0                	add    %edx,%eax
  80030f:	89 45 ec             	mov    %eax,-0x14(%ebp)
	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
	int dstSum1 = 0;
	//cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  800312:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800319:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800320:	7e c4                	jle    8002e6 <_main+0x2ae>
		dstSum1 += i;
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}


	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800322:	e8 6c 15 00 00       	call   801893 <sys_calculate_notmod_frames>
  800327:	89 c2                	mov    %eax,%edx
  800329:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80032c:	29 c2                	sub    %eax,%edx
  80032e:	89 d0                	mov    %edx,%eax
  800330:	83 f8 07             	cmp    $0x7,%eax
  800333:	74 14                	je     800349 <_main+0x311>
  800335:	83 ec 04             	sub    $0x4,%esp
  800338:	68 2c 20 80 00       	push   $0x80202c
  80033d:	6a 35                	push   $0x35
  80033f:	68 c8 1f 80 00       	push   $0x801fc8
  800344:	e8 6e 03 00 00       	call   8006b7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800349:	e8 2c 15 00 00       	call   80187a <sys_calculate_modified_frames>
  80034e:	89 c2                	mov    %eax,%edx
  800350:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	74 14                	je     80036b <_main+0x333>
  800357:	83 ec 04             	sub    $0x4,%esp
  80035a:	68 90 20 80 00       	push   $0x802090
  80035f:	6a 36                	push   $0x36
  800361:	68 c8 1f 80 00       	push   $0x801fc8
  800366:	e8 4c 03 00 00       	call   8006b7 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  80036b:	e8 23 15 00 00       	call   801893 <sys_calculate_notmod_frames>
  800370:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800373:	e8 02 15 00 00       	call   80187a <sys_calculate_modified_frames>
  800378:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
  80037b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	i = PAGE_SIZE/4;
  800382:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	for(;i<arrSize;i+=PAGE_SIZE/4)
  800389:	eb 2d                	jmp    8003b8 <_main+0x380>
	{
		srcSum1 += src[i];
  80038b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80038e:	8b 04 85 60 b0 80 00 	mov    0x80b060(,%eax,4),%eax
  800395:	01 45 e8             	add    %eax,-0x18(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  800398:	e8 f6 14 00 00       	call   801893 <sys_calculate_notmod_frames>
  80039d:	89 c2                	mov    %eax,%edx
  80039f:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a4:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003a7:	01 c2                	add    %eax,%edx
  8003a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003ac:	01 d0                	add    %edx,%eax
  8003ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
	i = PAGE_SIZE/4;
	for(;i<arrSize;i+=PAGE_SIZE/4)
  8003b1:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  8003b8:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  8003bf:	7e ca                	jle    80038b <_main+0x353>
		srcSum1 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c1:	e8 cd 14 00 00       	call   801893 <sys_calculate_notmod_frames>
  8003c6:	89 c2                	mov    %eax,%edx
  8003c8:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003cb:	39 c2                	cmp    %eax,%edx
  8003cd:	74 14                	je     8003e3 <_main+0x3ab>
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	68 2c 20 80 00       	push   $0x80202c
  8003d7:	6a 45                	push   $0x45
  8003d9:	68 c8 1f 80 00       	push   $0x801fc8
  8003de:	e8 d4 02 00 00       	call   8006b7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003e3:	e8 92 14 00 00       	call   80187a <sys_calculate_modified_frames>
  8003e8:	89 c2                	mov    %eax,%edx
  8003ea:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003ed:	29 c2                	sub    %eax,%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	83 f8 07             	cmp    $0x7,%eax
  8003f4:	74 14                	je     80040a <_main+0x3d2>
  8003f6:	83 ec 04             	sub    $0x4,%esp
  8003f9:	68 90 20 80 00       	push   $0x802090
  8003fe:	6a 46                	push   $0x46
  800400:	68 c8 1f 80 00       	push   $0x801fc8
  800405:	e8 ad 02 00 00       	call   8006b7 <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  80040a:	e8 84 14 00 00       	call   801893 <sys_calculate_notmod_frames>
  80040f:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800412:	e8 63 14 00 00       	call   80187a <sys_calculate_modified_frames>
  800417:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
	i = 0;
  80041a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum2 = 0 ;
  800421:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800428:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  80042f:	eb 2d                	jmp    80045e <_main+0x426>
	{
		dstSum2 += dst[i];
  800431:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800434:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  80043b:	01 45 e4             	add    %eax,-0x1c(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  80043e:	e8 50 14 00 00       	call   801893 <sys_calculate_notmod_frames>
  800443:	89 c2                	mov    %eax,%edx
  800445:	a1 20 30 80 00       	mov    0x803020,%eax
  80044a:	8b 40 4c             	mov    0x4c(%eax),%eax
  80044d:	01 c2                	add    %eax,%edx
  80044f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800452:	01 d0                	add    %edx,%eax
  800454:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800457:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80045e:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800465:	7e ca                	jle    800431 <_main+0x3f9>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800467:	e8 27 14 00 00       	call   801893 <sys_calculate_notmod_frames>
  80046c:	89 c2                	mov    %eax,%edx
  80046e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800471:	29 c2                	sub    %eax,%edx
  800473:	89 d0                	mov    %edx,%eax
  800475:	83 f8 07             	cmp    $0x7,%eax
  800478:	74 14                	je     80048e <_main+0x456>
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	68 2c 20 80 00       	push   $0x80202c
  800482:	6a 53                	push   $0x53
  800484:	68 c8 1f 80 00       	push   $0x801fc8
  800489:	e8 29 02 00 00       	call   8006b7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80048e:	e8 e7 13 00 00       	call   80187a <sys_calculate_modified_frames>
  800493:	89 c2                	mov    %eax,%edx
  800495:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800498:	29 c2                	sub    %eax,%edx
  80049a:	89 d0                	mov    %edx,%eax
  80049c:	83 f8 f9             	cmp    $0xfffffff9,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 90 20 80 00       	push   $0x802090
  8004a9:	6a 54                	push   $0x54
  8004ab:	68 c8 1f 80 00       	push   $0x801fc8
  8004b0:	e8 02 02 00 00       	call   8006b7 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004b5:	e8 d9 13 00 00       	call   801893 <sys_calculate_notmod_frames>
  8004ba:	89 45 ac             	mov    %eax,-0x54(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004bd:	e8 b8 13 00 00       	call   80187a <sys_calculate_modified_frames>
  8004c2:	89 45 b0             	mov    %eax,-0x50(%ebp)

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
  8004c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int srcSum2 = 0 ;
  8004cc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  8004d3:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8004da:	eb 2d                	jmp    800509 <_main+0x4d1>
	{
		srcSum2 += src[i];
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	8b 04 85 60 b0 80 00 	mov    0x80b060(,%eax,4),%eax
  8004e6:	01 45 e0             	add    %eax,-0x20(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8004e9:	e8 a5 13 00 00       	call   801893 <sys_calculate_notmod_frames>
  8004ee:	89 c2                	mov    %eax,%edx
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8b 40 4c             	mov    0x4c(%eax),%eax
  8004f8:	01 c2                	add    %eax,%edx
  8004fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004fd:	01 d0                	add    %edx,%eax
  8004ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
	int srcSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800502:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800509:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800510:	7e ca                	jle    8004dc <_main+0x4a4>
	{
		srcSum2 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800512:	e8 7c 13 00 00       	call   801893 <sys_calculate_notmod_frames>
  800517:	89 c2                	mov    %eax,%edx
  800519:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80051c:	29 c2                	sub    %eax,%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	83 f8 f9             	cmp    $0xfffffff9,%eax
  800523:	74 14                	je     800539 <_main+0x501>
  800525:	83 ec 04             	sub    $0x4,%esp
  800528:	68 2c 20 80 00       	push   $0x80202c
  80052d:	6a 62                	push   $0x62
  80052f:	68 c8 1f 80 00       	push   $0x801fc8
  800534:	e8 7e 01 00 00       	call   8006b7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800539:	e8 3c 13 00 00       	call   80187a <sys_calculate_modified_frames>
  80053e:	89 c2                	mov    %eax,%edx
  800540:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800543:	29 c2                	sub    %eax,%edx
  800545:	89 d0                	mov    %edx,%eax
  800547:	83 f8 07             	cmp    $0x7,%eax
  80054a:	74 14                	je     800560 <_main+0x528>
  80054c:	83 ec 04             	sub    $0x4,%esp
  80054f:	68 90 20 80 00       	push   $0x802090
  800554:	6a 63                	push   $0x63
  800556:	68 c8 1f 80 00       	push   $0x801fc8
  80055b:	e8 57 01 00 00       	call   8006b7 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800560:	e8 7f 13 00 00       	call   8018e4 <sys_pf_calculate_allocated_pages>
  800565:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 fc 20 80 00       	push   $0x8020fc
  800572:	6a 65                	push   $0x65
  800574:	68 c8 1f 80 00       	push   $0x801fc8
  800579:	e8 39 01 00 00       	call   8006b7 <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  80057e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800581:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800584:	75 08                	jne    80058e <_main+0x556>
  800586:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800589:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80058c:	74 14                	je     8005a2 <_main+0x56a>
  80058e:	83 ec 04             	sub    $0x4,%esp
  800591:	68 6c 21 80 00       	push   $0x80216c
  800596:	6a 67                	push   $0x67
  800598:	68 c8 1f 80 00       	push   $0x801fc8
  80059d:	e8 15 01 00 00       	call   8006b7 <_panic>

	cprintf("Congratulations!! test buffered pages inside REPLACEMENT is completed successfully.\n");
  8005a2:	83 ec 0c             	sub    $0xc,%esp
  8005a5:	68 a8 21 80 00       	push   $0x8021a8
  8005aa:	e8 bc 03 00 00       	call   80096b <cprintf>
  8005af:	83 c4 10             	add    $0x10,%esp
	return;
  8005b2:	90                   	nop

}
  8005b3:	c9                   	leave  
  8005b4:	c3                   	ret    

008005b5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005b5:	55                   	push   %ebp
  8005b6:	89 e5                	mov    %esp,%ebp
  8005b8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005bb:	e8 d6 11 00 00       	call   801796 <sys_getenvindex>
  8005c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005c6:	89 d0                	mov    %edx,%eax
  8005c8:	01 c0                	add    %eax,%eax
  8005ca:	01 d0                	add    %edx,%eax
  8005cc:	c1 e0 02             	shl    $0x2,%eax
  8005cf:	01 d0                	add    %edx,%eax
  8005d1:	c1 e0 06             	shl    $0x6,%eax
  8005d4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005d9:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005de:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e3:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005e9:	84 c0                	test   %al,%al
  8005eb:	74 0f                	je     8005fc <libmain+0x47>
		binaryname = myEnv->prog_name;
  8005ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f2:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005f7:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005fc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800600:	7e 0a                	jle    80060c <libmain+0x57>
		binaryname = argv[0];
  800602:	8b 45 0c             	mov    0xc(%ebp),%eax
  800605:	8b 00                	mov    (%eax),%eax
  800607:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80060c:	83 ec 08             	sub    $0x8,%esp
  80060f:	ff 75 0c             	pushl  0xc(%ebp)
  800612:	ff 75 08             	pushl  0x8(%ebp)
  800615:	e8 1e fa ff ff       	call   800038 <_main>
  80061a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80061d:	e8 0f 13 00 00       	call   801931 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800622:	83 ec 0c             	sub    $0xc,%esp
  800625:	68 18 22 80 00       	push   $0x802218
  80062a:	e8 3c 03 00 00       	call   80096b <cprintf>
  80062f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800632:	a1 20 30 80 00       	mov    0x803020,%eax
  800637:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80063d:	a1 20 30 80 00       	mov    0x803020,%eax
  800642:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800648:	83 ec 04             	sub    $0x4,%esp
  80064b:	52                   	push   %edx
  80064c:	50                   	push   %eax
  80064d:	68 40 22 80 00       	push   $0x802240
  800652:	e8 14 03 00 00       	call   80096b <cprintf>
  800657:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80065a:	a1 20 30 80 00       	mov    0x803020,%eax
  80065f:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800665:	83 ec 08             	sub    $0x8,%esp
  800668:	50                   	push   %eax
  800669:	68 65 22 80 00       	push   $0x802265
  80066e:	e8 f8 02 00 00       	call   80096b <cprintf>
  800673:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800676:	83 ec 0c             	sub    $0xc,%esp
  800679:	68 18 22 80 00       	push   $0x802218
  80067e:	e8 e8 02 00 00       	call   80096b <cprintf>
  800683:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800686:	e8 c0 12 00 00       	call   80194b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80068b:	e8 19 00 00 00       	call   8006a9 <exit>
}
  800690:	90                   	nop
  800691:	c9                   	leave  
  800692:	c3                   	ret    

00800693 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800693:	55                   	push   %ebp
  800694:	89 e5                	mov    %esp,%ebp
  800696:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800699:	83 ec 0c             	sub    $0xc,%esp
  80069c:	6a 00                	push   $0x0
  80069e:	e8 bf 10 00 00       	call   801762 <sys_env_destroy>
  8006a3:	83 c4 10             	add    $0x10,%esp
}
  8006a6:	90                   	nop
  8006a7:	c9                   	leave  
  8006a8:	c3                   	ret    

008006a9 <exit>:

void
exit(void)
{
  8006a9:	55                   	push   %ebp
  8006aa:	89 e5                	mov    %esp,%ebp
  8006ac:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006af:	e8 14 11 00 00       	call   8017c8 <sys_env_exit>
}
  8006b4:	90                   	nop
  8006b5:	c9                   	leave  
  8006b6:	c3                   	ret    

008006b7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006b7:	55                   	push   %ebp
  8006b8:	89 e5                	mov    %esp,%ebp
  8006ba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006bd:	8d 45 10             	lea    0x10(%ebp),%eax
  8006c0:	83 c0 04             	add    $0x4,%eax
  8006c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006c6:	a1 64 30 81 00       	mov    0x813064,%eax
  8006cb:	85 c0                	test   %eax,%eax
  8006cd:	74 16                	je     8006e5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006cf:	a1 64 30 81 00       	mov    0x813064,%eax
  8006d4:	83 ec 08             	sub    $0x8,%esp
  8006d7:	50                   	push   %eax
  8006d8:	68 7c 22 80 00       	push   $0x80227c
  8006dd:	e8 89 02 00 00       	call   80096b <cprintf>
  8006e2:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006e5:	a1 00 30 80 00       	mov    0x803000,%eax
  8006ea:	ff 75 0c             	pushl  0xc(%ebp)
  8006ed:	ff 75 08             	pushl  0x8(%ebp)
  8006f0:	50                   	push   %eax
  8006f1:	68 81 22 80 00       	push   $0x802281
  8006f6:	e8 70 02 00 00       	call   80096b <cprintf>
  8006fb:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 f4             	pushl  -0xc(%ebp)
  800707:	50                   	push   %eax
  800708:	e8 f3 01 00 00       	call   800900 <vcprintf>
  80070d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800710:	83 ec 08             	sub    $0x8,%esp
  800713:	6a 00                	push   $0x0
  800715:	68 9d 22 80 00       	push   $0x80229d
  80071a:	e8 e1 01 00 00       	call   800900 <vcprintf>
  80071f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800722:	e8 82 ff ff ff       	call   8006a9 <exit>

	// should not return here
	while (1) ;
  800727:	eb fe                	jmp    800727 <_panic+0x70>

00800729 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800729:	55                   	push   %ebp
  80072a:	89 e5                	mov    %esp,%ebp
  80072c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80072f:	a1 20 30 80 00       	mov    0x803020,%eax
  800734:	8b 50 74             	mov    0x74(%eax),%edx
  800737:	8b 45 0c             	mov    0xc(%ebp),%eax
  80073a:	39 c2                	cmp    %eax,%edx
  80073c:	74 14                	je     800752 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80073e:	83 ec 04             	sub    $0x4,%esp
  800741:	68 a0 22 80 00       	push   $0x8022a0
  800746:	6a 26                	push   $0x26
  800748:	68 ec 22 80 00       	push   $0x8022ec
  80074d:	e8 65 ff ff ff       	call   8006b7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800752:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800759:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800760:	e9 c2 00 00 00       	jmp    800827 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800765:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800768:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	01 d0                	add    %edx,%eax
  800774:	8b 00                	mov    (%eax),%eax
  800776:	85 c0                	test   %eax,%eax
  800778:	75 08                	jne    800782 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80077a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80077d:	e9 a2 00 00 00       	jmp    800824 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800782:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800789:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800790:	eb 69                	jmp    8007fb <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800792:	a1 20 30 80 00       	mov    0x803020,%eax
  800797:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80079d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007a0:	89 d0                	mov    %edx,%eax
  8007a2:	01 c0                	add    %eax,%eax
  8007a4:	01 d0                	add    %edx,%eax
  8007a6:	c1 e0 02             	shl    $0x2,%eax
  8007a9:	01 c8                	add    %ecx,%eax
  8007ab:	8a 40 04             	mov    0x4(%eax),%al
  8007ae:	84 c0                	test   %al,%al
  8007b0:	75 46                	jne    8007f8 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c0:	89 d0                	mov    %edx,%eax
  8007c2:	01 c0                	add    %eax,%eax
  8007c4:	01 d0                	add    %edx,%eax
  8007c6:	c1 e0 02             	shl    $0x2,%eax
  8007c9:	01 c8                	add    %ecx,%eax
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007d3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007d8:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007dd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e7:	01 c8                	add    %ecx,%eax
  8007e9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007eb:	39 c2                	cmp    %eax,%edx
  8007ed:	75 09                	jne    8007f8 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007ef:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007f6:	eb 12                	jmp    80080a <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f8:	ff 45 e8             	incl   -0x18(%ebp)
  8007fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800800:	8b 50 74             	mov    0x74(%eax),%edx
  800803:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800806:	39 c2                	cmp    %eax,%edx
  800808:	77 88                	ja     800792 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80080a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80080e:	75 14                	jne    800824 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800810:	83 ec 04             	sub    $0x4,%esp
  800813:	68 f8 22 80 00       	push   $0x8022f8
  800818:	6a 3a                	push   $0x3a
  80081a:	68 ec 22 80 00       	push   $0x8022ec
  80081f:	e8 93 fe ff ff       	call   8006b7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800824:	ff 45 f0             	incl   -0x10(%ebp)
  800827:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80082d:	0f 8c 32 ff ff ff    	jl     800765 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800833:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80083a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800841:	eb 26                	jmp    800869 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800843:	a1 20 30 80 00       	mov    0x803020,%eax
  800848:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80084e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800851:	89 d0                	mov    %edx,%eax
  800853:	01 c0                	add    %eax,%eax
  800855:	01 d0                	add    %edx,%eax
  800857:	c1 e0 02             	shl    $0x2,%eax
  80085a:	01 c8                	add    %ecx,%eax
  80085c:	8a 40 04             	mov    0x4(%eax),%al
  80085f:	3c 01                	cmp    $0x1,%al
  800861:	75 03                	jne    800866 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800863:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800866:	ff 45 e0             	incl   -0x20(%ebp)
  800869:	a1 20 30 80 00       	mov    0x803020,%eax
  80086e:	8b 50 74             	mov    0x74(%eax),%edx
  800871:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800874:	39 c2                	cmp    %eax,%edx
  800876:	77 cb                	ja     800843 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800878:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80087b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80087e:	74 14                	je     800894 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800880:	83 ec 04             	sub    $0x4,%esp
  800883:	68 4c 23 80 00       	push   $0x80234c
  800888:	6a 44                	push   $0x44
  80088a:	68 ec 22 80 00       	push   $0x8022ec
  80088f:	e8 23 fe ff ff       	call   8006b7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800894:	90                   	nop
  800895:	c9                   	leave  
  800896:	c3                   	ret    

00800897 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800897:	55                   	push   %ebp
  800898:	89 e5                	mov    %esp,%ebp
  80089a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80089d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a0:	8b 00                	mov    (%eax),%eax
  8008a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a8:	89 0a                	mov    %ecx,(%edx)
  8008aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ad:	88 d1                	mov    %dl,%cl
  8008af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008c0:	75 2c                	jne    8008ee <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008c2:	a0 24 30 80 00       	mov    0x803024,%al
  8008c7:	0f b6 c0             	movzbl %al,%eax
  8008ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cd:	8b 12                	mov    (%edx),%edx
  8008cf:	89 d1                	mov    %edx,%ecx
  8008d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d4:	83 c2 08             	add    $0x8,%edx
  8008d7:	83 ec 04             	sub    $0x4,%esp
  8008da:	50                   	push   %eax
  8008db:	51                   	push   %ecx
  8008dc:	52                   	push   %edx
  8008dd:	e8 3e 0e 00 00       	call   801720 <sys_cputs>
  8008e2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f1:	8b 40 04             	mov    0x4(%eax),%eax
  8008f4:	8d 50 01             	lea    0x1(%eax),%edx
  8008f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fa:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008fd:	90                   	nop
  8008fe:	c9                   	leave  
  8008ff:	c3                   	ret    

00800900 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800900:	55                   	push   %ebp
  800901:	89 e5                	mov    %esp,%ebp
  800903:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800909:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800910:	00 00 00 
	b.cnt = 0;
  800913:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80091a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	ff 75 08             	pushl  0x8(%ebp)
  800923:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800929:	50                   	push   %eax
  80092a:	68 97 08 80 00       	push   $0x800897
  80092f:	e8 11 02 00 00       	call   800b45 <vprintfmt>
  800934:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800937:	a0 24 30 80 00       	mov    0x803024,%al
  80093c:	0f b6 c0             	movzbl %al,%eax
  80093f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800945:	83 ec 04             	sub    $0x4,%esp
  800948:	50                   	push   %eax
  800949:	52                   	push   %edx
  80094a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800950:	83 c0 08             	add    $0x8,%eax
  800953:	50                   	push   %eax
  800954:	e8 c7 0d 00 00       	call   801720 <sys_cputs>
  800959:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80095c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800963:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800969:	c9                   	leave  
  80096a:	c3                   	ret    

0080096b <cprintf>:

int cprintf(const char *fmt, ...) {
  80096b:	55                   	push   %ebp
  80096c:	89 e5                	mov    %esp,%ebp
  80096e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800971:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800978:	8d 45 0c             	lea    0xc(%ebp),%eax
  80097b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80097e:	8b 45 08             	mov    0x8(%ebp),%eax
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 f4             	pushl  -0xc(%ebp)
  800987:	50                   	push   %eax
  800988:	e8 73 ff ff ff       	call   800900 <vcprintf>
  80098d:	83 c4 10             	add    $0x10,%esp
  800990:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800993:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800996:	c9                   	leave  
  800997:	c3                   	ret    

00800998 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800998:	55                   	push   %ebp
  800999:	89 e5                	mov    %esp,%ebp
  80099b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80099e:	e8 8e 0f 00 00       	call   801931 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009a3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ac:	83 ec 08             	sub    $0x8,%esp
  8009af:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b2:	50                   	push   %eax
  8009b3:	e8 48 ff ff ff       	call   800900 <vcprintf>
  8009b8:	83 c4 10             	add    $0x10,%esp
  8009bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009be:	e8 88 0f 00 00       	call   80194b <sys_enable_interrupt>
	return cnt;
  8009c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c6:	c9                   	leave  
  8009c7:	c3                   	ret    

008009c8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009c8:	55                   	push   %ebp
  8009c9:	89 e5                	mov    %esp,%ebp
  8009cb:	53                   	push   %ebx
  8009cc:	83 ec 14             	sub    $0x14,%esp
  8009cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8009d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009db:	8b 45 18             	mov    0x18(%ebp),%eax
  8009de:	ba 00 00 00 00       	mov    $0x0,%edx
  8009e3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009e6:	77 55                	ja     800a3d <printnum+0x75>
  8009e8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009eb:	72 05                	jb     8009f2 <printnum+0x2a>
  8009ed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009f0:	77 4b                	ja     800a3d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009f2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009f5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009f8:	8b 45 18             	mov    0x18(%ebp),%eax
  8009fb:	ba 00 00 00 00       	mov    $0x0,%edx
  800a00:	52                   	push   %edx
  800a01:	50                   	push   %eax
  800a02:	ff 75 f4             	pushl  -0xc(%ebp)
  800a05:	ff 75 f0             	pushl  -0x10(%ebp)
  800a08:	e8 03 13 00 00       	call   801d10 <__udivdi3>
  800a0d:	83 c4 10             	add    $0x10,%esp
  800a10:	83 ec 04             	sub    $0x4,%esp
  800a13:	ff 75 20             	pushl  0x20(%ebp)
  800a16:	53                   	push   %ebx
  800a17:	ff 75 18             	pushl  0x18(%ebp)
  800a1a:	52                   	push   %edx
  800a1b:	50                   	push   %eax
  800a1c:	ff 75 0c             	pushl  0xc(%ebp)
  800a1f:	ff 75 08             	pushl  0x8(%ebp)
  800a22:	e8 a1 ff ff ff       	call   8009c8 <printnum>
  800a27:	83 c4 20             	add    $0x20,%esp
  800a2a:	eb 1a                	jmp    800a46 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a2c:	83 ec 08             	sub    $0x8,%esp
  800a2f:	ff 75 0c             	pushl  0xc(%ebp)
  800a32:	ff 75 20             	pushl  0x20(%ebp)
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	ff d0                	call   *%eax
  800a3a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a3d:	ff 4d 1c             	decl   0x1c(%ebp)
  800a40:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a44:	7f e6                	jg     800a2c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a46:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a49:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a51:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a54:	53                   	push   %ebx
  800a55:	51                   	push   %ecx
  800a56:	52                   	push   %edx
  800a57:	50                   	push   %eax
  800a58:	e8 c3 13 00 00       	call   801e20 <__umoddi3>
  800a5d:	83 c4 10             	add    $0x10,%esp
  800a60:	05 b4 25 80 00       	add    $0x8025b4,%eax
  800a65:	8a 00                	mov    (%eax),%al
  800a67:	0f be c0             	movsbl %al,%eax
  800a6a:	83 ec 08             	sub    $0x8,%esp
  800a6d:	ff 75 0c             	pushl  0xc(%ebp)
  800a70:	50                   	push   %eax
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	ff d0                	call   *%eax
  800a76:	83 c4 10             	add    $0x10,%esp
}
  800a79:	90                   	nop
  800a7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a7d:	c9                   	leave  
  800a7e:	c3                   	ret    

00800a7f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a7f:	55                   	push   %ebp
  800a80:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a82:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a86:	7e 1c                	jle    800aa4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	8b 00                	mov    (%eax),%eax
  800a8d:	8d 50 08             	lea    0x8(%eax),%edx
  800a90:	8b 45 08             	mov    0x8(%ebp),%eax
  800a93:	89 10                	mov    %edx,(%eax)
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	8b 00                	mov    (%eax),%eax
  800a9a:	83 e8 08             	sub    $0x8,%eax
  800a9d:	8b 50 04             	mov    0x4(%eax),%edx
  800aa0:	8b 00                	mov    (%eax),%eax
  800aa2:	eb 40                	jmp    800ae4 <getuint+0x65>
	else if (lflag)
  800aa4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa8:	74 1e                	je     800ac8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	8b 00                	mov    (%eax),%eax
  800aaf:	8d 50 04             	lea    0x4(%eax),%edx
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	89 10                	mov    %edx,(%eax)
  800ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aba:	8b 00                	mov    (%eax),%eax
  800abc:	83 e8 04             	sub    $0x4,%eax
  800abf:	8b 00                	mov    (%eax),%eax
  800ac1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ac6:	eb 1c                	jmp    800ae4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  800acb:	8b 00                	mov    (%eax),%eax
  800acd:	8d 50 04             	lea    0x4(%eax),%edx
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	89 10                	mov    %edx,(%eax)
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	8b 00                	mov    (%eax),%eax
  800ada:	83 e8 04             	sub    $0x4,%eax
  800add:	8b 00                	mov    (%eax),%eax
  800adf:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ae4:	5d                   	pop    %ebp
  800ae5:	c3                   	ret    

00800ae6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ae6:	55                   	push   %ebp
  800ae7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aed:	7e 1c                	jle    800b0b <getint+0x25>
		return va_arg(*ap, long long);
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	8b 00                	mov    (%eax),%eax
  800af4:	8d 50 08             	lea    0x8(%eax),%edx
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	89 10                	mov    %edx,(%eax)
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8b 00                	mov    (%eax),%eax
  800b01:	83 e8 08             	sub    $0x8,%eax
  800b04:	8b 50 04             	mov    0x4(%eax),%edx
  800b07:	8b 00                	mov    (%eax),%eax
  800b09:	eb 38                	jmp    800b43 <getint+0x5d>
	else if (lflag)
  800b0b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b0f:	74 1a                	je     800b2b <getint+0x45>
		return va_arg(*ap, long);
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	8b 00                	mov    (%eax),%eax
  800b16:	8d 50 04             	lea    0x4(%eax),%edx
  800b19:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1c:	89 10                	mov    %edx,(%eax)
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	83 e8 04             	sub    $0x4,%eax
  800b26:	8b 00                	mov    (%eax),%eax
  800b28:	99                   	cltd   
  800b29:	eb 18                	jmp    800b43 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	8d 50 04             	lea    0x4(%eax),%edx
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	89 10                	mov    %edx,(%eax)
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	8b 00                	mov    (%eax),%eax
  800b3d:	83 e8 04             	sub    $0x4,%eax
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	99                   	cltd   
}
  800b43:	5d                   	pop    %ebp
  800b44:	c3                   	ret    

00800b45 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
  800b48:	56                   	push   %esi
  800b49:	53                   	push   %ebx
  800b4a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b4d:	eb 17                	jmp    800b66 <vprintfmt+0x21>
			if (ch == '\0')
  800b4f:	85 db                	test   %ebx,%ebx
  800b51:	0f 84 af 03 00 00    	je     800f06 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b57:	83 ec 08             	sub    $0x8,%esp
  800b5a:	ff 75 0c             	pushl  0xc(%ebp)
  800b5d:	53                   	push   %ebx
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	ff d0                	call   *%eax
  800b63:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b66:	8b 45 10             	mov    0x10(%ebp),%eax
  800b69:	8d 50 01             	lea    0x1(%eax),%edx
  800b6c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b6f:	8a 00                	mov    (%eax),%al
  800b71:	0f b6 d8             	movzbl %al,%ebx
  800b74:	83 fb 25             	cmp    $0x25,%ebx
  800b77:	75 d6                	jne    800b4f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b79:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b7d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b84:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b8b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b92:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b99:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9c:	8d 50 01             	lea    0x1(%eax),%edx
  800b9f:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba2:	8a 00                	mov    (%eax),%al
  800ba4:	0f b6 d8             	movzbl %al,%ebx
  800ba7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800baa:	83 f8 55             	cmp    $0x55,%eax
  800bad:	0f 87 2b 03 00 00    	ja     800ede <vprintfmt+0x399>
  800bb3:	8b 04 85 d8 25 80 00 	mov    0x8025d8(,%eax,4),%eax
  800bba:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bbc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bc0:	eb d7                	jmp    800b99 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bc2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bc6:	eb d1                	jmp    800b99 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bc8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bcf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bd2:	89 d0                	mov    %edx,%eax
  800bd4:	c1 e0 02             	shl    $0x2,%eax
  800bd7:	01 d0                	add    %edx,%eax
  800bd9:	01 c0                	add    %eax,%eax
  800bdb:	01 d8                	add    %ebx,%eax
  800bdd:	83 e8 30             	sub    $0x30,%eax
  800be0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800be3:	8b 45 10             	mov    0x10(%ebp),%eax
  800be6:	8a 00                	mov    (%eax),%al
  800be8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800beb:	83 fb 2f             	cmp    $0x2f,%ebx
  800bee:	7e 3e                	jle    800c2e <vprintfmt+0xe9>
  800bf0:	83 fb 39             	cmp    $0x39,%ebx
  800bf3:	7f 39                	jg     800c2e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bf5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bf8:	eb d5                	jmp    800bcf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bfa:	8b 45 14             	mov    0x14(%ebp),%eax
  800bfd:	83 c0 04             	add    $0x4,%eax
  800c00:	89 45 14             	mov    %eax,0x14(%ebp)
  800c03:	8b 45 14             	mov    0x14(%ebp),%eax
  800c06:	83 e8 04             	sub    $0x4,%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c0e:	eb 1f                	jmp    800c2f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c14:	79 83                	jns    800b99 <vprintfmt+0x54>
				width = 0;
  800c16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c1d:	e9 77 ff ff ff       	jmp    800b99 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c22:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c29:	e9 6b ff ff ff       	jmp    800b99 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c2e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c2f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c33:	0f 89 60 ff ff ff    	jns    800b99 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c3f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c46:	e9 4e ff ff ff       	jmp    800b99 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c4b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c4e:	e9 46 ff ff ff       	jmp    800b99 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c53:	8b 45 14             	mov    0x14(%ebp),%eax
  800c56:	83 c0 04             	add    $0x4,%eax
  800c59:	89 45 14             	mov    %eax,0x14(%ebp)
  800c5c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5f:	83 e8 04             	sub    $0x4,%eax
  800c62:	8b 00                	mov    (%eax),%eax
  800c64:	83 ec 08             	sub    $0x8,%esp
  800c67:	ff 75 0c             	pushl  0xc(%ebp)
  800c6a:	50                   	push   %eax
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	ff d0                	call   *%eax
  800c70:	83 c4 10             	add    $0x10,%esp
			break;
  800c73:	e9 89 02 00 00       	jmp    800f01 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c78:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7b:	83 c0 04             	add    $0x4,%eax
  800c7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c81:	8b 45 14             	mov    0x14(%ebp),%eax
  800c84:	83 e8 04             	sub    $0x4,%eax
  800c87:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c89:	85 db                	test   %ebx,%ebx
  800c8b:	79 02                	jns    800c8f <vprintfmt+0x14a>
				err = -err;
  800c8d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c8f:	83 fb 64             	cmp    $0x64,%ebx
  800c92:	7f 0b                	jg     800c9f <vprintfmt+0x15a>
  800c94:	8b 34 9d 20 24 80 00 	mov    0x802420(,%ebx,4),%esi
  800c9b:	85 f6                	test   %esi,%esi
  800c9d:	75 19                	jne    800cb8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c9f:	53                   	push   %ebx
  800ca0:	68 c5 25 80 00       	push   $0x8025c5
  800ca5:	ff 75 0c             	pushl  0xc(%ebp)
  800ca8:	ff 75 08             	pushl  0x8(%ebp)
  800cab:	e8 5e 02 00 00       	call   800f0e <printfmt>
  800cb0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cb3:	e9 49 02 00 00       	jmp    800f01 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cb8:	56                   	push   %esi
  800cb9:	68 ce 25 80 00       	push   $0x8025ce
  800cbe:	ff 75 0c             	pushl  0xc(%ebp)
  800cc1:	ff 75 08             	pushl  0x8(%ebp)
  800cc4:	e8 45 02 00 00       	call   800f0e <printfmt>
  800cc9:	83 c4 10             	add    $0x10,%esp
			break;
  800ccc:	e9 30 02 00 00       	jmp    800f01 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd4:	83 c0 04             	add    $0x4,%eax
  800cd7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cda:	8b 45 14             	mov    0x14(%ebp),%eax
  800cdd:	83 e8 04             	sub    $0x4,%eax
  800ce0:	8b 30                	mov    (%eax),%esi
  800ce2:	85 f6                	test   %esi,%esi
  800ce4:	75 05                	jne    800ceb <vprintfmt+0x1a6>
				p = "(null)";
  800ce6:	be d1 25 80 00       	mov    $0x8025d1,%esi
			if (width > 0 && padc != '-')
  800ceb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cef:	7e 6d                	jle    800d5e <vprintfmt+0x219>
  800cf1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cf5:	74 67                	je     800d5e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cf7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cfa:	83 ec 08             	sub    $0x8,%esp
  800cfd:	50                   	push   %eax
  800cfe:	56                   	push   %esi
  800cff:	e8 0c 03 00 00       	call   801010 <strnlen>
  800d04:	83 c4 10             	add    $0x10,%esp
  800d07:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d0a:	eb 16                	jmp    800d22 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d0c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d10:	83 ec 08             	sub    $0x8,%esp
  800d13:	ff 75 0c             	pushl  0xc(%ebp)
  800d16:	50                   	push   %eax
  800d17:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1a:	ff d0                	call   *%eax
  800d1c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d1f:	ff 4d e4             	decl   -0x1c(%ebp)
  800d22:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d26:	7f e4                	jg     800d0c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d28:	eb 34                	jmp    800d5e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d2a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d2e:	74 1c                	je     800d4c <vprintfmt+0x207>
  800d30:	83 fb 1f             	cmp    $0x1f,%ebx
  800d33:	7e 05                	jle    800d3a <vprintfmt+0x1f5>
  800d35:	83 fb 7e             	cmp    $0x7e,%ebx
  800d38:	7e 12                	jle    800d4c <vprintfmt+0x207>
					putch('?', putdat);
  800d3a:	83 ec 08             	sub    $0x8,%esp
  800d3d:	ff 75 0c             	pushl  0xc(%ebp)
  800d40:	6a 3f                	push   $0x3f
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	ff d0                	call   *%eax
  800d47:	83 c4 10             	add    $0x10,%esp
  800d4a:	eb 0f                	jmp    800d5b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d4c:	83 ec 08             	sub    $0x8,%esp
  800d4f:	ff 75 0c             	pushl  0xc(%ebp)
  800d52:	53                   	push   %ebx
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	ff d0                	call   *%eax
  800d58:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d5b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d5e:	89 f0                	mov    %esi,%eax
  800d60:	8d 70 01             	lea    0x1(%eax),%esi
  800d63:	8a 00                	mov    (%eax),%al
  800d65:	0f be d8             	movsbl %al,%ebx
  800d68:	85 db                	test   %ebx,%ebx
  800d6a:	74 24                	je     800d90 <vprintfmt+0x24b>
  800d6c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d70:	78 b8                	js     800d2a <vprintfmt+0x1e5>
  800d72:	ff 4d e0             	decl   -0x20(%ebp)
  800d75:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d79:	79 af                	jns    800d2a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d7b:	eb 13                	jmp    800d90 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d7d:	83 ec 08             	sub    $0x8,%esp
  800d80:	ff 75 0c             	pushl  0xc(%ebp)
  800d83:	6a 20                	push   $0x20
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	ff d0                	call   *%eax
  800d8a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d8d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d90:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d94:	7f e7                	jg     800d7d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d96:	e9 66 01 00 00       	jmp    800f01 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d9b:	83 ec 08             	sub    $0x8,%esp
  800d9e:	ff 75 e8             	pushl  -0x18(%ebp)
  800da1:	8d 45 14             	lea    0x14(%ebp),%eax
  800da4:	50                   	push   %eax
  800da5:	e8 3c fd ff ff       	call   800ae6 <getint>
  800daa:	83 c4 10             	add    $0x10,%esp
  800dad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800db0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800db3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db9:	85 d2                	test   %edx,%edx
  800dbb:	79 23                	jns    800de0 <vprintfmt+0x29b>
				putch('-', putdat);
  800dbd:	83 ec 08             	sub    $0x8,%esp
  800dc0:	ff 75 0c             	pushl  0xc(%ebp)
  800dc3:	6a 2d                	push   $0x2d
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	ff d0                	call   *%eax
  800dca:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dd3:	f7 d8                	neg    %eax
  800dd5:	83 d2 00             	adc    $0x0,%edx
  800dd8:	f7 da                	neg    %edx
  800dda:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ddd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800de0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800de7:	e9 bc 00 00 00       	jmp    800ea8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dec:	83 ec 08             	sub    $0x8,%esp
  800def:	ff 75 e8             	pushl  -0x18(%ebp)
  800df2:	8d 45 14             	lea    0x14(%ebp),%eax
  800df5:	50                   	push   %eax
  800df6:	e8 84 fc ff ff       	call   800a7f <getuint>
  800dfb:	83 c4 10             	add    $0x10,%esp
  800dfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e01:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e04:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e0b:	e9 98 00 00 00       	jmp    800ea8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e10:	83 ec 08             	sub    $0x8,%esp
  800e13:	ff 75 0c             	pushl  0xc(%ebp)
  800e16:	6a 58                	push   $0x58
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	ff d0                	call   *%eax
  800e1d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e20:	83 ec 08             	sub    $0x8,%esp
  800e23:	ff 75 0c             	pushl  0xc(%ebp)
  800e26:	6a 58                	push   $0x58
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	ff d0                	call   *%eax
  800e2d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e30:	83 ec 08             	sub    $0x8,%esp
  800e33:	ff 75 0c             	pushl  0xc(%ebp)
  800e36:	6a 58                	push   $0x58
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	ff d0                	call   *%eax
  800e3d:	83 c4 10             	add    $0x10,%esp
			break;
  800e40:	e9 bc 00 00 00       	jmp    800f01 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	6a 30                	push   $0x30
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	ff d0                	call   *%eax
  800e52:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 78                	push   $0x78
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e65:	8b 45 14             	mov    0x14(%ebp),%eax
  800e68:	83 c0 04             	add    $0x4,%eax
  800e6b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e71:	83 e8 04             	sub    $0x4,%eax
  800e74:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e80:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e87:	eb 1f                	jmp    800ea8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e8f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e92:	50                   	push   %eax
  800e93:	e8 e7 fb ff ff       	call   800a7f <getuint>
  800e98:	83 c4 10             	add    $0x10,%esp
  800e9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ea1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ea8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800eaf:	83 ec 04             	sub    $0x4,%esp
  800eb2:	52                   	push   %edx
  800eb3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800eb6:	50                   	push   %eax
  800eb7:	ff 75 f4             	pushl  -0xc(%ebp)
  800eba:	ff 75 f0             	pushl  -0x10(%ebp)
  800ebd:	ff 75 0c             	pushl  0xc(%ebp)
  800ec0:	ff 75 08             	pushl  0x8(%ebp)
  800ec3:	e8 00 fb ff ff       	call   8009c8 <printnum>
  800ec8:	83 c4 20             	add    $0x20,%esp
			break;
  800ecb:	eb 34                	jmp    800f01 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ecd:	83 ec 08             	sub    $0x8,%esp
  800ed0:	ff 75 0c             	pushl  0xc(%ebp)
  800ed3:	53                   	push   %ebx
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	ff d0                	call   *%eax
  800ed9:	83 c4 10             	add    $0x10,%esp
			break;
  800edc:	eb 23                	jmp    800f01 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ede:	83 ec 08             	sub    $0x8,%esp
  800ee1:	ff 75 0c             	pushl  0xc(%ebp)
  800ee4:	6a 25                	push   $0x25
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	ff d0                	call   *%eax
  800eeb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800eee:	ff 4d 10             	decl   0x10(%ebp)
  800ef1:	eb 03                	jmp    800ef6 <vprintfmt+0x3b1>
  800ef3:	ff 4d 10             	decl   0x10(%ebp)
  800ef6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef9:	48                   	dec    %eax
  800efa:	8a 00                	mov    (%eax),%al
  800efc:	3c 25                	cmp    $0x25,%al
  800efe:	75 f3                	jne    800ef3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f00:	90                   	nop
		}
	}
  800f01:	e9 47 fc ff ff       	jmp    800b4d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f06:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f07:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f0a:	5b                   	pop    %ebx
  800f0b:	5e                   	pop    %esi
  800f0c:	5d                   	pop    %ebp
  800f0d:	c3                   	ret    

00800f0e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f0e:	55                   	push   %ebp
  800f0f:	89 e5                	mov    %esp,%ebp
  800f11:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f14:	8d 45 10             	lea    0x10(%ebp),%eax
  800f17:	83 c0 04             	add    $0x4,%eax
  800f1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f20:	ff 75 f4             	pushl  -0xc(%ebp)
  800f23:	50                   	push   %eax
  800f24:	ff 75 0c             	pushl  0xc(%ebp)
  800f27:	ff 75 08             	pushl  0x8(%ebp)
  800f2a:	e8 16 fc ff ff       	call   800b45 <vprintfmt>
  800f2f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f32:	90                   	nop
  800f33:	c9                   	leave  
  800f34:	c3                   	ret    

00800f35 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f35:	55                   	push   %ebp
  800f36:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3b:	8b 40 08             	mov    0x8(%eax),%eax
  800f3e:	8d 50 01             	lea    0x1(%eax),%edx
  800f41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f44:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4a:	8b 10                	mov    (%eax),%edx
  800f4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4f:	8b 40 04             	mov    0x4(%eax),%eax
  800f52:	39 c2                	cmp    %eax,%edx
  800f54:	73 12                	jae    800f68 <sprintputch+0x33>
		*b->buf++ = ch;
  800f56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f59:	8b 00                	mov    (%eax),%eax
  800f5b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f61:	89 0a                	mov    %ecx,(%edx)
  800f63:	8b 55 08             	mov    0x8(%ebp),%edx
  800f66:	88 10                	mov    %dl,(%eax)
}
  800f68:	90                   	nop
  800f69:	5d                   	pop    %ebp
  800f6a:	c3                   	ret    

00800f6b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f6b:	55                   	push   %ebp
  800f6c:	89 e5                	mov    %esp,%ebp
  800f6e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	01 d0                	add    %edx,%eax
  800f82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f8c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f90:	74 06                	je     800f98 <vsnprintf+0x2d>
  800f92:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f96:	7f 07                	jg     800f9f <vsnprintf+0x34>
		return -E_INVAL;
  800f98:	b8 03 00 00 00       	mov    $0x3,%eax
  800f9d:	eb 20                	jmp    800fbf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f9f:	ff 75 14             	pushl  0x14(%ebp)
  800fa2:	ff 75 10             	pushl  0x10(%ebp)
  800fa5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fa8:	50                   	push   %eax
  800fa9:	68 35 0f 80 00       	push   $0x800f35
  800fae:	e8 92 fb ff ff       	call   800b45 <vprintfmt>
  800fb3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fb6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fb9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fbf:	c9                   	leave  
  800fc0:	c3                   	ret    

00800fc1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
  800fc4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fc7:	8d 45 10             	lea    0x10(%ebp),%eax
  800fca:	83 c0 04             	add    $0x4,%eax
  800fcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fd6:	50                   	push   %eax
  800fd7:	ff 75 0c             	pushl  0xc(%ebp)
  800fda:	ff 75 08             	pushl  0x8(%ebp)
  800fdd:	e8 89 ff ff ff       	call   800f6b <vsnprintf>
  800fe2:	83 c4 10             	add    $0x10,%esp
  800fe5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fe8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800feb:	c9                   	leave  
  800fec:	c3                   	ret    

00800fed <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fed:	55                   	push   %ebp
  800fee:	89 e5                	mov    %esp,%ebp
  800ff0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ff3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ffa:	eb 06                	jmp    801002 <strlen+0x15>
		n++;
  800ffc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fff:	ff 45 08             	incl   0x8(%ebp)
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8a 00                	mov    (%eax),%al
  801007:	84 c0                	test   %al,%al
  801009:	75 f1                	jne    800ffc <strlen+0xf>
		n++;
	return n;
  80100b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80100e:	c9                   	leave  
  80100f:	c3                   	ret    

00801010 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801010:	55                   	push   %ebp
  801011:	89 e5                	mov    %esp,%ebp
  801013:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801016:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80101d:	eb 09                	jmp    801028 <strnlen+0x18>
		n++;
  80101f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801022:	ff 45 08             	incl   0x8(%ebp)
  801025:	ff 4d 0c             	decl   0xc(%ebp)
  801028:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80102c:	74 09                	je     801037 <strnlen+0x27>
  80102e:	8b 45 08             	mov    0x8(%ebp),%eax
  801031:	8a 00                	mov    (%eax),%al
  801033:	84 c0                	test   %al,%al
  801035:	75 e8                	jne    80101f <strnlen+0xf>
		n++;
	return n;
  801037:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801048:	90                   	nop
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8d 50 01             	lea    0x1(%eax),%edx
  80104f:	89 55 08             	mov    %edx,0x8(%ebp)
  801052:	8b 55 0c             	mov    0xc(%ebp),%edx
  801055:	8d 4a 01             	lea    0x1(%edx),%ecx
  801058:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80105b:	8a 12                	mov    (%edx),%dl
  80105d:	88 10                	mov    %dl,(%eax)
  80105f:	8a 00                	mov    (%eax),%al
  801061:	84 c0                	test   %al,%al
  801063:	75 e4                	jne    801049 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801065:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801068:	c9                   	leave  
  801069:	c3                   	ret    

0080106a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80106a:	55                   	push   %ebp
  80106b:	89 e5                	mov    %esp,%ebp
  80106d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801076:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80107d:	eb 1f                	jmp    80109e <strncpy+0x34>
		*dst++ = *src;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8d 50 01             	lea    0x1(%eax),%edx
  801085:	89 55 08             	mov    %edx,0x8(%ebp)
  801088:	8b 55 0c             	mov    0xc(%ebp),%edx
  80108b:	8a 12                	mov    (%edx),%dl
  80108d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80108f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	84 c0                	test   %al,%al
  801096:	74 03                	je     80109b <strncpy+0x31>
			src++;
  801098:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80109b:	ff 45 fc             	incl   -0x4(%ebp)
  80109e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010a4:	72 d9                	jb     80107f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a9:	c9                   	leave  
  8010aa:	c3                   	ret    

008010ab <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010ab:	55                   	push   %ebp
  8010ac:	89 e5                	mov    %esp,%ebp
  8010ae:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010b7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010bb:	74 30                	je     8010ed <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010bd:	eb 16                	jmp    8010d5 <strlcpy+0x2a>
			*dst++ = *src++;
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c2:	8d 50 01             	lea    0x1(%eax),%edx
  8010c5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ce:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010d1:	8a 12                	mov    (%edx),%dl
  8010d3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010d5:	ff 4d 10             	decl   0x10(%ebp)
  8010d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010dc:	74 09                	je     8010e7 <strlcpy+0x3c>
  8010de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e1:	8a 00                	mov    (%eax),%al
  8010e3:	84 c0                	test   %al,%al
  8010e5:	75 d8                	jne    8010bf <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f3:	29 c2                	sub    %eax,%edx
  8010f5:	89 d0                	mov    %edx,%eax
}
  8010f7:	c9                   	leave  
  8010f8:	c3                   	ret    

008010f9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010f9:	55                   	push   %ebp
  8010fa:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010fc:	eb 06                	jmp    801104 <strcmp+0xb>
		p++, q++;
  8010fe:	ff 45 08             	incl   0x8(%ebp)
  801101:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	8a 00                	mov    (%eax),%al
  801109:	84 c0                	test   %al,%al
  80110b:	74 0e                	je     80111b <strcmp+0x22>
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8a 10                	mov    (%eax),%dl
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	8a 00                	mov    (%eax),%al
  801117:	38 c2                	cmp    %al,%dl
  801119:	74 e3                	je     8010fe <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80111b:	8b 45 08             	mov    0x8(%ebp),%eax
  80111e:	8a 00                	mov    (%eax),%al
  801120:	0f b6 d0             	movzbl %al,%edx
  801123:	8b 45 0c             	mov    0xc(%ebp),%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	0f b6 c0             	movzbl %al,%eax
  80112b:	29 c2                	sub    %eax,%edx
  80112d:	89 d0                	mov    %edx,%eax
}
  80112f:	5d                   	pop    %ebp
  801130:	c3                   	ret    

00801131 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801131:	55                   	push   %ebp
  801132:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801134:	eb 09                	jmp    80113f <strncmp+0xe>
		n--, p++, q++;
  801136:	ff 4d 10             	decl   0x10(%ebp)
  801139:	ff 45 08             	incl   0x8(%ebp)
  80113c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80113f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801143:	74 17                	je     80115c <strncmp+0x2b>
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	8a 00                	mov    (%eax),%al
  80114a:	84 c0                	test   %al,%al
  80114c:	74 0e                	je     80115c <strncmp+0x2b>
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	8a 10                	mov    (%eax),%dl
  801153:	8b 45 0c             	mov    0xc(%ebp),%eax
  801156:	8a 00                	mov    (%eax),%al
  801158:	38 c2                	cmp    %al,%dl
  80115a:	74 da                	je     801136 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80115c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801160:	75 07                	jne    801169 <strncmp+0x38>
		return 0;
  801162:	b8 00 00 00 00       	mov    $0x0,%eax
  801167:	eb 14                	jmp    80117d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	0f b6 d0             	movzbl %al,%edx
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	0f b6 c0             	movzbl %al,%eax
  801179:	29 c2                	sub    %eax,%edx
  80117b:	89 d0                	mov    %edx,%eax
}
  80117d:	5d                   	pop    %ebp
  80117e:	c3                   	ret    

0080117f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80117f:	55                   	push   %ebp
  801180:	89 e5                	mov    %esp,%ebp
  801182:	83 ec 04             	sub    $0x4,%esp
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80118b:	eb 12                	jmp    80119f <strchr+0x20>
		if (*s == c)
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	8a 00                	mov    (%eax),%al
  801192:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801195:	75 05                	jne    80119c <strchr+0x1d>
			return (char *) s;
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	eb 11                	jmp    8011ad <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80119c:	ff 45 08             	incl   0x8(%ebp)
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	8a 00                	mov    (%eax),%al
  8011a4:	84 c0                	test   %al,%al
  8011a6:	75 e5                	jne    80118d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ad:	c9                   	leave  
  8011ae:	c3                   	ret    

008011af <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011af:	55                   	push   %ebp
  8011b0:	89 e5                	mov    %esp,%ebp
  8011b2:	83 ec 04             	sub    $0x4,%esp
  8011b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011bb:	eb 0d                	jmp    8011ca <strfind+0x1b>
		if (*s == c)
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011c5:	74 0e                	je     8011d5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011c7:	ff 45 08             	incl   0x8(%ebp)
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	84 c0                	test   %al,%al
  8011d1:	75 ea                	jne    8011bd <strfind+0xe>
  8011d3:	eb 01                	jmp    8011d6 <strfind+0x27>
		if (*s == c)
			break;
  8011d5:	90                   	nop
	return (char *) s;
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d9:	c9                   	leave  
  8011da:	c3                   	ret    

008011db <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011db:	55                   	push   %ebp
  8011dc:	89 e5                	mov    %esp,%ebp
  8011de:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011ed:	eb 0e                	jmp    8011fd <memset+0x22>
		*p++ = c;
  8011ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f2:	8d 50 01             	lea    0x1(%eax),%edx
  8011f5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011fb:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011fd:	ff 4d f8             	decl   -0x8(%ebp)
  801200:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801204:	79 e9                	jns    8011ef <memset+0x14>
		*p++ = c;

	return v;
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801209:	c9                   	leave  
  80120a:	c3                   	ret    

0080120b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80120b:	55                   	push   %ebp
  80120c:	89 e5                	mov    %esp,%ebp
  80120e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801211:	8b 45 0c             	mov    0xc(%ebp),%eax
  801214:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80121d:	eb 16                	jmp    801235 <memcpy+0x2a>
		*d++ = *s++;
  80121f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801222:	8d 50 01             	lea    0x1(%eax),%edx
  801225:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801228:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80122b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80122e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801231:	8a 12                	mov    (%edx),%dl
  801233:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801235:	8b 45 10             	mov    0x10(%ebp),%eax
  801238:	8d 50 ff             	lea    -0x1(%eax),%edx
  80123b:	89 55 10             	mov    %edx,0x10(%ebp)
  80123e:	85 c0                	test   %eax,%eax
  801240:	75 dd                	jne    80121f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801242:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
  80124a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801253:	8b 45 08             	mov    0x8(%ebp),%eax
  801256:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801259:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80125f:	73 50                	jae    8012b1 <memmove+0x6a>
  801261:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801264:	8b 45 10             	mov    0x10(%ebp),%eax
  801267:	01 d0                	add    %edx,%eax
  801269:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80126c:	76 43                	jbe    8012b1 <memmove+0x6a>
		s += n;
  80126e:	8b 45 10             	mov    0x10(%ebp),%eax
  801271:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80127a:	eb 10                	jmp    80128c <memmove+0x45>
			*--d = *--s;
  80127c:	ff 4d f8             	decl   -0x8(%ebp)
  80127f:	ff 4d fc             	decl   -0x4(%ebp)
  801282:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801285:	8a 10                	mov    (%eax),%dl
  801287:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80128c:	8b 45 10             	mov    0x10(%ebp),%eax
  80128f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801292:	89 55 10             	mov    %edx,0x10(%ebp)
  801295:	85 c0                	test   %eax,%eax
  801297:	75 e3                	jne    80127c <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801299:	eb 23                	jmp    8012be <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80129b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129e:	8d 50 01             	lea    0x1(%eax),%edx
  8012a1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012aa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012ad:	8a 12                	mov    (%edx),%dl
  8012af:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ba:	85 c0                	test   %eax,%eax
  8012bc:	75 dd                	jne    80129b <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
  8012c6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012d5:	eb 2a                	jmp    801301 <memcmp+0x3e>
		if (*s1 != *s2)
  8012d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012da:	8a 10                	mov    (%eax),%dl
  8012dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	38 c2                	cmp    %al,%dl
  8012e3:	74 16                	je     8012fb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	0f b6 d0             	movzbl %al,%edx
  8012ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	0f b6 c0             	movzbl %al,%eax
  8012f5:	29 c2                	sub    %eax,%edx
  8012f7:	89 d0                	mov    %edx,%eax
  8012f9:	eb 18                	jmp    801313 <memcmp+0x50>
		s1++, s2++;
  8012fb:	ff 45 fc             	incl   -0x4(%ebp)
  8012fe:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801301:	8b 45 10             	mov    0x10(%ebp),%eax
  801304:	8d 50 ff             	lea    -0x1(%eax),%edx
  801307:	89 55 10             	mov    %edx,0x10(%ebp)
  80130a:	85 c0                	test   %eax,%eax
  80130c:	75 c9                	jne    8012d7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80130e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801313:	c9                   	leave  
  801314:	c3                   	ret    

00801315 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801315:	55                   	push   %ebp
  801316:	89 e5                	mov    %esp,%ebp
  801318:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80131b:	8b 55 08             	mov    0x8(%ebp),%edx
  80131e:	8b 45 10             	mov    0x10(%ebp),%eax
  801321:	01 d0                	add    %edx,%eax
  801323:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801326:	eb 15                	jmp    80133d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	0f b6 d0             	movzbl %al,%edx
  801330:	8b 45 0c             	mov    0xc(%ebp),%eax
  801333:	0f b6 c0             	movzbl %al,%eax
  801336:	39 c2                	cmp    %eax,%edx
  801338:	74 0d                	je     801347 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80133a:	ff 45 08             	incl   0x8(%ebp)
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801343:	72 e3                	jb     801328 <memfind+0x13>
  801345:	eb 01                	jmp    801348 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801347:	90                   	nop
	return (void *) s;
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80134b:	c9                   	leave  
  80134c:	c3                   	ret    

0080134d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80134d:	55                   	push   %ebp
  80134e:	89 e5                	mov    %esp,%ebp
  801350:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801353:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80135a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801361:	eb 03                	jmp    801366 <strtol+0x19>
		s++;
  801363:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8a 00                	mov    (%eax),%al
  80136b:	3c 20                	cmp    $0x20,%al
  80136d:	74 f4                	je     801363 <strtol+0x16>
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	3c 09                	cmp    $0x9,%al
  801376:	74 eb                	je     801363 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	3c 2b                	cmp    $0x2b,%al
  80137f:	75 05                	jne    801386 <strtol+0x39>
		s++;
  801381:	ff 45 08             	incl   0x8(%ebp)
  801384:	eb 13                	jmp    801399 <strtol+0x4c>
	else if (*s == '-')
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	3c 2d                	cmp    $0x2d,%al
  80138d:	75 0a                	jne    801399 <strtol+0x4c>
		s++, neg = 1;
  80138f:	ff 45 08             	incl   0x8(%ebp)
  801392:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801399:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80139d:	74 06                	je     8013a5 <strtol+0x58>
  80139f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013a3:	75 20                	jne    8013c5 <strtol+0x78>
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	3c 30                	cmp    $0x30,%al
  8013ac:	75 17                	jne    8013c5 <strtol+0x78>
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	40                   	inc    %eax
  8013b2:	8a 00                	mov    (%eax),%al
  8013b4:	3c 78                	cmp    $0x78,%al
  8013b6:	75 0d                	jne    8013c5 <strtol+0x78>
		s += 2, base = 16;
  8013b8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013bc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013c3:	eb 28                	jmp    8013ed <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c9:	75 15                	jne    8013e0 <strtol+0x93>
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	8a 00                	mov    (%eax),%al
  8013d0:	3c 30                	cmp    $0x30,%al
  8013d2:	75 0c                	jne    8013e0 <strtol+0x93>
		s++, base = 8;
  8013d4:	ff 45 08             	incl   0x8(%ebp)
  8013d7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013de:	eb 0d                	jmp    8013ed <strtol+0xa0>
	else if (base == 0)
  8013e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e4:	75 07                	jne    8013ed <strtol+0xa0>
		base = 10;
  8013e6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f0:	8a 00                	mov    (%eax),%al
  8013f2:	3c 2f                	cmp    $0x2f,%al
  8013f4:	7e 19                	jle    80140f <strtol+0xc2>
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	3c 39                	cmp    $0x39,%al
  8013fd:	7f 10                	jg     80140f <strtol+0xc2>
			dig = *s - '0';
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	0f be c0             	movsbl %al,%eax
  801407:	83 e8 30             	sub    $0x30,%eax
  80140a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80140d:	eb 42                	jmp    801451 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	3c 60                	cmp    $0x60,%al
  801416:	7e 19                	jle    801431 <strtol+0xe4>
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	3c 7a                	cmp    $0x7a,%al
  80141f:	7f 10                	jg     801431 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	0f be c0             	movsbl %al,%eax
  801429:	83 e8 57             	sub    $0x57,%eax
  80142c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80142f:	eb 20                	jmp    801451 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801431:	8b 45 08             	mov    0x8(%ebp),%eax
  801434:	8a 00                	mov    (%eax),%al
  801436:	3c 40                	cmp    $0x40,%al
  801438:	7e 39                	jle    801473 <strtol+0x126>
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	8a 00                	mov    (%eax),%al
  80143f:	3c 5a                	cmp    $0x5a,%al
  801441:	7f 30                	jg     801473 <strtol+0x126>
			dig = *s - 'A' + 10;
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8a 00                	mov    (%eax),%al
  801448:	0f be c0             	movsbl %al,%eax
  80144b:	83 e8 37             	sub    $0x37,%eax
  80144e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801451:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801454:	3b 45 10             	cmp    0x10(%ebp),%eax
  801457:	7d 19                	jge    801472 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801459:	ff 45 08             	incl   0x8(%ebp)
  80145c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801463:	89 c2                	mov    %eax,%edx
  801465:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801468:	01 d0                	add    %edx,%eax
  80146a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80146d:	e9 7b ff ff ff       	jmp    8013ed <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801472:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801473:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801477:	74 08                	je     801481 <strtol+0x134>
		*endptr = (char *) s;
  801479:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147c:	8b 55 08             	mov    0x8(%ebp),%edx
  80147f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801481:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801485:	74 07                	je     80148e <strtol+0x141>
  801487:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80148a:	f7 d8                	neg    %eax
  80148c:	eb 03                	jmp    801491 <strtol+0x144>
  80148e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <ltostr>:

void
ltostr(long value, char *str)
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
  801496:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801499:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014ab:	79 13                	jns    8014c0 <ltostr+0x2d>
	{
		neg = 1;
  8014ad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014ba:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014bd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014c8:	99                   	cltd   
  8014c9:	f7 f9                	idiv   %ecx
  8014cb:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d1:	8d 50 01             	lea    0x1(%eax),%edx
  8014d4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d7:	89 c2                	mov    %eax,%edx
  8014d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014dc:	01 d0                	add    %edx,%eax
  8014de:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014e1:	83 c2 30             	add    $0x30,%edx
  8014e4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014ee:	f7 e9                	imul   %ecx
  8014f0:	c1 fa 02             	sar    $0x2,%edx
  8014f3:	89 c8                	mov    %ecx,%eax
  8014f5:	c1 f8 1f             	sar    $0x1f,%eax
  8014f8:	29 c2                	sub    %eax,%edx
  8014fa:	89 d0                	mov    %edx,%eax
  8014fc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801502:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801507:	f7 e9                	imul   %ecx
  801509:	c1 fa 02             	sar    $0x2,%edx
  80150c:	89 c8                	mov    %ecx,%eax
  80150e:	c1 f8 1f             	sar    $0x1f,%eax
  801511:	29 c2                	sub    %eax,%edx
  801513:	89 d0                	mov    %edx,%eax
  801515:	c1 e0 02             	shl    $0x2,%eax
  801518:	01 d0                	add    %edx,%eax
  80151a:	01 c0                	add    %eax,%eax
  80151c:	29 c1                	sub    %eax,%ecx
  80151e:	89 ca                	mov    %ecx,%edx
  801520:	85 d2                	test   %edx,%edx
  801522:	75 9c                	jne    8014c0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80152b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152e:	48                   	dec    %eax
  80152f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801532:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801536:	74 3d                	je     801575 <ltostr+0xe2>
		start = 1 ;
  801538:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80153f:	eb 34                	jmp    801575 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801541:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801544:	8b 45 0c             	mov    0xc(%ebp),%eax
  801547:	01 d0                	add    %edx,%eax
  801549:	8a 00                	mov    (%eax),%al
  80154b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80154e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801551:	8b 45 0c             	mov    0xc(%ebp),%eax
  801554:	01 c2                	add    %eax,%edx
  801556:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801559:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155c:	01 c8                	add    %ecx,%eax
  80155e:	8a 00                	mov    (%eax),%al
  801560:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801562:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801565:	8b 45 0c             	mov    0xc(%ebp),%eax
  801568:	01 c2                	add    %eax,%edx
  80156a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80156d:	88 02                	mov    %al,(%edx)
		start++ ;
  80156f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801572:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801575:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801578:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80157b:	7c c4                	jl     801541 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80157d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801580:	8b 45 0c             	mov    0xc(%ebp),%eax
  801583:	01 d0                	add    %edx,%eax
  801585:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801588:	90                   	nop
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
  80158e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801591:	ff 75 08             	pushl  0x8(%ebp)
  801594:	e8 54 fa ff ff       	call   800fed <strlen>
  801599:	83 c4 04             	add    $0x4,%esp
  80159c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80159f:	ff 75 0c             	pushl  0xc(%ebp)
  8015a2:	e8 46 fa ff ff       	call   800fed <strlen>
  8015a7:	83 c4 04             	add    $0x4,%esp
  8015aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015bb:	eb 17                	jmp    8015d4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c3:	01 c2                	add    %eax,%edx
  8015c5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cb:	01 c8                	add    %ecx,%eax
  8015cd:	8a 00                	mov    (%eax),%al
  8015cf:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015d1:	ff 45 fc             	incl   -0x4(%ebp)
  8015d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015da:	7c e1                	jl     8015bd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015ea:	eb 1f                	jmp    80160b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ef:	8d 50 01             	lea    0x1(%eax),%edx
  8015f2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015f5:	89 c2                	mov    %eax,%edx
  8015f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fa:	01 c2                	add    %eax,%edx
  8015fc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801602:	01 c8                	add    %ecx,%eax
  801604:	8a 00                	mov    (%eax),%al
  801606:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801608:	ff 45 f8             	incl   -0x8(%ebp)
  80160b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80160e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801611:	7c d9                	jl     8015ec <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801613:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801616:	8b 45 10             	mov    0x10(%ebp),%eax
  801619:	01 d0                	add    %edx,%eax
  80161b:	c6 00 00             	movb   $0x0,(%eax)
}
  80161e:	90                   	nop
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801624:	8b 45 14             	mov    0x14(%ebp),%eax
  801627:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80162d:	8b 45 14             	mov    0x14(%ebp),%eax
  801630:	8b 00                	mov    (%eax),%eax
  801632:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801639:	8b 45 10             	mov    0x10(%ebp),%eax
  80163c:	01 d0                	add    %edx,%eax
  80163e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801644:	eb 0c                	jmp    801652 <strsplit+0x31>
			*string++ = 0;
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	8d 50 01             	lea    0x1(%eax),%edx
  80164c:	89 55 08             	mov    %edx,0x8(%ebp)
  80164f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801652:	8b 45 08             	mov    0x8(%ebp),%eax
  801655:	8a 00                	mov    (%eax),%al
  801657:	84 c0                	test   %al,%al
  801659:	74 18                	je     801673 <strsplit+0x52>
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	8a 00                	mov    (%eax),%al
  801660:	0f be c0             	movsbl %al,%eax
  801663:	50                   	push   %eax
  801664:	ff 75 0c             	pushl  0xc(%ebp)
  801667:	e8 13 fb ff ff       	call   80117f <strchr>
  80166c:	83 c4 08             	add    $0x8,%esp
  80166f:	85 c0                	test   %eax,%eax
  801671:	75 d3                	jne    801646 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	8a 00                	mov    (%eax),%al
  801678:	84 c0                	test   %al,%al
  80167a:	74 5a                	je     8016d6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80167c:	8b 45 14             	mov    0x14(%ebp),%eax
  80167f:	8b 00                	mov    (%eax),%eax
  801681:	83 f8 0f             	cmp    $0xf,%eax
  801684:	75 07                	jne    80168d <strsplit+0x6c>
		{
			return 0;
  801686:	b8 00 00 00 00       	mov    $0x0,%eax
  80168b:	eb 66                	jmp    8016f3 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80168d:	8b 45 14             	mov    0x14(%ebp),%eax
  801690:	8b 00                	mov    (%eax),%eax
  801692:	8d 48 01             	lea    0x1(%eax),%ecx
  801695:	8b 55 14             	mov    0x14(%ebp),%edx
  801698:	89 0a                	mov    %ecx,(%edx)
  80169a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a4:	01 c2                	add    %eax,%edx
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016ab:	eb 03                	jmp    8016b0 <strsplit+0x8f>
			string++;
  8016ad:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	8a 00                	mov    (%eax),%al
  8016b5:	84 c0                	test   %al,%al
  8016b7:	74 8b                	je     801644 <strsplit+0x23>
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	8a 00                	mov    (%eax),%al
  8016be:	0f be c0             	movsbl %al,%eax
  8016c1:	50                   	push   %eax
  8016c2:	ff 75 0c             	pushl  0xc(%ebp)
  8016c5:	e8 b5 fa ff ff       	call   80117f <strchr>
  8016ca:	83 c4 08             	add    $0x8,%esp
  8016cd:	85 c0                	test   %eax,%eax
  8016cf:	74 dc                	je     8016ad <strsplit+0x8c>
			string++;
	}
  8016d1:	e9 6e ff ff ff       	jmp    801644 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016d6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016da:	8b 00                	mov    (%eax),%eax
  8016dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e6:	01 d0                	add    %edx,%eax
  8016e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016ee:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
  8016f8:	57                   	push   %edi
  8016f9:	56                   	push   %esi
  8016fa:	53                   	push   %ebx
  8016fb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8b 55 0c             	mov    0xc(%ebp),%edx
  801704:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801707:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80170a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80170d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801710:	cd 30                	int    $0x30
  801712:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801715:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801718:	83 c4 10             	add    $0x10,%esp
  80171b:	5b                   	pop    %ebx
  80171c:	5e                   	pop    %esi
  80171d:	5f                   	pop    %edi
  80171e:	5d                   	pop    %ebp
  80171f:	c3                   	ret    

00801720 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
  801723:	83 ec 04             	sub    $0x4,%esp
  801726:	8b 45 10             	mov    0x10(%ebp),%eax
  801729:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80172c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	52                   	push   %edx
  801738:	ff 75 0c             	pushl  0xc(%ebp)
  80173b:	50                   	push   %eax
  80173c:	6a 00                	push   $0x0
  80173e:	e8 b2 ff ff ff       	call   8016f5 <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	90                   	nop
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <sys_cgetc>:

int
sys_cgetc(void)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 01                	push   $0x1
  801758:	e8 98 ff ff ff       	call   8016f5 <syscall>
  80175d:	83 c4 18             	add    $0x18,%esp
}
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	50                   	push   %eax
  801771:	6a 05                	push   $0x5
  801773:	e8 7d ff ff ff       	call   8016f5 <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
}
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 02                	push   $0x2
  80178c:	e8 64 ff ff ff       	call   8016f5 <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 03                	push   $0x3
  8017a5:	e8 4b ff ff ff       	call   8016f5 <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 04                	push   $0x4
  8017be:	e8 32 ff ff ff       	call   8016f5 <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_env_exit>:


void sys_env_exit(void)
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 06                	push   $0x6
  8017d7:	e8 19 ff ff ff       	call   8016f5 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	90                   	nop
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	52                   	push   %edx
  8017f2:	50                   	push   %eax
  8017f3:	6a 07                	push   $0x7
  8017f5:	e8 fb fe ff ff       	call   8016f5 <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
  801802:	56                   	push   %esi
  801803:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801804:	8b 75 18             	mov    0x18(%ebp),%esi
  801807:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80180a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80180d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	56                   	push   %esi
  801814:	53                   	push   %ebx
  801815:	51                   	push   %ecx
  801816:	52                   	push   %edx
  801817:	50                   	push   %eax
  801818:	6a 08                	push   $0x8
  80181a:	e8 d6 fe ff ff       	call   8016f5 <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801825:	5b                   	pop    %ebx
  801826:	5e                   	pop    %esi
  801827:	5d                   	pop    %ebp
  801828:	c3                   	ret    

00801829 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80182c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	52                   	push   %edx
  801839:	50                   	push   %eax
  80183a:	6a 09                	push   $0x9
  80183c:	e8 b4 fe ff ff       	call   8016f5 <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	ff 75 0c             	pushl  0xc(%ebp)
  801852:	ff 75 08             	pushl  0x8(%ebp)
  801855:	6a 0a                	push   $0xa
  801857:	e8 99 fe ff ff       	call   8016f5 <syscall>
  80185c:	83 c4 18             	add    $0x18,%esp
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 0b                	push   $0xb
  801870:	e8 80 fe ff ff       	call   8016f5 <syscall>
  801875:	83 c4 18             	add    $0x18,%esp
}
  801878:	c9                   	leave  
  801879:	c3                   	ret    

0080187a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80187a:	55                   	push   %ebp
  80187b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 0c                	push   $0xc
  801889:	e8 67 fe ff ff       	call   8016f5 <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 0d                	push   $0xd
  8018a2:	e8 4e fe ff ff       	call   8016f5 <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
}
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	ff 75 0c             	pushl  0xc(%ebp)
  8018b8:	ff 75 08             	pushl  0x8(%ebp)
  8018bb:	6a 11                	push   $0x11
  8018bd:	e8 33 fe ff ff       	call   8016f5 <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
	return;
  8018c5:	90                   	nop
}
  8018c6:	c9                   	leave  
  8018c7:	c3                   	ret    

008018c8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018c8:	55                   	push   %ebp
  8018c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	ff 75 0c             	pushl  0xc(%ebp)
  8018d4:	ff 75 08             	pushl  0x8(%ebp)
  8018d7:	6a 12                	push   $0x12
  8018d9:	e8 17 fe ff ff       	call   8016f5 <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e1:	90                   	nop
}
  8018e2:	c9                   	leave  
  8018e3:	c3                   	ret    

008018e4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018e4:	55                   	push   %ebp
  8018e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 0e                	push   $0xe
  8018f3:	e8 fd fd ff ff       	call   8016f5 <syscall>
  8018f8:	83 c4 18             	add    $0x18,%esp
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	ff 75 08             	pushl  0x8(%ebp)
  80190b:	6a 0f                	push   $0xf
  80190d:	e8 e3 fd ff ff       	call   8016f5 <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
}
  801915:	c9                   	leave  
  801916:	c3                   	ret    

00801917 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801917:	55                   	push   %ebp
  801918:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 10                	push   $0x10
  801926:	e8 ca fd ff ff       	call   8016f5 <syscall>
  80192b:	83 c4 18             	add    $0x18,%esp
}
  80192e:	90                   	nop
  80192f:	c9                   	leave  
  801930:	c3                   	ret    

00801931 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 14                	push   $0x14
  801940:	e8 b0 fd ff ff       	call   8016f5 <syscall>
  801945:	83 c4 18             	add    $0x18,%esp
}
  801948:	90                   	nop
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 15                	push   $0x15
  80195a:	e8 96 fd ff ff       	call   8016f5 <syscall>
  80195f:	83 c4 18             	add    $0x18,%esp
}
  801962:	90                   	nop
  801963:	c9                   	leave  
  801964:	c3                   	ret    

00801965 <sys_cputc>:


void
sys_cputc(const char c)
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
  801968:	83 ec 04             	sub    $0x4,%esp
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801971:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	50                   	push   %eax
  80197e:	6a 16                	push   $0x16
  801980:	e8 70 fd ff ff       	call   8016f5 <syscall>
  801985:	83 c4 18             	add    $0x18,%esp
}
  801988:	90                   	nop
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 17                	push   $0x17
  80199a:	e8 56 fd ff ff       	call   8016f5 <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	90                   	nop
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	ff 75 0c             	pushl  0xc(%ebp)
  8019b4:	50                   	push   %eax
  8019b5:	6a 18                	push   $0x18
  8019b7:	e8 39 fd ff ff       	call   8016f5 <syscall>
  8019bc:	83 c4 18             	add    $0x18,%esp
}
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	52                   	push   %edx
  8019d1:	50                   	push   %eax
  8019d2:	6a 1b                	push   $0x1b
  8019d4:	e8 1c fd ff ff       	call   8016f5 <syscall>
  8019d9:	83 c4 18             	add    $0x18,%esp
}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	52                   	push   %edx
  8019ee:	50                   	push   %eax
  8019ef:	6a 19                	push   $0x19
  8019f1:	e8 ff fc ff ff       	call   8016f5 <syscall>
  8019f6:	83 c4 18             	add    $0x18,%esp
}
  8019f9:	90                   	nop
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	52                   	push   %edx
  801a0c:	50                   	push   %eax
  801a0d:	6a 1a                	push   $0x1a
  801a0f:	e8 e1 fc ff ff       	call   8016f5 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	90                   	nop
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
  801a1d:	83 ec 04             	sub    $0x4,%esp
  801a20:	8b 45 10             	mov    0x10(%ebp),%eax
  801a23:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a26:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a29:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	6a 00                	push   $0x0
  801a32:	51                   	push   %ecx
  801a33:	52                   	push   %edx
  801a34:	ff 75 0c             	pushl  0xc(%ebp)
  801a37:	50                   	push   %eax
  801a38:	6a 1c                	push   $0x1c
  801a3a:	e8 b6 fc ff ff       	call   8016f5 <syscall>
  801a3f:	83 c4 18             	add    $0x18,%esp
}
  801a42:	c9                   	leave  
  801a43:	c3                   	ret    

00801a44 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a44:	55                   	push   %ebp
  801a45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	52                   	push   %edx
  801a54:	50                   	push   %eax
  801a55:	6a 1d                	push   $0x1d
  801a57:	e8 99 fc ff ff       	call   8016f5 <syscall>
  801a5c:	83 c4 18             	add    $0x18,%esp
}
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a64:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	51                   	push   %ecx
  801a72:	52                   	push   %edx
  801a73:	50                   	push   %eax
  801a74:	6a 1e                	push   $0x1e
  801a76:	e8 7a fc ff ff       	call   8016f5 <syscall>
  801a7b:	83 c4 18             	add    $0x18,%esp
}
  801a7e:	c9                   	leave  
  801a7f:	c3                   	ret    

00801a80 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a83:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a86:	8b 45 08             	mov    0x8(%ebp),%eax
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	52                   	push   %edx
  801a90:	50                   	push   %eax
  801a91:	6a 1f                	push   $0x1f
  801a93:	e8 5d fc ff ff       	call   8016f5 <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 20                	push   $0x20
  801aac:	e8 44 fc ff ff       	call   8016f5 <syscall>
  801ab1:	83 c4 18             	add    $0x18,%esp
}
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	ff 75 10             	pushl  0x10(%ebp)
  801ac3:	ff 75 0c             	pushl  0xc(%ebp)
  801ac6:	50                   	push   %eax
  801ac7:	6a 21                	push   $0x21
  801ac9:	e8 27 fc ff ff       	call   8016f5 <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	50                   	push   %eax
  801ae2:	6a 22                	push   $0x22
  801ae4:	e8 0c fc ff ff       	call   8016f5 <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
}
  801aec:	90                   	nop
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801af2:	8b 45 08             	mov    0x8(%ebp),%eax
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	50                   	push   %eax
  801afe:	6a 23                	push   $0x23
  801b00:	e8 f0 fb ff ff       	call   8016f5 <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
}
  801b08:	90                   	nop
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b11:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b14:	8d 50 04             	lea    0x4(%eax),%edx
  801b17:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	52                   	push   %edx
  801b21:	50                   	push   %eax
  801b22:	6a 24                	push   $0x24
  801b24:	e8 cc fb ff ff       	call   8016f5 <syscall>
  801b29:	83 c4 18             	add    $0x18,%esp
	return result;
  801b2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b32:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b35:	89 01                	mov    %eax,(%ecx)
  801b37:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	c9                   	leave  
  801b3e:	c2 04 00             	ret    $0x4

00801b41 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	ff 75 10             	pushl  0x10(%ebp)
  801b4b:	ff 75 0c             	pushl  0xc(%ebp)
  801b4e:	ff 75 08             	pushl  0x8(%ebp)
  801b51:	6a 13                	push   $0x13
  801b53:	e8 9d fb ff ff       	call   8016f5 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5b:	90                   	nop
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <sys_rcr2>:
uint32 sys_rcr2()
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 25                	push   $0x25
  801b6d:	e8 83 fb ff ff       	call   8016f5 <syscall>
  801b72:	83 c4 18             	add    $0x18,%esp
}
  801b75:	c9                   	leave  
  801b76:	c3                   	ret    

00801b77 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
  801b7a:	83 ec 04             	sub    $0x4,%esp
  801b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b80:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b83:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	6a 00                	push   $0x0
  801b8f:	50                   	push   %eax
  801b90:	6a 26                	push   $0x26
  801b92:	e8 5e fb ff ff       	call   8016f5 <syscall>
  801b97:	83 c4 18             	add    $0x18,%esp
	return ;
  801b9a:	90                   	nop
}
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <rsttst>:
void rsttst()
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 28                	push   $0x28
  801bac:	e8 44 fb ff ff       	call   8016f5 <syscall>
  801bb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb4:	90                   	nop
}
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
  801bba:	83 ec 04             	sub    $0x4,%esp
  801bbd:	8b 45 14             	mov    0x14(%ebp),%eax
  801bc0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bc3:	8b 55 18             	mov    0x18(%ebp),%edx
  801bc6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bca:	52                   	push   %edx
  801bcb:	50                   	push   %eax
  801bcc:	ff 75 10             	pushl  0x10(%ebp)
  801bcf:	ff 75 0c             	pushl  0xc(%ebp)
  801bd2:	ff 75 08             	pushl  0x8(%ebp)
  801bd5:	6a 27                	push   $0x27
  801bd7:	e8 19 fb ff ff       	call   8016f5 <syscall>
  801bdc:	83 c4 18             	add    $0x18,%esp
	return ;
  801bdf:	90                   	nop
}
  801be0:	c9                   	leave  
  801be1:	c3                   	ret    

00801be2 <chktst>:
void chktst(uint32 n)
{
  801be2:	55                   	push   %ebp
  801be3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	ff 75 08             	pushl  0x8(%ebp)
  801bf0:	6a 29                	push   $0x29
  801bf2:	e8 fe fa ff ff       	call   8016f5 <syscall>
  801bf7:	83 c4 18             	add    $0x18,%esp
	return ;
  801bfa:	90                   	nop
}
  801bfb:	c9                   	leave  
  801bfc:	c3                   	ret    

00801bfd <inctst>:

void inctst()
{
  801bfd:	55                   	push   %ebp
  801bfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 2a                	push   $0x2a
  801c0c:	e8 e4 fa ff ff       	call   8016f5 <syscall>
  801c11:	83 c4 18             	add    $0x18,%esp
	return ;
  801c14:	90                   	nop
}
  801c15:	c9                   	leave  
  801c16:	c3                   	ret    

00801c17 <gettst>:
uint32 gettst()
{
  801c17:	55                   	push   %ebp
  801c18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 2b                	push   $0x2b
  801c26:	e8 ca fa ff ff       	call   8016f5 <syscall>
  801c2b:	83 c4 18             	add    $0x18,%esp
}
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
  801c33:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 2c                	push   $0x2c
  801c42:	e8 ae fa ff ff       	call   8016f5 <syscall>
  801c47:	83 c4 18             	add    $0x18,%esp
  801c4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c4d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c51:	75 07                	jne    801c5a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c53:	b8 01 00 00 00       	mov    $0x1,%eax
  801c58:	eb 05                	jmp    801c5f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c5f:	c9                   	leave  
  801c60:	c3                   	ret    

00801c61 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c61:	55                   	push   %ebp
  801c62:	89 e5                	mov    %esp,%ebp
  801c64:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 2c                	push   $0x2c
  801c73:	e8 7d fa ff ff       	call   8016f5 <syscall>
  801c78:	83 c4 18             	add    $0x18,%esp
  801c7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c7e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c82:	75 07                	jne    801c8b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c84:	b8 01 00 00 00       	mov    $0x1,%eax
  801c89:	eb 05                	jmp    801c90 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c8b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c90:	c9                   	leave  
  801c91:	c3                   	ret    

00801c92 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c92:	55                   	push   %ebp
  801c93:	89 e5                	mov    %esp,%ebp
  801c95:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 2c                	push   $0x2c
  801ca4:	e8 4c fa ff ff       	call   8016f5 <syscall>
  801ca9:	83 c4 18             	add    $0x18,%esp
  801cac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801caf:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cb3:	75 07                	jne    801cbc <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cb5:	b8 01 00 00 00       	mov    $0x1,%eax
  801cba:	eb 05                	jmp    801cc1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cbc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
  801cc6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 2c                	push   $0x2c
  801cd5:	e8 1b fa ff ff       	call   8016f5 <syscall>
  801cda:	83 c4 18             	add    $0x18,%esp
  801cdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ce0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ce4:	75 07                	jne    801ced <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ce6:	b8 01 00 00 00       	mov    $0x1,%eax
  801ceb:	eb 05                	jmp    801cf2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ced:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cf2:	c9                   	leave  
  801cf3:	c3                   	ret    

00801cf4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	ff 75 08             	pushl  0x8(%ebp)
  801d02:	6a 2d                	push   $0x2d
  801d04:	e8 ec f9 ff ff       	call   8016f5 <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
	return ;
  801d0c:	90                   	nop
}
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    
  801d0f:	90                   	nop

00801d10 <__udivdi3>:
  801d10:	55                   	push   %ebp
  801d11:	57                   	push   %edi
  801d12:	56                   	push   %esi
  801d13:	53                   	push   %ebx
  801d14:	83 ec 1c             	sub    $0x1c,%esp
  801d17:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d1b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d23:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d27:	89 ca                	mov    %ecx,%edx
  801d29:	89 f8                	mov    %edi,%eax
  801d2b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d2f:	85 f6                	test   %esi,%esi
  801d31:	75 2d                	jne    801d60 <__udivdi3+0x50>
  801d33:	39 cf                	cmp    %ecx,%edi
  801d35:	77 65                	ja     801d9c <__udivdi3+0x8c>
  801d37:	89 fd                	mov    %edi,%ebp
  801d39:	85 ff                	test   %edi,%edi
  801d3b:	75 0b                	jne    801d48 <__udivdi3+0x38>
  801d3d:	b8 01 00 00 00       	mov    $0x1,%eax
  801d42:	31 d2                	xor    %edx,%edx
  801d44:	f7 f7                	div    %edi
  801d46:	89 c5                	mov    %eax,%ebp
  801d48:	31 d2                	xor    %edx,%edx
  801d4a:	89 c8                	mov    %ecx,%eax
  801d4c:	f7 f5                	div    %ebp
  801d4e:	89 c1                	mov    %eax,%ecx
  801d50:	89 d8                	mov    %ebx,%eax
  801d52:	f7 f5                	div    %ebp
  801d54:	89 cf                	mov    %ecx,%edi
  801d56:	89 fa                	mov    %edi,%edx
  801d58:	83 c4 1c             	add    $0x1c,%esp
  801d5b:	5b                   	pop    %ebx
  801d5c:	5e                   	pop    %esi
  801d5d:	5f                   	pop    %edi
  801d5e:	5d                   	pop    %ebp
  801d5f:	c3                   	ret    
  801d60:	39 ce                	cmp    %ecx,%esi
  801d62:	77 28                	ja     801d8c <__udivdi3+0x7c>
  801d64:	0f bd fe             	bsr    %esi,%edi
  801d67:	83 f7 1f             	xor    $0x1f,%edi
  801d6a:	75 40                	jne    801dac <__udivdi3+0x9c>
  801d6c:	39 ce                	cmp    %ecx,%esi
  801d6e:	72 0a                	jb     801d7a <__udivdi3+0x6a>
  801d70:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d74:	0f 87 9e 00 00 00    	ja     801e18 <__udivdi3+0x108>
  801d7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7f:	89 fa                	mov    %edi,%edx
  801d81:	83 c4 1c             	add    $0x1c,%esp
  801d84:	5b                   	pop    %ebx
  801d85:	5e                   	pop    %esi
  801d86:	5f                   	pop    %edi
  801d87:	5d                   	pop    %ebp
  801d88:	c3                   	ret    
  801d89:	8d 76 00             	lea    0x0(%esi),%esi
  801d8c:	31 ff                	xor    %edi,%edi
  801d8e:	31 c0                	xor    %eax,%eax
  801d90:	89 fa                	mov    %edi,%edx
  801d92:	83 c4 1c             	add    $0x1c,%esp
  801d95:	5b                   	pop    %ebx
  801d96:	5e                   	pop    %esi
  801d97:	5f                   	pop    %edi
  801d98:	5d                   	pop    %ebp
  801d99:	c3                   	ret    
  801d9a:	66 90                	xchg   %ax,%ax
  801d9c:	89 d8                	mov    %ebx,%eax
  801d9e:	f7 f7                	div    %edi
  801da0:	31 ff                	xor    %edi,%edi
  801da2:	89 fa                	mov    %edi,%edx
  801da4:	83 c4 1c             	add    $0x1c,%esp
  801da7:	5b                   	pop    %ebx
  801da8:	5e                   	pop    %esi
  801da9:	5f                   	pop    %edi
  801daa:	5d                   	pop    %ebp
  801dab:	c3                   	ret    
  801dac:	bd 20 00 00 00       	mov    $0x20,%ebp
  801db1:	89 eb                	mov    %ebp,%ebx
  801db3:	29 fb                	sub    %edi,%ebx
  801db5:	89 f9                	mov    %edi,%ecx
  801db7:	d3 e6                	shl    %cl,%esi
  801db9:	89 c5                	mov    %eax,%ebp
  801dbb:	88 d9                	mov    %bl,%cl
  801dbd:	d3 ed                	shr    %cl,%ebp
  801dbf:	89 e9                	mov    %ebp,%ecx
  801dc1:	09 f1                	or     %esi,%ecx
  801dc3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801dc7:	89 f9                	mov    %edi,%ecx
  801dc9:	d3 e0                	shl    %cl,%eax
  801dcb:	89 c5                	mov    %eax,%ebp
  801dcd:	89 d6                	mov    %edx,%esi
  801dcf:	88 d9                	mov    %bl,%cl
  801dd1:	d3 ee                	shr    %cl,%esi
  801dd3:	89 f9                	mov    %edi,%ecx
  801dd5:	d3 e2                	shl    %cl,%edx
  801dd7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ddb:	88 d9                	mov    %bl,%cl
  801ddd:	d3 e8                	shr    %cl,%eax
  801ddf:	09 c2                	or     %eax,%edx
  801de1:	89 d0                	mov    %edx,%eax
  801de3:	89 f2                	mov    %esi,%edx
  801de5:	f7 74 24 0c          	divl   0xc(%esp)
  801de9:	89 d6                	mov    %edx,%esi
  801deb:	89 c3                	mov    %eax,%ebx
  801ded:	f7 e5                	mul    %ebp
  801def:	39 d6                	cmp    %edx,%esi
  801df1:	72 19                	jb     801e0c <__udivdi3+0xfc>
  801df3:	74 0b                	je     801e00 <__udivdi3+0xf0>
  801df5:	89 d8                	mov    %ebx,%eax
  801df7:	31 ff                	xor    %edi,%edi
  801df9:	e9 58 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801dfe:	66 90                	xchg   %ax,%ax
  801e00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e04:	89 f9                	mov    %edi,%ecx
  801e06:	d3 e2                	shl    %cl,%edx
  801e08:	39 c2                	cmp    %eax,%edx
  801e0a:	73 e9                	jae    801df5 <__udivdi3+0xe5>
  801e0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e0f:	31 ff                	xor    %edi,%edi
  801e11:	e9 40 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801e16:	66 90                	xchg   %ax,%ax
  801e18:	31 c0                	xor    %eax,%eax
  801e1a:	e9 37 ff ff ff       	jmp    801d56 <__udivdi3+0x46>
  801e1f:	90                   	nop

00801e20 <__umoddi3>:
  801e20:	55                   	push   %ebp
  801e21:	57                   	push   %edi
  801e22:	56                   	push   %esi
  801e23:	53                   	push   %ebx
  801e24:	83 ec 1c             	sub    $0x1c,%esp
  801e27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e3f:	89 f3                	mov    %esi,%ebx
  801e41:	89 fa                	mov    %edi,%edx
  801e43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e47:	89 34 24             	mov    %esi,(%esp)
  801e4a:	85 c0                	test   %eax,%eax
  801e4c:	75 1a                	jne    801e68 <__umoddi3+0x48>
  801e4e:	39 f7                	cmp    %esi,%edi
  801e50:	0f 86 a2 00 00 00    	jbe    801ef8 <__umoddi3+0xd8>
  801e56:	89 c8                	mov    %ecx,%eax
  801e58:	89 f2                	mov    %esi,%edx
  801e5a:	f7 f7                	div    %edi
  801e5c:	89 d0                	mov    %edx,%eax
  801e5e:	31 d2                	xor    %edx,%edx
  801e60:	83 c4 1c             	add    $0x1c,%esp
  801e63:	5b                   	pop    %ebx
  801e64:	5e                   	pop    %esi
  801e65:	5f                   	pop    %edi
  801e66:	5d                   	pop    %ebp
  801e67:	c3                   	ret    
  801e68:	39 f0                	cmp    %esi,%eax
  801e6a:	0f 87 ac 00 00 00    	ja     801f1c <__umoddi3+0xfc>
  801e70:	0f bd e8             	bsr    %eax,%ebp
  801e73:	83 f5 1f             	xor    $0x1f,%ebp
  801e76:	0f 84 ac 00 00 00    	je     801f28 <__umoddi3+0x108>
  801e7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e81:	29 ef                	sub    %ebp,%edi
  801e83:	89 fe                	mov    %edi,%esi
  801e85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e89:	89 e9                	mov    %ebp,%ecx
  801e8b:	d3 e0                	shl    %cl,%eax
  801e8d:	89 d7                	mov    %edx,%edi
  801e8f:	89 f1                	mov    %esi,%ecx
  801e91:	d3 ef                	shr    %cl,%edi
  801e93:	09 c7                	or     %eax,%edi
  801e95:	89 e9                	mov    %ebp,%ecx
  801e97:	d3 e2                	shl    %cl,%edx
  801e99:	89 14 24             	mov    %edx,(%esp)
  801e9c:	89 d8                	mov    %ebx,%eax
  801e9e:	d3 e0                	shl    %cl,%eax
  801ea0:	89 c2                	mov    %eax,%edx
  801ea2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ea6:	d3 e0                	shl    %cl,%eax
  801ea8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801eac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eb0:	89 f1                	mov    %esi,%ecx
  801eb2:	d3 e8                	shr    %cl,%eax
  801eb4:	09 d0                	or     %edx,%eax
  801eb6:	d3 eb                	shr    %cl,%ebx
  801eb8:	89 da                	mov    %ebx,%edx
  801eba:	f7 f7                	div    %edi
  801ebc:	89 d3                	mov    %edx,%ebx
  801ebe:	f7 24 24             	mull   (%esp)
  801ec1:	89 c6                	mov    %eax,%esi
  801ec3:	89 d1                	mov    %edx,%ecx
  801ec5:	39 d3                	cmp    %edx,%ebx
  801ec7:	0f 82 87 00 00 00    	jb     801f54 <__umoddi3+0x134>
  801ecd:	0f 84 91 00 00 00    	je     801f64 <__umoddi3+0x144>
  801ed3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ed7:	29 f2                	sub    %esi,%edx
  801ed9:	19 cb                	sbb    %ecx,%ebx
  801edb:	89 d8                	mov    %ebx,%eax
  801edd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ee1:	d3 e0                	shl    %cl,%eax
  801ee3:	89 e9                	mov    %ebp,%ecx
  801ee5:	d3 ea                	shr    %cl,%edx
  801ee7:	09 d0                	or     %edx,%eax
  801ee9:	89 e9                	mov    %ebp,%ecx
  801eeb:	d3 eb                	shr    %cl,%ebx
  801eed:	89 da                	mov    %ebx,%edx
  801eef:	83 c4 1c             	add    $0x1c,%esp
  801ef2:	5b                   	pop    %ebx
  801ef3:	5e                   	pop    %esi
  801ef4:	5f                   	pop    %edi
  801ef5:	5d                   	pop    %ebp
  801ef6:	c3                   	ret    
  801ef7:	90                   	nop
  801ef8:	89 fd                	mov    %edi,%ebp
  801efa:	85 ff                	test   %edi,%edi
  801efc:	75 0b                	jne    801f09 <__umoddi3+0xe9>
  801efe:	b8 01 00 00 00       	mov    $0x1,%eax
  801f03:	31 d2                	xor    %edx,%edx
  801f05:	f7 f7                	div    %edi
  801f07:	89 c5                	mov    %eax,%ebp
  801f09:	89 f0                	mov    %esi,%eax
  801f0b:	31 d2                	xor    %edx,%edx
  801f0d:	f7 f5                	div    %ebp
  801f0f:	89 c8                	mov    %ecx,%eax
  801f11:	f7 f5                	div    %ebp
  801f13:	89 d0                	mov    %edx,%eax
  801f15:	e9 44 ff ff ff       	jmp    801e5e <__umoddi3+0x3e>
  801f1a:	66 90                	xchg   %ax,%ax
  801f1c:	89 c8                	mov    %ecx,%eax
  801f1e:	89 f2                	mov    %esi,%edx
  801f20:	83 c4 1c             	add    $0x1c,%esp
  801f23:	5b                   	pop    %ebx
  801f24:	5e                   	pop    %esi
  801f25:	5f                   	pop    %edi
  801f26:	5d                   	pop    %ebp
  801f27:	c3                   	ret    
  801f28:	3b 04 24             	cmp    (%esp),%eax
  801f2b:	72 06                	jb     801f33 <__umoddi3+0x113>
  801f2d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f31:	77 0f                	ja     801f42 <__umoddi3+0x122>
  801f33:	89 f2                	mov    %esi,%edx
  801f35:	29 f9                	sub    %edi,%ecx
  801f37:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f3b:	89 14 24             	mov    %edx,(%esp)
  801f3e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f42:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f46:	8b 14 24             	mov    (%esp),%edx
  801f49:	83 c4 1c             	add    $0x1c,%esp
  801f4c:	5b                   	pop    %ebx
  801f4d:	5e                   	pop    %esi
  801f4e:	5f                   	pop    %edi
  801f4f:	5d                   	pop    %ebp
  801f50:	c3                   	ret    
  801f51:	8d 76 00             	lea    0x0(%esi),%esi
  801f54:	2b 04 24             	sub    (%esp),%eax
  801f57:	19 fa                	sbb    %edi,%edx
  801f59:	89 d1                	mov    %edx,%ecx
  801f5b:	89 c6                	mov    %eax,%esi
  801f5d:	e9 71 ff ff ff       	jmp    801ed3 <__umoddi3+0xb3>
  801f62:	66 90                	xchg   %ax,%ax
  801f64:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f68:	72 ea                	jb     801f54 <__umoddi3+0x134>
  801f6a:	89 d9                	mov    %ebx,%ecx
  801f6c:	e9 62 ff ff ff       	jmp    801ed3 <__umoddi3+0xb3>
