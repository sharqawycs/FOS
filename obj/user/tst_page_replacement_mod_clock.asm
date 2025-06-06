
obj/user/tst_page_replacement_mod_clock:     file format elf32-i386


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
  800031:	e8 59 05 00 00       	call   80058f <libmain>
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
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 60 1f 80 00       	push   $0x801f60
  800065:	6a 15                	push   $0x15
  800067:	68 a4 1f 80 00       	push   $0x801fa4
  80006c:	e8 20 06 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007c:	83 c0 0c             	add    $0xc,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800084:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 60 1f 80 00       	push   $0x801f60
  80009b:	6a 16                	push   $0x16
  80009d:	68 a4 1f 80 00       	push   $0x801fa4
  8000a2:	e8 ea 05 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b2:	83 c0 18             	add    $0x18,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 60 1f 80 00       	push   $0x801f60
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 a4 1f 80 00       	push   $0x801fa4
  8000d8:	e8 b4 05 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e8:	83 c0 24             	add    $0x24,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 60 1f 80 00       	push   $0x801f60
  800107:	6a 18                	push   $0x18
  800109:	68 a4 1f 80 00       	push   $0x801fa4
  80010e:	e8 7e 05 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800126:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 60 1f 80 00       	push   $0x801f60
  80013d:	6a 19                	push   $0x19
  80013f:	68 a4 1f 80 00       	push   $0x801fa4
  800144:	e8 48 05 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800154:	83 c0 3c             	add    $0x3c,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 60 1f 80 00       	push   $0x801f60
  800173:	6a 1a                	push   $0x1a
  800175:	68 a4 1f 80 00       	push   $0x801fa4
  80017a:	e8 12 05 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018a:	83 c0 48             	add    $0x48,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800192:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 60 1f 80 00       	push   $0x801f60
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 a4 1f 80 00       	push   $0x801fa4
  8001b0:	e8 dc 04 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c0:	83 c0 54             	add    $0x54,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 60 1f 80 00       	push   $0x801f60
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 a4 1f 80 00       	push   $0x801fa4
  8001e6:	e8 a6 04 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 60 1f 80 00       	push   $0x801f60
  800215:	6a 1d                	push   $0x1d
  800217:	68 a4 1f 80 00       	push   $0x801fa4
  80021c:	e8 70 04 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022c:	83 c0 6c             	add    $0x6c,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800234:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 60 1f 80 00       	push   $0x801f60
  80024b:	6a 1e                	push   $0x1e
  80024d:	68 a4 1f 80 00       	push   $0x801fa4
  800252:	e8 3a 04 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800262:	83 c0 78             	add    $0x78,%eax
  800265:	8b 00                	mov    (%eax),%eax
  800267:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800272:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800277:	74 14                	je     80028d <_main+0x255>
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	68 60 1f 80 00       	push   $0x801f60
  800281:	6a 1f                	push   $0x1f
  800283:	68 a4 1f 80 00       	push   $0x801fa4
  800288:	e8 04 04 00 00       	call   800691 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028d:	a1 20 30 80 00       	mov    0x803020,%eax
  800292:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800298:	85 c0                	test   %eax,%eax
  80029a:	74 14                	je     8002b0 <_main+0x278>
  80029c:	83 ec 04             	sub    $0x4,%esp
  80029f:	68 cc 1f 80 00       	push   $0x801fcc
  8002a4:	6a 20                	push   $0x20
  8002a6:	68 a4 1f 80 00       	push   $0x801fa4
  8002ab:	e8 e1 03 00 00       	call   800691 <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002b0:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002b5:	88 45 c7             	mov    %al,-0x39(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002b8:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002bd:	88 45 c6             	mov    %al,-0x3a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002c7:	eb 37                	jmp    800300 <_main+0x2c8>
	{
		arr[i] = -1 ;
  8002c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002cc:	05 40 30 80 00       	add    $0x803040,%eax
  8002d1:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d9:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002df:	8a 12                	mov    (%edx),%dl
  8002e1:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002e3:	a1 00 30 80 00       	mov    0x803000,%eax
  8002e8:	40                   	inc    %eax
  8002e9:	a3 00 30 80 00       	mov    %eax,0x803000
  8002ee:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f3:	40                   	inc    %eax
  8002f4:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002f9:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800300:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  800307:	7e c0                	jle    8002c9 <_main+0x291>
		ptr++ ; ptr2++ ;
	}

	//===================
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x809000)  panic("modified clock algo failed");
  800309:	a1 20 30 80 00       	mov    0x803020,%eax
  80030e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800314:	8b 00                	mov    (%eax),%eax
  800316:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800319:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80031c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800321:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800326:	74 14                	je     80033c <_main+0x304>
  800328:	83 ec 04             	sub    $0x4,%esp
  80032b:	68 12 20 80 00       	push   $0x802012
  800330:	6a 36                	push   $0x36
  800332:	68 a4 1f 80 00       	push   $0x801fa4
  800337:	e8 55 03 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("modified clock algo failed");
  80033c:	a1 20 30 80 00       	mov    0x803020,%eax
  800341:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800347:	83 c0 0c             	add    $0xc,%eax
  80034a:	8b 00                	mov    (%eax),%eax
  80034c:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80034f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800352:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800357:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  80035c:	74 14                	je     800372 <_main+0x33a>
  80035e:	83 ec 04             	sub    $0x4,%esp
  800361:	68 12 20 80 00       	push   $0x802012
  800366:	6a 37                	push   $0x37
  800368:	68 a4 1f 80 00       	push   $0x801fa4
  80036d:	e8 1f 03 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x804000)  panic("modified clock algo failed");
  800372:	a1 20 30 80 00       	mov    0x803020,%eax
  800377:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80037d:	83 c0 18             	add    $0x18,%eax
  800380:	8b 00                	mov    (%eax),%eax
  800382:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800385:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800388:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80038d:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800392:	74 14                	je     8003a8 <_main+0x370>
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 12 20 80 00       	push   $0x802012
  80039c:	6a 38                	push   $0x38
  80039e:	68 a4 1f 80 00       	push   $0x801fa4
  8003a3:	e8 e9 02 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("modified clock algo failed");
  8003a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ad:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003b3:	83 c0 24             	add    $0x24,%eax
  8003b6:	8b 00                	mov    (%eax),%eax
  8003b8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8003bb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8003be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c3:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8003c8:	74 14                	je     8003de <_main+0x3a6>
  8003ca:	83 ec 04             	sub    $0x4,%esp
  8003cd:	68 12 20 80 00       	push   $0x802012
  8003d2:	6a 39                	push   $0x39
  8003d4:	68 a4 1f 80 00       	push   $0x801fa4
  8003d9:	e8 b3 02 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("modified clock algo failed");
  8003de:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003e9:	83 c0 30             	add    $0x30,%eax
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8003f1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f9:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  8003fe:	74 14                	je     800414 <_main+0x3dc>
  800400:	83 ec 04             	sub    $0x4,%esp
  800403:	68 12 20 80 00       	push   $0x802012
  800408:	6a 3a                	push   $0x3a
  80040a:	68 a4 1f 80 00       	push   $0x801fa4
  80040f:	e8 7d 02 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("modified clock algo failed");
  800414:	a1 20 30 80 00       	mov    0x803020,%eax
  800419:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80041f:	83 c0 3c             	add    $0x3c,%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800427:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80042a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80042f:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800434:	74 14                	je     80044a <_main+0x412>
  800436:	83 ec 04             	sub    $0x4,%esp
  800439:	68 12 20 80 00       	push   $0x802012
  80043e:	6a 3b                	push   $0x3b
  800440:	68 a4 1f 80 00       	push   $0x801fa4
  800445:	e8 47 02 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("modified clock algo failed");
  80044a:	a1 20 30 80 00       	mov    0x803020,%eax
  80044f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800455:	83 c0 48             	add    $0x48,%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80045d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800460:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800465:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80046a:	74 14                	je     800480 <_main+0x448>
  80046c:	83 ec 04             	sub    $0x4,%esp
  80046f:	68 12 20 80 00       	push   $0x802012
  800474:	6a 3c                	push   $0x3c
  800476:	68 a4 1f 80 00       	push   $0x801fa4
  80047b:	e8 11 02 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("modified clock algo failed");
  800480:	a1 20 30 80 00       	mov    0x803020,%eax
  800485:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80048b:	83 c0 54             	add    $0x54,%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800493:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800496:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80049b:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004a0:	74 14                	je     8004b6 <_main+0x47e>
  8004a2:	83 ec 04             	sub    $0x4,%esp
  8004a5:	68 12 20 80 00       	push   $0x802012
  8004aa:	6a 3d                	push   $0x3d
  8004ac:	68 a4 1f 80 00       	push   $0x801fa4
  8004b1:	e8 db 01 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x808000)  panic("modified clock algo failed");
  8004b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004c1:	83 c0 60             	add    $0x60,%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8004c9:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d1:	3d 00 80 80 00       	cmp    $0x808000,%eax
  8004d6:	74 14                	je     8004ec <_main+0x4b4>
  8004d8:	83 ec 04             	sub    $0x4,%esp
  8004db:	68 12 20 80 00       	push   $0x802012
  8004e0:	6a 3e                	push   $0x3e
  8004e2:	68 a4 1f 80 00       	push   $0x801fa4
  8004e7:	e8 a5 01 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("modified clock algo failed");
  8004ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004f7:	83 c0 6c             	add    $0x6c,%eax
  8004fa:	8b 00                	mov    (%eax),%eax
  8004fc:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8004ff:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800502:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800507:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80050c:	74 14                	je     800522 <_main+0x4ea>
  80050e:	83 ec 04             	sub    $0x4,%esp
  800511:	68 12 20 80 00       	push   $0x802012
  800516:	6a 3f                	push   $0x3f
  800518:	68 a4 1f 80 00       	push   $0x801fa4
  80051d:	e8 6f 01 00 00       	call   800691 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("modified clock algo failed");
  800522:	a1 20 30 80 00       	mov    0x803020,%eax
  800527:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80052d:	83 c0 78             	add    $0x78,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	89 45 98             	mov    %eax,-0x68(%ebp)
  800535:	8b 45 98             	mov    -0x68(%ebp),%eax
  800538:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053d:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800542:	74 14                	je     800558 <_main+0x520>
  800544:	83 ec 04             	sub    $0x4,%esp
  800547:	68 12 20 80 00       	push   $0x802012
  80054c:	6a 40                	push   $0x40
  80054e:	68 a4 1f 80 00       	push   $0x801fa4
  800553:	e8 39 01 00 00       	call   800691 <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  800558:	a1 20 30 80 00       	mov    0x803020,%eax
  80055d:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800563:	83 f8 05             	cmp    $0x5,%eax
  800566:	74 14                	je     80057c <_main+0x544>
  800568:	83 ec 04             	sub    $0x4,%esp
  80056b:	68 30 20 80 00       	push   $0x802030
  800570:	6a 42                	push   $0x42
  800572:	68 a4 1f 80 00       	push   $0x801fa4
  800577:	e8 15 01 00 00       	call   800691 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [Modified CLOCK Alg.] is completed successfully.\n");
  80057c:	83 ec 0c             	sub    $0xc,%esp
  80057f:	68 50 20 80 00       	push   $0x802050
  800584:	e8 bc 03 00 00       	call   800945 <cprintf>
  800589:	83 c4 10             	add    $0x10,%esp
	return;
  80058c:	90                   	nop
}
  80058d:	c9                   	leave  
  80058e:	c3                   	ret    

0080058f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80058f:	55                   	push   %ebp
  800590:	89 e5                	mov    %esp,%ebp
  800592:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800595:	e8 d6 11 00 00       	call   801770 <sys_getenvindex>
  80059a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80059d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005a0:	89 d0                	mov    %edx,%eax
  8005a2:	01 c0                	add    %eax,%eax
  8005a4:	01 d0                	add    %edx,%eax
  8005a6:	c1 e0 02             	shl    $0x2,%eax
  8005a9:	01 d0                	add    %edx,%eax
  8005ab:	c1 e0 06             	shl    $0x6,%eax
  8005ae:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005b3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005bd:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8005c3:	84 c0                	test   %al,%al
  8005c5:	74 0f                	je     8005d6 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8005c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005cc:	05 f4 02 00 00       	add    $0x2f4,%eax
  8005d1:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005da:	7e 0a                	jle    8005e6 <libmain+0x57>
		binaryname = argv[0];
  8005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005df:	8b 00                	mov    (%eax),%eax
  8005e1:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8005e6:	83 ec 08             	sub    $0x8,%esp
  8005e9:	ff 75 0c             	pushl  0xc(%ebp)
  8005ec:	ff 75 08             	pushl  0x8(%ebp)
  8005ef:	e8 44 fa ff ff       	call   800038 <_main>
  8005f4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005f7:	e8 0f 13 00 00       	call   80190b <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005fc:	83 ec 0c             	sub    $0xc,%esp
  8005ff:	68 c4 20 80 00       	push   $0x8020c4
  800604:	e8 3c 03 00 00       	call   800945 <cprintf>
  800609:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80060c:	a1 20 30 80 00       	mov    0x803020,%eax
  800611:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800617:	a1 20 30 80 00       	mov    0x803020,%eax
  80061c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800622:	83 ec 04             	sub    $0x4,%esp
  800625:	52                   	push   %edx
  800626:	50                   	push   %eax
  800627:	68 ec 20 80 00       	push   $0x8020ec
  80062c:	e8 14 03 00 00       	call   800945 <cprintf>
  800631:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800634:	a1 20 30 80 00       	mov    0x803020,%eax
  800639:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80063f:	83 ec 08             	sub    $0x8,%esp
  800642:	50                   	push   %eax
  800643:	68 11 21 80 00       	push   $0x802111
  800648:	e8 f8 02 00 00       	call   800945 <cprintf>
  80064d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800650:	83 ec 0c             	sub    $0xc,%esp
  800653:	68 c4 20 80 00       	push   $0x8020c4
  800658:	e8 e8 02 00 00       	call   800945 <cprintf>
  80065d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800660:	e8 c0 12 00 00       	call   801925 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800665:	e8 19 00 00 00       	call   800683 <exit>
}
  80066a:	90                   	nop
  80066b:	c9                   	leave  
  80066c:	c3                   	ret    

0080066d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80066d:	55                   	push   %ebp
  80066e:	89 e5                	mov    %esp,%ebp
  800670:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800673:	83 ec 0c             	sub    $0xc,%esp
  800676:	6a 00                	push   $0x0
  800678:	e8 bf 10 00 00       	call   80173c <sys_env_destroy>
  80067d:	83 c4 10             	add    $0x10,%esp
}
  800680:	90                   	nop
  800681:	c9                   	leave  
  800682:	c3                   	ret    

00800683 <exit>:

void
exit(void)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
  800686:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800689:	e8 14 11 00 00       	call   8017a2 <sys_env_exit>
}
  80068e:	90                   	nop
  80068f:	c9                   	leave  
  800690:	c3                   	ret    

00800691 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800691:	55                   	push   %ebp
  800692:	89 e5                	mov    %esp,%ebp
  800694:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800697:	8d 45 10             	lea    0x10(%ebp),%eax
  80069a:	83 c0 04             	add    $0x4,%eax
  80069d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006a0:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8006a5:	85 c0                	test   %eax,%eax
  8006a7:	74 16                	je     8006bf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006a9:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8006ae:	83 ec 08             	sub    $0x8,%esp
  8006b1:	50                   	push   %eax
  8006b2:	68 28 21 80 00       	push   $0x802128
  8006b7:	e8 89 02 00 00       	call   800945 <cprintf>
  8006bc:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006bf:	a1 08 30 80 00       	mov    0x803008,%eax
  8006c4:	ff 75 0c             	pushl  0xc(%ebp)
  8006c7:	ff 75 08             	pushl  0x8(%ebp)
  8006ca:	50                   	push   %eax
  8006cb:	68 2d 21 80 00       	push   $0x80212d
  8006d0:	e8 70 02 00 00       	call   800945 <cprintf>
  8006d5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8006db:	83 ec 08             	sub    $0x8,%esp
  8006de:	ff 75 f4             	pushl  -0xc(%ebp)
  8006e1:	50                   	push   %eax
  8006e2:	e8 f3 01 00 00       	call   8008da <vcprintf>
  8006e7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8006ea:	83 ec 08             	sub    $0x8,%esp
  8006ed:	6a 00                	push   $0x0
  8006ef:	68 49 21 80 00       	push   $0x802149
  8006f4:	e8 e1 01 00 00       	call   8008da <vcprintf>
  8006f9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8006fc:	e8 82 ff ff ff       	call   800683 <exit>

	// should not return here
	while (1) ;
  800701:	eb fe                	jmp    800701 <_panic+0x70>

00800703 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800703:	55                   	push   %ebp
  800704:	89 e5                	mov    %esp,%ebp
  800706:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800709:	a1 20 30 80 00       	mov    0x803020,%eax
  80070e:	8b 50 74             	mov    0x74(%eax),%edx
  800711:	8b 45 0c             	mov    0xc(%ebp),%eax
  800714:	39 c2                	cmp    %eax,%edx
  800716:	74 14                	je     80072c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800718:	83 ec 04             	sub    $0x4,%esp
  80071b:	68 4c 21 80 00       	push   $0x80214c
  800720:	6a 26                	push   $0x26
  800722:	68 98 21 80 00       	push   $0x802198
  800727:	e8 65 ff ff ff       	call   800691 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80072c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800733:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80073a:	e9 c2 00 00 00       	jmp    800801 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80073f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800742:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	01 d0                	add    %edx,%eax
  80074e:	8b 00                	mov    (%eax),%eax
  800750:	85 c0                	test   %eax,%eax
  800752:	75 08                	jne    80075c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800754:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800757:	e9 a2 00 00 00       	jmp    8007fe <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80075c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800763:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80076a:	eb 69                	jmp    8007d5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80076c:	a1 20 30 80 00       	mov    0x803020,%eax
  800771:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800777:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80077a:	89 d0                	mov    %edx,%eax
  80077c:	01 c0                	add    %eax,%eax
  80077e:	01 d0                	add    %edx,%eax
  800780:	c1 e0 02             	shl    $0x2,%eax
  800783:	01 c8                	add    %ecx,%eax
  800785:	8a 40 04             	mov    0x4(%eax),%al
  800788:	84 c0                	test   %al,%al
  80078a:	75 46                	jne    8007d2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80078c:	a1 20 30 80 00       	mov    0x803020,%eax
  800791:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800797:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80079a:	89 d0                	mov    %edx,%eax
  80079c:	01 c0                	add    %eax,%eax
  80079e:	01 d0                	add    %edx,%eax
  8007a0:	c1 e0 02             	shl    $0x2,%eax
  8007a3:	01 c8                	add    %ecx,%eax
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007aa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007b2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	01 c8                	add    %ecx,%eax
  8007c3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007c5:	39 c2                	cmp    %eax,%edx
  8007c7:	75 09                	jne    8007d2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8007c9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007d0:	eb 12                	jmp    8007e4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d2:	ff 45 e8             	incl   -0x18(%ebp)
  8007d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8007da:	8b 50 74             	mov    0x74(%eax),%edx
  8007dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007e0:	39 c2                	cmp    %eax,%edx
  8007e2:	77 88                	ja     80076c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007e8:	75 14                	jne    8007fe <CheckWSWithoutLastIndex+0xfb>
			panic(
  8007ea:	83 ec 04             	sub    $0x4,%esp
  8007ed:	68 a4 21 80 00       	push   $0x8021a4
  8007f2:	6a 3a                	push   $0x3a
  8007f4:	68 98 21 80 00       	push   $0x802198
  8007f9:	e8 93 fe ff ff       	call   800691 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8007fe:	ff 45 f0             	incl   -0x10(%ebp)
  800801:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800804:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800807:	0f 8c 32 ff ff ff    	jl     80073f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80080d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800814:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80081b:	eb 26                	jmp    800843 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80081d:	a1 20 30 80 00       	mov    0x803020,%eax
  800822:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800828:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80082b:	89 d0                	mov    %edx,%eax
  80082d:	01 c0                	add    %eax,%eax
  80082f:	01 d0                	add    %edx,%eax
  800831:	c1 e0 02             	shl    $0x2,%eax
  800834:	01 c8                	add    %ecx,%eax
  800836:	8a 40 04             	mov    0x4(%eax),%al
  800839:	3c 01                	cmp    $0x1,%al
  80083b:	75 03                	jne    800840 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80083d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800840:	ff 45 e0             	incl   -0x20(%ebp)
  800843:	a1 20 30 80 00       	mov    0x803020,%eax
  800848:	8b 50 74             	mov    0x74(%eax),%edx
  80084b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80084e:	39 c2                	cmp    %eax,%edx
  800850:	77 cb                	ja     80081d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800852:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800855:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800858:	74 14                	je     80086e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80085a:	83 ec 04             	sub    $0x4,%esp
  80085d:	68 f8 21 80 00       	push   $0x8021f8
  800862:	6a 44                	push   $0x44
  800864:	68 98 21 80 00       	push   $0x802198
  800869:	e8 23 fe ff ff       	call   800691 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80086e:	90                   	nop
  80086f:	c9                   	leave  
  800870:	c3                   	ret    

00800871 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800871:	55                   	push   %ebp
  800872:	89 e5                	mov    %esp,%ebp
  800874:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	8d 48 01             	lea    0x1(%eax),%ecx
  80087f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800882:	89 0a                	mov    %ecx,(%edx)
  800884:	8b 55 08             	mov    0x8(%ebp),%edx
  800887:	88 d1                	mov    %dl,%cl
  800889:	8b 55 0c             	mov    0xc(%ebp),%edx
  80088c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800890:	8b 45 0c             	mov    0xc(%ebp),%eax
  800893:	8b 00                	mov    (%eax),%eax
  800895:	3d ff 00 00 00       	cmp    $0xff,%eax
  80089a:	75 2c                	jne    8008c8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80089c:	a0 24 30 80 00       	mov    0x803024,%al
  8008a1:	0f b6 c0             	movzbl %al,%eax
  8008a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a7:	8b 12                	mov    (%edx),%edx
  8008a9:	89 d1                	mov    %edx,%ecx
  8008ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ae:	83 c2 08             	add    $0x8,%edx
  8008b1:	83 ec 04             	sub    $0x4,%esp
  8008b4:	50                   	push   %eax
  8008b5:	51                   	push   %ecx
  8008b6:	52                   	push   %edx
  8008b7:	e8 3e 0e 00 00       	call   8016fa <sys_cputs>
  8008bc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cb:	8b 40 04             	mov    0x4(%eax),%eax
  8008ce:	8d 50 01             	lea    0x1(%eax),%edx
  8008d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008d7:	90                   	nop
  8008d8:	c9                   	leave  
  8008d9:	c3                   	ret    

008008da <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008da:	55                   	push   %ebp
  8008db:	89 e5                	mov    %esp,%ebp
  8008dd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008e3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008ea:	00 00 00 
	b.cnt = 0;
  8008ed:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8008f4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8008f7:	ff 75 0c             	pushl  0xc(%ebp)
  8008fa:	ff 75 08             	pushl  0x8(%ebp)
  8008fd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800903:	50                   	push   %eax
  800904:	68 71 08 80 00       	push   $0x800871
  800909:	e8 11 02 00 00       	call   800b1f <vprintfmt>
  80090e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800911:	a0 24 30 80 00       	mov    0x803024,%al
  800916:	0f b6 c0             	movzbl %al,%eax
  800919:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80091f:	83 ec 04             	sub    $0x4,%esp
  800922:	50                   	push   %eax
  800923:	52                   	push   %edx
  800924:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80092a:	83 c0 08             	add    $0x8,%eax
  80092d:	50                   	push   %eax
  80092e:	e8 c7 0d 00 00       	call   8016fa <sys_cputs>
  800933:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800936:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80093d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800943:	c9                   	leave  
  800944:	c3                   	ret    

00800945 <cprintf>:

int cprintf(const char *fmt, ...) {
  800945:	55                   	push   %ebp
  800946:	89 e5                	mov    %esp,%ebp
  800948:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80094b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800952:	8d 45 0c             	lea    0xc(%ebp),%eax
  800955:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800958:	8b 45 08             	mov    0x8(%ebp),%eax
  80095b:	83 ec 08             	sub    $0x8,%esp
  80095e:	ff 75 f4             	pushl  -0xc(%ebp)
  800961:	50                   	push   %eax
  800962:	e8 73 ff ff ff       	call   8008da <vcprintf>
  800967:	83 c4 10             	add    $0x10,%esp
  80096a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80096d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800970:	c9                   	leave  
  800971:	c3                   	ret    

00800972 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800972:	55                   	push   %ebp
  800973:	89 e5                	mov    %esp,%ebp
  800975:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800978:	e8 8e 0f 00 00       	call   80190b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80097d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800980:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	83 ec 08             	sub    $0x8,%esp
  800989:	ff 75 f4             	pushl  -0xc(%ebp)
  80098c:	50                   	push   %eax
  80098d:	e8 48 ff ff ff       	call   8008da <vcprintf>
  800992:	83 c4 10             	add    $0x10,%esp
  800995:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800998:	e8 88 0f 00 00       	call   801925 <sys_enable_interrupt>
	return cnt;
  80099d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a0:	c9                   	leave  
  8009a1:	c3                   	ret    

008009a2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009a2:	55                   	push   %ebp
  8009a3:	89 e5                	mov    %esp,%ebp
  8009a5:	53                   	push   %ebx
  8009a6:	83 ec 14             	sub    $0x14,%esp
  8009a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009af:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009b5:	8b 45 18             	mov    0x18(%ebp),%eax
  8009b8:	ba 00 00 00 00       	mov    $0x0,%edx
  8009bd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009c0:	77 55                	ja     800a17 <printnum+0x75>
  8009c2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009c5:	72 05                	jb     8009cc <printnum+0x2a>
  8009c7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009ca:	77 4b                	ja     800a17 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009cc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009cf:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009d2:	8b 45 18             	mov    0x18(%ebp),%eax
  8009d5:	ba 00 00 00 00       	mov    $0x0,%edx
  8009da:	52                   	push   %edx
  8009db:	50                   	push   %eax
  8009dc:	ff 75 f4             	pushl  -0xc(%ebp)
  8009df:	ff 75 f0             	pushl  -0x10(%ebp)
  8009e2:	e8 05 13 00 00       	call   801cec <__udivdi3>
  8009e7:	83 c4 10             	add    $0x10,%esp
  8009ea:	83 ec 04             	sub    $0x4,%esp
  8009ed:	ff 75 20             	pushl  0x20(%ebp)
  8009f0:	53                   	push   %ebx
  8009f1:	ff 75 18             	pushl  0x18(%ebp)
  8009f4:	52                   	push   %edx
  8009f5:	50                   	push   %eax
  8009f6:	ff 75 0c             	pushl  0xc(%ebp)
  8009f9:	ff 75 08             	pushl  0x8(%ebp)
  8009fc:	e8 a1 ff ff ff       	call   8009a2 <printnum>
  800a01:	83 c4 20             	add    $0x20,%esp
  800a04:	eb 1a                	jmp    800a20 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a06:	83 ec 08             	sub    $0x8,%esp
  800a09:	ff 75 0c             	pushl  0xc(%ebp)
  800a0c:	ff 75 20             	pushl  0x20(%ebp)
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	ff d0                	call   *%eax
  800a14:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a17:	ff 4d 1c             	decl   0x1c(%ebp)
  800a1a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a1e:	7f e6                	jg     800a06 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a20:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a23:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a2e:	53                   	push   %ebx
  800a2f:	51                   	push   %ecx
  800a30:	52                   	push   %edx
  800a31:	50                   	push   %eax
  800a32:	e8 c5 13 00 00       	call   801dfc <__umoddi3>
  800a37:	83 c4 10             	add    $0x10,%esp
  800a3a:	05 74 24 80 00       	add    $0x802474,%eax
  800a3f:	8a 00                	mov    (%eax),%al
  800a41:	0f be c0             	movsbl %al,%eax
  800a44:	83 ec 08             	sub    $0x8,%esp
  800a47:	ff 75 0c             	pushl  0xc(%ebp)
  800a4a:	50                   	push   %eax
  800a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4e:	ff d0                	call   *%eax
  800a50:	83 c4 10             	add    $0x10,%esp
}
  800a53:	90                   	nop
  800a54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a57:	c9                   	leave  
  800a58:	c3                   	ret    

00800a59 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a59:	55                   	push   %ebp
  800a5a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a5c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a60:	7e 1c                	jle    800a7e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	8b 00                	mov    (%eax),%eax
  800a67:	8d 50 08             	lea    0x8(%eax),%edx
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	89 10                	mov    %edx,(%eax)
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	8b 00                	mov    (%eax),%eax
  800a74:	83 e8 08             	sub    $0x8,%eax
  800a77:	8b 50 04             	mov    0x4(%eax),%edx
  800a7a:	8b 00                	mov    (%eax),%eax
  800a7c:	eb 40                	jmp    800abe <getuint+0x65>
	else if (lflag)
  800a7e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a82:	74 1e                	je     800aa2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	8b 00                	mov    (%eax),%eax
  800a89:	8d 50 04             	lea    0x4(%eax),%edx
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	89 10                	mov    %edx,(%eax)
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	8b 00                	mov    (%eax),%eax
  800a96:	83 e8 04             	sub    $0x4,%eax
  800a99:	8b 00                	mov    (%eax),%eax
  800a9b:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa0:	eb 1c                	jmp    800abe <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	8b 00                	mov    (%eax),%eax
  800aa7:	8d 50 04             	lea    0x4(%eax),%edx
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	89 10                	mov    %edx,(%eax)
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	8b 00                	mov    (%eax),%eax
  800ab4:	83 e8 04             	sub    $0x4,%eax
  800ab7:	8b 00                	mov    (%eax),%eax
  800ab9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800abe:	5d                   	pop    %ebp
  800abf:	c3                   	ret    

00800ac0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ac0:	55                   	push   %ebp
  800ac1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ac7:	7e 1c                	jle    800ae5 <getint+0x25>
		return va_arg(*ap, long long);
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	8b 00                	mov    (%eax),%eax
  800ace:	8d 50 08             	lea    0x8(%eax),%edx
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	89 10                	mov    %edx,(%eax)
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	8b 00                	mov    (%eax),%eax
  800adb:	83 e8 08             	sub    $0x8,%eax
  800ade:	8b 50 04             	mov    0x4(%eax),%edx
  800ae1:	8b 00                	mov    (%eax),%eax
  800ae3:	eb 38                	jmp    800b1d <getint+0x5d>
	else if (lflag)
  800ae5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ae9:	74 1a                	je     800b05 <getint+0x45>
		return va_arg(*ap, long);
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	8b 00                	mov    (%eax),%eax
  800af0:	8d 50 04             	lea    0x4(%eax),%edx
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	89 10                	mov    %edx,(%eax)
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	83 e8 04             	sub    $0x4,%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	99                   	cltd   
  800b03:	eb 18                	jmp    800b1d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	8d 50 04             	lea    0x4(%eax),%edx
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	89 10                	mov    %edx,(%eax)
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	83 e8 04             	sub    $0x4,%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	99                   	cltd   
}
  800b1d:	5d                   	pop    %ebp
  800b1e:	c3                   	ret    

00800b1f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	56                   	push   %esi
  800b23:	53                   	push   %ebx
  800b24:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b27:	eb 17                	jmp    800b40 <vprintfmt+0x21>
			if (ch == '\0')
  800b29:	85 db                	test   %ebx,%ebx
  800b2b:	0f 84 af 03 00 00    	je     800ee0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b31:	83 ec 08             	sub    $0x8,%esp
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	53                   	push   %ebx
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	ff d0                	call   *%eax
  800b3d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b40:	8b 45 10             	mov    0x10(%ebp),%eax
  800b43:	8d 50 01             	lea    0x1(%eax),%edx
  800b46:	89 55 10             	mov    %edx,0x10(%ebp)
  800b49:	8a 00                	mov    (%eax),%al
  800b4b:	0f b6 d8             	movzbl %al,%ebx
  800b4e:	83 fb 25             	cmp    $0x25,%ebx
  800b51:	75 d6                	jne    800b29 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b53:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b57:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b5e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b65:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b6c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b73:	8b 45 10             	mov    0x10(%ebp),%eax
  800b76:	8d 50 01             	lea    0x1(%eax),%edx
  800b79:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7c:	8a 00                	mov    (%eax),%al
  800b7e:	0f b6 d8             	movzbl %al,%ebx
  800b81:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b84:	83 f8 55             	cmp    $0x55,%eax
  800b87:	0f 87 2b 03 00 00    	ja     800eb8 <vprintfmt+0x399>
  800b8d:	8b 04 85 98 24 80 00 	mov    0x802498(,%eax,4),%eax
  800b94:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b96:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800b9a:	eb d7                	jmp    800b73 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800b9c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ba0:	eb d1                	jmp    800b73 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ba2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ba9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bac:	89 d0                	mov    %edx,%eax
  800bae:	c1 e0 02             	shl    $0x2,%eax
  800bb1:	01 d0                	add    %edx,%eax
  800bb3:	01 c0                	add    %eax,%eax
  800bb5:	01 d8                	add    %ebx,%eax
  800bb7:	83 e8 30             	sub    $0x30,%eax
  800bba:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bbd:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc0:	8a 00                	mov    (%eax),%al
  800bc2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bc5:	83 fb 2f             	cmp    $0x2f,%ebx
  800bc8:	7e 3e                	jle    800c08 <vprintfmt+0xe9>
  800bca:	83 fb 39             	cmp    $0x39,%ebx
  800bcd:	7f 39                	jg     800c08 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bcf:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bd2:	eb d5                	jmp    800ba9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bd4:	8b 45 14             	mov    0x14(%ebp),%eax
  800bd7:	83 c0 04             	add    $0x4,%eax
  800bda:	89 45 14             	mov    %eax,0x14(%ebp)
  800bdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800be0:	83 e8 04             	sub    $0x4,%eax
  800be3:	8b 00                	mov    (%eax),%eax
  800be5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800be8:	eb 1f                	jmp    800c09 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800bea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bee:	79 83                	jns    800b73 <vprintfmt+0x54>
				width = 0;
  800bf0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800bf7:	e9 77 ff ff ff       	jmp    800b73 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800bfc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c03:	e9 6b ff ff ff       	jmp    800b73 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c08:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0d:	0f 89 60 ff ff ff    	jns    800b73 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c13:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c19:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c20:	e9 4e ff ff ff       	jmp    800b73 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c25:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c28:	e9 46 ff ff ff       	jmp    800b73 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c30:	83 c0 04             	add    $0x4,%eax
  800c33:	89 45 14             	mov    %eax,0x14(%ebp)
  800c36:	8b 45 14             	mov    0x14(%ebp),%eax
  800c39:	83 e8 04             	sub    $0x4,%eax
  800c3c:	8b 00                	mov    (%eax),%eax
  800c3e:	83 ec 08             	sub    $0x8,%esp
  800c41:	ff 75 0c             	pushl  0xc(%ebp)
  800c44:	50                   	push   %eax
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	ff d0                	call   *%eax
  800c4a:	83 c4 10             	add    $0x10,%esp
			break;
  800c4d:	e9 89 02 00 00       	jmp    800edb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c52:	8b 45 14             	mov    0x14(%ebp),%eax
  800c55:	83 c0 04             	add    $0x4,%eax
  800c58:	89 45 14             	mov    %eax,0x14(%ebp)
  800c5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5e:	83 e8 04             	sub    $0x4,%eax
  800c61:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c63:	85 db                	test   %ebx,%ebx
  800c65:	79 02                	jns    800c69 <vprintfmt+0x14a>
				err = -err;
  800c67:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c69:	83 fb 64             	cmp    $0x64,%ebx
  800c6c:	7f 0b                	jg     800c79 <vprintfmt+0x15a>
  800c6e:	8b 34 9d e0 22 80 00 	mov    0x8022e0(,%ebx,4),%esi
  800c75:	85 f6                	test   %esi,%esi
  800c77:	75 19                	jne    800c92 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c79:	53                   	push   %ebx
  800c7a:	68 85 24 80 00       	push   $0x802485
  800c7f:	ff 75 0c             	pushl  0xc(%ebp)
  800c82:	ff 75 08             	pushl  0x8(%ebp)
  800c85:	e8 5e 02 00 00       	call   800ee8 <printfmt>
  800c8a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c8d:	e9 49 02 00 00       	jmp    800edb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c92:	56                   	push   %esi
  800c93:	68 8e 24 80 00       	push   $0x80248e
  800c98:	ff 75 0c             	pushl  0xc(%ebp)
  800c9b:	ff 75 08             	pushl  0x8(%ebp)
  800c9e:	e8 45 02 00 00       	call   800ee8 <printfmt>
  800ca3:	83 c4 10             	add    $0x10,%esp
			break;
  800ca6:	e9 30 02 00 00       	jmp    800edb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cab:	8b 45 14             	mov    0x14(%ebp),%eax
  800cae:	83 c0 04             	add    $0x4,%eax
  800cb1:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb7:	83 e8 04             	sub    $0x4,%eax
  800cba:	8b 30                	mov    (%eax),%esi
  800cbc:	85 f6                	test   %esi,%esi
  800cbe:	75 05                	jne    800cc5 <vprintfmt+0x1a6>
				p = "(null)";
  800cc0:	be 91 24 80 00       	mov    $0x802491,%esi
			if (width > 0 && padc != '-')
  800cc5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cc9:	7e 6d                	jle    800d38 <vprintfmt+0x219>
  800ccb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ccf:	74 67                	je     800d38 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cd4:	83 ec 08             	sub    $0x8,%esp
  800cd7:	50                   	push   %eax
  800cd8:	56                   	push   %esi
  800cd9:	e8 0c 03 00 00       	call   800fea <strnlen>
  800cde:	83 c4 10             	add    $0x10,%esp
  800ce1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ce4:	eb 16                	jmp    800cfc <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ce6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800cea:	83 ec 08             	sub    $0x8,%esp
  800ced:	ff 75 0c             	pushl  0xc(%ebp)
  800cf0:	50                   	push   %eax
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	ff d0                	call   *%eax
  800cf6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800cf9:	ff 4d e4             	decl   -0x1c(%ebp)
  800cfc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d00:	7f e4                	jg     800ce6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d02:	eb 34                	jmp    800d38 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d04:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d08:	74 1c                	je     800d26 <vprintfmt+0x207>
  800d0a:	83 fb 1f             	cmp    $0x1f,%ebx
  800d0d:	7e 05                	jle    800d14 <vprintfmt+0x1f5>
  800d0f:	83 fb 7e             	cmp    $0x7e,%ebx
  800d12:	7e 12                	jle    800d26 <vprintfmt+0x207>
					putch('?', putdat);
  800d14:	83 ec 08             	sub    $0x8,%esp
  800d17:	ff 75 0c             	pushl  0xc(%ebp)
  800d1a:	6a 3f                	push   $0x3f
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	ff d0                	call   *%eax
  800d21:	83 c4 10             	add    $0x10,%esp
  800d24:	eb 0f                	jmp    800d35 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d26:	83 ec 08             	sub    $0x8,%esp
  800d29:	ff 75 0c             	pushl  0xc(%ebp)
  800d2c:	53                   	push   %ebx
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	ff d0                	call   *%eax
  800d32:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d35:	ff 4d e4             	decl   -0x1c(%ebp)
  800d38:	89 f0                	mov    %esi,%eax
  800d3a:	8d 70 01             	lea    0x1(%eax),%esi
  800d3d:	8a 00                	mov    (%eax),%al
  800d3f:	0f be d8             	movsbl %al,%ebx
  800d42:	85 db                	test   %ebx,%ebx
  800d44:	74 24                	je     800d6a <vprintfmt+0x24b>
  800d46:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d4a:	78 b8                	js     800d04 <vprintfmt+0x1e5>
  800d4c:	ff 4d e0             	decl   -0x20(%ebp)
  800d4f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d53:	79 af                	jns    800d04 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d55:	eb 13                	jmp    800d6a <vprintfmt+0x24b>
				putch(' ', putdat);
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	ff 75 0c             	pushl  0xc(%ebp)
  800d5d:	6a 20                	push   $0x20
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	ff d0                	call   *%eax
  800d64:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d67:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d6e:	7f e7                	jg     800d57 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d70:	e9 66 01 00 00       	jmp    800edb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d75:	83 ec 08             	sub    $0x8,%esp
  800d78:	ff 75 e8             	pushl  -0x18(%ebp)
  800d7b:	8d 45 14             	lea    0x14(%ebp),%eax
  800d7e:	50                   	push   %eax
  800d7f:	e8 3c fd ff ff       	call   800ac0 <getint>
  800d84:	83 c4 10             	add    $0x10,%esp
  800d87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d8a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d90:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d93:	85 d2                	test   %edx,%edx
  800d95:	79 23                	jns    800dba <vprintfmt+0x29b>
				putch('-', putdat);
  800d97:	83 ec 08             	sub    $0x8,%esp
  800d9a:	ff 75 0c             	pushl  0xc(%ebp)
  800d9d:	6a 2d                	push   $0x2d
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	ff d0                	call   *%eax
  800da4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800daa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dad:	f7 d8                	neg    %eax
  800daf:	83 d2 00             	adc    $0x0,%edx
  800db2:	f7 da                	neg    %edx
  800db4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800db7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dba:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800dc1:	e9 bc 00 00 00       	jmp    800e82 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dc6:	83 ec 08             	sub    $0x8,%esp
  800dc9:	ff 75 e8             	pushl  -0x18(%ebp)
  800dcc:	8d 45 14             	lea    0x14(%ebp),%eax
  800dcf:	50                   	push   %eax
  800dd0:	e8 84 fc ff ff       	call   800a59 <getuint>
  800dd5:	83 c4 10             	add    $0x10,%esp
  800dd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ddb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800dde:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800de5:	e9 98 00 00 00       	jmp    800e82 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800dea:	83 ec 08             	sub    $0x8,%esp
  800ded:	ff 75 0c             	pushl  0xc(%ebp)
  800df0:	6a 58                	push   $0x58
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	ff d0                	call   *%eax
  800df7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800dfa:	83 ec 08             	sub    $0x8,%esp
  800dfd:	ff 75 0c             	pushl  0xc(%ebp)
  800e00:	6a 58                	push   $0x58
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	ff d0                	call   *%eax
  800e07:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e0a:	83 ec 08             	sub    $0x8,%esp
  800e0d:	ff 75 0c             	pushl  0xc(%ebp)
  800e10:	6a 58                	push   $0x58
  800e12:	8b 45 08             	mov    0x8(%ebp),%eax
  800e15:	ff d0                	call   *%eax
  800e17:	83 c4 10             	add    $0x10,%esp
			break;
  800e1a:	e9 bc 00 00 00       	jmp    800edb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e1f:	83 ec 08             	sub    $0x8,%esp
  800e22:	ff 75 0c             	pushl  0xc(%ebp)
  800e25:	6a 30                	push   $0x30
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	ff d0                	call   *%eax
  800e2c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e2f:	83 ec 08             	sub    $0x8,%esp
  800e32:	ff 75 0c             	pushl  0xc(%ebp)
  800e35:	6a 78                	push   $0x78
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	ff d0                	call   *%eax
  800e3c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e42:	83 c0 04             	add    $0x4,%eax
  800e45:	89 45 14             	mov    %eax,0x14(%ebp)
  800e48:	8b 45 14             	mov    0x14(%ebp),%eax
  800e4b:	83 e8 04             	sub    $0x4,%eax
  800e4e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e5a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e61:	eb 1f                	jmp    800e82 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e63:	83 ec 08             	sub    $0x8,%esp
  800e66:	ff 75 e8             	pushl  -0x18(%ebp)
  800e69:	8d 45 14             	lea    0x14(%ebp),%eax
  800e6c:	50                   	push   %eax
  800e6d:	e8 e7 fb ff ff       	call   800a59 <getuint>
  800e72:	83 c4 10             	add    $0x10,%esp
  800e75:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e78:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e7b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e82:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e86:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e89:	83 ec 04             	sub    $0x4,%esp
  800e8c:	52                   	push   %edx
  800e8d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e90:	50                   	push   %eax
  800e91:	ff 75 f4             	pushl  -0xc(%ebp)
  800e94:	ff 75 f0             	pushl  -0x10(%ebp)
  800e97:	ff 75 0c             	pushl  0xc(%ebp)
  800e9a:	ff 75 08             	pushl  0x8(%ebp)
  800e9d:	e8 00 fb ff ff       	call   8009a2 <printnum>
  800ea2:	83 c4 20             	add    $0x20,%esp
			break;
  800ea5:	eb 34                	jmp    800edb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ea7:	83 ec 08             	sub    $0x8,%esp
  800eaa:	ff 75 0c             	pushl  0xc(%ebp)
  800ead:	53                   	push   %ebx
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	ff d0                	call   *%eax
  800eb3:	83 c4 10             	add    $0x10,%esp
			break;
  800eb6:	eb 23                	jmp    800edb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eb8:	83 ec 08             	sub    $0x8,%esp
  800ebb:	ff 75 0c             	pushl  0xc(%ebp)
  800ebe:	6a 25                	push   $0x25
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	ff d0                	call   *%eax
  800ec5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ec8:	ff 4d 10             	decl   0x10(%ebp)
  800ecb:	eb 03                	jmp    800ed0 <vprintfmt+0x3b1>
  800ecd:	ff 4d 10             	decl   0x10(%ebp)
  800ed0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed3:	48                   	dec    %eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	3c 25                	cmp    $0x25,%al
  800ed8:	75 f3                	jne    800ecd <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800eda:	90                   	nop
		}
	}
  800edb:	e9 47 fc ff ff       	jmp    800b27 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ee0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ee1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ee4:	5b                   	pop    %ebx
  800ee5:	5e                   	pop    %esi
  800ee6:	5d                   	pop    %ebp
  800ee7:	c3                   	ret    

00800ee8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ee8:	55                   	push   %ebp
  800ee9:	89 e5                	mov    %esp,%ebp
  800eeb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800eee:	8d 45 10             	lea    0x10(%ebp),%eax
  800ef1:	83 c0 04             	add    $0x4,%eax
  800ef4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ef7:	8b 45 10             	mov    0x10(%ebp),%eax
  800efa:	ff 75 f4             	pushl  -0xc(%ebp)
  800efd:	50                   	push   %eax
  800efe:	ff 75 0c             	pushl  0xc(%ebp)
  800f01:	ff 75 08             	pushl  0x8(%ebp)
  800f04:	e8 16 fc ff ff       	call   800b1f <vprintfmt>
  800f09:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f0c:	90                   	nop
  800f0d:	c9                   	leave  
  800f0e:	c3                   	ret    

00800f0f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f0f:	55                   	push   %ebp
  800f10:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f15:	8b 40 08             	mov    0x8(%eax),%eax
  800f18:	8d 50 01             	lea    0x1(%eax),%edx
  800f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f24:	8b 10                	mov    (%eax),%edx
  800f26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f29:	8b 40 04             	mov    0x4(%eax),%eax
  800f2c:	39 c2                	cmp    %eax,%edx
  800f2e:	73 12                	jae    800f42 <sprintputch+0x33>
		*b->buf++ = ch;
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	8b 00                	mov    (%eax),%eax
  800f35:	8d 48 01             	lea    0x1(%eax),%ecx
  800f38:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3b:	89 0a                	mov    %ecx,(%edx)
  800f3d:	8b 55 08             	mov    0x8(%ebp),%edx
  800f40:	88 10                	mov    %dl,(%eax)
}
  800f42:	90                   	nop
  800f43:	5d                   	pop    %ebp
  800f44:	c3                   	ret    

00800f45 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f45:	55                   	push   %ebp
  800f46:	89 e5                	mov    %esp,%ebp
  800f48:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	01 d0                	add    %edx,%eax
  800f5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f66:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f6a:	74 06                	je     800f72 <vsnprintf+0x2d>
  800f6c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f70:	7f 07                	jg     800f79 <vsnprintf+0x34>
		return -E_INVAL;
  800f72:	b8 03 00 00 00       	mov    $0x3,%eax
  800f77:	eb 20                	jmp    800f99 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f79:	ff 75 14             	pushl  0x14(%ebp)
  800f7c:	ff 75 10             	pushl  0x10(%ebp)
  800f7f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f82:	50                   	push   %eax
  800f83:	68 0f 0f 80 00       	push   $0x800f0f
  800f88:	e8 92 fb ff ff       	call   800b1f <vprintfmt>
  800f8d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f90:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f93:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f96:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f99:	c9                   	leave  
  800f9a:	c3                   	ret    

00800f9b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800f9b:	55                   	push   %ebp
  800f9c:	89 e5                	mov    %esp,%ebp
  800f9e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fa1:	8d 45 10             	lea    0x10(%ebp),%eax
  800fa4:	83 c0 04             	add    $0x4,%eax
  800fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800faa:	8b 45 10             	mov    0x10(%ebp),%eax
  800fad:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb0:	50                   	push   %eax
  800fb1:	ff 75 0c             	pushl  0xc(%ebp)
  800fb4:	ff 75 08             	pushl  0x8(%ebp)
  800fb7:	e8 89 ff ff ff       	call   800f45 <vsnprintf>
  800fbc:	83 c4 10             	add    $0x10,%esp
  800fbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fc5:	c9                   	leave  
  800fc6:	c3                   	ret    

00800fc7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fc7:	55                   	push   %ebp
  800fc8:	89 e5                	mov    %esp,%ebp
  800fca:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fcd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fd4:	eb 06                	jmp    800fdc <strlen+0x15>
		n++;
  800fd6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fd9:	ff 45 08             	incl   0x8(%ebp)
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	8a 00                	mov    (%eax),%al
  800fe1:	84 c0                	test   %al,%al
  800fe3:	75 f1                	jne    800fd6 <strlen+0xf>
		n++;
	return n;
  800fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fe8:	c9                   	leave  
  800fe9:	c3                   	ret    

00800fea <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800fea:	55                   	push   %ebp
  800feb:	89 e5                	mov    %esp,%ebp
  800fed:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ff0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ff7:	eb 09                	jmp    801002 <strnlen+0x18>
		n++;
  800ff9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ffc:	ff 45 08             	incl   0x8(%ebp)
  800fff:	ff 4d 0c             	decl   0xc(%ebp)
  801002:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801006:	74 09                	je     801011 <strnlen+0x27>
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
  80100b:	8a 00                	mov    (%eax),%al
  80100d:	84 c0                	test   %al,%al
  80100f:	75 e8                	jne    800ff9 <strnlen+0xf>
		n++;
	return n;
  801011:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801014:	c9                   	leave  
  801015:	c3                   	ret    

00801016 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801016:	55                   	push   %ebp
  801017:	89 e5                	mov    %esp,%ebp
  801019:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801022:	90                   	nop
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	8d 50 01             	lea    0x1(%eax),%edx
  801029:	89 55 08             	mov    %edx,0x8(%ebp)
  80102c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80102f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801032:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801035:	8a 12                	mov    (%edx),%dl
  801037:	88 10                	mov    %dl,(%eax)
  801039:	8a 00                	mov    (%eax),%al
  80103b:	84 c0                	test   %al,%al
  80103d:	75 e4                	jne    801023 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80103f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801050:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801057:	eb 1f                	jmp    801078 <strncpy+0x34>
		*dst++ = *src;
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	8d 50 01             	lea    0x1(%eax),%edx
  80105f:	89 55 08             	mov    %edx,0x8(%ebp)
  801062:	8b 55 0c             	mov    0xc(%ebp),%edx
  801065:	8a 12                	mov    (%edx),%dl
  801067:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801069:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106c:	8a 00                	mov    (%eax),%al
  80106e:	84 c0                	test   %al,%al
  801070:	74 03                	je     801075 <strncpy+0x31>
			src++;
  801072:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801075:	ff 45 fc             	incl   -0x4(%ebp)
  801078:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80107b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80107e:	72 d9                	jb     801059 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801080:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
  801088:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801091:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801095:	74 30                	je     8010c7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801097:	eb 16                	jmp    8010af <strlcpy+0x2a>
			*dst++ = *src++;
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	8d 50 01             	lea    0x1(%eax),%edx
  80109f:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ab:	8a 12                	mov    (%edx),%dl
  8010ad:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010af:	ff 4d 10             	decl   0x10(%ebp)
  8010b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b6:	74 09                	je     8010c1 <strlcpy+0x3c>
  8010b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bb:	8a 00                	mov    (%eax),%al
  8010bd:	84 c0                	test   %al,%al
  8010bf:	75 d8                	jne    801099 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010c7:	8b 55 08             	mov    0x8(%ebp),%edx
  8010ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cd:	29 c2                	sub    %eax,%edx
  8010cf:	89 d0                	mov    %edx,%eax
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010d6:	eb 06                	jmp    8010de <strcmp+0xb>
		p++, q++;
  8010d8:	ff 45 08             	incl   0x8(%ebp)
  8010db:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010de:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e1:	8a 00                	mov    (%eax),%al
  8010e3:	84 c0                	test   %al,%al
  8010e5:	74 0e                	je     8010f5 <strcmp+0x22>
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	8a 10                	mov    (%eax),%dl
  8010ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ef:	8a 00                	mov    (%eax),%al
  8010f1:	38 c2                	cmp    %al,%dl
  8010f3:	74 e3                	je     8010d8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	0f b6 d0             	movzbl %al,%edx
  8010fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	0f b6 c0             	movzbl %al,%eax
  801105:	29 c2                	sub    %eax,%edx
  801107:	89 d0                	mov    %edx,%eax
}
  801109:	5d                   	pop    %ebp
  80110a:	c3                   	ret    

0080110b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80110e:	eb 09                	jmp    801119 <strncmp+0xe>
		n--, p++, q++;
  801110:	ff 4d 10             	decl   0x10(%ebp)
  801113:	ff 45 08             	incl   0x8(%ebp)
  801116:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801119:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80111d:	74 17                	je     801136 <strncmp+0x2b>
  80111f:	8b 45 08             	mov    0x8(%ebp),%eax
  801122:	8a 00                	mov    (%eax),%al
  801124:	84 c0                	test   %al,%al
  801126:	74 0e                	je     801136 <strncmp+0x2b>
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	8a 10                	mov    (%eax),%dl
  80112d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801130:	8a 00                	mov    (%eax),%al
  801132:	38 c2                	cmp    %al,%dl
  801134:	74 da                	je     801110 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801136:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113a:	75 07                	jne    801143 <strncmp+0x38>
		return 0;
  80113c:	b8 00 00 00 00       	mov    $0x0,%eax
  801141:	eb 14                	jmp    801157 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	0f b6 d0             	movzbl %al,%edx
  80114b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	0f b6 c0             	movzbl %al,%eax
  801153:	29 c2                	sub    %eax,%edx
  801155:	89 d0                	mov    %edx,%eax
}
  801157:	5d                   	pop    %ebp
  801158:	c3                   	ret    

00801159 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
  80115c:	83 ec 04             	sub    $0x4,%esp
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801165:	eb 12                	jmp    801179 <strchr+0x20>
		if (*s == c)
  801167:	8b 45 08             	mov    0x8(%ebp),%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80116f:	75 05                	jne    801176 <strchr+0x1d>
			return (char *) s;
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	eb 11                	jmp    801187 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801176:	ff 45 08             	incl   0x8(%ebp)
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	84 c0                	test   %al,%al
  801180:	75 e5                	jne    801167 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801182:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801187:	c9                   	leave  
  801188:	c3                   	ret    

00801189 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801189:	55                   	push   %ebp
  80118a:	89 e5                	mov    %esp,%ebp
  80118c:	83 ec 04             	sub    $0x4,%esp
  80118f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801192:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801195:	eb 0d                	jmp    8011a4 <strfind+0x1b>
		if (*s == c)
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80119f:	74 0e                	je     8011af <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011a1:	ff 45 08             	incl   0x8(%ebp)
  8011a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	84 c0                	test   %al,%al
  8011ab:	75 ea                	jne    801197 <strfind+0xe>
  8011ad:	eb 01                	jmp    8011b0 <strfind+0x27>
		if (*s == c)
			break;
  8011af:	90                   	nop
	return (char *) s;
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011b3:	c9                   	leave  
  8011b4:	c3                   	ret    

008011b5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011b5:	55                   	push   %ebp
  8011b6:	89 e5                	mov    %esp,%ebp
  8011b8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011c7:	eb 0e                	jmp    8011d7 <memset+0x22>
		*p++ = c;
  8011c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011cc:	8d 50 01             	lea    0x1(%eax),%edx
  8011cf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011d5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011d7:	ff 4d f8             	decl   -0x8(%ebp)
  8011da:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011de:	79 e9                	jns    8011c9 <memset+0x14>
		*p++ = c;

	return v;
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e3:	c9                   	leave  
  8011e4:	c3                   	ret    

008011e5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011e5:	55                   	push   %ebp
  8011e6:	89 e5                	mov    %esp,%ebp
  8011e8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8011f7:	eb 16                	jmp    80120f <memcpy+0x2a>
		*d++ = *s++;
  8011f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011fc:	8d 50 01             	lea    0x1(%eax),%edx
  8011ff:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801202:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801205:	8d 4a 01             	lea    0x1(%edx),%ecx
  801208:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80120b:	8a 12                	mov    (%edx),%dl
  80120d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80120f:	8b 45 10             	mov    0x10(%ebp),%eax
  801212:	8d 50 ff             	lea    -0x1(%eax),%edx
  801215:	89 55 10             	mov    %edx,0x10(%ebp)
  801218:	85 c0                	test   %eax,%eax
  80121a:	75 dd                	jne    8011f9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
  801224:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801227:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801233:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801236:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801239:	73 50                	jae    80128b <memmove+0x6a>
  80123b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123e:	8b 45 10             	mov    0x10(%ebp),%eax
  801241:	01 d0                	add    %edx,%eax
  801243:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801246:	76 43                	jbe    80128b <memmove+0x6a>
		s += n;
  801248:	8b 45 10             	mov    0x10(%ebp),%eax
  80124b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80124e:	8b 45 10             	mov    0x10(%ebp),%eax
  801251:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801254:	eb 10                	jmp    801266 <memmove+0x45>
			*--d = *--s;
  801256:	ff 4d f8             	decl   -0x8(%ebp)
  801259:	ff 4d fc             	decl   -0x4(%ebp)
  80125c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125f:	8a 10                	mov    (%eax),%dl
  801261:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801264:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801266:	8b 45 10             	mov    0x10(%ebp),%eax
  801269:	8d 50 ff             	lea    -0x1(%eax),%edx
  80126c:	89 55 10             	mov    %edx,0x10(%ebp)
  80126f:	85 c0                	test   %eax,%eax
  801271:	75 e3                	jne    801256 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801273:	eb 23                	jmp    801298 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801275:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801278:	8d 50 01             	lea    0x1(%eax),%edx
  80127b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80127e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801281:	8d 4a 01             	lea    0x1(%edx),%ecx
  801284:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801287:	8a 12                	mov    (%edx),%dl
  801289:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80128b:	8b 45 10             	mov    0x10(%ebp),%eax
  80128e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801291:	89 55 10             	mov    %edx,0x10(%ebp)
  801294:	85 c0                	test   %eax,%eax
  801296:	75 dd                	jne    801275 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
  8012a0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ac:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012af:	eb 2a                	jmp    8012db <memcmp+0x3e>
		if (*s1 != *s2)
  8012b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b4:	8a 10                	mov    (%eax),%dl
  8012b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	38 c2                	cmp    %al,%dl
  8012bd:	74 16                	je     8012d5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	0f b6 d0             	movzbl %al,%edx
  8012c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ca:	8a 00                	mov    (%eax),%al
  8012cc:	0f b6 c0             	movzbl %al,%eax
  8012cf:	29 c2                	sub    %eax,%edx
  8012d1:	89 d0                	mov    %edx,%eax
  8012d3:	eb 18                	jmp    8012ed <memcmp+0x50>
		s1++, s2++;
  8012d5:	ff 45 fc             	incl   -0x4(%ebp)
  8012d8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012db:	8b 45 10             	mov    0x10(%ebp),%eax
  8012de:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e1:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e4:	85 c0                	test   %eax,%eax
  8012e6:	75 c9                	jne    8012b1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
  8012f2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fb:	01 d0                	add    %edx,%eax
  8012fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801300:	eb 15                	jmp    801317 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	8a 00                	mov    (%eax),%al
  801307:	0f b6 d0             	movzbl %al,%edx
  80130a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130d:	0f b6 c0             	movzbl %al,%eax
  801310:	39 c2                	cmp    %eax,%edx
  801312:	74 0d                	je     801321 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801314:	ff 45 08             	incl   0x8(%ebp)
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80131d:	72 e3                	jb     801302 <memfind+0x13>
  80131f:	eb 01                	jmp    801322 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801321:	90                   	nop
	return (void *) s;
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
  80132a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80132d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801334:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80133b:	eb 03                	jmp    801340 <strtol+0x19>
		s++;
  80133d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	8a 00                	mov    (%eax),%al
  801345:	3c 20                	cmp    $0x20,%al
  801347:	74 f4                	je     80133d <strtol+0x16>
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	8a 00                	mov    (%eax),%al
  80134e:	3c 09                	cmp    $0x9,%al
  801350:	74 eb                	je     80133d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	3c 2b                	cmp    $0x2b,%al
  801359:	75 05                	jne    801360 <strtol+0x39>
		s++;
  80135b:	ff 45 08             	incl   0x8(%ebp)
  80135e:	eb 13                	jmp    801373 <strtol+0x4c>
	else if (*s == '-')
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	3c 2d                	cmp    $0x2d,%al
  801367:	75 0a                	jne    801373 <strtol+0x4c>
		s++, neg = 1;
  801369:	ff 45 08             	incl   0x8(%ebp)
  80136c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801373:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801377:	74 06                	je     80137f <strtol+0x58>
  801379:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80137d:	75 20                	jne    80139f <strtol+0x78>
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 30                	cmp    $0x30,%al
  801386:	75 17                	jne    80139f <strtol+0x78>
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	40                   	inc    %eax
  80138c:	8a 00                	mov    (%eax),%al
  80138e:	3c 78                	cmp    $0x78,%al
  801390:	75 0d                	jne    80139f <strtol+0x78>
		s += 2, base = 16;
  801392:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801396:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80139d:	eb 28                	jmp    8013c7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80139f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a3:	75 15                	jne    8013ba <strtol+0x93>
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	8a 00                	mov    (%eax),%al
  8013aa:	3c 30                	cmp    $0x30,%al
  8013ac:	75 0c                	jne    8013ba <strtol+0x93>
		s++, base = 8;
  8013ae:	ff 45 08             	incl   0x8(%ebp)
  8013b1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013b8:	eb 0d                	jmp    8013c7 <strtol+0xa0>
	else if (base == 0)
  8013ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013be:	75 07                	jne    8013c7 <strtol+0xa0>
		base = 10;
  8013c0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	8a 00                	mov    (%eax),%al
  8013cc:	3c 2f                	cmp    $0x2f,%al
  8013ce:	7e 19                	jle    8013e9 <strtol+0xc2>
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	8a 00                	mov    (%eax),%al
  8013d5:	3c 39                	cmp    $0x39,%al
  8013d7:	7f 10                	jg     8013e9 <strtol+0xc2>
			dig = *s - '0';
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8a 00                	mov    (%eax),%al
  8013de:	0f be c0             	movsbl %al,%eax
  8013e1:	83 e8 30             	sub    $0x30,%eax
  8013e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013e7:	eb 42                	jmp    80142b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ec:	8a 00                	mov    (%eax),%al
  8013ee:	3c 60                	cmp    $0x60,%al
  8013f0:	7e 19                	jle    80140b <strtol+0xe4>
  8013f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f5:	8a 00                	mov    (%eax),%al
  8013f7:	3c 7a                	cmp    $0x7a,%al
  8013f9:	7f 10                	jg     80140b <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	8a 00                	mov    (%eax),%al
  801400:	0f be c0             	movsbl %al,%eax
  801403:	83 e8 57             	sub    $0x57,%eax
  801406:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801409:	eb 20                	jmp    80142b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	3c 40                	cmp    $0x40,%al
  801412:	7e 39                	jle    80144d <strtol+0x126>
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	8a 00                	mov    (%eax),%al
  801419:	3c 5a                	cmp    $0x5a,%al
  80141b:	7f 30                	jg     80144d <strtol+0x126>
			dig = *s - 'A' + 10;
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	0f be c0             	movsbl %al,%eax
  801425:	83 e8 37             	sub    $0x37,%eax
  801428:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80142b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80142e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801431:	7d 19                	jge    80144c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801433:	ff 45 08             	incl   0x8(%ebp)
  801436:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801439:	0f af 45 10          	imul   0x10(%ebp),%eax
  80143d:	89 c2                	mov    %eax,%edx
  80143f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801442:	01 d0                	add    %edx,%eax
  801444:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801447:	e9 7b ff ff ff       	jmp    8013c7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80144c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80144d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801451:	74 08                	je     80145b <strtol+0x134>
		*endptr = (char *) s;
  801453:	8b 45 0c             	mov    0xc(%ebp),%eax
  801456:	8b 55 08             	mov    0x8(%ebp),%edx
  801459:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80145b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80145f:	74 07                	je     801468 <strtol+0x141>
  801461:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801464:	f7 d8                	neg    %eax
  801466:	eb 03                	jmp    80146b <strtol+0x144>
  801468:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <ltostr>:

void
ltostr(long value, char *str)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
  801470:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801473:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80147a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801481:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801485:	79 13                	jns    80149a <ltostr+0x2d>
	{
		neg = 1;
  801487:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80148e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801491:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801494:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801497:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014a2:	99                   	cltd   
  8014a3:	f7 f9                	idiv   %ecx
  8014a5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ab:	8d 50 01             	lea    0x1(%eax),%edx
  8014ae:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014b1:	89 c2                	mov    %eax,%edx
  8014b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b6:	01 d0                	add    %edx,%eax
  8014b8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014bb:	83 c2 30             	add    $0x30,%edx
  8014be:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014c3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014c8:	f7 e9                	imul   %ecx
  8014ca:	c1 fa 02             	sar    $0x2,%edx
  8014cd:	89 c8                	mov    %ecx,%eax
  8014cf:	c1 f8 1f             	sar    $0x1f,%eax
  8014d2:	29 c2                	sub    %eax,%edx
  8014d4:	89 d0                	mov    %edx,%eax
  8014d6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014dc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014e1:	f7 e9                	imul   %ecx
  8014e3:	c1 fa 02             	sar    $0x2,%edx
  8014e6:	89 c8                	mov    %ecx,%eax
  8014e8:	c1 f8 1f             	sar    $0x1f,%eax
  8014eb:	29 c2                	sub    %eax,%edx
  8014ed:	89 d0                	mov    %edx,%eax
  8014ef:	c1 e0 02             	shl    $0x2,%eax
  8014f2:	01 d0                	add    %edx,%eax
  8014f4:	01 c0                	add    %eax,%eax
  8014f6:	29 c1                	sub    %eax,%ecx
  8014f8:	89 ca                	mov    %ecx,%edx
  8014fa:	85 d2                	test   %edx,%edx
  8014fc:	75 9c                	jne    80149a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8014fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801505:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801508:	48                   	dec    %eax
  801509:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80150c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801510:	74 3d                	je     80154f <ltostr+0xe2>
		start = 1 ;
  801512:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801519:	eb 34                	jmp    80154f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80151b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80151e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801521:	01 d0                	add    %edx,%eax
  801523:	8a 00                	mov    (%eax),%al
  801525:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801528:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80152b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152e:	01 c2                	add    %eax,%edx
  801530:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801533:	8b 45 0c             	mov    0xc(%ebp),%eax
  801536:	01 c8                	add    %ecx,%eax
  801538:	8a 00                	mov    (%eax),%al
  80153a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80153c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80153f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801542:	01 c2                	add    %eax,%edx
  801544:	8a 45 eb             	mov    -0x15(%ebp),%al
  801547:	88 02                	mov    %al,(%edx)
		start++ ;
  801549:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80154c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80154f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801552:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801555:	7c c4                	jl     80151b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801557:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80155a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155d:	01 d0                	add    %edx,%eax
  80155f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801562:	90                   	nop
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
  801568:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80156b:	ff 75 08             	pushl  0x8(%ebp)
  80156e:	e8 54 fa ff ff       	call   800fc7 <strlen>
  801573:	83 c4 04             	add    $0x4,%esp
  801576:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801579:	ff 75 0c             	pushl  0xc(%ebp)
  80157c:	e8 46 fa ff ff       	call   800fc7 <strlen>
  801581:	83 c4 04             	add    $0x4,%esp
  801584:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801587:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80158e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801595:	eb 17                	jmp    8015ae <strcconcat+0x49>
		final[s] = str1[s] ;
  801597:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80159a:	8b 45 10             	mov    0x10(%ebp),%eax
  80159d:	01 c2                	add    %eax,%edx
  80159f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	01 c8                	add    %ecx,%eax
  8015a7:	8a 00                	mov    (%eax),%al
  8015a9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015ab:	ff 45 fc             	incl   -0x4(%ebp)
  8015ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015b4:	7c e1                	jl     801597 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015b6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015c4:	eb 1f                	jmp    8015e5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c9:	8d 50 01             	lea    0x1(%eax),%edx
  8015cc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015cf:	89 c2                	mov    %eax,%edx
  8015d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d4:	01 c2                	add    %eax,%edx
  8015d6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015dc:	01 c8                	add    %ecx,%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015e2:	ff 45 f8             	incl   -0x8(%ebp)
  8015e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015eb:	7c d9                	jl     8015c6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f3:	01 d0                	add    %edx,%eax
  8015f5:	c6 00 00             	movb   $0x0,(%eax)
}
  8015f8:	90                   	nop
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8015fe:	8b 45 14             	mov    0x14(%ebp),%eax
  801601:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801607:	8b 45 14             	mov    0x14(%ebp),%eax
  80160a:	8b 00                	mov    (%eax),%eax
  80160c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801613:	8b 45 10             	mov    0x10(%ebp),%eax
  801616:	01 d0                	add    %edx,%eax
  801618:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80161e:	eb 0c                	jmp    80162c <strsplit+0x31>
			*string++ = 0;
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8d 50 01             	lea    0x1(%eax),%edx
  801626:	89 55 08             	mov    %edx,0x8(%ebp)
  801629:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	84 c0                	test   %al,%al
  801633:	74 18                	je     80164d <strsplit+0x52>
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	0f be c0             	movsbl %al,%eax
  80163d:	50                   	push   %eax
  80163e:	ff 75 0c             	pushl  0xc(%ebp)
  801641:	e8 13 fb ff ff       	call   801159 <strchr>
  801646:	83 c4 08             	add    $0x8,%esp
  801649:	85 c0                	test   %eax,%eax
  80164b:	75 d3                	jne    801620 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	8a 00                	mov    (%eax),%al
  801652:	84 c0                	test   %al,%al
  801654:	74 5a                	je     8016b0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801656:	8b 45 14             	mov    0x14(%ebp),%eax
  801659:	8b 00                	mov    (%eax),%eax
  80165b:	83 f8 0f             	cmp    $0xf,%eax
  80165e:	75 07                	jne    801667 <strsplit+0x6c>
		{
			return 0;
  801660:	b8 00 00 00 00       	mov    $0x0,%eax
  801665:	eb 66                	jmp    8016cd <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801667:	8b 45 14             	mov    0x14(%ebp),%eax
  80166a:	8b 00                	mov    (%eax),%eax
  80166c:	8d 48 01             	lea    0x1(%eax),%ecx
  80166f:	8b 55 14             	mov    0x14(%ebp),%edx
  801672:	89 0a                	mov    %ecx,(%edx)
  801674:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80167b:	8b 45 10             	mov    0x10(%ebp),%eax
  80167e:	01 c2                	add    %eax,%edx
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801685:	eb 03                	jmp    80168a <strsplit+0x8f>
			string++;
  801687:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
  80168d:	8a 00                	mov    (%eax),%al
  80168f:	84 c0                	test   %al,%al
  801691:	74 8b                	je     80161e <strsplit+0x23>
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	0f be c0             	movsbl %al,%eax
  80169b:	50                   	push   %eax
  80169c:	ff 75 0c             	pushl  0xc(%ebp)
  80169f:	e8 b5 fa ff ff       	call   801159 <strchr>
  8016a4:	83 c4 08             	add    $0x8,%esp
  8016a7:	85 c0                	test   %eax,%eax
  8016a9:	74 dc                	je     801687 <strsplit+0x8c>
			string++;
	}
  8016ab:	e9 6e ff ff ff       	jmp    80161e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016b0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b4:	8b 00                	mov    (%eax),%eax
  8016b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c0:	01 d0                	add    %edx,%eax
  8016c2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016c8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016cd:	c9                   	leave  
  8016ce:	c3                   	ret    

008016cf <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016cf:	55                   	push   %ebp
  8016d0:	89 e5                	mov    %esp,%ebp
  8016d2:	57                   	push   %edi
  8016d3:	56                   	push   %esi
  8016d4:	53                   	push   %ebx
  8016d5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016e4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016e7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016ea:	cd 30                	int    $0x30
  8016ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016f2:	83 c4 10             	add    $0x10,%esp
  8016f5:	5b                   	pop    %ebx
  8016f6:	5e                   	pop    %esi
  8016f7:	5f                   	pop    %edi
  8016f8:	5d                   	pop    %ebp
  8016f9:	c3                   	ret    

008016fa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016fa:	55                   	push   %ebp
  8016fb:	89 e5                	mov    %esp,%ebp
  8016fd:	83 ec 04             	sub    $0x4,%esp
  801700:	8b 45 10             	mov    0x10(%ebp),%eax
  801703:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801706:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80170a:	8b 45 08             	mov    0x8(%ebp),%eax
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	52                   	push   %edx
  801712:	ff 75 0c             	pushl  0xc(%ebp)
  801715:	50                   	push   %eax
  801716:	6a 00                	push   $0x0
  801718:	e8 b2 ff ff ff       	call   8016cf <syscall>
  80171d:	83 c4 18             	add    $0x18,%esp
}
  801720:	90                   	nop
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_cgetc>:

int
sys_cgetc(void)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 01                	push   $0x1
  801732:	e8 98 ff ff ff       	call   8016cf <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	50                   	push   %eax
  80174b:	6a 05                	push   $0x5
  80174d:	e8 7d ff ff ff       	call   8016cf <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
}
  801755:	c9                   	leave  
  801756:	c3                   	ret    

00801757 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801757:	55                   	push   %ebp
  801758:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 02                	push   $0x2
  801766:	e8 64 ff ff ff       	call   8016cf <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 03                	push   $0x3
  80177f:	e8 4b ff ff ff       	call   8016cf <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 04                	push   $0x4
  801798:	e8 32 ff ff ff       	call   8016cf <syscall>
  80179d:	83 c4 18             	add    $0x18,%esp
}
  8017a0:	c9                   	leave  
  8017a1:	c3                   	ret    

008017a2 <sys_env_exit>:


void sys_env_exit(void)
{
  8017a2:	55                   	push   %ebp
  8017a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 06                	push   $0x6
  8017b1:	e8 19 ff ff ff       	call   8016cf <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
}
  8017b9:	90                   	nop
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	52                   	push   %edx
  8017cc:	50                   	push   %eax
  8017cd:	6a 07                	push   $0x7
  8017cf:	e8 fb fe ff ff       	call   8016cf <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
  8017dc:	56                   	push   %esi
  8017dd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017de:	8b 75 18             	mov    0x18(%ebp),%esi
  8017e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ed:	56                   	push   %esi
  8017ee:	53                   	push   %ebx
  8017ef:	51                   	push   %ecx
  8017f0:	52                   	push   %edx
  8017f1:	50                   	push   %eax
  8017f2:	6a 08                	push   $0x8
  8017f4:	e8 d6 fe ff ff       	call   8016cf <syscall>
  8017f9:	83 c4 18             	add    $0x18,%esp
}
  8017fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017ff:	5b                   	pop    %ebx
  801800:	5e                   	pop    %esi
  801801:	5d                   	pop    %ebp
  801802:	c3                   	ret    

00801803 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801806:	8b 55 0c             	mov    0xc(%ebp),%edx
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	52                   	push   %edx
  801813:	50                   	push   %eax
  801814:	6a 09                	push   $0x9
  801816:	e8 b4 fe ff ff       	call   8016cf <syscall>
  80181b:	83 c4 18             	add    $0x18,%esp
}
  80181e:	c9                   	leave  
  80181f:	c3                   	ret    

00801820 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801820:	55                   	push   %ebp
  801821:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	ff 75 0c             	pushl  0xc(%ebp)
  80182c:	ff 75 08             	pushl  0x8(%ebp)
  80182f:	6a 0a                	push   $0xa
  801831:	e8 99 fe ff ff       	call   8016cf <syscall>
  801836:	83 c4 18             	add    $0x18,%esp
}
  801839:	c9                   	leave  
  80183a:	c3                   	ret    

0080183b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80183b:	55                   	push   %ebp
  80183c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 0b                	push   $0xb
  80184a:	e8 80 fe ff ff       	call   8016cf <syscall>
  80184f:	83 c4 18             	add    $0x18,%esp
}
  801852:	c9                   	leave  
  801853:	c3                   	ret    

00801854 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801854:	55                   	push   %ebp
  801855:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 0c                	push   $0xc
  801863:	e8 67 fe ff ff       	call   8016cf <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
}
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 0d                	push   $0xd
  80187c:	e8 4e fe ff ff       	call   8016cf <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	c9                   	leave  
  801885:	c3                   	ret    

00801886 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801886:	55                   	push   %ebp
  801887:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	ff 75 0c             	pushl  0xc(%ebp)
  801892:	ff 75 08             	pushl  0x8(%ebp)
  801895:	6a 11                	push   $0x11
  801897:	e8 33 fe ff ff       	call   8016cf <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
	return;
  80189f:	90                   	nop
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	ff 75 0c             	pushl  0xc(%ebp)
  8018ae:	ff 75 08             	pushl  0x8(%ebp)
  8018b1:	6a 12                	push   $0x12
  8018b3:	e8 17 fe ff ff       	call   8016cf <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8018bb:	90                   	nop
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 0e                	push   $0xe
  8018cd:	e8 fd fd ff ff       	call   8016cf <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
}
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	ff 75 08             	pushl  0x8(%ebp)
  8018e5:	6a 0f                	push   $0xf
  8018e7:	e8 e3 fd ff ff       	call   8016cf <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 10                	push   $0x10
  801900:	e8 ca fd ff ff       	call   8016cf <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
}
  801908:	90                   	nop
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 14                	push   $0x14
  80191a:	e8 b0 fd ff ff       	call   8016cf <syscall>
  80191f:	83 c4 18             	add    $0x18,%esp
}
  801922:	90                   	nop
  801923:	c9                   	leave  
  801924:	c3                   	ret    

00801925 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801925:	55                   	push   %ebp
  801926:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 15                	push   $0x15
  801934:	e8 96 fd ff ff       	call   8016cf <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
}
  80193c:	90                   	nop
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <sys_cputc>:


void
sys_cputc(const char c)
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
  801942:	83 ec 04             	sub    $0x4,%esp
  801945:	8b 45 08             	mov    0x8(%ebp),%eax
  801948:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80194b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	50                   	push   %eax
  801958:	6a 16                	push   $0x16
  80195a:	e8 70 fd ff ff       	call   8016cf <syscall>
  80195f:	83 c4 18             	add    $0x18,%esp
}
  801962:	90                   	nop
  801963:	c9                   	leave  
  801964:	c3                   	ret    

00801965 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 17                	push   $0x17
  801974:	e8 56 fd ff ff       	call   8016cf <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	90                   	nop
  80197d:	c9                   	leave  
  80197e:	c3                   	ret    

0080197f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80197f:	55                   	push   %ebp
  801980:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	ff 75 0c             	pushl  0xc(%ebp)
  80198e:	50                   	push   %eax
  80198f:	6a 18                	push   $0x18
  801991:	e8 39 fd ff ff       	call   8016cf <syscall>
  801996:	83 c4 18             	add    $0x18,%esp
}
  801999:	c9                   	leave  
  80199a:	c3                   	ret    

0080199b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80199b:	55                   	push   %ebp
  80199c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80199e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	52                   	push   %edx
  8019ab:	50                   	push   %eax
  8019ac:	6a 1b                	push   $0x1b
  8019ae:	e8 1c fd ff ff       	call   8016cf <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
}
  8019b6:	c9                   	leave  
  8019b7:	c3                   	ret    

008019b8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019b8:	55                   	push   %ebp
  8019b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019be:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	52                   	push   %edx
  8019c8:	50                   	push   %eax
  8019c9:	6a 19                	push   $0x19
  8019cb:	e8 ff fc ff ff       	call   8016cf <syscall>
  8019d0:	83 c4 18             	add    $0x18,%esp
}
  8019d3:	90                   	nop
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	52                   	push   %edx
  8019e6:	50                   	push   %eax
  8019e7:	6a 1a                	push   $0x1a
  8019e9:	e8 e1 fc ff ff       	call   8016cf <syscall>
  8019ee:	83 c4 18             	add    $0x18,%esp
}
  8019f1:	90                   	nop
  8019f2:	c9                   	leave  
  8019f3:	c3                   	ret    

008019f4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
  8019f7:	83 ec 04             	sub    $0x4,%esp
  8019fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8019fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a00:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a03:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	6a 00                	push   $0x0
  801a0c:	51                   	push   %ecx
  801a0d:	52                   	push   %edx
  801a0e:	ff 75 0c             	pushl  0xc(%ebp)
  801a11:	50                   	push   %eax
  801a12:	6a 1c                	push   $0x1c
  801a14:	e8 b6 fc ff ff       	call   8016cf <syscall>
  801a19:	83 c4 18             	add    $0x18,%esp
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a24:	8b 45 08             	mov    0x8(%ebp),%eax
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	52                   	push   %edx
  801a2e:	50                   	push   %eax
  801a2f:	6a 1d                	push   $0x1d
  801a31:	e8 99 fc ff ff       	call   8016cf <syscall>
  801a36:	83 c4 18             	add    $0x18,%esp
}
  801a39:	c9                   	leave  
  801a3a:	c3                   	ret    

00801a3b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a3b:	55                   	push   %ebp
  801a3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a3e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	51                   	push   %ecx
  801a4c:	52                   	push   %edx
  801a4d:	50                   	push   %eax
  801a4e:	6a 1e                	push   $0x1e
  801a50:	e8 7a fc ff ff       	call   8016cf <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a60:	8b 45 08             	mov    0x8(%ebp),%eax
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	52                   	push   %edx
  801a6a:	50                   	push   %eax
  801a6b:	6a 1f                	push   $0x1f
  801a6d:	e8 5d fc ff ff       	call   8016cf <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 20                	push   $0x20
  801a86:	e8 44 fc ff ff       	call   8016cf <syscall>
  801a8b:	83 c4 18             	add    $0x18,%esp
}
  801a8e:	c9                   	leave  
  801a8f:	c3                   	ret    

00801a90 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801a90:	55                   	push   %ebp
  801a91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	ff 75 10             	pushl  0x10(%ebp)
  801a9d:	ff 75 0c             	pushl  0xc(%ebp)
  801aa0:	50                   	push   %eax
  801aa1:	6a 21                	push   $0x21
  801aa3:	e8 27 fc ff ff       	call   8016cf <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	50                   	push   %eax
  801abc:	6a 22                	push   $0x22
  801abe:	e8 0c fc ff ff       	call   8016cf <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
}
  801ac6:	90                   	nop
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801acc:	8b 45 08             	mov    0x8(%ebp),%eax
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	50                   	push   %eax
  801ad8:	6a 23                	push   $0x23
  801ada:	e8 f0 fb ff ff       	call   8016cf <syscall>
  801adf:	83 c4 18             	add    $0x18,%esp
}
  801ae2:	90                   	nop
  801ae3:	c9                   	leave  
  801ae4:	c3                   	ret    

00801ae5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ae5:	55                   	push   %ebp
  801ae6:	89 e5                	mov    %esp,%ebp
  801ae8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801aeb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801aee:	8d 50 04             	lea    0x4(%eax),%edx
  801af1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	52                   	push   %edx
  801afb:	50                   	push   %eax
  801afc:	6a 24                	push   $0x24
  801afe:	e8 cc fb ff ff       	call   8016cf <syscall>
  801b03:	83 c4 18             	add    $0x18,%esp
	return result;
  801b06:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b0c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b0f:	89 01                	mov    %eax,(%ecx)
  801b11:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b14:	8b 45 08             	mov    0x8(%ebp),%eax
  801b17:	c9                   	leave  
  801b18:	c2 04 00             	ret    $0x4

00801b1b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	ff 75 10             	pushl  0x10(%ebp)
  801b25:	ff 75 0c             	pushl  0xc(%ebp)
  801b28:	ff 75 08             	pushl  0x8(%ebp)
  801b2b:	6a 13                	push   $0x13
  801b2d:	e8 9d fb ff ff       	call   8016cf <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
	return ;
  801b35:	90                   	nop
}
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 25                	push   $0x25
  801b47:	e8 83 fb ff ff       	call   8016cf <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
  801b54:	83 ec 04             	sub    $0x4,%esp
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b5d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	50                   	push   %eax
  801b6a:	6a 26                	push   $0x26
  801b6c:	e8 5e fb ff ff       	call   8016cf <syscall>
  801b71:	83 c4 18             	add    $0x18,%esp
	return ;
  801b74:	90                   	nop
}
  801b75:	c9                   	leave  
  801b76:	c3                   	ret    

00801b77 <rsttst>:
void rsttst()
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 28                	push   $0x28
  801b86:	e8 44 fb ff ff       	call   8016cf <syscall>
  801b8b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8e:	90                   	nop
}
  801b8f:	c9                   	leave  
  801b90:	c3                   	ret    

00801b91 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
  801b94:	83 ec 04             	sub    $0x4,%esp
  801b97:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b9d:	8b 55 18             	mov    0x18(%ebp),%edx
  801ba0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ba4:	52                   	push   %edx
  801ba5:	50                   	push   %eax
  801ba6:	ff 75 10             	pushl  0x10(%ebp)
  801ba9:	ff 75 0c             	pushl  0xc(%ebp)
  801bac:	ff 75 08             	pushl  0x8(%ebp)
  801baf:	6a 27                	push   $0x27
  801bb1:	e8 19 fb ff ff       	call   8016cf <syscall>
  801bb6:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb9:	90                   	nop
}
  801bba:	c9                   	leave  
  801bbb:	c3                   	ret    

00801bbc <chktst>:
void chktst(uint32 n)
{
  801bbc:	55                   	push   %ebp
  801bbd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	ff 75 08             	pushl  0x8(%ebp)
  801bca:	6a 29                	push   $0x29
  801bcc:	e8 fe fa ff ff       	call   8016cf <syscall>
  801bd1:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd4:	90                   	nop
}
  801bd5:	c9                   	leave  
  801bd6:	c3                   	ret    

00801bd7 <inctst>:

void inctst()
{
  801bd7:	55                   	push   %ebp
  801bd8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 2a                	push   $0x2a
  801be6:	e8 e4 fa ff ff       	call   8016cf <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
	return ;
  801bee:	90                   	nop
}
  801bef:	c9                   	leave  
  801bf0:	c3                   	ret    

00801bf1 <gettst>:
uint32 gettst()
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 2b                	push   $0x2b
  801c00:	e8 ca fa ff ff       	call   8016cf <syscall>
  801c05:	83 c4 18             	add    $0x18,%esp
}
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 2c                	push   $0x2c
  801c1c:	e8 ae fa ff ff       	call   8016cf <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
  801c24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c27:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c2b:	75 07                	jne    801c34 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c2d:	b8 01 00 00 00       	mov    $0x1,%eax
  801c32:	eb 05                	jmp    801c39 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c34:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c39:	c9                   	leave  
  801c3a:	c3                   	ret    

00801c3b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
  801c3e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 2c                	push   $0x2c
  801c4d:	e8 7d fa ff ff       	call   8016cf <syscall>
  801c52:	83 c4 18             	add    $0x18,%esp
  801c55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c58:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c5c:	75 07                	jne    801c65 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c63:	eb 05                	jmp    801c6a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c65:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c6a:	c9                   	leave  
  801c6b:	c3                   	ret    

00801c6c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
  801c6f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 2c                	push   $0x2c
  801c7e:	e8 4c fa ff ff       	call   8016cf <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
  801c86:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c89:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c8d:	75 07                	jne    801c96 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c8f:	b8 01 00 00 00       	mov    $0x1,%eax
  801c94:	eb 05                	jmp    801c9b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c96:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
  801ca0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 2c                	push   $0x2c
  801caf:	e8 1b fa ff ff       	call   8016cf <syscall>
  801cb4:	83 c4 18             	add    $0x18,%esp
  801cb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cba:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cbe:	75 07                	jne    801cc7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cc0:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc5:	eb 05                	jmp    801ccc <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cc7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	ff 75 08             	pushl  0x8(%ebp)
  801cdc:	6a 2d                	push   $0x2d
  801cde:	e8 ec f9 ff ff       	call   8016cf <syscall>
  801ce3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ce6:	90                   	nop
}
  801ce7:	c9                   	leave  
  801ce8:	c3                   	ret    
  801ce9:	66 90                	xchg   %ax,%ax
  801ceb:	90                   	nop

00801cec <__udivdi3>:
  801cec:	55                   	push   %ebp
  801ced:	57                   	push   %edi
  801cee:	56                   	push   %esi
  801cef:	53                   	push   %ebx
  801cf0:	83 ec 1c             	sub    $0x1c,%esp
  801cf3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cf7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cfb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d03:	89 ca                	mov    %ecx,%edx
  801d05:	89 f8                	mov    %edi,%eax
  801d07:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d0b:	85 f6                	test   %esi,%esi
  801d0d:	75 2d                	jne    801d3c <__udivdi3+0x50>
  801d0f:	39 cf                	cmp    %ecx,%edi
  801d11:	77 65                	ja     801d78 <__udivdi3+0x8c>
  801d13:	89 fd                	mov    %edi,%ebp
  801d15:	85 ff                	test   %edi,%edi
  801d17:	75 0b                	jne    801d24 <__udivdi3+0x38>
  801d19:	b8 01 00 00 00       	mov    $0x1,%eax
  801d1e:	31 d2                	xor    %edx,%edx
  801d20:	f7 f7                	div    %edi
  801d22:	89 c5                	mov    %eax,%ebp
  801d24:	31 d2                	xor    %edx,%edx
  801d26:	89 c8                	mov    %ecx,%eax
  801d28:	f7 f5                	div    %ebp
  801d2a:	89 c1                	mov    %eax,%ecx
  801d2c:	89 d8                	mov    %ebx,%eax
  801d2e:	f7 f5                	div    %ebp
  801d30:	89 cf                	mov    %ecx,%edi
  801d32:	89 fa                	mov    %edi,%edx
  801d34:	83 c4 1c             	add    $0x1c,%esp
  801d37:	5b                   	pop    %ebx
  801d38:	5e                   	pop    %esi
  801d39:	5f                   	pop    %edi
  801d3a:	5d                   	pop    %ebp
  801d3b:	c3                   	ret    
  801d3c:	39 ce                	cmp    %ecx,%esi
  801d3e:	77 28                	ja     801d68 <__udivdi3+0x7c>
  801d40:	0f bd fe             	bsr    %esi,%edi
  801d43:	83 f7 1f             	xor    $0x1f,%edi
  801d46:	75 40                	jne    801d88 <__udivdi3+0x9c>
  801d48:	39 ce                	cmp    %ecx,%esi
  801d4a:	72 0a                	jb     801d56 <__udivdi3+0x6a>
  801d4c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d50:	0f 87 9e 00 00 00    	ja     801df4 <__udivdi3+0x108>
  801d56:	b8 01 00 00 00       	mov    $0x1,%eax
  801d5b:	89 fa                	mov    %edi,%edx
  801d5d:	83 c4 1c             	add    $0x1c,%esp
  801d60:	5b                   	pop    %ebx
  801d61:	5e                   	pop    %esi
  801d62:	5f                   	pop    %edi
  801d63:	5d                   	pop    %ebp
  801d64:	c3                   	ret    
  801d65:	8d 76 00             	lea    0x0(%esi),%esi
  801d68:	31 ff                	xor    %edi,%edi
  801d6a:	31 c0                	xor    %eax,%eax
  801d6c:	89 fa                	mov    %edi,%edx
  801d6e:	83 c4 1c             	add    $0x1c,%esp
  801d71:	5b                   	pop    %ebx
  801d72:	5e                   	pop    %esi
  801d73:	5f                   	pop    %edi
  801d74:	5d                   	pop    %ebp
  801d75:	c3                   	ret    
  801d76:	66 90                	xchg   %ax,%ax
  801d78:	89 d8                	mov    %ebx,%eax
  801d7a:	f7 f7                	div    %edi
  801d7c:	31 ff                	xor    %edi,%edi
  801d7e:	89 fa                	mov    %edi,%edx
  801d80:	83 c4 1c             	add    $0x1c,%esp
  801d83:	5b                   	pop    %ebx
  801d84:	5e                   	pop    %esi
  801d85:	5f                   	pop    %edi
  801d86:	5d                   	pop    %ebp
  801d87:	c3                   	ret    
  801d88:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d8d:	89 eb                	mov    %ebp,%ebx
  801d8f:	29 fb                	sub    %edi,%ebx
  801d91:	89 f9                	mov    %edi,%ecx
  801d93:	d3 e6                	shl    %cl,%esi
  801d95:	89 c5                	mov    %eax,%ebp
  801d97:	88 d9                	mov    %bl,%cl
  801d99:	d3 ed                	shr    %cl,%ebp
  801d9b:	89 e9                	mov    %ebp,%ecx
  801d9d:	09 f1                	or     %esi,%ecx
  801d9f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801da3:	89 f9                	mov    %edi,%ecx
  801da5:	d3 e0                	shl    %cl,%eax
  801da7:	89 c5                	mov    %eax,%ebp
  801da9:	89 d6                	mov    %edx,%esi
  801dab:	88 d9                	mov    %bl,%cl
  801dad:	d3 ee                	shr    %cl,%esi
  801daf:	89 f9                	mov    %edi,%ecx
  801db1:	d3 e2                	shl    %cl,%edx
  801db3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801db7:	88 d9                	mov    %bl,%cl
  801db9:	d3 e8                	shr    %cl,%eax
  801dbb:	09 c2                	or     %eax,%edx
  801dbd:	89 d0                	mov    %edx,%eax
  801dbf:	89 f2                	mov    %esi,%edx
  801dc1:	f7 74 24 0c          	divl   0xc(%esp)
  801dc5:	89 d6                	mov    %edx,%esi
  801dc7:	89 c3                	mov    %eax,%ebx
  801dc9:	f7 e5                	mul    %ebp
  801dcb:	39 d6                	cmp    %edx,%esi
  801dcd:	72 19                	jb     801de8 <__udivdi3+0xfc>
  801dcf:	74 0b                	je     801ddc <__udivdi3+0xf0>
  801dd1:	89 d8                	mov    %ebx,%eax
  801dd3:	31 ff                	xor    %edi,%edi
  801dd5:	e9 58 ff ff ff       	jmp    801d32 <__udivdi3+0x46>
  801dda:	66 90                	xchg   %ax,%ax
  801ddc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801de0:	89 f9                	mov    %edi,%ecx
  801de2:	d3 e2                	shl    %cl,%edx
  801de4:	39 c2                	cmp    %eax,%edx
  801de6:	73 e9                	jae    801dd1 <__udivdi3+0xe5>
  801de8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801deb:	31 ff                	xor    %edi,%edi
  801ded:	e9 40 ff ff ff       	jmp    801d32 <__udivdi3+0x46>
  801df2:	66 90                	xchg   %ax,%ax
  801df4:	31 c0                	xor    %eax,%eax
  801df6:	e9 37 ff ff ff       	jmp    801d32 <__udivdi3+0x46>
  801dfb:	90                   	nop

00801dfc <__umoddi3>:
  801dfc:	55                   	push   %ebp
  801dfd:	57                   	push   %edi
  801dfe:	56                   	push   %esi
  801dff:	53                   	push   %ebx
  801e00:	83 ec 1c             	sub    $0x1c,%esp
  801e03:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e07:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e0f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e13:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e17:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e1b:	89 f3                	mov    %esi,%ebx
  801e1d:	89 fa                	mov    %edi,%edx
  801e1f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e23:	89 34 24             	mov    %esi,(%esp)
  801e26:	85 c0                	test   %eax,%eax
  801e28:	75 1a                	jne    801e44 <__umoddi3+0x48>
  801e2a:	39 f7                	cmp    %esi,%edi
  801e2c:	0f 86 a2 00 00 00    	jbe    801ed4 <__umoddi3+0xd8>
  801e32:	89 c8                	mov    %ecx,%eax
  801e34:	89 f2                	mov    %esi,%edx
  801e36:	f7 f7                	div    %edi
  801e38:	89 d0                	mov    %edx,%eax
  801e3a:	31 d2                	xor    %edx,%edx
  801e3c:	83 c4 1c             	add    $0x1c,%esp
  801e3f:	5b                   	pop    %ebx
  801e40:	5e                   	pop    %esi
  801e41:	5f                   	pop    %edi
  801e42:	5d                   	pop    %ebp
  801e43:	c3                   	ret    
  801e44:	39 f0                	cmp    %esi,%eax
  801e46:	0f 87 ac 00 00 00    	ja     801ef8 <__umoddi3+0xfc>
  801e4c:	0f bd e8             	bsr    %eax,%ebp
  801e4f:	83 f5 1f             	xor    $0x1f,%ebp
  801e52:	0f 84 ac 00 00 00    	je     801f04 <__umoddi3+0x108>
  801e58:	bf 20 00 00 00       	mov    $0x20,%edi
  801e5d:	29 ef                	sub    %ebp,%edi
  801e5f:	89 fe                	mov    %edi,%esi
  801e61:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e65:	89 e9                	mov    %ebp,%ecx
  801e67:	d3 e0                	shl    %cl,%eax
  801e69:	89 d7                	mov    %edx,%edi
  801e6b:	89 f1                	mov    %esi,%ecx
  801e6d:	d3 ef                	shr    %cl,%edi
  801e6f:	09 c7                	or     %eax,%edi
  801e71:	89 e9                	mov    %ebp,%ecx
  801e73:	d3 e2                	shl    %cl,%edx
  801e75:	89 14 24             	mov    %edx,(%esp)
  801e78:	89 d8                	mov    %ebx,%eax
  801e7a:	d3 e0                	shl    %cl,%eax
  801e7c:	89 c2                	mov    %eax,%edx
  801e7e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e82:	d3 e0                	shl    %cl,%eax
  801e84:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e88:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e8c:	89 f1                	mov    %esi,%ecx
  801e8e:	d3 e8                	shr    %cl,%eax
  801e90:	09 d0                	or     %edx,%eax
  801e92:	d3 eb                	shr    %cl,%ebx
  801e94:	89 da                	mov    %ebx,%edx
  801e96:	f7 f7                	div    %edi
  801e98:	89 d3                	mov    %edx,%ebx
  801e9a:	f7 24 24             	mull   (%esp)
  801e9d:	89 c6                	mov    %eax,%esi
  801e9f:	89 d1                	mov    %edx,%ecx
  801ea1:	39 d3                	cmp    %edx,%ebx
  801ea3:	0f 82 87 00 00 00    	jb     801f30 <__umoddi3+0x134>
  801ea9:	0f 84 91 00 00 00    	je     801f40 <__umoddi3+0x144>
  801eaf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eb3:	29 f2                	sub    %esi,%edx
  801eb5:	19 cb                	sbb    %ecx,%ebx
  801eb7:	89 d8                	mov    %ebx,%eax
  801eb9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ebd:	d3 e0                	shl    %cl,%eax
  801ebf:	89 e9                	mov    %ebp,%ecx
  801ec1:	d3 ea                	shr    %cl,%edx
  801ec3:	09 d0                	or     %edx,%eax
  801ec5:	89 e9                	mov    %ebp,%ecx
  801ec7:	d3 eb                	shr    %cl,%ebx
  801ec9:	89 da                	mov    %ebx,%edx
  801ecb:	83 c4 1c             	add    $0x1c,%esp
  801ece:	5b                   	pop    %ebx
  801ecf:	5e                   	pop    %esi
  801ed0:	5f                   	pop    %edi
  801ed1:	5d                   	pop    %ebp
  801ed2:	c3                   	ret    
  801ed3:	90                   	nop
  801ed4:	89 fd                	mov    %edi,%ebp
  801ed6:	85 ff                	test   %edi,%edi
  801ed8:	75 0b                	jne    801ee5 <__umoddi3+0xe9>
  801eda:	b8 01 00 00 00       	mov    $0x1,%eax
  801edf:	31 d2                	xor    %edx,%edx
  801ee1:	f7 f7                	div    %edi
  801ee3:	89 c5                	mov    %eax,%ebp
  801ee5:	89 f0                	mov    %esi,%eax
  801ee7:	31 d2                	xor    %edx,%edx
  801ee9:	f7 f5                	div    %ebp
  801eeb:	89 c8                	mov    %ecx,%eax
  801eed:	f7 f5                	div    %ebp
  801eef:	89 d0                	mov    %edx,%eax
  801ef1:	e9 44 ff ff ff       	jmp    801e3a <__umoddi3+0x3e>
  801ef6:	66 90                	xchg   %ax,%ax
  801ef8:	89 c8                	mov    %ecx,%eax
  801efa:	89 f2                	mov    %esi,%edx
  801efc:	83 c4 1c             	add    $0x1c,%esp
  801eff:	5b                   	pop    %ebx
  801f00:	5e                   	pop    %esi
  801f01:	5f                   	pop    %edi
  801f02:	5d                   	pop    %ebp
  801f03:	c3                   	ret    
  801f04:	3b 04 24             	cmp    (%esp),%eax
  801f07:	72 06                	jb     801f0f <__umoddi3+0x113>
  801f09:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f0d:	77 0f                	ja     801f1e <__umoddi3+0x122>
  801f0f:	89 f2                	mov    %esi,%edx
  801f11:	29 f9                	sub    %edi,%ecx
  801f13:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f17:	89 14 24             	mov    %edx,(%esp)
  801f1a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f1e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f22:	8b 14 24             	mov    (%esp),%edx
  801f25:	83 c4 1c             	add    $0x1c,%esp
  801f28:	5b                   	pop    %ebx
  801f29:	5e                   	pop    %esi
  801f2a:	5f                   	pop    %edi
  801f2b:	5d                   	pop    %ebp
  801f2c:	c3                   	ret    
  801f2d:	8d 76 00             	lea    0x0(%esi),%esi
  801f30:	2b 04 24             	sub    (%esp),%eax
  801f33:	19 fa                	sbb    %edi,%edx
  801f35:	89 d1                	mov    %edx,%ecx
  801f37:	89 c6                	mov    %eax,%esi
  801f39:	e9 71 ff ff ff       	jmp    801eaf <__umoddi3+0xb3>
  801f3e:	66 90                	xchg   %ax,%ax
  801f40:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f44:	72 ea                	jb     801f30 <__umoddi3+0x134>
  801f46:	89 d9                	mov    %ebx,%ecx
  801f48:	e9 62 ff ff ff       	jmp    801eaf <__umoddi3+0xb3>
