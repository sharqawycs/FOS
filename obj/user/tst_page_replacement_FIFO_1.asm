
obj/user/tst_page_replacement_FIFO_1:     file format elf32-i386


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
  800031:	e8 98 05 00 00       	call   8005ce <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 78             	sub    $0x78,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80004e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 a0 1f 80 00       	push   $0x801fa0
  800065:	6a 15                	push   $0x15
  800067:	68 e4 1f 80 00       	push   $0x801fe4
  80006c:	e8 5f 06 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800084:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 a0 1f 80 00       	push   $0x801fa0
  80009b:	6a 16                	push   $0x16
  80009d:	68 e4 1f 80 00       	push   $0x801fe4
  8000a2:	e8 29 06 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 a0 1f 80 00       	push   $0x801fa0
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 e4 1f 80 00       	push   $0x801fe4
  8000d8:	e8 f3 05 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 a0 1f 80 00       	push   $0x801fa0
  800107:	6a 18                	push   $0x18
  800109:	68 e4 1f 80 00       	push   $0x801fe4
  80010e:	e8 bd 05 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800126:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 a0 1f 80 00       	push   $0x801fa0
  80013d:	6a 19                	push   $0x19
  80013f:	68 e4 1f 80 00       	push   $0x801fe4
  800144:	e8 87 05 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80015c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 a0 1f 80 00       	push   $0x801fa0
  800173:	6a 1a                	push   $0x1a
  800175:	68 e4 1f 80 00       	push   $0x801fe4
  80017a:	e8 51 05 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800192:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 a0 1f 80 00       	push   $0x801fa0
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 e4 1f 80 00       	push   $0x801fe4
  8001b0:	e8 1b 05 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 a0 1f 80 00       	push   $0x801fa0
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 e4 1f 80 00       	push   $0x801fe4
  8001e6:	e8 e5 04 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 a0 1f 80 00       	push   $0x801fa0
  800215:	6a 1d                	push   $0x1d
  800217:	68 e4 1f 80 00       	push   $0x801fe4
  80021c:	e8 af 04 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800234:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 a0 1f 80 00       	push   $0x801fa0
  80024b:	6a 1e                	push   $0x1e
  80024d:	68 e4 1f 80 00       	push   $0x801fe4
  800252:	e8 79 04 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80026a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 a0 1f 80 00       	push   $0x801fa0
  800281:	6a 1f                	push   $0x1f
  800283:	68 e4 1f 80 00       	push   $0x801fe4
  800288:	e8 43 04 00 00       	call   8006d0 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 08 20 80 00       	push   $0x802008
  8002a4:	6a 20                	push   $0x20
  8002a6:	68 e4 1f 80 00       	push   $0x801fe4
  8002ab:	e8 20 04 00 00       	call   8006d0 <_panic>
	}


	int freePages = sys_calculate_free_frames();
  8002b0:	e8 c5 15 00 00       	call   80187a <sys_calculate_free_frames>
  8002b5:	89 45 c0             	mov    %eax,-0x40(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b8:	e8 40 16 00 00       	call   8018fd <sys_pf_calculate_allocated_pages>
  8002bd:	89 45 bc             	mov    %eax,-0x44(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  8002c0:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002c5:	88 45 bb             	mov    %al,-0x45(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  8002c8:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002cd:	88 45 ba             	mov    %al,-0x46(%ebp)
	char garbage4,garbage5;
	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002d7:	eb 26                	jmp    8002ff <_main+0x2c7>
	{
		arr[i] = -1 ;
  8002d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002dc:	05 40 30 80 00       	add    $0x803040,%eax
  8002e1:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		//ptr++ ; ptr2++ ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  8002e4:	a1 00 30 80 00       	mov    0x803000,%eax
  8002e9:	8a 00                	mov    (%eax),%al
  8002eb:	88 45 f7             	mov    %al,-0x9(%ebp)
		garbage5 = *ptr2 ;
  8002ee:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f3:	8a 00                	mov    (%eax),%al
  8002f5:	88 45 f6             	mov    %al,-0xa(%ebp)
	char garbage1 = arr[PAGE_SIZE*11-1];
	char garbage2 = arr[PAGE_SIZE*12-1];
	char garbage4,garbage5;
	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002f8:	81 45 f0 00 08 00 00 	addl   $0x800,-0x10(%ebp)
  8002ff:	81 7d f0 ff 9f 00 00 	cmpl   $0x9fff,-0x10(%ebp)
  800306:	7e d1                	jle    8002d9 <_main+0x2a1>
	}

	//===================
	//cprintf("Checking PAGE FIFO algorithm... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800308:	a1 20 30 80 00       	mov    0x803020,%eax
  80030d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800313:	8b 00                	mov    (%eax),%eax
  800315:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800318:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80031b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800320:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800325:	74 14                	je     80033b <_main+0x303>
  800327:	83 ec 04             	sub    $0x4,%esp
  80032a:	68 50 20 80 00       	push   $0x802050
  80032f:	6a 3c                	push   $0x3c
  800331:	68 e4 1f 80 00       	push   $0x801fe4
  800336:	e8 95 03 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80033b:	a1 20 30 80 00       	mov    0x803020,%eax
  800340:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800346:	83 c0 0c             	add    $0xc,%eax
  800349:	8b 00                	mov    (%eax),%eax
  80034b:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80034e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800351:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800356:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  80035b:	74 14                	je     800371 <_main+0x339>
  80035d:	83 ec 04             	sub    $0x4,%esp
  800360:	68 50 20 80 00       	push   $0x802050
  800365:	6a 3d                	push   $0x3d
  800367:	68 e4 1f 80 00       	push   $0x801fe4
  80036c:	e8 5f 03 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800371:	a1 20 30 80 00       	mov    0x803020,%eax
  800376:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80037c:	83 c0 18             	add    $0x18,%eax
  80037f:	8b 00                	mov    (%eax),%eax
  800381:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800384:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800387:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80038c:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  800391:	74 14                	je     8003a7 <_main+0x36f>
  800393:	83 ec 04             	sub    $0x4,%esp
  800396:	68 50 20 80 00       	push   $0x802050
  80039b:	6a 3e                	push   $0x3e
  80039d:	68 e4 1f 80 00       	push   $0x801fe4
  8003a2:	e8 29 03 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003b2:	83 c0 24             	add    $0x24,%eax
  8003b5:	8b 00                	mov    (%eax),%eax
  8003b7:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8003ba:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c2:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8003c7:	74 14                	je     8003dd <_main+0x3a5>
  8003c9:	83 ec 04             	sub    $0x4,%esp
  8003cc:	68 50 20 80 00       	push   $0x802050
  8003d1:	6a 3f                	push   $0x3f
  8003d3:	68 e4 1f 80 00       	push   $0x801fe4
  8003d8:	e8 f3 02 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003e8:	83 c0 30             	add    $0x30,%eax
  8003eb:	8b 00                	mov    (%eax),%eax
  8003ed:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8003f0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f8:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  8003fd:	74 14                	je     800413 <_main+0x3db>
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 50 20 80 00       	push   $0x802050
  800407:	6a 40                	push   $0x40
  800409:	68 e4 1f 80 00       	push   $0x801fe4
  80040e:	e8 bd 02 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800413:	a1 20 30 80 00       	mov    0x803020,%eax
  800418:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80041e:	83 c0 3c             	add    $0x3c,%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800426:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800429:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80042e:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800433:	74 14                	je     800449 <_main+0x411>
  800435:	83 ec 04             	sub    $0x4,%esp
  800438:	68 50 20 80 00       	push   $0x802050
  80043d:	6a 41                	push   $0x41
  80043f:	68 e4 1f 80 00       	push   $0x801fe4
  800444:	e8 87 02 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x808000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800449:	a1 20 30 80 00       	mov    0x803020,%eax
  80044e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800454:	83 c0 48             	add    $0x48,%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80045c:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80045f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800464:	3d 00 80 80 00       	cmp    $0x808000,%eax
  800469:	74 14                	je     80047f <_main+0x447>
  80046b:	83 ec 04             	sub    $0x4,%esp
  80046e:	68 50 20 80 00       	push   $0x802050
  800473:	6a 42                	push   $0x42
  800475:	68 e4 1f 80 00       	push   $0x801fe4
  80047a:	e8 51 02 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80047f:	a1 20 30 80 00       	mov    0x803020,%eax
  800484:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80048a:	83 c0 54             	add    $0x54,%eax
  80048d:	8b 00                	mov    (%eax),%eax
  80048f:	89 45 98             	mov    %eax,-0x68(%ebp)
  800492:	8b 45 98             	mov    -0x68(%ebp),%eax
  800495:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80049a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80049f:	74 14                	je     8004b5 <_main+0x47d>
  8004a1:	83 ec 04             	sub    $0x4,%esp
  8004a4:	68 50 20 80 00       	push   $0x802050
  8004a9:	6a 43                	push   $0x43
  8004ab:	68 e4 1f 80 00       	push   $0x801fe4
  8004b0:	e8 1b 02 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004c0:	83 c0 60             	add    $0x60,%eax
  8004c3:	8b 00                	mov    (%eax),%eax
  8004c5:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8004c8:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004d5:	74 14                	je     8004eb <_main+0x4b3>
  8004d7:	83 ec 04             	sub    $0x4,%esp
  8004da:	68 50 20 80 00       	push   $0x802050
  8004df:	6a 44                	push   $0x44
  8004e1:	68 e4 1f 80 00       	push   $0x801fe4
  8004e6:	e8 e5 01 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x809000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004f6:	83 c0 6c             	add    $0x6c,%eax
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	89 45 90             	mov    %eax,-0x70(%ebp)
  8004fe:	8b 45 90             	mov    -0x70(%ebp),%eax
  800501:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800506:	3d 00 90 80 00       	cmp    $0x809000,%eax
  80050b:	74 14                	je     800521 <_main+0x4e9>
  80050d:	83 ec 04             	sub    $0x4,%esp
  800510:	68 50 20 80 00       	push   $0x802050
  800515:	6a 45                	push   $0x45
  800517:	68 e4 1f 80 00       	push   $0x801fe4
  80051c:	e8 af 01 00 00       	call   8006d0 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800521:	a1 20 30 80 00       	mov    0x803020,%eax
  800526:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80052c:	83 c0 78             	add    $0x78,%eax
  80052f:	8b 00                	mov    (%eax),%eax
  800531:	89 45 8c             	mov    %eax,-0x74(%ebp)
  800534:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800537:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800541:	74 14                	je     800557 <_main+0x51f>
  800543:	83 ec 04             	sub    $0x4,%esp
  800546:	68 50 20 80 00       	push   $0x802050
  80054b:	6a 46                	push   $0x46
  80054d:	68 e4 1f 80 00       	push   $0x801fe4
  800552:	e8 79 01 00 00       	call   8006d0 <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  800557:	a1 20 30 80 00       	mov    0x803020,%eax
  80055c:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800562:	83 f8 05             	cmp    $0x5,%eax
  800565:	74 14                	je     80057b <_main+0x543>
  800567:	83 ec 04             	sub    $0x4,%esp
  80056a:	68 9c 20 80 00       	push   $0x80209c
  80056f:	6a 48                	push   $0x48
  800571:	68 e4 1f 80 00       	push   $0x801fe4
  800576:	e8 55 01 00 00       	call   8006d0 <_panic>

	}
	{
		if (garbage4 != *ptr) panic("test failed!");
  80057b:	a1 00 30 80 00       	mov    0x803000,%eax
  800580:	8a 00                	mov    (%eax),%al
  800582:	3a 45 f7             	cmp    -0x9(%ebp),%al
  800585:	74 14                	je     80059b <_main+0x563>
  800587:	83 ec 04             	sub    $0x4,%esp
  80058a:	68 bb 20 80 00       	push   $0x8020bb
  80058f:	6a 4c                	push   $0x4c
  800591:	68 e4 1f 80 00       	push   $0x801fe4
  800596:	e8 35 01 00 00       	call   8006d0 <_panic>
		if (garbage5 != *ptr2) panic("test failed!");
  80059b:	a1 04 30 80 00       	mov    0x803004,%eax
  8005a0:	8a 00                	mov    (%eax),%al
  8005a2:	3a 45 f6             	cmp    -0xa(%ebp),%al
  8005a5:	74 14                	je     8005bb <_main+0x583>
  8005a7:	83 ec 04             	sub    $0x4,%esp
  8005aa:	68 bb 20 80 00       	push   $0x8020bb
  8005af:	6a 4d                	push   $0x4d
  8005b1:	68 e4 1f 80 00       	push   $0x801fe4
  8005b6:	e8 15 01 00 00       	call   8006d0 <_panic>
	}
	cprintf("Congratulations!! test PAGE replacement [FIFO 1] is completed successfully.\n");
  8005bb:	83 ec 0c             	sub    $0xc,%esp
  8005be:	68 c8 20 80 00       	push   $0x8020c8
  8005c3:	e8 bc 03 00 00       	call   800984 <cprintf>
  8005c8:	83 c4 10             	add    $0x10,%esp
	return;
  8005cb:	90                   	nop
}
  8005cc:	c9                   	leave  
  8005cd:	c3                   	ret    

008005ce <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ce:	55                   	push   %ebp
  8005cf:	89 e5                	mov    %esp,%ebp
  8005d1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005d4:	e8 d6 11 00 00       	call   8017af <sys_getenvindex>
  8005d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005df:	89 d0                	mov    %edx,%eax
  8005e1:	01 c0                	add    %eax,%eax
  8005e3:	01 d0                	add    %edx,%eax
  8005e5:	c1 e0 02             	shl    $0x2,%eax
  8005e8:	01 d0                	add    %edx,%eax
  8005ea:	c1 e0 06             	shl    $0x6,%eax
  8005ed:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005f2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fc:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800602:	84 c0                	test   %al,%al
  800604:	74 0f                	je     800615 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800606:	a1 20 30 80 00       	mov    0x803020,%eax
  80060b:	05 f4 02 00 00       	add    $0x2f4,%eax
  800610:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800615:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800619:	7e 0a                	jle    800625 <libmain+0x57>
		binaryname = argv[0];
  80061b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800625:	83 ec 08             	sub    $0x8,%esp
  800628:	ff 75 0c             	pushl  0xc(%ebp)
  80062b:	ff 75 08             	pushl  0x8(%ebp)
  80062e:	e8 05 fa ff ff       	call   800038 <_main>
  800633:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800636:	e8 0f 13 00 00       	call   80194a <sys_disable_interrupt>
	cprintf("**************************************\n");
  80063b:	83 ec 0c             	sub    $0xc,%esp
  80063e:	68 30 21 80 00       	push   $0x802130
  800643:	e8 3c 03 00 00       	call   800984 <cprintf>
  800648:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80064b:	a1 20 30 80 00       	mov    0x803020,%eax
  800650:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800656:	a1 20 30 80 00       	mov    0x803020,%eax
  80065b:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800661:	83 ec 04             	sub    $0x4,%esp
  800664:	52                   	push   %edx
  800665:	50                   	push   %eax
  800666:	68 58 21 80 00       	push   $0x802158
  80066b:	e8 14 03 00 00       	call   800984 <cprintf>
  800670:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800673:	a1 20 30 80 00       	mov    0x803020,%eax
  800678:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80067e:	83 ec 08             	sub    $0x8,%esp
  800681:	50                   	push   %eax
  800682:	68 7d 21 80 00       	push   $0x80217d
  800687:	e8 f8 02 00 00       	call   800984 <cprintf>
  80068c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80068f:	83 ec 0c             	sub    $0xc,%esp
  800692:	68 30 21 80 00       	push   $0x802130
  800697:	e8 e8 02 00 00       	call   800984 <cprintf>
  80069c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80069f:	e8 c0 12 00 00       	call   801964 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006a4:	e8 19 00 00 00       	call   8006c2 <exit>
}
  8006a9:	90                   	nop
  8006aa:	c9                   	leave  
  8006ab:	c3                   	ret    

008006ac <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006ac:	55                   	push   %ebp
  8006ad:	89 e5                	mov    %esp,%ebp
  8006af:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006b2:	83 ec 0c             	sub    $0xc,%esp
  8006b5:	6a 00                	push   $0x0
  8006b7:	e8 bf 10 00 00       	call   80177b <sys_env_destroy>
  8006bc:	83 c4 10             	add    $0x10,%esp
}
  8006bf:	90                   	nop
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <exit>:

void
exit(void)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
  8006c5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006c8:	e8 14 11 00 00       	call   8017e1 <sys_env_exit>
}
  8006cd:	90                   	nop
  8006ce:	c9                   	leave  
  8006cf:	c3                   	ret    

008006d0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006d0:	55                   	push   %ebp
  8006d1:	89 e5                	mov    %esp,%ebp
  8006d3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006d6:	8d 45 10             	lea    0x10(%ebp),%eax
  8006d9:	83 c0 04             	add    $0x4,%eax
  8006dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006df:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8006e4:	85 c0                	test   %eax,%eax
  8006e6:	74 16                	je     8006fe <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006e8:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8006ed:	83 ec 08             	sub    $0x8,%esp
  8006f0:	50                   	push   %eax
  8006f1:	68 94 21 80 00       	push   $0x802194
  8006f6:	e8 89 02 00 00       	call   800984 <cprintf>
  8006fb:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006fe:	a1 08 30 80 00       	mov    0x803008,%eax
  800703:	ff 75 0c             	pushl  0xc(%ebp)
  800706:	ff 75 08             	pushl  0x8(%ebp)
  800709:	50                   	push   %eax
  80070a:	68 99 21 80 00       	push   $0x802199
  80070f:	e8 70 02 00 00       	call   800984 <cprintf>
  800714:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800717:	8b 45 10             	mov    0x10(%ebp),%eax
  80071a:	83 ec 08             	sub    $0x8,%esp
  80071d:	ff 75 f4             	pushl  -0xc(%ebp)
  800720:	50                   	push   %eax
  800721:	e8 f3 01 00 00       	call   800919 <vcprintf>
  800726:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800729:	83 ec 08             	sub    $0x8,%esp
  80072c:	6a 00                	push   $0x0
  80072e:	68 b5 21 80 00       	push   $0x8021b5
  800733:	e8 e1 01 00 00       	call   800919 <vcprintf>
  800738:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80073b:	e8 82 ff ff ff       	call   8006c2 <exit>

	// should not return here
	while (1) ;
  800740:	eb fe                	jmp    800740 <_panic+0x70>

00800742 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800742:	55                   	push   %ebp
  800743:	89 e5                	mov    %esp,%ebp
  800745:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800748:	a1 20 30 80 00       	mov    0x803020,%eax
  80074d:	8b 50 74             	mov    0x74(%eax),%edx
  800750:	8b 45 0c             	mov    0xc(%ebp),%eax
  800753:	39 c2                	cmp    %eax,%edx
  800755:	74 14                	je     80076b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800757:	83 ec 04             	sub    $0x4,%esp
  80075a:	68 b8 21 80 00       	push   $0x8021b8
  80075f:	6a 26                	push   $0x26
  800761:	68 04 22 80 00       	push   $0x802204
  800766:	e8 65 ff ff ff       	call   8006d0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80076b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800772:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800779:	e9 c2 00 00 00       	jmp    800840 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80077e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800781:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	01 d0                	add    %edx,%eax
  80078d:	8b 00                	mov    (%eax),%eax
  80078f:	85 c0                	test   %eax,%eax
  800791:	75 08                	jne    80079b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800793:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800796:	e9 a2 00 00 00       	jmp    80083d <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80079b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007a2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007a9:	eb 69                	jmp    800814 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007b6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007b9:	89 d0                	mov    %edx,%eax
  8007bb:	01 c0                	add    %eax,%eax
  8007bd:	01 d0                	add    %edx,%eax
  8007bf:	c1 e0 02             	shl    $0x2,%eax
  8007c2:	01 c8                	add    %ecx,%eax
  8007c4:	8a 40 04             	mov    0x4(%eax),%al
  8007c7:	84 c0                	test   %al,%al
  8007c9:	75 46                	jne    800811 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8007d6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007d9:	89 d0                	mov    %edx,%eax
  8007db:	01 c0                	add    %eax,%eax
  8007dd:	01 d0                	add    %edx,%eax
  8007df:	c1 e0 02             	shl    $0x2,%eax
  8007e2:	01 c8                	add    %ecx,%eax
  8007e4:	8b 00                	mov    (%eax),%eax
  8007e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007ec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007f1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	01 c8                	add    %ecx,%eax
  800802:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800804:	39 c2                	cmp    %eax,%edx
  800806:	75 09                	jne    800811 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800808:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80080f:	eb 12                	jmp    800823 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800811:	ff 45 e8             	incl   -0x18(%ebp)
  800814:	a1 20 30 80 00       	mov    0x803020,%eax
  800819:	8b 50 74             	mov    0x74(%eax),%edx
  80081c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081f:	39 c2                	cmp    %eax,%edx
  800821:	77 88                	ja     8007ab <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800823:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800827:	75 14                	jne    80083d <CheckWSWithoutLastIndex+0xfb>
			panic(
  800829:	83 ec 04             	sub    $0x4,%esp
  80082c:	68 10 22 80 00       	push   $0x802210
  800831:	6a 3a                	push   $0x3a
  800833:	68 04 22 80 00       	push   $0x802204
  800838:	e8 93 fe ff ff       	call   8006d0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80083d:	ff 45 f0             	incl   -0x10(%ebp)
  800840:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800843:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800846:	0f 8c 32 ff ff ff    	jl     80077e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80084c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800853:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80085a:	eb 26                	jmp    800882 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80085c:	a1 20 30 80 00       	mov    0x803020,%eax
  800861:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800867:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80086a:	89 d0                	mov    %edx,%eax
  80086c:	01 c0                	add    %eax,%eax
  80086e:	01 d0                	add    %edx,%eax
  800870:	c1 e0 02             	shl    $0x2,%eax
  800873:	01 c8                	add    %ecx,%eax
  800875:	8a 40 04             	mov    0x4(%eax),%al
  800878:	3c 01                	cmp    $0x1,%al
  80087a:	75 03                	jne    80087f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80087c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087f:	ff 45 e0             	incl   -0x20(%ebp)
  800882:	a1 20 30 80 00       	mov    0x803020,%eax
  800887:	8b 50 74             	mov    0x74(%eax),%edx
  80088a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088d:	39 c2                	cmp    %eax,%edx
  80088f:	77 cb                	ja     80085c <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800891:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800894:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800897:	74 14                	je     8008ad <CheckWSWithoutLastIndex+0x16b>
		panic(
  800899:	83 ec 04             	sub    $0x4,%esp
  80089c:	68 64 22 80 00       	push   $0x802264
  8008a1:	6a 44                	push   $0x44
  8008a3:	68 04 22 80 00       	push   $0x802204
  8008a8:	e8 23 fe ff ff       	call   8006d0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008ad:	90                   	nop
  8008ae:	c9                   	leave  
  8008af:	c3                   	ret    

008008b0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008b0:	55                   	push   %ebp
  8008b1:	89 e5                	mov    %esp,%ebp
  8008b3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	8d 48 01             	lea    0x1(%eax),%ecx
  8008be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c1:	89 0a                	mov    %ecx,(%edx)
  8008c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008c6:	88 d1                	mov    %dl,%cl
  8008c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d2:	8b 00                	mov    (%eax),%eax
  8008d4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008d9:	75 2c                	jne    800907 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008db:	a0 24 30 80 00       	mov    0x803024,%al
  8008e0:	0f b6 c0             	movzbl %al,%eax
  8008e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e6:	8b 12                	mov    (%edx),%edx
  8008e8:	89 d1                	mov    %edx,%ecx
  8008ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ed:	83 c2 08             	add    $0x8,%edx
  8008f0:	83 ec 04             	sub    $0x4,%esp
  8008f3:	50                   	push   %eax
  8008f4:	51                   	push   %ecx
  8008f5:	52                   	push   %edx
  8008f6:	e8 3e 0e 00 00       	call   801739 <sys_cputs>
  8008fb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800901:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090a:	8b 40 04             	mov    0x4(%eax),%eax
  80090d:	8d 50 01             	lea    0x1(%eax),%edx
  800910:	8b 45 0c             	mov    0xc(%ebp),%eax
  800913:	89 50 04             	mov    %edx,0x4(%eax)
}
  800916:	90                   	nop
  800917:	c9                   	leave  
  800918:	c3                   	ret    

00800919 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800919:	55                   	push   %ebp
  80091a:	89 e5                	mov    %esp,%ebp
  80091c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800922:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800929:	00 00 00 
	b.cnt = 0;
  80092c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800933:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800936:	ff 75 0c             	pushl  0xc(%ebp)
  800939:	ff 75 08             	pushl  0x8(%ebp)
  80093c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800942:	50                   	push   %eax
  800943:	68 b0 08 80 00       	push   $0x8008b0
  800948:	e8 11 02 00 00       	call   800b5e <vprintfmt>
  80094d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800950:	a0 24 30 80 00       	mov    0x803024,%al
  800955:	0f b6 c0             	movzbl %al,%eax
  800958:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80095e:	83 ec 04             	sub    $0x4,%esp
  800961:	50                   	push   %eax
  800962:	52                   	push   %edx
  800963:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800969:	83 c0 08             	add    $0x8,%eax
  80096c:	50                   	push   %eax
  80096d:	e8 c7 0d 00 00       	call   801739 <sys_cputs>
  800972:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800975:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80097c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800982:	c9                   	leave  
  800983:	c3                   	ret    

00800984 <cprintf>:

int cprintf(const char *fmt, ...) {
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80098a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800991:	8d 45 0c             	lea    0xc(%ebp),%eax
  800994:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	83 ec 08             	sub    $0x8,%esp
  80099d:	ff 75 f4             	pushl  -0xc(%ebp)
  8009a0:	50                   	push   %eax
  8009a1:	e8 73 ff ff ff       	call   800919 <vcprintf>
  8009a6:	83 c4 10             	add    $0x10,%esp
  8009a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009af:	c9                   	leave  
  8009b0:	c3                   	ret    

008009b1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009b1:	55                   	push   %ebp
  8009b2:	89 e5                	mov    %esp,%ebp
  8009b4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009b7:	e8 8e 0f 00 00       	call   80194a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009bc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	83 ec 08             	sub    $0x8,%esp
  8009c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009cb:	50                   	push   %eax
  8009cc:	e8 48 ff ff ff       	call   800919 <vcprintf>
  8009d1:	83 c4 10             	add    $0x10,%esp
  8009d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009d7:	e8 88 0f 00 00       	call   801964 <sys_enable_interrupt>
	return cnt;
  8009dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009df:	c9                   	leave  
  8009e0:	c3                   	ret    

008009e1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009e1:	55                   	push   %ebp
  8009e2:	89 e5                	mov    %esp,%ebp
  8009e4:	53                   	push   %ebx
  8009e5:	83 ec 14             	sub    $0x14,%esp
  8009e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009f4:	8b 45 18             	mov    0x18(%ebp),%eax
  8009f7:	ba 00 00 00 00       	mov    $0x0,%edx
  8009fc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009ff:	77 55                	ja     800a56 <printnum+0x75>
  800a01:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a04:	72 05                	jb     800a0b <printnum+0x2a>
  800a06:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a09:	77 4b                	ja     800a56 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a0b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a0e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a11:	8b 45 18             	mov    0x18(%ebp),%eax
  800a14:	ba 00 00 00 00       	mov    $0x0,%edx
  800a19:	52                   	push   %edx
  800a1a:	50                   	push   %eax
  800a1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1e:	ff 75 f0             	pushl  -0x10(%ebp)
  800a21:	e8 02 13 00 00       	call   801d28 <__udivdi3>
  800a26:	83 c4 10             	add    $0x10,%esp
  800a29:	83 ec 04             	sub    $0x4,%esp
  800a2c:	ff 75 20             	pushl  0x20(%ebp)
  800a2f:	53                   	push   %ebx
  800a30:	ff 75 18             	pushl  0x18(%ebp)
  800a33:	52                   	push   %edx
  800a34:	50                   	push   %eax
  800a35:	ff 75 0c             	pushl  0xc(%ebp)
  800a38:	ff 75 08             	pushl  0x8(%ebp)
  800a3b:	e8 a1 ff ff ff       	call   8009e1 <printnum>
  800a40:	83 c4 20             	add    $0x20,%esp
  800a43:	eb 1a                	jmp    800a5f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a45:	83 ec 08             	sub    $0x8,%esp
  800a48:	ff 75 0c             	pushl  0xc(%ebp)
  800a4b:	ff 75 20             	pushl  0x20(%ebp)
  800a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a51:	ff d0                	call   *%eax
  800a53:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a56:	ff 4d 1c             	decl   0x1c(%ebp)
  800a59:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a5d:	7f e6                	jg     800a45 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a5f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a62:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a6d:	53                   	push   %ebx
  800a6e:	51                   	push   %ecx
  800a6f:	52                   	push   %edx
  800a70:	50                   	push   %eax
  800a71:	e8 c2 13 00 00       	call   801e38 <__umoddi3>
  800a76:	83 c4 10             	add    $0x10,%esp
  800a79:	05 d4 24 80 00       	add    $0x8024d4,%eax
  800a7e:	8a 00                	mov    (%eax),%al
  800a80:	0f be c0             	movsbl %al,%eax
  800a83:	83 ec 08             	sub    $0x8,%esp
  800a86:	ff 75 0c             	pushl  0xc(%ebp)
  800a89:	50                   	push   %eax
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	ff d0                	call   *%eax
  800a8f:	83 c4 10             	add    $0x10,%esp
}
  800a92:	90                   	nop
  800a93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a96:	c9                   	leave  
  800a97:	c3                   	ret    

00800a98 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a98:	55                   	push   %ebp
  800a99:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a9b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a9f:	7e 1c                	jle    800abd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	8b 00                	mov    (%eax),%eax
  800aa6:	8d 50 08             	lea    0x8(%eax),%edx
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	89 10                	mov    %edx,(%eax)
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	8b 00                	mov    (%eax),%eax
  800ab3:	83 e8 08             	sub    $0x8,%eax
  800ab6:	8b 50 04             	mov    0x4(%eax),%edx
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	eb 40                	jmp    800afd <getuint+0x65>
	else if (lflag)
  800abd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ac1:	74 1e                	je     800ae1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8b 00                	mov    (%eax),%eax
  800ac8:	8d 50 04             	lea    0x4(%eax),%edx
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	89 10                	mov    %edx,(%eax)
  800ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	83 e8 04             	sub    $0x4,%eax
  800ad8:	8b 00                	mov    (%eax),%eax
  800ada:	ba 00 00 00 00       	mov    $0x0,%edx
  800adf:	eb 1c                	jmp    800afd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	8b 00                	mov    (%eax),%eax
  800ae6:	8d 50 04             	lea    0x4(%eax),%edx
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	89 10                	mov    %edx,(%eax)
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	8b 00                	mov    (%eax),%eax
  800af3:	83 e8 04             	sub    $0x4,%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800afd:	5d                   	pop    %ebp
  800afe:	c3                   	ret    

00800aff <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800aff:	55                   	push   %ebp
  800b00:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b02:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b06:	7e 1c                	jle    800b24 <getint+0x25>
		return va_arg(*ap, long long);
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	8d 50 08             	lea    0x8(%eax),%edx
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	89 10                	mov    %edx,(%eax)
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	8b 00                	mov    (%eax),%eax
  800b1a:	83 e8 08             	sub    $0x8,%eax
  800b1d:	8b 50 04             	mov    0x4(%eax),%edx
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	eb 38                	jmp    800b5c <getint+0x5d>
	else if (lflag)
  800b24:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b28:	74 1a                	je     800b44 <getint+0x45>
		return va_arg(*ap, long);
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	8b 00                	mov    (%eax),%eax
  800b2f:	8d 50 04             	lea    0x4(%eax),%edx
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	89 10                	mov    %edx,(%eax)
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	83 e8 04             	sub    $0x4,%eax
  800b3f:	8b 00                	mov    (%eax),%eax
  800b41:	99                   	cltd   
  800b42:	eb 18                	jmp    800b5c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b44:	8b 45 08             	mov    0x8(%ebp),%eax
  800b47:	8b 00                	mov    (%eax),%eax
  800b49:	8d 50 04             	lea    0x4(%eax),%edx
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	89 10                	mov    %edx,(%eax)
  800b51:	8b 45 08             	mov    0x8(%ebp),%eax
  800b54:	8b 00                	mov    (%eax),%eax
  800b56:	83 e8 04             	sub    $0x4,%eax
  800b59:	8b 00                	mov    (%eax),%eax
  800b5b:	99                   	cltd   
}
  800b5c:	5d                   	pop    %ebp
  800b5d:	c3                   	ret    

00800b5e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	56                   	push   %esi
  800b62:	53                   	push   %ebx
  800b63:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b66:	eb 17                	jmp    800b7f <vprintfmt+0x21>
			if (ch == '\0')
  800b68:	85 db                	test   %ebx,%ebx
  800b6a:	0f 84 af 03 00 00    	je     800f1f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b70:	83 ec 08             	sub    $0x8,%esp
  800b73:	ff 75 0c             	pushl  0xc(%ebp)
  800b76:	53                   	push   %ebx
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	ff d0                	call   *%eax
  800b7c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b82:	8d 50 01             	lea    0x1(%eax),%edx
  800b85:	89 55 10             	mov    %edx,0x10(%ebp)
  800b88:	8a 00                	mov    (%eax),%al
  800b8a:	0f b6 d8             	movzbl %al,%ebx
  800b8d:	83 fb 25             	cmp    $0x25,%ebx
  800b90:	75 d6                	jne    800b68 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b92:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b96:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b9d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ba4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bab:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb5:	8d 50 01             	lea    0x1(%eax),%edx
  800bb8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bbb:	8a 00                	mov    (%eax),%al
  800bbd:	0f b6 d8             	movzbl %al,%ebx
  800bc0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bc3:	83 f8 55             	cmp    $0x55,%eax
  800bc6:	0f 87 2b 03 00 00    	ja     800ef7 <vprintfmt+0x399>
  800bcc:	8b 04 85 f8 24 80 00 	mov    0x8024f8(,%eax,4),%eax
  800bd3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bd5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bd9:	eb d7                	jmp    800bb2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bdb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bdf:	eb d1                	jmp    800bb2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800be1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800be8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800beb:	89 d0                	mov    %edx,%eax
  800bed:	c1 e0 02             	shl    $0x2,%eax
  800bf0:	01 d0                	add    %edx,%eax
  800bf2:	01 c0                	add    %eax,%eax
  800bf4:	01 d8                	add    %ebx,%eax
  800bf6:	83 e8 30             	sub    $0x30,%eax
  800bf9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bfc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c04:	83 fb 2f             	cmp    $0x2f,%ebx
  800c07:	7e 3e                	jle    800c47 <vprintfmt+0xe9>
  800c09:	83 fb 39             	cmp    $0x39,%ebx
  800c0c:	7f 39                	jg     800c47 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c0e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c11:	eb d5                	jmp    800be8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c13:	8b 45 14             	mov    0x14(%ebp),%eax
  800c16:	83 c0 04             	add    $0x4,%eax
  800c19:	89 45 14             	mov    %eax,0x14(%ebp)
  800c1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c1f:	83 e8 04             	sub    $0x4,%eax
  800c22:	8b 00                	mov    (%eax),%eax
  800c24:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c27:	eb 1f                	jmp    800c48 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c29:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c2d:	79 83                	jns    800bb2 <vprintfmt+0x54>
				width = 0;
  800c2f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c36:	e9 77 ff ff ff       	jmp    800bb2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c3b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c42:	e9 6b ff ff ff       	jmp    800bb2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c47:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c48:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c4c:	0f 89 60 ff ff ff    	jns    800bb2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c52:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c58:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c5f:	e9 4e ff ff ff       	jmp    800bb2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c64:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c67:	e9 46 ff ff ff       	jmp    800bb2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6f:	83 c0 04             	add    $0x4,%eax
  800c72:	89 45 14             	mov    %eax,0x14(%ebp)
  800c75:	8b 45 14             	mov    0x14(%ebp),%eax
  800c78:	83 e8 04             	sub    $0x4,%eax
  800c7b:	8b 00                	mov    (%eax),%eax
  800c7d:	83 ec 08             	sub    $0x8,%esp
  800c80:	ff 75 0c             	pushl  0xc(%ebp)
  800c83:	50                   	push   %eax
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	ff d0                	call   *%eax
  800c89:	83 c4 10             	add    $0x10,%esp
			break;
  800c8c:	e9 89 02 00 00       	jmp    800f1a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c91:	8b 45 14             	mov    0x14(%ebp),%eax
  800c94:	83 c0 04             	add    $0x4,%eax
  800c97:	89 45 14             	mov    %eax,0x14(%ebp)
  800c9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9d:	83 e8 04             	sub    $0x4,%eax
  800ca0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ca2:	85 db                	test   %ebx,%ebx
  800ca4:	79 02                	jns    800ca8 <vprintfmt+0x14a>
				err = -err;
  800ca6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ca8:	83 fb 64             	cmp    $0x64,%ebx
  800cab:	7f 0b                	jg     800cb8 <vprintfmt+0x15a>
  800cad:	8b 34 9d 40 23 80 00 	mov    0x802340(,%ebx,4),%esi
  800cb4:	85 f6                	test   %esi,%esi
  800cb6:	75 19                	jne    800cd1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cb8:	53                   	push   %ebx
  800cb9:	68 e5 24 80 00       	push   $0x8024e5
  800cbe:	ff 75 0c             	pushl  0xc(%ebp)
  800cc1:	ff 75 08             	pushl  0x8(%ebp)
  800cc4:	e8 5e 02 00 00       	call   800f27 <printfmt>
  800cc9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ccc:	e9 49 02 00 00       	jmp    800f1a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cd1:	56                   	push   %esi
  800cd2:	68 ee 24 80 00       	push   $0x8024ee
  800cd7:	ff 75 0c             	pushl  0xc(%ebp)
  800cda:	ff 75 08             	pushl  0x8(%ebp)
  800cdd:	e8 45 02 00 00       	call   800f27 <printfmt>
  800ce2:	83 c4 10             	add    $0x10,%esp
			break;
  800ce5:	e9 30 02 00 00       	jmp    800f1a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cea:	8b 45 14             	mov    0x14(%ebp),%eax
  800ced:	83 c0 04             	add    $0x4,%eax
  800cf0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf6:	83 e8 04             	sub    $0x4,%eax
  800cf9:	8b 30                	mov    (%eax),%esi
  800cfb:	85 f6                	test   %esi,%esi
  800cfd:	75 05                	jne    800d04 <vprintfmt+0x1a6>
				p = "(null)";
  800cff:	be f1 24 80 00       	mov    $0x8024f1,%esi
			if (width > 0 && padc != '-')
  800d04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d08:	7e 6d                	jle    800d77 <vprintfmt+0x219>
  800d0a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d0e:	74 67                	je     800d77 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d10:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d13:	83 ec 08             	sub    $0x8,%esp
  800d16:	50                   	push   %eax
  800d17:	56                   	push   %esi
  800d18:	e8 0c 03 00 00       	call   801029 <strnlen>
  800d1d:	83 c4 10             	add    $0x10,%esp
  800d20:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d23:	eb 16                	jmp    800d3b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d25:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d29:	83 ec 08             	sub    $0x8,%esp
  800d2c:	ff 75 0c             	pushl  0xc(%ebp)
  800d2f:	50                   	push   %eax
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	ff d0                	call   *%eax
  800d35:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d38:	ff 4d e4             	decl   -0x1c(%ebp)
  800d3b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d3f:	7f e4                	jg     800d25 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d41:	eb 34                	jmp    800d77 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d43:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d47:	74 1c                	je     800d65 <vprintfmt+0x207>
  800d49:	83 fb 1f             	cmp    $0x1f,%ebx
  800d4c:	7e 05                	jle    800d53 <vprintfmt+0x1f5>
  800d4e:	83 fb 7e             	cmp    $0x7e,%ebx
  800d51:	7e 12                	jle    800d65 <vprintfmt+0x207>
					putch('?', putdat);
  800d53:	83 ec 08             	sub    $0x8,%esp
  800d56:	ff 75 0c             	pushl  0xc(%ebp)
  800d59:	6a 3f                	push   $0x3f
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	ff d0                	call   *%eax
  800d60:	83 c4 10             	add    $0x10,%esp
  800d63:	eb 0f                	jmp    800d74 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d65:	83 ec 08             	sub    $0x8,%esp
  800d68:	ff 75 0c             	pushl  0xc(%ebp)
  800d6b:	53                   	push   %ebx
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	ff d0                	call   *%eax
  800d71:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d74:	ff 4d e4             	decl   -0x1c(%ebp)
  800d77:	89 f0                	mov    %esi,%eax
  800d79:	8d 70 01             	lea    0x1(%eax),%esi
  800d7c:	8a 00                	mov    (%eax),%al
  800d7e:	0f be d8             	movsbl %al,%ebx
  800d81:	85 db                	test   %ebx,%ebx
  800d83:	74 24                	je     800da9 <vprintfmt+0x24b>
  800d85:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d89:	78 b8                	js     800d43 <vprintfmt+0x1e5>
  800d8b:	ff 4d e0             	decl   -0x20(%ebp)
  800d8e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d92:	79 af                	jns    800d43 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d94:	eb 13                	jmp    800da9 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d96:	83 ec 08             	sub    $0x8,%esp
  800d99:	ff 75 0c             	pushl  0xc(%ebp)
  800d9c:	6a 20                	push   $0x20
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	ff d0                	call   *%eax
  800da3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da6:	ff 4d e4             	decl   -0x1c(%ebp)
  800da9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dad:	7f e7                	jg     800d96 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800daf:	e9 66 01 00 00       	jmp    800f1a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800db4:	83 ec 08             	sub    $0x8,%esp
  800db7:	ff 75 e8             	pushl  -0x18(%ebp)
  800dba:	8d 45 14             	lea    0x14(%ebp),%eax
  800dbd:	50                   	push   %eax
  800dbe:	e8 3c fd ff ff       	call   800aff <getint>
  800dc3:	83 c4 10             	add    $0x10,%esp
  800dc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dcf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dd2:	85 d2                	test   %edx,%edx
  800dd4:	79 23                	jns    800df9 <vprintfmt+0x29b>
				putch('-', putdat);
  800dd6:	83 ec 08             	sub    $0x8,%esp
  800dd9:	ff 75 0c             	pushl  0xc(%ebp)
  800ddc:	6a 2d                	push   $0x2d
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	ff d0                	call   *%eax
  800de3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800de6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dec:	f7 d8                	neg    %eax
  800dee:	83 d2 00             	adc    $0x0,%edx
  800df1:	f7 da                	neg    %edx
  800df3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800df9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e00:	e9 bc 00 00 00       	jmp    800ec1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e05:	83 ec 08             	sub    $0x8,%esp
  800e08:	ff 75 e8             	pushl  -0x18(%ebp)
  800e0b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e0e:	50                   	push   %eax
  800e0f:	e8 84 fc ff ff       	call   800a98 <getuint>
  800e14:	83 c4 10             	add    $0x10,%esp
  800e17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e1a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e1d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e24:	e9 98 00 00 00       	jmp    800ec1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e29:	83 ec 08             	sub    $0x8,%esp
  800e2c:	ff 75 0c             	pushl  0xc(%ebp)
  800e2f:	6a 58                	push   $0x58
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	ff d0                	call   *%eax
  800e36:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e39:	83 ec 08             	sub    $0x8,%esp
  800e3c:	ff 75 0c             	pushl  0xc(%ebp)
  800e3f:	6a 58                	push   $0x58
  800e41:	8b 45 08             	mov    0x8(%ebp),%eax
  800e44:	ff d0                	call   *%eax
  800e46:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e49:	83 ec 08             	sub    $0x8,%esp
  800e4c:	ff 75 0c             	pushl  0xc(%ebp)
  800e4f:	6a 58                	push   $0x58
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	ff d0                	call   *%eax
  800e56:	83 c4 10             	add    $0x10,%esp
			break;
  800e59:	e9 bc 00 00 00       	jmp    800f1a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e5e:	83 ec 08             	sub    $0x8,%esp
  800e61:	ff 75 0c             	pushl  0xc(%ebp)
  800e64:	6a 30                	push   $0x30
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e6e:	83 ec 08             	sub    $0x8,%esp
  800e71:	ff 75 0c             	pushl  0xc(%ebp)
  800e74:	6a 78                	push   $0x78
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	ff d0                	call   *%eax
  800e7b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e81:	83 c0 04             	add    $0x4,%eax
  800e84:	89 45 14             	mov    %eax,0x14(%ebp)
  800e87:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8a:	83 e8 04             	sub    $0x4,%eax
  800e8d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e99:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ea0:	eb 1f                	jmp    800ec1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ea2:	83 ec 08             	sub    $0x8,%esp
  800ea5:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea8:	8d 45 14             	lea    0x14(%ebp),%eax
  800eab:	50                   	push   %eax
  800eac:	e8 e7 fb ff ff       	call   800a98 <getuint>
  800eb1:	83 c4 10             	add    $0x10,%esp
  800eb4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eba:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ec1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ec5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ec8:	83 ec 04             	sub    $0x4,%esp
  800ecb:	52                   	push   %edx
  800ecc:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ecf:	50                   	push   %eax
  800ed0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ed3:	ff 75 f0             	pushl  -0x10(%ebp)
  800ed6:	ff 75 0c             	pushl  0xc(%ebp)
  800ed9:	ff 75 08             	pushl  0x8(%ebp)
  800edc:	e8 00 fb ff ff       	call   8009e1 <printnum>
  800ee1:	83 c4 20             	add    $0x20,%esp
			break;
  800ee4:	eb 34                	jmp    800f1a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ee6:	83 ec 08             	sub    $0x8,%esp
  800ee9:	ff 75 0c             	pushl  0xc(%ebp)
  800eec:	53                   	push   %ebx
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	ff d0                	call   *%eax
  800ef2:	83 c4 10             	add    $0x10,%esp
			break;
  800ef5:	eb 23                	jmp    800f1a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ef7:	83 ec 08             	sub    $0x8,%esp
  800efa:	ff 75 0c             	pushl  0xc(%ebp)
  800efd:	6a 25                	push   $0x25
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	ff d0                	call   *%eax
  800f04:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f07:	ff 4d 10             	decl   0x10(%ebp)
  800f0a:	eb 03                	jmp    800f0f <vprintfmt+0x3b1>
  800f0c:	ff 4d 10             	decl   0x10(%ebp)
  800f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f12:	48                   	dec    %eax
  800f13:	8a 00                	mov    (%eax),%al
  800f15:	3c 25                	cmp    $0x25,%al
  800f17:	75 f3                	jne    800f0c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f19:	90                   	nop
		}
	}
  800f1a:	e9 47 fc ff ff       	jmp    800b66 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f1f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f20:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f23:	5b                   	pop    %ebx
  800f24:	5e                   	pop    %esi
  800f25:	5d                   	pop    %ebp
  800f26:	c3                   	ret    

00800f27 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f27:	55                   	push   %ebp
  800f28:	89 e5                	mov    %esp,%ebp
  800f2a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f2d:	8d 45 10             	lea    0x10(%ebp),%eax
  800f30:	83 c0 04             	add    $0x4,%eax
  800f33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f36:	8b 45 10             	mov    0x10(%ebp),%eax
  800f39:	ff 75 f4             	pushl  -0xc(%ebp)
  800f3c:	50                   	push   %eax
  800f3d:	ff 75 0c             	pushl  0xc(%ebp)
  800f40:	ff 75 08             	pushl  0x8(%ebp)
  800f43:	e8 16 fc ff ff       	call   800b5e <vprintfmt>
  800f48:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f4b:	90                   	nop
  800f4c:	c9                   	leave  
  800f4d:	c3                   	ret    

00800f4e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f4e:	55                   	push   %ebp
  800f4f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	8b 40 08             	mov    0x8(%eax),%eax
  800f57:	8d 50 01             	lea    0x1(%eax),%edx
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f63:	8b 10                	mov    (%eax),%edx
  800f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f68:	8b 40 04             	mov    0x4(%eax),%eax
  800f6b:	39 c2                	cmp    %eax,%edx
  800f6d:	73 12                	jae    800f81 <sprintputch+0x33>
		*b->buf++ = ch;
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	8b 00                	mov    (%eax),%eax
  800f74:	8d 48 01             	lea    0x1(%eax),%ecx
  800f77:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f7a:	89 0a                	mov    %ecx,(%edx)
  800f7c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f7f:	88 10                	mov    %dl,(%eax)
}
  800f81:	90                   	nop
  800f82:	5d                   	pop    %ebp
  800f83:	c3                   	ret    

00800f84 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f84:	55                   	push   %ebp
  800f85:	89 e5                	mov    %esp,%ebp
  800f87:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	01 d0                	add    %edx,%eax
  800f9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fa5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa9:	74 06                	je     800fb1 <vsnprintf+0x2d>
  800fab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800faf:	7f 07                	jg     800fb8 <vsnprintf+0x34>
		return -E_INVAL;
  800fb1:	b8 03 00 00 00       	mov    $0x3,%eax
  800fb6:	eb 20                	jmp    800fd8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fb8:	ff 75 14             	pushl  0x14(%ebp)
  800fbb:	ff 75 10             	pushl  0x10(%ebp)
  800fbe:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fc1:	50                   	push   %eax
  800fc2:	68 4e 0f 80 00       	push   $0x800f4e
  800fc7:	e8 92 fb ff ff       	call   800b5e <vprintfmt>
  800fcc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fd2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fd8:	c9                   	leave  
  800fd9:	c3                   	ret    

00800fda <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fda:	55                   	push   %ebp
  800fdb:	89 e5                	mov    %esp,%ebp
  800fdd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fe0:	8d 45 10             	lea    0x10(%ebp),%eax
  800fe3:	83 c0 04             	add    $0x4,%eax
  800fe6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	ff 75 f4             	pushl  -0xc(%ebp)
  800fef:	50                   	push   %eax
  800ff0:	ff 75 0c             	pushl  0xc(%ebp)
  800ff3:	ff 75 08             	pushl  0x8(%ebp)
  800ff6:	e8 89 ff ff ff       	call   800f84 <vsnprintf>
  800ffb:	83 c4 10             	add    $0x10,%esp
  800ffe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801001:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801004:	c9                   	leave  
  801005:	c3                   	ret    

00801006 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801006:	55                   	push   %ebp
  801007:	89 e5                	mov    %esp,%ebp
  801009:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80100c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801013:	eb 06                	jmp    80101b <strlen+0x15>
		n++;
  801015:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801018:	ff 45 08             	incl   0x8(%ebp)
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	84 c0                	test   %al,%al
  801022:	75 f1                	jne    801015 <strlen+0xf>
		n++;
	return n;
  801024:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801027:	c9                   	leave  
  801028:	c3                   	ret    

00801029 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
  80102c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80102f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801036:	eb 09                	jmp    801041 <strnlen+0x18>
		n++;
  801038:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80103b:	ff 45 08             	incl   0x8(%ebp)
  80103e:	ff 4d 0c             	decl   0xc(%ebp)
  801041:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801045:	74 09                	je     801050 <strnlen+0x27>
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	84 c0                	test   %al,%al
  80104e:	75 e8                	jne    801038 <strnlen+0xf>
		n++;
	return n;
  801050:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801053:	c9                   	leave  
  801054:	c3                   	ret    

00801055 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
  801058:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801061:	90                   	nop
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
  801065:	8d 50 01             	lea    0x1(%eax),%edx
  801068:	89 55 08             	mov    %edx,0x8(%ebp)
  80106b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80106e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801071:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801074:	8a 12                	mov    (%edx),%dl
  801076:	88 10                	mov    %dl,(%eax)
  801078:	8a 00                	mov    (%eax),%al
  80107a:	84 c0                	test   %al,%al
  80107c:	75 e4                	jne    801062 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80107e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801081:	c9                   	leave  
  801082:	c3                   	ret    

00801083 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801083:	55                   	push   %ebp
  801084:	89 e5                	mov    %esp,%ebp
  801086:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80108f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801096:	eb 1f                	jmp    8010b7 <strncpy+0x34>
		*dst++ = *src;
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	8d 50 01             	lea    0x1(%eax),%edx
  80109e:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a4:	8a 12                	mov    (%edx),%dl
  8010a6:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ab:	8a 00                	mov    (%eax),%al
  8010ad:	84 c0                	test   %al,%al
  8010af:	74 03                	je     8010b4 <strncpy+0x31>
			src++;
  8010b1:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010b4:	ff 45 fc             	incl   -0x4(%ebp)
  8010b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ba:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010bd:	72 d9                	jb     801098 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
  8010c7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d4:	74 30                	je     801106 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010d6:	eb 16                	jmp    8010ee <strlcpy+0x2a>
			*dst++ = *src++;
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	8d 50 01             	lea    0x1(%eax),%edx
  8010de:	89 55 08             	mov    %edx,0x8(%ebp)
  8010e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010e7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ea:	8a 12                	mov    (%edx),%dl
  8010ec:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010ee:	ff 4d 10             	decl   0x10(%ebp)
  8010f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f5:	74 09                	je     801100 <strlcpy+0x3c>
  8010f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	84 c0                	test   %al,%al
  8010fe:	75 d8                	jne    8010d8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801106:	8b 55 08             	mov    0x8(%ebp),%edx
  801109:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80110c:	29 c2                	sub    %eax,%edx
  80110e:	89 d0                	mov    %edx,%eax
}
  801110:	c9                   	leave  
  801111:	c3                   	ret    

00801112 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801112:	55                   	push   %ebp
  801113:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801115:	eb 06                	jmp    80111d <strcmp+0xb>
		p++, q++;
  801117:	ff 45 08             	incl   0x8(%ebp)
  80111a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	84 c0                	test   %al,%al
  801124:	74 0e                	je     801134 <strcmp+0x22>
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	8a 10                	mov    (%eax),%dl
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	38 c2                	cmp    %al,%dl
  801132:	74 e3                	je     801117 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	0f b6 d0             	movzbl %al,%edx
  80113c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	0f b6 c0             	movzbl %al,%eax
  801144:	29 c2                	sub    %eax,%edx
  801146:	89 d0                	mov    %edx,%eax
}
  801148:	5d                   	pop    %ebp
  801149:	c3                   	ret    

0080114a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80114a:	55                   	push   %ebp
  80114b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80114d:	eb 09                	jmp    801158 <strncmp+0xe>
		n--, p++, q++;
  80114f:	ff 4d 10             	decl   0x10(%ebp)
  801152:	ff 45 08             	incl   0x8(%ebp)
  801155:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801158:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80115c:	74 17                	je     801175 <strncmp+0x2b>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	84 c0                	test   %al,%al
  801165:	74 0e                	je     801175 <strncmp+0x2b>
  801167:	8b 45 08             	mov    0x8(%ebp),%eax
  80116a:	8a 10                	mov    (%eax),%dl
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	38 c2                	cmp    %al,%dl
  801173:	74 da                	je     80114f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801175:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801179:	75 07                	jne    801182 <strncmp+0x38>
		return 0;
  80117b:	b8 00 00 00 00       	mov    $0x0,%eax
  801180:	eb 14                	jmp    801196 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801182:	8b 45 08             	mov    0x8(%ebp),%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	0f b6 d0             	movzbl %al,%edx
  80118a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	0f b6 c0             	movzbl %al,%eax
  801192:	29 c2                	sub    %eax,%edx
  801194:	89 d0                	mov    %edx,%eax
}
  801196:	5d                   	pop    %ebp
  801197:	c3                   	ret    

00801198 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801198:	55                   	push   %ebp
  801199:	89 e5                	mov    %esp,%ebp
  80119b:	83 ec 04             	sub    $0x4,%esp
  80119e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011a4:	eb 12                	jmp    8011b8 <strchr+0x20>
		if (*s == c)
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011ae:	75 05                	jne    8011b5 <strchr+0x1d>
			return (char *) s;
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	eb 11                	jmp    8011c6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011b5:	ff 45 08             	incl   0x8(%ebp)
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	84 c0                	test   %al,%al
  8011bf:	75 e5                	jne    8011a6 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011c6:	c9                   	leave  
  8011c7:	c3                   	ret    

008011c8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011c8:	55                   	push   %ebp
  8011c9:	89 e5                	mov    %esp,%ebp
  8011cb:	83 ec 04             	sub    $0x4,%esp
  8011ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011d4:	eb 0d                	jmp    8011e3 <strfind+0x1b>
		if (*s == c)
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011de:	74 0e                	je     8011ee <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011e0:	ff 45 08             	incl   0x8(%ebp)
  8011e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e6:	8a 00                	mov    (%eax),%al
  8011e8:	84 c0                	test   %al,%al
  8011ea:	75 ea                	jne    8011d6 <strfind+0xe>
  8011ec:	eb 01                	jmp    8011ef <strfind+0x27>
		if (*s == c)
			break;
  8011ee:	90                   	nop
	return (char *) s;
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801200:	8b 45 10             	mov    0x10(%ebp),%eax
  801203:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801206:	eb 0e                	jmp    801216 <memset+0x22>
		*p++ = c;
  801208:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80120b:	8d 50 01             	lea    0x1(%eax),%edx
  80120e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801211:	8b 55 0c             	mov    0xc(%ebp),%edx
  801214:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801216:	ff 4d f8             	decl   -0x8(%ebp)
  801219:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80121d:	79 e9                	jns    801208 <memset+0x14>
		*p++ = c;

	return v;
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
  801227:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80122a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801236:	eb 16                	jmp    80124e <memcpy+0x2a>
		*d++ = *s++;
  801238:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80123b:	8d 50 01             	lea    0x1(%eax),%edx
  80123e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801241:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801244:	8d 4a 01             	lea    0x1(%edx),%ecx
  801247:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80124a:	8a 12                	mov    (%edx),%dl
  80124c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80124e:	8b 45 10             	mov    0x10(%ebp),%eax
  801251:	8d 50 ff             	lea    -0x1(%eax),%edx
  801254:	89 55 10             	mov    %edx,0x10(%ebp)
  801257:	85 c0                	test   %eax,%eax
  801259:	75 dd                	jne    801238 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80125b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125e:	c9                   	leave  
  80125f:	c3                   	ret    

00801260 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801260:	55                   	push   %ebp
  801261:	89 e5                	mov    %esp,%ebp
  801263:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801266:	8b 45 0c             	mov    0xc(%ebp),%eax
  801269:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
  80126f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801272:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801275:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801278:	73 50                	jae    8012ca <memmove+0x6a>
  80127a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80127d:	8b 45 10             	mov    0x10(%ebp),%eax
  801280:	01 d0                	add    %edx,%eax
  801282:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801285:	76 43                	jbe    8012ca <memmove+0x6a>
		s += n;
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80128d:	8b 45 10             	mov    0x10(%ebp),%eax
  801290:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801293:	eb 10                	jmp    8012a5 <memmove+0x45>
			*--d = *--s;
  801295:	ff 4d f8             	decl   -0x8(%ebp)
  801298:	ff 4d fc             	decl   -0x4(%ebp)
  80129b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80129e:	8a 10                	mov    (%eax),%dl
  8012a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a3:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ab:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ae:	85 c0                	test   %eax,%eax
  8012b0:	75 e3                	jne    801295 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012b2:	eb 23                	jmp    8012d7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b7:	8d 50 01             	lea    0x1(%eax),%edx
  8012ba:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012c3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012c6:	8a 12                	mov    (%edx),%dl
  8012c8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012d3:	85 c0                	test   %eax,%eax
  8012d5:	75 dd                	jne    8012b4 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
  8012df:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012eb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012ee:	eb 2a                	jmp    80131a <memcmp+0x3e>
		if (*s1 != *s2)
  8012f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f3:	8a 10                	mov    (%eax),%dl
  8012f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	38 c2                	cmp    %al,%dl
  8012fc:	74 16                	je     801314 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	0f b6 d0             	movzbl %al,%edx
  801306:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	0f b6 c0             	movzbl %al,%eax
  80130e:	29 c2                	sub    %eax,%edx
  801310:	89 d0                	mov    %edx,%eax
  801312:	eb 18                	jmp    80132c <memcmp+0x50>
		s1++, s2++;
  801314:	ff 45 fc             	incl   -0x4(%ebp)
  801317:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80131a:	8b 45 10             	mov    0x10(%ebp),%eax
  80131d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801320:	89 55 10             	mov    %edx,0x10(%ebp)
  801323:	85 c0                	test   %eax,%eax
  801325:	75 c9                	jne    8012f0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801327:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
  801331:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801334:	8b 55 08             	mov    0x8(%ebp),%edx
  801337:	8b 45 10             	mov    0x10(%ebp),%eax
  80133a:	01 d0                	add    %edx,%eax
  80133c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80133f:	eb 15                	jmp    801356 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	0f b6 d0             	movzbl %al,%edx
  801349:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134c:	0f b6 c0             	movzbl %al,%eax
  80134f:	39 c2                	cmp    %eax,%edx
  801351:	74 0d                	je     801360 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801353:	ff 45 08             	incl   0x8(%ebp)
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80135c:	72 e3                	jb     801341 <memfind+0x13>
  80135e:	eb 01                	jmp    801361 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801360:	90                   	nop
	return (void *) s;
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
  801369:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80136c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801373:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80137a:	eb 03                	jmp    80137f <strtol+0x19>
		s++;
  80137c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 20                	cmp    $0x20,%al
  801386:	74 f4                	je     80137c <strtol+0x16>
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	3c 09                	cmp    $0x9,%al
  80138f:	74 eb                	je     80137c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	8a 00                	mov    (%eax),%al
  801396:	3c 2b                	cmp    $0x2b,%al
  801398:	75 05                	jne    80139f <strtol+0x39>
		s++;
  80139a:	ff 45 08             	incl   0x8(%ebp)
  80139d:	eb 13                	jmp    8013b2 <strtol+0x4c>
	else if (*s == '-')
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	8a 00                	mov    (%eax),%al
  8013a4:	3c 2d                	cmp    $0x2d,%al
  8013a6:	75 0a                	jne    8013b2 <strtol+0x4c>
		s++, neg = 1;
  8013a8:	ff 45 08             	incl   0x8(%ebp)
  8013ab:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b6:	74 06                	je     8013be <strtol+0x58>
  8013b8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013bc:	75 20                	jne    8013de <strtol+0x78>
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	3c 30                	cmp    $0x30,%al
  8013c5:	75 17                	jne    8013de <strtol+0x78>
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	40                   	inc    %eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	3c 78                	cmp    $0x78,%al
  8013cf:	75 0d                	jne    8013de <strtol+0x78>
		s += 2, base = 16;
  8013d1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013d5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013dc:	eb 28                	jmp    801406 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e2:	75 15                	jne    8013f9 <strtol+0x93>
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	3c 30                	cmp    $0x30,%al
  8013eb:	75 0c                	jne    8013f9 <strtol+0x93>
		s++, base = 8;
  8013ed:	ff 45 08             	incl   0x8(%ebp)
  8013f0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013f7:	eb 0d                	jmp    801406 <strtol+0xa0>
	else if (base == 0)
  8013f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fd:	75 07                	jne    801406 <strtol+0xa0>
		base = 10;
  8013ff:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	3c 2f                	cmp    $0x2f,%al
  80140d:	7e 19                	jle    801428 <strtol+0xc2>
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	3c 39                	cmp    $0x39,%al
  801416:	7f 10                	jg     801428 <strtol+0xc2>
			dig = *s - '0';
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	0f be c0             	movsbl %al,%eax
  801420:	83 e8 30             	sub    $0x30,%eax
  801423:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801426:	eb 42                	jmp    80146a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	3c 60                	cmp    $0x60,%al
  80142f:	7e 19                	jle    80144a <strtol+0xe4>
  801431:	8b 45 08             	mov    0x8(%ebp),%eax
  801434:	8a 00                	mov    (%eax),%al
  801436:	3c 7a                	cmp    $0x7a,%al
  801438:	7f 10                	jg     80144a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	8a 00                	mov    (%eax),%al
  80143f:	0f be c0             	movsbl %al,%eax
  801442:	83 e8 57             	sub    $0x57,%eax
  801445:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801448:	eb 20                	jmp    80146a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	8a 00                	mov    (%eax),%al
  80144f:	3c 40                	cmp    $0x40,%al
  801451:	7e 39                	jle    80148c <strtol+0x126>
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	3c 5a                	cmp    $0x5a,%al
  80145a:	7f 30                	jg     80148c <strtol+0x126>
			dig = *s - 'A' + 10;
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	8a 00                	mov    (%eax),%al
  801461:	0f be c0             	movsbl %al,%eax
  801464:	83 e8 37             	sub    $0x37,%eax
  801467:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80146a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80146d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801470:	7d 19                	jge    80148b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801472:	ff 45 08             	incl   0x8(%ebp)
  801475:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801478:	0f af 45 10          	imul   0x10(%ebp),%eax
  80147c:	89 c2                	mov    %eax,%edx
  80147e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801481:	01 d0                	add    %edx,%eax
  801483:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801486:	e9 7b ff ff ff       	jmp    801406 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80148b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80148c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801490:	74 08                	je     80149a <strtol+0x134>
		*endptr = (char *) s;
  801492:	8b 45 0c             	mov    0xc(%ebp),%eax
  801495:	8b 55 08             	mov    0x8(%ebp),%edx
  801498:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80149a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80149e:	74 07                	je     8014a7 <strtol+0x141>
  8014a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a3:	f7 d8                	neg    %eax
  8014a5:	eb 03                	jmp    8014aa <strtol+0x144>
  8014a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <ltostr>:

void
ltostr(long value, char *str)
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
  8014af:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014c0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014c4:	79 13                	jns    8014d9 <ltostr+0x2d>
	{
		neg = 1;
  8014c6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014d3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014d6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014e1:	99                   	cltd   
  8014e2:	f7 f9                	idiv   %ecx
  8014e4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ea:	8d 50 01             	lea    0x1(%eax),%edx
  8014ed:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014f0:	89 c2                	mov    %eax,%edx
  8014f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f5:	01 d0                	add    %edx,%eax
  8014f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014fa:	83 c2 30             	add    $0x30,%edx
  8014fd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801502:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801507:	f7 e9                	imul   %ecx
  801509:	c1 fa 02             	sar    $0x2,%edx
  80150c:	89 c8                	mov    %ecx,%eax
  80150e:	c1 f8 1f             	sar    $0x1f,%eax
  801511:	29 c2                	sub    %eax,%edx
  801513:	89 d0                	mov    %edx,%eax
  801515:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801518:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80151b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801520:	f7 e9                	imul   %ecx
  801522:	c1 fa 02             	sar    $0x2,%edx
  801525:	89 c8                	mov    %ecx,%eax
  801527:	c1 f8 1f             	sar    $0x1f,%eax
  80152a:	29 c2                	sub    %eax,%edx
  80152c:	89 d0                	mov    %edx,%eax
  80152e:	c1 e0 02             	shl    $0x2,%eax
  801531:	01 d0                	add    %edx,%eax
  801533:	01 c0                	add    %eax,%eax
  801535:	29 c1                	sub    %eax,%ecx
  801537:	89 ca                	mov    %ecx,%edx
  801539:	85 d2                	test   %edx,%edx
  80153b:	75 9c                	jne    8014d9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80153d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801544:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801547:	48                   	dec    %eax
  801548:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80154b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80154f:	74 3d                	je     80158e <ltostr+0xe2>
		start = 1 ;
  801551:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801558:	eb 34                	jmp    80158e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80155a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80155d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801560:	01 d0                	add    %edx,%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801567:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80156a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156d:	01 c2                	add    %eax,%edx
  80156f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	01 c8                	add    %ecx,%eax
  801577:	8a 00                	mov    (%eax),%al
  801579:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80157b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80157e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801581:	01 c2                	add    %eax,%edx
  801583:	8a 45 eb             	mov    -0x15(%ebp),%al
  801586:	88 02                	mov    %al,(%edx)
		start++ ;
  801588:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80158b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80158e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801591:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801594:	7c c4                	jl     80155a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801596:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801599:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159c:	01 d0                	add    %edx,%eax
  80159e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015a1:	90                   	nop
  8015a2:	c9                   	leave  
  8015a3:	c3                   	ret    

008015a4 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
  8015a7:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015aa:	ff 75 08             	pushl  0x8(%ebp)
  8015ad:	e8 54 fa ff ff       	call   801006 <strlen>
  8015b2:	83 c4 04             	add    $0x4,%esp
  8015b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015b8:	ff 75 0c             	pushl  0xc(%ebp)
  8015bb:	e8 46 fa ff ff       	call   801006 <strlen>
  8015c0:	83 c4 04             	add    $0x4,%esp
  8015c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015d4:	eb 17                	jmp    8015ed <strcconcat+0x49>
		final[s] = str1[s] ;
  8015d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015dc:	01 c2                	add    %eax,%edx
  8015de:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	01 c8                	add    %ecx,%eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015ea:	ff 45 fc             	incl   -0x4(%ebp)
  8015ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015f3:	7c e1                	jl     8015d6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015f5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015fc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801603:	eb 1f                	jmp    801624 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801605:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801608:	8d 50 01             	lea    0x1(%eax),%edx
  80160b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80160e:	89 c2                	mov    %eax,%edx
  801610:	8b 45 10             	mov    0x10(%ebp),%eax
  801613:	01 c2                	add    %eax,%edx
  801615:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161b:	01 c8                	add    %ecx,%eax
  80161d:	8a 00                	mov    (%eax),%al
  80161f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801621:	ff 45 f8             	incl   -0x8(%ebp)
  801624:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801627:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80162a:	7c d9                	jl     801605 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80162c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80162f:	8b 45 10             	mov    0x10(%ebp),%eax
  801632:	01 d0                	add    %edx,%eax
  801634:	c6 00 00             	movb   $0x0,(%eax)
}
  801637:	90                   	nop
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80163d:	8b 45 14             	mov    0x14(%ebp),%eax
  801640:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801646:	8b 45 14             	mov    0x14(%ebp),%eax
  801649:	8b 00                	mov    (%eax),%eax
  80164b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	01 d0                	add    %edx,%eax
  801657:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80165d:	eb 0c                	jmp    80166b <strsplit+0x31>
			*string++ = 0;
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8d 50 01             	lea    0x1(%eax),%edx
  801665:	89 55 08             	mov    %edx,0x8(%ebp)
  801668:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	84 c0                	test   %al,%al
  801672:	74 18                	je     80168c <strsplit+0x52>
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	8a 00                	mov    (%eax),%al
  801679:	0f be c0             	movsbl %al,%eax
  80167c:	50                   	push   %eax
  80167d:	ff 75 0c             	pushl  0xc(%ebp)
  801680:	e8 13 fb ff ff       	call   801198 <strchr>
  801685:	83 c4 08             	add    $0x8,%esp
  801688:	85 c0                	test   %eax,%eax
  80168a:	75 d3                	jne    80165f <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	8a 00                	mov    (%eax),%al
  801691:	84 c0                	test   %al,%al
  801693:	74 5a                	je     8016ef <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801695:	8b 45 14             	mov    0x14(%ebp),%eax
  801698:	8b 00                	mov    (%eax),%eax
  80169a:	83 f8 0f             	cmp    $0xf,%eax
  80169d:	75 07                	jne    8016a6 <strsplit+0x6c>
		{
			return 0;
  80169f:	b8 00 00 00 00       	mov    $0x0,%eax
  8016a4:	eb 66                	jmp    80170c <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a9:	8b 00                	mov    (%eax),%eax
  8016ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8016ae:	8b 55 14             	mov    0x14(%ebp),%edx
  8016b1:	89 0a                	mov    %ecx,(%edx)
  8016b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8016bd:	01 c2                	add    %eax,%edx
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016c4:	eb 03                	jmp    8016c9 <strsplit+0x8f>
			string++;
  8016c6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	84 c0                	test   %al,%al
  8016d0:	74 8b                	je     80165d <strsplit+0x23>
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d5:	8a 00                	mov    (%eax),%al
  8016d7:	0f be c0             	movsbl %al,%eax
  8016da:	50                   	push   %eax
  8016db:	ff 75 0c             	pushl  0xc(%ebp)
  8016de:	e8 b5 fa ff ff       	call   801198 <strchr>
  8016e3:	83 c4 08             	add    $0x8,%esp
  8016e6:	85 c0                	test   %eax,%eax
  8016e8:	74 dc                	je     8016c6 <strsplit+0x8c>
			string++;
	}
  8016ea:	e9 6e ff ff ff       	jmp    80165d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016ef:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016f3:	8b 00                	mov    (%eax),%eax
  8016f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ff:	01 d0                	add    %edx,%eax
  801701:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801707:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
  801711:	57                   	push   %edi
  801712:	56                   	push   %esi
  801713:	53                   	push   %ebx
  801714:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80171d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801720:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801723:	8b 7d 18             	mov    0x18(%ebp),%edi
  801726:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801729:	cd 30                	int    $0x30
  80172b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80172e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801731:	83 c4 10             	add    $0x10,%esp
  801734:	5b                   	pop    %ebx
  801735:	5e                   	pop    %esi
  801736:	5f                   	pop    %edi
  801737:	5d                   	pop    %ebp
  801738:	c3                   	ret    

00801739 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
  80173c:	83 ec 04             	sub    $0x4,%esp
  80173f:	8b 45 10             	mov    0x10(%ebp),%eax
  801742:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801745:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	52                   	push   %edx
  801751:	ff 75 0c             	pushl  0xc(%ebp)
  801754:	50                   	push   %eax
  801755:	6a 00                	push   $0x0
  801757:	e8 b2 ff ff ff       	call   80170e <syscall>
  80175c:	83 c4 18             	add    $0x18,%esp
}
  80175f:	90                   	nop
  801760:	c9                   	leave  
  801761:	c3                   	ret    

00801762 <sys_cgetc>:

int
sys_cgetc(void)
{
  801762:	55                   	push   %ebp
  801763:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 01                	push   $0x1
  801771:	e8 98 ff ff ff       	call   80170e <syscall>
  801776:	83 c4 18             	add    $0x18,%esp
}
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	50                   	push   %eax
  80178a:	6a 05                	push   $0x5
  80178c:	e8 7d ff ff ff       	call   80170e <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 02                	push   $0x2
  8017a5:	e8 64 ff ff ff       	call   80170e <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
}
  8017ad:	c9                   	leave  
  8017ae:	c3                   	ret    

008017af <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017af:	55                   	push   %ebp
  8017b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 03                	push   $0x3
  8017be:	e8 4b ff ff ff       	call   80170e <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 04                	push   $0x4
  8017d7:	e8 32 ff ff ff       	call   80170e <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <sys_env_exit>:


void sys_env_exit(void)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 06                	push   $0x6
  8017f0:	e8 19 ff ff ff       	call   80170e <syscall>
  8017f5:	83 c4 18             	add    $0x18,%esp
}
  8017f8:	90                   	nop
  8017f9:	c9                   	leave  
  8017fa:	c3                   	ret    

008017fb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	52                   	push   %edx
  80180b:	50                   	push   %eax
  80180c:	6a 07                	push   $0x7
  80180e:	e8 fb fe ff ff       	call   80170e <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
  80181b:	56                   	push   %esi
  80181c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80181d:	8b 75 18             	mov    0x18(%ebp),%esi
  801820:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801823:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801826:	8b 55 0c             	mov    0xc(%ebp),%edx
  801829:	8b 45 08             	mov    0x8(%ebp),%eax
  80182c:	56                   	push   %esi
  80182d:	53                   	push   %ebx
  80182e:	51                   	push   %ecx
  80182f:	52                   	push   %edx
  801830:	50                   	push   %eax
  801831:	6a 08                	push   $0x8
  801833:	e8 d6 fe ff ff       	call   80170e <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80183e:	5b                   	pop    %ebx
  80183f:	5e                   	pop    %esi
  801840:	5d                   	pop    %ebp
  801841:	c3                   	ret    

00801842 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801845:	8b 55 0c             	mov    0xc(%ebp),%edx
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	52                   	push   %edx
  801852:	50                   	push   %eax
  801853:	6a 09                	push   $0x9
  801855:	e8 b4 fe ff ff       	call   80170e <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
}
  80185d:	c9                   	leave  
  80185e:	c3                   	ret    

0080185f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	ff 75 0c             	pushl  0xc(%ebp)
  80186b:	ff 75 08             	pushl  0x8(%ebp)
  80186e:	6a 0a                	push   $0xa
  801870:	e8 99 fe ff ff       	call   80170e <syscall>
  801875:	83 c4 18             	add    $0x18,%esp
}
  801878:	c9                   	leave  
  801879:	c3                   	ret    

0080187a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80187a:	55                   	push   %ebp
  80187b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 0b                	push   $0xb
  801889:	e8 80 fe ff ff       	call   80170e <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
}
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 0c                	push   $0xc
  8018a2:	e8 67 fe ff ff       	call   80170e <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
}
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 0d                	push   $0xd
  8018bb:	e8 4e fe ff ff       	call   80170e <syscall>
  8018c0:	83 c4 18             	add    $0x18,%esp
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	ff 75 0c             	pushl  0xc(%ebp)
  8018d1:	ff 75 08             	pushl  0x8(%ebp)
  8018d4:	6a 11                	push   $0x11
  8018d6:	e8 33 fe ff ff       	call   80170e <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
	return;
  8018de:	90                   	nop
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	ff 75 0c             	pushl  0xc(%ebp)
  8018ed:	ff 75 08             	pushl  0x8(%ebp)
  8018f0:	6a 12                	push   $0x12
  8018f2:	e8 17 fe ff ff       	call   80170e <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018fa:	90                   	nop
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 0e                	push   $0xe
  80190c:	e8 fd fd ff ff       	call   80170e <syscall>
  801911:	83 c4 18             	add    $0x18,%esp
}
  801914:	c9                   	leave  
  801915:	c3                   	ret    

00801916 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801916:	55                   	push   %ebp
  801917:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	ff 75 08             	pushl  0x8(%ebp)
  801924:	6a 0f                	push   $0xf
  801926:	e8 e3 fd ff ff       	call   80170e <syscall>
  80192b:	83 c4 18             	add    $0x18,%esp
}
  80192e:	c9                   	leave  
  80192f:	c3                   	ret    

00801930 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801930:	55                   	push   %ebp
  801931:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 10                	push   $0x10
  80193f:	e8 ca fd ff ff       	call   80170e <syscall>
  801944:	83 c4 18             	add    $0x18,%esp
}
  801947:	90                   	nop
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 14                	push   $0x14
  801959:	e8 b0 fd ff ff       	call   80170e <syscall>
  80195e:	83 c4 18             	add    $0x18,%esp
}
  801961:	90                   	nop
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 15                	push   $0x15
  801973:	e8 96 fd ff ff       	call   80170e <syscall>
  801978:	83 c4 18             	add    $0x18,%esp
}
  80197b:	90                   	nop
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <sys_cputc>:


void
sys_cputc(const char c)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
  801981:	83 ec 04             	sub    $0x4,%esp
  801984:	8b 45 08             	mov    0x8(%ebp),%eax
  801987:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80198a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	50                   	push   %eax
  801997:	6a 16                	push   $0x16
  801999:	e8 70 fd ff ff       	call   80170e <syscall>
  80199e:	83 c4 18             	add    $0x18,%esp
}
  8019a1:	90                   	nop
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 17                	push   $0x17
  8019b3:	e8 56 fd ff ff       	call   80170e <syscall>
  8019b8:	83 c4 18             	add    $0x18,%esp
}
  8019bb:	90                   	nop
  8019bc:	c9                   	leave  
  8019bd:	c3                   	ret    

008019be <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019be:	55                   	push   %ebp
  8019bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	ff 75 0c             	pushl  0xc(%ebp)
  8019cd:	50                   	push   %eax
  8019ce:	6a 18                	push   $0x18
  8019d0:	e8 39 fd ff ff       	call   80170e <syscall>
  8019d5:	83 c4 18             	add    $0x18,%esp
}
  8019d8:	c9                   	leave  
  8019d9:	c3                   	ret    

008019da <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019da:	55                   	push   %ebp
  8019db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	52                   	push   %edx
  8019ea:	50                   	push   %eax
  8019eb:	6a 1b                	push   $0x1b
  8019ed:	e8 1c fd ff ff       	call   80170e <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
}
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	52                   	push   %edx
  801a07:	50                   	push   %eax
  801a08:	6a 19                	push   $0x19
  801a0a:	e8 ff fc ff ff       	call   80170e <syscall>
  801a0f:	83 c4 18             	add    $0x18,%esp
}
  801a12:	90                   	nop
  801a13:	c9                   	leave  
  801a14:	c3                   	ret    

00801a15 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a15:	55                   	push   %ebp
  801a16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	52                   	push   %edx
  801a25:	50                   	push   %eax
  801a26:	6a 1a                	push   $0x1a
  801a28:	e8 e1 fc ff ff       	call   80170e <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	90                   	nop
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
  801a36:	83 ec 04             	sub    $0x4,%esp
  801a39:	8b 45 10             	mov    0x10(%ebp),%eax
  801a3c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a3f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a42:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a46:	8b 45 08             	mov    0x8(%ebp),%eax
  801a49:	6a 00                	push   $0x0
  801a4b:	51                   	push   %ecx
  801a4c:	52                   	push   %edx
  801a4d:	ff 75 0c             	pushl  0xc(%ebp)
  801a50:	50                   	push   %eax
  801a51:	6a 1c                	push   $0x1c
  801a53:	e8 b6 fc ff ff       	call   80170e <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
}
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	52                   	push   %edx
  801a6d:	50                   	push   %eax
  801a6e:	6a 1d                	push   $0x1d
  801a70:	e8 99 fc ff ff       	call   80170e <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
}
  801a78:	c9                   	leave  
  801a79:	c3                   	ret    

00801a7a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a7d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a80:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	51                   	push   %ecx
  801a8b:	52                   	push   %edx
  801a8c:	50                   	push   %eax
  801a8d:	6a 1e                	push   $0x1e
  801a8f:	e8 7a fc ff ff       	call   80170e <syscall>
  801a94:	83 c4 18             	add    $0x18,%esp
}
  801a97:	c9                   	leave  
  801a98:	c3                   	ret    

00801a99 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a99:	55                   	push   %ebp
  801a9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	52                   	push   %edx
  801aa9:	50                   	push   %eax
  801aaa:	6a 1f                	push   $0x1f
  801aac:	e8 5d fc ff ff       	call   80170e <syscall>
  801ab1:	83 c4 18             	add    $0x18,%esp
}
  801ab4:	c9                   	leave  
  801ab5:	c3                   	ret    

00801ab6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ab6:	55                   	push   %ebp
  801ab7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 20                	push   $0x20
  801ac5:	e8 44 fc ff ff       	call   80170e <syscall>
  801aca:	83 c4 18             	add    $0x18,%esp
}
  801acd:	c9                   	leave  
  801ace:	c3                   	ret    

00801acf <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801acf:	55                   	push   %ebp
  801ad0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	ff 75 10             	pushl  0x10(%ebp)
  801adc:	ff 75 0c             	pushl  0xc(%ebp)
  801adf:	50                   	push   %eax
  801ae0:	6a 21                	push   $0x21
  801ae2:	e8 27 fc ff ff       	call   80170e <syscall>
  801ae7:	83 c4 18             	add    $0x18,%esp
}
  801aea:	c9                   	leave  
  801aeb:	c3                   	ret    

00801aec <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801aec:	55                   	push   %ebp
  801aed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801aef:	8b 45 08             	mov    0x8(%ebp),%eax
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	50                   	push   %eax
  801afb:	6a 22                	push   $0x22
  801afd:	e8 0c fc ff ff       	call   80170e <syscall>
  801b02:	83 c4 18             	add    $0x18,%esp
}
  801b05:	90                   	nop
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	50                   	push   %eax
  801b17:	6a 23                	push   $0x23
  801b19:	e8 f0 fb ff ff       	call   80170e <syscall>
  801b1e:	83 c4 18             	add    $0x18,%esp
}
  801b21:	90                   	nop
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
  801b27:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b2a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b2d:	8d 50 04             	lea    0x4(%eax),%edx
  801b30:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	52                   	push   %edx
  801b3a:	50                   	push   %eax
  801b3b:	6a 24                	push   $0x24
  801b3d:	e8 cc fb ff ff       	call   80170e <syscall>
  801b42:	83 c4 18             	add    $0x18,%esp
	return result;
  801b45:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b4e:	89 01                	mov    %eax,(%ecx)
  801b50:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b53:	8b 45 08             	mov    0x8(%ebp),%eax
  801b56:	c9                   	leave  
  801b57:	c2 04 00             	ret    $0x4

00801b5a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	ff 75 10             	pushl  0x10(%ebp)
  801b64:	ff 75 0c             	pushl  0xc(%ebp)
  801b67:	ff 75 08             	pushl  0x8(%ebp)
  801b6a:	6a 13                	push   $0x13
  801b6c:	e8 9d fb ff ff       	call   80170e <syscall>
  801b71:	83 c4 18             	add    $0x18,%esp
	return ;
  801b74:	90                   	nop
}
  801b75:	c9                   	leave  
  801b76:	c3                   	ret    

00801b77 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 25                	push   $0x25
  801b86:	e8 83 fb ff ff       	call   80170e <syscall>
  801b8b:	83 c4 18             	add    $0x18,%esp
}
  801b8e:	c9                   	leave  
  801b8f:	c3                   	ret    

00801b90 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b90:	55                   	push   %ebp
  801b91:	89 e5                	mov    %esp,%ebp
  801b93:	83 ec 04             	sub    $0x4,%esp
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b9c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	50                   	push   %eax
  801ba9:	6a 26                	push   $0x26
  801bab:	e8 5e fb ff ff       	call   80170e <syscall>
  801bb0:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb3:	90                   	nop
}
  801bb4:	c9                   	leave  
  801bb5:	c3                   	ret    

00801bb6 <rsttst>:
void rsttst()
{
  801bb6:	55                   	push   %ebp
  801bb7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 28                	push   $0x28
  801bc5:	e8 44 fb ff ff       	call   80170e <syscall>
  801bca:	83 c4 18             	add    $0x18,%esp
	return ;
  801bcd:	90                   	nop
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	83 ec 04             	sub    $0x4,%esp
  801bd6:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bdc:	8b 55 18             	mov    0x18(%ebp),%edx
  801bdf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801be3:	52                   	push   %edx
  801be4:	50                   	push   %eax
  801be5:	ff 75 10             	pushl  0x10(%ebp)
  801be8:	ff 75 0c             	pushl  0xc(%ebp)
  801beb:	ff 75 08             	pushl  0x8(%ebp)
  801bee:	6a 27                	push   $0x27
  801bf0:	e8 19 fb ff ff       	call   80170e <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf8:	90                   	nop
}
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    

00801bfb <chktst>:
void chktst(uint32 n)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	ff 75 08             	pushl  0x8(%ebp)
  801c09:	6a 29                	push   $0x29
  801c0b:	e8 fe fa ff ff       	call   80170e <syscall>
  801c10:	83 c4 18             	add    $0x18,%esp
	return ;
  801c13:	90                   	nop
}
  801c14:	c9                   	leave  
  801c15:	c3                   	ret    

00801c16 <inctst>:

void inctst()
{
  801c16:	55                   	push   %ebp
  801c17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 2a                	push   $0x2a
  801c25:	e8 e4 fa ff ff       	call   80170e <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c2d:	90                   	nop
}
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <gettst>:
uint32 gettst()
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 2b                	push   $0x2b
  801c3f:	e8 ca fa ff ff       	call   80170e <syscall>
  801c44:	83 c4 18             	add    $0x18,%esp
}
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
  801c4c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 2c                	push   $0x2c
  801c5b:	e8 ae fa ff ff       	call   80170e <syscall>
  801c60:	83 c4 18             	add    $0x18,%esp
  801c63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c66:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c6a:	75 07                	jne    801c73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c6c:	b8 01 00 00 00       	mov    $0x1,%eax
  801c71:	eb 05                	jmp    801c78 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c73:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
  801c7d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 2c                	push   $0x2c
  801c8c:	e8 7d fa ff ff       	call   80170e <syscall>
  801c91:	83 c4 18             	add    $0x18,%esp
  801c94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c97:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c9b:	75 07                	jne    801ca4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c9d:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca2:	eb 05                	jmp    801ca9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ca4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca9:	c9                   	leave  
  801caa:	c3                   	ret    

00801cab <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 2c                	push   $0x2c
  801cbd:	e8 4c fa ff ff       	call   80170e <syscall>
  801cc2:	83 c4 18             	add    $0x18,%esp
  801cc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cc8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ccc:	75 07                	jne    801cd5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cce:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd3:	eb 05                	jmp    801cda <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cdc:	55                   	push   %ebp
  801cdd:	89 e5                	mov    %esp,%ebp
  801cdf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 2c                	push   $0x2c
  801cee:	e8 1b fa ff ff       	call   80170e <syscall>
  801cf3:	83 c4 18             	add    $0x18,%esp
  801cf6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cf9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cfd:	75 07                	jne    801d06 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cff:	b8 01 00 00 00       	mov    $0x1,%eax
  801d04:	eb 05                	jmp    801d0b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d0b:	c9                   	leave  
  801d0c:	c3                   	ret    

00801d0d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d0d:	55                   	push   %ebp
  801d0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	ff 75 08             	pushl  0x8(%ebp)
  801d1b:	6a 2d                	push   $0x2d
  801d1d:	e8 ec f9 ff ff       	call   80170e <syscall>
  801d22:	83 c4 18             	add    $0x18,%esp
	return ;
  801d25:	90                   	nop
}
  801d26:	c9                   	leave  
  801d27:	c3                   	ret    

00801d28 <__udivdi3>:
  801d28:	55                   	push   %ebp
  801d29:	57                   	push   %edi
  801d2a:	56                   	push   %esi
  801d2b:	53                   	push   %ebx
  801d2c:	83 ec 1c             	sub    $0x1c,%esp
  801d2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d3f:	89 ca                	mov    %ecx,%edx
  801d41:	89 f8                	mov    %edi,%eax
  801d43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d47:	85 f6                	test   %esi,%esi
  801d49:	75 2d                	jne    801d78 <__udivdi3+0x50>
  801d4b:	39 cf                	cmp    %ecx,%edi
  801d4d:	77 65                	ja     801db4 <__udivdi3+0x8c>
  801d4f:	89 fd                	mov    %edi,%ebp
  801d51:	85 ff                	test   %edi,%edi
  801d53:	75 0b                	jne    801d60 <__udivdi3+0x38>
  801d55:	b8 01 00 00 00       	mov    $0x1,%eax
  801d5a:	31 d2                	xor    %edx,%edx
  801d5c:	f7 f7                	div    %edi
  801d5e:	89 c5                	mov    %eax,%ebp
  801d60:	31 d2                	xor    %edx,%edx
  801d62:	89 c8                	mov    %ecx,%eax
  801d64:	f7 f5                	div    %ebp
  801d66:	89 c1                	mov    %eax,%ecx
  801d68:	89 d8                	mov    %ebx,%eax
  801d6a:	f7 f5                	div    %ebp
  801d6c:	89 cf                	mov    %ecx,%edi
  801d6e:	89 fa                	mov    %edi,%edx
  801d70:	83 c4 1c             	add    $0x1c,%esp
  801d73:	5b                   	pop    %ebx
  801d74:	5e                   	pop    %esi
  801d75:	5f                   	pop    %edi
  801d76:	5d                   	pop    %ebp
  801d77:	c3                   	ret    
  801d78:	39 ce                	cmp    %ecx,%esi
  801d7a:	77 28                	ja     801da4 <__udivdi3+0x7c>
  801d7c:	0f bd fe             	bsr    %esi,%edi
  801d7f:	83 f7 1f             	xor    $0x1f,%edi
  801d82:	75 40                	jne    801dc4 <__udivdi3+0x9c>
  801d84:	39 ce                	cmp    %ecx,%esi
  801d86:	72 0a                	jb     801d92 <__udivdi3+0x6a>
  801d88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d8c:	0f 87 9e 00 00 00    	ja     801e30 <__udivdi3+0x108>
  801d92:	b8 01 00 00 00       	mov    $0x1,%eax
  801d97:	89 fa                	mov    %edi,%edx
  801d99:	83 c4 1c             	add    $0x1c,%esp
  801d9c:	5b                   	pop    %ebx
  801d9d:	5e                   	pop    %esi
  801d9e:	5f                   	pop    %edi
  801d9f:	5d                   	pop    %ebp
  801da0:	c3                   	ret    
  801da1:	8d 76 00             	lea    0x0(%esi),%esi
  801da4:	31 ff                	xor    %edi,%edi
  801da6:	31 c0                	xor    %eax,%eax
  801da8:	89 fa                	mov    %edi,%edx
  801daa:	83 c4 1c             	add    $0x1c,%esp
  801dad:	5b                   	pop    %ebx
  801dae:	5e                   	pop    %esi
  801daf:	5f                   	pop    %edi
  801db0:	5d                   	pop    %ebp
  801db1:	c3                   	ret    
  801db2:	66 90                	xchg   %ax,%ax
  801db4:	89 d8                	mov    %ebx,%eax
  801db6:	f7 f7                	div    %edi
  801db8:	31 ff                	xor    %edi,%edi
  801dba:	89 fa                	mov    %edi,%edx
  801dbc:	83 c4 1c             	add    $0x1c,%esp
  801dbf:	5b                   	pop    %ebx
  801dc0:	5e                   	pop    %esi
  801dc1:	5f                   	pop    %edi
  801dc2:	5d                   	pop    %ebp
  801dc3:	c3                   	ret    
  801dc4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dc9:	89 eb                	mov    %ebp,%ebx
  801dcb:	29 fb                	sub    %edi,%ebx
  801dcd:	89 f9                	mov    %edi,%ecx
  801dcf:	d3 e6                	shl    %cl,%esi
  801dd1:	89 c5                	mov    %eax,%ebp
  801dd3:	88 d9                	mov    %bl,%cl
  801dd5:	d3 ed                	shr    %cl,%ebp
  801dd7:	89 e9                	mov    %ebp,%ecx
  801dd9:	09 f1                	or     %esi,%ecx
  801ddb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ddf:	89 f9                	mov    %edi,%ecx
  801de1:	d3 e0                	shl    %cl,%eax
  801de3:	89 c5                	mov    %eax,%ebp
  801de5:	89 d6                	mov    %edx,%esi
  801de7:	88 d9                	mov    %bl,%cl
  801de9:	d3 ee                	shr    %cl,%esi
  801deb:	89 f9                	mov    %edi,%ecx
  801ded:	d3 e2                	shl    %cl,%edx
  801def:	8b 44 24 08          	mov    0x8(%esp),%eax
  801df3:	88 d9                	mov    %bl,%cl
  801df5:	d3 e8                	shr    %cl,%eax
  801df7:	09 c2                	or     %eax,%edx
  801df9:	89 d0                	mov    %edx,%eax
  801dfb:	89 f2                	mov    %esi,%edx
  801dfd:	f7 74 24 0c          	divl   0xc(%esp)
  801e01:	89 d6                	mov    %edx,%esi
  801e03:	89 c3                	mov    %eax,%ebx
  801e05:	f7 e5                	mul    %ebp
  801e07:	39 d6                	cmp    %edx,%esi
  801e09:	72 19                	jb     801e24 <__udivdi3+0xfc>
  801e0b:	74 0b                	je     801e18 <__udivdi3+0xf0>
  801e0d:	89 d8                	mov    %ebx,%eax
  801e0f:	31 ff                	xor    %edi,%edi
  801e11:	e9 58 ff ff ff       	jmp    801d6e <__udivdi3+0x46>
  801e16:	66 90                	xchg   %ax,%ax
  801e18:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e1c:	89 f9                	mov    %edi,%ecx
  801e1e:	d3 e2                	shl    %cl,%edx
  801e20:	39 c2                	cmp    %eax,%edx
  801e22:	73 e9                	jae    801e0d <__udivdi3+0xe5>
  801e24:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e27:	31 ff                	xor    %edi,%edi
  801e29:	e9 40 ff ff ff       	jmp    801d6e <__udivdi3+0x46>
  801e2e:	66 90                	xchg   %ax,%ax
  801e30:	31 c0                	xor    %eax,%eax
  801e32:	e9 37 ff ff ff       	jmp    801d6e <__udivdi3+0x46>
  801e37:	90                   	nop

00801e38 <__umoddi3>:
  801e38:	55                   	push   %ebp
  801e39:	57                   	push   %edi
  801e3a:	56                   	push   %esi
  801e3b:	53                   	push   %ebx
  801e3c:	83 ec 1c             	sub    $0x1c,%esp
  801e3f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e43:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e4b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e53:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e57:	89 f3                	mov    %esi,%ebx
  801e59:	89 fa                	mov    %edi,%edx
  801e5b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e5f:	89 34 24             	mov    %esi,(%esp)
  801e62:	85 c0                	test   %eax,%eax
  801e64:	75 1a                	jne    801e80 <__umoddi3+0x48>
  801e66:	39 f7                	cmp    %esi,%edi
  801e68:	0f 86 a2 00 00 00    	jbe    801f10 <__umoddi3+0xd8>
  801e6e:	89 c8                	mov    %ecx,%eax
  801e70:	89 f2                	mov    %esi,%edx
  801e72:	f7 f7                	div    %edi
  801e74:	89 d0                	mov    %edx,%eax
  801e76:	31 d2                	xor    %edx,%edx
  801e78:	83 c4 1c             	add    $0x1c,%esp
  801e7b:	5b                   	pop    %ebx
  801e7c:	5e                   	pop    %esi
  801e7d:	5f                   	pop    %edi
  801e7e:	5d                   	pop    %ebp
  801e7f:	c3                   	ret    
  801e80:	39 f0                	cmp    %esi,%eax
  801e82:	0f 87 ac 00 00 00    	ja     801f34 <__umoddi3+0xfc>
  801e88:	0f bd e8             	bsr    %eax,%ebp
  801e8b:	83 f5 1f             	xor    $0x1f,%ebp
  801e8e:	0f 84 ac 00 00 00    	je     801f40 <__umoddi3+0x108>
  801e94:	bf 20 00 00 00       	mov    $0x20,%edi
  801e99:	29 ef                	sub    %ebp,%edi
  801e9b:	89 fe                	mov    %edi,%esi
  801e9d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ea1:	89 e9                	mov    %ebp,%ecx
  801ea3:	d3 e0                	shl    %cl,%eax
  801ea5:	89 d7                	mov    %edx,%edi
  801ea7:	89 f1                	mov    %esi,%ecx
  801ea9:	d3 ef                	shr    %cl,%edi
  801eab:	09 c7                	or     %eax,%edi
  801ead:	89 e9                	mov    %ebp,%ecx
  801eaf:	d3 e2                	shl    %cl,%edx
  801eb1:	89 14 24             	mov    %edx,(%esp)
  801eb4:	89 d8                	mov    %ebx,%eax
  801eb6:	d3 e0                	shl    %cl,%eax
  801eb8:	89 c2                	mov    %eax,%edx
  801eba:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ebe:	d3 e0                	shl    %cl,%eax
  801ec0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ec4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec8:	89 f1                	mov    %esi,%ecx
  801eca:	d3 e8                	shr    %cl,%eax
  801ecc:	09 d0                	or     %edx,%eax
  801ece:	d3 eb                	shr    %cl,%ebx
  801ed0:	89 da                	mov    %ebx,%edx
  801ed2:	f7 f7                	div    %edi
  801ed4:	89 d3                	mov    %edx,%ebx
  801ed6:	f7 24 24             	mull   (%esp)
  801ed9:	89 c6                	mov    %eax,%esi
  801edb:	89 d1                	mov    %edx,%ecx
  801edd:	39 d3                	cmp    %edx,%ebx
  801edf:	0f 82 87 00 00 00    	jb     801f6c <__umoddi3+0x134>
  801ee5:	0f 84 91 00 00 00    	je     801f7c <__umoddi3+0x144>
  801eeb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eef:	29 f2                	sub    %esi,%edx
  801ef1:	19 cb                	sbb    %ecx,%ebx
  801ef3:	89 d8                	mov    %ebx,%eax
  801ef5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ef9:	d3 e0                	shl    %cl,%eax
  801efb:	89 e9                	mov    %ebp,%ecx
  801efd:	d3 ea                	shr    %cl,%edx
  801eff:	09 d0                	or     %edx,%eax
  801f01:	89 e9                	mov    %ebp,%ecx
  801f03:	d3 eb                	shr    %cl,%ebx
  801f05:	89 da                	mov    %ebx,%edx
  801f07:	83 c4 1c             	add    $0x1c,%esp
  801f0a:	5b                   	pop    %ebx
  801f0b:	5e                   	pop    %esi
  801f0c:	5f                   	pop    %edi
  801f0d:	5d                   	pop    %ebp
  801f0e:	c3                   	ret    
  801f0f:	90                   	nop
  801f10:	89 fd                	mov    %edi,%ebp
  801f12:	85 ff                	test   %edi,%edi
  801f14:	75 0b                	jne    801f21 <__umoddi3+0xe9>
  801f16:	b8 01 00 00 00       	mov    $0x1,%eax
  801f1b:	31 d2                	xor    %edx,%edx
  801f1d:	f7 f7                	div    %edi
  801f1f:	89 c5                	mov    %eax,%ebp
  801f21:	89 f0                	mov    %esi,%eax
  801f23:	31 d2                	xor    %edx,%edx
  801f25:	f7 f5                	div    %ebp
  801f27:	89 c8                	mov    %ecx,%eax
  801f29:	f7 f5                	div    %ebp
  801f2b:	89 d0                	mov    %edx,%eax
  801f2d:	e9 44 ff ff ff       	jmp    801e76 <__umoddi3+0x3e>
  801f32:	66 90                	xchg   %ax,%ax
  801f34:	89 c8                	mov    %ecx,%eax
  801f36:	89 f2                	mov    %esi,%edx
  801f38:	83 c4 1c             	add    $0x1c,%esp
  801f3b:	5b                   	pop    %ebx
  801f3c:	5e                   	pop    %esi
  801f3d:	5f                   	pop    %edi
  801f3e:	5d                   	pop    %ebp
  801f3f:	c3                   	ret    
  801f40:	3b 04 24             	cmp    (%esp),%eax
  801f43:	72 06                	jb     801f4b <__umoddi3+0x113>
  801f45:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f49:	77 0f                	ja     801f5a <__umoddi3+0x122>
  801f4b:	89 f2                	mov    %esi,%edx
  801f4d:	29 f9                	sub    %edi,%ecx
  801f4f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f53:	89 14 24             	mov    %edx,(%esp)
  801f56:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f5a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f5e:	8b 14 24             	mov    (%esp),%edx
  801f61:	83 c4 1c             	add    $0x1c,%esp
  801f64:	5b                   	pop    %ebx
  801f65:	5e                   	pop    %esi
  801f66:	5f                   	pop    %edi
  801f67:	5d                   	pop    %ebp
  801f68:	c3                   	ret    
  801f69:	8d 76 00             	lea    0x0(%esi),%esi
  801f6c:	2b 04 24             	sub    (%esp),%eax
  801f6f:	19 fa                	sbb    %edi,%edx
  801f71:	89 d1                	mov    %edx,%ecx
  801f73:	89 c6                	mov    %eax,%esi
  801f75:	e9 71 ff ff ff       	jmp    801eeb <__umoddi3+0xb3>
  801f7a:	66 90                	xchg   %ax,%ax
  801f7c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f80:	72 ea                	jb     801f6c <__umoddi3+0x134>
  801f82:	89 d9                	mov    %ebx,%ecx
  801f84:	e9 62 ff ff ff       	jmp    801eeb <__umoddi3+0xb3>
