
obj/user/tst_page_replacement_FIFO_2_oldBuggyOne:     file format elf32-i386


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
  800031:	e8 97 08 00 00       	call   8008cd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
uint8* ptr = (uint8* )0x0801000 ;
uint8* ptr2 = (uint8* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec b8 00 00 00    	sub    $0xb8,%esp
	
//	cprintf("envID = %d\n",envID);

	
	
	char* tempArr = (char*)0x80000000;
  800041:	c7 45 ec 00 00 00 80 	movl   $0x80000000,-0x14(%ebp)
	//sys_allocateMem(0x80000000, 15*1024);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800048:	a1 20 30 80 00       	mov    0x803020,%eax
  80004d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800053:	8b 00                	mov    (%eax),%eax
  800055:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800058:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80005b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800060:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800065:	74 14                	je     80007b <_main+0x43>
  800067:	83 ec 04             	sub    $0x4,%esp
  80006a:	68 a0 22 80 00       	push   $0x8022a0
  80006f:	6a 17                	push   $0x17
  800071:	68 e4 22 80 00       	push   $0x8022e4
  800076:	e8 54 09 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80007b:	a1 20 30 80 00       	mov    0x803020,%eax
  800080:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800086:	83 c0 0c             	add    $0xc,%eax
  800089:	8b 00                	mov    (%eax),%eax
  80008b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80008e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800091:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800096:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80009b:	74 14                	je     8000b1 <_main+0x79>
  80009d:	83 ec 04             	sub    $0x4,%esp
  8000a0:	68 a0 22 80 00       	push   $0x8022a0
  8000a5:	6a 18                	push   $0x18
  8000a7:	68 e4 22 80 00       	push   $0x8022e4
  8000ac:	e8 1e 09 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b6:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000bc:	83 c0 18             	add    $0x18,%eax
  8000bf:	8b 00                	mov    (%eax),%eax
  8000c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000cc:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000d1:	74 14                	je     8000e7 <_main+0xaf>
  8000d3:	83 ec 04             	sub    $0x4,%esp
  8000d6:	68 a0 22 80 00       	push   $0x8022a0
  8000db:	6a 19                	push   $0x19
  8000dd:	68 e4 22 80 00       	push   $0x8022e4
  8000e2:	e8 e8 08 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ec:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000f2:	83 c0 24             	add    $0x24,%eax
  8000f5:	8b 00                	mov    (%eax),%eax
  8000f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8000fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800102:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800107:	74 14                	je     80011d <_main+0xe5>
  800109:	83 ec 04             	sub    $0x4,%esp
  80010c:	68 a0 22 80 00       	push   $0x8022a0
  800111:	6a 1a                	push   $0x1a
  800113:	68 e4 22 80 00       	push   $0x8022e4
  800118:	e8 b2 08 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80011d:	a1 20 30 80 00       	mov    0x803020,%eax
  800122:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800128:	83 c0 30             	add    $0x30,%eax
  80012b:	8b 00                	mov    (%eax),%eax
  80012d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800130:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800133:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800138:	3d 00 40 20 00       	cmp    $0x204000,%eax
  80013d:	74 14                	je     800153 <_main+0x11b>
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	68 a0 22 80 00       	push   $0x8022a0
  800147:	6a 1b                	push   $0x1b
  800149:	68 e4 22 80 00       	push   $0x8022e4
  80014e:	e8 7c 08 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800153:	a1 20 30 80 00       	mov    0x803020,%eax
  800158:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80015e:	83 c0 3c             	add    $0x3c,%eax
  800161:	8b 00                	mov    (%eax),%eax
  800163:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800166:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800169:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016e:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 a0 22 80 00       	push   $0x8022a0
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 e4 22 80 00       	push   $0x8022e4
  800184:	e8 46 08 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800189:	a1 20 30 80 00       	mov    0x803020,%eax
  80018e:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800194:	83 c0 48             	add    $0x48,%eax
  800197:	8b 00                	mov    (%eax),%eax
  800199:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80019c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80019f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a4:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a9:	74 14                	je     8001bf <_main+0x187>
  8001ab:	83 ec 04             	sub    $0x4,%esp
  8001ae:	68 a0 22 80 00       	push   $0x8022a0
  8001b3:	6a 1d                	push   $0x1d
  8001b5:	68 e4 22 80 00       	push   $0x8022e4
  8001ba:	e8 10 08 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c4:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001ca:	83 c0 54             	add    $0x54,%eax
  8001cd:	8b 00                	mov    (%eax),%eax
  8001cf:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001d2:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001da:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001df:	74 14                	je     8001f5 <_main+0x1bd>
  8001e1:	83 ec 04             	sub    $0x4,%esp
  8001e4:	68 a0 22 80 00       	push   $0x8022a0
  8001e9:	6a 1e                	push   $0x1e
  8001eb:	68 e4 22 80 00       	push   $0x8022e4
  8001f0:	e8 da 07 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fa:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800200:	83 c0 60             	add    $0x60,%eax
  800203:	8b 00                	mov    (%eax),%eax
  800205:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800208:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80020b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800210:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800215:	74 14                	je     80022b <_main+0x1f3>
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	68 a0 22 80 00       	push   $0x8022a0
  80021f:	6a 1f                	push   $0x1f
  800221:	68 e4 22 80 00       	push   $0x8022e4
  800226:	e8 a4 07 00 00       	call   8009cf <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80022b:	a1 20 30 80 00       	mov    0x803020,%eax
  800230:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800236:	85 c0                	test   %eax,%eax
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 14 23 80 00       	push   $0x802314
  800242:	6a 20                	push   $0x20
  800244:	68 e4 22 80 00       	push   $0x8022e4
  800249:	e8 81 07 00 00       	call   8009cf <_panic>
	}

	int freePages = sys_calculate_free_frames();
  80024e:	e8 26 19 00 00       	call   801b79 <sys_calculate_free_frames>
  800253:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800256:	e8 a1 19 00 00       	call   801bfc <sys_pf_calculate_allocated_pages>
  80025b:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  80025e:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800263:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  800266:	a0 3f f0 80 00       	mov    0x80f03f,%al
  80026b:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  80026e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800275:	eb 37                	jmp    8002ae <_main+0x276>
	{
		arr[i] = -1 ;
  800277:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80027a:	05 40 30 80 00       	add    $0x803040,%eax
  80027f:	c6 00 ff             	movb   $0xff,(%eax)
		*ptr = *ptr2 ;
  800282:	a1 00 30 80 00       	mov    0x803000,%eax
  800287:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80028d:	8a 12                	mov    (%edx),%dl
  80028f:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800291:	a1 00 30 80 00       	mov    0x803000,%eax
  800296:	40                   	inc    %eax
  800297:	a3 00 30 80 00       	mov    %eax,0x803000
  80029c:	a1 04 30 80 00       	mov    0x803004,%eax
  8002a1:	40                   	inc    %eax
  8002a2:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1];
	char garbage2 = arr[PAGE_SIZE*12-1];

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  8002a7:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8002ae:	81 7d f4 ff 4f 00 00 	cmpl   $0x4fff,-0xc(%ebp)
  8002b5:	7e c0                	jle    800277 <_main+0x23f>
		ptr++ ; ptr2++ ;
	}

	//Check FIFO 1
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8002b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bc:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002c2:	8b 00                	mov    (%eax),%eax
  8002c4:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8002c7:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002cf:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002d4:	74 14                	je     8002ea <_main+0x2b2>
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	68 5c 23 80 00       	push   $0x80235c
  8002de:	6a 35                	push   $0x35
  8002e0:	68 e4 22 80 00       	push   $0x8022e4
  8002e5:	e8 e5 06 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8002ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ef:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8002f5:	83 c0 0c             	add    $0xc,%eax
  8002f8:	8b 00                	mov    (%eax),%eax
  8002fa:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8002fd:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800300:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800305:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  80030a:	74 14                	je     800320 <_main+0x2e8>
  80030c:	83 ec 04             	sub    $0x4,%esp
  80030f:	68 5c 23 80 00       	push   $0x80235c
  800314:	6a 36                	push   $0x36
  800316:	68 e4 22 80 00       	push   $0x8022e4
  80031b:	e8 af 06 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800320:	a1 20 30 80 00       	mov    0x803020,%eax
  800325:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80032b:	83 c0 18             	add    $0x18,%eax
  80032e:	8b 00                	mov    (%eax),%eax
  800330:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800333:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800336:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80033b:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800340:	74 14                	je     800356 <_main+0x31e>
  800342:	83 ec 04             	sub    $0x4,%esp
  800345:	68 5c 23 80 00       	push   $0x80235c
  80034a:	6a 37                	push   $0x37
  80034c:	68 e4 22 80 00       	push   $0x8022e4
  800351:	e8 79 06 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800356:	a1 20 30 80 00       	mov    0x803020,%eax
  80035b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800361:	83 c0 24             	add    $0x24,%eax
  800364:	8b 00                	mov    (%eax),%eax
  800366:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800369:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80036c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800371:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800376:	74 14                	je     80038c <_main+0x354>
  800378:	83 ec 04             	sub    $0x4,%esp
  80037b:	68 5c 23 80 00       	push   $0x80235c
  800380:	6a 38                	push   $0x38
  800382:	68 e4 22 80 00       	push   $0x8022e4
  800387:	e8 43 06 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80038c:	a1 20 30 80 00       	mov    0x803020,%eax
  800391:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800397:	83 c0 30             	add    $0x30,%eax
  80039a:	8b 00                	mov    (%eax),%eax
  80039c:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80039f:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003a7:	3d 00 50 80 00       	cmp    $0x805000,%eax
  8003ac:	74 14                	je     8003c2 <_main+0x38a>
  8003ae:	83 ec 04             	sub    $0x4,%esp
  8003b1:	68 5c 23 80 00       	push   $0x80235c
  8003b6:	6a 39                	push   $0x39
  8003b8:	68 e4 22 80 00       	push   $0x8022e4
  8003bd:	e8 0d 06 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c7:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003cd:	83 c0 3c             	add    $0x3c,%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8003d5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003dd:	3d 00 60 80 00       	cmp    $0x806000,%eax
  8003e2:	74 14                	je     8003f8 <_main+0x3c0>
  8003e4:	83 ec 04             	sub    $0x4,%esp
  8003e7:	68 5c 23 80 00       	push   $0x80235c
  8003ec:	6a 3a                	push   $0x3a
  8003ee:	68 e4 22 80 00       	push   $0x8022e4
  8003f3:	e8 d7 05 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800403:	83 c0 48             	add    $0x48,%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80040b:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80040e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800413:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800418:	74 14                	je     80042e <_main+0x3f6>
  80041a:	83 ec 04             	sub    $0x4,%esp
  80041d:	68 5c 23 80 00       	push   $0x80235c
  800422:	6a 3b                	push   $0x3b
  800424:	68 e4 22 80 00       	push   $0x8022e4
  800429:	e8 a1 05 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80042e:	a1 20 30 80 00       	mov    0x803020,%eax
  800433:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800439:	83 c0 54             	add    $0x54,%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800441:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800444:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800449:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80044e:	74 14                	je     800464 <_main+0x42c>
  800450:	83 ec 04             	sub    $0x4,%esp
  800453:	68 5c 23 80 00       	push   $0x80235c
  800458:	6a 3c                	push   $0x3c
  80045a:	68 e4 22 80 00       	push   $0x8022e4
  80045f:	e8 6b 05 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800464:	a1 20 30 80 00       	mov    0x803020,%eax
  800469:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80046f:	83 c0 60             	add    $0x60,%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	89 45 98             	mov    %eax,-0x68(%ebp)
  800477:	8b 45 98             	mov    -0x68(%ebp),%eax
  80047a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80047f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800484:	74 14                	je     80049a <_main+0x462>
  800486:	83 ec 04             	sub    $0x4,%esp
  800489:	68 5c 23 80 00       	push   $0x80235c
  80048e:	6a 3d                	push   $0x3d
  800490:	68 e4 22 80 00       	push   $0x8022e4
  800495:	e8 35 05 00 00       	call   8009cf <_panic>

		if(myEnv->page_last_WS_index != 1) panic("wrong PAGE WS pointer location");
  80049a:	a1 20 30 80 00       	mov    0x803020,%eax
  80049f:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  8004a5:	83 f8 01             	cmp    $0x1,%eax
  8004a8:	74 14                	je     8004be <_main+0x486>
  8004aa:	83 ec 04             	sub    $0x4,%esp
  8004ad:	68 a8 23 80 00       	push   $0x8023a8
  8004b2:	6a 3f                	push   $0x3f
  8004b4:	68 e4 22 80 00       	push   $0x8022e4
  8004b9:	e8 11 05 00 00       	call   8009cf <_panic>
	}

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
  8004be:	83 ec 08             	sub    $0x8,%esp
  8004c1:	68 00 40 00 00       	push   $0x4000
  8004c6:	68 00 00 00 80       	push   $0x80000000
  8004cb:	e8 10 17 00 00       	call   801be0 <sys_allocateMem>
  8004d0:	83 c4 10             	add    $0x10,%esp
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8004d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004da:	eb 0e                	jmp    8004ea <_main+0x4b2>
	{
		tempArr[c] = 'a';
  8004dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004e2:	01 d0                	add    %edx,%eax
  8004e4:	c6 00 61             	movb   $0x61,(%eax)

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8004e7:	ff 45 f0             	incl   -0x10(%ebp)
  8004ea:	81 7d f0 ff 3b 00 00 	cmpl   $0x3bff,-0x10(%ebp)
  8004f1:	7e e9                	jle    8004dc <_main+0x4a4>
		tempArr[c] = 'a';
	}

	//cprintf("2\n");

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
  8004f3:	83 ec 08             	sub    $0x8,%esp
  8004f6:	68 00 40 00 00       	push   $0x4000
  8004fb:	68 00 00 00 80       	push   $0x80000000
  800500:	e8 bf 16 00 00       	call   801bc4 <sys_freeMem>
  800505:	83 c4 10             	add    $0x10,%esp
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800508:	c7 45 f4 00 50 00 00 	movl   $0x5000,-0xc(%ebp)
  80050f:	eb 37                	jmp    800548 <_main+0x510>
	{
		arr[i] = -1 ;
  800511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800514:	05 40 30 80 00       	add    $0x803040,%eax
  800519:	c6 00 ff             	movb   $0xff,(%eax)
		*ptr = *ptr2 ;
  80051c:	a1 00 30 80 00       	mov    0x803000,%eax
  800521:	8b 15 04 30 80 00    	mov    0x803004,%edx
  800527:	8a 12                	mov    (%edx),%dl
  800529:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  80052b:	a1 00 30 80 00       	mov    0x803000,%eax
  800530:	40                   	inc    %eax
  800531:	a3 00 30 80 00       	mov    %eax,0x803000
  800536:	a1 04 30 80 00       	mov    0x803004,%eax
  80053b:	40                   	inc    %eax
  80053c:	a3 04 30 80 00       	mov    %eax,0x803004

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800541:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800548:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80054f:	7e c0                	jle    800511 <_main+0x4d9>
	//cprintf("4\n");

	//===================
	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800551:	a1 20 30 80 00       	mov    0x803020,%eax
  800556:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80055c:	8b 00                	mov    (%eax),%eax
  80055e:	89 45 94             	mov    %eax,-0x6c(%ebp)
  800561:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800564:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800569:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  80056e:	74 14                	je     800584 <_main+0x54c>
  800570:	83 ec 04             	sub    $0x4,%esp
  800573:	68 5c 23 80 00       	push   $0x80235c
  800578:	6a 5c                	push   $0x5c
  80057a:	68 e4 22 80 00       	push   $0x8022e4
  80057f:	e8 4b 04 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0xeebfd000 && ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x801000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800584:	a1 20 30 80 00       	mov    0x803020,%eax
  800589:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80058f:	83 c0 0c             	add    $0xc,%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	89 45 90             	mov    %eax,-0x70(%ebp)
  800597:	8b 45 90             	mov    -0x70(%ebp),%eax
  80059a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80059f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8005a4:	74 36                	je     8005dc <_main+0x5a4>
  8005a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ab:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005b1:	83 c0 0c             	add    $0xc,%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8005b9:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8005bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005c1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8005c6:	74 14                	je     8005dc <_main+0x5a4>
  8005c8:	83 ec 04             	sub    $0x4,%esp
  8005cb:	68 5c 23 80 00       	push   $0x80235c
  8005d0:	6a 5d                	push   $0x5d
  8005d2:	68 e4 22 80 00       	push   $0x8022e4
  8005d7:	e8 f3 03 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80b000 && ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x803000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8005e7:	83 c0 18             	add    $0x18,%eax
  8005ea:	8b 00                	mov    (%eax),%eax
  8005ec:	89 45 88             	mov    %eax,-0x78(%ebp)
  8005ef:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005f7:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8005fc:	74 36                	je     800634 <_main+0x5fc>
  8005fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800603:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800609:	83 c0 18             	add    $0x18,%eax
  80060c:	8b 00                	mov    (%eax),%eax
  80060e:	89 45 84             	mov    %eax,-0x7c(%ebp)
  800611:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800614:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800619:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80061e:	74 14                	je     800634 <_main+0x5fc>
  800620:	83 ec 04             	sub    $0x4,%esp
  800623:	68 5c 23 80 00       	push   $0x80235c
  800628:	6a 5e                	push   $0x5e
  80062a:	68 e4 22 80 00       	push   $0x8022e4
  80062f:	e8 9b 03 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x80c000 && ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800634:	a1 20 30 80 00       	mov    0x803020,%eax
  800639:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80063f:	83 c0 24             	add    $0x24,%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	89 45 80             	mov    %eax,-0x80(%ebp)
  800647:	8b 45 80             	mov    -0x80(%ebp),%eax
  80064a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80064f:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800654:	74 3c                	je     800692 <_main+0x65a>
  800656:	a1 20 30 80 00       	mov    0x803020,%eax
  80065b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800661:	83 c0 24             	add    $0x24,%eax
  800664:	8b 00                	mov    (%eax),%eax
  800666:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80066c:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800672:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800677:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80067c:	74 14                	je     800692 <_main+0x65a>
  80067e:	83 ec 04             	sub    $0x4,%esp
  800681:	68 5c 23 80 00       	push   $0x80235c
  800686:	6a 5f                	push   $0x5f
  800688:	68 e4 22 80 00       	push   $0x8022e4
  80068d:	e8 3d 03 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x800000 && ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x809000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800692:	a1 20 30 80 00       	mov    0x803020,%eax
  800697:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80069d:	83 c0 30             	add    $0x30,%eax
  8006a0:	8b 00                	mov    (%eax),%eax
  8006a2:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  8006a8:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8006ae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006b3:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8006b8:	74 3c                	je     8006f6 <_main+0x6be>
  8006ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8006bf:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8006c5:	83 c0 30             	add    $0x30,%eax
  8006c8:	8b 00                	mov    (%eax),%eax
  8006ca:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  8006d0:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8006d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006db:	3d 00 90 80 00       	cmp    $0x809000,%eax
  8006e0:	74 14                	je     8006f6 <_main+0x6be>
  8006e2:	83 ec 04             	sub    $0x4,%esp
  8006e5:	68 5c 23 80 00       	push   $0x80235c
  8006ea:	6a 60                	push   $0x60
  8006ec:	68 e4 22 80 00       	push   $0x8022e4
  8006f1:	e8 d9 02 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x801000 && ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0xeebfd000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8006fb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800701:	83 c0 3c             	add    $0x3c,%eax
  800704:	8b 00                	mov    (%eax),%eax
  800706:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  80070c:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800712:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800717:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80071c:	74 3c                	je     80075a <_main+0x722>
  80071e:	a1 20 30 80 00       	mov    0x803020,%eax
  800723:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800729:	83 c0 3c             	add    $0x3c,%eax
  80072c:	8b 00                	mov    (%eax),%eax
  80072e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800734:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80073a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80073f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800744:	74 14                	je     80075a <_main+0x722>
  800746:	83 ec 04             	sub    $0x4,%esp
  800749:	68 5c 23 80 00       	push   $0x80235c
  80074e:	6a 61                	push   $0x61
  800750:	68 e4 22 80 00       	push   $0x8022e4
  800755:	e8 75 02 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x803000 && ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x80b000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80075a:	a1 20 30 80 00       	mov    0x803020,%eax
  80075f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800765:	83 c0 48             	add    $0x48,%eax
  800768:	8b 00                	mov    (%eax),%eax
  80076a:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800770:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800776:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80077b:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800780:	74 3c                	je     8007be <_main+0x786>
  800782:	a1 20 30 80 00       	mov    0x803020,%eax
  800787:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80078d:	83 c0 48             	add    $0x48,%eax
  800790:	8b 00                	mov    (%eax),%eax
  800792:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800798:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80079e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007a3:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8007a8:	74 14                	je     8007be <_main+0x786>
  8007aa:	83 ec 04             	sub    $0x4,%esp
  8007ad:	68 5c 23 80 00       	push   $0x80235c
  8007b2:	6a 62                	push   $0x62
  8007b4:	68 e4 22 80 00       	push   $0x8022e4
  8007b9:	e8 11 02 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x804000 && ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x80c000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8007be:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8007c9:	83 c0 54             	add    $0x54,%eax
  8007cc:	8b 00                	mov    (%eax),%eax
  8007ce:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8007d4:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8007da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007df:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8007e4:	74 3c                	je     800822 <_main+0x7ea>
  8007e6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007eb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8007f1:	83 c0 54             	add    $0x54,%eax
  8007f4:	8b 00                	mov    (%eax),%eax
  8007f6:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8007fc:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800802:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800807:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  80080c:	74 14                	je     800822 <_main+0x7ea>
  80080e:	83 ec 04             	sub    $0x4,%esp
  800811:	68 5c 23 80 00       	push   $0x80235c
  800816:	6a 63                	push   $0x63
  800818:	68 e4 22 80 00       	push   $0x8022e4
  80081d:	e8 ad 01 00 00       	call   8009cf <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x809000 && ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x800000) panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800822:	a1 20 30 80 00       	mov    0x803020,%eax
  800827:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80082d:	83 c0 60             	add    $0x60,%eax
  800830:	8b 00                	mov    (%eax),%eax
  800832:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800838:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  80083e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800843:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800848:	74 3c                	je     800886 <_main+0x84e>
  80084a:	a1 20 30 80 00       	mov    0x803020,%eax
  80084f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800855:	83 c0 60             	add    $0x60,%eax
  800858:	8b 00                	mov    (%eax),%eax
  80085a:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800860:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800866:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80086b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800870:	74 14                	je     800886 <_main+0x84e>
  800872:	83 ec 04             	sub    $0x4,%esp
  800875:	68 5c 23 80 00       	push   $0x80235c
  80087a:	6a 64                	push   $0x64
  80087c:	68 e4 22 80 00       	push   $0x8022e4
  800881:	e8 49 01 00 00       	call   8009cf <_panic>

		if(myEnv->page_last_WS_index != 6 && myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
  800886:	a1 20 30 80 00       	mov    0x803020,%eax
  80088b:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800891:	83 f8 06             	cmp    $0x6,%eax
  800894:	74 24                	je     8008ba <_main+0x882>
  800896:	a1 20 30 80 00       	mov    0x803020,%eax
  80089b:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  8008a1:	83 f8 02             	cmp    $0x2,%eax
  8008a4:	74 14                	je     8008ba <_main+0x882>
  8008a6:	83 ec 04             	sub    $0x4,%esp
  8008a9:	68 a8 23 80 00       	push   $0x8023a8
  8008ae:	6a 66                	push   $0x66
  8008b0:	68 e4 22 80 00       	push   $0x8022e4
  8008b5:	e8 15 01 00 00       	call   8009cf <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FIFO Alg.] is completed successfully.\n");
  8008ba:	83 ec 0c             	sub    $0xc,%esp
  8008bd:	68 c8 23 80 00       	push   $0x8023c8
  8008c2:	e8 bc 03 00 00       	call   800c83 <cprintf>
  8008c7:	83 c4 10             	add    $0x10,%esp
	return;
  8008ca:	90                   	nop
}
  8008cb:	c9                   	leave  
  8008cc:	c3                   	ret    

008008cd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008cd:	55                   	push   %ebp
  8008ce:	89 e5                	mov    %esp,%ebp
  8008d0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008d3:	e8 d6 11 00 00       	call   801aae <sys_getenvindex>
  8008d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008de:	89 d0                	mov    %edx,%eax
  8008e0:	01 c0                	add    %eax,%eax
  8008e2:	01 d0                	add    %edx,%eax
  8008e4:	c1 e0 02             	shl    $0x2,%eax
  8008e7:	01 d0                	add    %edx,%eax
  8008e9:	c1 e0 06             	shl    $0x6,%eax
  8008ec:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8008f1:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8008f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8008fb:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800901:	84 c0                	test   %al,%al
  800903:	74 0f                	je     800914 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800905:	a1 20 30 80 00       	mov    0x803020,%eax
  80090a:	05 f4 02 00 00       	add    $0x2f4,%eax
  80090f:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800914:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800918:	7e 0a                	jle    800924 <libmain+0x57>
		binaryname = argv[0];
  80091a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091d:	8b 00                	mov    (%eax),%eax
  80091f:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800924:	83 ec 08             	sub    $0x8,%esp
  800927:	ff 75 0c             	pushl  0xc(%ebp)
  80092a:	ff 75 08             	pushl  0x8(%ebp)
  80092d:	e8 06 f7 ff ff       	call   800038 <_main>
  800932:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800935:	e8 0f 13 00 00       	call   801c49 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80093a:	83 ec 0c             	sub    $0xc,%esp
  80093d:	68 30 24 80 00       	push   $0x802430
  800942:	e8 3c 03 00 00       	call   800c83 <cprintf>
  800947:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80094a:	a1 20 30 80 00       	mov    0x803020,%eax
  80094f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800955:	a1 20 30 80 00       	mov    0x803020,%eax
  80095a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800960:	83 ec 04             	sub    $0x4,%esp
  800963:	52                   	push   %edx
  800964:	50                   	push   %eax
  800965:	68 58 24 80 00       	push   $0x802458
  80096a:	e8 14 03 00 00       	call   800c83 <cprintf>
  80096f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800972:	a1 20 30 80 00       	mov    0x803020,%eax
  800977:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80097d:	83 ec 08             	sub    $0x8,%esp
  800980:	50                   	push   %eax
  800981:	68 7d 24 80 00       	push   $0x80247d
  800986:	e8 f8 02 00 00       	call   800c83 <cprintf>
  80098b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80098e:	83 ec 0c             	sub    $0xc,%esp
  800991:	68 30 24 80 00       	push   $0x802430
  800996:	e8 e8 02 00 00       	call   800c83 <cprintf>
  80099b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80099e:	e8 c0 12 00 00       	call   801c63 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009a3:	e8 19 00 00 00       	call   8009c1 <exit>
}
  8009a8:	90                   	nop
  8009a9:	c9                   	leave  
  8009aa:	c3                   	ret    

008009ab <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
  8009ae:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009b1:	83 ec 0c             	sub    $0xc,%esp
  8009b4:	6a 00                	push   $0x0
  8009b6:	e8 bf 10 00 00       	call   801a7a <sys_env_destroy>
  8009bb:	83 c4 10             	add    $0x10,%esp
}
  8009be:	90                   	nop
  8009bf:	c9                   	leave  
  8009c0:	c3                   	ret    

008009c1 <exit>:

void
exit(void)
{
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009c7:	e8 14 11 00 00       	call   801ae0 <sys_env_exit>
}
  8009cc:	90                   	nop
  8009cd:	c9                   	leave  
  8009ce:	c3                   	ret    

008009cf <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009cf:	55                   	push   %ebp
  8009d0:	89 e5                	mov    %esp,%ebp
  8009d2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009d5:	8d 45 10             	lea    0x10(%ebp),%eax
  8009d8:	83 c0 04             	add    $0x4,%eax
  8009db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009de:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8009e3:	85 c0                	test   %eax,%eax
  8009e5:	74 16                	je     8009fd <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009e7:	a1 48 f0 80 00       	mov    0x80f048,%eax
  8009ec:	83 ec 08             	sub    $0x8,%esp
  8009ef:	50                   	push   %eax
  8009f0:	68 94 24 80 00       	push   $0x802494
  8009f5:	e8 89 02 00 00       	call   800c83 <cprintf>
  8009fa:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8009fd:	a1 08 30 80 00       	mov    0x803008,%eax
  800a02:	ff 75 0c             	pushl  0xc(%ebp)
  800a05:	ff 75 08             	pushl  0x8(%ebp)
  800a08:	50                   	push   %eax
  800a09:	68 99 24 80 00       	push   $0x802499
  800a0e:	e8 70 02 00 00       	call   800c83 <cprintf>
  800a13:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a16:	8b 45 10             	mov    0x10(%ebp),%eax
  800a19:	83 ec 08             	sub    $0x8,%esp
  800a1c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1f:	50                   	push   %eax
  800a20:	e8 f3 01 00 00       	call   800c18 <vcprintf>
  800a25:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a28:	83 ec 08             	sub    $0x8,%esp
  800a2b:	6a 00                	push   $0x0
  800a2d:	68 b5 24 80 00       	push   $0x8024b5
  800a32:	e8 e1 01 00 00       	call   800c18 <vcprintf>
  800a37:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a3a:	e8 82 ff ff ff       	call   8009c1 <exit>

	// should not return here
	while (1) ;
  800a3f:	eb fe                	jmp    800a3f <_panic+0x70>

00800a41 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a41:	55                   	push   %ebp
  800a42:	89 e5                	mov    %esp,%ebp
  800a44:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a47:	a1 20 30 80 00       	mov    0x803020,%eax
  800a4c:	8b 50 74             	mov    0x74(%eax),%edx
  800a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a52:	39 c2                	cmp    %eax,%edx
  800a54:	74 14                	je     800a6a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a56:	83 ec 04             	sub    $0x4,%esp
  800a59:	68 b8 24 80 00       	push   $0x8024b8
  800a5e:	6a 26                	push   $0x26
  800a60:	68 04 25 80 00       	push   $0x802504
  800a65:	e8 65 ff ff ff       	call   8009cf <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a71:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a78:	e9 c2 00 00 00       	jmp    800b3f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a80:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	01 d0                	add    %edx,%eax
  800a8c:	8b 00                	mov    (%eax),%eax
  800a8e:	85 c0                	test   %eax,%eax
  800a90:	75 08                	jne    800a9a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a92:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a95:	e9 a2 00 00 00       	jmp    800b3c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800a9a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aa1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800aa8:	eb 69                	jmp    800b13 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800aaa:	a1 20 30 80 00       	mov    0x803020,%eax
  800aaf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ab5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ab8:	89 d0                	mov    %edx,%eax
  800aba:	01 c0                	add    %eax,%eax
  800abc:	01 d0                	add    %edx,%eax
  800abe:	c1 e0 02             	shl    $0x2,%eax
  800ac1:	01 c8                	add    %ecx,%eax
  800ac3:	8a 40 04             	mov    0x4(%eax),%al
  800ac6:	84 c0                	test   %al,%al
  800ac8:	75 46                	jne    800b10 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800aca:	a1 20 30 80 00       	mov    0x803020,%eax
  800acf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ad5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ad8:	89 d0                	mov    %edx,%eax
  800ada:	01 c0                	add    %eax,%eax
  800adc:	01 d0                	add    %edx,%eax
  800ade:	c1 e0 02             	shl    $0x2,%eax
  800ae1:	01 c8                	add    %ecx,%eax
  800ae3:	8b 00                	mov    (%eax),%eax
  800ae5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800ae8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800aeb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800af0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	01 c8                	add    %ecx,%eax
  800b01:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b03:	39 c2                	cmp    %eax,%edx
  800b05:	75 09                	jne    800b10 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800b07:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b0e:	eb 12                	jmp    800b22 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b10:	ff 45 e8             	incl   -0x18(%ebp)
  800b13:	a1 20 30 80 00       	mov    0x803020,%eax
  800b18:	8b 50 74             	mov    0x74(%eax),%edx
  800b1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b1e:	39 c2                	cmp    %eax,%edx
  800b20:	77 88                	ja     800aaa <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b22:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b26:	75 14                	jne    800b3c <CheckWSWithoutLastIndex+0xfb>
			panic(
  800b28:	83 ec 04             	sub    $0x4,%esp
  800b2b:	68 10 25 80 00       	push   $0x802510
  800b30:	6a 3a                	push   $0x3a
  800b32:	68 04 25 80 00       	push   $0x802504
  800b37:	e8 93 fe ff ff       	call   8009cf <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b3c:	ff 45 f0             	incl   -0x10(%ebp)
  800b3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b42:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b45:	0f 8c 32 ff ff ff    	jl     800a7d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b4b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b52:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b59:	eb 26                	jmp    800b81 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b5b:	a1 20 30 80 00       	mov    0x803020,%eax
  800b60:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b66:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b69:	89 d0                	mov    %edx,%eax
  800b6b:	01 c0                	add    %eax,%eax
  800b6d:	01 d0                	add    %edx,%eax
  800b6f:	c1 e0 02             	shl    $0x2,%eax
  800b72:	01 c8                	add    %ecx,%eax
  800b74:	8a 40 04             	mov    0x4(%eax),%al
  800b77:	3c 01                	cmp    $0x1,%al
  800b79:	75 03                	jne    800b7e <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800b7b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b7e:	ff 45 e0             	incl   -0x20(%ebp)
  800b81:	a1 20 30 80 00       	mov    0x803020,%eax
  800b86:	8b 50 74             	mov    0x74(%eax),%edx
  800b89:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b8c:	39 c2                	cmp    %eax,%edx
  800b8e:	77 cb                	ja     800b5b <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b93:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b96:	74 14                	je     800bac <CheckWSWithoutLastIndex+0x16b>
		panic(
  800b98:	83 ec 04             	sub    $0x4,%esp
  800b9b:	68 64 25 80 00       	push   $0x802564
  800ba0:	6a 44                	push   $0x44
  800ba2:	68 04 25 80 00       	push   $0x802504
  800ba7:	e8 23 fe ff ff       	call   8009cf <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bac:	90                   	nop
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb8:	8b 00                	mov    (%eax),%eax
  800bba:	8d 48 01             	lea    0x1(%eax),%ecx
  800bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc0:	89 0a                	mov    %ecx,(%edx)
  800bc2:	8b 55 08             	mov    0x8(%ebp),%edx
  800bc5:	88 d1                	mov    %dl,%cl
  800bc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bca:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd1:	8b 00                	mov    (%eax),%eax
  800bd3:	3d ff 00 00 00       	cmp    $0xff,%eax
  800bd8:	75 2c                	jne    800c06 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800bda:	a0 24 30 80 00       	mov    0x803024,%al
  800bdf:	0f b6 c0             	movzbl %al,%eax
  800be2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be5:	8b 12                	mov    (%edx),%edx
  800be7:	89 d1                	mov    %edx,%ecx
  800be9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bec:	83 c2 08             	add    $0x8,%edx
  800bef:	83 ec 04             	sub    $0x4,%esp
  800bf2:	50                   	push   %eax
  800bf3:	51                   	push   %ecx
  800bf4:	52                   	push   %edx
  800bf5:	e8 3e 0e 00 00       	call   801a38 <sys_cputs>
  800bfa:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c09:	8b 40 04             	mov    0x4(%eax),%eax
  800c0c:	8d 50 01             	lea    0x1(%eax),%edx
  800c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c12:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c15:	90                   	nop
  800c16:	c9                   	leave  
  800c17:	c3                   	ret    

00800c18 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c18:	55                   	push   %ebp
  800c19:	89 e5                	mov    %esp,%ebp
  800c1b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c21:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c28:	00 00 00 
	b.cnt = 0;
  800c2b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c32:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c35:	ff 75 0c             	pushl  0xc(%ebp)
  800c38:	ff 75 08             	pushl  0x8(%ebp)
  800c3b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c41:	50                   	push   %eax
  800c42:	68 af 0b 80 00       	push   $0x800baf
  800c47:	e8 11 02 00 00       	call   800e5d <vprintfmt>
  800c4c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c4f:	a0 24 30 80 00       	mov    0x803024,%al
  800c54:	0f b6 c0             	movzbl %al,%eax
  800c57:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c5d:	83 ec 04             	sub    $0x4,%esp
  800c60:	50                   	push   %eax
  800c61:	52                   	push   %edx
  800c62:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c68:	83 c0 08             	add    $0x8,%eax
  800c6b:	50                   	push   %eax
  800c6c:	e8 c7 0d 00 00       	call   801a38 <sys_cputs>
  800c71:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c74:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800c7b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c81:	c9                   	leave  
  800c82:	c3                   	ret    

00800c83 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c83:	55                   	push   %ebp
  800c84:	89 e5                	mov    %esp,%ebp
  800c86:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c89:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800c90:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	83 ec 08             	sub    $0x8,%esp
  800c9c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c9f:	50                   	push   %eax
  800ca0:	e8 73 ff ff ff       	call   800c18 <vcprintf>
  800ca5:	83 c4 10             	add    $0x10,%esp
  800ca8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cae:	c9                   	leave  
  800caf:	c3                   	ret    

00800cb0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800cb0:	55                   	push   %ebp
  800cb1:	89 e5                	mov    %esp,%ebp
  800cb3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cb6:	e8 8e 0f 00 00       	call   801c49 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cbb:	8d 45 0c             	lea    0xc(%ebp),%eax
  800cbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	83 ec 08             	sub    $0x8,%esp
  800cc7:	ff 75 f4             	pushl  -0xc(%ebp)
  800cca:	50                   	push   %eax
  800ccb:	e8 48 ff ff ff       	call   800c18 <vcprintf>
  800cd0:	83 c4 10             	add    $0x10,%esp
  800cd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800cd6:	e8 88 0f 00 00       	call   801c63 <sys_enable_interrupt>
	return cnt;
  800cdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cde:	c9                   	leave  
  800cdf:	c3                   	ret    

00800ce0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ce0:	55                   	push   %ebp
  800ce1:	89 e5                	mov    %esp,%ebp
  800ce3:	53                   	push   %ebx
  800ce4:	83 ec 14             	sub    $0x14,%esp
  800ce7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ced:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800cf3:	8b 45 18             	mov    0x18(%ebp),%eax
  800cf6:	ba 00 00 00 00       	mov    $0x0,%edx
  800cfb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cfe:	77 55                	ja     800d55 <printnum+0x75>
  800d00:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d03:	72 05                	jb     800d0a <printnum+0x2a>
  800d05:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d08:	77 4b                	ja     800d55 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d0a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d0d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d10:	8b 45 18             	mov    0x18(%ebp),%eax
  800d13:	ba 00 00 00 00       	mov    $0x0,%edx
  800d18:	52                   	push   %edx
  800d19:	50                   	push   %eax
  800d1a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1d:	ff 75 f0             	pushl  -0x10(%ebp)
  800d20:	e8 03 13 00 00       	call   802028 <__udivdi3>
  800d25:	83 c4 10             	add    $0x10,%esp
  800d28:	83 ec 04             	sub    $0x4,%esp
  800d2b:	ff 75 20             	pushl  0x20(%ebp)
  800d2e:	53                   	push   %ebx
  800d2f:	ff 75 18             	pushl  0x18(%ebp)
  800d32:	52                   	push   %edx
  800d33:	50                   	push   %eax
  800d34:	ff 75 0c             	pushl  0xc(%ebp)
  800d37:	ff 75 08             	pushl  0x8(%ebp)
  800d3a:	e8 a1 ff ff ff       	call   800ce0 <printnum>
  800d3f:	83 c4 20             	add    $0x20,%esp
  800d42:	eb 1a                	jmp    800d5e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d44:	83 ec 08             	sub    $0x8,%esp
  800d47:	ff 75 0c             	pushl  0xc(%ebp)
  800d4a:	ff 75 20             	pushl  0x20(%ebp)
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	ff d0                	call   *%eax
  800d52:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d55:	ff 4d 1c             	decl   0x1c(%ebp)
  800d58:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d5c:	7f e6                	jg     800d44 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d5e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d61:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d6c:	53                   	push   %ebx
  800d6d:	51                   	push   %ecx
  800d6e:	52                   	push   %edx
  800d6f:	50                   	push   %eax
  800d70:	e8 c3 13 00 00       	call   802138 <__umoddi3>
  800d75:	83 c4 10             	add    $0x10,%esp
  800d78:	05 d4 27 80 00       	add    $0x8027d4,%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	0f be c0             	movsbl %al,%eax
  800d82:	83 ec 08             	sub    $0x8,%esp
  800d85:	ff 75 0c             	pushl  0xc(%ebp)
  800d88:	50                   	push   %eax
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	ff d0                	call   *%eax
  800d8e:	83 c4 10             	add    $0x10,%esp
}
  800d91:	90                   	nop
  800d92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d95:	c9                   	leave  
  800d96:	c3                   	ret    

00800d97 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d97:	55                   	push   %ebp
  800d98:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d9a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d9e:	7e 1c                	jle    800dbc <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8b 00                	mov    (%eax),%eax
  800da5:	8d 50 08             	lea    0x8(%eax),%edx
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	89 10                	mov    %edx,(%eax)
  800dad:	8b 45 08             	mov    0x8(%ebp),%eax
  800db0:	8b 00                	mov    (%eax),%eax
  800db2:	83 e8 08             	sub    $0x8,%eax
  800db5:	8b 50 04             	mov    0x4(%eax),%edx
  800db8:	8b 00                	mov    (%eax),%eax
  800dba:	eb 40                	jmp    800dfc <getuint+0x65>
	else if (lflag)
  800dbc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dc0:	74 1e                	je     800de0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	8b 00                	mov    (%eax),%eax
  800dc7:	8d 50 04             	lea    0x4(%eax),%edx
  800dca:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcd:	89 10                	mov    %edx,(%eax)
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	8b 00                	mov    (%eax),%eax
  800dd4:	83 e8 04             	sub    $0x4,%eax
  800dd7:	8b 00                	mov    (%eax),%eax
  800dd9:	ba 00 00 00 00       	mov    $0x0,%edx
  800dde:	eb 1c                	jmp    800dfc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8b 00                	mov    (%eax),%eax
  800de5:	8d 50 04             	lea    0x4(%eax),%edx
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	89 10                	mov    %edx,(%eax)
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	8b 00                	mov    (%eax),%eax
  800df2:	83 e8 04             	sub    $0x4,%eax
  800df5:	8b 00                	mov    (%eax),%eax
  800df7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800dfc:	5d                   	pop    %ebp
  800dfd:	c3                   	ret    

00800dfe <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800dfe:	55                   	push   %ebp
  800dff:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e01:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e05:	7e 1c                	jle    800e23 <getint+0x25>
		return va_arg(*ap, long long);
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	8b 00                	mov    (%eax),%eax
  800e0c:	8d 50 08             	lea    0x8(%eax),%edx
  800e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e12:	89 10                	mov    %edx,(%eax)
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	8b 00                	mov    (%eax),%eax
  800e19:	83 e8 08             	sub    $0x8,%eax
  800e1c:	8b 50 04             	mov    0x4(%eax),%edx
  800e1f:	8b 00                	mov    (%eax),%eax
  800e21:	eb 38                	jmp    800e5b <getint+0x5d>
	else if (lflag)
  800e23:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e27:	74 1a                	je     800e43 <getint+0x45>
		return va_arg(*ap, long);
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8b 00                	mov    (%eax),%eax
  800e2e:	8d 50 04             	lea    0x4(%eax),%edx
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	89 10                	mov    %edx,(%eax)
  800e36:	8b 45 08             	mov    0x8(%ebp),%eax
  800e39:	8b 00                	mov    (%eax),%eax
  800e3b:	83 e8 04             	sub    $0x4,%eax
  800e3e:	8b 00                	mov    (%eax),%eax
  800e40:	99                   	cltd   
  800e41:	eb 18                	jmp    800e5b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8b 00                	mov    (%eax),%eax
  800e48:	8d 50 04             	lea    0x4(%eax),%edx
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	89 10                	mov    %edx,(%eax)
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	8b 00                	mov    (%eax),%eax
  800e55:	83 e8 04             	sub    $0x4,%eax
  800e58:	8b 00                	mov    (%eax),%eax
  800e5a:	99                   	cltd   
}
  800e5b:	5d                   	pop    %ebp
  800e5c:	c3                   	ret    

00800e5d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e5d:	55                   	push   %ebp
  800e5e:	89 e5                	mov    %esp,%ebp
  800e60:	56                   	push   %esi
  800e61:	53                   	push   %ebx
  800e62:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e65:	eb 17                	jmp    800e7e <vprintfmt+0x21>
			if (ch == '\0')
  800e67:	85 db                	test   %ebx,%ebx
  800e69:	0f 84 af 03 00 00    	je     80121e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e6f:	83 ec 08             	sub    $0x8,%esp
  800e72:	ff 75 0c             	pushl  0xc(%ebp)
  800e75:	53                   	push   %ebx
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	ff d0                	call   *%eax
  800e7b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e81:	8d 50 01             	lea    0x1(%eax),%edx
  800e84:	89 55 10             	mov    %edx,0x10(%ebp)
  800e87:	8a 00                	mov    (%eax),%al
  800e89:	0f b6 d8             	movzbl %al,%ebx
  800e8c:	83 fb 25             	cmp    $0x25,%ebx
  800e8f:	75 d6                	jne    800e67 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e91:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e95:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e9c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ea3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800eaa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800eb1:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb4:	8d 50 01             	lea    0x1(%eax),%edx
  800eb7:	89 55 10             	mov    %edx,0x10(%ebp)
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	0f b6 d8             	movzbl %al,%ebx
  800ebf:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ec2:	83 f8 55             	cmp    $0x55,%eax
  800ec5:	0f 87 2b 03 00 00    	ja     8011f6 <vprintfmt+0x399>
  800ecb:	8b 04 85 f8 27 80 00 	mov    0x8027f8(,%eax,4),%eax
  800ed2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ed4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ed8:	eb d7                	jmp    800eb1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800eda:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ede:	eb d1                	jmp    800eb1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ee0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ee7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800eea:	89 d0                	mov    %edx,%eax
  800eec:	c1 e0 02             	shl    $0x2,%eax
  800eef:	01 d0                	add    %edx,%eax
  800ef1:	01 c0                	add    %eax,%eax
  800ef3:	01 d8                	add    %ebx,%eax
  800ef5:	83 e8 30             	sub    $0x30,%eax
  800ef8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800efb:	8b 45 10             	mov    0x10(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f03:	83 fb 2f             	cmp    $0x2f,%ebx
  800f06:	7e 3e                	jle    800f46 <vprintfmt+0xe9>
  800f08:	83 fb 39             	cmp    $0x39,%ebx
  800f0b:	7f 39                	jg     800f46 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f0d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f10:	eb d5                	jmp    800ee7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f12:	8b 45 14             	mov    0x14(%ebp),%eax
  800f15:	83 c0 04             	add    $0x4,%eax
  800f18:	89 45 14             	mov    %eax,0x14(%ebp)
  800f1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1e:	83 e8 04             	sub    $0x4,%eax
  800f21:	8b 00                	mov    (%eax),%eax
  800f23:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f26:	eb 1f                	jmp    800f47 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f2c:	79 83                	jns    800eb1 <vprintfmt+0x54>
				width = 0;
  800f2e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f35:	e9 77 ff ff ff       	jmp    800eb1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f3a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f41:	e9 6b ff ff ff       	jmp    800eb1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f46:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f47:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f4b:	0f 89 60 ff ff ff    	jns    800eb1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f51:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f57:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f5e:	e9 4e ff ff ff       	jmp    800eb1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f63:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f66:	e9 46 ff ff ff       	jmp    800eb1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6e:	83 c0 04             	add    $0x4,%eax
  800f71:	89 45 14             	mov    %eax,0x14(%ebp)
  800f74:	8b 45 14             	mov    0x14(%ebp),%eax
  800f77:	83 e8 04             	sub    $0x4,%eax
  800f7a:	8b 00                	mov    (%eax),%eax
  800f7c:	83 ec 08             	sub    $0x8,%esp
  800f7f:	ff 75 0c             	pushl  0xc(%ebp)
  800f82:	50                   	push   %eax
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	ff d0                	call   *%eax
  800f88:	83 c4 10             	add    $0x10,%esp
			break;
  800f8b:	e9 89 02 00 00       	jmp    801219 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f90:	8b 45 14             	mov    0x14(%ebp),%eax
  800f93:	83 c0 04             	add    $0x4,%eax
  800f96:	89 45 14             	mov    %eax,0x14(%ebp)
  800f99:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9c:	83 e8 04             	sub    $0x4,%eax
  800f9f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800fa1:	85 db                	test   %ebx,%ebx
  800fa3:	79 02                	jns    800fa7 <vprintfmt+0x14a>
				err = -err;
  800fa5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fa7:	83 fb 64             	cmp    $0x64,%ebx
  800faa:	7f 0b                	jg     800fb7 <vprintfmt+0x15a>
  800fac:	8b 34 9d 40 26 80 00 	mov    0x802640(,%ebx,4),%esi
  800fb3:	85 f6                	test   %esi,%esi
  800fb5:	75 19                	jne    800fd0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fb7:	53                   	push   %ebx
  800fb8:	68 e5 27 80 00       	push   $0x8027e5
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	ff 75 08             	pushl  0x8(%ebp)
  800fc3:	e8 5e 02 00 00       	call   801226 <printfmt>
  800fc8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fcb:	e9 49 02 00 00       	jmp    801219 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800fd0:	56                   	push   %esi
  800fd1:	68 ee 27 80 00       	push   $0x8027ee
  800fd6:	ff 75 0c             	pushl  0xc(%ebp)
  800fd9:	ff 75 08             	pushl  0x8(%ebp)
  800fdc:	e8 45 02 00 00       	call   801226 <printfmt>
  800fe1:	83 c4 10             	add    $0x10,%esp
			break;
  800fe4:	e9 30 02 00 00       	jmp    801219 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800fe9:	8b 45 14             	mov    0x14(%ebp),%eax
  800fec:	83 c0 04             	add    $0x4,%eax
  800fef:	89 45 14             	mov    %eax,0x14(%ebp)
  800ff2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff5:	83 e8 04             	sub    $0x4,%eax
  800ff8:	8b 30                	mov    (%eax),%esi
  800ffa:	85 f6                	test   %esi,%esi
  800ffc:	75 05                	jne    801003 <vprintfmt+0x1a6>
				p = "(null)";
  800ffe:	be f1 27 80 00       	mov    $0x8027f1,%esi
			if (width > 0 && padc != '-')
  801003:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801007:	7e 6d                	jle    801076 <vprintfmt+0x219>
  801009:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80100d:	74 67                	je     801076 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80100f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801012:	83 ec 08             	sub    $0x8,%esp
  801015:	50                   	push   %eax
  801016:	56                   	push   %esi
  801017:	e8 0c 03 00 00       	call   801328 <strnlen>
  80101c:	83 c4 10             	add    $0x10,%esp
  80101f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801022:	eb 16                	jmp    80103a <vprintfmt+0x1dd>
					putch(padc, putdat);
  801024:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801028:	83 ec 08             	sub    $0x8,%esp
  80102b:	ff 75 0c             	pushl  0xc(%ebp)
  80102e:	50                   	push   %eax
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	ff d0                	call   *%eax
  801034:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801037:	ff 4d e4             	decl   -0x1c(%ebp)
  80103a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80103e:	7f e4                	jg     801024 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801040:	eb 34                	jmp    801076 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801042:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801046:	74 1c                	je     801064 <vprintfmt+0x207>
  801048:	83 fb 1f             	cmp    $0x1f,%ebx
  80104b:	7e 05                	jle    801052 <vprintfmt+0x1f5>
  80104d:	83 fb 7e             	cmp    $0x7e,%ebx
  801050:	7e 12                	jle    801064 <vprintfmt+0x207>
					putch('?', putdat);
  801052:	83 ec 08             	sub    $0x8,%esp
  801055:	ff 75 0c             	pushl  0xc(%ebp)
  801058:	6a 3f                	push   $0x3f
  80105a:	8b 45 08             	mov    0x8(%ebp),%eax
  80105d:	ff d0                	call   *%eax
  80105f:	83 c4 10             	add    $0x10,%esp
  801062:	eb 0f                	jmp    801073 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801064:	83 ec 08             	sub    $0x8,%esp
  801067:	ff 75 0c             	pushl  0xc(%ebp)
  80106a:	53                   	push   %ebx
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	ff d0                	call   *%eax
  801070:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801073:	ff 4d e4             	decl   -0x1c(%ebp)
  801076:	89 f0                	mov    %esi,%eax
  801078:	8d 70 01             	lea    0x1(%eax),%esi
  80107b:	8a 00                	mov    (%eax),%al
  80107d:	0f be d8             	movsbl %al,%ebx
  801080:	85 db                	test   %ebx,%ebx
  801082:	74 24                	je     8010a8 <vprintfmt+0x24b>
  801084:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801088:	78 b8                	js     801042 <vprintfmt+0x1e5>
  80108a:	ff 4d e0             	decl   -0x20(%ebp)
  80108d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801091:	79 af                	jns    801042 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801093:	eb 13                	jmp    8010a8 <vprintfmt+0x24b>
				putch(' ', putdat);
  801095:	83 ec 08             	sub    $0x8,%esp
  801098:	ff 75 0c             	pushl  0xc(%ebp)
  80109b:	6a 20                	push   $0x20
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	ff d0                	call   *%eax
  8010a2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010a5:	ff 4d e4             	decl   -0x1c(%ebp)
  8010a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010ac:	7f e7                	jg     801095 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010ae:	e9 66 01 00 00       	jmp    801219 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010b3:	83 ec 08             	sub    $0x8,%esp
  8010b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8010b9:	8d 45 14             	lea    0x14(%ebp),%eax
  8010bc:	50                   	push   %eax
  8010bd:	e8 3c fd ff ff       	call   800dfe <getint>
  8010c2:	83 c4 10             	add    $0x10,%esp
  8010c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d1:	85 d2                	test   %edx,%edx
  8010d3:	79 23                	jns    8010f8 <vprintfmt+0x29b>
				putch('-', putdat);
  8010d5:	83 ec 08             	sub    $0x8,%esp
  8010d8:	ff 75 0c             	pushl  0xc(%ebp)
  8010db:	6a 2d                	push   $0x2d
  8010dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e0:	ff d0                	call   *%eax
  8010e2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8010e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010eb:	f7 d8                	neg    %eax
  8010ed:	83 d2 00             	adc    $0x0,%edx
  8010f0:	f7 da                	neg    %edx
  8010f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8010f8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010ff:	e9 bc 00 00 00       	jmp    8011c0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801104:	83 ec 08             	sub    $0x8,%esp
  801107:	ff 75 e8             	pushl  -0x18(%ebp)
  80110a:	8d 45 14             	lea    0x14(%ebp),%eax
  80110d:	50                   	push   %eax
  80110e:	e8 84 fc ff ff       	call   800d97 <getuint>
  801113:	83 c4 10             	add    $0x10,%esp
  801116:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801119:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80111c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801123:	e9 98 00 00 00       	jmp    8011c0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801128:	83 ec 08             	sub    $0x8,%esp
  80112b:	ff 75 0c             	pushl  0xc(%ebp)
  80112e:	6a 58                	push   $0x58
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	ff d0                	call   *%eax
  801135:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801138:	83 ec 08             	sub    $0x8,%esp
  80113b:	ff 75 0c             	pushl  0xc(%ebp)
  80113e:	6a 58                	push   $0x58
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	ff d0                	call   *%eax
  801145:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801148:	83 ec 08             	sub    $0x8,%esp
  80114b:	ff 75 0c             	pushl  0xc(%ebp)
  80114e:	6a 58                	push   $0x58
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	ff d0                	call   *%eax
  801155:	83 c4 10             	add    $0x10,%esp
			break;
  801158:	e9 bc 00 00 00       	jmp    801219 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80115d:	83 ec 08             	sub    $0x8,%esp
  801160:	ff 75 0c             	pushl  0xc(%ebp)
  801163:	6a 30                	push   $0x30
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	ff d0                	call   *%eax
  80116a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80116d:	83 ec 08             	sub    $0x8,%esp
  801170:	ff 75 0c             	pushl  0xc(%ebp)
  801173:	6a 78                	push   $0x78
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	ff d0                	call   *%eax
  80117a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80117d:	8b 45 14             	mov    0x14(%ebp),%eax
  801180:	83 c0 04             	add    $0x4,%eax
  801183:	89 45 14             	mov    %eax,0x14(%ebp)
  801186:	8b 45 14             	mov    0x14(%ebp),%eax
  801189:	83 e8 04             	sub    $0x4,%eax
  80118c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80118e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801191:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801198:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80119f:	eb 1f                	jmp    8011c0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011a1:	83 ec 08             	sub    $0x8,%esp
  8011a4:	ff 75 e8             	pushl  -0x18(%ebp)
  8011a7:	8d 45 14             	lea    0x14(%ebp),%eax
  8011aa:	50                   	push   %eax
  8011ab:	e8 e7 fb ff ff       	call   800d97 <getuint>
  8011b0:	83 c4 10             	add    $0x10,%esp
  8011b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011b9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011c0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011c7:	83 ec 04             	sub    $0x4,%esp
  8011ca:	52                   	push   %edx
  8011cb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011ce:	50                   	push   %eax
  8011cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8011d2:	ff 75 f0             	pushl  -0x10(%ebp)
  8011d5:	ff 75 0c             	pushl  0xc(%ebp)
  8011d8:	ff 75 08             	pushl  0x8(%ebp)
  8011db:	e8 00 fb ff ff       	call   800ce0 <printnum>
  8011e0:	83 c4 20             	add    $0x20,%esp
			break;
  8011e3:	eb 34                	jmp    801219 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8011e5:	83 ec 08             	sub    $0x8,%esp
  8011e8:	ff 75 0c             	pushl  0xc(%ebp)
  8011eb:	53                   	push   %ebx
  8011ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ef:	ff d0                	call   *%eax
  8011f1:	83 c4 10             	add    $0x10,%esp
			break;
  8011f4:	eb 23                	jmp    801219 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8011f6:	83 ec 08             	sub    $0x8,%esp
  8011f9:	ff 75 0c             	pushl  0xc(%ebp)
  8011fc:	6a 25                	push   $0x25
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	ff d0                	call   *%eax
  801203:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801206:	ff 4d 10             	decl   0x10(%ebp)
  801209:	eb 03                	jmp    80120e <vprintfmt+0x3b1>
  80120b:	ff 4d 10             	decl   0x10(%ebp)
  80120e:	8b 45 10             	mov    0x10(%ebp),%eax
  801211:	48                   	dec    %eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	3c 25                	cmp    $0x25,%al
  801216:	75 f3                	jne    80120b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801218:	90                   	nop
		}
	}
  801219:	e9 47 fc ff ff       	jmp    800e65 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80121e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80121f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801222:	5b                   	pop    %ebx
  801223:	5e                   	pop    %esi
  801224:	5d                   	pop    %ebp
  801225:	c3                   	ret    

00801226 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80122c:	8d 45 10             	lea    0x10(%ebp),%eax
  80122f:	83 c0 04             	add    $0x4,%eax
  801232:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801235:	8b 45 10             	mov    0x10(%ebp),%eax
  801238:	ff 75 f4             	pushl  -0xc(%ebp)
  80123b:	50                   	push   %eax
  80123c:	ff 75 0c             	pushl  0xc(%ebp)
  80123f:	ff 75 08             	pushl  0x8(%ebp)
  801242:	e8 16 fc ff ff       	call   800e5d <vprintfmt>
  801247:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80124a:	90                   	nop
  80124b:	c9                   	leave  
  80124c:	c3                   	ret    

0080124d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80124d:	55                   	push   %ebp
  80124e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801250:	8b 45 0c             	mov    0xc(%ebp),%eax
  801253:	8b 40 08             	mov    0x8(%eax),%eax
  801256:	8d 50 01             	lea    0x1(%eax),%edx
  801259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80125f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801262:	8b 10                	mov    (%eax),%edx
  801264:	8b 45 0c             	mov    0xc(%ebp),%eax
  801267:	8b 40 04             	mov    0x4(%eax),%eax
  80126a:	39 c2                	cmp    %eax,%edx
  80126c:	73 12                	jae    801280 <sprintputch+0x33>
		*b->buf++ = ch;
  80126e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801271:	8b 00                	mov    (%eax),%eax
  801273:	8d 48 01             	lea    0x1(%eax),%ecx
  801276:	8b 55 0c             	mov    0xc(%ebp),%edx
  801279:	89 0a                	mov    %ecx,(%edx)
  80127b:	8b 55 08             	mov    0x8(%ebp),%edx
  80127e:	88 10                	mov    %dl,(%eax)
}
  801280:	90                   	nop
  801281:	5d                   	pop    %ebp
  801282:	c3                   	ret    

00801283 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
  801286:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80128f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801292:	8d 50 ff             	lea    -0x1(%eax),%edx
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	01 d0                	add    %edx,%eax
  80129a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80129d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012a8:	74 06                	je     8012b0 <vsnprintf+0x2d>
  8012aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ae:	7f 07                	jg     8012b7 <vsnprintf+0x34>
		return -E_INVAL;
  8012b0:	b8 03 00 00 00       	mov    $0x3,%eax
  8012b5:	eb 20                	jmp    8012d7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012b7:	ff 75 14             	pushl  0x14(%ebp)
  8012ba:	ff 75 10             	pushl  0x10(%ebp)
  8012bd:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012c0:	50                   	push   %eax
  8012c1:	68 4d 12 80 00       	push   $0x80124d
  8012c6:	e8 92 fb ff ff       	call   800e5d <vprintfmt>
  8012cb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012d1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8012d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
  8012dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8012df:	8d 45 10             	lea    0x10(%ebp),%eax
  8012e2:	83 c0 04             	add    $0x4,%eax
  8012e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8012e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8012ee:	50                   	push   %eax
  8012ef:	ff 75 0c             	pushl  0xc(%ebp)
  8012f2:	ff 75 08             	pushl  0x8(%ebp)
  8012f5:	e8 89 ff ff ff       	call   801283 <vsnprintf>
  8012fa:	83 c4 10             	add    $0x10,%esp
  8012fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801300:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80130b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801312:	eb 06                	jmp    80131a <strlen+0x15>
		n++;
  801314:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801317:	ff 45 08             	incl   0x8(%ebp)
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	8a 00                	mov    (%eax),%al
  80131f:	84 c0                	test   %al,%al
  801321:	75 f1                	jne    801314 <strlen+0xf>
		n++;
	return n;
  801323:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
  80132b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80132e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801335:	eb 09                	jmp    801340 <strnlen+0x18>
		n++;
  801337:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80133a:	ff 45 08             	incl   0x8(%ebp)
  80133d:	ff 4d 0c             	decl   0xc(%ebp)
  801340:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801344:	74 09                	je     80134f <strnlen+0x27>
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	84 c0                	test   %al,%al
  80134d:	75 e8                	jne    801337 <strnlen+0xf>
		n++;
	return n;
  80134f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801352:	c9                   	leave  
  801353:	c3                   	ret    

00801354 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801354:	55                   	push   %ebp
  801355:	89 e5                	mov    %esp,%ebp
  801357:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801360:	90                   	nop
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	8d 50 01             	lea    0x1(%eax),%edx
  801367:	89 55 08             	mov    %edx,0x8(%ebp)
  80136a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801370:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801373:	8a 12                	mov    (%edx),%dl
  801375:	88 10                	mov    %dl,(%eax)
  801377:	8a 00                	mov    (%eax),%al
  801379:	84 c0                	test   %al,%al
  80137b:	75 e4                	jne    801361 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80137d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
  801385:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80138e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801395:	eb 1f                	jmp    8013b6 <strncpy+0x34>
		*dst++ = *src;
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8d 50 01             	lea    0x1(%eax),%edx
  80139d:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a3:	8a 12                	mov    (%edx),%dl
  8013a5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	84 c0                	test   %al,%al
  8013ae:	74 03                	je     8013b3 <strncpy+0x31>
			src++;
  8013b0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013b3:	ff 45 fc             	incl   -0x4(%ebp)
  8013b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013bc:	72 d9                	jb     801397 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013be:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013c1:	c9                   	leave  
  8013c2:	c3                   	ret    

008013c3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
  8013c6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013cf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d3:	74 30                	je     801405 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013d5:	eb 16                	jmp    8013ed <strlcpy+0x2a>
			*dst++ = *src++;
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8d 50 01             	lea    0x1(%eax),%edx
  8013dd:	89 55 08             	mov    %edx,0x8(%ebp)
  8013e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013e3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013e6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013e9:	8a 12                	mov    (%edx),%dl
  8013eb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013ed:	ff 4d 10             	decl   0x10(%ebp)
  8013f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f4:	74 09                	je     8013ff <strlcpy+0x3c>
  8013f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	84 c0                	test   %al,%al
  8013fd:	75 d8                	jne    8013d7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801405:	8b 55 08             	mov    0x8(%ebp),%edx
  801408:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140b:	29 c2                	sub    %eax,%edx
  80140d:	89 d0                	mov    %edx,%eax
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801414:	eb 06                	jmp    80141c <strcmp+0xb>
		p++, q++;
  801416:	ff 45 08             	incl   0x8(%ebp)
  801419:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	8a 00                	mov    (%eax),%al
  801421:	84 c0                	test   %al,%al
  801423:	74 0e                	je     801433 <strcmp+0x22>
  801425:	8b 45 08             	mov    0x8(%ebp),%eax
  801428:	8a 10                	mov    (%eax),%dl
  80142a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	38 c2                	cmp    %al,%dl
  801431:	74 e3                	je     801416 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	0f b6 d0             	movzbl %al,%edx
  80143b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143e:	8a 00                	mov    (%eax),%al
  801440:	0f b6 c0             	movzbl %al,%eax
  801443:	29 c2                	sub    %eax,%edx
  801445:	89 d0                	mov    %edx,%eax
}
  801447:	5d                   	pop    %ebp
  801448:	c3                   	ret    

00801449 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80144c:	eb 09                	jmp    801457 <strncmp+0xe>
		n--, p++, q++;
  80144e:	ff 4d 10             	decl   0x10(%ebp)
  801451:	ff 45 08             	incl   0x8(%ebp)
  801454:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801457:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80145b:	74 17                	je     801474 <strncmp+0x2b>
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	84 c0                	test   %al,%al
  801464:	74 0e                	je     801474 <strncmp+0x2b>
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8a 10                	mov    (%eax),%dl
  80146b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	38 c2                	cmp    %al,%dl
  801472:	74 da                	je     80144e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801474:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801478:	75 07                	jne    801481 <strncmp+0x38>
		return 0;
  80147a:	b8 00 00 00 00       	mov    $0x0,%eax
  80147f:	eb 14                	jmp    801495 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	8a 00                	mov    (%eax),%al
  801486:	0f b6 d0             	movzbl %al,%edx
  801489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	0f b6 c0             	movzbl %al,%eax
  801491:	29 c2                	sub    %eax,%edx
  801493:	89 d0                	mov    %edx,%eax
}
  801495:	5d                   	pop    %ebp
  801496:	c3                   	ret    

00801497 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
  80149a:	83 ec 04             	sub    $0x4,%esp
  80149d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014a3:	eb 12                	jmp    8014b7 <strchr+0x20>
		if (*s == c)
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	8a 00                	mov    (%eax),%al
  8014aa:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014ad:	75 05                	jne    8014b4 <strchr+0x1d>
			return (char *) s;
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	eb 11                	jmp    8014c5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014b4:	ff 45 08             	incl   0x8(%ebp)
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	8a 00                	mov    (%eax),%al
  8014bc:	84 c0                	test   %al,%al
  8014be:	75 e5                	jne    8014a5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
  8014ca:	83 ec 04             	sub    $0x4,%esp
  8014cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d3:	eb 0d                	jmp    8014e2 <strfind+0x1b>
		if (*s == c)
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	8a 00                	mov    (%eax),%al
  8014da:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014dd:	74 0e                	je     8014ed <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014df:	ff 45 08             	incl   0x8(%ebp)
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	84 c0                	test   %al,%al
  8014e9:	75 ea                	jne    8014d5 <strfind+0xe>
  8014eb:	eb 01                	jmp    8014ee <strfind+0x27>
		if (*s == c)
			break;
  8014ed:	90                   	nop
	return (char *) s;
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
  8014f6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801502:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801505:	eb 0e                	jmp    801515 <memset+0x22>
		*p++ = c;
  801507:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150a:	8d 50 01             	lea    0x1(%eax),%edx
  80150d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801510:	8b 55 0c             	mov    0xc(%ebp),%edx
  801513:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801515:	ff 4d f8             	decl   -0x8(%ebp)
  801518:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80151c:	79 e9                	jns    801507 <memset+0x14>
		*p++ = c;

	return v;
  80151e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801521:	c9                   	leave  
  801522:	c3                   	ret    

00801523 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801523:	55                   	push   %ebp
  801524:	89 e5                	mov    %esp,%ebp
  801526:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801529:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801535:	eb 16                	jmp    80154d <memcpy+0x2a>
		*d++ = *s++;
  801537:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153a:	8d 50 01             	lea    0x1(%eax),%edx
  80153d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801540:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801543:	8d 4a 01             	lea    0x1(%edx),%ecx
  801546:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801549:	8a 12                	mov    (%edx),%dl
  80154b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80154d:	8b 45 10             	mov    0x10(%ebp),%eax
  801550:	8d 50 ff             	lea    -0x1(%eax),%edx
  801553:	89 55 10             	mov    %edx,0x10(%ebp)
  801556:	85 c0                	test   %eax,%eax
  801558:	75 dd                	jne    801537 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80155a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
  801562:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801565:	8b 45 0c             	mov    0xc(%ebp),%eax
  801568:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801571:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801574:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801577:	73 50                	jae    8015c9 <memmove+0x6a>
  801579:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157c:	8b 45 10             	mov    0x10(%ebp),%eax
  80157f:	01 d0                	add    %edx,%eax
  801581:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801584:	76 43                	jbe    8015c9 <memmove+0x6a>
		s += n;
  801586:	8b 45 10             	mov    0x10(%ebp),%eax
  801589:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80158c:	8b 45 10             	mov    0x10(%ebp),%eax
  80158f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801592:	eb 10                	jmp    8015a4 <memmove+0x45>
			*--d = *--s;
  801594:	ff 4d f8             	decl   -0x8(%ebp)
  801597:	ff 4d fc             	decl   -0x4(%ebp)
  80159a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80159d:	8a 10                	mov    (%eax),%dl
  80159f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ad:	85 c0                	test   %eax,%eax
  8015af:	75 e3                	jne    801594 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015b1:	eb 23                	jmp    8015d6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b6:	8d 50 01             	lea    0x1(%eax),%edx
  8015b9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015bf:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015c2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015c5:	8a 12                	mov    (%edx),%dl
  8015c7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015cf:	89 55 10             	mov    %edx,0x10(%ebp)
  8015d2:	85 c0                	test   %eax,%eax
  8015d4:	75 dd                	jne    8015b3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
  8015de:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ea:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015ed:	eb 2a                	jmp    801619 <memcmp+0x3e>
		if (*s1 != *s2)
  8015ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015f2:	8a 10                	mov    (%eax),%dl
  8015f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f7:	8a 00                	mov    (%eax),%al
  8015f9:	38 c2                	cmp    %al,%dl
  8015fb:	74 16                	je     801613 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801600:	8a 00                	mov    (%eax),%al
  801602:	0f b6 d0             	movzbl %al,%edx
  801605:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801608:	8a 00                	mov    (%eax),%al
  80160a:	0f b6 c0             	movzbl %al,%eax
  80160d:	29 c2                	sub    %eax,%edx
  80160f:	89 d0                	mov    %edx,%eax
  801611:	eb 18                	jmp    80162b <memcmp+0x50>
		s1++, s2++;
  801613:	ff 45 fc             	incl   -0x4(%ebp)
  801616:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801619:	8b 45 10             	mov    0x10(%ebp),%eax
  80161c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80161f:	89 55 10             	mov    %edx,0x10(%ebp)
  801622:	85 c0                	test   %eax,%eax
  801624:	75 c9                	jne    8015ef <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801626:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
  801630:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801633:	8b 55 08             	mov    0x8(%ebp),%edx
  801636:	8b 45 10             	mov    0x10(%ebp),%eax
  801639:	01 d0                	add    %edx,%eax
  80163b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80163e:	eb 15                	jmp    801655 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801640:	8b 45 08             	mov    0x8(%ebp),%eax
  801643:	8a 00                	mov    (%eax),%al
  801645:	0f b6 d0             	movzbl %al,%edx
  801648:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164b:	0f b6 c0             	movzbl %al,%eax
  80164e:	39 c2                	cmp    %eax,%edx
  801650:	74 0d                	je     80165f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801652:	ff 45 08             	incl   0x8(%ebp)
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80165b:	72 e3                	jb     801640 <memfind+0x13>
  80165d:	eb 01                	jmp    801660 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80165f:	90                   	nop
	return (void *) s;
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80166b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801672:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801679:	eb 03                	jmp    80167e <strtol+0x19>
		s++;
  80167b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	3c 20                	cmp    $0x20,%al
  801685:	74 f4                	je     80167b <strtol+0x16>
  801687:	8b 45 08             	mov    0x8(%ebp),%eax
  80168a:	8a 00                	mov    (%eax),%al
  80168c:	3c 09                	cmp    $0x9,%al
  80168e:	74 eb                	je     80167b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	3c 2b                	cmp    $0x2b,%al
  801697:	75 05                	jne    80169e <strtol+0x39>
		s++;
  801699:	ff 45 08             	incl   0x8(%ebp)
  80169c:	eb 13                	jmp    8016b1 <strtol+0x4c>
	else if (*s == '-')
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	3c 2d                	cmp    $0x2d,%al
  8016a5:	75 0a                	jne    8016b1 <strtol+0x4c>
		s++, neg = 1;
  8016a7:	ff 45 08             	incl   0x8(%ebp)
  8016aa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b5:	74 06                	je     8016bd <strtol+0x58>
  8016b7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016bb:	75 20                	jne    8016dd <strtol+0x78>
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	3c 30                	cmp    $0x30,%al
  8016c4:	75 17                	jne    8016dd <strtol+0x78>
  8016c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c9:	40                   	inc    %eax
  8016ca:	8a 00                	mov    (%eax),%al
  8016cc:	3c 78                	cmp    $0x78,%al
  8016ce:	75 0d                	jne    8016dd <strtol+0x78>
		s += 2, base = 16;
  8016d0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016d4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016db:	eb 28                	jmp    801705 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e1:	75 15                	jne    8016f8 <strtol+0x93>
  8016e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e6:	8a 00                	mov    (%eax),%al
  8016e8:	3c 30                	cmp    $0x30,%al
  8016ea:	75 0c                	jne    8016f8 <strtol+0x93>
		s++, base = 8;
  8016ec:	ff 45 08             	incl   0x8(%ebp)
  8016ef:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016f6:	eb 0d                	jmp    801705 <strtol+0xa0>
	else if (base == 0)
  8016f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016fc:	75 07                	jne    801705 <strtol+0xa0>
		base = 10;
  8016fe:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	8a 00                	mov    (%eax),%al
  80170a:	3c 2f                	cmp    $0x2f,%al
  80170c:	7e 19                	jle    801727 <strtol+0xc2>
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	8a 00                	mov    (%eax),%al
  801713:	3c 39                	cmp    $0x39,%al
  801715:	7f 10                	jg     801727 <strtol+0xc2>
			dig = *s - '0';
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	0f be c0             	movsbl %al,%eax
  80171f:	83 e8 30             	sub    $0x30,%eax
  801722:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801725:	eb 42                	jmp    801769 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801727:	8b 45 08             	mov    0x8(%ebp),%eax
  80172a:	8a 00                	mov    (%eax),%al
  80172c:	3c 60                	cmp    $0x60,%al
  80172e:	7e 19                	jle    801749 <strtol+0xe4>
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	8a 00                	mov    (%eax),%al
  801735:	3c 7a                	cmp    $0x7a,%al
  801737:	7f 10                	jg     801749 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	0f be c0             	movsbl %al,%eax
  801741:	83 e8 57             	sub    $0x57,%eax
  801744:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801747:	eb 20                	jmp    801769 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	8a 00                	mov    (%eax),%al
  80174e:	3c 40                	cmp    $0x40,%al
  801750:	7e 39                	jle    80178b <strtol+0x126>
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	8a 00                	mov    (%eax),%al
  801757:	3c 5a                	cmp    $0x5a,%al
  801759:	7f 30                	jg     80178b <strtol+0x126>
			dig = *s - 'A' + 10;
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	8a 00                	mov    (%eax),%al
  801760:	0f be c0             	movsbl %al,%eax
  801763:	83 e8 37             	sub    $0x37,%eax
  801766:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801769:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80176c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80176f:	7d 19                	jge    80178a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801771:	ff 45 08             	incl   0x8(%ebp)
  801774:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801777:	0f af 45 10          	imul   0x10(%ebp),%eax
  80177b:	89 c2                	mov    %eax,%edx
  80177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801780:	01 d0                	add    %edx,%eax
  801782:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801785:	e9 7b ff ff ff       	jmp    801705 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80178a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80178b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80178f:	74 08                	je     801799 <strtol+0x134>
		*endptr = (char *) s;
  801791:	8b 45 0c             	mov    0xc(%ebp),%eax
  801794:	8b 55 08             	mov    0x8(%ebp),%edx
  801797:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801799:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80179d:	74 07                	je     8017a6 <strtol+0x141>
  80179f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a2:	f7 d8                	neg    %eax
  8017a4:	eb 03                	jmp    8017a9 <strtol+0x144>
  8017a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <ltostr>:

void
ltostr(long value, char *str)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
  8017ae:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017c3:	79 13                	jns    8017d8 <ltostr+0x2d>
	{
		neg = 1;
  8017c5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017d2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017d5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017db:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017e0:	99                   	cltd   
  8017e1:	f7 f9                	idiv   %ecx
  8017e3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e9:	8d 50 01             	lea    0x1(%eax),%edx
  8017ec:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017ef:	89 c2                	mov    %eax,%edx
  8017f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f4:	01 d0                	add    %edx,%eax
  8017f6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017f9:	83 c2 30             	add    $0x30,%edx
  8017fc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801801:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801806:	f7 e9                	imul   %ecx
  801808:	c1 fa 02             	sar    $0x2,%edx
  80180b:	89 c8                	mov    %ecx,%eax
  80180d:	c1 f8 1f             	sar    $0x1f,%eax
  801810:	29 c2                	sub    %eax,%edx
  801812:	89 d0                	mov    %edx,%eax
  801814:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801817:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80181a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80181f:	f7 e9                	imul   %ecx
  801821:	c1 fa 02             	sar    $0x2,%edx
  801824:	89 c8                	mov    %ecx,%eax
  801826:	c1 f8 1f             	sar    $0x1f,%eax
  801829:	29 c2                	sub    %eax,%edx
  80182b:	89 d0                	mov    %edx,%eax
  80182d:	c1 e0 02             	shl    $0x2,%eax
  801830:	01 d0                	add    %edx,%eax
  801832:	01 c0                	add    %eax,%eax
  801834:	29 c1                	sub    %eax,%ecx
  801836:	89 ca                	mov    %ecx,%edx
  801838:	85 d2                	test   %edx,%edx
  80183a:	75 9c                	jne    8017d8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80183c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801843:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801846:	48                   	dec    %eax
  801847:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80184a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80184e:	74 3d                	je     80188d <ltostr+0xe2>
		start = 1 ;
  801850:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801857:	eb 34                	jmp    80188d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801859:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80185c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185f:	01 d0                	add    %edx,%eax
  801861:	8a 00                	mov    (%eax),%al
  801863:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801866:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801869:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186c:	01 c2                	add    %eax,%edx
  80186e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801871:	8b 45 0c             	mov    0xc(%ebp),%eax
  801874:	01 c8                	add    %ecx,%eax
  801876:	8a 00                	mov    (%eax),%al
  801878:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80187a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80187d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801880:	01 c2                	add    %eax,%edx
  801882:	8a 45 eb             	mov    -0x15(%ebp),%al
  801885:	88 02                	mov    %al,(%edx)
		start++ ;
  801887:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80188a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80188d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801890:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801893:	7c c4                	jl     801859 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801895:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189b:	01 d0                	add    %edx,%eax
  80189d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018a0:	90                   	nop
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
  8018a6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018a9:	ff 75 08             	pushl  0x8(%ebp)
  8018ac:	e8 54 fa ff ff       	call   801305 <strlen>
  8018b1:	83 c4 04             	add    $0x4,%esp
  8018b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018b7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ba:	e8 46 fa ff ff       	call   801305 <strlen>
  8018bf:	83 c4 04             	add    $0x4,%esp
  8018c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018d3:	eb 17                	jmp    8018ec <strcconcat+0x49>
		final[s] = str1[s] ;
  8018d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018db:	01 c2                	add    %eax,%edx
  8018dd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	01 c8                	add    %ecx,%eax
  8018e5:	8a 00                	mov    (%eax),%al
  8018e7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018e9:	ff 45 fc             	incl   -0x4(%ebp)
  8018ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ef:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018f2:	7c e1                	jl     8018d5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018f4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018fb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801902:	eb 1f                	jmp    801923 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801904:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801907:	8d 50 01             	lea    0x1(%eax),%edx
  80190a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80190d:	89 c2                	mov    %eax,%edx
  80190f:	8b 45 10             	mov    0x10(%ebp),%eax
  801912:	01 c2                	add    %eax,%edx
  801914:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80191a:	01 c8                	add    %ecx,%eax
  80191c:	8a 00                	mov    (%eax),%al
  80191e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801920:	ff 45 f8             	incl   -0x8(%ebp)
  801923:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801926:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801929:	7c d9                	jl     801904 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80192b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80192e:	8b 45 10             	mov    0x10(%ebp),%eax
  801931:	01 d0                	add    %edx,%eax
  801933:	c6 00 00             	movb   $0x0,(%eax)
}
  801936:	90                   	nop
  801937:	c9                   	leave  
  801938:	c3                   	ret    

00801939 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801939:	55                   	push   %ebp
  80193a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80193c:	8b 45 14             	mov    0x14(%ebp),%eax
  80193f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801945:	8b 45 14             	mov    0x14(%ebp),%eax
  801948:	8b 00                	mov    (%eax),%eax
  80194a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801951:	8b 45 10             	mov    0x10(%ebp),%eax
  801954:	01 d0                	add    %edx,%eax
  801956:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80195c:	eb 0c                	jmp    80196a <strsplit+0x31>
			*string++ = 0;
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	8d 50 01             	lea    0x1(%eax),%edx
  801964:	89 55 08             	mov    %edx,0x8(%ebp)
  801967:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80196a:	8b 45 08             	mov    0x8(%ebp),%eax
  80196d:	8a 00                	mov    (%eax),%al
  80196f:	84 c0                	test   %al,%al
  801971:	74 18                	je     80198b <strsplit+0x52>
  801973:	8b 45 08             	mov    0x8(%ebp),%eax
  801976:	8a 00                	mov    (%eax),%al
  801978:	0f be c0             	movsbl %al,%eax
  80197b:	50                   	push   %eax
  80197c:	ff 75 0c             	pushl  0xc(%ebp)
  80197f:	e8 13 fb ff ff       	call   801497 <strchr>
  801984:	83 c4 08             	add    $0x8,%esp
  801987:	85 c0                	test   %eax,%eax
  801989:	75 d3                	jne    80195e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80198b:	8b 45 08             	mov    0x8(%ebp),%eax
  80198e:	8a 00                	mov    (%eax),%al
  801990:	84 c0                	test   %al,%al
  801992:	74 5a                	je     8019ee <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801994:	8b 45 14             	mov    0x14(%ebp),%eax
  801997:	8b 00                	mov    (%eax),%eax
  801999:	83 f8 0f             	cmp    $0xf,%eax
  80199c:	75 07                	jne    8019a5 <strsplit+0x6c>
		{
			return 0;
  80199e:	b8 00 00 00 00       	mov    $0x0,%eax
  8019a3:	eb 66                	jmp    801a0b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a8:	8b 00                	mov    (%eax),%eax
  8019aa:	8d 48 01             	lea    0x1(%eax),%ecx
  8019ad:	8b 55 14             	mov    0x14(%ebp),%edx
  8019b0:	89 0a                	mov    %ecx,(%edx)
  8019b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8019bc:	01 c2                	add    %eax,%edx
  8019be:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019c3:	eb 03                	jmp    8019c8 <strsplit+0x8f>
			string++;
  8019c5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cb:	8a 00                	mov    (%eax),%al
  8019cd:	84 c0                	test   %al,%al
  8019cf:	74 8b                	je     80195c <strsplit+0x23>
  8019d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d4:	8a 00                	mov    (%eax),%al
  8019d6:	0f be c0             	movsbl %al,%eax
  8019d9:	50                   	push   %eax
  8019da:	ff 75 0c             	pushl  0xc(%ebp)
  8019dd:	e8 b5 fa ff ff       	call   801497 <strchr>
  8019e2:	83 c4 08             	add    $0x8,%esp
  8019e5:	85 c0                	test   %eax,%eax
  8019e7:	74 dc                	je     8019c5 <strsplit+0x8c>
			string++;
	}
  8019e9:	e9 6e ff ff ff       	jmp    80195c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019ee:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8019f2:	8b 00                	mov    (%eax),%eax
  8019f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8019fe:	01 d0                	add    %edx,%eax
  801a00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a06:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
  801a10:	57                   	push   %edi
  801a11:	56                   	push   %esi
  801a12:	53                   	push   %ebx
  801a13:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a1f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a22:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a25:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a28:	cd 30                	int    $0x30
  801a2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a30:	83 c4 10             	add    $0x10,%esp
  801a33:	5b                   	pop    %ebx
  801a34:	5e                   	pop    %esi
  801a35:	5f                   	pop    %edi
  801a36:	5d                   	pop    %ebp
  801a37:	c3                   	ret    

00801a38 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 04             	sub    $0x4,%esp
  801a3e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a41:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a44:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a48:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	52                   	push   %edx
  801a50:	ff 75 0c             	pushl  0xc(%ebp)
  801a53:	50                   	push   %eax
  801a54:	6a 00                	push   $0x0
  801a56:	e8 b2 ff ff ff       	call   801a0d <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
}
  801a5e:	90                   	nop
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 01                	push   $0x1
  801a70:	e8 98 ff ff ff       	call   801a0d <syscall>
  801a75:	83 c4 18             	add    $0x18,%esp
}
  801a78:	c9                   	leave  
  801a79:	c3                   	ret    

00801a7a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	50                   	push   %eax
  801a89:	6a 05                	push   $0x5
  801a8b:	e8 7d ff ff ff       	call   801a0d <syscall>
  801a90:	83 c4 18             	add    $0x18,%esp
}
  801a93:	c9                   	leave  
  801a94:	c3                   	ret    

00801a95 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a95:	55                   	push   %ebp
  801a96:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 02                	push   $0x2
  801aa4:	e8 64 ff ff ff       	call   801a0d <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 03                	push   $0x3
  801abd:	e8 4b ff ff ff       	call   801a0d <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 04                	push   $0x4
  801ad6:	e8 32 ff ff ff       	call   801a0d <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_env_exit>:


void sys_env_exit(void)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 06                	push   $0x6
  801aef:	e8 19 ff ff ff       	call   801a0d <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
}
  801af7:	90                   	nop
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801afd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b00:	8b 45 08             	mov    0x8(%ebp),%eax
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	52                   	push   %edx
  801b0a:	50                   	push   %eax
  801b0b:	6a 07                	push   $0x7
  801b0d:	e8 fb fe ff ff       	call   801a0d <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	c9                   	leave  
  801b16:	c3                   	ret    

00801b17 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
  801b1a:	56                   	push   %esi
  801b1b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b1c:	8b 75 18             	mov    0x18(%ebp),%esi
  801b1f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b22:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b25:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b28:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2b:	56                   	push   %esi
  801b2c:	53                   	push   %ebx
  801b2d:	51                   	push   %ecx
  801b2e:	52                   	push   %edx
  801b2f:	50                   	push   %eax
  801b30:	6a 08                	push   $0x8
  801b32:	e8 d6 fe ff ff       	call   801a0d <syscall>
  801b37:	83 c4 18             	add    $0x18,%esp
}
  801b3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b3d:	5b                   	pop    %ebx
  801b3e:	5e                   	pop    %esi
  801b3f:	5d                   	pop    %ebp
  801b40:	c3                   	ret    

00801b41 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b47:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	52                   	push   %edx
  801b51:	50                   	push   %eax
  801b52:	6a 09                	push   $0x9
  801b54:	e8 b4 fe ff ff       	call   801a0d <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	ff 75 0c             	pushl  0xc(%ebp)
  801b6a:	ff 75 08             	pushl  0x8(%ebp)
  801b6d:	6a 0a                	push   $0xa
  801b6f:	e8 99 fe ff ff       	call   801a0d <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 0b                	push   $0xb
  801b88:	e8 80 fe ff ff       	call   801a0d <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 0c                	push   $0xc
  801ba1:	e8 67 fe ff ff       	call   801a0d <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 0d                	push   $0xd
  801bba:	e8 4e fe ff ff       	call   801a0d <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	ff 75 0c             	pushl  0xc(%ebp)
  801bd0:	ff 75 08             	pushl  0x8(%ebp)
  801bd3:	6a 11                	push   $0x11
  801bd5:	e8 33 fe ff ff       	call   801a0d <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
	return;
  801bdd:	90                   	nop
}
  801bde:	c9                   	leave  
  801bdf:	c3                   	ret    

00801be0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	ff 75 0c             	pushl  0xc(%ebp)
  801bec:	ff 75 08             	pushl  0x8(%ebp)
  801bef:	6a 12                	push   $0x12
  801bf1:	e8 17 fe ff ff       	call   801a0d <syscall>
  801bf6:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf9:	90                   	nop
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 0e                	push   $0xe
  801c0b:	e8 fd fd ff ff       	call   801a0d <syscall>
  801c10:	83 c4 18             	add    $0x18,%esp
}
  801c13:	c9                   	leave  
  801c14:	c3                   	ret    

00801c15 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c15:	55                   	push   %ebp
  801c16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	ff 75 08             	pushl  0x8(%ebp)
  801c23:	6a 0f                	push   $0xf
  801c25:	e8 e3 fd ff ff       	call   801a0d <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
}
  801c2d:	c9                   	leave  
  801c2e:	c3                   	ret    

00801c2f <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c2f:	55                   	push   %ebp
  801c30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 10                	push   $0x10
  801c3e:	e8 ca fd ff ff       	call   801a0d <syscall>
  801c43:	83 c4 18             	add    $0x18,%esp
}
  801c46:	90                   	nop
  801c47:	c9                   	leave  
  801c48:	c3                   	ret    

00801c49 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c49:	55                   	push   %ebp
  801c4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 14                	push   $0x14
  801c58:	e8 b0 fd ff ff       	call   801a0d <syscall>
  801c5d:	83 c4 18             	add    $0x18,%esp
}
  801c60:	90                   	nop
  801c61:	c9                   	leave  
  801c62:	c3                   	ret    

00801c63 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c63:	55                   	push   %ebp
  801c64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 15                	push   $0x15
  801c72:	e8 96 fd ff ff       	call   801a0d <syscall>
  801c77:	83 c4 18             	add    $0x18,%esp
}
  801c7a:	90                   	nop
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <sys_cputc>:


void
sys_cputc(const char c)
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
  801c80:	83 ec 04             	sub    $0x4,%esp
  801c83:	8b 45 08             	mov    0x8(%ebp),%eax
  801c86:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c89:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	50                   	push   %eax
  801c96:	6a 16                	push   $0x16
  801c98:	e8 70 fd ff ff       	call   801a0d <syscall>
  801c9d:	83 c4 18             	add    $0x18,%esp
}
  801ca0:	90                   	nop
  801ca1:	c9                   	leave  
  801ca2:	c3                   	ret    

00801ca3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 17                	push   $0x17
  801cb2:	e8 56 fd ff ff       	call   801a0d <syscall>
  801cb7:	83 c4 18             	add    $0x18,%esp
}
  801cba:	90                   	nop
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    

00801cbd <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	ff 75 0c             	pushl  0xc(%ebp)
  801ccc:	50                   	push   %eax
  801ccd:	6a 18                	push   $0x18
  801ccf:	e8 39 fd ff ff       	call   801a0d <syscall>
  801cd4:	83 c4 18             	add    $0x18,%esp
}
  801cd7:	c9                   	leave  
  801cd8:	c3                   	ret    

00801cd9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cd9:	55                   	push   %ebp
  801cda:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	52                   	push   %edx
  801ce9:	50                   	push   %eax
  801cea:	6a 1b                	push   $0x1b
  801cec:	e8 1c fd ff ff       	call   801a0d <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
}
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	52                   	push   %edx
  801d06:	50                   	push   %eax
  801d07:	6a 19                	push   $0x19
  801d09:	e8 ff fc ff ff       	call   801a0d <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	90                   	nop
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	52                   	push   %edx
  801d24:	50                   	push   %eax
  801d25:	6a 1a                	push   $0x1a
  801d27:	e8 e1 fc ff ff       	call   801a0d <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
}
  801d2f:	90                   	nop
  801d30:	c9                   	leave  
  801d31:	c3                   	ret    

00801d32 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d32:	55                   	push   %ebp
  801d33:	89 e5                	mov    %esp,%ebp
  801d35:	83 ec 04             	sub    $0x4,%esp
  801d38:	8b 45 10             	mov    0x10(%ebp),%eax
  801d3b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d3e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d41:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d45:	8b 45 08             	mov    0x8(%ebp),%eax
  801d48:	6a 00                	push   $0x0
  801d4a:	51                   	push   %ecx
  801d4b:	52                   	push   %edx
  801d4c:	ff 75 0c             	pushl  0xc(%ebp)
  801d4f:	50                   	push   %eax
  801d50:	6a 1c                	push   $0x1c
  801d52:	e8 b6 fc ff ff       	call   801a0d <syscall>
  801d57:	83 c4 18             	add    $0x18,%esp
}
  801d5a:	c9                   	leave  
  801d5b:	c3                   	ret    

00801d5c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d5c:	55                   	push   %ebp
  801d5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d62:	8b 45 08             	mov    0x8(%ebp),%eax
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	52                   	push   %edx
  801d6c:	50                   	push   %eax
  801d6d:	6a 1d                	push   $0x1d
  801d6f:	e8 99 fc ff ff       	call   801a0d <syscall>
  801d74:	83 c4 18             	add    $0x18,%esp
}
  801d77:	c9                   	leave  
  801d78:	c3                   	ret    

00801d79 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d79:	55                   	push   %ebp
  801d7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d7c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d82:	8b 45 08             	mov    0x8(%ebp),%eax
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	51                   	push   %ecx
  801d8a:	52                   	push   %edx
  801d8b:	50                   	push   %eax
  801d8c:	6a 1e                	push   $0x1e
  801d8e:	e8 7a fc ff ff       	call   801a0d <syscall>
  801d93:	83 c4 18             	add    $0x18,%esp
}
  801d96:	c9                   	leave  
  801d97:	c3                   	ret    

00801d98 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d98:	55                   	push   %ebp
  801d99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	52                   	push   %edx
  801da8:	50                   	push   %eax
  801da9:	6a 1f                	push   $0x1f
  801dab:	e8 5d fc ff ff       	call   801a0d <syscall>
  801db0:	83 c4 18             	add    $0x18,%esp
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    

00801db5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801db5:	55                   	push   %ebp
  801db6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 20                	push   $0x20
  801dc4:	e8 44 fc ff ff       	call   801a0d <syscall>
  801dc9:	83 c4 18             	add    $0x18,%esp
}
  801dcc:	c9                   	leave  
  801dcd:	c3                   	ret    

00801dce <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801dce:	55                   	push   %ebp
  801dcf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	ff 75 10             	pushl  0x10(%ebp)
  801ddb:	ff 75 0c             	pushl  0xc(%ebp)
  801dde:	50                   	push   %eax
  801ddf:	6a 21                	push   $0x21
  801de1:	e8 27 fc ff ff       	call   801a0d <syscall>
  801de6:	83 c4 18             	add    $0x18,%esp
}
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dee:	8b 45 08             	mov    0x8(%ebp),%eax
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	50                   	push   %eax
  801dfa:	6a 22                	push   $0x22
  801dfc:	e8 0c fc ff ff       	call   801a0d <syscall>
  801e01:	83 c4 18             	add    $0x18,%esp
}
  801e04:	90                   	nop
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	50                   	push   %eax
  801e16:	6a 23                	push   $0x23
  801e18:	e8 f0 fb ff ff       	call   801a0d <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	90                   	nop
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
  801e26:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e29:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e2c:	8d 50 04             	lea    0x4(%eax),%edx
  801e2f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	52                   	push   %edx
  801e39:	50                   	push   %eax
  801e3a:	6a 24                	push   $0x24
  801e3c:	e8 cc fb ff ff       	call   801a0d <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
	return result;
  801e44:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e4a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e4d:	89 01                	mov    %eax,(%ecx)
  801e4f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e52:	8b 45 08             	mov    0x8(%ebp),%eax
  801e55:	c9                   	leave  
  801e56:	c2 04 00             	ret    $0x4

00801e59 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e59:	55                   	push   %ebp
  801e5a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	ff 75 10             	pushl  0x10(%ebp)
  801e63:	ff 75 0c             	pushl  0xc(%ebp)
  801e66:	ff 75 08             	pushl  0x8(%ebp)
  801e69:	6a 13                	push   $0x13
  801e6b:	e8 9d fb ff ff       	call   801a0d <syscall>
  801e70:	83 c4 18             	add    $0x18,%esp
	return ;
  801e73:	90                   	nop
}
  801e74:	c9                   	leave  
  801e75:	c3                   	ret    

00801e76 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e76:	55                   	push   %ebp
  801e77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	6a 25                	push   $0x25
  801e85:	e8 83 fb ff ff       	call   801a0d <syscall>
  801e8a:	83 c4 18             	add    $0x18,%esp
}
  801e8d:	c9                   	leave  
  801e8e:	c3                   	ret    

00801e8f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e8f:	55                   	push   %ebp
  801e90:	89 e5                	mov    %esp,%ebp
  801e92:	83 ec 04             	sub    $0x4,%esp
  801e95:	8b 45 08             	mov    0x8(%ebp),%eax
  801e98:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e9b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	50                   	push   %eax
  801ea8:	6a 26                	push   $0x26
  801eaa:	e8 5e fb ff ff       	call   801a0d <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
	return ;
  801eb2:	90                   	nop
}
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <rsttst>:
void rsttst()
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 28                	push   $0x28
  801ec4:	e8 44 fb ff ff       	call   801a0d <syscall>
  801ec9:	83 c4 18             	add    $0x18,%esp
	return ;
  801ecc:	90                   	nop
}
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
  801ed2:	83 ec 04             	sub    $0x4,%esp
  801ed5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ed8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801edb:	8b 55 18             	mov    0x18(%ebp),%edx
  801ede:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ee2:	52                   	push   %edx
  801ee3:	50                   	push   %eax
  801ee4:	ff 75 10             	pushl  0x10(%ebp)
  801ee7:	ff 75 0c             	pushl  0xc(%ebp)
  801eea:	ff 75 08             	pushl  0x8(%ebp)
  801eed:	6a 27                	push   $0x27
  801eef:	e8 19 fb ff ff       	call   801a0d <syscall>
  801ef4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef7:	90                   	nop
}
  801ef8:	c9                   	leave  
  801ef9:	c3                   	ret    

00801efa <chktst>:
void chktst(uint32 n)
{
  801efa:	55                   	push   %ebp
  801efb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	ff 75 08             	pushl  0x8(%ebp)
  801f08:	6a 29                	push   $0x29
  801f0a:	e8 fe fa ff ff       	call   801a0d <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
	return ;
  801f12:	90                   	nop
}
  801f13:	c9                   	leave  
  801f14:	c3                   	ret    

00801f15 <inctst>:

void inctst()
{
  801f15:	55                   	push   %ebp
  801f16:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 2a                	push   $0x2a
  801f24:	e8 e4 fa ff ff       	call   801a0d <syscall>
  801f29:	83 c4 18             	add    $0x18,%esp
	return ;
  801f2c:	90                   	nop
}
  801f2d:	c9                   	leave  
  801f2e:	c3                   	ret    

00801f2f <gettst>:
uint32 gettst()
{
  801f2f:	55                   	push   %ebp
  801f30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 2b                	push   $0x2b
  801f3e:	e8 ca fa ff ff       	call   801a0d <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
}
  801f46:	c9                   	leave  
  801f47:	c3                   	ret    

00801f48 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f48:	55                   	push   %ebp
  801f49:	89 e5                	mov    %esp,%ebp
  801f4b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 2c                	push   $0x2c
  801f5a:	e8 ae fa ff ff       	call   801a0d <syscall>
  801f5f:	83 c4 18             	add    $0x18,%esp
  801f62:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f65:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f69:	75 07                	jne    801f72 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f6b:	b8 01 00 00 00       	mov    $0x1,%eax
  801f70:	eb 05                	jmp    801f77 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f72:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f77:	c9                   	leave  
  801f78:	c3                   	ret    

00801f79 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f79:	55                   	push   %ebp
  801f7a:	89 e5                	mov    %esp,%ebp
  801f7c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 2c                	push   $0x2c
  801f8b:	e8 7d fa ff ff       	call   801a0d <syscall>
  801f90:	83 c4 18             	add    $0x18,%esp
  801f93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f96:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f9a:	75 07                	jne    801fa3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f9c:	b8 01 00 00 00       	mov    $0x1,%eax
  801fa1:	eb 05                	jmp    801fa8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fa3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fa8:	c9                   	leave  
  801fa9:	c3                   	ret    

00801faa <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801faa:	55                   	push   %ebp
  801fab:	89 e5                	mov    %esp,%ebp
  801fad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 2c                	push   $0x2c
  801fbc:	e8 4c fa ff ff       	call   801a0d <syscall>
  801fc1:	83 c4 18             	add    $0x18,%esp
  801fc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fc7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fcb:	75 07                	jne    801fd4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fcd:	b8 01 00 00 00       	mov    $0x1,%eax
  801fd2:	eb 05                	jmp    801fd9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fd9:	c9                   	leave  
  801fda:	c3                   	ret    

00801fdb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fdb:	55                   	push   %ebp
  801fdc:	89 e5                	mov    %esp,%ebp
  801fde:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 2c                	push   $0x2c
  801fed:	e8 1b fa ff ff       	call   801a0d <syscall>
  801ff2:	83 c4 18             	add    $0x18,%esp
  801ff5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ff8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ffc:	75 07                	jne    802005 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ffe:	b8 01 00 00 00       	mov    $0x1,%eax
  802003:	eb 05                	jmp    80200a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802005:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80200a:	c9                   	leave  
  80200b:	c3                   	ret    

0080200c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80200c:	55                   	push   %ebp
  80200d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	ff 75 08             	pushl  0x8(%ebp)
  80201a:	6a 2d                	push   $0x2d
  80201c:	e8 ec f9 ff ff       	call   801a0d <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
	return ;
  802024:	90                   	nop
}
  802025:	c9                   	leave  
  802026:	c3                   	ret    
  802027:	90                   	nop

00802028 <__udivdi3>:
  802028:	55                   	push   %ebp
  802029:	57                   	push   %edi
  80202a:	56                   	push   %esi
  80202b:	53                   	push   %ebx
  80202c:	83 ec 1c             	sub    $0x1c,%esp
  80202f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802033:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802037:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80203b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80203f:	89 ca                	mov    %ecx,%edx
  802041:	89 f8                	mov    %edi,%eax
  802043:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802047:	85 f6                	test   %esi,%esi
  802049:	75 2d                	jne    802078 <__udivdi3+0x50>
  80204b:	39 cf                	cmp    %ecx,%edi
  80204d:	77 65                	ja     8020b4 <__udivdi3+0x8c>
  80204f:	89 fd                	mov    %edi,%ebp
  802051:	85 ff                	test   %edi,%edi
  802053:	75 0b                	jne    802060 <__udivdi3+0x38>
  802055:	b8 01 00 00 00       	mov    $0x1,%eax
  80205a:	31 d2                	xor    %edx,%edx
  80205c:	f7 f7                	div    %edi
  80205e:	89 c5                	mov    %eax,%ebp
  802060:	31 d2                	xor    %edx,%edx
  802062:	89 c8                	mov    %ecx,%eax
  802064:	f7 f5                	div    %ebp
  802066:	89 c1                	mov    %eax,%ecx
  802068:	89 d8                	mov    %ebx,%eax
  80206a:	f7 f5                	div    %ebp
  80206c:	89 cf                	mov    %ecx,%edi
  80206e:	89 fa                	mov    %edi,%edx
  802070:	83 c4 1c             	add    $0x1c,%esp
  802073:	5b                   	pop    %ebx
  802074:	5e                   	pop    %esi
  802075:	5f                   	pop    %edi
  802076:	5d                   	pop    %ebp
  802077:	c3                   	ret    
  802078:	39 ce                	cmp    %ecx,%esi
  80207a:	77 28                	ja     8020a4 <__udivdi3+0x7c>
  80207c:	0f bd fe             	bsr    %esi,%edi
  80207f:	83 f7 1f             	xor    $0x1f,%edi
  802082:	75 40                	jne    8020c4 <__udivdi3+0x9c>
  802084:	39 ce                	cmp    %ecx,%esi
  802086:	72 0a                	jb     802092 <__udivdi3+0x6a>
  802088:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80208c:	0f 87 9e 00 00 00    	ja     802130 <__udivdi3+0x108>
  802092:	b8 01 00 00 00       	mov    $0x1,%eax
  802097:	89 fa                	mov    %edi,%edx
  802099:	83 c4 1c             	add    $0x1c,%esp
  80209c:	5b                   	pop    %ebx
  80209d:	5e                   	pop    %esi
  80209e:	5f                   	pop    %edi
  80209f:	5d                   	pop    %ebp
  8020a0:	c3                   	ret    
  8020a1:	8d 76 00             	lea    0x0(%esi),%esi
  8020a4:	31 ff                	xor    %edi,%edi
  8020a6:	31 c0                	xor    %eax,%eax
  8020a8:	89 fa                	mov    %edi,%edx
  8020aa:	83 c4 1c             	add    $0x1c,%esp
  8020ad:	5b                   	pop    %ebx
  8020ae:	5e                   	pop    %esi
  8020af:	5f                   	pop    %edi
  8020b0:	5d                   	pop    %ebp
  8020b1:	c3                   	ret    
  8020b2:	66 90                	xchg   %ax,%ax
  8020b4:	89 d8                	mov    %ebx,%eax
  8020b6:	f7 f7                	div    %edi
  8020b8:	31 ff                	xor    %edi,%edi
  8020ba:	89 fa                	mov    %edi,%edx
  8020bc:	83 c4 1c             	add    $0x1c,%esp
  8020bf:	5b                   	pop    %ebx
  8020c0:	5e                   	pop    %esi
  8020c1:	5f                   	pop    %edi
  8020c2:	5d                   	pop    %ebp
  8020c3:	c3                   	ret    
  8020c4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020c9:	89 eb                	mov    %ebp,%ebx
  8020cb:	29 fb                	sub    %edi,%ebx
  8020cd:	89 f9                	mov    %edi,%ecx
  8020cf:	d3 e6                	shl    %cl,%esi
  8020d1:	89 c5                	mov    %eax,%ebp
  8020d3:	88 d9                	mov    %bl,%cl
  8020d5:	d3 ed                	shr    %cl,%ebp
  8020d7:	89 e9                	mov    %ebp,%ecx
  8020d9:	09 f1                	or     %esi,%ecx
  8020db:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020df:	89 f9                	mov    %edi,%ecx
  8020e1:	d3 e0                	shl    %cl,%eax
  8020e3:	89 c5                	mov    %eax,%ebp
  8020e5:	89 d6                	mov    %edx,%esi
  8020e7:	88 d9                	mov    %bl,%cl
  8020e9:	d3 ee                	shr    %cl,%esi
  8020eb:	89 f9                	mov    %edi,%ecx
  8020ed:	d3 e2                	shl    %cl,%edx
  8020ef:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020f3:	88 d9                	mov    %bl,%cl
  8020f5:	d3 e8                	shr    %cl,%eax
  8020f7:	09 c2                	or     %eax,%edx
  8020f9:	89 d0                	mov    %edx,%eax
  8020fb:	89 f2                	mov    %esi,%edx
  8020fd:	f7 74 24 0c          	divl   0xc(%esp)
  802101:	89 d6                	mov    %edx,%esi
  802103:	89 c3                	mov    %eax,%ebx
  802105:	f7 e5                	mul    %ebp
  802107:	39 d6                	cmp    %edx,%esi
  802109:	72 19                	jb     802124 <__udivdi3+0xfc>
  80210b:	74 0b                	je     802118 <__udivdi3+0xf0>
  80210d:	89 d8                	mov    %ebx,%eax
  80210f:	31 ff                	xor    %edi,%edi
  802111:	e9 58 ff ff ff       	jmp    80206e <__udivdi3+0x46>
  802116:	66 90                	xchg   %ax,%ax
  802118:	8b 54 24 08          	mov    0x8(%esp),%edx
  80211c:	89 f9                	mov    %edi,%ecx
  80211e:	d3 e2                	shl    %cl,%edx
  802120:	39 c2                	cmp    %eax,%edx
  802122:	73 e9                	jae    80210d <__udivdi3+0xe5>
  802124:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802127:	31 ff                	xor    %edi,%edi
  802129:	e9 40 ff ff ff       	jmp    80206e <__udivdi3+0x46>
  80212e:	66 90                	xchg   %ax,%ax
  802130:	31 c0                	xor    %eax,%eax
  802132:	e9 37 ff ff ff       	jmp    80206e <__udivdi3+0x46>
  802137:	90                   	nop

00802138 <__umoddi3>:
  802138:	55                   	push   %ebp
  802139:	57                   	push   %edi
  80213a:	56                   	push   %esi
  80213b:	53                   	push   %ebx
  80213c:	83 ec 1c             	sub    $0x1c,%esp
  80213f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802143:	8b 74 24 34          	mov    0x34(%esp),%esi
  802147:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80214b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80214f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802153:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802157:	89 f3                	mov    %esi,%ebx
  802159:	89 fa                	mov    %edi,%edx
  80215b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80215f:	89 34 24             	mov    %esi,(%esp)
  802162:	85 c0                	test   %eax,%eax
  802164:	75 1a                	jne    802180 <__umoddi3+0x48>
  802166:	39 f7                	cmp    %esi,%edi
  802168:	0f 86 a2 00 00 00    	jbe    802210 <__umoddi3+0xd8>
  80216e:	89 c8                	mov    %ecx,%eax
  802170:	89 f2                	mov    %esi,%edx
  802172:	f7 f7                	div    %edi
  802174:	89 d0                	mov    %edx,%eax
  802176:	31 d2                	xor    %edx,%edx
  802178:	83 c4 1c             	add    $0x1c,%esp
  80217b:	5b                   	pop    %ebx
  80217c:	5e                   	pop    %esi
  80217d:	5f                   	pop    %edi
  80217e:	5d                   	pop    %ebp
  80217f:	c3                   	ret    
  802180:	39 f0                	cmp    %esi,%eax
  802182:	0f 87 ac 00 00 00    	ja     802234 <__umoddi3+0xfc>
  802188:	0f bd e8             	bsr    %eax,%ebp
  80218b:	83 f5 1f             	xor    $0x1f,%ebp
  80218e:	0f 84 ac 00 00 00    	je     802240 <__umoddi3+0x108>
  802194:	bf 20 00 00 00       	mov    $0x20,%edi
  802199:	29 ef                	sub    %ebp,%edi
  80219b:	89 fe                	mov    %edi,%esi
  80219d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021a1:	89 e9                	mov    %ebp,%ecx
  8021a3:	d3 e0                	shl    %cl,%eax
  8021a5:	89 d7                	mov    %edx,%edi
  8021a7:	89 f1                	mov    %esi,%ecx
  8021a9:	d3 ef                	shr    %cl,%edi
  8021ab:	09 c7                	or     %eax,%edi
  8021ad:	89 e9                	mov    %ebp,%ecx
  8021af:	d3 e2                	shl    %cl,%edx
  8021b1:	89 14 24             	mov    %edx,(%esp)
  8021b4:	89 d8                	mov    %ebx,%eax
  8021b6:	d3 e0                	shl    %cl,%eax
  8021b8:	89 c2                	mov    %eax,%edx
  8021ba:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021be:	d3 e0                	shl    %cl,%eax
  8021c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021c4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021c8:	89 f1                	mov    %esi,%ecx
  8021ca:	d3 e8                	shr    %cl,%eax
  8021cc:	09 d0                	or     %edx,%eax
  8021ce:	d3 eb                	shr    %cl,%ebx
  8021d0:	89 da                	mov    %ebx,%edx
  8021d2:	f7 f7                	div    %edi
  8021d4:	89 d3                	mov    %edx,%ebx
  8021d6:	f7 24 24             	mull   (%esp)
  8021d9:	89 c6                	mov    %eax,%esi
  8021db:	89 d1                	mov    %edx,%ecx
  8021dd:	39 d3                	cmp    %edx,%ebx
  8021df:	0f 82 87 00 00 00    	jb     80226c <__umoddi3+0x134>
  8021e5:	0f 84 91 00 00 00    	je     80227c <__umoddi3+0x144>
  8021eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021ef:	29 f2                	sub    %esi,%edx
  8021f1:	19 cb                	sbb    %ecx,%ebx
  8021f3:	89 d8                	mov    %ebx,%eax
  8021f5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021f9:	d3 e0                	shl    %cl,%eax
  8021fb:	89 e9                	mov    %ebp,%ecx
  8021fd:	d3 ea                	shr    %cl,%edx
  8021ff:	09 d0                	or     %edx,%eax
  802201:	89 e9                	mov    %ebp,%ecx
  802203:	d3 eb                	shr    %cl,%ebx
  802205:	89 da                	mov    %ebx,%edx
  802207:	83 c4 1c             	add    $0x1c,%esp
  80220a:	5b                   	pop    %ebx
  80220b:	5e                   	pop    %esi
  80220c:	5f                   	pop    %edi
  80220d:	5d                   	pop    %ebp
  80220e:	c3                   	ret    
  80220f:	90                   	nop
  802210:	89 fd                	mov    %edi,%ebp
  802212:	85 ff                	test   %edi,%edi
  802214:	75 0b                	jne    802221 <__umoddi3+0xe9>
  802216:	b8 01 00 00 00       	mov    $0x1,%eax
  80221b:	31 d2                	xor    %edx,%edx
  80221d:	f7 f7                	div    %edi
  80221f:	89 c5                	mov    %eax,%ebp
  802221:	89 f0                	mov    %esi,%eax
  802223:	31 d2                	xor    %edx,%edx
  802225:	f7 f5                	div    %ebp
  802227:	89 c8                	mov    %ecx,%eax
  802229:	f7 f5                	div    %ebp
  80222b:	89 d0                	mov    %edx,%eax
  80222d:	e9 44 ff ff ff       	jmp    802176 <__umoddi3+0x3e>
  802232:	66 90                	xchg   %ax,%ax
  802234:	89 c8                	mov    %ecx,%eax
  802236:	89 f2                	mov    %esi,%edx
  802238:	83 c4 1c             	add    $0x1c,%esp
  80223b:	5b                   	pop    %ebx
  80223c:	5e                   	pop    %esi
  80223d:	5f                   	pop    %edi
  80223e:	5d                   	pop    %ebp
  80223f:	c3                   	ret    
  802240:	3b 04 24             	cmp    (%esp),%eax
  802243:	72 06                	jb     80224b <__umoddi3+0x113>
  802245:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802249:	77 0f                	ja     80225a <__umoddi3+0x122>
  80224b:	89 f2                	mov    %esi,%edx
  80224d:	29 f9                	sub    %edi,%ecx
  80224f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802253:	89 14 24             	mov    %edx,(%esp)
  802256:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80225a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80225e:	8b 14 24             	mov    (%esp),%edx
  802261:	83 c4 1c             	add    $0x1c,%esp
  802264:	5b                   	pop    %ebx
  802265:	5e                   	pop    %esi
  802266:	5f                   	pop    %edi
  802267:	5d                   	pop    %ebp
  802268:	c3                   	ret    
  802269:	8d 76 00             	lea    0x0(%esi),%esi
  80226c:	2b 04 24             	sub    (%esp),%eax
  80226f:	19 fa                	sbb    %edi,%edx
  802271:	89 d1                	mov    %edx,%ecx
  802273:	89 c6                	mov    %eax,%esi
  802275:	e9 71 ff ff ff       	jmp    8021eb <__umoddi3+0xb3>
  80227a:	66 90                	xchg   %ax,%ax
  80227c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802280:	72 ea                	jb     80226c <__umoddi3+0x134>
  802282:	89 d9                	mov    %ebx,%ecx
  802284:	e9 62 ff ff ff       	jmp    8021eb <__umoddi3+0xb3>
