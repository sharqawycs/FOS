
obj/user/tst_buffer_2_slave:     file format elf32-i386


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
  800031:	e8 74 06 00 00       	call   8006aa <libmain>
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
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80004e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 20 21 80 00       	push   $0x802120
  800065:	6a 17                	push   $0x17
  800067:	68 68 21 80 00       	push   $0x802168
  80006c:	e8 3b 07 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800084:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 20 21 80 00       	push   $0x802120
  80009b:	6a 18                	push   $0x18
  80009d:	68 68 21 80 00       	push   $0x802168
  8000a2:	e8 05 07 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 20 21 80 00       	push   $0x802120
  8000d1:	6a 19                	push   $0x19
  8000d3:	68 68 21 80 00       	push   $0x802168
  8000d8:	e8 cf 06 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 20 21 80 00       	push   $0x802120
  800107:	6a 1a                	push   $0x1a
  800109:	68 68 21 80 00       	push   $0x802168
  80010e:	e8 99 06 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800126:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 20 21 80 00       	push   $0x802120
  80013d:	6a 1b                	push   $0x1b
  80013f:	68 68 21 80 00       	push   $0x802168
  800144:	e8 63 06 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80015c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 20 21 80 00       	push   $0x802120
  800173:	6a 1c                	push   $0x1c
  800175:	68 68 21 80 00       	push   $0x802168
  80017a:	e8 2d 06 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800192:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 20 21 80 00       	push   $0x802120
  8001a9:	6a 1d                	push   $0x1d
  8001ab:	68 68 21 80 00       	push   $0x802168
  8001b0:	e8 f7 05 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001c8:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 20 21 80 00       	push   $0x802120
  8001df:	6a 1e                	push   $0x1e
  8001e1:	68 68 21 80 00       	push   $0x802168
  8001e6:	e8 c1 05 00 00       	call   8007ac <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8001fe:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 20 21 80 00       	push   $0x802120
  800215:	6a 20                	push   $0x20
  800217:	68 68 21 80 00       	push   $0x802168
  80021c:	e8 8b 05 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800234:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 20 21 80 00       	push   $0x802120
  80024b:	6a 21                	push   $0x21
  80024d:	68 68 21 80 00       	push   $0x802168
  800252:	e8 55 05 00 00       	call   8007ac <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80026a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 20 21 80 00       	push   $0x802120
  800281:	6a 22                	push   $0x22
  800283:	68 68 21 80 00       	push   $0x802168
  800288:	e8 1f 05 00 00       	call   8007ac <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 84 21 80 00       	push   $0x802184
  8002a4:	6a 23                	push   $0x23
  8002a6:	68 68 21 80 00       	push   $0x802168
  8002ab:	e8 fc 04 00 00       	call   8007ac <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b0:	e8 ba 16 00 00       	call   80196f <sys_calculate_modified_frames>
  8002b5:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002b8:	e8 cb 16 00 00       	call   801988 <sys_calculate_notmod_frames>
  8002bd:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c0:	e8 14 17 00 00       	call   8019d9 <sys_pf_calculate_allocated_pages>
  8002c5:	89 45 a4             	mov    %eax,-0x5c(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8002f9:	e8 8a 16 00 00       	call   801988 <sys_calculate_notmod_frames>
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
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  800312:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800319:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800320:	7e c4                	jle    8002e6 <_main+0x2ae>
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}



	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800322:	e8 61 16 00 00       	call   801988 <sys_calculate_notmod_frames>
  800327:	89 c2                	mov    %eax,%edx
  800329:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80032c:	29 c2                	sub    %eax,%edx
  80032e:	89 d0                	mov    %edx,%eax
  800330:	83 f8 07             	cmp    $0x7,%eax
  800333:	74 14                	je     800349 <_main+0x311>
  800335:	83 ec 04             	sub    $0x4,%esp
  800338:	68 d4 21 80 00       	push   $0x8021d4
  80033d:	6a 37                	push   $0x37
  80033f:	68 68 21 80 00       	push   $0x802168
  800344:	e8 63 04 00 00       	call   8007ac <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800349:	e8 21 16 00 00       	call   80196f <sys_calculate_modified_frames>
  80034e:	89 c2                	mov    %eax,%edx
  800350:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	74 14                	je     80036b <_main+0x333>
  800357:	83 ec 04             	sub    $0x4,%esp
  80035a:	68 38 22 80 00       	push   $0x802238
  80035f:	6a 38                	push   $0x38
  800361:	68 68 21 80 00       	push   $0x802168
  800366:	e8 41 04 00 00       	call   8007ac <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  80036b:	e8 18 16 00 00       	call   801988 <sys_calculate_notmod_frames>
  800370:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800373:	e8 f7 15 00 00       	call   80196f <sys_calculate_modified_frames>
  800378:	89 45 ac             	mov    %eax,-0x54(%ebp)

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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800398:	e8 eb 15 00 00       	call   801988 <sys_calculate_notmod_frames>
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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c1:	e8 c2 15 00 00       	call   801988 <sys_calculate_notmod_frames>
  8003c6:	89 c2                	mov    %eax,%edx
  8003c8:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003cb:	39 c2                	cmp    %eax,%edx
  8003cd:	74 14                	je     8003e3 <_main+0x3ab>
  8003cf:	83 ec 04             	sub    $0x4,%esp
  8003d2:	68 d4 21 80 00       	push   $0x8021d4
  8003d7:	6a 47                	push   $0x47
  8003d9:	68 68 21 80 00       	push   $0x802168
  8003de:	e8 c9 03 00 00       	call   8007ac <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003e3:	e8 87 15 00 00       	call   80196f <sys_calculate_modified_frames>
  8003e8:	89 c2                	mov    %eax,%edx
  8003ea:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003ed:	29 c2                	sub    %eax,%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	83 f8 07             	cmp    $0x7,%eax
  8003f4:	74 14                	je     80040a <_main+0x3d2>
  8003f6:	83 ec 04             	sub    $0x4,%esp
  8003f9:	68 38 22 80 00       	push   $0x802238
  8003fe:	6a 48                	push   $0x48
  800400:	68 68 21 80 00       	push   $0x802168
  800405:	e8 a2 03 00 00       	call   8007ac <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  80040a:	e8 79 15 00 00       	call   801988 <sys_calculate_notmod_frames>
  80040f:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  800412:	e8 58 15 00 00       	call   80196f <sys_calculate_modified_frames>
  800417:	89 45 ac             	mov    %eax,-0x54(%ebp)

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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  80043e:	e8 45 15 00 00       	call   801988 <sys_calculate_notmod_frames>
  800443:	89 c2                	mov    %eax,%edx
  800445:	a1 20 30 80 00       	mov    0x803020,%eax
  80044a:	8b 40 4c             	mov    0x4c(%eax),%eax
  80044d:	01 c2                	add    %eax,%edx
  80044f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800452:	01 d0                	add    %edx,%eax
  800454:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)

	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800457:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80045e:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800465:	7e ca                	jle    800431 <_main+0x3f9>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800467:	e8 1c 15 00 00       	call   801988 <sys_calculate_notmod_frames>
  80046c:	89 c2                	mov    %eax,%edx
  80046e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800471:	29 c2                	sub    %eax,%edx
  800473:	89 d0                	mov    %edx,%eax
  800475:	83 f8 07             	cmp    $0x7,%eax
  800478:	74 14                	je     80048e <_main+0x456>
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	68 d4 21 80 00       	push   $0x8021d4
  800482:	6a 56                	push   $0x56
  800484:	68 68 21 80 00       	push   $0x802168
  800489:	e8 1e 03 00 00       	call   8007ac <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  80048e:	e8 dc 14 00 00       	call   80196f <sys_calculate_modified_frames>
  800493:	89 c2                	mov    %eax,%edx
  800495:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800498:	29 c2                	sub    %eax,%edx
  80049a:	89 d0                	mov    %edx,%eax
  80049c:	83 f8 f9             	cmp    $0xfffffff9,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 38 22 80 00       	push   $0x802238
  8004a9:	6a 57                	push   $0x57
  8004ab:	68 68 21 80 00       	push   $0x802168
  8004b0:	e8 f7 02 00 00       	call   8007ac <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004b5:	e8 ce 14 00 00       	call   801988 <sys_calculate_notmod_frames>
  8004ba:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004bd:	e8 ad 14 00 00       	call   80196f <sys_calculate_modified_frames>
  8004c2:	89 45 ac             	mov    %eax,-0x54(%ebp)

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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004e9:	e8 9a 14 00 00       	call   801988 <sys_calculate_notmod_frames>
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
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800512:	e8 71 14 00 00       	call   801988 <sys_calculate_notmod_frames>
  800517:	89 c2                	mov    %eax,%edx
  800519:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80051c:	29 c2                	sub    %eax,%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	83 f8 f9             	cmp    $0xfffffff9,%eax
  800523:	74 14                	je     800539 <_main+0x501>
  800525:	83 ec 04             	sub    $0x4,%esp
  800528:	68 d4 21 80 00       	push   $0x8021d4
  80052d:	6a 65                	push   $0x65
  80052f:	68 68 21 80 00       	push   $0x802168
  800534:	e8 73 02 00 00       	call   8007ac <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800539:	e8 31 14 00 00       	call   80196f <sys_calculate_modified_frames>
  80053e:	89 c2                	mov    %eax,%edx
  800540:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800543:	29 c2                	sub    %eax,%edx
  800545:	89 d0                	mov    %edx,%eax
  800547:	83 f8 07             	cmp    $0x7,%eax
  80054a:	74 14                	je     800560 <_main+0x528>
  80054c:	83 ec 04             	sub    $0x4,%esp
  80054f:	68 38 22 80 00       	push   $0x802238
  800554:	6a 66                	push   $0x66
  800556:	68 68 21 80 00       	push   $0x802168
  80055b:	e8 4c 02 00 00       	call   8007ac <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800560:	e8 74 14 00 00       	call   8019d9 <sys_pf_calculate_allocated_pages>
  800565:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 a4 22 80 00       	push   $0x8022a4
  800572:	6a 68                	push   $0x68
  800574:	68 68 21 80 00       	push   $0x802168
  800579:	e8 2e 02 00 00       	call   8007ac <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  80057e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800581:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800584:	75 08                	jne    80058e <_main+0x556>
  800586:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800589:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80058c:	74 14                	je     8005a2 <_main+0x56a>
  80058e:	83 ec 04             	sub    $0x4,%esp
  800591:	68 14 23 80 00       	push   $0x802314
  800596:	6a 6a                	push   $0x6a
  800598:	68 68 21 80 00       	push   $0x802168
  80059d:	e8 0a 02 00 00       	call   8007ac <_panic>

	/*[5] BUSY-WAIT FOR A WHILE TILL FINISHING THE MASTER PROGRAM */
	env_sleep(5000);
  8005a2:	83 ec 0c             	sub    $0xc,%esp
  8005a5:	68 88 13 00 00       	push   $0x1388
  8005aa:	e8 55 18 00 00       	call   801e04 <env_sleep>
  8005af:	83 c4 10             	add    $0x10,%esp

	/*[6] Read the modified pages of this slave program (after they have been written on page file) */
	initFreeBufCnt = sys_calculate_notmod_frames();
  8005b2:	e8 d1 13 00 00       	call   801988 <sys_calculate_notmod_frames>
  8005b7:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8005ba:	e8 b0 13 00 00       	call   80196f <sys_calculate_modified_frames>
  8005bf:	89 45 ac             	mov    %eax,-0x54(%ebp)
	i = 0;
  8005c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum3 = 0 ;
  8005c9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	dummy = 0;
  8005d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  8005d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005de:	eb 2d                	jmp    80060d <_main+0x5d5>
	{
		dstSum3 += dst[i];
  8005e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e3:	8b 04 85 40 30 80 00 	mov    0x803040(,%eax,4),%eax
  8005ea:	01 45 dc             	add    %eax,-0x24(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005ed:	e8 96 13 00 00       	call   801988 <sys_calculate_notmod_frames>
  8005f2:	89 c2                	mov    %eax,%edx
  8005f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f9:	8b 40 4c             	mov    0x4c(%eax),%eax
  8005fc:	01 c2                	add    %eax,%edx
  8005fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800601:	01 d0                	add    %edx,%eax
  800603:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initFreeBufCnt = sys_calculate_notmod_frames();
	initModBufCnt = sys_calculate_modified_frames();
	i = 0;
	int dstSum3 = 0 ;
	dummy = 0;
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  800606:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  80060d:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800614:	7e ca                	jle    8005e0 <_main+0x5a8>
	{
		dstSum3 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  800616:	e8 6d 13 00 00       	call   801988 <sys_calculate_notmod_frames>
  80061b:	89 c2                	mov    %eax,%edx
  80061d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800620:	39 c2                	cmp    %eax,%edx
  800622:	74 14                	je     800638 <_main+0x600>
  800624:	83 ec 04             	sub    $0x4,%esp
  800627:	68 d4 21 80 00       	push   $0x8021d4
  80062c:	6a 7b                	push   $0x7b
  80062e:	68 68 21 80 00       	push   $0x802168
  800633:	e8 74 01 00 00       	call   8007ac <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800638:	e8 32 13 00 00       	call   80196f <sys_calculate_modified_frames>
  80063d:	89 c2                	mov    %eax,%edx
  80063f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800642:	39 c2                	cmp    %eax,%edx
  800644:	74 14                	je     80065a <_main+0x622>
  800646:	83 ec 04             	sub    $0x4,%esp
  800649:	68 38 22 80 00       	push   $0x802238
  80064e:	6a 7c                	push   $0x7c
  800650:	68 68 21 80 00       	push   $0x802168
  800655:	e8 52 01 00 00       	call   8007ac <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  80065a:	e8 7a 13 00 00       	call   8019d9 <sys_pf_calculate_allocated_pages>
  80065f:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800662:	74 14                	je     800678 <_main+0x640>
  800664:	83 ec 04             	sub    $0x4,%esp
  800667:	68 a4 22 80 00       	push   $0x8022a4
  80066c:	6a 7e                	push   $0x7e
  80066e:	68 68 21 80 00       	push   $0x802168
  800673:	e8 34 01 00 00       	call   8007ac <_panic>

	if (dstSum1 != dstSum3) 	panic("Error in buffering/restoring modified pages after freeing the modified list") ;
  800678:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067b:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80067e:	74 17                	je     800697 <_main+0x65f>
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 50 23 80 00       	push   $0x802350
  800688:	68 80 00 00 00       	push   $0x80
  80068d:	68 68 21 80 00       	push   $0x802168
  800692:	e8 15 01 00 00       	call   8007ac <_panic>

	cprintf("Congratulations!! modified list is cleared and updated successfully.\n");
  800697:	83 ec 0c             	sub    $0xc,%esp
  80069a:	68 9c 23 80 00       	push   $0x80239c
  80069f:	e8 bc 03 00 00       	call   800a60 <cprintf>
  8006a4:	83 c4 10             	add    $0x10,%esp

	return;
  8006a7:	90                   	nop

}
  8006a8:	c9                   	leave  
  8006a9:	c3                   	ret    

008006aa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006aa:	55                   	push   %ebp
  8006ab:	89 e5                	mov    %esp,%ebp
  8006ad:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006b0:	e8 d6 11 00 00       	call   80188b <sys_getenvindex>
  8006b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bb:	89 d0                	mov    %edx,%eax
  8006bd:	01 c0                	add    %eax,%eax
  8006bf:	01 d0                	add    %edx,%eax
  8006c1:	c1 e0 02             	shl    $0x2,%eax
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	c1 e0 06             	shl    $0x6,%eax
  8006c9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006ce:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8006d8:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8006de:	84 c0                	test   %al,%al
  8006e0:	74 0f                	je     8006f1 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8006e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e7:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006ec:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006f1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006f5:	7e 0a                	jle    800701 <libmain+0x57>
		binaryname = argv[0];
  8006f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	ff 75 08             	pushl  0x8(%ebp)
  80070a:	e8 29 f9 ff ff       	call   800038 <_main>
  80070f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800712:	e8 0f 13 00 00       	call   801a26 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800717:	83 ec 0c             	sub    $0xc,%esp
  80071a:	68 fc 23 80 00       	push   $0x8023fc
  80071f:	e8 3c 03 00 00       	call   800a60 <cprintf>
  800724:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800727:	a1 20 30 80 00       	mov    0x803020,%eax
  80072c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800732:	a1 20 30 80 00       	mov    0x803020,%eax
  800737:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80073d:	83 ec 04             	sub    $0x4,%esp
  800740:	52                   	push   %edx
  800741:	50                   	push   %eax
  800742:	68 24 24 80 00       	push   $0x802424
  800747:	e8 14 03 00 00       	call   800a60 <cprintf>
  80074c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80074f:	a1 20 30 80 00       	mov    0x803020,%eax
  800754:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	50                   	push   %eax
  80075e:	68 49 24 80 00       	push   $0x802449
  800763:	e8 f8 02 00 00       	call   800a60 <cprintf>
  800768:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80076b:	83 ec 0c             	sub    $0xc,%esp
  80076e:	68 fc 23 80 00       	push   $0x8023fc
  800773:	e8 e8 02 00 00       	call   800a60 <cprintf>
  800778:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077b:	e8 c0 12 00 00       	call   801a40 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800780:	e8 19 00 00 00       	call   80079e <exit>
}
  800785:	90                   	nop
  800786:	c9                   	leave  
  800787:	c3                   	ret    

00800788 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800788:	55                   	push   %ebp
  800789:	89 e5                	mov    %esp,%ebp
  80078b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80078e:	83 ec 0c             	sub    $0xc,%esp
  800791:	6a 00                	push   $0x0
  800793:	e8 bf 10 00 00       	call   801857 <sys_env_destroy>
  800798:	83 c4 10             	add    $0x10,%esp
}
  80079b:	90                   	nop
  80079c:	c9                   	leave  
  80079d:	c3                   	ret    

0080079e <exit>:

void
exit(void)
{
  80079e:	55                   	push   %ebp
  80079f:	89 e5                	mov    %esp,%ebp
  8007a1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007a4:	e8 14 11 00 00       	call   8018bd <sys_env_exit>
}
  8007a9:	90                   	nop
  8007aa:	c9                   	leave  
  8007ab:	c3                   	ret    

008007ac <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007ac:	55                   	push   %ebp
  8007ad:	89 e5                	mov    %esp,%ebp
  8007af:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007b2:	8d 45 10             	lea    0x10(%ebp),%eax
  8007b5:	83 c0 04             	add    $0x4,%eax
  8007b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007bb:	a1 64 30 81 00       	mov    0x813064,%eax
  8007c0:	85 c0                	test   %eax,%eax
  8007c2:	74 16                	je     8007da <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007c4:	a1 64 30 81 00       	mov    0x813064,%eax
  8007c9:	83 ec 08             	sub    $0x8,%esp
  8007cc:	50                   	push   %eax
  8007cd:	68 60 24 80 00       	push   $0x802460
  8007d2:	e8 89 02 00 00       	call   800a60 <cprintf>
  8007d7:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007da:	a1 00 30 80 00       	mov    0x803000,%eax
  8007df:	ff 75 0c             	pushl  0xc(%ebp)
  8007e2:	ff 75 08             	pushl  0x8(%ebp)
  8007e5:	50                   	push   %eax
  8007e6:	68 65 24 80 00       	push   $0x802465
  8007eb:	e8 70 02 00 00       	call   800a60 <cprintf>
  8007f0:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f6:	83 ec 08             	sub    $0x8,%esp
  8007f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fc:	50                   	push   %eax
  8007fd:	e8 f3 01 00 00       	call   8009f5 <vcprintf>
  800802:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	6a 00                	push   $0x0
  80080a:	68 81 24 80 00       	push   $0x802481
  80080f:	e8 e1 01 00 00       	call   8009f5 <vcprintf>
  800814:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800817:	e8 82 ff ff ff       	call   80079e <exit>

	// should not return here
	while (1) ;
  80081c:	eb fe                	jmp    80081c <_panic+0x70>

0080081e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80081e:	55                   	push   %ebp
  80081f:	89 e5                	mov    %esp,%ebp
  800821:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800824:	a1 20 30 80 00       	mov    0x803020,%eax
  800829:	8b 50 74             	mov    0x74(%eax),%edx
  80082c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082f:	39 c2                	cmp    %eax,%edx
  800831:	74 14                	je     800847 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800833:	83 ec 04             	sub    $0x4,%esp
  800836:	68 84 24 80 00       	push   $0x802484
  80083b:	6a 26                	push   $0x26
  80083d:	68 d0 24 80 00       	push   $0x8024d0
  800842:	e8 65 ff ff ff       	call   8007ac <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800847:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80084e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800855:	e9 c2 00 00 00       	jmp    80091c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80085a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800864:	8b 45 08             	mov    0x8(%ebp),%eax
  800867:	01 d0                	add    %edx,%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	85 c0                	test   %eax,%eax
  80086d:	75 08                	jne    800877 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80086f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800872:	e9 a2 00 00 00       	jmp    800919 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800877:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800885:	eb 69                	jmp    8008f0 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800887:	a1 20 30 80 00       	mov    0x803020,%eax
  80088c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800892:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800895:	89 d0                	mov    %edx,%eax
  800897:	01 c0                	add    %eax,%eax
  800899:	01 d0                	add    %edx,%eax
  80089b:	c1 e0 02             	shl    $0x2,%eax
  80089e:	01 c8                	add    %ecx,%eax
  8008a0:	8a 40 04             	mov    0x4(%eax),%al
  8008a3:	84 c0                	test   %al,%al
  8008a5:	75 46                	jne    8008ed <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8008ac:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008b2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008b5:	89 d0                	mov    %edx,%eax
  8008b7:	01 c0                	add    %eax,%eax
  8008b9:	01 d0                	add    %edx,%eax
  8008bb:	c1 e0 02             	shl    $0x2,%eax
  8008be:	01 c8                	add    %ecx,%eax
  8008c0:	8b 00                	mov    (%eax),%eax
  8008c2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008cd:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	01 c8                	add    %ecx,%eax
  8008de:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008e0:	39 c2                	cmp    %eax,%edx
  8008e2:	75 09                	jne    8008ed <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008e4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008eb:	eb 12                	jmp    8008ff <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ed:	ff 45 e8             	incl   -0x18(%ebp)
  8008f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8008f5:	8b 50 74             	mov    0x74(%eax),%edx
  8008f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008fb:	39 c2                	cmp    %eax,%edx
  8008fd:	77 88                	ja     800887 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800903:	75 14                	jne    800919 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800905:	83 ec 04             	sub    $0x4,%esp
  800908:	68 dc 24 80 00       	push   $0x8024dc
  80090d:	6a 3a                	push   $0x3a
  80090f:	68 d0 24 80 00       	push   $0x8024d0
  800914:	e8 93 fe ff ff       	call   8007ac <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800919:	ff 45 f0             	incl   -0x10(%ebp)
  80091c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800922:	0f 8c 32 ff ff ff    	jl     80085a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800928:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80092f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800936:	eb 26                	jmp    80095e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800938:	a1 20 30 80 00       	mov    0x803020,%eax
  80093d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800943:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800946:	89 d0                	mov    %edx,%eax
  800948:	01 c0                	add    %eax,%eax
  80094a:	01 d0                	add    %edx,%eax
  80094c:	c1 e0 02             	shl    $0x2,%eax
  80094f:	01 c8                	add    %ecx,%eax
  800951:	8a 40 04             	mov    0x4(%eax),%al
  800954:	3c 01                	cmp    $0x1,%al
  800956:	75 03                	jne    80095b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800958:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80095b:	ff 45 e0             	incl   -0x20(%ebp)
  80095e:	a1 20 30 80 00       	mov    0x803020,%eax
  800963:	8b 50 74             	mov    0x74(%eax),%edx
  800966:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800969:	39 c2                	cmp    %eax,%edx
  80096b:	77 cb                	ja     800938 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80096d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800970:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800973:	74 14                	je     800989 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800975:	83 ec 04             	sub    $0x4,%esp
  800978:	68 30 25 80 00       	push   $0x802530
  80097d:	6a 44                	push   $0x44
  80097f:	68 d0 24 80 00       	push   $0x8024d0
  800984:	e8 23 fe ff ff       	call   8007ac <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800989:	90                   	nop
  80098a:	c9                   	leave  
  80098b:	c3                   	ret    

0080098c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80098c:	55                   	push   %ebp
  80098d:	89 e5                	mov    %esp,%ebp
  80098f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800992:	8b 45 0c             	mov    0xc(%ebp),%eax
  800995:	8b 00                	mov    (%eax),%eax
  800997:	8d 48 01             	lea    0x1(%eax),%ecx
  80099a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099d:	89 0a                	mov    %ecx,(%edx)
  80099f:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a2:	88 d1                	mov    %dl,%cl
  8009a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ae:	8b 00                	mov    (%eax),%eax
  8009b0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009b5:	75 2c                	jne    8009e3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009b7:	a0 24 30 80 00       	mov    0x803024,%al
  8009bc:	0f b6 c0             	movzbl %al,%eax
  8009bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c2:	8b 12                	mov    (%edx),%edx
  8009c4:	89 d1                	mov    %edx,%ecx
  8009c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c9:	83 c2 08             	add    $0x8,%edx
  8009cc:	83 ec 04             	sub    $0x4,%esp
  8009cf:	50                   	push   %eax
  8009d0:	51                   	push   %ecx
  8009d1:	52                   	push   %edx
  8009d2:	e8 3e 0e 00 00       	call   801815 <sys_cputs>
  8009d7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e6:	8b 40 04             	mov    0x4(%eax),%eax
  8009e9:	8d 50 01             	lea    0x1(%eax),%edx
  8009ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ef:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009f2:	90                   	nop
  8009f3:	c9                   	leave  
  8009f4:	c3                   	ret    

008009f5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009f5:	55                   	push   %ebp
  8009f6:	89 e5                	mov    %esp,%ebp
  8009f8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a05:	00 00 00 
	b.cnt = 0;
  800a08:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a0f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a12:	ff 75 0c             	pushl  0xc(%ebp)
  800a15:	ff 75 08             	pushl  0x8(%ebp)
  800a18:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a1e:	50                   	push   %eax
  800a1f:	68 8c 09 80 00       	push   $0x80098c
  800a24:	e8 11 02 00 00       	call   800c3a <vprintfmt>
  800a29:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a2c:	a0 24 30 80 00       	mov    0x803024,%al
  800a31:	0f b6 c0             	movzbl %al,%eax
  800a34:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a3a:	83 ec 04             	sub    $0x4,%esp
  800a3d:	50                   	push   %eax
  800a3e:	52                   	push   %edx
  800a3f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a45:	83 c0 08             	add    $0x8,%eax
  800a48:	50                   	push   %eax
  800a49:	e8 c7 0d 00 00       	call   801815 <sys_cputs>
  800a4e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a51:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800a58:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a5e:	c9                   	leave  
  800a5f:	c3                   	ret    

00800a60 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a60:	55                   	push   %ebp
  800a61:	89 e5                	mov    %esp,%ebp
  800a63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a66:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800a6d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a70:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a73:	8b 45 08             	mov    0x8(%ebp),%eax
  800a76:	83 ec 08             	sub    $0x8,%esp
  800a79:	ff 75 f4             	pushl  -0xc(%ebp)
  800a7c:	50                   	push   %eax
  800a7d:	e8 73 ff ff ff       	call   8009f5 <vcprintf>
  800a82:	83 c4 10             	add    $0x10,%esp
  800a85:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a8b:	c9                   	leave  
  800a8c:	c3                   	ret    

00800a8d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a8d:	55                   	push   %ebp
  800a8e:	89 e5                	mov    %esp,%ebp
  800a90:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a93:	e8 8e 0f 00 00       	call   801a26 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a98:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	83 ec 08             	sub    $0x8,%esp
  800aa4:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa7:	50                   	push   %eax
  800aa8:	e8 48 ff ff ff       	call   8009f5 <vcprintf>
  800aad:	83 c4 10             	add    $0x10,%esp
  800ab0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ab3:	e8 88 0f 00 00       	call   801a40 <sys_enable_interrupt>
	return cnt;
  800ab8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800abb:	c9                   	leave  
  800abc:	c3                   	ret    

00800abd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800abd:	55                   	push   %ebp
  800abe:	89 e5                	mov    %esp,%ebp
  800ac0:	53                   	push   %ebx
  800ac1:	83 ec 14             	sub    $0x14,%esp
  800ac4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aca:	8b 45 14             	mov    0x14(%ebp),%eax
  800acd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ad0:	8b 45 18             	mov    0x18(%ebp),%eax
  800ad3:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800adb:	77 55                	ja     800b32 <printnum+0x75>
  800add:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae0:	72 05                	jb     800ae7 <printnum+0x2a>
  800ae2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ae5:	77 4b                	ja     800b32 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ae7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aed:	8b 45 18             	mov    0x18(%ebp),%eax
  800af0:	ba 00 00 00 00       	mov    $0x0,%edx
  800af5:	52                   	push   %edx
  800af6:	50                   	push   %eax
  800af7:	ff 75 f4             	pushl  -0xc(%ebp)
  800afa:	ff 75 f0             	pushl  -0x10(%ebp)
  800afd:	e8 b6 13 00 00       	call   801eb8 <__udivdi3>
  800b02:	83 c4 10             	add    $0x10,%esp
  800b05:	83 ec 04             	sub    $0x4,%esp
  800b08:	ff 75 20             	pushl  0x20(%ebp)
  800b0b:	53                   	push   %ebx
  800b0c:	ff 75 18             	pushl  0x18(%ebp)
  800b0f:	52                   	push   %edx
  800b10:	50                   	push   %eax
  800b11:	ff 75 0c             	pushl  0xc(%ebp)
  800b14:	ff 75 08             	pushl  0x8(%ebp)
  800b17:	e8 a1 ff ff ff       	call   800abd <printnum>
  800b1c:	83 c4 20             	add    $0x20,%esp
  800b1f:	eb 1a                	jmp    800b3b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b21:	83 ec 08             	sub    $0x8,%esp
  800b24:	ff 75 0c             	pushl  0xc(%ebp)
  800b27:	ff 75 20             	pushl  0x20(%ebp)
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	ff d0                	call   *%eax
  800b2f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b32:	ff 4d 1c             	decl   0x1c(%ebp)
  800b35:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b39:	7f e6                	jg     800b21 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b3b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b3e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b49:	53                   	push   %ebx
  800b4a:	51                   	push   %ecx
  800b4b:	52                   	push   %edx
  800b4c:	50                   	push   %eax
  800b4d:	e8 76 14 00 00       	call   801fc8 <__umoddi3>
  800b52:	83 c4 10             	add    $0x10,%esp
  800b55:	05 94 27 80 00       	add    $0x802794,%eax
  800b5a:	8a 00                	mov    (%eax),%al
  800b5c:	0f be c0             	movsbl %al,%eax
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 0c             	pushl  0xc(%ebp)
  800b65:	50                   	push   %eax
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	ff d0                	call   *%eax
  800b6b:	83 c4 10             	add    $0x10,%esp
}
  800b6e:	90                   	nop
  800b6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b72:	c9                   	leave  
  800b73:	c3                   	ret    

00800b74 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b74:	55                   	push   %ebp
  800b75:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b77:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b7b:	7e 1c                	jle    800b99 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 50 08             	lea    0x8(%eax),%edx
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 10                	mov    %edx,(%eax)
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	83 e8 08             	sub    $0x8,%eax
  800b92:	8b 50 04             	mov    0x4(%eax),%edx
  800b95:	8b 00                	mov    (%eax),%eax
  800b97:	eb 40                	jmp    800bd9 <getuint+0x65>
	else if (lflag)
  800b99:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9d:	74 1e                	je     800bbd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	8b 00                	mov    (%eax),%eax
  800ba4:	8d 50 04             	lea    0x4(%eax),%edx
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	89 10                	mov    %edx,(%eax)
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8b 00                	mov    (%eax),%eax
  800bb1:	83 e8 04             	sub    $0x4,%eax
  800bb4:	8b 00                	mov    (%eax),%eax
  800bb6:	ba 00 00 00 00       	mov    $0x0,%edx
  800bbb:	eb 1c                	jmp    800bd9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	8b 00                	mov    (%eax),%eax
  800bc2:	8d 50 04             	lea    0x4(%eax),%edx
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	89 10                	mov    %edx,(%eax)
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	83 e8 04             	sub    $0x4,%eax
  800bd2:	8b 00                	mov    (%eax),%eax
  800bd4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800bd9:	5d                   	pop    %ebp
  800bda:	c3                   	ret    

00800bdb <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bdb:	55                   	push   %ebp
  800bdc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bde:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800be2:	7e 1c                	jle    800c00 <getint+0x25>
		return va_arg(*ap, long long);
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	8b 00                	mov    (%eax),%eax
  800be9:	8d 50 08             	lea    0x8(%eax),%edx
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	89 10                	mov    %edx,(%eax)
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	83 e8 08             	sub    $0x8,%eax
  800bf9:	8b 50 04             	mov    0x4(%eax),%edx
  800bfc:	8b 00                	mov    (%eax),%eax
  800bfe:	eb 38                	jmp    800c38 <getint+0x5d>
	else if (lflag)
  800c00:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c04:	74 1a                	je     800c20 <getint+0x45>
		return va_arg(*ap, long);
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	8d 50 04             	lea    0x4(%eax),%edx
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c11:	89 10                	mov    %edx,(%eax)
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8b 00                	mov    (%eax),%eax
  800c18:	83 e8 04             	sub    $0x4,%eax
  800c1b:	8b 00                	mov    (%eax),%eax
  800c1d:	99                   	cltd   
  800c1e:	eb 18                	jmp    800c38 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8b 00                	mov    (%eax),%eax
  800c25:	8d 50 04             	lea    0x4(%eax),%edx
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	89 10                	mov    %edx,(%eax)
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	8b 00                	mov    (%eax),%eax
  800c32:	83 e8 04             	sub    $0x4,%eax
  800c35:	8b 00                	mov    (%eax),%eax
  800c37:	99                   	cltd   
}
  800c38:	5d                   	pop    %ebp
  800c39:	c3                   	ret    

00800c3a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c3a:	55                   	push   %ebp
  800c3b:	89 e5                	mov    %esp,%ebp
  800c3d:	56                   	push   %esi
  800c3e:	53                   	push   %ebx
  800c3f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c42:	eb 17                	jmp    800c5b <vprintfmt+0x21>
			if (ch == '\0')
  800c44:	85 db                	test   %ebx,%ebx
  800c46:	0f 84 af 03 00 00    	je     800ffb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c4c:	83 ec 08             	sub    $0x8,%esp
  800c4f:	ff 75 0c             	pushl  0xc(%ebp)
  800c52:	53                   	push   %ebx
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	ff d0                	call   *%eax
  800c58:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5e:	8d 50 01             	lea    0x1(%eax),%edx
  800c61:	89 55 10             	mov    %edx,0x10(%ebp)
  800c64:	8a 00                	mov    (%eax),%al
  800c66:	0f b6 d8             	movzbl %al,%ebx
  800c69:	83 fb 25             	cmp    $0x25,%ebx
  800c6c:	75 d6                	jne    800c44 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c6e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c72:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c79:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c80:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c87:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c91:	8d 50 01             	lea    0x1(%eax),%edx
  800c94:	89 55 10             	mov    %edx,0x10(%ebp)
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	0f b6 d8             	movzbl %al,%ebx
  800c9c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c9f:	83 f8 55             	cmp    $0x55,%eax
  800ca2:	0f 87 2b 03 00 00    	ja     800fd3 <vprintfmt+0x399>
  800ca8:	8b 04 85 b8 27 80 00 	mov    0x8027b8(,%eax,4),%eax
  800caf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cb1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cb5:	eb d7                	jmp    800c8e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cb7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cbb:	eb d1                	jmp    800c8e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cbd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cc4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cc7:	89 d0                	mov    %edx,%eax
  800cc9:	c1 e0 02             	shl    $0x2,%eax
  800ccc:	01 d0                	add    %edx,%eax
  800cce:	01 c0                	add    %eax,%eax
  800cd0:	01 d8                	add    %ebx,%eax
  800cd2:	83 e8 30             	sub    $0x30,%eax
  800cd5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ce0:	83 fb 2f             	cmp    $0x2f,%ebx
  800ce3:	7e 3e                	jle    800d23 <vprintfmt+0xe9>
  800ce5:	83 fb 39             	cmp    $0x39,%ebx
  800ce8:	7f 39                	jg     800d23 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ced:	eb d5                	jmp    800cc4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cef:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf2:	83 c0 04             	add    $0x4,%eax
  800cf5:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf8:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfb:	83 e8 04             	sub    $0x4,%eax
  800cfe:	8b 00                	mov    (%eax),%eax
  800d00:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d03:	eb 1f                	jmp    800d24 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d09:	79 83                	jns    800c8e <vprintfmt+0x54>
				width = 0;
  800d0b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d12:	e9 77 ff ff ff       	jmp    800c8e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d17:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d1e:	e9 6b ff ff ff       	jmp    800c8e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d23:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d28:	0f 89 60 ff ff ff    	jns    800c8e <vprintfmt+0x54>
				width = precision, precision = -1;
  800d2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d34:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d3b:	e9 4e ff ff ff       	jmp    800c8e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d40:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d43:	e9 46 ff ff ff       	jmp    800c8e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d48:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4b:	83 c0 04             	add    $0x4,%eax
  800d4e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d51:	8b 45 14             	mov    0x14(%ebp),%eax
  800d54:	83 e8 04             	sub    $0x4,%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	83 ec 08             	sub    $0x8,%esp
  800d5c:	ff 75 0c             	pushl  0xc(%ebp)
  800d5f:	50                   	push   %eax
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	ff d0                	call   *%eax
  800d65:	83 c4 10             	add    $0x10,%esp
			break;
  800d68:	e9 89 02 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d70:	83 c0 04             	add    $0x4,%eax
  800d73:	89 45 14             	mov    %eax,0x14(%ebp)
  800d76:	8b 45 14             	mov    0x14(%ebp),%eax
  800d79:	83 e8 04             	sub    $0x4,%eax
  800d7c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d7e:	85 db                	test   %ebx,%ebx
  800d80:	79 02                	jns    800d84 <vprintfmt+0x14a>
				err = -err;
  800d82:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d84:	83 fb 64             	cmp    $0x64,%ebx
  800d87:	7f 0b                	jg     800d94 <vprintfmt+0x15a>
  800d89:	8b 34 9d 00 26 80 00 	mov    0x802600(,%ebx,4),%esi
  800d90:	85 f6                	test   %esi,%esi
  800d92:	75 19                	jne    800dad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d94:	53                   	push   %ebx
  800d95:	68 a5 27 80 00       	push   $0x8027a5
  800d9a:	ff 75 0c             	pushl  0xc(%ebp)
  800d9d:	ff 75 08             	pushl  0x8(%ebp)
  800da0:	e8 5e 02 00 00       	call   801003 <printfmt>
  800da5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800da8:	e9 49 02 00 00       	jmp    800ff6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800dad:	56                   	push   %esi
  800dae:	68 ae 27 80 00       	push   $0x8027ae
  800db3:	ff 75 0c             	pushl  0xc(%ebp)
  800db6:	ff 75 08             	pushl  0x8(%ebp)
  800db9:	e8 45 02 00 00       	call   801003 <printfmt>
  800dbe:	83 c4 10             	add    $0x10,%esp
			break;
  800dc1:	e9 30 02 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dc6:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc9:	83 c0 04             	add    $0x4,%eax
  800dcc:	89 45 14             	mov    %eax,0x14(%ebp)
  800dcf:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd2:	83 e8 04             	sub    $0x4,%eax
  800dd5:	8b 30                	mov    (%eax),%esi
  800dd7:	85 f6                	test   %esi,%esi
  800dd9:	75 05                	jne    800de0 <vprintfmt+0x1a6>
				p = "(null)";
  800ddb:	be b1 27 80 00       	mov    $0x8027b1,%esi
			if (width > 0 && padc != '-')
  800de0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de4:	7e 6d                	jle    800e53 <vprintfmt+0x219>
  800de6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dea:	74 67                	je     800e53 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800def:	83 ec 08             	sub    $0x8,%esp
  800df2:	50                   	push   %eax
  800df3:	56                   	push   %esi
  800df4:	e8 0c 03 00 00       	call   801105 <strnlen>
  800df9:	83 c4 10             	add    $0x10,%esp
  800dfc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dff:	eb 16                	jmp    800e17 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e01:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e05:	83 ec 08             	sub    $0x8,%esp
  800e08:	ff 75 0c             	pushl  0xc(%ebp)
  800e0b:	50                   	push   %eax
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	ff d0                	call   *%eax
  800e11:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e14:	ff 4d e4             	decl   -0x1c(%ebp)
  800e17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e1b:	7f e4                	jg     800e01 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e1d:	eb 34                	jmp    800e53 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e1f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e23:	74 1c                	je     800e41 <vprintfmt+0x207>
  800e25:	83 fb 1f             	cmp    $0x1f,%ebx
  800e28:	7e 05                	jle    800e2f <vprintfmt+0x1f5>
  800e2a:	83 fb 7e             	cmp    $0x7e,%ebx
  800e2d:	7e 12                	jle    800e41 <vprintfmt+0x207>
					putch('?', putdat);
  800e2f:	83 ec 08             	sub    $0x8,%esp
  800e32:	ff 75 0c             	pushl  0xc(%ebp)
  800e35:	6a 3f                	push   $0x3f
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	ff d0                	call   *%eax
  800e3c:	83 c4 10             	add    $0x10,%esp
  800e3f:	eb 0f                	jmp    800e50 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e41:	83 ec 08             	sub    $0x8,%esp
  800e44:	ff 75 0c             	pushl  0xc(%ebp)
  800e47:	53                   	push   %ebx
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e50:	ff 4d e4             	decl   -0x1c(%ebp)
  800e53:	89 f0                	mov    %esi,%eax
  800e55:	8d 70 01             	lea    0x1(%eax),%esi
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	0f be d8             	movsbl %al,%ebx
  800e5d:	85 db                	test   %ebx,%ebx
  800e5f:	74 24                	je     800e85 <vprintfmt+0x24b>
  800e61:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e65:	78 b8                	js     800e1f <vprintfmt+0x1e5>
  800e67:	ff 4d e0             	decl   -0x20(%ebp)
  800e6a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e6e:	79 af                	jns    800e1f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e70:	eb 13                	jmp    800e85 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	6a 20                	push   $0x20
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e82:	ff 4d e4             	decl   -0x1c(%ebp)
  800e85:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e89:	7f e7                	jg     800e72 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e8b:	e9 66 01 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e90:	83 ec 08             	sub    $0x8,%esp
  800e93:	ff 75 e8             	pushl  -0x18(%ebp)
  800e96:	8d 45 14             	lea    0x14(%ebp),%eax
  800e99:	50                   	push   %eax
  800e9a:	e8 3c fd ff ff       	call   800bdb <getint>
  800e9f:	83 c4 10             	add    $0x10,%esp
  800ea2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ea8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eae:	85 d2                	test   %edx,%edx
  800eb0:	79 23                	jns    800ed5 <vprintfmt+0x29b>
				putch('-', putdat);
  800eb2:	83 ec 08             	sub    $0x8,%esp
  800eb5:	ff 75 0c             	pushl  0xc(%ebp)
  800eb8:	6a 2d                	push   $0x2d
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	ff d0                	call   *%eax
  800ebf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ec2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ec5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec8:	f7 d8                	neg    %eax
  800eca:	83 d2 00             	adc    $0x0,%edx
  800ecd:	f7 da                	neg    %edx
  800ecf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ed5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800edc:	e9 bc 00 00 00       	jmp    800f9d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ee1:	83 ec 08             	sub    $0x8,%esp
  800ee4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee7:	8d 45 14             	lea    0x14(%ebp),%eax
  800eea:	50                   	push   %eax
  800eeb:	e8 84 fc ff ff       	call   800b74 <getuint>
  800ef0:	83 c4 10             	add    $0x10,%esp
  800ef3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ef9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f00:	e9 98 00 00 00       	jmp    800f9d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f05:	83 ec 08             	sub    $0x8,%esp
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	6a 58                	push   $0x58
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	ff d0                	call   *%eax
  800f12:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f15:	83 ec 08             	sub    $0x8,%esp
  800f18:	ff 75 0c             	pushl  0xc(%ebp)
  800f1b:	6a 58                	push   $0x58
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	ff d0                	call   *%eax
  800f22:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f25:	83 ec 08             	sub    $0x8,%esp
  800f28:	ff 75 0c             	pushl  0xc(%ebp)
  800f2b:	6a 58                	push   $0x58
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	ff d0                	call   *%eax
  800f32:	83 c4 10             	add    $0x10,%esp
			break;
  800f35:	e9 bc 00 00 00       	jmp    800ff6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f3a:	83 ec 08             	sub    $0x8,%esp
  800f3d:	ff 75 0c             	pushl  0xc(%ebp)
  800f40:	6a 30                	push   $0x30
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	ff d0                	call   *%eax
  800f47:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f4a:	83 ec 08             	sub    $0x8,%esp
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	6a 78                	push   $0x78
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	ff d0                	call   *%eax
  800f57:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f5a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5d:	83 c0 04             	add    $0x4,%eax
  800f60:	89 45 14             	mov    %eax,0x14(%ebp)
  800f63:	8b 45 14             	mov    0x14(%ebp),%eax
  800f66:	83 e8 04             	sub    $0x4,%eax
  800f69:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f75:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f7c:	eb 1f                	jmp    800f9d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f7e:	83 ec 08             	sub    $0x8,%esp
  800f81:	ff 75 e8             	pushl  -0x18(%ebp)
  800f84:	8d 45 14             	lea    0x14(%ebp),%eax
  800f87:	50                   	push   %eax
  800f88:	e8 e7 fb ff ff       	call   800b74 <getuint>
  800f8d:	83 c4 10             	add    $0x10,%esp
  800f90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f93:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f96:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f9d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fa4:	83 ec 04             	sub    $0x4,%esp
  800fa7:	52                   	push   %edx
  800fa8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fab:	50                   	push   %eax
  800fac:	ff 75 f4             	pushl  -0xc(%ebp)
  800faf:	ff 75 f0             	pushl  -0x10(%ebp)
  800fb2:	ff 75 0c             	pushl  0xc(%ebp)
  800fb5:	ff 75 08             	pushl  0x8(%ebp)
  800fb8:	e8 00 fb ff ff       	call   800abd <printnum>
  800fbd:	83 c4 20             	add    $0x20,%esp
			break;
  800fc0:	eb 34                	jmp    800ff6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fc2:	83 ec 08             	sub    $0x8,%esp
  800fc5:	ff 75 0c             	pushl  0xc(%ebp)
  800fc8:	53                   	push   %ebx
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	ff d0                	call   *%eax
  800fce:	83 c4 10             	add    $0x10,%esp
			break;
  800fd1:	eb 23                	jmp    800ff6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fd3:	83 ec 08             	sub    $0x8,%esp
  800fd6:	ff 75 0c             	pushl  0xc(%ebp)
  800fd9:	6a 25                	push   $0x25
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	ff d0                	call   *%eax
  800fe0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fe3:	ff 4d 10             	decl   0x10(%ebp)
  800fe6:	eb 03                	jmp    800feb <vprintfmt+0x3b1>
  800fe8:	ff 4d 10             	decl   0x10(%ebp)
  800feb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fee:	48                   	dec    %eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	3c 25                	cmp    $0x25,%al
  800ff3:	75 f3                	jne    800fe8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ff5:	90                   	nop
		}
	}
  800ff6:	e9 47 fc ff ff       	jmp    800c42 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ffb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ffc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fff:	5b                   	pop    %ebx
  801000:	5e                   	pop    %esi
  801001:	5d                   	pop    %ebp
  801002:	c3                   	ret    

00801003 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801003:	55                   	push   %ebp
  801004:	89 e5                	mov    %esp,%ebp
  801006:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801009:	8d 45 10             	lea    0x10(%ebp),%eax
  80100c:	83 c0 04             	add    $0x4,%eax
  80100f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801012:	8b 45 10             	mov    0x10(%ebp),%eax
  801015:	ff 75 f4             	pushl  -0xc(%ebp)
  801018:	50                   	push   %eax
  801019:	ff 75 0c             	pushl  0xc(%ebp)
  80101c:	ff 75 08             	pushl  0x8(%ebp)
  80101f:	e8 16 fc ff ff       	call   800c3a <vprintfmt>
  801024:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801027:	90                   	nop
  801028:	c9                   	leave  
  801029:	c3                   	ret    

0080102a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80102a:	55                   	push   %ebp
  80102b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80102d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801030:	8b 40 08             	mov    0x8(%eax),%eax
  801033:	8d 50 01             	lea    0x1(%eax),%edx
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103f:	8b 10                	mov    (%eax),%edx
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	8b 40 04             	mov    0x4(%eax),%eax
  801047:	39 c2                	cmp    %eax,%edx
  801049:	73 12                	jae    80105d <sprintputch+0x33>
		*b->buf++ = ch;
  80104b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104e:	8b 00                	mov    (%eax),%eax
  801050:	8d 48 01             	lea    0x1(%eax),%ecx
  801053:	8b 55 0c             	mov    0xc(%ebp),%edx
  801056:	89 0a                	mov    %ecx,(%edx)
  801058:	8b 55 08             	mov    0x8(%ebp),%edx
  80105b:	88 10                	mov    %dl,(%eax)
}
  80105d:	90                   	nop
  80105e:	5d                   	pop    %ebp
  80105f:	c3                   	ret    

00801060 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801060:	55                   	push   %ebp
  801061:	89 e5                	mov    %esp,%ebp
  801063:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80106c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	01 d0                	add    %edx,%eax
  801077:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801081:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801085:	74 06                	je     80108d <vsnprintf+0x2d>
  801087:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80108b:	7f 07                	jg     801094 <vsnprintf+0x34>
		return -E_INVAL;
  80108d:	b8 03 00 00 00       	mov    $0x3,%eax
  801092:	eb 20                	jmp    8010b4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801094:	ff 75 14             	pushl  0x14(%ebp)
  801097:	ff 75 10             	pushl  0x10(%ebp)
  80109a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80109d:	50                   	push   %eax
  80109e:	68 2a 10 80 00       	push   $0x80102a
  8010a3:	e8 92 fb ff ff       	call   800c3a <vprintfmt>
  8010a8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010ae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010b4:	c9                   	leave  
  8010b5:	c3                   	ret    

008010b6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010b6:	55                   	push   %ebp
  8010b7:	89 e5                	mov    %esp,%ebp
  8010b9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010bc:	8d 45 10             	lea    0x10(%ebp),%eax
  8010bf:	83 c0 04             	add    $0x4,%eax
  8010c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8010cb:	50                   	push   %eax
  8010cc:	ff 75 0c             	pushl  0xc(%ebp)
  8010cf:	ff 75 08             	pushl  0x8(%ebp)
  8010d2:	e8 89 ff ff ff       	call   801060 <vsnprintf>
  8010d7:	83 c4 10             	add    $0x10,%esp
  8010da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010e0:	c9                   	leave  
  8010e1:	c3                   	ret    

008010e2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8010e2:	55                   	push   %ebp
  8010e3:	89 e5                	mov    %esp,%ebp
  8010e5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8010e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010ef:	eb 06                	jmp    8010f7 <strlen+0x15>
		n++;
  8010f1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8010f4:	ff 45 08             	incl   0x8(%ebp)
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	84 c0                	test   %al,%al
  8010fe:	75 f1                	jne    8010f1 <strlen+0xf>
		n++;
	return n;
  801100:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
  801108:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80110b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801112:	eb 09                	jmp    80111d <strnlen+0x18>
		n++;
  801114:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801117:	ff 45 08             	incl   0x8(%ebp)
  80111a:	ff 4d 0c             	decl   0xc(%ebp)
  80111d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801121:	74 09                	je     80112c <strnlen+0x27>
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	84 c0                	test   %al,%al
  80112a:	75 e8                	jne    801114 <strnlen+0xf>
		n++;
	return n;
  80112c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80112f:	c9                   	leave  
  801130:	c3                   	ret    

00801131 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801131:	55                   	push   %ebp
  801132:	89 e5                	mov    %esp,%ebp
  801134:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
  80113a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80113d:	90                   	nop
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8d 50 01             	lea    0x1(%eax),%edx
  801144:	89 55 08             	mov    %edx,0x8(%ebp)
  801147:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80114d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801150:	8a 12                	mov    (%edx),%dl
  801152:	88 10                	mov    %dl,(%eax)
  801154:	8a 00                	mov    (%eax),%al
  801156:	84 c0                	test   %al,%al
  801158:	75 e4                	jne    80113e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80115a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
  801162:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80116b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801172:	eb 1f                	jmp    801193 <strncpy+0x34>
		*dst++ = *src;
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	8d 50 01             	lea    0x1(%eax),%edx
  80117a:	89 55 08             	mov    %edx,0x8(%ebp)
  80117d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801180:	8a 12                	mov    (%edx),%dl
  801182:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801184:	8b 45 0c             	mov    0xc(%ebp),%eax
  801187:	8a 00                	mov    (%eax),%al
  801189:	84 c0                	test   %al,%al
  80118b:	74 03                	je     801190 <strncpy+0x31>
			src++;
  80118d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801190:	ff 45 fc             	incl   -0x4(%ebp)
  801193:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801196:	3b 45 10             	cmp    0x10(%ebp),%eax
  801199:	72 d9                	jb     801174 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80119b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80119e:	c9                   	leave  
  80119f:	c3                   	ret    

008011a0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011a0:	55                   	push   %ebp
  8011a1:	89 e5                	mov    %esp,%ebp
  8011a3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8011ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b0:	74 30                	je     8011e2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8011b2:	eb 16                	jmp    8011ca <strlcpy+0x2a>
			*dst++ = *src++;
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8d 50 01             	lea    0x1(%eax),%edx
  8011ba:	89 55 08             	mov    %edx,0x8(%ebp)
  8011bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011c0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011c3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011c6:	8a 12                	mov    (%edx),%dl
  8011c8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8011ca:	ff 4d 10             	decl   0x10(%ebp)
  8011cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011d1:	74 09                	je     8011dc <strlcpy+0x3c>
  8011d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d6:	8a 00                	mov    (%eax),%al
  8011d8:	84 c0                	test   %al,%al
  8011da:	75 d8                	jne    8011b4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8011dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011df:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8011e2:	8b 55 08             	mov    0x8(%ebp),%edx
  8011e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011e8:	29 c2                	sub    %eax,%edx
  8011ea:	89 d0                	mov    %edx,%eax
}
  8011ec:	c9                   	leave  
  8011ed:	c3                   	ret    

008011ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8011ee:	55                   	push   %ebp
  8011ef:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8011f1:	eb 06                	jmp    8011f9 <strcmp+0xb>
		p++, q++;
  8011f3:	ff 45 08             	incl   0x8(%ebp)
  8011f6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	84 c0                	test   %al,%al
  801200:	74 0e                	je     801210 <strcmp+0x22>
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 10                	mov    (%eax),%dl
  801207:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	38 c2                	cmp    %al,%dl
  80120e:	74 e3                	je     8011f3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	0f b6 d0             	movzbl %al,%edx
  801218:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	0f b6 c0             	movzbl %al,%eax
  801220:	29 c2                	sub    %eax,%edx
  801222:	89 d0                	mov    %edx,%eax
}
  801224:	5d                   	pop    %ebp
  801225:	c3                   	ret    

00801226 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801229:	eb 09                	jmp    801234 <strncmp+0xe>
		n--, p++, q++;
  80122b:	ff 4d 10             	decl   0x10(%ebp)
  80122e:	ff 45 08             	incl   0x8(%ebp)
  801231:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801234:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801238:	74 17                	je     801251 <strncmp+0x2b>
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	8a 00                	mov    (%eax),%al
  80123f:	84 c0                	test   %al,%al
  801241:	74 0e                	je     801251 <strncmp+0x2b>
  801243:	8b 45 08             	mov    0x8(%ebp),%eax
  801246:	8a 10                	mov    (%eax),%dl
  801248:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124b:	8a 00                	mov    (%eax),%al
  80124d:	38 c2                	cmp    %al,%dl
  80124f:	74 da                	je     80122b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801251:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801255:	75 07                	jne    80125e <strncmp+0x38>
		return 0;
  801257:	b8 00 00 00 00       	mov    $0x0,%eax
  80125c:	eb 14                	jmp    801272 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80125e:	8b 45 08             	mov    0x8(%ebp),%eax
  801261:	8a 00                	mov    (%eax),%al
  801263:	0f b6 d0             	movzbl %al,%edx
  801266:	8b 45 0c             	mov    0xc(%ebp),%eax
  801269:	8a 00                	mov    (%eax),%al
  80126b:	0f b6 c0             	movzbl %al,%eax
  80126e:	29 c2                	sub    %eax,%edx
  801270:	89 d0                	mov    %edx,%eax
}
  801272:	5d                   	pop    %ebp
  801273:	c3                   	ret    

00801274 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801274:	55                   	push   %ebp
  801275:	89 e5                	mov    %esp,%ebp
  801277:	83 ec 04             	sub    $0x4,%esp
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801280:	eb 12                	jmp    801294 <strchr+0x20>
		if (*s == c)
  801282:	8b 45 08             	mov    0x8(%ebp),%eax
  801285:	8a 00                	mov    (%eax),%al
  801287:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80128a:	75 05                	jne    801291 <strchr+0x1d>
			return (char *) s;
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	eb 11                	jmp    8012a2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801291:	ff 45 08             	incl   0x8(%ebp)
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	84 c0                	test   %al,%al
  80129b:	75 e5                	jne    801282 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80129d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012a2:	c9                   	leave  
  8012a3:	c3                   	ret    

008012a4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012a4:	55                   	push   %ebp
  8012a5:	89 e5                	mov    %esp,%ebp
  8012a7:	83 ec 04             	sub    $0x4,%esp
  8012aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012b0:	eb 0d                	jmp    8012bf <strfind+0x1b>
		if (*s == c)
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012ba:	74 0e                	je     8012ca <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8012bc:	ff 45 08             	incl   0x8(%ebp)
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	84 c0                	test   %al,%al
  8012c6:	75 ea                	jne    8012b2 <strfind+0xe>
  8012c8:	eb 01                	jmp    8012cb <strfind+0x27>
		if (*s == c)
			break;
  8012ca:	90                   	nop
	return (char *) s;
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
  8012d3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8012dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012df:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8012e2:	eb 0e                	jmp    8012f2 <memset+0x22>
		*p++ = c;
  8012e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e7:	8d 50 01             	lea    0x1(%eax),%edx
  8012ea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8012f2:	ff 4d f8             	decl   -0x8(%ebp)
  8012f5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8012f9:	79 e9                	jns    8012e4 <memset+0x14>
		*p++ = c;

	return v;
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
  801303:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801306:	8b 45 0c             	mov    0xc(%ebp),%eax
  801309:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801312:	eb 16                	jmp    80132a <memcpy+0x2a>
		*d++ = *s++;
  801314:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801317:	8d 50 01             	lea    0x1(%eax),%edx
  80131a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80131d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801320:	8d 4a 01             	lea    0x1(%edx),%ecx
  801323:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801326:	8a 12                	mov    (%edx),%dl
  801328:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80132a:	8b 45 10             	mov    0x10(%ebp),%eax
  80132d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801330:	89 55 10             	mov    %edx,0x10(%ebp)
  801333:	85 c0                	test   %eax,%eax
  801335:	75 dd                	jne    801314 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801337:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80133a:	c9                   	leave  
  80133b:	c3                   	ret    

0080133c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
  80133f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801342:	8b 45 0c             	mov    0xc(%ebp),%eax
  801345:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80134e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801351:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801354:	73 50                	jae    8013a6 <memmove+0x6a>
  801356:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801359:	8b 45 10             	mov    0x10(%ebp),%eax
  80135c:	01 d0                	add    %edx,%eax
  80135e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801361:	76 43                	jbe    8013a6 <memmove+0x6a>
		s += n;
  801363:	8b 45 10             	mov    0x10(%ebp),%eax
  801366:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801369:	8b 45 10             	mov    0x10(%ebp),%eax
  80136c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80136f:	eb 10                	jmp    801381 <memmove+0x45>
			*--d = *--s;
  801371:	ff 4d f8             	decl   -0x8(%ebp)
  801374:	ff 4d fc             	decl   -0x4(%ebp)
  801377:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80137a:	8a 10                	mov    (%eax),%dl
  80137c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80137f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801381:	8b 45 10             	mov    0x10(%ebp),%eax
  801384:	8d 50 ff             	lea    -0x1(%eax),%edx
  801387:	89 55 10             	mov    %edx,0x10(%ebp)
  80138a:	85 c0                	test   %eax,%eax
  80138c:	75 e3                	jne    801371 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80138e:	eb 23                	jmp    8013b3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801390:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801393:	8d 50 01             	lea    0x1(%eax),%edx
  801396:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801399:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80139c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80139f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013a2:	8a 12                	mov    (%edx),%dl
  8013a4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8013af:	85 c0                	test   %eax,%eax
  8013b1:	75 dd                	jne    801390 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
  8013bb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8013c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8013ca:	eb 2a                	jmp    8013f6 <memcmp+0x3e>
		if (*s1 != *s2)
  8013cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013cf:	8a 10                	mov    (%eax),%dl
  8013d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	38 c2                	cmp    %al,%dl
  8013d8:	74 16                	je     8013f0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8013da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013dd:	8a 00                	mov    (%eax),%al
  8013df:	0f b6 d0             	movzbl %al,%edx
  8013e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e5:	8a 00                	mov    (%eax),%al
  8013e7:	0f b6 c0             	movzbl %al,%eax
  8013ea:	29 c2                	sub    %eax,%edx
  8013ec:	89 d0                	mov    %edx,%eax
  8013ee:	eb 18                	jmp    801408 <memcmp+0x50>
		s1++, s2++;
  8013f0:	ff 45 fc             	incl   -0x4(%ebp)
  8013f3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8013f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013fc:	89 55 10             	mov    %edx,0x10(%ebp)
  8013ff:	85 c0                	test   %eax,%eax
  801401:	75 c9                	jne    8013cc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801403:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
  80140d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801410:	8b 55 08             	mov    0x8(%ebp),%edx
  801413:	8b 45 10             	mov    0x10(%ebp),%eax
  801416:	01 d0                	add    %edx,%eax
  801418:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80141b:	eb 15                	jmp    801432 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	0f b6 d0             	movzbl %al,%edx
  801425:	8b 45 0c             	mov    0xc(%ebp),%eax
  801428:	0f b6 c0             	movzbl %al,%eax
  80142b:	39 c2                	cmp    %eax,%edx
  80142d:	74 0d                	je     80143c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80142f:	ff 45 08             	incl   0x8(%ebp)
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801438:	72 e3                	jb     80141d <memfind+0x13>
  80143a:	eb 01                	jmp    80143d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80143c:	90                   	nop
	return (void *) s;
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801440:	c9                   	leave  
  801441:	c3                   	ret    

00801442 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801442:	55                   	push   %ebp
  801443:	89 e5                	mov    %esp,%ebp
  801445:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801448:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80144f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801456:	eb 03                	jmp    80145b <strtol+0x19>
		s++;
  801458:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	8a 00                	mov    (%eax),%al
  801460:	3c 20                	cmp    $0x20,%al
  801462:	74 f4                	je     801458 <strtol+0x16>
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	3c 09                	cmp    $0x9,%al
  80146b:	74 eb                	je     801458 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	3c 2b                	cmp    $0x2b,%al
  801474:	75 05                	jne    80147b <strtol+0x39>
		s++;
  801476:	ff 45 08             	incl   0x8(%ebp)
  801479:	eb 13                	jmp    80148e <strtol+0x4c>
	else if (*s == '-')
  80147b:	8b 45 08             	mov    0x8(%ebp),%eax
  80147e:	8a 00                	mov    (%eax),%al
  801480:	3c 2d                	cmp    $0x2d,%al
  801482:	75 0a                	jne    80148e <strtol+0x4c>
		s++, neg = 1;
  801484:	ff 45 08             	incl   0x8(%ebp)
  801487:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80148e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801492:	74 06                	je     80149a <strtol+0x58>
  801494:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801498:	75 20                	jne    8014ba <strtol+0x78>
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	8a 00                	mov    (%eax),%al
  80149f:	3c 30                	cmp    $0x30,%al
  8014a1:	75 17                	jne    8014ba <strtol+0x78>
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	40                   	inc    %eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	3c 78                	cmp    $0x78,%al
  8014ab:	75 0d                	jne    8014ba <strtol+0x78>
		s += 2, base = 16;
  8014ad:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8014b1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8014b8:	eb 28                	jmp    8014e2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8014ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014be:	75 15                	jne    8014d5 <strtol+0x93>
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	8a 00                	mov    (%eax),%al
  8014c5:	3c 30                	cmp    $0x30,%al
  8014c7:	75 0c                	jne    8014d5 <strtol+0x93>
		s++, base = 8;
  8014c9:	ff 45 08             	incl   0x8(%ebp)
  8014cc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8014d3:	eb 0d                	jmp    8014e2 <strtol+0xa0>
	else if (base == 0)
  8014d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d9:	75 07                	jne    8014e2 <strtol+0xa0>
		base = 10;
  8014db:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	3c 2f                	cmp    $0x2f,%al
  8014e9:	7e 19                	jle    801504 <strtol+0xc2>
  8014eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ee:	8a 00                	mov    (%eax),%al
  8014f0:	3c 39                	cmp    $0x39,%al
  8014f2:	7f 10                	jg     801504 <strtol+0xc2>
			dig = *s - '0';
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	0f be c0             	movsbl %al,%eax
  8014fc:	83 e8 30             	sub    $0x30,%eax
  8014ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801502:	eb 42                	jmp    801546 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	8a 00                	mov    (%eax),%al
  801509:	3c 60                	cmp    $0x60,%al
  80150b:	7e 19                	jle    801526 <strtol+0xe4>
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	8a 00                	mov    (%eax),%al
  801512:	3c 7a                	cmp    $0x7a,%al
  801514:	7f 10                	jg     801526 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	8a 00                	mov    (%eax),%al
  80151b:	0f be c0             	movsbl %al,%eax
  80151e:	83 e8 57             	sub    $0x57,%eax
  801521:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801524:	eb 20                	jmp    801546 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	3c 40                	cmp    $0x40,%al
  80152d:	7e 39                	jle    801568 <strtol+0x126>
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	3c 5a                	cmp    $0x5a,%al
  801536:	7f 30                	jg     801568 <strtol+0x126>
			dig = *s - 'A' + 10;
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	0f be c0             	movsbl %al,%eax
  801540:	83 e8 37             	sub    $0x37,%eax
  801543:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801546:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801549:	3b 45 10             	cmp    0x10(%ebp),%eax
  80154c:	7d 19                	jge    801567 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80154e:	ff 45 08             	incl   0x8(%ebp)
  801551:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801554:	0f af 45 10          	imul   0x10(%ebp),%eax
  801558:	89 c2                	mov    %eax,%edx
  80155a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80155d:	01 d0                	add    %edx,%eax
  80155f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801562:	e9 7b ff ff ff       	jmp    8014e2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801567:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801568:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80156c:	74 08                	je     801576 <strtol+0x134>
		*endptr = (char *) s;
  80156e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801571:	8b 55 08             	mov    0x8(%ebp),%edx
  801574:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801576:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80157a:	74 07                	je     801583 <strtol+0x141>
  80157c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157f:	f7 d8                	neg    %eax
  801581:	eb 03                	jmp    801586 <strtol+0x144>
  801583:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801586:	c9                   	leave  
  801587:	c3                   	ret    

00801588 <ltostr>:

void
ltostr(long value, char *str)
{
  801588:	55                   	push   %ebp
  801589:	89 e5                	mov    %esp,%ebp
  80158b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80158e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801595:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80159c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015a0:	79 13                	jns    8015b5 <ltostr+0x2d>
	{
		neg = 1;
  8015a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ac:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8015af:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8015b2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8015b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8015bd:	99                   	cltd   
  8015be:	f7 f9                	idiv   %ecx
  8015c0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8015c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c6:	8d 50 01             	lea    0x1(%eax),%edx
  8015c9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015cc:	89 c2                	mov    %eax,%edx
  8015ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d1:	01 d0                	add    %edx,%eax
  8015d3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8015d6:	83 c2 30             	add    $0x30,%edx
  8015d9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8015db:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015de:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015e3:	f7 e9                	imul   %ecx
  8015e5:	c1 fa 02             	sar    $0x2,%edx
  8015e8:	89 c8                	mov    %ecx,%eax
  8015ea:	c1 f8 1f             	sar    $0x1f,%eax
  8015ed:	29 c2                	sub    %eax,%edx
  8015ef:	89 d0                	mov    %edx,%eax
  8015f1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8015f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015f7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015fc:	f7 e9                	imul   %ecx
  8015fe:	c1 fa 02             	sar    $0x2,%edx
  801601:	89 c8                	mov    %ecx,%eax
  801603:	c1 f8 1f             	sar    $0x1f,%eax
  801606:	29 c2                	sub    %eax,%edx
  801608:	89 d0                	mov    %edx,%eax
  80160a:	c1 e0 02             	shl    $0x2,%eax
  80160d:	01 d0                	add    %edx,%eax
  80160f:	01 c0                	add    %eax,%eax
  801611:	29 c1                	sub    %eax,%ecx
  801613:	89 ca                	mov    %ecx,%edx
  801615:	85 d2                	test   %edx,%edx
  801617:	75 9c                	jne    8015b5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801619:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801620:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801623:	48                   	dec    %eax
  801624:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801627:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80162b:	74 3d                	je     80166a <ltostr+0xe2>
		start = 1 ;
  80162d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801634:	eb 34                	jmp    80166a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801636:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801639:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163c:	01 d0                	add    %edx,%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801643:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801646:	8b 45 0c             	mov    0xc(%ebp),%eax
  801649:	01 c2                	add    %eax,%edx
  80164b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80164e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801651:	01 c8                	add    %ecx,%eax
  801653:	8a 00                	mov    (%eax),%al
  801655:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801657:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80165a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165d:	01 c2                	add    %eax,%edx
  80165f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801662:	88 02                	mov    %al,(%edx)
		start++ ;
  801664:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801667:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80166d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801670:	7c c4                	jl     801636 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801672:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801675:	8b 45 0c             	mov    0xc(%ebp),%eax
  801678:	01 d0                	add    %edx,%eax
  80167a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80167d:	90                   	nop
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
  801683:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801686:	ff 75 08             	pushl  0x8(%ebp)
  801689:	e8 54 fa ff ff       	call   8010e2 <strlen>
  80168e:	83 c4 04             	add    $0x4,%esp
  801691:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801694:	ff 75 0c             	pushl  0xc(%ebp)
  801697:	e8 46 fa ff ff       	call   8010e2 <strlen>
  80169c:	83 c4 04             	add    $0x4,%esp
  80169f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016b0:	eb 17                	jmp    8016c9 <strcconcat+0x49>
		final[s] = str1[s] ;
  8016b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b8:	01 c2                	add    %eax,%edx
  8016ba:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	01 c8                	add    %ecx,%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8016c6:	ff 45 fc             	incl   -0x4(%ebp)
  8016c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016cf:	7c e1                	jl     8016b2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8016d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8016d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8016df:	eb 1f                	jmp    801700 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8016e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016e4:	8d 50 01             	lea    0x1(%eax),%edx
  8016e7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016ea:	89 c2                	mov    %eax,%edx
  8016ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ef:	01 c2                	add    %eax,%edx
  8016f1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8016f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f7:	01 c8                	add    %ecx,%eax
  8016f9:	8a 00                	mov    (%eax),%al
  8016fb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8016fd:	ff 45 f8             	incl   -0x8(%ebp)
  801700:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801703:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801706:	7c d9                	jl     8016e1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801708:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80170b:	8b 45 10             	mov    0x10(%ebp),%eax
  80170e:	01 d0                	add    %edx,%eax
  801710:	c6 00 00             	movb   $0x0,(%eax)
}
  801713:	90                   	nop
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801719:	8b 45 14             	mov    0x14(%ebp),%eax
  80171c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801722:	8b 45 14             	mov    0x14(%ebp),%eax
  801725:	8b 00                	mov    (%eax),%eax
  801727:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80172e:	8b 45 10             	mov    0x10(%ebp),%eax
  801731:	01 d0                	add    %edx,%eax
  801733:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801739:	eb 0c                	jmp    801747 <strsplit+0x31>
			*string++ = 0;
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	8d 50 01             	lea    0x1(%eax),%edx
  801741:	89 55 08             	mov    %edx,0x8(%ebp)
  801744:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801747:	8b 45 08             	mov    0x8(%ebp),%eax
  80174a:	8a 00                	mov    (%eax),%al
  80174c:	84 c0                	test   %al,%al
  80174e:	74 18                	je     801768 <strsplit+0x52>
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	8a 00                	mov    (%eax),%al
  801755:	0f be c0             	movsbl %al,%eax
  801758:	50                   	push   %eax
  801759:	ff 75 0c             	pushl  0xc(%ebp)
  80175c:	e8 13 fb ff ff       	call   801274 <strchr>
  801761:	83 c4 08             	add    $0x8,%esp
  801764:	85 c0                	test   %eax,%eax
  801766:	75 d3                	jne    80173b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	8a 00                	mov    (%eax),%al
  80176d:	84 c0                	test   %al,%al
  80176f:	74 5a                	je     8017cb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801771:	8b 45 14             	mov    0x14(%ebp),%eax
  801774:	8b 00                	mov    (%eax),%eax
  801776:	83 f8 0f             	cmp    $0xf,%eax
  801779:	75 07                	jne    801782 <strsplit+0x6c>
		{
			return 0;
  80177b:	b8 00 00 00 00       	mov    $0x0,%eax
  801780:	eb 66                	jmp    8017e8 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801782:	8b 45 14             	mov    0x14(%ebp),%eax
  801785:	8b 00                	mov    (%eax),%eax
  801787:	8d 48 01             	lea    0x1(%eax),%ecx
  80178a:	8b 55 14             	mov    0x14(%ebp),%edx
  80178d:	89 0a                	mov    %ecx,(%edx)
  80178f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801796:	8b 45 10             	mov    0x10(%ebp),%eax
  801799:	01 c2                	add    %eax,%edx
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017a0:	eb 03                	jmp    8017a5 <strsplit+0x8f>
			string++;
  8017a2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	8a 00                	mov    (%eax),%al
  8017aa:	84 c0                	test   %al,%al
  8017ac:	74 8b                	je     801739 <strsplit+0x23>
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	8a 00                	mov    (%eax),%al
  8017b3:	0f be c0             	movsbl %al,%eax
  8017b6:	50                   	push   %eax
  8017b7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ba:	e8 b5 fa ff ff       	call   801274 <strchr>
  8017bf:	83 c4 08             	add    $0x8,%esp
  8017c2:	85 c0                	test   %eax,%eax
  8017c4:	74 dc                	je     8017a2 <strsplit+0x8c>
			string++;
	}
  8017c6:	e9 6e ff ff ff       	jmp    801739 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8017cb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8017cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8017cf:	8b 00                	mov    (%eax),%eax
  8017d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017db:	01 d0                	add    %edx,%eax
  8017dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8017e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
  8017ed:	57                   	push   %edi
  8017ee:	56                   	push   %esi
  8017ef:	53                   	push   %ebx
  8017f0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017ff:	8b 7d 18             	mov    0x18(%ebp),%edi
  801802:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801805:	cd 30                	int    $0x30
  801807:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80180a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80180d:	83 c4 10             	add    $0x10,%esp
  801810:	5b                   	pop    %ebx
  801811:	5e                   	pop    %esi
  801812:	5f                   	pop    %edi
  801813:	5d                   	pop    %ebp
  801814:	c3                   	ret    

00801815 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
  801818:	83 ec 04             	sub    $0x4,%esp
  80181b:	8b 45 10             	mov    0x10(%ebp),%eax
  80181e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801821:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	52                   	push   %edx
  80182d:	ff 75 0c             	pushl  0xc(%ebp)
  801830:	50                   	push   %eax
  801831:	6a 00                	push   $0x0
  801833:	e8 b2 ff ff ff       	call   8017ea <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	90                   	nop
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_cgetc>:

int
sys_cgetc(void)
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 01                	push   $0x1
  80184d:	e8 98 ff ff ff       	call   8017ea <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80185a:	8b 45 08             	mov    0x8(%ebp),%eax
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	50                   	push   %eax
  801866:	6a 05                	push   $0x5
  801868:	e8 7d ff ff ff       	call   8017ea <syscall>
  80186d:	83 c4 18             	add    $0x18,%esp
}
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 02                	push   $0x2
  801881:	e8 64 ff ff ff       	call   8017ea <syscall>
  801886:	83 c4 18             	add    $0x18,%esp
}
  801889:	c9                   	leave  
  80188a:	c3                   	ret    

0080188b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 03                	push   $0x3
  80189a:	e8 4b ff ff ff       	call   8017ea <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
}
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 04                	push   $0x4
  8018b3:	e8 32 ff ff ff       	call   8017ea <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
}
  8018bb:	c9                   	leave  
  8018bc:	c3                   	ret    

008018bd <sys_env_exit>:


void sys_env_exit(void)
{
  8018bd:	55                   	push   %ebp
  8018be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 06                	push   $0x6
  8018cc:	e8 19 ff ff ff       	call   8017ea <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
}
  8018d4:	90                   	nop
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	6a 07                	push   $0x7
  8018ea:	e8 fb fe ff ff       	call   8017ea <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
  8018f7:	56                   	push   %esi
  8018f8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018f9:	8b 75 18             	mov    0x18(%ebp),%esi
  8018fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801902:	8b 55 0c             	mov    0xc(%ebp),%edx
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	56                   	push   %esi
  801909:	53                   	push   %ebx
  80190a:	51                   	push   %ecx
  80190b:	52                   	push   %edx
  80190c:	50                   	push   %eax
  80190d:	6a 08                	push   $0x8
  80190f:	e8 d6 fe ff ff       	call   8017ea <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
}
  801917:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80191a:	5b                   	pop    %ebx
  80191b:	5e                   	pop    %esi
  80191c:	5d                   	pop    %ebp
  80191d:	c3                   	ret    

0080191e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80191e:	55                   	push   %ebp
  80191f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801921:	8b 55 0c             	mov    0xc(%ebp),%edx
  801924:	8b 45 08             	mov    0x8(%ebp),%eax
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	52                   	push   %edx
  80192e:	50                   	push   %eax
  80192f:	6a 09                	push   $0x9
  801931:	e8 b4 fe ff ff       	call   8017ea <syscall>
  801936:	83 c4 18             	add    $0x18,%esp
}
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	ff 75 0c             	pushl  0xc(%ebp)
  801947:	ff 75 08             	pushl  0x8(%ebp)
  80194a:	6a 0a                	push   $0xa
  80194c:	e8 99 fe ff ff       	call   8017ea <syscall>
  801951:	83 c4 18             	add    $0x18,%esp
}
  801954:	c9                   	leave  
  801955:	c3                   	ret    

00801956 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801956:	55                   	push   %ebp
  801957:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 0b                	push   $0xb
  801965:	e8 80 fe ff ff       	call   8017ea <syscall>
  80196a:	83 c4 18             	add    $0x18,%esp
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 0c                	push   $0xc
  80197e:	e8 67 fe ff ff       	call   8017ea <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 0d                	push   $0xd
  801997:	e8 4e fe ff ff       	call   8017ea <syscall>
  80199c:	83 c4 18             	add    $0x18,%esp
}
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	ff 75 0c             	pushl  0xc(%ebp)
  8019ad:	ff 75 08             	pushl  0x8(%ebp)
  8019b0:	6a 11                	push   $0x11
  8019b2:	e8 33 fe ff ff       	call   8017ea <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
	return;
  8019ba:	90                   	nop
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	ff 75 0c             	pushl  0xc(%ebp)
  8019c9:	ff 75 08             	pushl  0x8(%ebp)
  8019cc:	6a 12                	push   $0x12
  8019ce:	e8 17 fe ff ff       	call   8017ea <syscall>
  8019d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019d6:	90                   	nop
}
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 0e                	push   $0xe
  8019e8:	e8 fd fd ff ff       	call   8017ea <syscall>
  8019ed:	83 c4 18             	add    $0x18,%esp
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	ff 75 08             	pushl  0x8(%ebp)
  801a00:	6a 0f                	push   $0xf
  801a02:	e8 e3 fd ff ff       	call   8017ea <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
}
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 10                	push   $0x10
  801a1b:	e8 ca fd ff ff       	call   8017ea <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
}
  801a23:	90                   	nop
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 14                	push   $0x14
  801a35:	e8 b0 fd ff ff       	call   8017ea <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
}
  801a3d:	90                   	nop
  801a3e:	c9                   	leave  
  801a3f:	c3                   	ret    

00801a40 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a40:	55                   	push   %ebp
  801a41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 15                	push   $0x15
  801a4f:	e8 96 fd ff ff       	call   8017ea <syscall>
  801a54:	83 c4 18             	add    $0x18,%esp
}
  801a57:	90                   	nop
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_cputc>:


void
sys_cputc(const char c)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
  801a5d:	83 ec 04             	sub    $0x4,%esp
  801a60:	8b 45 08             	mov    0x8(%ebp),%eax
  801a63:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a66:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 00                	push   $0x0
  801a72:	50                   	push   %eax
  801a73:	6a 16                	push   $0x16
  801a75:	e8 70 fd ff ff       	call   8017ea <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
}
  801a7d:	90                   	nop
  801a7e:	c9                   	leave  
  801a7f:	c3                   	ret    

00801a80 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 17                	push   $0x17
  801a8f:	e8 56 fd ff ff       	call   8017ea <syscall>
  801a94:	83 c4 18             	add    $0x18,%esp
}
  801a97:	90                   	nop
  801a98:	c9                   	leave  
  801a99:	c3                   	ret    

00801a9a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	ff 75 0c             	pushl  0xc(%ebp)
  801aa9:	50                   	push   %eax
  801aaa:	6a 18                	push   $0x18
  801aac:	e8 39 fd ff ff       	call   8017ea <syscall>
  801ab1:	83 c4 18             	add    $0x18,%esp
}
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ab9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801abc:	8b 45 08             	mov    0x8(%ebp),%eax
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	52                   	push   %edx
  801ac6:	50                   	push   %eax
  801ac7:	6a 1b                	push   $0x1b
  801ac9:	e8 1c fd ff ff       	call   8017ea <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ad6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	52                   	push   %edx
  801ae3:	50                   	push   %eax
  801ae4:	6a 19                	push   $0x19
  801ae6:	e8 ff fc ff ff       	call   8017ea <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
}
  801aee:	90                   	nop
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801af4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af7:	8b 45 08             	mov    0x8(%ebp),%eax
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	52                   	push   %edx
  801b01:	50                   	push   %eax
  801b02:	6a 1a                	push   $0x1a
  801b04:	e8 e1 fc ff ff       	call   8017ea <syscall>
  801b09:	83 c4 18             	add    $0x18,%esp
}
  801b0c:	90                   	nop
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
  801b12:	83 ec 04             	sub    $0x4,%esp
  801b15:	8b 45 10             	mov    0x10(%ebp),%eax
  801b18:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b1b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b1e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b22:	8b 45 08             	mov    0x8(%ebp),%eax
  801b25:	6a 00                	push   $0x0
  801b27:	51                   	push   %ecx
  801b28:	52                   	push   %edx
  801b29:	ff 75 0c             	pushl  0xc(%ebp)
  801b2c:	50                   	push   %eax
  801b2d:	6a 1c                	push   $0x1c
  801b2f:	e8 b6 fc ff ff       	call   8017ea <syscall>
  801b34:	83 c4 18             	add    $0x18,%esp
}
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	52                   	push   %edx
  801b49:	50                   	push   %eax
  801b4a:	6a 1d                	push   $0x1d
  801b4c:	e8 99 fc ff ff       	call   8017ea <syscall>
  801b51:	83 c4 18             	add    $0x18,%esp
}
  801b54:	c9                   	leave  
  801b55:	c3                   	ret    

00801b56 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b56:	55                   	push   %ebp
  801b57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b59:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	51                   	push   %ecx
  801b67:	52                   	push   %edx
  801b68:	50                   	push   %eax
  801b69:	6a 1e                	push   $0x1e
  801b6b:	e8 7a fc ff ff       	call   8017ea <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
}
  801b73:	c9                   	leave  
  801b74:	c3                   	ret    

00801b75 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b75:	55                   	push   %ebp
  801b76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	52                   	push   %edx
  801b85:	50                   	push   %eax
  801b86:	6a 1f                	push   $0x1f
  801b88:	e8 5d fc ff ff       	call   8017ea <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 20                	push   $0x20
  801ba1:	e8 44 fc ff ff       	call   8017ea <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801bae:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	ff 75 10             	pushl  0x10(%ebp)
  801bb8:	ff 75 0c             	pushl  0xc(%ebp)
  801bbb:	50                   	push   %eax
  801bbc:	6a 21                	push   $0x21
  801bbe:	e8 27 fc ff ff       	call   8017ea <syscall>
  801bc3:	83 c4 18             	add    $0x18,%esp
}
  801bc6:	c9                   	leave  
  801bc7:	c3                   	ret    

00801bc8 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	50                   	push   %eax
  801bd7:	6a 22                	push   $0x22
  801bd9:	e8 0c fc ff ff       	call   8017ea <syscall>
  801bde:	83 c4 18             	add    $0x18,%esp
}
  801be1:	90                   	nop
  801be2:	c9                   	leave  
  801be3:	c3                   	ret    

00801be4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801be4:	55                   	push   %ebp
  801be5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801be7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	50                   	push   %eax
  801bf3:	6a 23                	push   $0x23
  801bf5:	e8 f0 fb ff ff       	call   8017ea <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
}
  801bfd:	90                   	nop
  801bfe:	c9                   	leave  
  801bff:	c3                   	ret    

00801c00 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
  801c03:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c06:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c09:	8d 50 04             	lea    0x4(%eax),%edx
  801c0c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	52                   	push   %edx
  801c16:	50                   	push   %eax
  801c17:	6a 24                	push   $0x24
  801c19:	e8 cc fb ff ff       	call   8017ea <syscall>
  801c1e:	83 c4 18             	add    $0x18,%esp
	return result;
  801c21:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c2a:	89 01                	mov    %eax,(%ecx)
  801c2c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c32:	c9                   	leave  
  801c33:	c2 04 00             	ret    $0x4

00801c36 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c36:	55                   	push   %ebp
  801c37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	ff 75 10             	pushl  0x10(%ebp)
  801c40:	ff 75 0c             	pushl  0xc(%ebp)
  801c43:	ff 75 08             	pushl  0x8(%ebp)
  801c46:	6a 13                	push   $0x13
  801c48:	e8 9d fb ff ff       	call   8017ea <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c50:	90                   	nop
}
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 25                	push   $0x25
  801c62:	e8 83 fb ff ff       	call   8017ea <syscall>
  801c67:	83 c4 18             	add    $0x18,%esp
}
  801c6a:	c9                   	leave  
  801c6b:	c3                   	ret    

00801c6c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
  801c6f:	83 ec 04             	sub    $0x4,%esp
  801c72:	8b 45 08             	mov    0x8(%ebp),%eax
  801c75:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c78:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	50                   	push   %eax
  801c85:	6a 26                	push   $0x26
  801c87:	e8 5e fb ff ff       	call   8017ea <syscall>
  801c8c:	83 c4 18             	add    $0x18,%esp
	return ;
  801c8f:	90                   	nop
}
  801c90:	c9                   	leave  
  801c91:	c3                   	ret    

00801c92 <rsttst>:
void rsttst()
{
  801c92:	55                   	push   %ebp
  801c93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 28                	push   $0x28
  801ca1:	e8 44 fb ff ff       	call   8017ea <syscall>
  801ca6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ca9:	90                   	nop
}
  801caa:	c9                   	leave  
  801cab:	c3                   	ret    

00801cac <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cac:	55                   	push   %ebp
  801cad:	89 e5                	mov    %esp,%ebp
  801caf:	83 ec 04             	sub    $0x4,%esp
  801cb2:	8b 45 14             	mov    0x14(%ebp),%eax
  801cb5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801cb8:	8b 55 18             	mov    0x18(%ebp),%edx
  801cbb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cbf:	52                   	push   %edx
  801cc0:	50                   	push   %eax
  801cc1:	ff 75 10             	pushl  0x10(%ebp)
  801cc4:	ff 75 0c             	pushl  0xc(%ebp)
  801cc7:	ff 75 08             	pushl  0x8(%ebp)
  801cca:	6a 27                	push   $0x27
  801ccc:	e8 19 fb ff ff       	call   8017ea <syscall>
  801cd1:	83 c4 18             	add    $0x18,%esp
	return ;
  801cd4:	90                   	nop
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <chktst>:
void chktst(uint32 n)
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	ff 75 08             	pushl  0x8(%ebp)
  801ce5:	6a 29                	push   $0x29
  801ce7:	e8 fe fa ff ff       	call   8017ea <syscall>
  801cec:	83 c4 18             	add    $0x18,%esp
	return ;
  801cef:	90                   	nop
}
  801cf0:	c9                   	leave  
  801cf1:	c3                   	ret    

00801cf2 <inctst>:

void inctst()
{
  801cf2:	55                   	push   %ebp
  801cf3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 2a                	push   $0x2a
  801d01:	e8 e4 fa ff ff       	call   8017ea <syscall>
  801d06:	83 c4 18             	add    $0x18,%esp
	return ;
  801d09:	90                   	nop
}
  801d0a:	c9                   	leave  
  801d0b:	c3                   	ret    

00801d0c <gettst>:
uint32 gettst()
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 2b                	push   $0x2b
  801d1b:	e8 ca fa ff ff       	call   8017ea <syscall>
  801d20:	83 c4 18             	add    $0x18,%esp
}
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
  801d28:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 2c                	push   $0x2c
  801d37:	e8 ae fa ff ff       	call   8017ea <syscall>
  801d3c:	83 c4 18             	add    $0x18,%esp
  801d3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d42:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d46:	75 07                	jne    801d4f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d48:	b8 01 00 00 00       	mov    $0x1,%eax
  801d4d:	eb 05                	jmp    801d54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d54:	c9                   	leave  
  801d55:	c3                   	ret    

00801d56 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
  801d59:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 00                	push   $0x0
  801d66:	6a 2c                	push   $0x2c
  801d68:	e8 7d fa ff ff       	call   8017ea <syscall>
  801d6d:	83 c4 18             	add    $0x18,%esp
  801d70:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d73:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d77:	75 07                	jne    801d80 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d79:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7e:	eb 05                	jmp    801d85 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
  801d8a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 2c                	push   $0x2c
  801d99:	e8 4c fa ff ff       	call   8017ea <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
  801da1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801da4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801da8:	75 07                	jne    801db1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801daa:	b8 01 00 00 00       	mov    $0x1,%eax
  801daf:	eb 05                	jmp    801db6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801db1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801db6:	c9                   	leave  
  801db7:	c3                   	ret    

00801db8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801db8:	55                   	push   %ebp
  801db9:	89 e5                	mov    %esp,%ebp
  801dbb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 2c                	push   $0x2c
  801dca:	e8 1b fa ff ff       	call   8017ea <syscall>
  801dcf:	83 c4 18             	add    $0x18,%esp
  801dd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801dd5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801dd9:	75 07                	jne    801de2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ddb:	b8 01 00 00 00       	mov    $0x1,%eax
  801de0:	eb 05                	jmp    801de7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801de2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de7:	c9                   	leave  
  801de8:	c3                   	ret    

00801de9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801de9:	55                   	push   %ebp
  801dea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	ff 75 08             	pushl  0x8(%ebp)
  801df7:	6a 2d                	push   $0x2d
  801df9:	e8 ec f9 ff ff       	call   8017ea <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
	return ;
  801e01:	90                   	nop
}
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
  801e07:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801e0a:	8b 55 08             	mov    0x8(%ebp),%edx
  801e0d:	89 d0                	mov    %edx,%eax
  801e0f:	c1 e0 02             	shl    $0x2,%eax
  801e12:	01 d0                	add    %edx,%eax
  801e14:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e1b:	01 d0                	add    %edx,%eax
  801e1d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e24:	01 d0                	add    %edx,%eax
  801e26:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e2d:	01 d0                	add    %edx,%eax
  801e2f:	c1 e0 04             	shl    $0x4,%eax
  801e32:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801e35:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801e3c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801e3f:	83 ec 0c             	sub    $0xc,%esp
  801e42:	50                   	push   %eax
  801e43:	e8 b8 fd ff ff       	call   801c00 <sys_get_virtual_time>
  801e48:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801e4b:	eb 41                	jmp    801e8e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801e4d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801e50:	83 ec 0c             	sub    $0xc,%esp
  801e53:	50                   	push   %eax
  801e54:	e8 a7 fd ff ff       	call   801c00 <sys_get_virtual_time>
  801e59:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801e5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e62:	29 c2                	sub    %eax,%edx
  801e64:	89 d0                	mov    %edx,%eax
  801e66:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801e69:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801e6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e6f:	89 d1                	mov    %edx,%ecx
  801e71:	29 c1                	sub    %eax,%ecx
  801e73:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801e76:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e79:	39 c2                	cmp    %eax,%edx
  801e7b:	0f 97 c0             	seta   %al
  801e7e:	0f b6 c0             	movzbl %al,%eax
  801e81:	29 c1                	sub    %eax,%ecx
  801e83:	89 c8                	mov    %ecx,%eax
  801e85:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801e88:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801e8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801e8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e91:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e94:	72 b7                	jb     801e4d <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801e96:	90                   	nop
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
  801e9c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801e9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801ea6:	eb 03                	jmp    801eab <busy_wait+0x12>
  801ea8:	ff 45 fc             	incl   -0x4(%ebp)
  801eab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801eae:	3b 45 08             	cmp    0x8(%ebp),%eax
  801eb1:	72 f5                	jb     801ea8 <busy_wait+0xf>
	return i;
  801eb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801eb6:	c9                   	leave  
  801eb7:	c3                   	ret    

00801eb8 <__udivdi3>:
  801eb8:	55                   	push   %ebp
  801eb9:	57                   	push   %edi
  801eba:	56                   	push   %esi
  801ebb:	53                   	push   %ebx
  801ebc:	83 ec 1c             	sub    $0x1c,%esp
  801ebf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ec3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ec7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ecb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ecf:	89 ca                	mov    %ecx,%edx
  801ed1:	89 f8                	mov    %edi,%eax
  801ed3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ed7:	85 f6                	test   %esi,%esi
  801ed9:	75 2d                	jne    801f08 <__udivdi3+0x50>
  801edb:	39 cf                	cmp    %ecx,%edi
  801edd:	77 65                	ja     801f44 <__udivdi3+0x8c>
  801edf:	89 fd                	mov    %edi,%ebp
  801ee1:	85 ff                	test   %edi,%edi
  801ee3:	75 0b                	jne    801ef0 <__udivdi3+0x38>
  801ee5:	b8 01 00 00 00       	mov    $0x1,%eax
  801eea:	31 d2                	xor    %edx,%edx
  801eec:	f7 f7                	div    %edi
  801eee:	89 c5                	mov    %eax,%ebp
  801ef0:	31 d2                	xor    %edx,%edx
  801ef2:	89 c8                	mov    %ecx,%eax
  801ef4:	f7 f5                	div    %ebp
  801ef6:	89 c1                	mov    %eax,%ecx
  801ef8:	89 d8                	mov    %ebx,%eax
  801efa:	f7 f5                	div    %ebp
  801efc:	89 cf                	mov    %ecx,%edi
  801efe:	89 fa                	mov    %edi,%edx
  801f00:	83 c4 1c             	add    $0x1c,%esp
  801f03:	5b                   	pop    %ebx
  801f04:	5e                   	pop    %esi
  801f05:	5f                   	pop    %edi
  801f06:	5d                   	pop    %ebp
  801f07:	c3                   	ret    
  801f08:	39 ce                	cmp    %ecx,%esi
  801f0a:	77 28                	ja     801f34 <__udivdi3+0x7c>
  801f0c:	0f bd fe             	bsr    %esi,%edi
  801f0f:	83 f7 1f             	xor    $0x1f,%edi
  801f12:	75 40                	jne    801f54 <__udivdi3+0x9c>
  801f14:	39 ce                	cmp    %ecx,%esi
  801f16:	72 0a                	jb     801f22 <__udivdi3+0x6a>
  801f18:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f1c:	0f 87 9e 00 00 00    	ja     801fc0 <__udivdi3+0x108>
  801f22:	b8 01 00 00 00       	mov    $0x1,%eax
  801f27:	89 fa                	mov    %edi,%edx
  801f29:	83 c4 1c             	add    $0x1c,%esp
  801f2c:	5b                   	pop    %ebx
  801f2d:	5e                   	pop    %esi
  801f2e:	5f                   	pop    %edi
  801f2f:	5d                   	pop    %ebp
  801f30:	c3                   	ret    
  801f31:	8d 76 00             	lea    0x0(%esi),%esi
  801f34:	31 ff                	xor    %edi,%edi
  801f36:	31 c0                	xor    %eax,%eax
  801f38:	89 fa                	mov    %edi,%edx
  801f3a:	83 c4 1c             	add    $0x1c,%esp
  801f3d:	5b                   	pop    %ebx
  801f3e:	5e                   	pop    %esi
  801f3f:	5f                   	pop    %edi
  801f40:	5d                   	pop    %ebp
  801f41:	c3                   	ret    
  801f42:	66 90                	xchg   %ax,%ax
  801f44:	89 d8                	mov    %ebx,%eax
  801f46:	f7 f7                	div    %edi
  801f48:	31 ff                	xor    %edi,%edi
  801f4a:	89 fa                	mov    %edi,%edx
  801f4c:	83 c4 1c             	add    $0x1c,%esp
  801f4f:	5b                   	pop    %ebx
  801f50:	5e                   	pop    %esi
  801f51:	5f                   	pop    %edi
  801f52:	5d                   	pop    %ebp
  801f53:	c3                   	ret    
  801f54:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f59:	89 eb                	mov    %ebp,%ebx
  801f5b:	29 fb                	sub    %edi,%ebx
  801f5d:	89 f9                	mov    %edi,%ecx
  801f5f:	d3 e6                	shl    %cl,%esi
  801f61:	89 c5                	mov    %eax,%ebp
  801f63:	88 d9                	mov    %bl,%cl
  801f65:	d3 ed                	shr    %cl,%ebp
  801f67:	89 e9                	mov    %ebp,%ecx
  801f69:	09 f1                	or     %esi,%ecx
  801f6b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f6f:	89 f9                	mov    %edi,%ecx
  801f71:	d3 e0                	shl    %cl,%eax
  801f73:	89 c5                	mov    %eax,%ebp
  801f75:	89 d6                	mov    %edx,%esi
  801f77:	88 d9                	mov    %bl,%cl
  801f79:	d3 ee                	shr    %cl,%esi
  801f7b:	89 f9                	mov    %edi,%ecx
  801f7d:	d3 e2                	shl    %cl,%edx
  801f7f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f83:	88 d9                	mov    %bl,%cl
  801f85:	d3 e8                	shr    %cl,%eax
  801f87:	09 c2                	or     %eax,%edx
  801f89:	89 d0                	mov    %edx,%eax
  801f8b:	89 f2                	mov    %esi,%edx
  801f8d:	f7 74 24 0c          	divl   0xc(%esp)
  801f91:	89 d6                	mov    %edx,%esi
  801f93:	89 c3                	mov    %eax,%ebx
  801f95:	f7 e5                	mul    %ebp
  801f97:	39 d6                	cmp    %edx,%esi
  801f99:	72 19                	jb     801fb4 <__udivdi3+0xfc>
  801f9b:	74 0b                	je     801fa8 <__udivdi3+0xf0>
  801f9d:	89 d8                	mov    %ebx,%eax
  801f9f:	31 ff                	xor    %edi,%edi
  801fa1:	e9 58 ff ff ff       	jmp    801efe <__udivdi3+0x46>
  801fa6:	66 90                	xchg   %ax,%ax
  801fa8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fac:	89 f9                	mov    %edi,%ecx
  801fae:	d3 e2                	shl    %cl,%edx
  801fb0:	39 c2                	cmp    %eax,%edx
  801fb2:	73 e9                	jae    801f9d <__udivdi3+0xe5>
  801fb4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fb7:	31 ff                	xor    %edi,%edi
  801fb9:	e9 40 ff ff ff       	jmp    801efe <__udivdi3+0x46>
  801fbe:	66 90                	xchg   %ax,%ax
  801fc0:	31 c0                	xor    %eax,%eax
  801fc2:	e9 37 ff ff ff       	jmp    801efe <__udivdi3+0x46>
  801fc7:	90                   	nop

00801fc8 <__umoddi3>:
  801fc8:	55                   	push   %ebp
  801fc9:	57                   	push   %edi
  801fca:	56                   	push   %esi
  801fcb:	53                   	push   %ebx
  801fcc:	83 ec 1c             	sub    $0x1c,%esp
  801fcf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801fd3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fd7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fdb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fdf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801fe3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801fe7:	89 f3                	mov    %esi,%ebx
  801fe9:	89 fa                	mov    %edi,%edx
  801feb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fef:	89 34 24             	mov    %esi,(%esp)
  801ff2:	85 c0                	test   %eax,%eax
  801ff4:	75 1a                	jne    802010 <__umoddi3+0x48>
  801ff6:	39 f7                	cmp    %esi,%edi
  801ff8:	0f 86 a2 00 00 00    	jbe    8020a0 <__umoddi3+0xd8>
  801ffe:	89 c8                	mov    %ecx,%eax
  802000:	89 f2                	mov    %esi,%edx
  802002:	f7 f7                	div    %edi
  802004:	89 d0                	mov    %edx,%eax
  802006:	31 d2                	xor    %edx,%edx
  802008:	83 c4 1c             	add    $0x1c,%esp
  80200b:	5b                   	pop    %ebx
  80200c:	5e                   	pop    %esi
  80200d:	5f                   	pop    %edi
  80200e:	5d                   	pop    %ebp
  80200f:	c3                   	ret    
  802010:	39 f0                	cmp    %esi,%eax
  802012:	0f 87 ac 00 00 00    	ja     8020c4 <__umoddi3+0xfc>
  802018:	0f bd e8             	bsr    %eax,%ebp
  80201b:	83 f5 1f             	xor    $0x1f,%ebp
  80201e:	0f 84 ac 00 00 00    	je     8020d0 <__umoddi3+0x108>
  802024:	bf 20 00 00 00       	mov    $0x20,%edi
  802029:	29 ef                	sub    %ebp,%edi
  80202b:	89 fe                	mov    %edi,%esi
  80202d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802031:	89 e9                	mov    %ebp,%ecx
  802033:	d3 e0                	shl    %cl,%eax
  802035:	89 d7                	mov    %edx,%edi
  802037:	89 f1                	mov    %esi,%ecx
  802039:	d3 ef                	shr    %cl,%edi
  80203b:	09 c7                	or     %eax,%edi
  80203d:	89 e9                	mov    %ebp,%ecx
  80203f:	d3 e2                	shl    %cl,%edx
  802041:	89 14 24             	mov    %edx,(%esp)
  802044:	89 d8                	mov    %ebx,%eax
  802046:	d3 e0                	shl    %cl,%eax
  802048:	89 c2                	mov    %eax,%edx
  80204a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80204e:	d3 e0                	shl    %cl,%eax
  802050:	89 44 24 04          	mov    %eax,0x4(%esp)
  802054:	8b 44 24 08          	mov    0x8(%esp),%eax
  802058:	89 f1                	mov    %esi,%ecx
  80205a:	d3 e8                	shr    %cl,%eax
  80205c:	09 d0                	or     %edx,%eax
  80205e:	d3 eb                	shr    %cl,%ebx
  802060:	89 da                	mov    %ebx,%edx
  802062:	f7 f7                	div    %edi
  802064:	89 d3                	mov    %edx,%ebx
  802066:	f7 24 24             	mull   (%esp)
  802069:	89 c6                	mov    %eax,%esi
  80206b:	89 d1                	mov    %edx,%ecx
  80206d:	39 d3                	cmp    %edx,%ebx
  80206f:	0f 82 87 00 00 00    	jb     8020fc <__umoddi3+0x134>
  802075:	0f 84 91 00 00 00    	je     80210c <__umoddi3+0x144>
  80207b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80207f:	29 f2                	sub    %esi,%edx
  802081:	19 cb                	sbb    %ecx,%ebx
  802083:	89 d8                	mov    %ebx,%eax
  802085:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802089:	d3 e0                	shl    %cl,%eax
  80208b:	89 e9                	mov    %ebp,%ecx
  80208d:	d3 ea                	shr    %cl,%edx
  80208f:	09 d0                	or     %edx,%eax
  802091:	89 e9                	mov    %ebp,%ecx
  802093:	d3 eb                	shr    %cl,%ebx
  802095:	89 da                	mov    %ebx,%edx
  802097:	83 c4 1c             	add    $0x1c,%esp
  80209a:	5b                   	pop    %ebx
  80209b:	5e                   	pop    %esi
  80209c:	5f                   	pop    %edi
  80209d:	5d                   	pop    %ebp
  80209e:	c3                   	ret    
  80209f:	90                   	nop
  8020a0:	89 fd                	mov    %edi,%ebp
  8020a2:	85 ff                	test   %edi,%edi
  8020a4:	75 0b                	jne    8020b1 <__umoddi3+0xe9>
  8020a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ab:	31 d2                	xor    %edx,%edx
  8020ad:	f7 f7                	div    %edi
  8020af:	89 c5                	mov    %eax,%ebp
  8020b1:	89 f0                	mov    %esi,%eax
  8020b3:	31 d2                	xor    %edx,%edx
  8020b5:	f7 f5                	div    %ebp
  8020b7:	89 c8                	mov    %ecx,%eax
  8020b9:	f7 f5                	div    %ebp
  8020bb:	89 d0                	mov    %edx,%eax
  8020bd:	e9 44 ff ff ff       	jmp    802006 <__umoddi3+0x3e>
  8020c2:	66 90                	xchg   %ax,%ax
  8020c4:	89 c8                	mov    %ecx,%eax
  8020c6:	89 f2                	mov    %esi,%edx
  8020c8:	83 c4 1c             	add    $0x1c,%esp
  8020cb:	5b                   	pop    %ebx
  8020cc:	5e                   	pop    %esi
  8020cd:	5f                   	pop    %edi
  8020ce:	5d                   	pop    %ebp
  8020cf:	c3                   	ret    
  8020d0:	3b 04 24             	cmp    (%esp),%eax
  8020d3:	72 06                	jb     8020db <__umoddi3+0x113>
  8020d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020d9:	77 0f                	ja     8020ea <__umoddi3+0x122>
  8020db:	89 f2                	mov    %esi,%edx
  8020dd:	29 f9                	sub    %edi,%ecx
  8020df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020e3:	89 14 24             	mov    %edx,(%esp)
  8020e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020ee:	8b 14 24             	mov    (%esp),%edx
  8020f1:	83 c4 1c             	add    $0x1c,%esp
  8020f4:	5b                   	pop    %ebx
  8020f5:	5e                   	pop    %esi
  8020f6:	5f                   	pop    %edi
  8020f7:	5d                   	pop    %ebp
  8020f8:	c3                   	ret    
  8020f9:	8d 76 00             	lea    0x0(%esi),%esi
  8020fc:	2b 04 24             	sub    (%esp),%eax
  8020ff:	19 fa                	sbb    %edi,%edx
  802101:	89 d1                	mov    %edx,%ecx
  802103:	89 c6                	mov    %eax,%esi
  802105:	e9 71 ff ff ff       	jmp    80207b <__umoddi3+0xb3>
  80210a:	66 90                	xchg   %ax,%ax
  80210c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802110:	72 ea                	jb     8020fc <__umoddi3+0x134>
  802112:	89 d9                	mov    %ebx,%ecx
  802114:	e9 62 ff ff ff       	jmp    80207b <__umoddi3+0xb3>
