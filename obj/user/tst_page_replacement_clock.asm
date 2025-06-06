
obj/user/tst_page_replacement_clock:     file format elf32-i386


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
  800031:	e8 91 04 00 00       	call   8004c7 <libmain>
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
  800060:	68 a0 1e 80 00       	push   $0x801ea0
  800065:	6a 15                	push   $0x15
  800067:	68 e4 1e 80 00       	push   $0x801ee4
  80006c:	e8 58 05 00 00       	call   8005c9 <_panic>
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
  800096:	68 a0 1e 80 00       	push   $0x801ea0
  80009b:	6a 16                	push   $0x16
  80009d:	68 e4 1e 80 00       	push   $0x801ee4
  8000a2:	e8 22 05 00 00       	call   8005c9 <_panic>
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
  8000cc:	68 a0 1e 80 00       	push   $0x801ea0
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 e4 1e 80 00       	push   $0x801ee4
  8000d8:	e8 ec 04 00 00       	call   8005c9 <_panic>
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
  800102:	68 a0 1e 80 00       	push   $0x801ea0
  800107:	6a 18                	push   $0x18
  800109:	68 e4 1e 80 00       	push   $0x801ee4
  80010e:	e8 b6 04 00 00       	call   8005c9 <_panic>
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
  800138:	68 a0 1e 80 00       	push   $0x801ea0
  80013d:	6a 19                	push   $0x19
  80013f:	68 e4 1e 80 00       	push   $0x801ee4
  800144:	e8 80 04 00 00       	call   8005c9 <_panic>
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
  80016e:	68 a0 1e 80 00       	push   $0x801ea0
  800173:	6a 1a                	push   $0x1a
  800175:	68 e4 1e 80 00       	push   $0x801ee4
  80017a:	e8 4a 04 00 00       	call   8005c9 <_panic>
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
  8001a4:	68 a0 1e 80 00       	push   $0x801ea0
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 e4 1e 80 00       	push   $0x801ee4
  8001b0:	e8 14 04 00 00       	call   8005c9 <_panic>
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
  8001da:	68 a0 1e 80 00       	push   $0x801ea0
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 e4 1e 80 00       	push   $0x801ee4
  8001e6:	e8 de 03 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f6:	83 c0 60             	add    $0x60,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 a0 1e 80 00       	push   $0x801ea0
  800215:	6a 1d                	push   $0x1d
  800217:	68 e4 1e 80 00       	push   $0x801ee4
  80021c:	e8 a8 03 00 00       	call   8005c9 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80022c:	85 c0                	test   %eax,%eax
  80022e:	74 14                	je     800244 <_main+0x20c>
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 08 1f 80 00       	push   $0x801f08
  800238:	6a 1e                	push   $0x1e
  80023a:	68 e4 1e 80 00       	push   $0x801ee4
  80023f:	e8 85 03 00 00       	call   8005c9 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  800244:	e8 2a 15 00 00       	call   801773 <sys_calculate_free_frames>
  800249:	89 45 cc             	mov    %eax,-0x34(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80024c:	e8 a5 15 00 00       	call   8017f6 <sys_pf_calculate_allocated_pages>
  800251:	89 45 c8             	mov    %eax,-0x38(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  800254:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800259:	88 45 c7             	mov    %al,-0x39(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  80025c:	a0 3f f0 80 00       	mov    0x80f03f,%al
  800261:	88 45 c6             	mov    %al,-0x3a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800264:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80026b:	eb 37                	jmp    8002a4 <_main+0x26c>
	{
		arr[i] = -1 ;
  80026d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800270:	05 40 30 80 00       	add    $0x803040,%eax
  800275:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  800278:	a1 04 30 80 00       	mov    0x803004,%eax
  80027d:	8b 15 00 30 80 00    	mov    0x803000,%edx
  800283:	8a 12                	mov    (%edx),%dl
  800285:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800287:	a1 00 30 80 00       	mov    0x803000,%eax
  80028c:	40                   	inc    %eax
  80028d:	a3 00 30 80 00       	mov    %eax,0x803000
  800292:	a1 04 30 80 00       	mov    0x803004,%eax
  800297:	40                   	inc    %eax
  800298:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80029d:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8002a4:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8002ab:	7e c0                	jle    80026d <_main+0x235>

	//===================

	//cprintf("Checking PAGE CLOCK algorithm... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8002ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b2:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002b8:	8b 00                	mov    (%eax),%eax
  8002ba:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8002bd:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002c5:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002ca:	74 14                	je     8002e0 <_main+0x2a8>
  8002cc:	83 ec 04             	sub    $0x4,%esp
  8002cf:	68 50 1f 80 00       	push   $0x801f50
  8002d4:	6a 3a                	push   $0x3a
  8002d6:	68 e4 1e 80 00       	push   $0x801ee4
  8002db:	e8 e9 02 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8002e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e5:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002eb:	83 c0 0c             	add    $0xc,%eax
  8002ee:	8b 00                	mov    (%eax),%eax
  8002f0:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8002f3:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002fb:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800300:	74 14                	je     800316 <_main+0x2de>
  800302:	83 ec 04             	sub    $0x4,%esp
  800305:	68 50 1f 80 00       	push   $0x801f50
  80030a:	6a 3b                	push   $0x3b
  80030c:	68 e4 1e 80 00       	push   $0x801ee4
  800311:	e8 b3 02 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  800316:	a1 20 30 80 00       	mov    0x803020,%eax
  80031b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800321:	83 c0 18             	add    $0x18,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800329:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80032c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800331:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800336:	74 14                	je     80034c <_main+0x314>
  800338:	83 ec 04             	sub    $0x4,%esp
  80033b:	68 50 1f 80 00       	push   $0x801f50
  800340:	6a 3c                	push   $0x3c
  800342:	68 e4 1e 80 00       	push   $0x801ee4
  800347:	e8 7d 02 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  80034c:	a1 20 30 80 00       	mov    0x803020,%eax
  800351:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800357:	83 c0 24             	add    $0x24,%eax
  80035a:	8b 00                	mov    (%eax),%eax
  80035c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80035f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800362:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800367:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80036c:	74 14                	je     800382 <_main+0x34a>
  80036e:	83 ec 04             	sub    $0x4,%esp
  800371:	68 50 1f 80 00       	push   $0x801f50
  800376:	6a 3d                	push   $0x3d
  800378:	68 e4 1e 80 00       	push   $0x801ee4
  80037d:	e8 47 02 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x809000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  800382:	a1 20 30 80 00       	mov    0x803020,%eax
  800387:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80038d:	83 c0 30             	add    $0x30,%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800395:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800398:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039d:	3d 00 90 80 00       	cmp    $0x809000,%eax
  8003a2:	74 14                	je     8003b8 <_main+0x380>
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 50 1f 80 00       	push   $0x801f50
  8003ac:	6a 3e                	push   $0x3e
  8003ae:	68 e4 1e 80 00       	push   $0x801ee4
  8003b3:	e8 11 02 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8003b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003c3:	83 c0 3c             	add    $0x3c,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8003cb:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d3:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  8003d8:	74 14                	je     8003ee <_main+0x3b6>
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 50 1f 80 00       	push   $0x801f50
  8003e2:	6a 3f                	push   $0x3f
  8003e4:	68 e4 1e 80 00       	push   $0x801ee4
  8003e9:	e8 db 01 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003f9:	83 c0 48             	add    $0x48,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800401:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800404:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800409:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  80040e:	74 14                	je     800424 <_main+0x3ec>
  800410:	83 ec 04             	sub    $0x4,%esp
  800413:	68 50 1f 80 00       	push   $0x801f50
  800418:	6a 40                	push   $0x40
  80041a:	68 e4 1e 80 00       	push   $0x801ee4
  80041f:	e8 a5 01 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  800424:	a1 20 30 80 00       	mov    0x803020,%eax
  800429:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80042f:	83 c0 54             	add    $0x54,%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800437:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80043a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80043f:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800444:	74 14                	je     80045a <_main+0x422>
  800446:	83 ec 04             	sub    $0x4,%esp
  800449:	68 50 1f 80 00       	push   $0x801f50
  80044e:	6a 41                	push   $0x41
  800450:	68 e4 1e 80 00       	push   $0x801ee4
  800455:	e8 6f 01 00 00       	call   8005c9 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  80045a:	a1 20 30 80 00       	mov    0x803020,%eax
  80045f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800465:	83 c0 60             	add    $0x60,%eax
  800468:	8b 00                	mov    (%eax),%eax
  80046a:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80046d:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800470:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800475:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80047a:	74 14                	je     800490 <_main+0x458>
  80047c:	83 ec 04             	sub    $0x4,%esp
  80047f:	68 50 1f 80 00       	push   $0x801f50
  800484:	6a 42                	push   $0x42
  800486:	68 e4 1e 80 00       	push   $0x801ee4
  80048b:	e8 39 01 00 00       	call   8005c9 <_panic>

		if(myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
  800490:	a1 20 30 80 00       	mov    0x803020,%eax
  800495:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  80049b:	83 f8 02             	cmp    $0x2,%eax
  80049e:	74 14                	je     8004b4 <_main+0x47c>
  8004a0:	83 ec 04             	sub    $0x4,%esp
  8004a3:	68 a0 1f 80 00       	push   $0x801fa0
  8004a8:	6a 44                	push   $0x44
  8004aa:	68 e4 1e 80 00       	push   $0x801ee4
  8004af:	e8 15 01 00 00       	call   8005c9 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [CLOCK Alg.] is completed successfully.\n");
  8004b4:	83 ec 0c             	sub    $0xc,%esp
  8004b7:	68 c0 1f 80 00       	push   $0x801fc0
  8004bc:	e8 bc 03 00 00       	call   80087d <cprintf>
  8004c1:	83 c4 10             	add    $0x10,%esp
	return;
  8004c4:	90                   	nop
}
  8004c5:	c9                   	leave  
  8004c6:	c3                   	ret    

008004c7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8004c7:	55                   	push   %ebp
  8004c8:	89 e5                	mov    %esp,%ebp
  8004ca:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8004cd:	e8 d6 11 00 00       	call   8016a8 <sys_getenvindex>
  8004d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8004d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004d8:	89 d0                	mov    %edx,%eax
  8004da:	01 c0                	add    %eax,%eax
  8004dc:	01 d0                	add    %edx,%eax
  8004de:	c1 e0 02             	shl    $0x2,%eax
  8004e1:	01 d0                	add    %edx,%eax
  8004e3:	c1 e0 06             	shl    $0x6,%eax
  8004e6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8004eb:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8004fb:	84 c0                	test   %al,%al
  8004fd:	74 0f                	je     80050e <libmain+0x47>
		binaryname = myEnv->prog_name;
  8004ff:	a1 20 30 80 00       	mov    0x803020,%eax
  800504:	05 f4 02 00 00       	add    $0x2f4,%eax
  800509:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80050e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800512:	7e 0a                	jle    80051e <libmain+0x57>
		binaryname = argv[0];
  800514:	8b 45 0c             	mov    0xc(%ebp),%eax
  800517:	8b 00                	mov    (%eax),%eax
  800519:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80051e:	83 ec 08             	sub    $0x8,%esp
  800521:	ff 75 0c             	pushl  0xc(%ebp)
  800524:	ff 75 08             	pushl  0x8(%ebp)
  800527:	e8 0c fb ff ff       	call   800038 <_main>
  80052c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80052f:	e8 0f 13 00 00       	call   801843 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800534:	83 ec 0c             	sub    $0xc,%esp
  800537:	68 2c 20 80 00       	push   $0x80202c
  80053c:	e8 3c 03 00 00       	call   80087d <cprintf>
  800541:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800544:	a1 20 30 80 00       	mov    0x803020,%eax
  800549:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80054f:	a1 20 30 80 00       	mov    0x803020,%eax
  800554:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80055a:	83 ec 04             	sub    $0x4,%esp
  80055d:	52                   	push   %edx
  80055e:	50                   	push   %eax
  80055f:	68 54 20 80 00       	push   $0x802054
  800564:	e8 14 03 00 00       	call   80087d <cprintf>
  800569:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80056c:	a1 20 30 80 00       	mov    0x803020,%eax
  800571:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800577:	83 ec 08             	sub    $0x8,%esp
  80057a:	50                   	push   %eax
  80057b:	68 79 20 80 00       	push   $0x802079
  800580:	e8 f8 02 00 00       	call   80087d <cprintf>
  800585:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800588:	83 ec 0c             	sub    $0xc,%esp
  80058b:	68 2c 20 80 00       	push   $0x80202c
  800590:	e8 e8 02 00 00       	call   80087d <cprintf>
  800595:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800598:	e8 c0 12 00 00       	call   80185d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80059d:	e8 19 00 00 00       	call   8005bb <exit>
}
  8005a2:	90                   	nop
  8005a3:	c9                   	leave  
  8005a4:	c3                   	ret    

008005a5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8005a5:	55                   	push   %ebp
  8005a6:	89 e5                	mov    %esp,%ebp
  8005a8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8005ab:	83 ec 0c             	sub    $0xc,%esp
  8005ae:	6a 00                	push   $0x0
  8005b0:	e8 bf 10 00 00       	call   801674 <sys_env_destroy>
  8005b5:	83 c4 10             	add    $0x10,%esp
}
  8005b8:	90                   	nop
  8005b9:	c9                   	leave  
  8005ba:	c3                   	ret    

008005bb <exit>:

void
exit(void)
{
  8005bb:	55                   	push   %ebp
  8005bc:	89 e5                	mov    %esp,%ebp
  8005be:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8005c1:	e8 14 11 00 00       	call   8016da <sys_env_exit>
}
  8005c6:	90                   	nop
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
  8005cc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8005cf:	8d 45 10             	lea    0x10(%ebp),%eax
  8005d2:	83 c0 04             	add    $0x4,%eax
  8005d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8005d8:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8005dd:	85 c0                	test   %eax,%eax
  8005df:	74 16                	je     8005f7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8005e1:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8005e6:	83 ec 08             	sub    $0x8,%esp
  8005e9:	50                   	push   %eax
  8005ea:	68 90 20 80 00       	push   $0x802090
  8005ef:	e8 89 02 00 00       	call   80087d <cprintf>
  8005f4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8005f7:	a1 08 30 80 00       	mov    0x803008,%eax
  8005fc:	ff 75 0c             	pushl  0xc(%ebp)
  8005ff:	ff 75 08             	pushl  0x8(%ebp)
  800602:	50                   	push   %eax
  800603:	68 95 20 80 00       	push   $0x802095
  800608:	e8 70 02 00 00       	call   80087d <cprintf>
  80060d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800610:	8b 45 10             	mov    0x10(%ebp),%eax
  800613:	83 ec 08             	sub    $0x8,%esp
  800616:	ff 75 f4             	pushl  -0xc(%ebp)
  800619:	50                   	push   %eax
  80061a:	e8 f3 01 00 00       	call   800812 <vcprintf>
  80061f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800622:	83 ec 08             	sub    $0x8,%esp
  800625:	6a 00                	push   $0x0
  800627:	68 b1 20 80 00       	push   $0x8020b1
  80062c:	e8 e1 01 00 00       	call   800812 <vcprintf>
  800631:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800634:	e8 82 ff ff ff       	call   8005bb <exit>

	// should not return here
	while (1) ;
  800639:	eb fe                	jmp    800639 <_panic+0x70>

0080063b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80063b:	55                   	push   %ebp
  80063c:	89 e5                	mov    %esp,%ebp
  80063e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800641:	a1 20 30 80 00       	mov    0x803020,%eax
  800646:	8b 50 74             	mov    0x74(%eax),%edx
  800649:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064c:	39 c2                	cmp    %eax,%edx
  80064e:	74 14                	je     800664 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800650:	83 ec 04             	sub    $0x4,%esp
  800653:	68 b4 20 80 00       	push   $0x8020b4
  800658:	6a 26                	push   $0x26
  80065a:	68 00 21 80 00       	push   $0x802100
  80065f:	e8 65 ff ff ff       	call   8005c9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800664:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80066b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800672:	e9 c2 00 00 00       	jmp    800739 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800677:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	01 d0                	add    %edx,%eax
  800686:	8b 00                	mov    (%eax),%eax
  800688:	85 c0                	test   %eax,%eax
  80068a:	75 08                	jne    800694 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80068c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80068f:	e9 a2 00 00 00       	jmp    800736 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800694:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80069b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8006a2:	eb 69                	jmp    80070d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8006a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8006af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006b2:	89 d0                	mov    %edx,%eax
  8006b4:	01 c0                	add    %eax,%eax
  8006b6:	01 d0                	add    %edx,%eax
  8006b8:	c1 e0 02             	shl    $0x2,%eax
  8006bb:	01 c8                	add    %ecx,%eax
  8006bd:	8a 40 04             	mov    0x4(%eax),%al
  8006c0:	84 c0                	test   %al,%al
  8006c2:	75 46                	jne    80070a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c9:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8006cf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006d2:	89 d0                	mov    %edx,%eax
  8006d4:	01 c0                	add    %eax,%eax
  8006d6:	01 d0                	add    %edx,%eax
  8006d8:	c1 e0 02             	shl    $0x2,%eax
  8006db:	01 c8                	add    %ecx,%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8006e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006e5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006ea:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8006ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f9:	01 c8                	add    %ecx,%eax
  8006fb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006fd:	39 c2                	cmp    %eax,%edx
  8006ff:	75 09                	jne    80070a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800701:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800708:	eb 12                	jmp    80071c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80070a:	ff 45 e8             	incl   -0x18(%ebp)
  80070d:	a1 20 30 80 00       	mov    0x803020,%eax
  800712:	8b 50 74             	mov    0x74(%eax),%edx
  800715:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800718:	39 c2                	cmp    %eax,%edx
  80071a:	77 88                	ja     8006a4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80071c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800720:	75 14                	jne    800736 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800722:	83 ec 04             	sub    $0x4,%esp
  800725:	68 0c 21 80 00       	push   $0x80210c
  80072a:	6a 3a                	push   $0x3a
  80072c:	68 00 21 80 00       	push   $0x802100
  800731:	e8 93 fe ff ff       	call   8005c9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800736:	ff 45 f0             	incl   -0x10(%ebp)
  800739:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80073f:	0f 8c 32 ff ff ff    	jl     800677 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800745:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80074c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800753:	eb 26                	jmp    80077b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800755:	a1 20 30 80 00       	mov    0x803020,%eax
  80075a:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800760:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800763:	89 d0                	mov    %edx,%eax
  800765:	01 c0                	add    %eax,%eax
  800767:	01 d0                	add    %edx,%eax
  800769:	c1 e0 02             	shl    $0x2,%eax
  80076c:	01 c8                	add    %ecx,%eax
  80076e:	8a 40 04             	mov    0x4(%eax),%al
  800771:	3c 01                	cmp    $0x1,%al
  800773:	75 03                	jne    800778 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800775:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800778:	ff 45 e0             	incl   -0x20(%ebp)
  80077b:	a1 20 30 80 00       	mov    0x803020,%eax
  800780:	8b 50 74             	mov    0x74(%eax),%edx
  800783:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800786:	39 c2                	cmp    %eax,%edx
  800788:	77 cb                	ja     800755 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80078a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80078d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800790:	74 14                	je     8007a6 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800792:	83 ec 04             	sub    $0x4,%esp
  800795:	68 60 21 80 00       	push   $0x802160
  80079a:	6a 44                	push   $0x44
  80079c:	68 00 21 80 00       	push   $0x802100
  8007a1:	e8 23 fe ff ff       	call   8005c9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8007a6:	90                   	nop
  8007a7:	c9                   	leave  
  8007a8:	c3                   	ret    

008007a9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8007af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	8d 48 01             	lea    0x1(%eax),%ecx
  8007b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007ba:	89 0a                	mov    %ecx,(%edx)
  8007bc:	8b 55 08             	mov    0x8(%ebp),%edx
  8007bf:	88 d1                	mov    %dl,%cl
  8007c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007c4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8007c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8007d2:	75 2c                	jne    800800 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8007d4:	a0 24 30 80 00       	mov    0x803024,%al
  8007d9:	0f b6 c0             	movzbl %al,%eax
  8007dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007df:	8b 12                	mov    (%edx),%edx
  8007e1:	89 d1                	mov    %edx,%ecx
  8007e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007e6:	83 c2 08             	add    $0x8,%edx
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	50                   	push   %eax
  8007ed:	51                   	push   %ecx
  8007ee:	52                   	push   %edx
  8007ef:	e8 3e 0e 00 00       	call   801632 <sys_cputs>
  8007f4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8007f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007fa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800800:	8b 45 0c             	mov    0xc(%ebp),%eax
  800803:	8b 40 04             	mov    0x4(%eax),%eax
  800806:	8d 50 01             	lea    0x1(%eax),%edx
  800809:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80080f:	90                   	nop
  800810:	c9                   	leave  
  800811:	c3                   	ret    

00800812 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800812:	55                   	push   %ebp
  800813:	89 e5                	mov    %esp,%ebp
  800815:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80081b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800822:	00 00 00 
	b.cnt = 0;
  800825:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80082c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80082f:	ff 75 0c             	pushl  0xc(%ebp)
  800832:	ff 75 08             	pushl  0x8(%ebp)
  800835:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80083b:	50                   	push   %eax
  80083c:	68 a9 07 80 00       	push   $0x8007a9
  800841:	e8 11 02 00 00       	call   800a57 <vprintfmt>
  800846:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800849:	a0 24 30 80 00       	mov    0x803024,%al
  80084e:	0f b6 c0             	movzbl %al,%eax
  800851:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800857:	83 ec 04             	sub    $0x4,%esp
  80085a:	50                   	push   %eax
  80085b:	52                   	push   %edx
  80085c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800862:	83 c0 08             	add    $0x8,%eax
  800865:	50                   	push   %eax
  800866:	e8 c7 0d 00 00       	call   801632 <sys_cputs>
  80086b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80086e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800875:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80087b:	c9                   	leave  
  80087c:	c3                   	ret    

0080087d <cprintf>:

int cprintf(const char *fmt, ...) {
  80087d:	55                   	push   %ebp
  80087e:	89 e5                	mov    %esp,%ebp
  800880:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800883:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80088a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80088d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800890:	8b 45 08             	mov    0x8(%ebp),%eax
  800893:	83 ec 08             	sub    $0x8,%esp
  800896:	ff 75 f4             	pushl  -0xc(%ebp)
  800899:	50                   	push   %eax
  80089a:	e8 73 ff ff ff       	call   800812 <vcprintf>
  80089f:	83 c4 10             	add    $0x10,%esp
  8008a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8008a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008a8:	c9                   	leave  
  8008a9:	c3                   	ret    

008008aa <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
  8008ad:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8008b0:	e8 8e 0f 00 00       	call   801843 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8008b5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8008b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8008bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008be:	83 ec 08             	sub    $0x8,%esp
  8008c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c4:	50                   	push   %eax
  8008c5:	e8 48 ff ff ff       	call   800812 <vcprintf>
  8008ca:	83 c4 10             	add    $0x10,%esp
  8008cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8008d0:	e8 88 0f 00 00       	call   80185d <sys_enable_interrupt>
	return cnt;
  8008d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008d8:	c9                   	leave  
  8008d9:	c3                   	ret    

008008da <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8008da:	55                   	push   %ebp
  8008db:	89 e5                	mov    %esp,%ebp
  8008dd:	53                   	push   %ebx
  8008de:	83 ec 14             	sub    $0x14,%esp
  8008e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8008f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8008f5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008f8:	77 55                	ja     80094f <printnum+0x75>
  8008fa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008fd:	72 05                	jb     800904 <printnum+0x2a>
  8008ff:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800902:	77 4b                	ja     80094f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800904:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800907:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80090a:	8b 45 18             	mov    0x18(%ebp),%eax
  80090d:	ba 00 00 00 00       	mov    $0x0,%edx
  800912:	52                   	push   %edx
  800913:	50                   	push   %eax
  800914:	ff 75 f4             	pushl  -0xc(%ebp)
  800917:	ff 75 f0             	pushl  -0x10(%ebp)
  80091a:	e8 05 13 00 00       	call   801c24 <__udivdi3>
  80091f:	83 c4 10             	add    $0x10,%esp
  800922:	83 ec 04             	sub    $0x4,%esp
  800925:	ff 75 20             	pushl  0x20(%ebp)
  800928:	53                   	push   %ebx
  800929:	ff 75 18             	pushl  0x18(%ebp)
  80092c:	52                   	push   %edx
  80092d:	50                   	push   %eax
  80092e:	ff 75 0c             	pushl  0xc(%ebp)
  800931:	ff 75 08             	pushl  0x8(%ebp)
  800934:	e8 a1 ff ff ff       	call   8008da <printnum>
  800939:	83 c4 20             	add    $0x20,%esp
  80093c:	eb 1a                	jmp    800958 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 0c             	pushl  0xc(%ebp)
  800944:	ff 75 20             	pushl  0x20(%ebp)
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	ff d0                	call   *%eax
  80094c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80094f:	ff 4d 1c             	decl   0x1c(%ebp)
  800952:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800956:	7f e6                	jg     80093e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800958:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80095b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800960:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800963:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800966:	53                   	push   %ebx
  800967:	51                   	push   %ecx
  800968:	52                   	push   %edx
  800969:	50                   	push   %eax
  80096a:	e8 c5 13 00 00       	call   801d34 <__umoddi3>
  80096f:	83 c4 10             	add    $0x10,%esp
  800972:	05 d4 23 80 00       	add    $0x8023d4,%eax
  800977:	8a 00                	mov    (%eax),%al
  800979:	0f be c0             	movsbl %al,%eax
  80097c:	83 ec 08             	sub    $0x8,%esp
  80097f:	ff 75 0c             	pushl  0xc(%ebp)
  800982:	50                   	push   %eax
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	ff d0                	call   *%eax
  800988:	83 c4 10             	add    $0x10,%esp
}
  80098b:	90                   	nop
  80098c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800994:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800998:	7e 1c                	jle    8009b6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	8d 50 08             	lea    0x8(%eax),%edx
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	89 10                	mov    %edx,(%eax)
  8009a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009aa:	8b 00                	mov    (%eax),%eax
  8009ac:	83 e8 08             	sub    $0x8,%eax
  8009af:	8b 50 04             	mov    0x4(%eax),%edx
  8009b2:	8b 00                	mov    (%eax),%eax
  8009b4:	eb 40                	jmp    8009f6 <getuint+0x65>
	else if (lflag)
  8009b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009ba:	74 1e                	je     8009da <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	8b 00                	mov    (%eax),%eax
  8009c1:	8d 50 04             	lea    0x4(%eax),%edx
  8009c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c7:	89 10                	mov    %edx,(%eax)
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	8b 00                	mov    (%eax),%eax
  8009ce:	83 e8 04             	sub    $0x4,%eax
  8009d1:	8b 00                	mov    (%eax),%eax
  8009d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8009d8:	eb 1c                	jmp    8009f6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	8d 50 04             	lea    0x4(%eax),%edx
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	89 10                	mov    %edx,(%eax)
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	8b 00                	mov    (%eax),%eax
  8009ec:	83 e8 04             	sub    $0x4,%eax
  8009ef:	8b 00                	mov    (%eax),%eax
  8009f1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009f6:	5d                   	pop    %ebp
  8009f7:	c3                   	ret    

008009f8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009f8:	55                   	push   %ebp
  8009f9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009fb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009ff:	7e 1c                	jle    800a1d <getint+0x25>
		return va_arg(*ap, long long);
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	8b 00                	mov    (%eax),%eax
  800a06:	8d 50 08             	lea    0x8(%eax),%edx
  800a09:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0c:	89 10                	mov    %edx,(%eax)
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	8b 00                	mov    (%eax),%eax
  800a13:	83 e8 08             	sub    $0x8,%eax
  800a16:	8b 50 04             	mov    0x4(%eax),%edx
  800a19:	8b 00                	mov    (%eax),%eax
  800a1b:	eb 38                	jmp    800a55 <getint+0x5d>
	else if (lflag)
  800a1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a21:	74 1a                	je     800a3d <getint+0x45>
		return va_arg(*ap, long);
  800a23:	8b 45 08             	mov    0x8(%ebp),%eax
  800a26:	8b 00                	mov    (%eax),%eax
  800a28:	8d 50 04             	lea    0x4(%eax),%edx
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	89 10                	mov    %edx,(%eax)
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	8b 00                	mov    (%eax),%eax
  800a35:	83 e8 04             	sub    $0x4,%eax
  800a38:	8b 00                	mov    (%eax),%eax
  800a3a:	99                   	cltd   
  800a3b:	eb 18                	jmp    800a55 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a40:	8b 00                	mov    (%eax),%eax
  800a42:	8d 50 04             	lea    0x4(%eax),%edx
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	89 10                	mov    %edx,(%eax)
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	8b 00                	mov    (%eax),%eax
  800a4f:	83 e8 04             	sub    $0x4,%eax
  800a52:	8b 00                	mov    (%eax),%eax
  800a54:	99                   	cltd   
}
  800a55:	5d                   	pop    %ebp
  800a56:	c3                   	ret    

00800a57 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a57:	55                   	push   %ebp
  800a58:	89 e5                	mov    %esp,%ebp
  800a5a:	56                   	push   %esi
  800a5b:	53                   	push   %ebx
  800a5c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a5f:	eb 17                	jmp    800a78 <vprintfmt+0x21>
			if (ch == '\0')
  800a61:	85 db                	test   %ebx,%ebx
  800a63:	0f 84 af 03 00 00    	je     800e18 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a69:	83 ec 08             	sub    $0x8,%esp
  800a6c:	ff 75 0c             	pushl  0xc(%ebp)
  800a6f:	53                   	push   %ebx
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	ff d0                	call   *%eax
  800a75:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a78:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7b:	8d 50 01             	lea    0x1(%eax),%edx
  800a7e:	89 55 10             	mov    %edx,0x10(%ebp)
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	0f b6 d8             	movzbl %al,%ebx
  800a86:	83 fb 25             	cmp    $0x25,%ebx
  800a89:	75 d6                	jne    800a61 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a8b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a8f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a96:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a9d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800aa4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800aab:	8b 45 10             	mov    0x10(%ebp),%eax
  800aae:	8d 50 01             	lea    0x1(%eax),%edx
  800ab1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ab4:	8a 00                	mov    (%eax),%al
  800ab6:	0f b6 d8             	movzbl %al,%ebx
  800ab9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800abc:	83 f8 55             	cmp    $0x55,%eax
  800abf:	0f 87 2b 03 00 00    	ja     800df0 <vprintfmt+0x399>
  800ac5:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  800acc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ace:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ad2:	eb d7                	jmp    800aab <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ad4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ad8:	eb d1                	jmp    800aab <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ada:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ae1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ae4:	89 d0                	mov    %edx,%eax
  800ae6:	c1 e0 02             	shl    $0x2,%eax
  800ae9:	01 d0                	add    %edx,%eax
  800aeb:	01 c0                	add    %eax,%eax
  800aed:	01 d8                	add    %ebx,%eax
  800aef:	83 e8 30             	sub    $0x30,%eax
  800af2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800af5:	8b 45 10             	mov    0x10(%ebp),%eax
  800af8:	8a 00                	mov    (%eax),%al
  800afa:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800afd:	83 fb 2f             	cmp    $0x2f,%ebx
  800b00:	7e 3e                	jle    800b40 <vprintfmt+0xe9>
  800b02:	83 fb 39             	cmp    $0x39,%ebx
  800b05:	7f 39                	jg     800b40 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b07:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800b0a:	eb d5                	jmp    800ae1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800b0c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b0f:	83 c0 04             	add    $0x4,%eax
  800b12:	89 45 14             	mov    %eax,0x14(%ebp)
  800b15:	8b 45 14             	mov    0x14(%ebp),%eax
  800b18:	83 e8 04             	sub    $0x4,%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800b20:	eb 1f                	jmp    800b41 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800b22:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b26:	79 83                	jns    800aab <vprintfmt+0x54>
				width = 0;
  800b28:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b2f:	e9 77 ff ff ff       	jmp    800aab <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b34:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b3b:	e9 6b ff ff ff       	jmp    800aab <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800b40:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800b41:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b45:	0f 89 60 ff ff ff    	jns    800aab <vprintfmt+0x54>
				width = precision, precision = -1;
  800b4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b51:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b58:	e9 4e ff ff ff       	jmp    800aab <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b5d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b60:	e9 46 ff ff ff       	jmp    800aab <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b65:	8b 45 14             	mov    0x14(%ebp),%eax
  800b68:	83 c0 04             	add    $0x4,%eax
  800b6b:	89 45 14             	mov    %eax,0x14(%ebp)
  800b6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800b71:	83 e8 04             	sub    $0x4,%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	83 ec 08             	sub    $0x8,%esp
  800b79:	ff 75 0c             	pushl  0xc(%ebp)
  800b7c:	50                   	push   %eax
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	ff d0                	call   *%eax
  800b82:	83 c4 10             	add    $0x10,%esp
			break;
  800b85:	e9 89 02 00 00       	jmp    800e13 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b8d:	83 c0 04             	add    $0x4,%eax
  800b90:	89 45 14             	mov    %eax,0x14(%ebp)
  800b93:	8b 45 14             	mov    0x14(%ebp),%eax
  800b96:	83 e8 04             	sub    $0x4,%eax
  800b99:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b9b:	85 db                	test   %ebx,%ebx
  800b9d:	79 02                	jns    800ba1 <vprintfmt+0x14a>
				err = -err;
  800b9f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ba1:	83 fb 64             	cmp    $0x64,%ebx
  800ba4:	7f 0b                	jg     800bb1 <vprintfmt+0x15a>
  800ba6:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  800bad:	85 f6                	test   %esi,%esi
  800baf:	75 19                	jne    800bca <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800bb1:	53                   	push   %ebx
  800bb2:	68 e5 23 80 00       	push   $0x8023e5
  800bb7:	ff 75 0c             	pushl  0xc(%ebp)
  800bba:	ff 75 08             	pushl  0x8(%ebp)
  800bbd:	e8 5e 02 00 00       	call   800e20 <printfmt>
  800bc2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800bc5:	e9 49 02 00 00       	jmp    800e13 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800bca:	56                   	push   %esi
  800bcb:	68 ee 23 80 00       	push   $0x8023ee
  800bd0:	ff 75 0c             	pushl  0xc(%ebp)
  800bd3:	ff 75 08             	pushl  0x8(%ebp)
  800bd6:	e8 45 02 00 00       	call   800e20 <printfmt>
  800bdb:	83 c4 10             	add    $0x10,%esp
			break;
  800bde:	e9 30 02 00 00       	jmp    800e13 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800be3:	8b 45 14             	mov    0x14(%ebp),%eax
  800be6:	83 c0 04             	add    $0x4,%eax
  800be9:	89 45 14             	mov    %eax,0x14(%ebp)
  800bec:	8b 45 14             	mov    0x14(%ebp),%eax
  800bef:	83 e8 04             	sub    $0x4,%eax
  800bf2:	8b 30                	mov    (%eax),%esi
  800bf4:	85 f6                	test   %esi,%esi
  800bf6:	75 05                	jne    800bfd <vprintfmt+0x1a6>
				p = "(null)";
  800bf8:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  800bfd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c01:	7e 6d                	jle    800c70 <vprintfmt+0x219>
  800c03:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800c07:	74 67                	je     800c70 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800c09:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c0c:	83 ec 08             	sub    $0x8,%esp
  800c0f:	50                   	push   %eax
  800c10:	56                   	push   %esi
  800c11:	e8 0c 03 00 00       	call   800f22 <strnlen>
  800c16:	83 c4 10             	add    $0x10,%esp
  800c19:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800c1c:	eb 16                	jmp    800c34 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800c1e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800c22:	83 ec 08             	sub    $0x8,%esp
  800c25:	ff 75 0c             	pushl  0xc(%ebp)
  800c28:	50                   	push   %eax
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	ff d0                	call   *%eax
  800c2e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c31:	ff 4d e4             	decl   -0x1c(%ebp)
  800c34:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c38:	7f e4                	jg     800c1e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c3a:	eb 34                	jmp    800c70 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800c3c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800c40:	74 1c                	je     800c5e <vprintfmt+0x207>
  800c42:	83 fb 1f             	cmp    $0x1f,%ebx
  800c45:	7e 05                	jle    800c4c <vprintfmt+0x1f5>
  800c47:	83 fb 7e             	cmp    $0x7e,%ebx
  800c4a:	7e 12                	jle    800c5e <vprintfmt+0x207>
					putch('?', putdat);
  800c4c:	83 ec 08             	sub    $0x8,%esp
  800c4f:	ff 75 0c             	pushl  0xc(%ebp)
  800c52:	6a 3f                	push   $0x3f
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	ff d0                	call   *%eax
  800c59:	83 c4 10             	add    $0x10,%esp
  800c5c:	eb 0f                	jmp    800c6d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c5e:	83 ec 08             	sub    $0x8,%esp
  800c61:	ff 75 0c             	pushl  0xc(%ebp)
  800c64:	53                   	push   %ebx
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	ff d0                	call   *%eax
  800c6a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c6d:	ff 4d e4             	decl   -0x1c(%ebp)
  800c70:	89 f0                	mov    %esi,%eax
  800c72:	8d 70 01             	lea    0x1(%eax),%esi
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	0f be d8             	movsbl %al,%ebx
  800c7a:	85 db                	test   %ebx,%ebx
  800c7c:	74 24                	je     800ca2 <vprintfmt+0x24b>
  800c7e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c82:	78 b8                	js     800c3c <vprintfmt+0x1e5>
  800c84:	ff 4d e0             	decl   -0x20(%ebp)
  800c87:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c8b:	79 af                	jns    800c3c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c8d:	eb 13                	jmp    800ca2 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c8f:	83 ec 08             	sub    $0x8,%esp
  800c92:	ff 75 0c             	pushl  0xc(%ebp)
  800c95:	6a 20                	push   $0x20
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	ff d0                	call   *%eax
  800c9c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c9f:	ff 4d e4             	decl   -0x1c(%ebp)
  800ca2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ca6:	7f e7                	jg     800c8f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ca8:	e9 66 01 00 00       	jmp    800e13 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800cad:	83 ec 08             	sub    $0x8,%esp
  800cb0:	ff 75 e8             	pushl  -0x18(%ebp)
  800cb3:	8d 45 14             	lea    0x14(%ebp),%eax
  800cb6:	50                   	push   %eax
  800cb7:	e8 3c fd ff ff       	call   8009f8 <getint>
  800cbc:	83 c4 10             	add    $0x10,%esp
  800cbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800cc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cc8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ccb:	85 d2                	test   %edx,%edx
  800ccd:	79 23                	jns    800cf2 <vprintfmt+0x29b>
				putch('-', putdat);
  800ccf:	83 ec 08             	sub    $0x8,%esp
  800cd2:	ff 75 0c             	pushl  0xc(%ebp)
  800cd5:	6a 2d                	push   $0x2d
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	ff d0                	call   *%eax
  800cdc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800cdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ce2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ce5:	f7 d8                	neg    %eax
  800ce7:	83 d2 00             	adc    $0x0,%edx
  800cea:	f7 da                	neg    %edx
  800cec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cef:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800cf2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cf9:	e9 bc 00 00 00       	jmp    800dba <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cfe:	83 ec 08             	sub    $0x8,%esp
  800d01:	ff 75 e8             	pushl  -0x18(%ebp)
  800d04:	8d 45 14             	lea    0x14(%ebp),%eax
  800d07:	50                   	push   %eax
  800d08:	e8 84 fc ff ff       	call   800991 <getuint>
  800d0d:	83 c4 10             	add    $0x10,%esp
  800d10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d13:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800d16:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d1d:	e9 98 00 00 00       	jmp    800dba <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800d22:	83 ec 08             	sub    $0x8,%esp
  800d25:	ff 75 0c             	pushl  0xc(%ebp)
  800d28:	6a 58                	push   $0x58
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	ff d0                	call   *%eax
  800d2f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d32:	83 ec 08             	sub    $0x8,%esp
  800d35:	ff 75 0c             	pushl  0xc(%ebp)
  800d38:	6a 58                	push   $0x58
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	ff d0                	call   *%eax
  800d3f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d42:	83 ec 08             	sub    $0x8,%esp
  800d45:	ff 75 0c             	pushl  0xc(%ebp)
  800d48:	6a 58                	push   $0x58
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	ff d0                	call   *%eax
  800d4f:	83 c4 10             	add    $0x10,%esp
			break;
  800d52:	e9 bc 00 00 00       	jmp    800e13 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	ff 75 0c             	pushl  0xc(%ebp)
  800d5d:	6a 30                	push   $0x30
  800d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d62:	ff d0                	call   *%eax
  800d64:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d67:	83 ec 08             	sub    $0x8,%esp
  800d6a:	ff 75 0c             	pushl  0xc(%ebp)
  800d6d:	6a 78                	push   $0x78
  800d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d72:	ff d0                	call   *%eax
  800d74:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d77:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7a:	83 c0 04             	add    $0x4,%eax
  800d7d:	89 45 14             	mov    %eax,0x14(%ebp)
  800d80:	8b 45 14             	mov    0x14(%ebp),%eax
  800d83:	83 e8 04             	sub    $0x4,%eax
  800d86:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d8b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d92:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d99:	eb 1f                	jmp    800dba <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d9b:	83 ec 08             	sub    $0x8,%esp
  800d9e:	ff 75 e8             	pushl  -0x18(%ebp)
  800da1:	8d 45 14             	lea    0x14(%ebp),%eax
  800da4:	50                   	push   %eax
  800da5:	e8 e7 fb ff ff       	call   800991 <getuint>
  800daa:	83 c4 10             	add    $0x10,%esp
  800dad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800db0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800db3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800dba:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800dbe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dc1:	83 ec 04             	sub    $0x4,%esp
  800dc4:	52                   	push   %edx
  800dc5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800dc8:	50                   	push   %eax
  800dc9:	ff 75 f4             	pushl  -0xc(%ebp)
  800dcc:	ff 75 f0             	pushl  -0x10(%ebp)
  800dcf:	ff 75 0c             	pushl  0xc(%ebp)
  800dd2:	ff 75 08             	pushl  0x8(%ebp)
  800dd5:	e8 00 fb ff ff       	call   8008da <printnum>
  800dda:	83 c4 20             	add    $0x20,%esp
			break;
  800ddd:	eb 34                	jmp    800e13 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ddf:	83 ec 08             	sub    $0x8,%esp
  800de2:	ff 75 0c             	pushl  0xc(%ebp)
  800de5:	53                   	push   %ebx
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	ff d0                	call   *%eax
  800deb:	83 c4 10             	add    $0x10,%esp
			break;
  800dee:	eb 23                	jmp    800e13 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800df0:	83 ec 08             	sub    $0x8,%esp
  800df3:	ff 75 0c             	pushl  0xc(%ebp)
  800df6:	6a 25                	push   $0x25
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	ff d0                	call   *%eax
  800dfd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800e00:	ff 4d 10             	decl   0x10(%ebp)
  800e03:	eb 03                	jmp    800e08 <vprintfmt+0x3b1>
  800e05:	ff 4d 10             	decl   0x10(%ebp)
  800e08:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0b:	48                   	dec    %eax
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	3c 25                	cmp    $0x25,%al
  800e10:	75 f3                	jne    800e05 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800e12:	90                   	nop
		}
	}
  800e13:	e9 47 fc ff ff       	jmp    800a5f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800e18:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800e19:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e1c:	5b                   	pop    %ebx
  800e1d:	5e                   	pop    %esi
  800e1e:	5d                   	pop    %ebp
  800e1f:	c3                   	ret    

00800e20 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800e20:	55                   	push   %ebp
  800e21:	89 e5                	mov    %esp,%ebp
  800e23:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800e26:	8d 45 10             	lea    0x10(%ebp),%eax
  800e29:	83 c0 04             	add    $0x4,%eax
  800e2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e32:	ff 75 f4             	pushl  -0xc(%ebp)
  800e35:	50                   	push   %eax
  800e36:	ff 75 0c             	pushl  0xc(%ebp)
  800e39:	ff 75 08             	pushl  0x8(%ebp)
  800e3c:	e8 16 fc ff ff       	call   800a57 <vprintfmt>
  800e41:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e44:	90                   	nop
  800e45:	c9                   	leave  
  800e46:	c3                   	ret    

00800e47 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e47:	55                   	push   %ebp
  800e48:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4d:	8b 40 08             	mov    0x8(%eax),%eax
  800e50:	8d 50 01             	lea    0x1(%eax),%edx
  800e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e56:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5c:	8b 10                	mov    (%eax),%edx
  800e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e61:	8b 40 04             	mov    0x4(%eax),%eax
  800e64:	39 c2                	cmp    %eax,%edx
  800e66:	73 12                	jae    800e7a <sprintputch+0x33>
		*b->buf++ = ch;
  800e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6b:	8b 00                	mov    (%eax),%eax
  800e6d:	8d 48 01             	lea    0x1(%eax),%ecx
  800e70:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e73:	89 0a                	mov    %ecx,(%edx)
  800e75:	8b 55 08             	mov    0x8(%ebp),%edx
  800e78:	88 10                	mov    %dl,(%eax)
}
  800e7a:	90                   	nop
  800e7b:	5d                   	pop    %ebp
  800e7c:	c3                   	ret    

00800e7d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e7d:	55                   	push   %ebp
  800e7e:	89 e5                	mov    %esp,%ebp
  800e80:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	01 d0                	add    %edx,%eax
  800e94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e9e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ea2:	74 06                	je     800eaa <vsnprintf+0x2d>
  800ea4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ea8:	7f 07                	jg     800eb1 <vsnprintf+0x34>
		return -E_INVAL;
  800eaa:	b8 03 00 00 00       	mov    $0x3,%eax
  800eaf:	eb 20                	jmp    800ed1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800eb1:	ff 75 14             	pushl  0x14(%ebp)
  800eb4:	ff 75 10             	pushl  0x10(%ebp)
  800eb7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800eba:	50                   	push   %eax
  800ebb:	68 47 0e 80 00       	push   $0x800e47
  800ec0:	e8 92 fb ff ff       	call   800a57 <vprintfmt>
  800ec5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ec8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ecb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ece:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ed9:	8d 45 10             	lea    0x10(%ebp),%eax
  800edc:	83 c0 04             	add    $0x4,%eax
  800edf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ee2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ee8:	50                   	push   %eax
  800ee9:	ff 75 0c             	pushl  0xc(%ebp)
  800eec:	ff 75 08             	pushl  0x8(%ebp)
  800eef:	e8 89 ff ff ff       	call   800e7d <vsnprintf>
  800ef4:	83 c4 10             	add    $0x10,%esp
  800ef7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800efa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800efd:	c9                   	leave  
  800efe:	c3                   	ret    

00800eff <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800eff:	55                   	push   %ebp
  800f00:	89 e5                	mov    %esp,%ebp
  800f02:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800f05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f0c:	eb 06                	jmp    800f14 <strlen+0x15>
		n++;
  800f0e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800f11:	ff 45 08             	incl   0x8(%ebp)
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	84 c0                	test   %al,%al
  800f1b:	75 f1                	jne    800f0e <strlen+0xf>
		n++;
	return n;
  800f1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f20:	c9                   	leave  
  800f21:	c3                   	ret    

00800f22 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800f22:	55                   	push   %ebp
  800f23:	89 e5                	mov    %esp,%ebp
  800f25:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f2f:	eb 09                	jmp    800f3a <strnlen+0x18>
		n++;
  800f31:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f34:	ff 45 08             	incl   0x8(%ebp)
  800f37:	ff 4d 0c             	decl   0xc(%ebp)
  800f3a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f3e:	74 09                	je     800f49 <strnlen+0x27>
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	84 c0                	test   %al,%al
  800f47:	75 e8                	jne    800f31 <strnlen+0xf>
		n++;
	return n;
  800f49:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f4c:	c9                   	leave  
  800f4d:	c3                   	ret    

00800f4e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f4e:	55                   	push   %ebp
  800f4f:	89 e5                	mov    %esp,%ebp
  800f51:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f5a:	90                   	nop
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	8d 50 01             	lea    0x1(%eax),%edx
  800f61:	89 55 08             	mov    %edx,0x8(%ebp)
  800f64:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f67:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f6a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f6d:	8a 12                	mov    (%edx),%dl
  800f6f:	88 10                	mov    %dl,(%eax)
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	84 c0                	test   %al,%al
  800f75:	75 e4                	jne    800f5b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f77:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f7a:	c9                   	leave  
  800f7b:	c3                   	ret    

00800f7c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f7c:	55                   	push   %ebp
  800f7d:	89 e5                	mov    %esp,%ebp
  800f7f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f8f:	eb 1f                	jmp    800fb0 <strncpy+0x34>
		*dst++ = *src;
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	8d 50 01             	lea    0x1(%eax),%edx
  800f97:	89 55 08             	mov    %edx,0x8(%ebp)
  800f9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f9d:	8a 12                	mov    (%edx),%dl
  800f9f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800fa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	84 c0                	test   %al,%al
  800fa8:	74 03                	je     800fad <strncpy+0x31>
			src++;
  800faa:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800fad:	ff 45 fc             	incl   -0x4(%ebp)
  800fb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fb6:	72 d9                	jb     800f91 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800fb8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fbb:	c9                   	leave  
  800fbc:	c3                   	ret    

00800fbd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800fbd:	55                   	push   %ebp
  800fbe:	89 e5                	mov    %esp,%ebp
  800fc0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800fc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fcd:	74 30                	je     800fff <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800fcf:	eb 16                	jmp    800fe7 <strlcpy+0x2a>
			*dst++ = *src++;
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	8d 50 01             	lea    0x1(%eax),%edx
  800fd7:	89 55 08             	mov    %edx,0x8(%ebp)
  800fda:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fdd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fe0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fe3:	8a 12                	mov    (%edx),%dl
  800fe5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800fe7:	ff 4d 10             	decl   0x10(%ebp)
  800fea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fee:	74 09                	je     800ff9 <strlcpy+0x3c>
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	84 c0                	test   %al,%al
  800ff7:	75 d8                	jne    800fd1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fff:	8b 55 08             	mov    0x8(%ebp),%edx
  801002:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801005:	29 c2                	sub    %eax,%edx
  801007:	89 d0                	mov    %edx,%eax
}
  801009:	c9                   	leave  
  80100a:	c3                   	ret    

0080100b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80100b:	55                   	push   %ebp
  80100c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80100e:	eb 06                	jmp    801016 <strcmp+0xb>
		p++, q++;
  801010:	ff 45 08             	incl   0x8(%ebp)
  801013:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	8a 00                	mov    (%eax),%al
  80101b:	84 c0                	test   %al,%al
  80101d:	74 0e                	je     80102d <strcmp+0x22>
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8a 10                	mov    (%eax),%dl
  801024:	8b 45 0c             	mov    0xc(%ebp),%eax
  801027:	8a 00                	mov    (%eax),%al
  801029:	38 c2                	cmp    %al,%dl
  80102b:	74 e3                	je     801010 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80102d:	8b 45 08             	mov    0x8(%ebp),%eax
  801030:	8a 00                	mov    (%eax),%al
  801032:	0f b6 d0             	movzbl %al,%edx
  801035:	8b 45 0c             	mov    0xc(%ebp),%eax
  801038:	8a 00                	mov    (%eax),%al
  80103a:	0f b6 c0             	movzbl %al,%eax
  80103d:	29 c2                	sub    %eax,%edx
  80103f:	89 d0                	mov    %edx,%eax
}
  801041:	5d                   	pop    %ebp
  801042:	c3                   	ret    

00801043 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801043:	55                   	push   %ebp
  801044:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801046:	eb 09                	jmp    801051 <strncmp+0xe>
		n--, p++, q++;
  801048:	ff 4d 10             	decl   0x10(%ebp)
  80104b:	ff 45 08             	incl   0x8(%ebp)
  80104e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801051:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801055:	74 17                	je     80106e <strncmp+0x2b>
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	8a 00                	mov    (%eax),%al
  80105c:	84 c0                	test   %al,%al
  80105e:	74 0e                	je     80106e <strncmp+0x2b>
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8a 10                	mov    (%eax),%dl
  801065:	8b 45 0c             	mov    0xc(%ebp),%eax
  801068:	8a 00                	mov    (%eax),%al
  80106a:	38 c2                	cmp    %al,%dl
  80106c:	74 da                	je     801048 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80106e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801072:	75 07                	jne    80107b <strncmp+0x38>
		return 0;
  801074:	b8 00 00 00 00       	mov    $0x0,%eax
  801079:	eb 14                	jmp    80108f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	0f b6 d0             	movzbl %al,%edx
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	8a 00                	mov    (%eax),%al
  801088:	0f b6 c0             	movzbl %al,%eax
  80108b:	29 c2                	sub    %eax,%edx
  80108d:	89 d0                	mov    %edx,%eax
}
  80108f:	5d                   	pop    %ebp
  801090:	c3                   	ret    

00801091 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
  801094:	83 ec 04             	sub    $0x4,%esp
  801097:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80109d:	eb 12                	jmp    8010b1 <strchr+0x20>
		if (*s == c)
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	8a 00                	mov    (%eax),%al
  8010a4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010a7:	75 05                	jne    8010ae <strchr+0x1d>
			return (char *) s;
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	eb 11                	jmp    8010bf <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8010ae:	ff 45 08             	incl   0x8(%ebp)
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	8a 00                	mov    (%eax),%al
  8010b6:	84 c0                	test   %al,%al
  8010b8:	75 e5                	jne    80109f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8010ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010bf:	c9                   	leave  
  8010c0:	c3                   	ret    

008010c1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8010c1:	55                   	push   %ebp
  8010c2:	89 e5                	mov    %esp,%ebp
  8010c4:	83 ec 04             	sub    $0x4,%esp
  8010c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010cd:	eb 0d                	jmp    8010dc <strfind+0x1b>
		if (*s == c)
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010d7:	74 0e                	je     8010e7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8010d9:	ff 45 08             	incl   0x8(%ebp)
  8010dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010df:	8a 00                	mov    (%eax),%al
  8010e1:	84 c0                	test   %al,%al
  8010e3:	75 ea                	jne    8010cf <strfind+0xe>
  8010e5:	eb 01                	jmp    8010e8 <strfind+0x27>
		if (*s == c)
			break;
  8010e7:	90                   	nop
	return (char *) s;
  8010e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010eb:	c9                   	leave  
  8010ec:	c3                   	ret    

008010ed <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8010ed:	55                   	push   %ebp
  8010ee:	89 e5                	mov    %esp,%ebp
  8010f0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8010f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8010ff:	eb 0e                	jmp    80110f <memset+0x22>
		*p++ = c;
  801101:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801104:	8d 50 01             	lea    0x1(%eax),%edx
  801107:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80110a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80110f:	ff 4d f8             	decl   -0x8(%ebp)
  801112:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801116:	79 e9                	jns    801101 <memset+0x14>
		*p++ = c;

	return v;
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
  801120:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801123:	8b 45 0c             	mov    0xc(%ebp),%eax
  801126:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80112f:	eb 16                	jmp    801147 <memcpy+0x2a>
		*d++ = *s++;
  801131:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801134:	8d 50 01             	lea    0x1(%eax),%edx
  801137:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80113a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80113d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801140:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801143:	8a 12                	mov    (%edx),%dl
  801145:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801147:	8b 45 10             	mov    0x10(%ebp),%eax
  80114a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80114d:	89 55 10             	mov    %edx,0x10(%ebp)
  801150:	85 c0                	test   %eax,%eax
  801152:	75 dd                	jne    801131 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801157:	c9                   	leave  
  801158:	c3                   	ret    

00801159 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
  80115c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80116b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801171:	73 50                	jae    8011c3 <memmove+0x6a>
  801173:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801176:	8b 45 10             	mov    0x10(%ebp),%eax
  801179:	01 d0                	add    %edx,%eax
  80117b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80117e:	76 43                	jbe    8011c3 <memmove+0x6a>
		s += n;
  801180:	8b 45 10             	mov    0x10(%ebp),%eax
  801183:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801186:	8b 45 10             	mov    0x10(%ebp),%eax
  801189:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80118c:	eb 10                	jmp    80119e <memmove+0x45>
			*--d = *--s;
  80118e:	ff 4d f8             	decl   -0x8(%ebp)
  801191:	ff 4d fc             	decl   -0x4(%ebp)
  801194:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801197:	8a 10                	mov    (%eax),%dl
  801199:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80119c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80119e:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a4:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a7:	85 c0                	test   %eax,%eax
  8011a9:	75 e3                	jne    80118e <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011ab:	eb 23                	jmp    8011d0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b0:	8d 50 01             	lea    0x1(%eax),%edx
  8011b3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011b9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011bc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011bf:	8a 12                	mov    (%edx),%dl
  8011c1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8011c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011c9:	89 55 10             	mov    %edx,0x10(%ebp)
  8011cc:	85 c0                	test   %eax,%eax
  8011ce:	75 dd                	jne    8011ad <memmove+0x54>
			*d++ = *s++;

	return dst;
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d3:	c9                   	leave  
  8011d4:	c3                   	ret    

008011d5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8011d5:	55                   	push   %ebp
  8011d6:	89 e5                	mov    %esp,%ebp
  8011d8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8011e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8011e7:	eb 2a                	jmp    801213 <memcmp+0x3e>
		if (*s1 != *s2)
  8011e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011ec:	8a 10                	mov    (%eax),%dl
  8011ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f1:	8a 00                	mov    (%eax),%al
  8011f3:	38 c2                	cmp    %al,%dl
  8011f5:	74 16                	je     80120d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fa:	8a 00                	mov    (%eax),%al
  8011fc:	0f b6 d0             	movzbl %al,%edx
  8011ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801202:	8a 00                	mov    (%eax),%al
  801204:	0f b6 c0             	movzbl %al,%eax
  801207:	29 c2                	sub    %eax,%edx
  801209:	89 d0                	mov    %edx,%eax
  80120b:	eb 18                	jmp    801225 <memcmp+0x50>
		s1++, s2++;
  80120d:	ff 45 fc             	incl   -0x4(%ebp)
  801210:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801213:	8b 45 10             	mov    0x10(%ebp),%eax
  801216:	8d 50 ff             	lea    -0x1(%eax),%edx
  801219:	89 55 10             	mov    %edx,0x10(%ebp)
  80121c:	85 c0                	test   %eax,%eax
  80121e:	75 c9                	jne    8011e9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801220:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801225:	c9                   	leave  
  801226:	c3                   	ret    

00801227 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801227:	55                   	push   %ebp
  801228:	89 e5                	mov    %esp,%ebp
  80122a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80122d:	8b 55 08             	mov    0x8(%ebp),%edx
  801230:	8b 45 10             	mov    0x10(%ebp),%eax
  801233:	01 d0                	add    %edx,%eax
  801235:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801238:	eb 15                	jmp    80124f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	8a 00                	mov    (%eax),%al
  80123f:	0f b6 d0             	movzbl %al,%edx
  801242:	8b 45 0c             	mov    0xc(%ebp),%eax
  801245:	0f b6 c0             	movzbl %al,%eax
  801248:	39 c2                	cmp    %eax,%edx
  80124a:	74 0d                	je     801259 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80124c:	ff 45 08             	incl   0x8(%ebp)
  80124f:	8b 45 08             	mov    0x8(%ebp),%eax
  801252:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801255:	72 e3                	jb     80123a <memfind+0x13>
  801257:	eb 01                	jmp    80125a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801259:	90                   	nop
	return (void *) s;
  80125a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
  801262:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801265:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80126c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801273:	eb 03                	jmp    801278 <strtol+0x19>
		s++;
  801275:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801278:	8b 45 08             	mov    0x8(%ebp),%eax
  80127b:	8a 00                	mov    (%eax),%al
  80127d:	3c 20                	cmp    $0x20,%al
  80127f:	74 f4                	je     801275 <strtol+0x16>
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	3c 09                	cmp    $0x9,%al
  801288:	74 eb                	je     801275 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80128a:	8b 45 08             	mov    0x8(%ebp),%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	3c 2b                	cmp    $0x2b,%al
  801291:	75 05                	jne    801298 <strtol+0x39>
		s++;
  801293:	ff 45 08             	incl   0x8(%ebp)
  801296:	eb 13                	jmp    8012ab <strtol+0x4c>
	else if (*s == '-')
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	8a 00                	mov    (%eax),%al
  80129d:	3c 2d                	cmp    $0x2d,%al
  80129f:	75 0a                	jne    8012ab <strtol+0x4c>
		s++, neg = 1;
  8012a1:	ff 45 08             	incl   0x8(%ebp)
  8012a4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012af:	74 06                	je     8012b7 <strtol+0x58>
  8012b1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012b5:	75 20                	jne    8012d7 <strtol+0x78>
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	8a 00                	mov    (%eax),%al
  8012bc:	3c 30                	cmp    $0x30,%al
  8012be:	75 17                	jne    8012d7 <strtol+0x78>
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	40                   	inc    %eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	3c 78                	cmp    $0x78,%al
  8012c8:	75 0d                	jne    8012d7 <strtol+0x78>
		s += 2, base = 16;
  8012ca:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012ce:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8012d5:	eb 28                	jmp    8012ff <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8012d7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012db:	75 15                	jne    8012f2 <strtol+0x93>
  8012dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	3c 30                	cmp    $0x30,%al
  8012e4:	75 0c                	jne    8012f2 <strtol+0x93>
		s++, base = 8;
  8012e6:	ff 45 08             	incl   0x8(%ebp)
  8012e9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012f0:	eb 0d                	jmp    8012ff <strtol+0xa0>
	else if (base == 0)
  8012f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012f6:	75 07                	jne    8012ff <strtol+0xa0>
		base = 10;
  8012f8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	8a 00                	mov    (%eax),%al
  801304:	3c 2f                	cmp    $0x2f,%al
  801306:	7e 19                	jle    801321 <strtol+0xc2>
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	8a 00                	mov    (%eax),%al
  80130d:	3c 39                	cmp    $0x39,%al
  80130f:	7f 10                	jg     801321 <strtol+0xc2>
			dig = *s - '0';
  801311:	8b 45 08             	mov    0x8(%ebp),%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	0f be c0             	movsbl %al,%eax
  801319:	83 e8 30             	sub    $0x30,%eax
  80131c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80131f:	eb 42                	jmp    801363 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	3c 60                	cmp    $0x60,%al
  801328:	7e 19                	jle    801343 <strtol+0xe4>
  80132a:	8b 45 08             	mov    0x8(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	3c 7a                	cmp    $0x7a,%al
  801331:	7f 10                	jg     801343 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	8a 00                	mov    (%eax),%al
  801338:	0f be c0             	movsbl %al,%eax
  80133b:	83 e8 57             	sub    $0x57,%eax
  80133e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801341:	eb 20                	jmp    801363 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	3c 40                	cmp    $0x40,%al
  80134a:	7e 39                	jle    801385 <strtol+0x126>
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	8a 00                	mov    (%eax),%al
  801351:	3c 5a                	cmp    $0x5a,%al
  801353:	7f 30                	jg     801385 <strtol+0x126>
			dig = *s - 'A' + 10;
  801355:	8b 45 08             	mov    0x8(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	0f be c0             	movsbl %al,%eax
  80135d:	83 e8 37             	sub    $0x37,%eax
  801360:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801363:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801366:	3b 45 10             	cmp    0x10(%ebp),%eax
  801369:	7d 19                	jge    801384 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80136b:	ff 45 08             	incl   0x8(%ebp)
  80136e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801371:	0f af 45 10          	imul   0x10(%ebp),%eax
  801375:	89 c2                	mov    %eax,%edx
  801377:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80137a:	01 d0                	add    %edx,%eax
  80137c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80137f:	e9 7b ff ff ff       	jmp    8012ff <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801384:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801385:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801389:	74 08                	je     801393 <strtol+0x134>
		*endptr = (char *) s;
  80138b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138e:	8b 55 08             	mov    0x8(%ebp),%edx
  801391:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801393:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801397:	74 07                	je     8013a0 <strtol+0x141>
  801399:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80139c:	f7 d8                	neg    %eax
  80139e:	eb 03                	jmp    8013a3 <strtol+0x144>
  8013a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <ltostr>:

void
ltostr(long value, char *str)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
  8013a8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013b2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013b9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013bd:	79 13                	jns    8013d2 <ltostr+0x2d>
	{
		neg = 1;
  8013bf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8013c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013cc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8013cf:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8013da:	99                   	cltd   
  8013db:	f7 f9                	idiv   %ecx
  8013dd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8013e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013e3:	8d 50 01             	lea    0x1(%eax),%edx
  8013e6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013e9:	89 c2                	mov    %eax,%edx
  8013eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ee:	01 d0                	add    %edx,%eax
  8013f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013f3:	83 c2 30             	add    $0x30,%edx
  8013f6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013fb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801400:	f7 e9                	imul   %ecx
  801402:	c1 fa 02             	sar    $0x2,%edx
  801405:	89 c8                	mov    %ecx,%eax
  801407:	c1 f8 1f             	sar    $0x1f,%eax
  80140a:	29 c2                	sub    %eax,%edx
  80140c:	89 d0                	mov    %edx,%eax
  80140e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801411:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801414:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801419:	f7 e9                	imul   %ecx
  80141b:	c1 fa 02             	sar    $0x2,%edx
  80141e:	89 c8                	mov    %ecx,%eax
  801420:	c1 f8 1f             	sar    $0x1f,%eax
  801423:	29 c2                	sub    %eax,%edx
  801425:	89 d0                	mov    %edx,%eax
  801427:	c1 e0 02             	shl    $0x2,%eax
  80142a:	01 d0                	add    %edx,%eax
  80142c:	01 c0                	add    %eax,%eax
  80142e:	29 c1                	sub    %eax,%ecx
  801430:	89 ca                	mov    %ecx,%edx
  801432:	85 d2                	test   %edx,%edx
  801434:	75 9c                	jne    8013d2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801436:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80143d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801440:	48                   	dec    %eax
  801441:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801444:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801448:	74 3d                	je     801487 <ltostr+0xe2>
		start = 1 ;
  80144a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801451:	eb 34                	jmp    801487 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801453:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801456:	8b 45 0c             	mov    0xc(%ebp),%eax
  801459:	01 d0                	add    %edx,%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801460:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801463:	8b 45 0c             	mov    0xc(%ebp),%eax
  801466:	01 c2                	add    %eax,%edx
  801468:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80146b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146e:	01 c8                	add    %ecx,%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801474:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147a:	01 c2                	add    %eax,%edx
  80147c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80147f:	88 02                	mov    %al,(%edx)
		start++ ;
  801481:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801484:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801487:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80148a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80148d:	7c c4                	jl     801453 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80148f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801492:	8b 45 0c             	mov    0xc(%ebp),%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80149a:	90                   	nop
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
  8014a0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014a3:	ff 75 08             	pushl  0x8(%ebp)
  8014a6:	e8 54 fa ff ff       	call   800eff <strlen>
  8014ab:	83 c4 04             	add    $0x4,%esp
  8014ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014b1:	ff 75 0c             	pushl  0xc(%ebp)
  8014b4:	e8 46 fa ff ff       	call   800eff <strlen>
  8014b9:	83 c4 04             	add    $0x4,%esp
  8014bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014cd:	eb 17                	jmp    8014e6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d5:	01 c2                	add    %eax,%edx
  8014d7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	01 c8                	add    %ecx,%eax
  8014df:	8a 00                	mov    (%eax),%al
  8014e1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8014e3:	ff 45 fc             	incl   -0x4(%ebp)
  8014e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014ec:	7c e1                	jl     8014cf <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014f5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014fc:	eb 1f                	jmp    80151d <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801501:	8d 50 01             	lea    0x1(%eax),%edx
  801504:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801507:	89 c2                	mov    %eax,%edx
  801509:	8b 45 10             	mov    0x10(%ebp),%eax
  80150c:	01 c2                	add    %eax,%edx
  80150e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801511:	8b 45 0c             	mov    0xc(%ebp),%eax
  801514:	01 c8                	add    %ecx,%eax
  801516:	8a 00                	mov    (%eax),%al
  801518:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80151a:	ff 45 f8             	incl   -0x8(%ebp)
  80151d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801520:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801523:	7c d9                	jl     8014fe <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801525:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801528:	8b 45 10             	mov    0x10(%ebp),%eax
  80152b:	01 d0                	add    %edx,%eax
  80152d:	c6 00 00             	movb   $0x0,(%eax)
}
  801530:	90                   	nop
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801536:	8b 45 14             	mov    0x14(%ebp),%eax
  801539:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80153f:	8b 45 14             	mov    0x14(%ebp),%eax
  801542:	8b 00                	mov    (%eax),%eax
  801544:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80154b:	8b 45 10             	mov    0x10(%ebp),%eax
  80154e:	01 d0                	add    %edx,%eax
  801550:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801556:	eb 0c                	jmp    801564 <strsplit+0x31>
			*string++ = 0;
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	8d 50 01             	lea    0x1(%eax),%edx
  80155e:	89 55 08             	mov    %edx,0x8(%ebp)
  801561:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	8a 00                	mov    (%eax),%al
  801569:	84 c0                	test   %al,%al
  80156b:	74 18                	je     801585 <strsplit+0x52>
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	8a 00                	mov    (%eax),%al
  801572:	0f be c0             	movsbl %al,%eax
  801575:	50                   	push   %eax
  801576:	ff 75 0c             	pushl  0xc(%ebp)
  801579:	e8 13 fb ff ff       	call   801091 <strchr>
  80157e:	83 c4 08             	add    $0x8,%esp
  801581:	85 c0                	test   %eax,%eax
  801583:	75 d3                	jne    801558 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
  801588:	8a 00                	mov    (%eax),%al
  80158a:	84 c0                	test   %al,%al
  80158c:	74 5a                	je     8015e8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80158e:	8b 45 14             	mov    0x14(%ebp),%eax
  801591:	8b 00                	mov    (%eax),%eax
  801593:	83 f8 0f             	cmp    $0xf,%eax
  801596:	75 07                	jne    80159f <strsplit+0x6c>
		{
			return 0;
  801598:	b8 00 00 00 00       	mov    $0x0,%eax
  80159d:	eb 66                	jmp    801605 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80159f:	8b 45 14             	mov    0x14(%ebp),%eax
  8015a2:	8b 00                	mov    (%eax),%eax
  8015a4:	8d 48 01             	lea    0x1(%eax),%ecx
  8015a7:	8b 55 14             	mov    0x14(%ebp),%edx
  8015aa:	89 0a                	mov    %ecx,(%edx)
  8015ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b6:	01 c2                	add    %eax,%edx
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015bd:	eb 03                	jmp    8015c2 <strsplit+0x8f>
			string++;
  8015bf:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	8a 00                	mov    (%eax),%al
  8015c7:	84 c0                	test   %al,%al
  8015c9:	74 8b                	je     801556 <strsplit+0x23>
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	8a 00                	mov    (%eax),%al
  8015d0:	0f be c0             	movsbl %al,%eax
  8015d3:	50                   	push   %eax
  8015d4:	ff 75 0c             	pushl  0xc(%ebp)
  8015d7:	e8 b5 fa ff ff       	call   801091 <strchr>
  8015dc:	83 c4 08             	add    $0x8,%esp
  8015df:	85 c0                	test   %eax,%eax
  8015e1:	74 dc                	je     8015bf <strsplit+0x8c>
			string++;
	}
  8015e3:	e9 6e ff ff ff       	jmp    801556 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8015e8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8015e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8015ec:	8b 00                	mov    (%eax),%eax
  8015ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f8:	01 d0                	add    %edx,%eax
  8015fa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801600:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801605:	c9                   	leave  
  801606:	c3                   	ret    

00801607 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801607:	55                   	push   %ebp
  801608:	89 e5                	mov    %esp,%ebp
  80160a:	57                   	push   %edi
  80160b:	56                   	push   %esi
  80160c:	53                   	push   %ebx
  80160d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801610:	8b 45 08             	mov    0x8(%ebp),%eax
  801613:	8b 55 0c             	mov    0xc(%ebp),%edx
  801616:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801619:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80161c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80161f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801622:	cd 30                	int    $0x30
  801624:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801627:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80162a:	83 c4 10             	add    $0x10,%esp
  80162d:	5b                   	pop    %ebx
  80162e:	5e                   	pop    %esi
  80162f:	5f                   	pop    %edi
  801630:	5d                   	pop    %ebp
  801631:	c3                   	ret    

00801632 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
  801635:	83 ec 04             	sub    $0x4,%esp
  801638:	8b 45 10             	mov    0x10(%ebp),%eax
  80163b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80163e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	52                   	push   %edx
  80164a:	ff 75 0c             	pushl  0xc(%ebp)
  80164d:	50                   	push   %eax
  80164e:	6a 00                	push   $0x0
  801650:	e8 b2 ff ff ff       	call   801607 <syscall>
  801655:	83 c4 18             	add    $0x18,%esp
}
  801658:	90                   	nop
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_cgetc>:

int
sys_cgetc(void)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 01                	push   $0x1
  80166a:	e8 98 ff ff ff       	call   801607 <syscall>
  80166f:	83 c4 18             	add    $0x18,%esp
}
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	50                   	push   %eax
  801683:	6a 05                	push   $0x5
  801685:	e8 7d ff ff ff       	call   801607 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 02                	push   $0x2
  80169e:	e8 64 ff ff ff       	call   801607 <syscall>
  8016a3:	83 c4 18             	add    $0x18,%esp
}
  8016a6:	c9                   	leave  
  8016a7:	c3                   	ret    

008016a8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 03                	push   $0x3
  8016b7:	e8 4b ff ff ff       	call   801607 <syscall>
  8016bc:	83 c4 18             	add    $0x18,%esp
}
  8016bf:	c9                   	leave  
  8016c0:	c3                   	ret    

008016c1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016c1:	55                   	push   %ebp
  8016c2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 04                	push   $0x4
  8016d0:	e8 32 ff ff ff       	call   801607 <syscall>
  8016d5:	83 c4 18             	add    $0x18,%esp
}
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    

008016da <sys_env_exit>:


void sys_env_exit(void)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 06                	push   $0x6
  8016e9:	e8 19 ff ff ff       	call   801607 <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
}
  8016f1:	90                   	nop
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	52                   	push   %edx
  801704:	50                   	push   %eax
  801705:	6a 07                	push   $0x7
  801707:	e8 fb fe ff ff       	call   801607 <syscall>
  80170c:	83 c4 18             	add    $0x18,%esp
}
  80170f:	c9                   	leave  
  801710:	c3                   	ret    

00801711 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801711:	55                   	push   %ebp
  801712:	89 e5                	mov    %esp,%ebp
  801714:	56                   	push   %esi
  801715:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801716:	8b 75 18             	mov    0x18(%ebp),%esi
  801719:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80171c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80171f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	56                   	push   %esi
  801726:	53                   	push   %ebx
  801727:	51                   	push   %ecx
  801728:	52                   	push   %edx
  801729:	50                   	push   %eax
  80172a:	6a 08                	push   $0x8
  80172c:	e8 d6 fe ff ff       	call   801607 <syscall>
  801731:	83 c4 18             	add    $0x18,%esp
}
  801734:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801737:	5b                   	pop    %ebx
  801738:	5e                   	pop    %esi
  801739:	5d                   	pop    %ebp
  80173a:	c3                   	ret    

0080173b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80173e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	52                   	push   %edx
  80174b:	50                   	push   %eax
  80174c:	6a 09                	push   $0x9
  80174e:	e8 b4 fe ff ff       	call   801607 <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	ff 75 0c             	pushl  0xc(%ebp)
  801764:	ff 75 08             	pushl  0x8(%ebp)
  801767:	6a 0a                	push   $0xa
  801769:	e8 99 fe ff ff       	call   801607 <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 0b                	push   $0xb
  801782:	e8 80 fe ff ff       	call   801607 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 0c                	push   $0xc
  80179b:	e8 67 fe ff ff       	call   801607 <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 0d                	push   $0xd
  8017b4:	e8 4e fe ff ff       	call   801607 <syscall>
  8017b9:	83 c4 18             	add    $0x18,%esp
}
  8017bc:	c9                   	leave  
  8017bd:	c3                   	ret    

008017be <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017be:	55                   	push   %ebp
  8017bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	ff 75 0c             	pushl  0xc(%ebp)
  8017ca:	ff 75 08             	pushl  0x8(%ebp)
  8017cd:	6a 11                	push   $0x11
  8017cf:	e8 33 fe ff ff       	call   801607 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
	return;
  8017d7:	90                   	nop
}
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	ff 75 0c             	pushl  0xc(%ebp)
  8017e6:	ff 75 08             	pushl  0x8(%ebp)
  8017e9:	6a 12                	push   $0x12
  8017eb:	e8 17 fe ff ff       	call   801607 <syscall>
  8017f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f3:	90                   	nop
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 0e                	push   $0xe
  801805:	e8 fd fd ff ff       	call   801607 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	ff 75 08             	pushl  0x8(%ebp)
  80181d:	6a 0f                	push   $0xf
  80181f:	e8 e3 fd ff ff       	call   801607 <syscall>
  801824:	83 c4 18             	add    $0x18,%esp
}
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 10                	push   $0x10
  801838:	e8 ca fd ff ff       	call   801607 <syscall>
  80183d:	83 c4 18             	add    $0x18,%esp
}
  801840:	90                   	nop
  801841:	c9                   	leave  
  801842:	c3                   	ret    

00801843 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 14                	push   $0x14
  801852:	e8 b0 fd ff ff       	call   801607 <syscall>
  801857:	83 c4 18             	add    $0x18,%esp
}
  80185a:	90                   	nop
  80185b:	c9                   	leave  
  80185c:	c3                   	ret    

0080185d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80185d:	55                   	push   %ebp
  80185e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 15                	push   $0x15
  80186c:	e8 96 fd ff ff       	call   801607 <syscall>
  801871:	83 c4 18             	add    $0x18,%esp
}
  801874:	90                   	nop
  801875:	c9                   	leave  
  801876:	c3                   	ret    

00801877 <sys_cputc>:


void
sys_cputc(const char c)
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
  80187a:	83 ec 04             	sub    $0x4,%esp
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801883:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	50                   	push   %eax
  801890:	6a 16                	push   $0x16
  801892:	e8 70 fd ff ff       	call   801607 <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
}
  80189a:	90                   	nop
  80189b:	c9                   	leave  
  80189c:	c3                   	ret    

0080189d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80189d:	55                   	push   %ebp
  80189e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 17                	push   $0x17
  8018ac:	e8 56 fd ff ff       	call   801607 <syscall>
  8018b1:	83 c4 18             	add    $0x18,%esp
}
  8018b4:	90                   	nop
  8018b5:	c9                   	leave  
  8018b6:	c3                   	ret    

008018b7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018b7:	55                   	push   %ebp
  8018b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	ff 75 0c             	pushl  0xc(%ebp)
  8018c6:	50                   	push   %eax
  8018c7:	6a 18                	push   $0x18
  8018c9:	e8 39 fd ff ff       	call   801607 <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	52                   	push   %edx
  8018e3:	50                   	push   %eax
  8018e4:	6a 1b                	push   $0x1b
  8018e6:	e8 1c fd ff ff       	call   801607 <syscall>
  8018eb:	83 c4 18             	add    $0x18,%esp
}
  8018ee:	c9                   	leave  
  8018ef:	c3                   	ret    

008018f0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	52                   	push   %edx
  801900:	50                   	push   %eax
  801901:	6a 19                	push   $0x19
  801903:	e8 ff fc ff ff       	call   801607 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
}
  80190b:	90                   	nop
  80190c:	c9                   	leave  
  80190d:	c3                   	ret    

0080190e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80190e:	55                   	push   %ebp
  80190f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801911:	8b 55 0c             	mov    0xc(%ebp),%edx
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	52                   	push   %edx
  80191e:	50                   	push   %eax
  80191f:	6a 1a                	push   $0x1a
  801921:	e8 e1 fc ff ff       	call   801607 <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	90                   	nop
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
  80192f:	83 ec 04             	sub    $0x4,%esp
  801932:	8b 45 10             	mov    0x10(%ebp),%eax
  801935:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801938:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80193b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
  801942:	6a 00                	push   $0x0
  801944:	51                   	push   %ecx
  801945:	52                   	push   %edx
  801946:	ff 75 0c             	pushl  0xc(%ebp)
  801949:	50                   	push   %eax
  80194a:	6a 1c                	push   $0x1c
  80194c:	e8 b6 fc ff ff       	call   801607 <syscall>
  801951:	83 c4 18             	add    $0x18,%esp
}
  801954:	c9                   	leave  
  801955:	c3                   	ret    

00801956 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801956:	55                   	push   %ebp
  801957:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801959:	8b 55 0c             	mov    0xc(%ebp),%edx
  80195c:	8b 45 08             	mov    0x8(%ebp),%eax
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	52                   	push   %edx
  801966:	50                   	push   %eax
  801967:	6a 1d                	push   $0x1d
  801969:	e8 99 fc ff ff       	call   801607 <syscall>
  80196e:	83 c4 18             	add    $0x18,%esp
}
  801971:	c9                   	leave  
  801972:	c3                   	ret    

00801973 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801973:	55                   	push   %ebp
  801974:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801976:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801979:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197c:	8b 45 08             	mov    0x8(%ebp),%eax
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	51                   	push   %ecx
  801984:	52                   	push   %edx
  801985:	50                   	push   %eax
  801986:	6a 1e                	push   $0x1e
  801988:	e8 7a fc ff ff       	call   801607 <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
}
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801995:	8b 55 0c             	mov    0xc(%ebp),%edx
  801998:	8b 45 08             	mov    0x8(%ebp),%eax
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	52                   	push   %edx
  8019a2:	50                   	push   %eax
  8019a3:	6a 1f                	push   $0x1f
  8019a5:	e8 5d fc ff ff       	call   801607 <syscall>
  8019aa:	83 c4 18             	add    $0x18,%esp
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 20                	push   $0x20
  8019be:	e8 44 fc ff ff       	call   801607 <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8019cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	ff 75 10             	pushl  0x10(%ebp)
  8019d5:	ff 75 0c             	pushl  0xc(%ebp)
  8019d8:	50                   	push   %eax
  8019d9:	6a 21                	push   $0x21
  8019db:	e8 27 fc ff ff       	call   801607 <syscall>
  8019e0:	83 c4 18             	add    $0x18,%esp
}
  8019e3:	c9                   	leave  
  8019e4:	c3                   	ret    

008019e5 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019e5:	55                   	push   %ebp
  8019e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	50                   	push   %eax
  8019f4:	6a 22                	push   $0x22
  8019f6:	e8 0c fc ff ff       	call   801607 <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
}
  8019fe:	90                   	nop
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a04:	8b 45 08             	mov    0x8(%ebp),%eax
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	50                   	push   %eax
  801a10:	6a 23                	push   $0x23
  801a12:	e8 f0 fb ff ff       	call   801607 <syscall>
  801a17:	83 c4 18             	add    $0x18,%esp
}
  801a1a:	90                   	nop
  801a1b:	c9                   	leave  
  801a1c:	c3                   	ret    

00801a1d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a1d:	55                   	push   %ebp
  801a1e:	89 e5                	mov    %esp,%ebp
  801a20:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a23:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a26:	8d 50 04             	lea    0x4(%eax),%edx
  801a29:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	52                   	push   %edx
  801a33:	50                   	push   %eax
  801a34:	6a 24                	push   $0x24
  801a36:	e8 cc fb ff ff       	call   801607 <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
	return result;
  801a3e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a41:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a44:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a47:	89 01                	mov    %eax,(%ecx)
  801a49:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	c9                   	leave  
  801a50:	c2 04 00             	ret    $0x4

00801a53 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a53:	55                   	push   %ebp
  801a54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	ff 75 10             	pushl  0x10(%ebp)
  801a5d:	ff 75 0c             	pushl  0xc(%ebp)
  801a60:	ff 75 08             	pushl  0x8(%ebp)
  801a63:	6a 13                	push   $0x13
  801a65:	e8 9d fb ff ff       	call   801607 <syscall>
  801a6a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a6d:	90                   	nop
}
  801a6e:	c9                   	leave  
  801a6f:	c3                   	ret    

00801a70 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a70:	55                   	push   %ebp
  801a71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 25                	push   $0x25
  801a7f:	e8 83 fb ff ff       	call   801607 <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
  801a8c:	83 ec 04             	sub    $0x4,%esp
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a92:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a95:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	50                   	push   %eax
  801aa2:	6a 26                	push   $0x26
  801aa4:	e8 5e fb ff ff       	call   801607 <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
	return ;
  801aac:	90                   	nop
}
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <rsttst>:
void rsttst()
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 28                	push   $0x28
  801abe:	e8 44 fb ff ff       	call   801607 <syscall>
  801ac3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac6:	90                   	nop
}
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
  801acc:	83 ec 04             	sub    $0x4,%esp
  801acf:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ad5:	8b 55 18             	mov    0x18(%ebp),%edx
  801ad8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801adc:	52                   	push   %edx
  801add:	50                   	push   %eax
  801ade:	ff 75 10             	pushl  0x10(%ebp)
  801ae1:	ff 75 0c             	pushl  0xc(%ebp)
  801ae4:	ff 75 08             	pushl  0x8(%ebp)
  801ae7:	6a 27                	push   $0x27
  801ae9:	e8 19 fb ff ff       	call   801607 <syscall>
  801aee:	83 c4 18             	add    $0x18,%esp
	return ;
  801af1:	90                   	nop
}
  801af2:	c9                   	leave  
  801af3:	c3                   	ret    

00801af4 <chktst>:
void chktst(uint32 n)
{
  801af4:	55                   	push   %ebp
  801af5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	ff 75 08             	pushl  0x8(%ebp)
  801b02:	6a 29                	push   $0x29
  801b04:	e8 fe fa ff ff       	call   801607 <syscall>
  801b09:	83 c4 18             	add    $0x18,%esp
	return ;
  801b0c:	90                   	nop
}
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <inctst>:

void inctst()
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 2a                	push   $0x2a
  801b1e:	e8 e4 fa ff ff       	call   801607 <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
	return ;
  801b26:	90                   	nop
}
  801b27:	c9                   	leave  
  801b28:	c3                   	ret    

00801b29 <gettst>:
uint32 gettst()
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 2b                	push   $0x2b
  801b38:	e8 ca fa ff ff       	call   801607 <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
}
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
  801b45:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 2c                	push   $0x2c
  801b54:	e8 ae fa ff ff       	call   801607 <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
  801b5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b5f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b63:	75 07                	jne    801b6c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b65:	b8 01 00 00 00       	mov    $0x1,%eax
  801b6a:	eb 05                	jmp    801b71 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b71:	c9                   	leave  
  801b72:	c3                   	ret    

00801b73 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
  801b76:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 2c                	push   $0x2c
  801b85:	e8 7d fa ff ff       	call   801607 <syscall>
  801b8a:	83 c4 18             	add    $0x18,%esp
  801b8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b90:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b94:	75 07                	jne    801b9d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b96:	b8 01 00 00 00       	mov    $0x1,%eax
  801b9b:	eb 05                	jmp    801ba2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ba2:	c9                   	leave  
  801ba3:	c3                   	ret    

00801ba4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ba4:	55                   	push   %ebp
  801ba5:	89 e5                	mov    %esp,%ebp
  801ba7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 2c                	push   $0x2c
  801bb6:	e8 4c fa ff ff       	call   801607 <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
  801bbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bc1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bc5:	75 07                	jne    801bce <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bc7:	b8 01 00 00 00       	mov    $0x1,%eax
  801bcc:	eb 05                	jmp    801bd3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bd3:	c9                   	leave  
  801bd4:	c3                   	ret    

00801bd5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bd5:	55                   	push   %ebp
  801bd6:	89 e5                	mov    %esp,%ebp
  801bd8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 2c                	push   $0x2c
  801be7:	e8 1b fa ff ff       	call   801607 <syscall>
  801bec:	83 c4 18             	add    $0x18,%esp
  801bef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bf2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bf6:	75 07                	jne    801bff <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bf8:	b8 01 00 00 00       	mov    $0x1,%eax
  801bfd:	eb 05                	jmp    801c04 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c04:	c9                   	leave  
  801c05:	c3                   	ret    

00801c06 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c06:	55                   	push   %ebp
  801c07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	ff 75 08             	pushl  0x8(%ebp)
  801c14:	6a 2d                	push   $0x2d
  801c16:	e8 ec f9 ff ff       	call   801607 <syscall>
  801c1b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1e:	90                   	nop
}
  801c1f:	c9                   	leave  
  801c20:	c3                   	ret    
  801c21:	66 90                	xchg   %ax,%ax
  801c23:	90                   	nop

00801c24 <__udivdi3>:
  801c24:	55                   	push   %ebp
  801c25:	57                   	push   %edi
  801c26:	56                   	push   %esi
  801c27:	53                   	push   %ebx
  801c28:	83 ec 1c             	sub    $0x1c,%esp
  801c2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c3b:	89 ca                	mov    %ecx,%edx
  801c3d:	89 f8                	mov    %edi,%eax
  801c3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c43:	85 f6                	test   %esi,%esi
  801c45:	75 2d                	jne    801c74 <__udivdi3+0x50>
  801c47:	39 cf                	cmp    %ecx,%edi
  801c49:	77 65                	ja     801cb0 <__udivdi3+0x8c>
  801c4b:	89 fd                	mov    %edi,%ebp
  801c4d:	85 ff                	test   %edi,%edi
  801c4f:	75 0b                	jne    801c5c <__udivdi3+0x38>
  801c51:	b8 01 00 00 00       	mov    $0x1,%eax
  801c56:	31 d2                	xor    %edx,%edx
  801c58:	f7 f7                	div    %edi
  801c5a:	89 c5                	mov    %eax,%ebp
  801c5c:	31 d2                	xor    %edx,%edx
  801c5e:	89 c8                	mov    %ecx,%eax
  801c60:	f7 f5                	div    %ebp
  801c62:	89 c1                	mov    %eax,%ecx
  801c64:	89 d8                	mov    %ebx,%eax
  801c66:	f7 f5                	div    %ebp
  801c68:	89 cf                	mov    %ecx,%edi
  801c6a:	89 fa                	mov    %edi,%edx
  801c6c:	83 c4 1c             	add    $0x1c,%esp
  801c6f:	5b                   	pop    %ebx
  801c70:	5e                   	pop    %esi
  801c71:	5f                   	pop    %edi
  801c72:	5d                   	pop    %ebp
  801c73:	c3                   	ret    
  801c74:	39 ce                	cmp    %ecx,%esi
  801c76:	77 28                	ja     801ca0 <__udivdi3+0x7c>
  801c78:	0f bd fe             	bsr    %esi,%edi
  801c7b:	83 f7 1f             	xor    $0x1f,%edi
  801c7e:	75 40                	jne    801cc0 <__udivdi3+0x9c>
  801c80:	39 ce                	cmp    %ecx,%esi
  801c82:	72 0a                	jb     801c8e <__udivdi3+0x6a>
  801c84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c88:	0f 87 9e 00 00 00    	ja     801d2c <__udivdi3+0x108>
  801c8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c93:	89 fa                	mov    %edi,%edx
  801c95:	83 c4 1c             	add    $0x1c,%esp
  801c98:	5b                   	pop    %ebx
  801c99:	5e                   	pop    %esi
  801c9a:	5f                   	pop    %edi
  801c9b:	5d                   	pop    %ebp
  801c9c:	c3                   	ret    
  801c9d:	8d 76 00             	lea    0x0(%esi),%esi
  801ca0:	31 ff                	xor    %edi,%edi
  801ca2:	31 c0                	xor    %eax,%eax
  801ca4:	89 fa                	mov    %edi,%edx
  801ca6:	83 c4 1c             	add    $0x1c,%esp
  801ca9:	5b                   	pop    %ebx
  801caa:	5e                   	pop    %esi
  801cab:	5f                   	pop    %edi
  801cac:	5d                   	pop    %ebp
  801cad:	c3                   	ret    
  801cae:	66 90                	xchg   %ax,%ax
  801cb0:	89 d8                	mov    %ebx,%eax
  801cb2:	f7 f7                	div    %edi
  801cb4:	31 ff                	xor    %edi,%edi
  801cb6:	89 fa                	mov    %edi,%edx
  801cb8:	83 c4 1c             	add    $0x1c,%esp
  801cbb:	5b                   	pop    %ebx
  801cbc:	5e                   	pop    %esi
  801cbd:	5f                   	pop    %edi
  801cbe:	5d                   	pop    %ebp
  801cbf:	c3                   	ret    
  801cc0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cc5:	89 eb                	mov    %ebp,%ebx
  801cc7:	29 fb                	sub    %edi,%ebx
  801cc9:	89 f9                	mov    %edi,%ecx
  801ccb:	d3 e6                	shl    %cl,%esi
  801ccd:	89 c5                	mov    %eax,%ebp
  801ccf:	88 d9                	mov    %bl,%cl
  801cd1:	d3 ed                	shr    %cl,%ebp
  801cd3:	89 e9                	mov    %ebp,%ecx
  801cd5:	09 f1                	or     %esi,%ecx
  801cd7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cdb:	89 f9                	mov    %edi,%ecx
  801cdd:	d3 e0                	shl    %cl,%eax
  801cdf:	89 c5                	mov    %eax,%ebp
  801ce1:	89 d6                	mov    %edx,%esi
  801ce3:	88 d9                	mov    %bl,%cl
  801ce5:	d3 ee                	shr    %cl,%esi
  801ce7:	89 f9                	mov    %edi,%ecx
  801ce9:	d3 e2                	shl    %cl,%edx
  801ceb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cef:	88 d9                	mov    %bl,%cl
  801cf1:	d3 e8                	shr    %cl,%eax
  801cf3:	09 c2                	or     %eax,%edx
  801cf5:	89 d0                	mov    %edx,%eax
  801cf7:	89 f2                	mov    %esi,%edx
  801cf9:	f7 74 24 0c          	divl   0xc(%esp)
  801cfd:	89 d6                	mov    %edx,%esi
  801cff:	89 c3                	mov    %eax,%ebx
  801d01:	f7 e5                	mul    %ebp
  801d03:	39 d6                	cmp    %edx,%esi
  801d05:	72 19                	jb     801d20 <__udivdi3+0xfc>
  801d07:	74 0b                	je     801d14 <__udivdi3+0xf0>
  801d09:	89 d8                	mov    %ebx,%eax
  801d0b:	31 ff                	xor    %edi,%edi
  801d0d:	e9 58 ff ff ff       	jmp    801c6a <__udivdi3+0x46>
  801d12:	66 90                	xchg   %ax,%ax
  801d14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d18:	89 f9                	mov    %edi,%ecx
  801d1a:	d3 e2                	shl    %cl,%edx
  801d1c:	39 c2                	cmp    %eax,%edx
  801d1e:	73 e9                	jae    801d09 <__udivdi3+0xe5>
  801d20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d23:	31 ff                	xor    %edi,%edi
  801d25:	e9 40 ff ff ff       	jmp    801c6a <__udivdi3+0x46>
  801d2a:	66 90                	xchg   %ax,%ax
  801d2c:	31 c0                	xor    %eax,%eax
  801d2e:	e9 37 ff ff ff       	jmp    801c6a <__udivdi3+0x46>
  801d33:	90                   	nop

00801d34 <__umoddi3>:
  801d34:	55                   	push   %ebp
  801d35:	57                   	push   %edi
  801d36:	56                   	push   %esi
  801d37:	53                   	push   %ebx
  801d38:	83 ec 1c             	sub    $0x1c,%esp
  801d3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d53:	89 f3                	mov    %esi,%ebx
  801d55:	89 fa                	mov    %edi,%edx
  801d57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d5b:	89 34 24             	mov    %esi,(%esp)
  801d5e:	85 c0                	test   %eax,%eax
  801d60:	75 1a                	jne    801d7c <__umoddi3+0x48>
  801d62:	39 f7                	cmp    %esi,%edi
  801d64:	0f 86 a2 00 00 00    	jbe    801e0c <__umoddi3+0xd8>
  801d6a:	89 c8                	mov    %ecx,%eax
  801d6c:	89 f2                	mov    %esi,%edx
  801d6e:	f7 f7                	div    %edi
  801d70:	89 d0                	mov    %edx,%eax
  801d72:	31 d2                	xor    %edx,%edx
  801d74:	83 c4 1c             	add    $0x1c,%esp
  801d77:	5b                   	pop    %ebx
  801d78:	5e                   	pop    %esi
  801d79:	5f                   	pop    %edi
  801d7a:	5d                   	pop    %ebp
  801d7b:	c3                   	ret    
  801d7c:	39 f0                	cmp    %esi,%eax
  801d7e:	0f 87 ac 00 00 00    	ja     801e30 <__umoddi3+0xfc>
  801d84:	0f bd e8             	bsr    %eax,%ebp
  801d87:	83 f5 1f             	xor    $0x1f,%ebp
  801d8a:	0f 84 ac 00 00 00    	je     801e3c <__umoddi3+0x108>
  801d90:	bf 20 00 00 00       	mov    $0x20,%edi
  801d95:	29 ef                	sub    %ebp,%edi
  801d97:	89 fe                	mov    %edi,%esi
  801d99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d9d:	89 e9                	mov    %ebp,%ecx
  801d9f:	d3 e0                	shl    %cl,%eax
  801da1:	89 d7                	mov    %edx,%edi
  801da3:	89 f1                	mov    %esi,%ecx
  801da5:	d3 ef                	shr    %cl,%edi
  801da7:	09 c7                	or     %eax,%edi
  801da9:	89 e9                	mov    %ebp,%ecx
  801dab:	d3 e2                	shl    %cl,%edx
  801dad:	89 14 24             	mov    %edx,(%esp)
  801db0:	89 d8                	mov    %ebx,%eax
  801db2:	d3 e0                	shl    %cl,%eax
  801db4:	89 c2                	mov    %eax,%edx
  801db6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dba:	d3 e0                	shl    %cl,%eax
  801dbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dc0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dc4:	89 f1                	mov    %esi,%ecx
  801dc6:	d3 e8                	shr    %cl,%eax
  801dc8:	09 d0                	or     %edx,%eax
  801dca:	d3 eb                	shr    %cl,%ebx
  801dcc:	89 da                	mov    %ebx,%edx
  801dce:	f7 f7                	div    %edi
  801dd0:	89 d3                	mov    %edx,%ebx
  801dd2:	f7 24 24             	mull   (%esp)
  801dd5:	89 c6                	mov    %eax,%esi
  801dd7:	89 d1                	mov    %edx,%ecx
  801dd9:	39 d3                	cmp    %edx,%ebx
  801ddb:	0f 82 87 00 00 00    	jb     801e68 <__umoddi3+0x134>
  801de1:	0f 84 91 00 00 00    	je     801e78 <__umoddi3+0x144>
  801de7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801deb:	29 f2                	sub    %esi,%edx
  801ded:	19 cb                	sbb    %ecx,%ebx
  801def:	89 d8                	mov    %ebx,%eax
  801df1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801df5:	d3 e0                	shl    %cl,%eax
  801df7:	89 e9                	mov    %ebp,%ecx
  801df9:	d3 ea                	shr    %cl,%edx
  801dfb:	09 d0                	or     %edx,%eax
  801dfd:	89 e9                	mov    %ebp,%ecx
  801dff:	d3 eb                	shr    %cl,%ebx
  801e01:	89 da                	mov    %ebx,%edx
  801e03:	83 c4 1c             	add    $0x1c,%esp
  801e06:	5b                   	pop    %ebx
  801e07:	5e                   	pop    %esi
  801e08:	5f                   	pop    %edi
  801e09:	5d                   	pop    %ebp
  801e0a:	c3                   	ret    
  801e0b:	90                   	nop
  801e0c:	89 fd                	mov    %edi,%ebp
  801e0e:	85 ff                	test   %edi,%edi
  801e10:	75 0b                	jne    801e1d <__umoddi3+0xe9>
  801e12:	b8 01 00 00 00       	mov    $0x1,%eax
  801e17:	31 d2                	xor    %edx,%edx
  801e19:	f7 f7                	div    %edi
  801e1b:	89 c5                	mov    %eax,%ebp
  801e1d:	89 f0                	mov    %esi,%eax
  801e1f:	31 d2                	xor    %edx,%edx
  801e21:	f7 f5                	div    %ebp
  801e23:	89 c8                	mov    %ecx,%eax
  801e25:	f7 f5                	div    %ebp
  801e27:	89 d0                	mov    %edx,%eax
  801e29:	e9 44 ff ff ff       	jmp    801d72 <__umoddi3+0x3e>
  801e2e:	66 90                	xchg   %ax,%ax
  801e30:	89 c8                	mov    %ecx,%eax
  801e32:	89 f2                	mov    %esi,%edx
  801e34:	83 c4 1c             	add    $0x1c,%esp
  801e37:	5b                   	pop    %ebx
  801e38:	5e                   	pop    %esi
  801e39:	5f                   	pop    %edi
  801e3a:	5d                   	pop    %ebp
  801e3b:	c3                   	ret    
  801e3c:	3b 04 24             	cmp    (%esp),%eax
  801e3f:	72 06                	jb     801e47 <__umoddi3+0x113>
  801e41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e45:	77 0f                	ja     801e56 <__umoddi3+0x122>
  801e47:	89 f2                	mov    %esi,%edx
  801e49:	29 f9                	sub    %edi,%ecx
  801e4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e4f:	89 14 24             	mov    %edx,(%esp)
  801e52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e5a:	8b 14 24             	mov    (%esp),%edx
  801e5d:	83 c4 1c             	add    $0x1c,%esp
  801e60:	5b                   	pop    %ebx
  801e61:	5e                   	pop    %esi
  801e62:	5f                   	pop    %edi
  801e63:	5d                   	pop    %ebp
  801e64:	c3                   	ret    
  801e65:	8d 76 00             	lea    0x0(%esi),%esi
  801e68:	2b 04 24             	sub    (%esp),%eax
  801e6b:	19 fa                	sbb    %edi,%edx
  801e6d:	89 d1                	mov    %edx,%ecx
  801e6f:	89 c6                	mov    %eax,%esi
  801e71:	e9 71 ff ff ff       	jmp    801de7 <__umoddi3+0xb3>
  801e76:	66 90                	xchg   %ax,%ax
  801e78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e7c:	72 ea                	jb     801e68 <__umoddi3+0x134>
  801e7e:	89 d9                	mov    %ebx,%ecx
  801e80:	e9 62 ff ff ff       	jmp    801de7 <__umoddi3+0xb3>
