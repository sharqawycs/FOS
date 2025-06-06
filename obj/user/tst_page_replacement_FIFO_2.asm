
obj/user/tst_page_replacement_FIFO_2:     file format elf32-i386


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
  800031:	e8 1f 07 00 00       	call   800755 <libmain>
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
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec bc 00 00 00    	sub    $0xbc,%esp

//	cprintf("envID = %d\n",envID);



	char* tempArr = (char*)0x80000000;
  800044:	c7 45 cc 00 00 00 80 	movl   $0x80000000,-0x34(%ebp)
	//sys_allocateMem(0x80000000, 15*1024);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80004b:	a1 20 30 80 00       	mov    0x803020,%eax
  800050:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800056:	8b 00                	mov    (%eax),%eax
  800058:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80005b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80005e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800063:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800068:	74 14                	je     80007e <_main+0x46>
  80006a:	83 ec 04             	sub    $0x4,%esp
  80006d:	68 20 21 80 00       	push   $0x802120
  800072:	6a 17                	push   $0x17
  800074:	68 64 21 80 00       	push   $0x802164
  800079:	e8 d9 07 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80007e:	a1 20 30 80 00       	mov    0x803020,%eax
  800083:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800089:	83 c0 0c             	add    $0xc,%eax
  80008c:	8b 00                	mov    (%eax),%eax
  80008e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800091:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800094:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800099:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80009e:	74 14                	je     8000b4 <_main+0x7c>
  8000a0:	83 ec 04             	sub    $0x4,%esp
  8000a3:	68 20 21 80 00       	push   $0x802120
  8000a8:	6a 18                	push   $0x18
  8000aa:	68 64 21 80 00       	push   $0x802164
  8000af:	e8 a3 07 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000bf:	83 c0 18             	add    $0x18,%eax
  8000c2:	8b 00                	mov    (%eax),%eax
  8000c4:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8000c7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8000ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000cf:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000d4:	74 14                	je     8000ea <_main+0xb2>
  8000d6:	83 ec 04             	sub    $0x4,%esp
  8000d9:	68 20 21 80 00       	push   $0x802120
  8000de:	6a 19                	push   $0x19
  8000e0:	68 64 21 80 00       	push   $0x802164
  8000e5:	e8 6d 07 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ef:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000f5:	83 c0 24             	add    $0x24,%eax
  8000f8:	8b 00                	mov    (%eax),%eax
  8000fa:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8000fd:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800100:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800105:	3d 00 30 20 00       	cmp    $0x203000,%eax
  80010a:	74 14                	je     800120 <_main+0xe8>
  80010c:	83 ec 04             	sub    $0x4,%esp
  80010f:	68 20 21 80 00       	push   $0x802120
  800114:	6a 1a                	push   $0x1a
  800116:	68 64 21 80 00       	push   $0x802164
  80011b:	e8 37 07 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800120:	a1 20 30 80 00       	mov    0x803020,%eax
  800125:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80012b:	83 c0 30             	add    $0x30,%eax
  80012e:	8b 00                	mov    (%eax),%eax
  800130:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800133:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800136:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80013b:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800140:	74 14                	je     800156 <_main+0x11e>
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	68 20 21 80 00       	push   $0x802120
  80014a:	6a 1b                	push   $0x1b
  80014c:	68 64 21 80 00       	push   $0x802164
  800151:	e8 01 07 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800156:	a1 20 30 80 00       	mov    0x803020,%eax
  80015b:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800161:	83 c0 3c             	add    $0x3c,%eax
  800164:	8b 00                	mov    (%eax),%eax
  800166:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800169:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80016c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800171:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800176:	74 14                	je     80018c <_main+0x154>
  800178:	83 ec 04             	sub    $0x4,%esp
  80017b:	68 20 21 80 00       	push   $0x802120
  800180:	6a 1c                	push   $0x1c
  800182:	68 64 21 80 00       	push   $0x802164
  800187:	e8 cb 06 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80018c:	a1 20 30 80 00       	mov    0x803020,%eax
  800191:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800197:	83 c0 48             	add    $0x48,%eax
  80019a:	8b 00                	mov    (%eax),%eax
  80019c:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80019f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8001a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a7:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001ac:	74 14                	je     8001c2 <_main+0x18a>
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	68 20 21 80 00       	push   $0x802120
  8001b6:	6a 1d                	push   $0x1d
  8001b8:	68 64 21 80 00       	push   $0x802164
  8001bd:	e8 95 06 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c7:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001cd:	83 c0 54             	add    $0x54,%eax
  8001d0:	8b 00                	mov    (%eax),%eax
  8001d2:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8001d5:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8001d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001dd:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001e2:	74 14                	je     8001f8 <_main+0x1c0>
  8001e4:	83 ec 04             	sub    $0x4,%esp
  8001e7:	68 20 21 80 00       	push   $0x802120
  8001ec:	6a 1e                	push   $0x1e
  8001ee:	68 64 21 80 00       	push   $0x802164
  8001f3:	e8 5f 06 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fd:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800203:	83 c0 60             	add    $0x60,%eax
  800206:	8b 00                	mov    (%eax),%eax
  800208:	89 45 a8             	mov    %eax,-0x58(%ebp)
  80020b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80020e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800213:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800218:	74 14                	je     80022e <_main+0x1f6>
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	68 20 21 80 00       	push   $0x802120
  800222:	6a 1f                	push   $0x1f
  800224:	68 64 21 80 00       	push   $0x802164
  800229:	e8 29 06 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80022e:	a1 20 30 80 00       	mov    0x803020,%eax
  800233:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800239:	83 c0 6c             	add    $0x6c,%eax
  80023c:	8b 00                	mov    (%eax),%eax
  80023e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800241:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800244:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800249:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80024e:	74 14                	je     800264 <_main+0x22c>
  800250:	83 ec 04             	sub    $0x4,%esp
  800253:	68 20 21 80 00       	push   $0x802120
  800258:	6a 20                	push   $0x20
  80025a:	68 64 21 80 00       	push   $0x802164
  80025f:	e8 f3 05 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800264:	a1 20 30 80 00       	mov    0x803020,%eax
  800269:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80026f:	83 c0 78             	add    $0x78,%eax
  800272:	8b 00                	mov    (%eax),%eax
  800274:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800277:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80027a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800284:	74 14                	je     80029a <_main+0x262>
  800286:	83 ec 04             	sub    $0x4,%esp
  800289:	68 20 21 80 00       	push   $0x802120
  80028e:	6a 21                	push   $0x21
  800290:	68 64 21 80 00       	push   $0x802164
  800295:	e8 bd 05 00 00       	call   800857 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80029a:	a1 20 30 80 00       	mov    0x803020,%eax
  80029f:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  8002a5:	85 c0                	test   %eax,%eax
  8002a7:	74 14                	je     8002bd <_main+0x285>
  8002a9:	83 ec 04             	sub    $0x4,%esp
  8002ac:	68 88 21 80 00       	push   $0x802188
  8002b1:	6a 22                	push   $0x22
  8002b3:	68 64 21 80 00       	push   $0x802164
  8002b8:	e8 9a 05 00 00       	call   800857 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002bd:	e8 3f 17 00 00       	call   801a01 <sys_calculate_free_frames>
  8002c2:	89 45 9c             	mov    %eax,-0x64(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c5:	e8 ba 17 00 00       	call   801a84 <sys_pf_calculate_allocated_pages>
  8002ca:	89 45 98             	mov    %eax,-0x68(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  8002cd:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002d2:	88 45 97             	mov    %al,-0x69(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  8002d5:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002da:	88 45 96             	mov    %al,-0x6a(%ebp)
	char garbage4, garbage5;

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  8002dd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8002e4:	eb 26                	jmp    80030c <_main+0x2d4>
	{
		arr[i] = -1 ;
  8002e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e9:	05 40 30 80 00       	add    $0x803040,%eax
  8002ee:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		//ptr++ ; ptr2++ ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  8002f1:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f6:	8a 00                	mov    (%eax),%al
  8002f8:	88 45 e7             	mov    %al,-0x19(%ebp)
		garbage5 = *ptr2 ;
  8002fb:	a1 04 30 80 00       	mov    0x803004,%eax
  800300:	8a 00                	mov    (%eax),%al
  800302:	88 45 e6             	mov    %al,-0x1a(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
	char garbage4, garbage5;

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*5 ; i+=PAGE_SIZE/2)
  800305:	81 45 e0 00 08 00 00 	addl   $0x800,-0x20(%ebp)
  80030c:	81 7d e0 ff 4f 00 00 	cmpl   $0x4fff,-0x20(%ebp)
  800313:	7e d1                	jle    8002e6 <_main+0x2ae>
		garbage5 = *ptr2 ;
	}

	//Check FIFO 1
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x80e000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800315:	a1 20 30 80 00       	mov    0x803020,%eax
  80031a:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800320:	8b 00                	mov    (%eax),%eax
  800322:	89 45 90             	mov    %eax,-0x70(%ebp)
  800325:	8b 45 90             	mov    -0x70(%ebp),%eax
  800328:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80032d:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  800332:	74 14                	je     800348 <_main+0x310>
  800334:	83 ec 04             	sub    $0x4,%esp
  800337:	68 d0 21 80 00       	push   $0x8021d0
  80033c:	6a 3d                	push   $0x3d
  80033e:	68 64 21 80 00       	push   $0x802164
  800343:	e8 0f 05 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800348:	a1 20 30 80 00       	mov    0x803020,%eax
  80034d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800353:	83 c0 0c             	add    $0xc,%eax
  800356:	8b 00                	mov    (%eax),%eax
  800358:	89 45 8c             	mov    %eax,-0x74(%ebp)
  80035b:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80035e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800363:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  800368:	74 14                	je     80037e <_main+0x346>
  80036a:	83 ec 04             	sub    $0x4,%esp
  80036d:	68 d0 21 80 00       	push   $0x8021d0
  800372:	6a 3e                	push   $0x3e
  800374:	68 64 21 80 00       	push   $0x802164
  800379:	e8 d9 04 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80037e:	a1 20 30 80 00       	mov    0x803020,%eax
  800383:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800389:	83 c0 18             	add    $0x18,%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	89 45 88             	mov    %eax,-0x78(%ebp)
  800391:	8b 45 88             	mov    -0x78(%ebp),%eax
  800394:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800399:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80039e:	74 14                	je     8003b4 <_main+0x37c>
  8003a0:	83 ec 04             	sub    $0x4,%esp
  8003a3:	68 d0 21 80 00       	push   $0x8021d0
  8003a8:	6a 3f                	push   $0x3f
  8003aa:	68 64 21 80 00       	push   $0x802164
  8003af:	e8 a3 04 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003bf:	83 c0 24             	add    $0x24,%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	89 45 84             	mov    %eax,-0x7c(%ebp)
  8003c7:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003cf:	3d 00 50 80 00       	cmp    $0x805000,%eax
  8003d4:	74 14                	je     8003ea <_main+0x3b2>
  8003d6:	83 ec 04             	sub    $0x4,%esp
  8003d9:	68 d0 21 80 00       	push   $0x8021d0
  8003de:	6a 40                	push   $0x40
  8003e0:	68 64 21 80 00       	push   $0x802164
  8003e5:	e8 6d 04 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ef:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8003f5:	83 c0 30             	add    $0x30,%eax
  8003f8:	8b 00                	mov    (%eax),%eax
  8003fa:	89 45 80             	mov    %eax,-0x80(%ebp)
  8003fd:	8b 45 80             	mov    -0x80(%ebp),%eax
  800400:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800405:	3d 00 60 80 00       	cmp    $0x806000,%eax
  80040a:	74 14                	je     800420 <_main+0x3e8>
  80040c:	83 ec 04             	sub    $0x4,%esp
  80040f:	68 d0 21 80 00       	push   $0x8021d0
  800414:	6a 41                	push   $0x41
  800416:	68 64 21 80 00       	push   $0x802164
  80041b:	e8 37 04 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800420:	a1 20 30 80 00       	mov    0x803020,%eax
  800425:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80042b:	83 c0 3c             	add    $0x3c,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  800436:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80043c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800441:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800446:	74 14                	je     80045c <_main+0x424>
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 d0 21 80 00       	push   $0x8021d0
  800450:	6a 42                	push   $0x42
  800452:	68 64 21 80 00       	push   $0x802164
  800457:	e8 fb 03 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80045c:	a1 20 30 80 00       	mov    0x803020,%eax
  800461:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800467:	83 c0 48             	add    $0x48,%eax
  80046a:	8b 00                	mov    (%eax),%eax
  80046c:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  800472:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800478:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80047d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800482:	74 14                	je     800498 <_main+0x460>
  800484:	83 ec 04             	sub    $0x4,%esp
  800487:	68 d0 21 80 00       	push   $0x8021d0
  80048c:	6a 43                	push   $0x43
  80048e:	68 64 21 80 00       	push   $0x802164
  800493:	e8 bf 03 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800498:	a1 20 30 80 00       	mov    0x803020,%eax
  80049d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004a3:	83 c0 54             	add    $0x54,%eax
  8004a6:	8b 00                	mov    (%eax),%eax
  8004a8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  8004ae:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8004b4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004b9:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004be:	74 14                	je     8004d4 <_main+0x49c>
  8004c0:	83 ec 04             	sub    $0x4,%esp
  8004c3:	68 d0 21 80 00       	push   $0x8021d0
  8004c8:	6a 44                	push   $0x44
  8004ca:	68 64 21 80 00       	push   $0x802164
  8004cf:	e8 83 03 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x802000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004d4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d9:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8004df:	83 c0 60             	add    $0x60,%eax
  8004e2:	8b 00                	mov    (%eax),%eax
  8004e4:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  8004ea:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8004f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004f5:	3d 00 20 80 00       	cmp    $0x802000,%eax
  8004fa:	74 14                	je     800510 <_main+0x4d8>
  8004fc:	83 ec 04             	sub    $0x4,%esp
  8004ff:	68 d0 21 80 00       	push   $0x8021d0
  800504:	6a 45                	push   $0x45
  800506:	68 64 21 80 00       	push   $0x802164
  80050b:	e8 47 03 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800510:	a1 20 30 80 00       	mov    0x803020,%eax
  800515:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80051b:	83 c0 6c             	add    $0x6c,%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800526:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80052c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800531:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800536:	74 14                	je     80054c <_main+0x514>
  800538:	83 ec 04             	sub    $0x4,%esp
  80053b:	68 d0 21 80 00       	push   $0x8021d0
  800540:	6a 46                	push   $0x46
  800542:	68 64 21 80 00       	push   $0x802164
  800547:	e8 0b 03 00 00       	call   800857 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80054c:	a1 20 30 80 00       	mov    0x803020,%eax
  800551:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800557:	83 c0 78             	add    $0x78,%eax
  80055a:	8b 00                	mov    (%eax),%eax
  80055c:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800562:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800568:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80056d:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800572:	74 14                	je     800588 <_main+0x550>
  800574:	83 ec 04             	sub    $0x4,%esp
  800577:	68 d0 21 80 00       	push   $0x8021d0
  80057c:	6a 47                	push   $0x47
  80057e:	68 64 21 80 00       	push   $0x802164
  800583:	e8 cf 02 00 00       	call   800857 <_panic>

		if(myEnv->page_last_WS_index != 6) panic("wrong PAGE WS pointer location");
  800588:	a1 20 30 80 00       	mov    0x803020,%eax
  80058d:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800593:	83 f8 06             	cmp    $0x6,%eax
  800596:	74 14                	je     8005ac <_main+0x574>
  800598:	83 ec 04             	sub    $0x4,%esp
  80059b:	68 1c 22 80 00       	push   $0x80221c
  8005a0:	6a 49                	push   $0x49
  8005a2:	68 64 21 80 00       	push   $0x802164
  8005a7:	e8 ab 02 00 00       	call   800857 <_panic>
	}

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
  8005ac:	83 ec 08             	sub    $0x8,%esp
  8005af:	68 00 40 00 00       	push   $0x4000
  8005b4:	68 00 00 00 80       	push   $0x80000000
  8005b9:	e8 aa 14 00 00       	call   801a68 <sys_allocateMem>
  8005be:	83 c4 10             	add    $0x10,%esp
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8005c1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8005c8:	eb 0e                	jmp    8005d8 <_main+0x5a0>
	{
		tempArr[c] = 'a';
  8005ca:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005cd:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8005d0:	01 d0                	add    %edx,%eax
  8005d2:	c6 00 61             	movb   $0x61,(%eax)

	sys_allocateMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("1\n");

	int c;
	for(c = 0;c< 15*1024;c++)
  8005d5:	ff 45 dc             	incl   -0x24(%ebp)
  8005d8:	81 7d dc ff 3b 00 00 	cmpl   $0x3bff,-0x24(%ebp)
  8005df:	7e e9                	jle    8005ca <_main+0x592>
		tempArr[c] = 'a';
	}

	//cprintf("2\n");

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
  8005e1:	83 ec 08             	sub    $0x8,%esp
  8005e4:	68 00 40 00 00       	push   $0x4000
  8005e9:	68 00 00 00 80       	push   $0x80000000
  8005ee:	e8 59 14 00 00       	call   801a4c <sys_freeMem>
  8005f3:	83 c4 10             	add    $0x10,%esp
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8005f6:	c7 45 e0 00 50 00 00 	movl   $0x5000,-0x20(%ebp)
  8005fd:	eb 26                	jmp    800625 <_main+0x5ed>
	{
		arr[i] = -1 ;
  8005ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800602:	05 40 30 80 00       	add    $0x803040,%eax
  800607:	c6 00 ff             	movb   $0xff,(%eax)
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  80060a:	a1 00 30 80 00       	mov    0x803000,%eax
  80060f:	8a 00                	mov    (%eax),%al
  800611:	88 45 e7             	mov    %al,-0x19(%ebp)
		garbage5 = *ptr2 ;
  800614:	a1 04 30 80 00       	mov    0x803004,%eax
  800619:	8a 00                	mov    (%eax),%al
  80061b:	88 45 e6             	mov    %al,-0x1a(%ebp)

	sys_freeMem(0x80000000, 4*PAGE_SIZE);
	//cprintf("3\n");

	//Check after free either push records up or leave them empty
	for (i = PAGE_SIZE*5 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80061e:	81 45 e0 00 08 00 00 	addl   $0x800,-0x20(%ebp)
  800625:	81 7d e0 ff 9f 00 00 	cmpl   $0x9fff,-0x20(%ebp)
  80062c:	7e d1                	jle    8005ff <_main+0x5c7>
		garbage5 = *ptr2 ;
	}
	//cprintf("4\n");

	//===================
	uint32 finalPageNums[11] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0xeebfd000};
  80062e:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  800634:	bb c0 22 80 00       	mov    $0x8022c0,%ebx
  800639:	ba 0b 00 00 00       	mov    $0xb,%edx
  80063e:	89 c7                	mov    %eax,%edi
  800640:	89 de                	mov    %ebx,%esi
  800642:	89 d1                	mov    %edx,%ecx
  800644:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800646:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  80064d:	e9 97 00 00 00       	jmp    8006e9 <_main+0x6b1>
		{
			uint8 found = 0;
  800652:	c6 45 d7 00          	movb   $0x0,-0x29(%ebp)
			for (int j = 0; j < myEnv->page_WS_max_size; ++j)
  800656:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  80065d:	eb 43                	jmp    8006a2 <_main+0x66a>
			{
				if(finalPageNums[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE))
  80065f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800662:	8b 8c 85 38 ff ff ff 	mov    -0xc8(%ebp,%eax,4),%ecx
  800669:	a1 20 30 80 00       	mov    0x803020,%eax
  80066e:	8b 98 34 03 00 00    	mov    0x334(%eax),%ebx
  800674:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800677:	89 d0                	mov    %edx,%eax
  800679:	01 c0                	add    %eax,%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	c1 e0 02             	shl    $0x2,%eax
  800680:	01 d8                	add    %ebx,%eax
  800682:	8b 00                	mov    (%eax),%eax
  800684:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80068a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800690:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800695:	39 c1                	cmp    %eax,%ecx
  800697:	75 06                	jne    80069f <_main+0x667>
				{
					found = 1;
  800699:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
					break;
  80069d:	eb 12                	jmp    8006b1 <_main+0x679>
	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
		{
			uint8 found = 0;
			for (int j = 0; j < myEnv->page_WS_max_size; ++j)
  80069f:	ff 45 d0             	incl   -0x30(%ebp)
  8006a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a7:	8b 50 74             	mov    0x74(%eax),%edx
  8006aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8006ad:	39 c2                	cmp    %eax,%edx
  8006af:	77 ae                	ja     80065f <_main+0x627>
				{
					found = 1;
					break;
				}
			}
			if (found == 0)
  8006b1:	80 7d d7 00          	cmpb   $0x0,-0x29(%ebp)
  8006b5:	75 2f                	jne    8006e6 <_main+0x6ae>
			{
				cprintf("%x NOT FOUND\n", finalPageNums[i]);
  8006b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006ba:	8b 84 85 38 ff ff ff 	mov    -0xc8(%ebp,%eax,4),%eax
  8006c1:	83 ec 08             	sub    $0x8,%esp
  8006c4:	50                   	push   %eax
  8006c5:	68 3b 22 80 00       	push   $0x80223b
  8006ca:	e8 3c 04 00 00       	call   800b0b <cprintf>
  8006cf:	83 c4 10             	add    $0x10,%esp
				panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006d2:	83 ec 04             	sub    $0x4,%esp
  8006d5:	68 d0 21 80 00       	push   $0x8021d0
  8006da:	6a 77                	push   $0x77
  8006dc:	68 64 21 80 00       	push   $0x802164
  8006e1:	e8 71 01 00 00       	call   800857 <_panic>
	//===================
	uint32 finalPageNums[11] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0xeebfd000};

	//cprintf("Checking PAGE FIFO algorithm after Free and replacement... \n");
	{
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8006e6:	ff 45 d8             	incl   -0x28(%ebp)
  8006e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ee:	8b 50 74             	mov    0x74(%eax),%edx
  8006f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006f4:	39 c2                	cmp    %eax,%edx
  8006f6:	0f 87 56 ff ff ff    	ja     800652 <_main+0x61a>
			}
		}
	}

	{
		if (garbage4 != *ptr) panic("test failed!");
  8006fc:	a1 00 30 80 00       	mov    0x803000,%eax
  800701:	8a 00                	mov    (%eax),%al
  800703:	3a 45 e7             	cmp    -0x19(%ebp),%al
  800706:	74 14                	je     80071c <_main+0x6e4>
  800708:	83 ec 04             	sub    $0x4,%esp
  80070b:	68 49 22 80 00       	push   $0x802249
  800710:	6a 7d                	push   $0x7d
  800712:	68 64 21 80 00       	push   $0x802164
  800717:	e8 3b 01 00 00       	call   800857 <_panic>
		if (garbage5 != *ptr2) panic("test failed!");
  80071c:	a1 04 30 80 00       	mov    0x803004,%eax
  800721:	8a 00                	mov    (%eax),%al
  800723:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  800726:	74 14                	je     80073c <_main+0x704>
  800728:	83 ec 04             	sub    $0x4,%esp
  80072b:	68 49 22 80 00       	push   $0x802249
  800730:	6a 7e                	push   $0x7e
  800732:	68 64 21 80 00       	push   $0x802164
  800737:	e8 1b 01 00 00       	call   800857 <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FIFO 2] is completed successfully.\n");
  80073c:	83 ec 0c             	sub    $0xc,%esp
  80073f:	68 58 22 80 00       	push   $0x802258
  800744:	e8 c2 03 00 00       	call   800b0b <cprintf>
  800749:	83 c4 10             	add    $0x10,%esp
	return;
  80074c:	90                   	nop
}
  80074d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800750:	5b                   	pop    %ebx
  800751:	5e                   	pop    %esi
  800752:	5f                   	pop    %edi
  800753:	5d                   	pop    %ebp
  800754:	c3                   	ret    

00800755 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800755:	55                   	push   %ebp
  800756:	89 e5                	mov    %esp,%ebp
  800758:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80075b:	e8 d6 11 00 00       	call   801936 <sys_getenvindex>
  800760:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800763:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800766:	89 d0                	mov    %edx,%eax
  800768:	01 c0                	add    %eax,%eax
  80076a:	01 d0                	add    %edx,%eax
  80076c:	c1 e0 02             	shl    $0x2,%eax
  80076f:	01 d0                	add    %edx,%eax
  800771:	c1 e0 06             	shl    $0x6,%eax
  800774:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800779:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80077e:	a1 20 30 80 00       	mov    0x803020,%eax
  800783:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800789:	84 c0                	test   %al,%al
  80078b:	74 0f                	je     80079c <libmain+0x47>
		binaryname = myEnv->prog_name;
  80078d:	a1 20 30 80 00       	mov    0x803020,%eax
  800792:	05 f4 02 00 00       	add    $0x2f4,%eax
  800797:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80079c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007a0:	7e 0a                	jle    8007ac <libmain+0x57>
		binaryname = argv[0];
  8007a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a5:	8b 00                	mov    (%eax),%eax
  8007a7:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8007ac:	83 ec 08             	sub    $0x8,%esp
  8007af:	ff 75 0c             	pushl  0xc(%ebp)
  8007b2:	ff 75 08             	pushl  0x8(%ebp)
  8007b5:	e8 7e f8 ff ff       	call   800038 <_main>
  8007ba:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8007bd:	e8 0f 13 00 00       	call   801ad1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8007c2:	83 ec 0c             	sub    $0xc,%esp
  8007c5:	68 04 23 80 00       	push   $0x802304
  8007ca:	e8 3c 03 00 00       	call   800b0b <cprintf>
  8007cf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8007d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d7:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8007dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e2:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8007e8:	83 ec 04             	sub    $0x4,%esp
  8007eb:	52                   	push   %edx
  8007ec:	50                   	push   %eax
  8007ed:	68 2c 23 80 00       	push   $0x80232c
  8007f2:	e8 14 03 00 00       	call   800b0b <cprintf>
  8007f7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ff:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	50                   	push   %eax
  800809:	68 51 23 80 00       	push   $0x802351
  80080e:	e8 f8 02 00 00       	call   800b0b <cprintf>
  800813:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800816:	83 ec 0c             	sub    $0xc,%esp
  800819:	68 04 23 80 00       	push   $0x802304
  80081e:	e8 e8 02 00 00       	call   800b0b <cprintf>
  800823:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800826:	e8 c0 12 00 00       	call   801aeb <sys_enable_interrupt>

	// exit gracefully
	exit();
  80082b:	e8 19 00 00 00       	call   800849 <exit>
}
  800830:	90                   	nop
  800831:	c9                   	leave  
  800832:	c3                   	ret    

00800833 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800833:	55                   	push   %ebp
  800834:	89 e5                	mov    %esp,%ebp
  800836:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800839:	83 ec 0c             	sub    $0xc,%esp
  80083c:	6a 00                	push   $0x0
  80083e:	e8 bf 10 00 00       	call   801902 <sys_env_destroy>
  800843:	83 c4 10             	add    $0x10,%esp
}
  800846:	90                   	nop
  800847:	c9                   	leave  
  800848:	c3                   	ret    

00800849 <exit>:

void
exit(void)
{
  800849:	55                   	push   %ebp
  80084a:	89 e5                	mov    %esp,%ebp
  80084c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80084f:	e8 14 11 00 00       	call   801968 <sys_env_exit>
}
  800854:	90                   	nop
  800855:	c9                   	leave  
  800856:	c3                   	ret    

00800857 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800857:	55                   	push   %ebp
  800858:	89 e5                	mov    %esp,%ebp
  80085a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80085d:	8d 45 10             	lea    0x10(%ebp),%eax
  800860:	83 c0 04             	add    $0x4,%eax
  800863:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800866:	a1 48 f0 80 00       	mov    0x80f048,%eax
  80086b:	85 c0                	test   %eax,%eax
  80086d:	74 16                	je     800885 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80086f:	a1 48 f0 80 00       	mov    0x80f048,%eax
  800874:	83 ec 08             	sub    $0x8,%esp
  800877:	50                   	push   %eax
  800878:	68 68 23 80 00       	push   $0x802368
  80087d:	e8 89 02 00 00       	call   800b0b <cprintf>
  800882:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800885:	a1 08 30 80 00       	mov    0x803008,%eax
  80088a:	ff 75 0c             	pushl  0xc(%ebp)
  80088d:	ff 75 08             	pushl  0x8(%ebp)
  800890:	50                   	push   %eax
  800891:	68 6d 23 80 00       	push   $0x80236d
  800896:	e8 70 02 00 00       	call   800b0b <cprintf>
  80089b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80089e:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a1:	83 ec 08             	sub    $0x8,%esp
  8008a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a7:	50                   	push   %eax
  8008a8:	e8 f3 01 00 00       	call   800aa0 <vcprintf>
  8008ad:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008b0:	83 ec 08             	sub    $0x8,%esp
  8008b3:	6a 00                	push   $0x0
  8008b5:	68 89 23 80 00       	push   $0x802389
  8008ba:	e8 e1 01 00 00       	call   800aa0 <vcprintf>
  8008bf:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008c2:	e8 82 ff ff ff       	call   800849 <exit>

	// should not return here
	while (1) ;
  8008c7:	eb fe                	jmp    8008c7 <_panic+0x70>

008008c9 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008c9:	55                   	push   %ebp
  8008ca:	89 e5                	mov    %esp,%ebp
  8008cc:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d4:	8b 50 74             	mov    0x74(%eax),%edx
  8008d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008da:	39 c2                	cmp    %eax,%edx
  8008dc:	74 14                	je     8008f2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008de:	83 ec 04             	sub    $0x4,%esp
  8008e1:	68 8c 23 80 00       	push   $0x80238c
  8008e6:	6a 26                	push   $0x26
  8008e8:	68 d8 23 80 00       	push   $0x8023d8
  8008ed:	e8 65 ff ff ff       	call   800857 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800900:	e9 c2 00 00 00       	jmp    8009c7 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800905:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800908:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80090f:	8b 45 08             	mov    0x8(%ebp),%eax
  800912:	01 d0                	add    %edx,%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	85 c0                	test   %eax,%eax
  800918:	75 08                	jne    800922 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80091a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80091d:	e9 a2 00 00 00       	jmp    8009c4 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800922:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800929:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800930:	eb 69                	jmp    80099b <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800932:	a1 20 30 80 00       	mov    0x803020,%eax
  800937:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80093d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800940:	89 d0                	mov    %edx,%eax
  800942:	01 c0                	add    %eax,%eax
  800944:	01 d0                	add    %edx,%eax
  800946:	c1 e0 02             	shl    $0x2,%eax
  800949:	01 c8                	add    %ecx,%eax
  80094b:	8a 40 04             	mov    0x4(%eax),%al
  80094e:	84 c0                	test   %al,%al
  800950:	75 46                	jne    800998 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800952:	a1 20 30 80 00       	mov    0x803020,%eax
  800957:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80095d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800960:	89 d0                	mov    %edx,%eax
  800962:	01 c0                	add    %eax,%eax
  800964:	01 d0                	add    %edx,%eax
  800966:	c1 e0 02             	shl    $0x2,%eax
  800969:	01 c8                	add    %ecx,%eax
  80096b:	8b 00                	mov    (%eax),%eax
  80096d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800970:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800973:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800978:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80097a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80097d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800984:	8b 45 08             	mov    0x8(%ebp),%eax
  800987:	01 c8                	add    %ecx,%eax
  800989:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80098b:	39 c2                	cmp    %eax,%edx
  80098d:	75 09                	jne    800998 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80098f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800996:	eb 12                	jmp    8009aa <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800998:	ff 45 e8             	incl   -0x18(%ebp)
  80099b:	a1 20 30 80 00       	mov    0x803020,%eax
  8009a0:	8b 50 74             	mov    0x74(%eax),%edx
  8009a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009a6:	39 c2                	cmp    %eax,%edx
  8009a8:	77 88                	ja     800932 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009ae:	75 14                	jne    8009c4 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8009b0:	83 ec 04             	sub    $0x4,%esp
  8009b3:	68 e4 23 80 00       	push   $0x8023e4
  8009b8:	6a 3a                	push   $0x3a
  8009ba:	68 d8 23 80 00       	push   $0x8023d8
  8009bf:	e8 93 fe ff ff       	call   800857 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009c4:	ff 45 f0             	incl   -0x10(%ebp)
  8009c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009cd:	0f 8c 32 ff ff ff    	jl     800905 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009da:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009e1:	eb 26                	jmp    800a09 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8009e8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8009ee:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f1:	89 d0                	mov    %edx,%eax
  8009f3:	01 c0                	add    %eax,%eax
  8009f5:	01 d0                	add    %edx,%eax
  8009f7:	c1 e0 02             	shl    $0x2,%eax
  8009fa:	01 c8                	add    %ecx,%eax
  8009fc:	8a 40 04             	mov    0x4(%eax),%al
  8009ff:	3c 01                	cmp    $0x1,%al
  800a01:	75 03                	jne    800a06 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a03:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a06:	ff 45 e0             	incl   -0x20(%ebp)
  800a09:	a1 20 30 80 00       	mov    0x803020,%eax
  800a0e:	8b 50 74             	mov    0x74(%eax),%edx
  800a11:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a14:	39 c2                	cmp    %eax,%edx
  800a16:	77 cb                	ja     8009e3 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a1b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a1e:	74 14                	je     800a34 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	68 38 24 80 00       	push   $0x802438
  800a28:	6a 44                	push   $0x44
  800a2a:	68 d8 23 80 00       	push   $0x8023d8
  800a2f:	e8 23 fe ff ff       	call   800857 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a34:	90                   	nop
  800a35:	c9                   	leave  
  800a36:	c3                   	ret    

00800a37 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a37:	55                   	push   %ebp
  800a38:	89 e5                	mov    %esp,%ebp
  800a3a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a40:	8b 00                	mov    (%eax),%eax
  800a42:	8d 48 01             	lea    0x1(%eax),%ecx
  800a45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a48:	89 0a                	mov    %ecx,(%edx)
  800a4a:	8b 55 08             	mov    0x8(%ebp),%edx
  800a4d:	88 d1                	mov    %dl,%cl
  800a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a52:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a59:	8b 00                	mov    (%eax),%eax
  800a5b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a60:	75 2c                	jne    800a8e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a62:	a0 24 30 80 00       	mov    0x803024,%al
  800a67:	0f b6 c0             	movzbl %al,%eax
  800a6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6d:	8b 12                	mov    (%edx),%edx
  800a6f:	89 d1                	mov    %edx,%ecx
  800a71:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a74:	83 c2 08             	add    $0x8,%edx
  800a77:	83 ec 04             	sub    $0x4,%esp
  800a7a:	50                   	push   %eax
  800a7b:	51                   	push   %ecx
  800a7c:	52                   	push   %edx
  800a7d:	e8 3e 0e 00 00       	call   8018c0 <sys_cputs>
  800a82:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a88:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a91:	8b 40 04             	mov    0x4(%eax),%eax
  800a94:	8d 50 01             	lea    0x1(%eax),%edx
  800a97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a9d:	90                   	nop
  800a9e:	c9                   	leave  
  800a9f:	c3                   	ret    

00800aa0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800aa0:	55                   	push   %ebp
  800aa1:	89 e5                	mov    %esp,%ebp
  800aa3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800aa9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ab0:	00 00 00 
	b.cnt = 0;
  800ab3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800aba:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800abd:	ff 75 0c             	pushl  0xc(%ebp)
  800ac0:	ff 75 08             	pushl  0x8(%ebp)
  800ac3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ac9:	50                   	push   %eax
  800aca:	68 37 0a 80 00       	push   $0x800a37
  800acf:	e8 11 02 00 00       	call   800ce5 <vprintfmt>
  800ad4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800ad7:	a0 24 30 80 00       	mov    0x803024,%al
  800adc:	0f b6 c0             	movzbl %al,%eax
  800adf:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800ae5:	83 ec 04             	sub    $0x4,%esp
  800ae8:	50                   	push   %eax
  800ae9:	52                   	push   %edx
  800aea:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800af0:	83 c0 08             	add    $0x8,%eax
  800af3:	50                   	push   %eax
  800af4:	e8 c7 0d 00 00       	call   8018c0 <sys_cputs>
  800af9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800afc:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800b03:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b09:	c9                   	leave  
  800b0a:	c3                   	ret    

00800b0b <cprintf>:

int cprintf(const char *fmt, ...) {
  800b0b:	55                   	push   %ebp
  800b0c:	89 e5                	mov    %esp,%ebp
  800b0e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b11:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800b18:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	83 ec 08             	sub    $0x8,%esp
  800b24:	ff 75 f4             	pushl  -0xc(%ebp)
  800b27:	50                   	push   %eax
  800b28:	e8 73 ff ff ff       	call   800aa0 <vcprintf>
  800b2d:	83 c4 10             	add    $0x10,%esp
  800b30:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b33:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b36:	c9                   	leave  
  800b37:	c3                   	ret    

00800b38 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b38:	55                   	push   %ebp
  800b39:	89 e5                	mov    %esp,%ebp
  800b3b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b3e:	e8 8e 0f 00 00       	call   801ad1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b43:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	83 ec 08             	sub    $0x8,%esp
  800b4f:	ff 75 f4             	pushl  -0xc(%ebp)
  800b52:	50                   	push   %eax
  800b53:	e8 48 ff ff ff       	call   800aa0 <vcprintf>
  800b58:	83 c4 10             	add    $0x10,%esp
  800b5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b5e:	e8 88 0f 00 00       	call   801aeb <sys_enable_interrupt>
	return cnt;
  800b63:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b66:	c9                   	leave  
  800b67:	c3                   	ret    

00800b68 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b68:	55                   	push   %ebp
  800b69:	89 e5                	mov    %esp,%ebp
  800b6b:	53                   	push   %ebx
  800b6c:	83 ec 14             	sub    $0x14,%esp
  800b6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b75:	8b 45 14             	mov    0x14(%ebp),%eax
  800b78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b7b:	8b 45 18             	mov    0x18(%ebp),%eax
  800b7e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b83:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b86:	77 55                	ja     800bdd <printnum+0x75>
  800b88:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b8b:	72 05                	jb     800b92 <printnum+0x2a>
  800b8d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b90:	77 4b                	ja     800bdd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b92:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b95:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b98:	8b 45 18             	mov    0x18(%ebp),%eax
  800b9b:	ba 00 00 00 00       	mov    $0x0,%edx
  800ba0:	52                   	push   %edx
  800ba1:	50                   	push   %eax
  800ba2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba5:	ff 75 f0             	pushl  -0x10(%ebp)
  800ba8:	e8 03 13 00 00       	call   801eb0 <__udivdi3>
  800bad:	83 c4 10             	add    $0x10,%esp
  800bb0:	83 ec 04             	sub    $0x4,%esp
  800bb3:	ff 75 20             	pushl  0x20(%ebp)
  800bb6:	53                   	push   %ebx
  800bb7:	ff 75 18             	pushl  0x18(%ebp)
  800bba:	52                   	push   %edx
  800bbb:	50                   	push   %eax
  800bbc:	ff 75 0c             	pushl  0xc(%ebp)
  800bbf:	ff 75 08             	pushl  0x8(%ebp)
  800bc2:	e8 a1 ff ff ff       	call   800b68 <printnum>
  800bc7:	83 c4 20             	add    $0x20,%esp
  800bca:	eb 1a                	jmp    800be6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800bcc:	83 ec 08             	sub    $0x8,%esp
  800bcf:	ff 75 0c             	pushl  0xc(%ebp)
  800bd2:	ff 75 20             	pushl  0x20(%ebp)
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	ff d0                	call   *%eax
  800bda:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800bdd:	ff 4d 1c             	decl   0x1c(%ebp)
  800be0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800be4:	7f e6                	jg     800bcc <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800be6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800be9:	bb 00 00 00 00       	mov    $0x0,%ebx
  800bee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bf1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bf4:	53                   	push   %ebx
  800bf5:	51                   	push   %ecx
  800bf6:	52                   	push   %edx
  800bf7:	50                   	push   %eax
  800bf8:	e8 c3 13 00 00       	call   801fc0 <__umoddi3>
  800bfd:	83 c4 10             	add    $0x10,%esp
  800c00:	05 b4 26 80 00       	add    $0x8026b4,%eax
  800c05:	8a 00                	mov    (%eax),%al
  800c07:	0f be c0             	movsbl %al,%eax
  800c0a:	83 ec 08             	sub    $0x8,%esp
  800c0d:	ff 75 0c             	pushl  0xc(%ebp)
  800c10:	50                   	push   %eax
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	ff d0                	call   *%eax
  800c16:	83 c4 10             	add    $0x10,%esp
}
  800c19:	90                   	nop
  800c1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c1d:	c9                   	leave  
  800c1e:	c3                   	ret    

00800c1f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c1f:	55                   	push   %ebp
  800c20:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c22:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c26:	7e 1c                	jle    800c44 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	8b 00                	mov    (%eax),%eax
  800c2d:	8d 50 08             	lea    0x8(%eax),%edx
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	89 10                	mov    %edx,(%eax)
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	8b 00                	mov    (%eax),%eax
  800c3a:	83 e8 08             	sub    $0x8,%eax
  800c3d:	8b 50 04             	mov    0x4(%eax),%edx
  800c40:	8b 00                	mov    (%eax),%eax
  800c42:	eb 40                	jmp    800c84 <getuint+0x65>
	else if (lflag)
  800c44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c48:	74 1e                	je     800c68 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	8b 00                	mov    (%eax),%eax
  800c4f:	8d 50 04             	lea    0x4(%eax),%edx
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	89 10                	mov    %edx,(%eax)
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	8b 00                	mov    (%eax),%eax
  800c5c:	83 e8 04             	sub    $0x4,%eax
  800c5f:	8b 00                	mov    (%eax),%eax
  800c61:	ba 00 00 00 00       	mov    $0x0,%edx
  800c66:	eb 1c                	jmp    800c84 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8b 00                	mov    (%eax),%eax
  800c6d:	8d 50 04             	lea    0x4(%eax),%edx
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	89 10                	mov    %edx,(%eax)
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	8b 00                	mov    (%eax),%eax
  800c7a:	83 e8 04             	sub    $0x4,%eax
  800c7d:	8b 00                	mov    (%eax),%eax
  800c7f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c84:	5d                   	pop    %ebp
  800c85:	c3                   	ret    

00800c86 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c86:	55                   	push   %ebp
  800c87:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c89:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c8d:	7e 1c                	jle    800cab <getint+0x25>
		return va_arg(*ap, long long);
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	8b 00                	mov    (%eax),%eax
  800c94:	8d 50 08             	lea    0x8(%eax),%edx
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	89 10                	mov    %edx,(%eax)
  800c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9f:	8b 00                	mov    (%eax),%eax
  800ca1:	83 e8 08             	sub    $0x8,%eax
  800ca4:	8b 50 04             	mov    0x4(%eax),%edx
  800ca7:	8b 00                	mov    (%eax),%eax
  800ca9:	eb 38                	jmp    800ce3 <getint+0x5d>
	else if (lflag)
  800cab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800caf:	74 1a                	je     800ccb <getint+0x45>
		return va_arg(*ap, long);
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	8b 00                	mov    (%eax),%eax
  800cb6:	8d 50 04             	lea    0x4(%eax),%edx
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	89 10                	mov    %edx,(%eax)
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	8b 00                	mov    (%eax),%eax
  800cc3:	83 e8 04             	sub    $0x4,%eax
  800cc6:	8b 00                	mov    (%eax),%eax
  800cc8:	99                   	cltd   
  800cc9:	eb 18                	jmp    800ce3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8b 00                	mov    (%eax),%eax
  800cd0:	8d 50 04             	lea    0x4(%eax),%edx
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	89 10                	mov    %edx,(%eax)
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8b 00                	mov    (%eax),%eax
  800cdd:	83 e8 04             	sub    $0x4,%eax
  800ce0:	8b 00                	mov    (%eax),%eax
  800ce2:	99                   	cltd   
}
  800ce3:	5d                   	pop    %ebp
  800ce4:	c3                   	ret    

00800ce5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ce5:	55                   	push   %ebp
  800ce6:	89 e5                	mov    %esp,%ebp
  800ce8:	56                   	push   %esi
  800ce9:	53                   	push   %ebx
  800cea:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ced:	eb 17                	jmp    800d06 <vprintfmt+0x21>
			if (ch == '\0')
  800cef:	85 db                	test   %ebx,%ebx
  800cf1:	0f 84 af 03 00 00    	je     8010a6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800cf7:	83 ec 08             	sub    $0x8,%esp
  800cfa:	ff 75 0c             	pushl  0xc(%ebp)
  800cfd:	53                   	push   %ebx
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	ff d0                	call   *%eax
  800d03:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d06:	8b 45 10             	mov    0x10(%ebp),%eax
  800d09:	8d 50 01             	lea    0x1(%eax),%edx
  800d0c:	89 55 10             	mov    %edx,0x10(%ebp)
  800d0f:	8a 00                	mov    (%eax),%al
  800d11:	0f b6 d8             	movzbl %al,%ebx
  800d14:	83 fb 25             	cmp    $0x25,%ebx
  800d17:	75 d6                	jne    800cef <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d19:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d1d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d24:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d2b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d32:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d39:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3c:	8d 50 01             	lea    0x1(%eax),%edx
  800d3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	0f b6 d8             	movzbl %al,%ebx
  800d47:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d4a:	83 f8 55             	cmp    $0x55,%eax
  800d4d:	0f 87 2b 03 00 00    	ja     80107e <vprintfmt+0x399>
  800d53:	8b 04 85 d8 26 80 00 	mov    0x8026d8(,%eax,4),%eax
  800d5a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d5c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d60:	eb d7                	jmp    800d39 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d62:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d66:	eb d1                	jmp    800d39 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d68:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d72:	89 d0                	mov    %edx,%eax
  800d74:	c1 e0 02             	shl    $0x2,%eax
  800d77:	01 d0                	add    %edx,%eax
  800d79:	01 c0                	add    %eax,%eax
  800d7b:	01 d8                	add    %ebx,%eax
  800d7d:	83 e8 30             	sub    $0x30,%eax
  800d80:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d83:	8b 45 10             	mov    0x10(%ebp),%eax
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d8b:	83 fb 2f             	cmp    $0x2f,%ebx
  800d8e:	7e 3e                	jle    800dce <vprintfmt+0xe9>
  800d90:	83 fb 39             	cmp    $0x39,%ebx
  800d93:	7f 39                	jg     800dce <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d95:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d98:	eb d5                	jmp    800d6f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9d:	83 c0 04             	add    $0x4,%eax
  800da0:	89 45 14             	mov    %eax,0x14(%ebp)
  800da3:	8b 45 14             	mov    0x14(%ebp),%eax
  800da6:	83 e8 04             	sub    $0x4,%eax
  800da9:	8b 00                	mov    (%eax),%eax
  800dab:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800dae:	eb 1f                	jmp    800dcf <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800db0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db4:	79 83                	jns    800d39 <vprintfmt+0x54>
				width = 0;
  800db6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800dbd:	e9 77 ff ff ff       	jmp    800d39 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800dc2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800dc9:	e9 6b ff ff ff       	jmp    800d39 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800dce:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800dcf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd3:	0f 89 60 ff ff ff    	jns    800d39 <vprintfmt+0x54>
				width = precision, precision = -1;
  800dd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ddc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ddf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800de6:	e9 4e ff ff ff       	jmp    800d39 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800deb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800dee:	e9 46 ff ff ff       	jmp    800d39 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800df3:	8b 45 14             	mov    0x14(%ebp),%eax
  800df6:	83 c0 04             	add    $0x4,%eax
  800df9:	89 45 14             	mov    %eax,0x14(%ebp)
  800dfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800dff:	83 e8 04             	sub    $0x4,%eax
  800e02:	8b 00                	mov    (%eax),%eax
  800e04:	83 ec 08             	sub    $0x8,%esp
  800e07:	ff 75 0c             	pushl  0xc(%ebp)
  800e0a:	50                   	push   %eax
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	ff d0                	call   *%eax
  800e10:	83 c4 10             	add    $0x10,%esp
			break;
  800e13:	e9 89 02 00 00       	jmp    8010a1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e18:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1b:	83 c0 04             	add    $0x4,%eax
  800e1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e21:	8b 45 14             	mov    0x14(%ebp),%eax
  800e24:	83 e8 04             	sub    $0x4,%eax
  800e27:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e29:	85 db                	test   %ebx,%ebx
  800e2b:	79 02                	jns    800e2f <vprintfmt+0x14a>
				err = -err;
  800e2d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e2f:	83 fb 64             	cmp    $0x64,%ebx
  800e32:	7f 0b                	jg     800e3f <vprintfmt+0x15a>
  800e34:	8b 34 9d 20 25 80 00 	mov    0x802520(,%ebx,4),%esi
  800e3b:	85 f6                	test   %esi,%esi
  800e3d:	75 19                	jne    800e58 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e3f:	53                   	push   %ebx
  800e40:	68 c5 26 80 00       	push   $0x8026c5
  800e45:	ff 75 0c             	pushl  0xc(%ebp)
  800e48:	ff 75 08             	pushl  0x8(%ebp)
  800e4b:	e8 5e 02 00 00       	call   8010ae <printfmt>
  800e50:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e53:	e9 49 02 00 00       	jmp    8010a1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e58:	56                   	push   %esi
  800e59:	68 ce 26 80 00       	push   $0x8026ce
  800e5e:	ff 75 0c             	pushl  0xc(%ebp)
  800e61:	ff 75 08             	pushl  0x8(%ebp)
  800e64:	e8 45 02 00 00       	call   8010ae <printfmt>
  800e69:	83 c4 10             	add    $0x10,%esp
			break;
  800e6c:	e9 30 02 00 00       	jmp    8010a1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e71:	8b 45 14             	mov    0x14(%ebp),%eax
  800e74:	83 c0 04             	add    $0x4,%eax
  800e77:	89 45 14             	mov    %eax,0x14(%ebp)
  800e7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7d:	83 e8 04             	sub    $0x4,%eax
  800e80:	8b 30                	mov    (%eax),%esi
  800e82:	85 f6                	test   %esi,%esi
  800e84:	75 05                	jne    800e8b <vprintfmt+0x1a6>
				p = "(null)";
  800e86:	be d1 26 80 00       	mov    $0x8026d1,%esi
			if (width > 0 && padc != '-')
  800e8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e8f:	7e 6d                	jle    800efe <vprintfmt+0x219>
  800e91:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e95:	74 67                	je     800efe <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	50                   	push   %eax
  800e9e:	56                   	push   %esi
  800e9f:	e8 0c 03 00 00       	call   8011b0 <strnlen>
  800ea4:	83 c4 10             	add    $0x10,%esp
  800ea7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800eaa:	eb 16                	jmp    800ec2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800eac:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800eb0:	83 ec 08             	sub    $0x8,%esp
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	50                   	push   %eax
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	ff d0                	call   *%eax
  800ebc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ebf:	ff 4d e4             	decl   -0x1c(%ebp)
  800ec2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ec6:	7f e4                	jg     800eac <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ec8:	eb 34                	jmp    800efe <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800eca:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ece:	74 1c                	je     800eec <vprintfmt+0x207>
  800ed0:	83 fb 1f             	cmp    $0x1f,%ebx
  800ed3:	7e 05                	jle    800eda <vprintfmt+0x1f5>
  800ed5:	83 fb 7e             	cmp    $0x7e,%ebx
  800ed8:	7e 12                	jle    800eec <vprintfmt+0x207>
					putch('?', putdat);
  800eda:	83 ec 08             	sub    $0x8,%esp
  800edd:	ff 75 0c             	pushl  0xc(%ebp)
  800ee0:	6a 3f                	push   $0x3f
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	ff d0                	call   *%eax
  800ee7:	83 c4 10             	add    $0x10,%esp
  800eea:	eb 0f                	jmp    800efb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800eec:	83 ec 08             	sub    $0x8,%esp
  800eef:	ff 75 0c             	pushl  0xc(%ebp)
  800ef2:	53                   	push   %ebx
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	ff d0                	call   *%eax
  800ef8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800efb:	ff 4d e4             	decl   -0x1c(%ebp)
  800efe:	89 f0                	mov    %esi,%eax
  800f00:	8d 70 01             	lea    0x1(%eax),%esi
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	0f be d8             	movsbl %al,%ebx
  800f08:	85 db                	test   %ebx,%ebx
  800f0a:	74 24                	je     800f30 <vprintfmt+0x24b>
  800f0c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f10:	78 b8                	js     800eca <vprintfmt+0x1e5>
  800f12:	ff 4d e0             	decl   -0x20(%ebp)
  800f15:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f19:	79 af                	jns    800eca <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f1b:	eb 13                	jmp    800f30 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f1d:	83 ec 08             	sub    $0x8,%esp
  800f20:	ff 75 0c             	pushl  0xc(%ebp)
  800f23:	6a 20                	push   $0x20
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	ff d0                	call   *%eax
  800f2a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f2d:	ff 4d e4             	decl   -0x1c(%ebp)
  800f30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f34:	7f e7                	jg     800f1d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f36:	e9 66 01 00 00       	jmp    8010a1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f3b:	83 ec 08             	sub    $0x8,%esp
  800f3e:	ff 75 e8             	pushl  -0x18(%ebp)
  800f41:	8d 45 14             	lea    0x14(%ebp),%eax
  800f44:	50                   	push   %eax
  800f45:	e8 3c fd ff ff       	call   800c86 <getint>
  800f4a:	83 c4 10             	add    $0x10,%esp
  800f4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f50:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f56:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f59:	85 d2                	test   %edx,%edx
  800f5b:	79 23                	jns    800f80 <vprintfmt+0x29b>
				putch('-', putdat);
  800f5d:	83 ec 08             	sub    $0x8,%esp
  800f60:	ff 75 0c             	pushl  0xc(%ebp)
  800f63:	6a 2d                	push   $0x2d
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	ff d0                	call   *%eax
  800f6a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f73:	f7 d8                	neg    %eax
  800f75:	83 d2 00             	adc    $0x0,%edx
  800f78:	f7 da                	neg    %edx
  800f7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f80:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f87:	e9 bc 00 00 00       	jmp    801048 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f8c:	83 ec 08             	sub    $0x8,%esp
  800f8f:	ff 75 e8             	pushl  -0x18(%ebp)
  800f92:	8d 45 14             	lea    0x14(%ebp),%eax
  800f95:	50                   	push   %eax
  800f96:	e8 84 fc ff ff       	call   800c1f <getuint>
  800f9b:	83 c4 10             	add    $0x10,%esp
  800f9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800fa4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fab:	e9 98 00 00 00       	jmp    801048 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800fb0:	83 ec 08             	sub    $0x8,%esp
  800fb3:	ff 75 0c             	pushl  0xc(%ebp)
  800fb6:	6a 58                	push   $0x58
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	ff d0                	call   *%eax
  800fbd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800fc0:	83 ec 08             	sub    $0x8,%esp
  800fc3:	ff 75 0c             	pushl  0xc(%ebp)
  800fc6:	6a 58                	push   $0x58
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	ff d0                	call   *%eax
  800fcd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800fd0:	83 ec 08             	sub    $0x8,%esp
  800fd3:	ff 75 0c             	pushl  0xc(%ebp)
  800fd6:	6a 58                	push   $0x58
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	ff d0                	call   *%eax
  800fdd:	83 c4 10             	add    $0x10,%esp
			break;
  800fe0:	e9 bc 00 00 00       	jmp    8010a1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800fe5:	83 ec 08             	sub    $0x8,%esp
  800fe8:	ff 75 0c             	pushl  0xc(%ebp)
  800feb:	6a 30                	push   $0x30
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	ff d0                	call   *%eax
  800ff2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ff5:	83 ec 08             	sub    $0x8,%esp
  800ff8:	ff 75 0c             	pushl  0xc(%ebp)
  800ffb:	6a 78                	push   $0x78
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	ff d0                	call   *%eax
  801002:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801005:	8b 45 14             	mov    0x14(%ebp),%eax
  801008:	83 c0 04             	add    $0x4,%eax
  80100b:	89 45 14             	mov    %eax,0x14(%ebp)
  80100e:	8b 45 14             	mov    0x14(%ebp),%eax
  801011:	83 e8 04             	sub    $0x4,%eax
  801014:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801016:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801019:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801020:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801027:	eb 1f                	jmp    801048 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801029:	83 ec 08             	sub    $0x8,%esp
  80102c:	ff 75 e8             	pushl  -0x18(%ebp)
  80102f:	8d 45 14             	lea    0x14(%ebp),%eax
  801032:	50                   	push   %eax
  801033:	e8 e7 fb ff ff       	call   800c1f <getuint>
  801038:	83 c4 10             	add    $0x10,%esp
  80103b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801041:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801048:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80104c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80104f:	83 ec 04             	sub    $0x4,%esp
  801052:	52                   	push   %edx
  801053:	ff 75 e4             	pushl  -0x1c(%ebp)
  801056:	50                   	push   %eax
  801057:	ff 75 f4             	pushl  -0xc(%ebp)
  80105a:	ff 75 f0             	pushl  -0x10(%ebp)
  80105d:	ff 75 0c             	pushl  0xc(%ebp)
  801060:	ff 75 08             	pushl  0x8(%ebp)
  801063:	e8 00 fb ff ff       	call   800b68 <printnum>
  801068:	83 c4 20             	add    $0x20,%esp
			break;
  80106b:	eb 34                	jmp    8010a1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80106d:	83 ec 08             	sub    $0x8,%esp
  801070:	ff 75 0c             	pushl  0xc(%ebp)
  801073:	53                   	push   %ebx
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	ff d0                	call   *%eax
  801079:	83 c4 10             	add    $0x10,%esp
			break;
  80107c:	eb 23                	jmp    8010a1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80107e:	83 ec 08             	sub    $0x8,%esp
  801081:	ff 75 0c             	pushl  0xc(%ebp)
  801084:	6a 25                	push   $0x25
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	ff d0                	call   *%eax
  80108b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80108e:	ff 4d 10             	decl   0x10(%ebp)
  801091:	eb 03                	jmp    801096 <vprintfmt+0x3b1>
  801093:	ff 4d 10             	decl   0x10(%ebp)
  801096:	8b 45 10             	mov    0x10(%ebp),%eax
  801099:	48                   	dec    %eax
  80109a:	8a 00                	mov    (%eax),%al
  80109c:	3c 25                	cmp    $0x25,%al
  80109e:	75 f3                	jne    801093 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8010a0:	90                   	nop
		}
	}
  8010a1:	e9 47 fc ff ff       	jmp    800ced <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8010a6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8010a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010aa:	5b                   	pop    %ebx
  8010ab:	5e                   	pop    %esi
  8010ac:	5d                   	pop    %ebp
  8010ad:	c3                   	ret    

008010ae <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8010ae:	55                   	push   %ebp
  8010af:	89 e5                	mov    %esp,%ebp
  8010b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8010b4:	8d 45 10             	lea    0x10(%ebp),%eax
  8010b7:	83 c0 04             	add    $0x4,%eax
  8010ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8010bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8010c3:	50                   	push   %eax
  8010c4:	ff 75 0c             	pushl  0xc(%ebp)
  8010c7:	ff 75 08             	pushl  0x8(%ebp)
  8010ca:	e8 16 fc ff ff       	call   800ce5 <vprintfmt>
  8010cf:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8010d2:	90                   	nop
  8010d3:	c9                   	leave  
  8010d4:	c3                   	ret    

008010d5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8010d5:	55                   	push   %ebp
  8010d6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8010d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010db:	8b 40 08             	mov    0x8(%eax),%eax
  8010de:	8d 50 01             	lea    0x1(%eax),%edx
  8010e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8010e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ea:	8b 10                	mov    (%eax),%edx
  8010ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ef:	8b 40 04             	mov    0x4(%eax),%eax
  8010f2:	39 c2                	cmp    %eax,%edx
  8010f4:	73 12                	jae    801108 <sprintputch+0x33>
		*b->buf++ = ch;
  8010f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f9:	8b 00                	mov    (%eax),%eax
  8010fb:	8d 48 01             	lea    0x1(%eax),%ecx
  8010fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801101:	89 0a                	mov    %ecx,(%edx)
  801103:	8b 55 08             	mov    0x8(%ebp),%edx
  801106:	88 10                	mov    %dl,(%eax)
}
  801108:	90                   	nop
  801109:	5d                   	pop    %ebp
  80110a:	c3                   	ret    

0080110b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
  80110e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801117:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	01 d0                	add    %edx,%eax
  801122:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801125:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80112c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801130:	74 06                	je     801138 <vsnprintf+0x2d>
  801132:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801136:	7f 07                	jg     80113f <vsnprintf+0x34>
		return -E_INVAL;
  801138:	b8 03 00 00 00       	mov    $0x3,%eax
  80113d:	eb 20                	jmp    80115f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80113f:	ff 75 14             	pushl  0x14(%ebp)
  801142:	ff 75 10             	pushl  0x10(%ebp)
  801145:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801148:	50                   	push   %eax
  801149:	68 d5 10 80 00       	push   $0x8010d5
  80114e:	e8 92 fb ff ff       	call   800ce5 <vprintfmt>
  801153:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801156:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801159:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80115c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
  801164:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801167:	8d 45 10             	lea    0x10(%ebp),%eax
  80116a:	83 c0 04             	add    $0x4,%eax
  80116d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801170:	8b 45 10             	mov    0x10(%ebp),%eax
  801173:	ff 75 f4             	pushl  -0xc(%ebp)
  801176:	50                   	push   %eax
  801177:	ff 75 0c             	pushl  0xc(%ebp)
  80117a:	ff 75 08             	pushl  0x8(%ebp)
  80117d:	e8 89 ff ff ff       	call   80110b <vsnprintf>
  801182:	83 c4 10             	add    $0x10,%esp
  801185:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801188:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80118b:	c9                   	leave  
  80118c:	c3                   	ret    

0080118d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80118d:	55                   	push   %ebp
  80118e:	89 e5                	mov    %esp,%ebp
  801190:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801193:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80119a:	eb 06                	jmp    8011a2 <strlen+0x15>
		n++;
  80119c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80119f:	ff 45 08             	incl   0x8(%ebp)
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	84 c0                	test   %al,%al
  8011a9:	75 f1                	jne    80119c <strlen+0xf>
		n++;
	return n;
  8011ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
  8011b3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011bd:	eb 09                	jmp    8011c8 <strnlen+0x18>
		n++;
  8011bf:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011c2:	ff 45 08             	incl   0x8(%ebp)
  8011c5:	ff 4d 0c             	decl   0xc(%ebp)
  8011c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011cc:	74 09                	je     8011d7 <strnlen+0x27>
  8011ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d1:	8a 00                	mov    (%eax),%al
  8011d3:	84 c0                	test   %al,%al
  8011d5:	75 e8                	jne    8011bf <strnlen+0xf>
		n++;
	return n;
  8011d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011da:	c9                   	leave  
  8011db:	c3                   	ret    

008011dc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8011dc:	55                   	push   %ebp
  8011dd:	89 e5                	mov    %esp,%ebp
  8011df:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8011e8:	90                   	nop
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8d 50 01             	lea    0x1(%eax),%edx
  8011ef:	89 55 08             	mov    %edx,0x8(%ebp)
  8011f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011f8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011fb:	8a 12                	mov    (%edx),%dl
  8011fd:	88 10                	mov    %dl,(%eax)
  8011ff:	8a 00                	mov    (%eax),%al
  801201:	84 c0                	test   %al,%al
  801203:	75 e4                	jne    8011e9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801205:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801208:	c9                   	leave  
  801209:	c3                   	ret    

0080120a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80120a:	55                   	push   %ebp
  80120b:	89 e5                	mov    %esp,%ebp
  80120d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801216:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80121d:	eb 1f                	jmp    80123e <strncpy+0x34>
		*dst++ = *src;
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	8d 50 01             	lea    0x1(%eax),%edx
  801225:	89 55 08             	mov    %edx,0x8(%ebp)
  801228:	8b 55 0c             	mov    0xc(%ebp),%edx
  80122b:	8a 12                	mov    (%edx),%dl
  80122d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80122f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801232:	8a 00                	mov    (%eax),%al
  801234:	84 c0                	test   %al,%al
  801236:	74 03                	je     80123b <strncpy+0x31>
			src++;
  801238:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80123b:	ff 45 fc             	incl   -0x4(%ebp)
  80123e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801241:	3b 45 10             	cmp    0x10(%ebp),%eax
  801244:	72 d9                	jb     80121f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801246:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801249:	c9                   	leave  
  80124a:	c3                   	ret    

0080124b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80124b:	55                   	push   %ebp
  80124c:	89 e5                	mov    %esp,%ebp
  80124e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801251:	8b 45 08             	mov    0x8(%ebp),%eax
  801254:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801257:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80125b:	74 30                	je     80128d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80125d:	eb 16                	jmp    801275 <strlcpy+0x2a>
			*dst++ = *src++;
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	8d 50 01             	lea    0x1(%eax),%edx
  801265:	89 55 08             	mov    %edx,0x8(%ebp)
  801268:	8b 55 0c             	mov    0xc(%ebp),%edx
  80126b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80126e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801271:	8a 12                	mov    (%edx),%dl
  801273:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801275:	ff 4d 10             	decl   0x10(%ebp)
  801278:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80127c:	74 09                	je     801287 <strlcpy+0x3c>
  80127e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	84 c0                	test   %al,%al
  801285:	75 d8                	jne    80125f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801287:	8b 45 08             	mov    0x8(%ebp),%eax
  80128a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80128d:	8b 55 08             	mov    0x8(%ebp),%edx
  801290:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801293:	29 c2                	sub    %eax,%edx
  801295:	89 d0                	mov    %edx,%eax
}
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80129c:	eb 06                	jmp    8012a4 <strcmp+0xb>
		p++, q++;
  80129e:	ff 45 08             	incl   0x8(%ebp)
  8012a1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	8a 00                	mov    (%eax),%al
  8012a9:	84 c0                	test   %al,%al
  8012ab:	74 0e                	je     8012bb <strcmp+0x22>
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	8a 10                	mov    (%eax),%dl
  8012b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	38 c2                	cmp    %al,%dl
  8012b9:	74 e3                	je     80129e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	8a 00                	mov    (%eax),%al
  8012c0:	0f b6 d0             	movzbl %al,%edx
  8012c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c6:	8a 00                	mov    (%eax),%al
  8012c8:	0f b6 c0             	movzbl %al,%eax
  8012cb:	29 c2                	sub    %eax,%edx
  8012cd:	89 d0                	mov    %edx,%eax
}
  8012cf:	5d                   	pop    %ebp
  8012d0:	c3                   	ret    

008012d1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8012d1:	55                   	push   %ebp
  8012d2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8012d4:	eb 09                	jmp    8012df <strncmp+0xe>
		n--, p++, q++;
  8012d6:	ff 4d 10             	decl   0x10(%ebp)
  8012d9:	ff 45 08             	incl   0x8(%ebp)
  8012dc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8012df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e3:	74 17                	je     8012fc <strncmp+0x2b>
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	84 c0                	test   %al,%al
  8012ec:	74 0e                	je     8012fc <strncmp+0x2b>
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	8a 10                	mov    (%eax),%dl
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	38 c2                	cmp    %al,%dl
  8012fa:	74 da                	je     8012d6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8012fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801300:	75 07                	jne    801309 <strncmp+0x38>
		return 0;
  801302:	b8 00 00 00 00       	mov    $0x0,%eax
  801307:	eb 14                	jmp    80131d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	8a 00                	mov    (%eax),%al
  80130e:	0f b6 d0             	movzbl %al,%edx
  801311:	8b 45 0c             	mov    0xc(%ebp),%eax
  801314:	8a 00                	mov    (%eax),%al
  801316:	0f b6 c0             	movzbl %al,%eax
  801319:	29 c2                	sub    %eax,%edx
  80131b:	89 d0                	mov    %edx,%eax
}
  80131d:	5d                   	pop    %ebp
  80131e:	c3                   	ret    

0080131f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
  801322:	83 ec 04             	sub    $0x4,%esp
  801325:	8b 45 0c             	mov    0xc(%ebp),%eax
  801328:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80132b:	eb 12                	jmp    80133f <strchr+0x20>
		if (*s == c)
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801335:	75 05                	jne    80133c <strchr+0x1d>
			return (char *) s;
  801337:	8b 45 08             	mov    0x8(%ebp),%eax
  80133a:	eb 11                	jmp    80134d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80133c:	ff 45 08             	incl   0x8(%ebp)
  80133f:	8b 45 08             	mov    0x8(%ebp),%eax
  801342:	8a 00                	mov    (%eax),%al
  801344:	84 c0                	test   %al,%al
  801346:	75 e5                	jne    80132d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801348:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80134d:	c9                   	leave  
  80134e:	c3                   	ret    

0080134f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80134f:	55                   	push   %ebp
  801350:	89 e5                	mov    %esp,%ebp
  801352:	83 ec 04             	sub    $0x4,%esp
  801355:	8b 45 0c             	mov    0xc(%ebp),%eax
  801358:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80135b:	eb 0d                	jmp    80136a <strfind+0x1b>
		if (*s == c)
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8a 00                	mov    (%eax),%al
  801362:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801365:	74 0e                	je     801375 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801367:	ff 45 08             	incl   0x8(%ebp)
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	8a 00                	mov    (%eax),%al
  80136f:	84 c0                	test   %al,%al
  801371:	75 ea                	jne    80135d <strfind+0xe>
  801373:	eb 01                	jmp    801376 <strfind+0x27>
		if (*s == c)
			break;
  801375:	90                   	nop
	return (char *) s;
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
  80137e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801387:	8b 45 10             	mov    0x10(%ebp),%eax
  80138a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80138d:	eb 0e                	jmp    80139d <memset+0x22>
		*p++ = c;
  80138f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801392:	8d 50 01             	lea    0x1(%eax),%edx
  801395:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80139d:	ff 4d f8             	decl   -0x8(%ebp)
  8013a0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8013a4:	79 e9                	jns    80138f <memset+0x14>
		*p++ = c;

	return v;
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
  8013ae:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8013b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8013bd:	eb 16                	jmp    8013d5 <memcpy+0x2a>
		*d++ = *s++;
  8013bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c2:	8d 50 01             	lea    0x1(%eax),%edx
  8013c5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013cb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013ce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013d1:	8a 12                	mov    (%edx),%dl
  8013d3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8013d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013db:	89 55 10             	mov    %edx,0x10(%ebp)
  8013de:	85 c0                	test   %eax,%eax
  8013e0:	75 dd                	jne    8013bf <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013e5:	c9                   	leave  
  8013e6:	c3                   	ret    

008013e7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8013e7:	55                   	push   %ebp
  8013e8:	89 e5                	mov    %esp,%ebp
  8013ea:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8013ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8013f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013fc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013ff:	73 50                	jae    801451 <memmove+0x6a>
  801401:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801404:	8b 45 10             	mov    0x10(%ebp),%eax
  801407:	01 d0                	add    %edx,%eax
  801409:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80140c:	76 43                	jbe    801451 <memmove+0x6a>
		s += n;
  80140e:	8b 45 10             	mov    0x10(%ebp),%eax
  801411:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801414:	8b 45 10             	mov    0x10(%ebp),%eax
  801417:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80141a:	eb 10                	jmp    80142c <memmove+0x45>
			*--d = *--s;
  80141c:	ff 4d f8             	decl   -0x8(%ebp)
  80141f:	ff 4d fc             	decl   -0x4(%ebp)
  801422:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801425:	8a 10                	mov    (%eax),%dl
  801427:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80142a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80142c:	8b 45 10             	mov    0x10(%ebp),%eax
  80142f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801432:	89 55 10             	mov    %edx,0x10(%ebp)
  801435:	85 c0                	test   %eax,%eax
  801437:	75 e3                	jne    80141c <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801439:	eb 23                	jmp    80145e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80143b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143e:	8d 50 01             	lea    0x1(%eax),%edx
  801441:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801444:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801447:	8d 4a 01             	lea    0x1(%edx),%ecx
  80144a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80144d:	8a 12                	mov    (%edx),%dl
  80144f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801451:	8b 45 10             	mov    0x10(%ebp),%eax
  801454:	8d 50 ff             	lea    -0x1(%eax),%edx
  801457:	89 55 10             	mov    %edx,0x10(%ebp)
  80145a:	85 c0                	test   %eax,%eax
  80145c:	75 dd                	jne    80143b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
  801466:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
  80146c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80146f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801472:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801475:	eb 2a                	jmp    8014a1 <memcmp+0x3e>
		if (*s1 != *s2)
  801477:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80147a:	8a 10                	mov    (%eax),%dl
  80147c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147f:	8a 00                	mov    (%eax),%al
  801481:	38 c2                	cmp    %al,%dl
  801483:	74 16                	je     80149b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801485:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801488:	8a 00                	mov    (%eax),%al
  80148a:	0f b6 d0             	movzbl %al,%edx
  80148d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801490:	8a 00                	mov    (%eax),%al
  801492:	0f b6 c0             	movzbl %al,%eax
  801495:	29 c2                	sub    %eax,%edx
  801497:	89 d0                	mov    %edx,%eax
  801499:	eb 18                	jmp    8014b3 <memcmp+0x50>
		s1++, s2++;
  80149b:	ff 45 fc             	incl   -0x4(%ebp)
  80149e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8014a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014a7:	89 55 10             	mov    %edx,0x10(%ebp)
  8014aa:	85 c0                	test   %eax,%eax
  8014ac:	75 c9                	jne    801477 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8014ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
  8014b8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8014bb:	8b 55 08             	mov    0x8(%ebp),%edx
  8014be:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c1:	01 d0                	add    %edx,%eax
  8014c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8014c6:	eb 15                	jmp    8014dd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	8a 00                	mov    (%eax),%al
  8014cd:	0f b6 d0             	movzbl %al,%edx
  8014d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d3:	0f b6 c0             	movzbl %al,%eax
  8014d6:	39 c2                	cmp    %eax,%edx
  8014d8:	74 0d                	je     8014e7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8014da:	ff 45 08             	incl   0x8(%ebp)
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014e3:	72 e3                	jb     8014c8 <memfind+0x13>
  8014e5:	eb 01                	jmp    8014e8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8014e7:	90                   	nop
	return (void *) s;
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
  8014f0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8014f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8014fa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801501:	eb 03                	jmp    801506 <strtol+0x19>
		s++;
  801503:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801506:	8b 45 08             	mov    0x8(%ebp),%eax
  801509:	8a 00                	mov    (%eax),%al
  80150b:	3c 20                	cmp    $0x20,%al
  80150d:	74 f4                	je     801503 <strtol+0x16>
  80150f:	8b 45 08             	mov    0x8(%ebp),%eax
  801512:	8a 00                	mov    (%eax),%al
  801514:	3c 09                	cmp    $0x9,%al
  801516:	74 eb                	je     801503 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	3c 2b                	cmp    $0x2b,%al
  80151f:	75 05                	jne    801526 <strtol+0x39>
		s++;
  801521:	ff 45 08             	incl   0x8(%ebp)
  801524:	eb 13                	jmp    801539 <strtol+0x4c>
	else if (*s == '-')
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	3c 2d                	cmp    $0x2d,%al
  80152d:	75 0a                	jne    801539 <strtol+0x4c>
		s++, neg = 1;
  80152f:	ff 45 08             	incl   0x8(%ebp)
  801532:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801539:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80153d:	74 06                	je     801545 <strtol+0x58>
  80153f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801543:	75 20                	jne    801565 <strtol+0x78>
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	8a 00                	mov    (%eax),%al
  80154a:	3c 30                	cmp    $0x30,%al
  80154c:	75 17                	jne    801565 <strtol+0x78>
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	40                   	inc    %eax
  801552:	8a 00                	mov    (%eax),%al
  801554:	3c 78                	cmp    $0x78,%al
  801556:	75 0d                	jne    801565 <strtol+0x78>
		s += 2, base = 16;
  801558:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80155c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801563:	eb 28                	jmp    80158d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801565:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801569:	75 15                	jne    801580 <strtol+0x93>
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	3c 30                	cmp    $0x30,%al
  801572:	75 0c                	jne    801580 <strtol+0x93>
		s++, base = 8;
  801574:	ff 45 08             	incl   0x8(%ebp)
  801577:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80157e:	eb 0d                	jmp    80158d <strtol+0xa0>
	else if (base == 0)
  801580:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801584:	75 07                	jne    80158d <strtol+0xa0>
		base = 10;
  801586:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	8a 00                	mov    (%eax),%al
  801592:	3c 2f                	cmp    $0x2f,%al
  801594:	7e 19                	jle    8015af <strtol+0xc2>
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	8a 00                	mov    (%eax),%al
  80159b:	3c 39                	cmp    $0x39,%al
  80159d:	7f 10                	jg     8015af <strtol+0xc2>
			dig = *s - '0';
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	8a 00                	mov    (%eax),%al
  8015a4:	0f be c0             	movsbl %al,%eax
  8015a7:	83 e8 30             	sub    $0x30,%eax
  8015aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8015ad:	eb 42                	jmp    8015f1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8015af:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b2:	8a 00                	mov    (%eax),%al
  8015b4:	3c 60                	cmp    $0x60,%al
  8015b6:	7e 19                	jle    8015d1 <strtol+0xe4>
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	3c 7a                	cmp    $0x7a,%al
  8015bf:	7f 10                	jg     8015d1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	8a 00                	mov    (%eax),%al
  8015c6:	0f be c0             	movsbl %al,%eax
  8015c9:	83 e8 57             	sub    $0x57,%eax
  8015cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8015cf:	eb 20                	jmp    8015f1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	8a 00                	mov    (%eax),%al
  8015d6:	3c 40                	cmp    $0x40,%al
  8015d8:	7e 39                	jle    801613 <strtol+0x126>
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	3c 5a                	cmp    $0x5a,%al
  8015e1:	7f 30                	jg     801613 <strtol+0x126>
			dig = *s - 'A' + 10;
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	0f be c0             	movsbl %al,%eax
  8015eb:	83 e8 37             	sub    $0x37,%eax
  8015ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8015f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015f4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015f7:	7d 19                	jge    801612 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8015f9:	ff 45 08             	incl   0x8(%ebp)
  8015fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ff:	0f af 45 10          	imul   0x10(%ebp),%eax
  801603:	89 c2                	mov    %eax,%edx
  801605:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801608:	01 d0                	add    %edx,%eax
  80160a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80160d:	e9 7b ff ff ff       	jmp    80158d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801612:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801613:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801617:	74 08                	je     801621 <strtol+0x134>
		*endptr = (char *) s;
  801619:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161c:	8b 55 08             	mov    0x8(%ebp),%edx
  80161f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801621:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801625:	74 07                	je     80162e <strtol+0x141>
  801627:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80162a:	f7 d8                	neg    %eax
  80162c:	eb 03                	jmp    801631 <strtol+0x144>
  80162e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801631:	c9                   	leave  
  801632:	c3                   	ret    

00801633 <ltostr>:

void
ltostr(long value, char *str)
{
  801633:	55                   	push   %ebp
  801634:	89 e5                	mov    %esp,%ebp
  801636:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801639:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801640:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801647:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80164b:	79 13                	jns    801660 <ltostr+0x2d>
	{
		neg = 1;
  80164d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801654:	8b 45 0c             	mov    0xc(%ebp),%eax
  801657:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80165a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80165d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801668:	99                   	cltd   
  801669:	f7 f9                	idiv   %ecx
  80166b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80166e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801671:	8d 50 01             	lea    0x1(%eax),%edx
  801674:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801677:	89 c2                	mov    %eax,%edx
  801679:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167c:	01 d0                	add    %edx,%eax
  80167e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801681:	83 c2 30             	add    $0x30,%edx
  801684:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801686:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801689:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80168e:	f7 e9                	imul   %ecx
  801690:	c1 fa 02             	sar    $0x2,%edx
  801693:	89 c8                	mov    %ecx,%eax
  801695:	c1 f8 1f             	sar    $0x1f,%eax
  801698:	29 c2                	sub    %eax,%edx
  80169a:	89 d0                	mov    %edx,%eax
  80169c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80169f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016a2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8016a7:	f7 e9                	imul   %ecx
  8016a9:	c1 fa 02             	sar    $0x2,%edx
  8016ac:	89 c8                	mov    %ecx,%eax
  8016ae:	c1 f8 1f             	sar    $0x1f,%eax
  8016b1:	29 c2                	sub    %eax,%edx
  8016b3:	89 d0                	mov    %edx,%eax
  8016b5:	c1 e0 02             	shl    $0x2,%eax
  8016b8:	01 d0                	add    %edx,%eax
  8016ba:	01 c0                	add    %eax,%eax
  8016bc:	29 c1                	sub    %eax,%ecx
  8016be:	89 ca                	mov    %ecx,%edx
  8016c0:	85 d2                	test   %edx,%edx
  8016c2:	75 9c                	jne    801660 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8016c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8016cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ce:	48                   	dec    %eax
  8016cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8016d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016d6:	74 3d                	je     801715 <ltostr+0xe2>
		start = 1 ;
  8016d8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8016df:	eb 34                	jmp    801715 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8016e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e7:	01 d0                	add    %edx,%eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8016ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f4:	01 c2                	add    %eax,%edx
  8016f6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8016f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016fc:	01 c8                	add    %ecx,%eax
  8016fe:	8a 00                	mov    (%eax),%al
  801700:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801702:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801705:	8b 45 0c             	mov    0xc(%ebp),%eax
  801708:	01 c2                	add    %eax,%edx
  80170a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80170d:	88 02                	mov    %al,(%edx)
		start++ ;
  80170f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801712:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801715:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801718:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80171b:	7c c4                	jl     8016e1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80171d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801720:	8b 45 0c             	mov    0xc(%ebp),%eax
  801723:	01 d0                	add    %edx,%eax
  801725:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801728:	90                   	nop
  801729:	c9                   	leave  
  80172a:	c3                   	ret    

0080172b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80172b:	55                   	push   %ebp
  80172c:	89 e5                	mov    %esp,%ebp
  80172e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801731:	ff 75 08             	pushl  0x8(%ebp)
  801734:	e8 54 fa ff ff       	call   80118d <strlen>
  801739:	83 c4 04             	add    $0x4,%esp
  80173c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80173f:	ff 75 0c             	pushl  0xc(%ebp)
  801742:	e8 46 fa ff ff       	call   80118d <strlen>
  801747:	83 c4 04             	add    $0x4,%esp
  80174a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80174d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801754:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80175b:	eb 17                	jmp    801774 <strcconcat+0x49>
		final[s] = str1[s] ;
  80175d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801760:	8b 45 10             	mov    0x10(%ebp),%eax
  801763:	01 c2                	add    %eax,%edx
  801765:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	01 c8                	add    %ecx,%eax
  80176d:	8a 00                	mov    (%eax),%al
  80176f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801771:	ff 45 fc             	incl   -0x4(%ebp)
  801774:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801777:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80177a:	7c e1                	jl     80175d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80177c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801783:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80178a:	eb 1f                	jmp    8017ab <strcconcat+0x80>
		final[s++] = str2[i] ;
  80178c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80178f:	8d 50 01             	lea    0x1(%eax),%edx
  801792:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801795:	89 c2                	mov    %eax,%edx
  801797:	8b 45 10             	mov    0x10(%ebp),%eax
  80179a:	01 c2                	add    %eax,%edx
  80179c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80179f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a2:	01 c8                	add    %ecx,%eax
  8017a4:	8a 00                	mov    (%eax),%al
  8017a6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8017a8:	ff 45 f8             	incl   -0x8(%ebp)
  8017ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017b1:	7c d9                	jl     80178c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8017b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b9:	01 d0                	add    %edx,%eax
  8017bb:	c6 00 00             	movb   $0x0,(%eax)
}
  8017be:	90                   	nop
  8017bf:	c9                   	leave  
  8017c0:	c3                   	ret    

008017c1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8017c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8017c7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8017cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8017d0:	8b 00                	mov    (%eax),%eax
  8017d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017dc:	01 d0                	add    %edx,%eax
  8017de:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017e4:	eb 0c                	jmp    8017f2 <strsplit+0x31>
			*string++ = 0;
  8017e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e9:	8d 50 01             	lea    0x1(%eax),%edx
  8017ec:	89 55 08             	mov    %edx,0x8(%ebp)
  8017ef:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	8a 00                	mov    (%eax),%al
  8017f7:	84 c0                	test   %al,%al
  8017f9:	74 18                	je     801813 <strsplit+0x52>
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	8a 00                	mov    (%eax),%al
  801800:	0f be c0             	movsbl %al,%eax
  801803:	50                   	push   %eax
  801804:	ff 75 0c             	pushl  0xc(%ebp)
  801807:	e8 13 fb ff ff       	call   80131f <strchr>
  80180c:	83 c4 08             	add    $0x8,%esp
  80180f:	85 c0                	test   %eax,%eax
  801811:	75 d3                	jne    8017e6 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	84 c0                	test   %al,%al
  80181a:	74 5a                	je     801876 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  80181c:	8b 45 14             	mov    0x14(%ebp),%eax
  80181f:	8b 00                	mov    (%eax),%eax
  801821:	83 f8 0f             	cmp    $0xf,%eax
  801824:	75 07                	jne    80182d <strsplit+0x6c>
		{
			return 0;
  801826:	b8 00 00 00 00       	mov    $0x0,%eax
  80182b:	eb 66                	jmp    801893 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80182d:	8b 45 14             	mov    0x14(%ebp),%eax
  801830:	8b 00                	mov    (%eax),%eax
  801832:	8d 48 01             	lea    0x1(%eax),%ecx
  801835:	8b 55 14             	mov    0x14(%ebp),%edx
  801838:	89 0a                	mov    %ecx,(%edx)
  80183a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801841:	8b 45 10             	mov    0x10(%ebp),%eax
  801844:	01 c2                	add    %eax,%edx
  801846:	8b 45 08             	mov    0x8(%ebp),%eax
  801849:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80184b:	eb 03                	jmp    801850 <strsplit+0x8f>
			string++;
  80184d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801850:	8b 45 08             	mov    0x8(%ebp),%eax
  801853:	8a 00                	mov    (%eax),%al
  801855:	84 c0                	test   %al,%al
  801857:	74 8b                	je     8017e4 <strsplit+0x23>
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	8a 00                	mov    (%eax),%al
  80185e:	0f be c0             	movsbl %al,%eax
  801861:	50                   	push   %eax
  801862:	ff 75 0c             	pushl  0xc(%ebp)
  801865:	e8 b5 fa ff ff       	call   80131f <strchr>
  80186a:	83 c4 08             	add    $0x8,%esp
  80186d:	85 c0                	test   %eax,%eax
  80186f:	74 dc                	je     80184d <strsplit+0x8c>
			string++;
	}
  801871:	e9 6e ff ff ff       	jmp    8017e4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801876:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801877:	8b 45 14             	mov    0x14(%ebp),%eax
  80187a:	8b 00                	mov    (%eax),%eax
  80187c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801883:	8b 45 10             	mov    0x10(%ebp),%eax
  801886:	01 d0                	add    %edx,%eax
  801888:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80188e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
  801898:	57                   	push   %edi
  801899:	56                   	push   %esi
  80189a:	53                   	push   %ebx
  80189b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018a7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018aa:	8b 7d 18             	mov    0x18(%ebp),%edi
  8018ad:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8018b0:	cd 30                	int    $0x30
  8018b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8018b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018b8:	83 c4 10             	add    $0x10,%esp
  8018bb:	5b                   	pop    %ebx
  8018bc:	5e                   	pop    %esi
  8018bd:	5f                   	pop    %edi
  8018be:	5d                   	pop    %ebp
  8018bf:	c3                   	ret    

008018c0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
  8018c3:	83 ec 04             	sub    $0x4,%esp
  8018c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018cc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	52                   	push   %edx
  8018d8:	ff 75 0c             	pushl  0xc(%ebp)
  8018db:	50                   	push   %eax
  8018dc:	6a 00                	push   $0x0
  8018de:	e8 b2 ff ff ff       	call   801895 <syscall>
  8018e3:	83 c4 18             	add    $0x18,%esp
}
  8018e6:	90                   	nop
  8018e7:	c9                   	leave  
  8018e8:	c3                   	ret    

008018e9 <sys_cgetc>:

int
sys_cgetc(void)
{
  8018e9:	55                   	push   %ebp
  8018ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 01                	push   $0x1
  8018f8:	e8 98 ff ff ff       	call   801895 <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
}
  801900:	c9                   	leave  
  801901:	c3                   	ret    

00801902 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801902:	55                   	push   %ebp
  801903:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	50                   	push   %eax
  801911:	6a 05                	push   $0x5
  801913:	e8 7d ff ff ff       	call   801895 <syscall>
  801918:	83 c4 18             	add    $0x18,%esp
}
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 02                	push   $0x2
  80192c:	e8 64 ff ff ff       	call   801895 <syscall>
  801931:	83 c4 18             	add    $0x18,%esp
}
  801934:	c9                   	leave  
  801935:	c3                   	ret    

00801936 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801936:	55                   	push   %ebp
  801937:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 03                	push   $0x3
  801945:	e8 4b ff ff ff       	call   801895 <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 04                	push   $0x4
  80195e:	e8 32 ff ff ff       	call   801895 <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_env_exit>:


void sys_env_exit(void)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 06                	push   $0x6
  801977:	e8 19 ff ff ff       	call   801895 <syscall>
  80197c:	83 c4 18             	add    $0x18,%esp
}
  80197f:	90                   	nop
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801985:	8b 55 0c             	mov    0xc(%ebp),%edx
  801988:	8b 45 08             	mov    0x8(%ebp),%eax
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	52                   	push   %edx
  801992:	50                   	push   %eax
  801993:	6a 07                	push   $0x7
  801995:	e8 fb fe ff ff       	call   801895 <syscall>
  80199a:	83 c4 18             	add    $0x18,%esp
}
  80199d:	c9                   	leave  
  80199e:	c3                   	ret    

0080199f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80199f:	55                   	push   %ebp
  8019a0:	89 e5                	mov    %esp,%ebp
  8019a2:	56                   	push   %esi
  8019a3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8019a4:	8b 75 18             	mov    0x18(%ebp),%esi
  8019a7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	56                   	push   %esi
  8019b4:	53                   	push   %ebx
  8019b5:	51                   	push   %ecx
  8019b6:	52                   	push   %edx
  8019b7:	50                   	push   %eax
  8019b8:	6a 08                	push   $0x8
  8019ba:	e8 d6 fe ff ff       	call   801895 <syscall>
  8019bf:	83 c4 18             	add    $0x18,%esp
}
  8019c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019c5:	5b                   	pop    %ebx
  8019c6:	5e                   	pop    %esi
  8019c7:	5d                   	pop    %ebp
  8019c8:	c3                   	ret    

008019c9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019c9:	55                   	push   %ebp
  8019ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	52                   	push   %edx
  8019d9:	50                   	push   %eax
  8019da:	6a 09                	push   $0x9
  8019dc:	e8 b4 fe ff ff       	call   801895 <syscall>
  8019e1:	83 c4 18             	add    $0x18,%esp
}
  8019e4:	c9                   	leave  
  8019e5:	c3                   	ret    

008019e6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019e6:	55                   	push   %ebp
  8019e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	ff 75 0c             	pushl  0xc(%ebp)
  8019f2:	ff 75 08             	pushl  0x8(%ebp)
  8019f5:	6a 0a                	push   $0xa
  8019f7:	e8 99 fe ff ff       	call   801895 <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 0b                	push   $0xb
  801a10:	e8 80 fe ff ff       	call   801895 <syscall>
  801a15:	83 c4 18             	add    $0x18,%esp
}
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 0c                	push   $0xc
  801a29:	e8 67 fe ff ff       	call   801895 <syscall>
  801a2e:	83 c4 18             	add    $0x18,%esp
}
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 0d                	push   $0xd
  801a42:	e8 4e fe ff ff       	call   801895 <syscall>
  801a47:	83 c4 18             	add    $0x18,%esp
}
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	ff 75 0c             	pushl  0xc(%ebp)
  801a58:	ff 75 08             	pushl  0x8(%ebp)
  801a5b:	6a 11                	push   $0x11
  801a5d:	e8 33 fe ff ff       	call   801895 <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
	return;
  801a65:	90                   	nop
}
  801a66:	c9                   	leave  
  801a67:	c3                   	ret    

00801a68 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a68:	55                   	push   %ebp
  801a69:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	ff 75 0c             	pushl  0xc(%ebp)
  801a74:	ff 75 08             	pushl  0x8(%ebp)
  801a77:	6a 12                	push   $0x12
  801a79:	e8 17 fe ff ff       	call   801895 <syscall>
  801a7e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a81:	90                   	nop
}
  801a82:	c9                   	leave  
  801a83:	c3                   	ret    

00801a84 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a84:	55                   	push   %ebp
  801a85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 0e                	push   $0xe
  801a93:	e8 fd fd ff ff       	call   801895 <syscall>
  801a98:	83 c4 18             	add    $0x18,%esp
}
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	ff 75 08             	pushl  0x8(%ebp)
  801aab:	6a 0f                	push   $0xf
  801aad:	e8 e3 fd ff ff       	call   801895 <syscall>
  801ab2:	83 c4 18             	add    $0x18,%esp
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 10                	push   $0x10
  801ac6:	e8 ca fd ff ff       	call   801895 <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	90                   	nop
  801acf:	c9                   	leave  
  801ad0:	c3                   	ret    

00801ad1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ad1:	55                   	push   %ebp
  801ad2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 00                	push   $0x0
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 14                	push   $0x14
  801ae0:	e8 b0 fd ff ff       	call   801895 <syscall>
  801ae5:	83 c4 18             	add    $0x18,%esp
}
  801ae8:	90                   	nop
  801ae9:	c9                   	leave  
  801aea:	c3                   	ret    

00801aeb <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801aeb:	55                   	push   %ebp
  801aec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 15                	push   $0x15
  801afa:	e8 96 fd ff ff       	call   801895 <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
}
  801b02:	90                   	nop
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    

00801b05 <sys_cputc>:


void
sys_cputc(const char c)
{
  801b05:	55                   	push   %ebp
  801b06:	89 e5                	mov    %esp,%ebp
  801b08:	83 ec 04             	sub    $0x4,%esp
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b11:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	50                   	push   %eax
  801b1e:	6a 16                	push   $0x16
  801b20:	e8 70 fd ff ff       	call   801895 <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	90                   	nop
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 17                	push   $0x17
  801b3a:	e8 56 fd ff ff       	call   801895 <syscall>
  801b3f:	83 c4 18             	add    $0x18,%esp
}
  801b42:	90                   	nop
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b48:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	ff 75 0c             	pushl  0xc(%ebp)
  801b54:	50                   	push   %eax
  801b55:	6a 18                	push   $0x18
  801b57:	e8 39 fd ff ff       	call   801895 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	c9                   	leave  
  801b60:	c3                   	ret    

00801b61 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b61:	55                   	push   %ebp
  801b62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b64:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	52                   	push   %edx
  801b71:	50                   	push   %eax
  801b72:	6a 1b                	push   $0x1b
  801b74:	e8 1c fd ff ff       	call   801895 <syscall>
  801b79:	83 c4 18             	add    $0x18,%esp
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b84:	8b 45 08             	mov    0x8(%ebp),%eax
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	6a 00                	push   $0x0
  801b8d:	52                   	push   %edx
  801b8e:	50                   	push   %eax
  801b8f:	6a 19                	push   $0x19
  801b91:	e8 ff fc ff ff       	call   801895 <syscall>
  801b96:	83 c4 18             	add    $0x18,%esp
}
  801b99:	90                   	nop
  801b9a:	c9                   	leave  
  801b9b:	c3                   	ret    

00801b9c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	52                   	push   %edx
  801bac:	50                   	push   %eax
  801bad:	6a 1a                	push   $0x1a
  801baf:	e8 e1 fc ff ff       	call   801895 <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
}
  801bb7:	90                   	nop
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
  801bbd:	83 ec 04             	sub    $0x4,%esp
  801bc0:	8b 45 10             	mov    0x10(%ebp),%eax
  801bc3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801bc6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801bc9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd0:	6a 00                	push   $0x0
  801bd2:	51                   	push   %ecx
  801bd3:	52                   	push   %edx
  801bd4:	ff 75 0c             	pushl  0xc(%ebp)
  801bd7:	50                   	push   %eax
  801bd8:	6a 1c                	push   $0x1c
  801bda:	e8 b6 fc ff ff       	call   801895 <syscall>
  801bdf:	83 c4 18             	add    $0x18,%esp
}
  801be2:	c9                   	leave  
  801be3:	c3                   	ret    

00801be4 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801be4:	55                   	push   %ebp
  801be5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801be7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bea:	8b 45 08             	mov    0x8(%ebp),%eax
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	52                   	push   %edx
  801bf4:	50                   	push   %eax
  801bf5:	6a 1d                	push   $0x1d
  801bf7:	e8 99 fc ff ff       	call   801895 <syscall>
  801bfc:	83 c4 18             	add    $0x18,%esp
}
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c04:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c07:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	51                   	push   %ecx
  801c12:	52                   	push   %edx
  801c13:	50                   	push   %eax
  801c14:	6a 1e                	push   $0x1e
  801c16:	e8 7a fc ff ff       	call   801895 <syscall>
  801c1b:	83 c4 18             	add    $0x18,%esp
}
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c26:	8b 45 08             	mov    0x8(%ebp),%eax
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	52                   	push   %edx
  801c30:	50                   	push   %eax
  801c31:	6a 1f                	push   $0x1f
  801c33:	e8 5d fc ff ff       	call   801895 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 20                	push   $0x20
  801c4c:	e8 44 fc ff ff       	call   801895 <syscall>
  801c51:	83 c4 18             	add    $0x18,%esp
}
  801c54:	c9                   	leave  
  801c55:	c3                   	ret    

00801c56 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801c59:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	ff 75 10             	pushl  0x10(%ebp)
  801c63:	ff 75 0c             	pushl  0xc(%ebp)
  801c66:	50                   	push   %eax
  801c67:	6a 21                	push   $0x21
  801c69:	e8 27 fc ff ff       	call   801895 <syscall>
  801c6e:	83 c4 18             	add    $0x18,%esp
}
  801c71:	c9                   	leave  
  801c72:	c3                   	ret    

00801c73 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c73:	55                   	push   %ebp
  801c74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c76:	8b 45 08             	mov    0x8(%ebp),%eax
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	50                   	push   %eax
  801c82:	6a 22                	push   $0x22
  801c84:	e8 0c fc ff ff       	call   801895 <syscall>
  801c89:	83 c4 18             	add    $0x18,%esp
}
  801c8c:	90                   	nop
  801c8d:	c9                   	leave  
  801c8e:	c3                   	ret    

00801c8f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c8f:	55                   	push   %ebp
  801c90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c92:	8b 45 08             	mov    0x8(%ebp),%eax
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	50                   	push   %eax
  801c9e:	6a 23                	push   $0x23
  801ca0:	e8 f0 fb ff ff       	call   801895 <syscall>
  801ca5:	83 c4 18             	add    $0x18,%esp
}
  801ca8:	90                   	nop
  801ca9:	c9                   	leave  
  801caa:	c3                   	ret    

00801cab <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801cb1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cb4:	8d 50 04             	lea    0x4(%eax),%edx
  801cb7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	52                   	push   %edx
  801cc1:	50                   	push   %eax
  801cc2:	6a 24                	push   $0x24
  801cc4:	e8 cc fb ff ff       	call   801895 <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
	return result;
  801ccc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ccf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cd2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cd5:	89 01                	mov    %eax,(%ecx)
  801cd7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801cda:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdd:	c9                   	leave  
  801cde:	c2 04 00             	ret    $0x4

00801ce1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	ff 75 10             	pushl  0x10(%ebp)
  801ceb:	ff 75 0c             	pushl  0xc(%ebp)
  801cee:	ff 75 08             	pushl  0x8(%ebp)
  801cf1:	6a 13                	push   $0x13
  801cf3:	e8 9d fb ff ff       	call   801895 <syscall>
  801cf8:	83 c4 18             	add    $0x18,%esp
	return ;
  801cfb:	90                   	nop
}
  801cfc:	c9                   	leave  
  801cfd:	c3                   	ret    

00801cfe <sys_rcr2>:
uint32 sys_rcr2()
{
  801cfe:	55                   	push   %ebp
  801cff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 25                	push   $0x25
  801d0d:	e8 83 fb ff ff       	call   801895 <syscall>
  801d12:	83 c4 18             	add    $0x18,%esp
}
  801d15:	c9                   	leave  
  801d16:	c3                   	ret    

00801d17 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
  801d1a:	83 ec 04             	sub    $0x4,%esp
  801d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d20:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d23:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	50                   	push   %eax
  801d30:	6a 26                	push   $0x26
  801d32:	e8 5e fb ff ff       	call   801895 <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
	return ;
  801d3a:	90                   	nop
}
  801d3b:	c9                   	leave  
  801d3c:	c3                   	ret    

00801d3d <rsttst>:
void rsttst()
{
  801d3d:	55                   	push   %ebp
  801d3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 28                	push   $0x28
  801d4c:	e8 44 fb ff ff       	call   801895 <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
	return ;
  801d54:	90                   	nop
}
  801d55:	c9                   	leave  
  801d56:	c3                   	ret    

00801d57 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d57:	55                   	push   %ebp
  801d58:	89 e5                	mov    %esp,%ebp
  801d5a:	83 ec 04             	sub    $0x4,%esp
  801d5d:	8b 45 14             	mov    0x14(%ebp),%eax
  801d60:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d63:	8b 55 18             	mov    0x18(%ebp),%edx
  801d66:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d6a:	52                   	push   %edx
  801d6b:	50                   	push   %eax
  801d6c:	ff 75 10             	pushl  0x10(%ebp)
  801d6f:	ff 75 0c             	pushl  0xc(%ebp)
  801d72:	ff 75 08             	pushl  0x8(%ebp)
  801d75:	6a 27                	push   $0x27
  801d77:	e8 19 fb ff ff       	call   801895 <syscall>
  801d7c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d7f:	90                   	nop
}
  801d80:	c9                   	leave  
  801d81:	c3                   	ret    

00801d82 <chktst>:
void chktst(uint32 n)
{
  801d82:	55                   	push   %ebp
  801d83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	ff 75 08             	pushl  0x8(%ebp)
  801d90:	6a 29                	push   $0x29
  801d92:	e8 fe fa ff ff       	call   801895 <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
	return ;
  801d9a:	90                   	nop
}
  801d9b:	c9                   	leave  
  801d9c:	c3                   	ret    

00801d9d <inctst>:

void inctst()
{
  801d9d:	55                   	push   %ebp
  801d9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 2a                	push   $0x2a
  801dac:	e8 e4 fa ff ff       	call   801895 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
	return ;
  801db4:	90                   	nop
}
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <gettst>:
uint32 gettst()
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 2b                	push   $0x2b
  801dc6:	e8 ca fa ff ff       	call   801895 <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
  801dd3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 2c                	push   $0x2c
  801de2:	e8 ae fa ff ff       	call   801895 <syscall>
  801de7:	83 c4 18             	add    $0x18,%esp
  801dea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ded:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801df1:	75 07                	jne    801dfa <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801df3:	b8 01 00 00 00       	mov    $0x1,%eax
  801df8:	eb 05                	jmp    801dff <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801dfa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dff:	c9                   	leave  
  801e00:	c3                   	ret    

00801e01 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e01:	55                   	push   %ebp
  801e02:	89 e5                	mov    %esp,%ebp
  801e04:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 2c                	push   $0x2c
  801e13:	e8 7d fa ff ff       	call   801895 <syscall>
  801e18:	83 c4 18             	add    $0x18,%esp
  801e1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e1e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e22:	75 07                	jne    801e2b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e24:	b8 01 00 00 00       	mov    $0x1,%eax
  801e29:	eb 05                	jmp    801e30 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
  801e35:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 2c                	push   $0x2c
  801e44:	e8 4c fa ff ff       	call   801895 <syscall>
  801e49:	83 c4 18             	add    $0x18,%esp
  801e4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e4f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e53:	75 07                	jne    801e5c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e55:	b8 01 00 00 00       	mov    $0x1,%eax
  801e5a:	eb 05                	jmp    801e61 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
  801e66:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 2c                	push   $0x2c
  801e75:	e8 1b fa ff ff       	call   801895 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
  801e7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e80:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e84:	75 07                	jne    801e8d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e86:	b8 01 00 00 00       	mov    $0x1,%eax
  801e8b:	eb 05                	jmp    801e92 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e92:	c9                   	leave  
  801e93:	c3                   	ret    

00801e94 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e94:	55                   	push   %ebp
  801e95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	ff 75 08             	pushl  0x8(%ebp)
  801ea2:	6a 2d                	push   $0x2d
  801ea4:	e8 ec f9 ff ff       	call   801895 <syscall>
  801ea9:	83 c4 18             	add    $0x18,%esp
	return ;
  801eac:	90                   	nop
}
  801ead:	c9                   	leave  
  801eae:	c3                   	ret    
  801eaf:	90                   	nop

00801eb0 <__udivdi3>:
  801eb0:	55                   	push   %ebp
  801eb1:	57                   	push   %edi
  801eb2:	56                   	push   %esi
  801eb3:	53                   	push   %ebx
  801eb4:	83 ec 1c             	sub    $0x1c,%esp
  801eb7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ebb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ebf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ec3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ec7:	89 ca                	mov    %ecx,%edx
  801ec9:	89 f8                	mov    %edi,%eax
  801ecb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ecf:	85 f6                	test   %esi,%esi
  801ed1:	75 2d                	jne    801f00 <__udivdi3+0x50>
  801ed3:	39 cf                	cmp    %ecx,%edi
  801ed5:	77 65                	ja     801f3c <__udivdi3+0x8c>
  801ed7:	89 fd                	mov    %edi,%ebp
  801ed9:	85 ff                	test   %edi,%edi
  801edb:	75 0b                	jne    801ee8 <__udivdi3+0x38>
  801edd:	b8 01 00 00 00       	mov    $0x1,%eax
  801ee2:	31 d2                	xor    %edx,%edx
  801ee4:	f7 f7                	div    %edi
  801ee6:	89 c5                	mov    %eax,%ebp
  801ee8:	31 d2                	xor    %edx,%edx
  801eea:	89 c8                	mov    %ecx,%eax
  801eec:	f7 f5                	div    %ebp
  801eee:	89 c1                	mov    %eax,%ecx
  801ef0:	89 d8                	mov    %ebx,%eax
  801ef2:	f7 f5                	div    %ebp
  801ef4:	89 cf                	mov    %ecx,%edi
  801ef6:	89 fa                	mov    %edi,%edx
  801ef8:	83 c4 1c             	add    $0x1c,%esp
  801efb:	5b                   	pop    %ebx
  801efc:	5e                   	pop    %esi
  801efd:	5f                   	pop    %edi
  801efe:	5d                   	pop    %ebp
  801eff:	c3                   	ret    
  801f00:	39 ce                	cmp    %ecx,%esi
  801f02:	77 28                	ja     801f2c <__udivdi3+0x7c>
  801f04:	0f bd fe             	bsr    %esi,%edi
  801f07:	83 f7 1f             	xor    $0x1f,%edi
  801f0a:	75 40                	jne    801f4c <__udivdi3+0x9c>
  801f0c:	39 ce                	cmp    %ecx,%esi
  801f0e:	72 0a                	jb     801f1a <__udivdi3+0x6a>
  801f10:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f14:	0f 87 9e 00 00 00    	ja     801fb8 <__udivdi3+0x108>
  801f1a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f1f:	89 fa                	mov    %edi,%edx
  801f21:	83 c4 1c             	add    $0x1c,%esp
  801f24:	5b                   	pop    %ebx
  801f25:	5e                   	pop    %esi
  801f26:	5f                   	pop    %edi
  801f27:	5d                   	pop    %ebp
  801f28:	c3                   	ret    
  801f29:	8d 76 00             	lea    0x0(%esi),%esi
  801f2c:	31 ff                	xor    %edi,%edi
  801f2e:	31 c0                	xor    %eax,%eax
  801f30:	89 fa                	mov    %edi,%edx
  801f32:	83 c4 1c             	add    $0x1c,%esp
  801f35:	5b                   	pop    %ebx
  801f36:	5e                   	pop    %esi
  801f37:	5f                   	pop    %edi
  801f38:	5d                   	pop    %ebp
  801f39:	c3                   	ret    
  801f3a:	66 90                	xchg   %ax,%ax
  801f3c:	89 d8                	mov    %ebx,%eax
  801f3e:	f7 f7                	div    %edi
  801f40:	31 ff                	xor    %edi,%edi
  801f42:	89 fa                	mov    %edi,%edx
  801f44:	83 c4 1c             	add    $0x1c,%esp
  801f47:	5b                   	pop    %ebx
  801f48:	5e                   	pop    %esi
  801f49:	5f                   	pop    %edi
  801f4a:	5d                   	pop    %ebp
  801f4b:	c3                   	ret    
  801f4c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f51:	89 eb                	mov    %ebp,%ebx
  801f53:	29 fb                	sub    %edi,%ebx
  801f55:	89 f9                	mov    %edi,%ecx
  801f57:	d3 e6                	shl    %cl,%esi
  801f59:	89 c5                	mov    %eax,%ebp
  801f5b:	88 d9                	mov    %bl,%cl
  801f5d:	d3 ed                	shr    %cl,%ebp
  801f5f:	89 e9                	mov    %ebp,%ecx
  801f61:	09 f1                	or     %esi,%ecx
  801f63:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f67:	89 f9                	mov    %edi,%ecx
  801f69:	d3 e0                	shl    %cl,%eax
  801f6b:	89 c5                	mov    %eax,%ebp
  801f6d:	89 d6                	mov    %edx,%esi
  801f6f:	88 d9                	mov    %bl,%cl
  801f71:	d3 ee                	shr    %cl,%esi
  801f73:	89 f9                	mov    %edi,%ecx
  801f75:	d3 e2                	shl    %cl,%edx
  801f77:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f7b:	88 d9                	mov    %bl,%cl
  801f7d:	d3 e8                	shr    %cl,%eax
  801f7f:	09 c2                	or     %eax,%edx
  801f81:	89 d0                	mov    %edx,%eax
  801f83:	89 f2                	mov    %esi,%edx
  801f85:	f7 74 24 0c          	divl   0xc(%esp)
  801f89:	89 d6                	mov    %edx,%esi
  801f8b:	89 c3                	mov    %eax,%ebx
  801f8d:	f7 e5                	mul    %ebp
  801f8f:	39 d6                	cmp    %edx,%esi
  801f91:	72 19                	jb     801fac <__udivdi3+0xfc>
  801f93:	74 0b                	je     801fa0 <__udivdi3+0xf0>
  801f95:	89 d8                	mov    %ebx,%eax
  801f97:	31 ff                	xor    %edi,%edi
  801f99:	e9 58 ff ff ff       	jmp    801ef6 <__udivdi3+0x46>
  801f9e:	66 90                	xchg   %ax,%ax
  801fa0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fa4:	89 f9                	mov    %edi,%ecx
  801fa6:	d3 e2                	shl    %cl,%edx
  801fa8:	39 c2                	cmp    %eax,%edx
  801faa:	73 e9                	jae    801f95 <__udivdi3+0xe5>
  801fac:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801faf:	31 ff                	xor    %edi,%edi
  801fb1:	e9 40 ff ff ff       	jmp    801ef6 <__udivdi3+0x46>
  801fb6:	66 90                	xchg   %ax,%ax
  801fb8:	31 c0                	xor    %eax,%eax
  801fba:	e9 37 ff ff ff       	jmp    801ef6 <__udivdi3+0x46>
  801fbf:	90                   	nop

00801fc0 <__umoddi3>:
  801fc0:	55                   	push   %ebp
  801fc1:	57                   	push   %edi
  801fc2:	56                   	push   %esi
  801fc3:	53                   	push   %ebx
  801fc4:	83 ec 1c             	sub    $0x1c,%esp
  801fc7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801fcb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fcf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fd3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fd7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801fdb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801fdf:	89 f3                	mov    %esi,%ebx
  801fe1:	89 fa                	mov    %edi,%edx
  801fe3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fe7:	89 34 24             	mov    %esi,(%esp)
  801fea:	85 c0                	test   %eax,%eax
  801fec:	75 1a                	jne    802008 <__umoddi3+0x48>
  801fee:	39 f7                	cmp    %esi,%edi
  801ff0:	0f 86 a2 00 00 00    	jbe    802098 <__umoddi3+0xd8>
  801ff6:	89 c8                	mov    %ecx,%eax
  801ff8:	89 f2                	mov    %esi,%edx
  801ffa:	f7 f7                	div    %edi
  801ffc:	89 d0                	mov    %edx,%eax
  801ffe:	31 d2                	xor    %edx,%edx
  802000:	83 c4 1c             	add    $0x1c,%esp
  802003:	5b                   	pop    %ebx
  802004:	5e                   	pop    %esi
  802005:	5f                   	pop    %edi
  802006:	5d                   	pop    %ebp
  802007:	c3                   	ret    
  802008:	39 f0                	cmp    %esi,%eax
  80200a:	0f 87 ac 00 00 00    	ja     8020bc <__umoddi3+0xfc>
  802010:	0f bd e8             	bsr    %eax,%ebp
  802013:	83 f5 1f             	xor    $0x1f,%ebp
  802016:	0f 84 ac 00 00 00    	je     8020c8 <__umoddi3+0x108>
  80201c:	bf 20 00 00 00       	mov    $0x20,%edi
  802021:	29 ef                	sub    %ebp,%edi
  802023:	89 fe                	mov    %edi,%esi
  802025:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802029:	89 e9                	mov    %ebp,%ecx
  80202b:	d3 e0                	shl    %cl,%eax
  80202d:	89 d7                	mov    %edx,%edi
  80202f:	89 f1                	mov    %esi,%ecx
  802031:	d3 ef                	shr    %cl,%edi
  802033:	09 c7                	or     %eax,%edi
  802035:	89 e9                	mov    %ebp,%ecx
  802037:	d3 e2                	shl    %cl,%edx
  802039:	89 14 24             	mov    %edx,(%esp)
  80203c:	89 d8                	mov    %ebx,%eax
  80203e:	d3 e0                	shl    %cl,%eax
  802040:	89 c2                	mov    %eax,%edx
  802042:	8b 44 24 08          	mov    0x8(%esp),%eax
  802046:	d3 e0                	shl    %cl,%eax
  802048:	89 44 24 04          	mov    %eax,0x4(%esp)
  80204c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802050:	89 f1                	mov    %esi,%ecx
  802052:	d3 e8                	shr    %cl,%eax
  802054:	09 d0                	or     %edx,%eax
  802056:	d3 eb                	shr    %cl,%ebx
  802058:	89 da                	mov    %ebx,%edx
  80205a:	f7 f7                	div    %edi
  80205c:	89 d3                	mov    %edx,%ebx
  80205e:	f7 24 24             	mull   (%esp)
  802061:	89 c6                	mov    %eax,%esi
  802063:	89 d1                	mov    %edx,%ecx
  802065:	39 d3                	cmp    %edx,%ebx
  802067:	0f 82 87 00 00 00    	jb     8020f4 <__umoddi3+0x134>
  80206d:	0f 84 91 00 00 00    	je     802104 <__umoddi3+0x144>
  802073:	8b 54 24 04          	mov    0x4(%esp),%edx
  802077:	29 f2                	sub    %esi,%edx
  802079:	19 cb                	sbb    %ecx,%ebx
  80207b:	89 d8                	mov    %ebx,%eax
  80207d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802081:	d3 e0                	shl    %cl,%eax
  802083:	89 e9                	mov    %ebp,%ecx
  802085:	d3 ea                	shr    %cl,%edx
  802087:	09 d0                	or     %edx,%eax
  802089:	89 e9                	mov    %ebp,%ecx
  80208b:	d3 eb                	shr    %cl,%ebx
  80208d:	89 da                	mov    %ebx,%edx
  80208f:	83 c4 1c             	add    $0x1c,%esp
  802092:	5b                   	pop    %ebx
  802093:	5e                   	pop    %esi
  802094:	5f                   	pop    %edi
  802095:	5d                   	pop    %ebp
  802096:	c3                   	ret    
  802097:	90                   	nop
  802098:	89 fd                	mov    %edi,%ebp
  80209a:	85 ff                	test   %edi,%edi
  80209c:	75 0b                	jne    8020a9 <__umoddi3+0xe9>
  80209e:	b8 01 00 00 00       	mov    $0x1,%eax
  8020a3:	31 d2                	xor    %edx,%edx
  8020a5:	f7 f7                	div    %edi
  8020a7:	89 c5                	mov    %eax,%ebp
  8020a9:	89 f0                	mov    %esi,%eax
  8020ab:	31 d2                	xor    %edx,%edx
  8020ad:	f7 f5                	div    %ebp
  8020af:	89 c8                	mov    %ecx,%eax
  8020b1:	f7 f5                	div    %ebp
  8020b3:	89 d0                	mov    %edx,%eax
  8020b5:	e9 44 ff ff ff       	jmp    801ffe <__umoddi3+0x3e>
  8020ba:	66 90                	xchg   %ax,%ax
  8020bc:	89 c8                	mov    %ecx,%eax
  8020be:	89 f2                	mov    %esi,%edx
  8020c0:	83 c4 1c             	add    $0x1c,%esp
  8020c3:	5b                   	pop    %ebx
  8020c4:	5e                   	pop    %esi
  8020c5:	5f                   	pop    %edi
  8020c6:	5d                   	pop    %ebp
  8020c7:	c3                   	ret    
  8020c8:	3b 04 24             	cmp    (%esp),%eax
  8020cb:	72 06                	jb     8020d3 <__umoddi3+0x113>
  8020cd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020d1:	77 0f                	ja     8020e2 <__umoddi3+0x122>
  8020d3:	89 f2                	mov    %esi,%edx
  8020d5:	29 f9                	sub    %edi,%ecx
  8020d7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020db:	89 14 24             	mov    %edx,(%esp)
  8020de:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020e2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020e6:	8b 14 24             	mov    (%esp),%edx
  8020e9:	83 c4 1c             	add    $0x1c,%esp
  8020ec:	5b                   	pop    %ebx
  8020ed:	5e                   	pop    %esi
  8020ee:	5f                   	pop    %edi
  8020ef:	5d                   	pop    %ebp
  8020f0:	c3                   	ret    
  8020f1:	8d 76 00             	lea    0x0(%esi),%esi
  8020f4:	2b 04 24             	sub    (%esp),%eax
  8020f7:	19 fa                	sbb    %edi,%edx
  8020f9:	89 d1                	mov    %edx,%ecx
  8020fb:	89 c6                	mov    %eax,%esi
  8020fd:	e9 71 ff ff ff       	jmp    802073 <__umoddi3+0xb3>
  802102:	66 90                	xchg   %ax,%ax
  802104:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802108:	72 ea                	jb     8020f4 <__umoddi3+0x134>
  80210a:	89 d9                	mov    %ebx,%ecx
  80210c:	e9 62 ff ff ff       	jmp    802073 <__umoddi3+0xb3>
