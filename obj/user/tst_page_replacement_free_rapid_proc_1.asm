
obj/user/tst_page_replacement_free_rapid_proc_1:     file format elf32-i386


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
  800031:	e8 f1 03 00 00       	call   800427 <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	83 ec 54             	sub    $0x54,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 00 1e 80 00       	push   $0x801e00
  800066:	6a 12                	push   $0x12
  800068:	68 44 1e 80 00       	push   $0x801e44
  80006d:	e8 b7 04 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80007d:	83 c0 0c             	add    $0xc,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 00 1e 80 00       	push   $0x801e00
  80009c:	6a 13                	push   $0x13
  80009e:	68 44 1e 80 00       	push   $0x801e44
  8000a3:	e8 81 04 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000b3:	83 c0 18             	add    $0x18,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 00 1e 80 00       	push   $0x801e00
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 44 1e 80 00       	push   $0x801e44
  8000d9:	e8 4b 04 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8000e9:	83 c0 24             	add    $0x24,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 00 1e 80 00       	push   $0x801e00
  800108:	6a 15                	push   $0x15
  80010a:	68 44 1e 80 00       	push   $0x801e44
  80010f:	e8 15 04 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80011f:	83 c0 30             	add    $0x30,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 00 1e 80 00       	push   $0x801e00
  80013e:	6a 16                	push   $0x16
  800140:	68 44 1e 80 00       	push   $0x801e44
  800145:	e8 df 03 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800155:	83 c0 3c             	add    $0x3c,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 00 1e 80 00       	push   $0x801e00
  800174:	6a 17                	push   $0x17
  800176:	68 44 1e 80 00       	push   $0x801e44
  80017b:	e8 a9 03 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80018b:	83 c0 48             	add    $0x48,%eax
  80018e:	8b 00                	mov    (%eax),%eax
  800190:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800193:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800196:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 00 1e 80 00       	push   $0x801e00
  8001aa:	6a 18                	push   $0x18
  8001ac:	68 44 1e 80 00       	push   $0x801e44
  8001b1:	e8 73 03 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001c1:	83 c0 54             	add    $0x54,%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d6:	74 14                	je     8001ec <_main+0x1b4>
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 00 1e 80 00       	push   $0x801e00
  8001e0:	6a 19                	push   $0x19
  8001e2:	68 44 1e 80 00       	push   $0x801e44
  8001e7:	e8 3d 03 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f1:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  8001f7:	83 c0 60             	add    $0x60,%eax
  8001fa:	8b 00                	mov    (%eax),%eax
  8001fc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800202:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800207:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020c:	74 14                	je     800222 <_main+0x1ea>
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	68 00 1e 80 00       	push   $0x801e00
  800216:	6a 1a                	push   $0x1a
  800218:	68 44 1e 80 00       	push   $0x801e44
  80021d:	e8 07 03 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800222:	a1 20 30 80 00       	mov    0x803020,%eax
  800227:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  80022d:	83 c0 6c             	add    $0x6c,%eax
  800230:	8b 00                	mov    (%eax),%eax
  800232:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800235:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800238:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023d:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800242:	74 14                	je     800258 <_main+0x220>
  800244:	83 ec 04             	sub    $0x4,%esp
  800247:	68 00 1e 80 00       	push   $0x801e00
  80024c:	6a 1b                	push   $0x1b
  80024e:	68 44 1e 80 00       	push   $0x801e44
  800253:	e8 d1 02 00 00       	call   800529 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800258:	a1 20 30 80 00       	mov    0x803020,%eax
  80025d:	8b 80 34 03 00 00    	mov    0x334(%eax),%eax
  800263:	83 c0 78             	add    $0x78,%eax
  800266:	8b 00                	mov    (%eax),%eax
  800268:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80026e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800273:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800278:	74 14                	je     80028e <_main+0x256>
  80027a:	83 ec 04             	sub    $0x4,%esp
  80027d:	68 00 1e 80 00       	push   $0x801e00
  800282:	6a 1c                	push   $0x1c
  800284:	68 44 1e 80 00       	push   $0x801e44
  800289:	e8 9b 02 00 00       	call   800529 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028e:	a1 20 30 80 00       	mov    0x803020,%eax
  800293:	8b 80 d4 02 00 00    	mov    0x2d4(%eax),%eax
  800299:	85 c0                	test   %eax,%eax
  80029b:	74 14                	je     8002b1 <_main+0x279>
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	68 74 1e 80 00       	push   $0x801e74
  8002a5:	6a 1d                	push   $0x1d
  8002a7:	68 44 1e 80 00       	push   $0x801e44
  8002ac:	e8 78 02 00 00       	call   800529 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002b1:	e8 1d 14 00 00       	call   8016d3 <sys_calculate_free_frames>
  8002b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b9:	e8 98 14 00 00       	call   801756 <sys_pf_calculate_allocated_pages>
  8002be:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002c1:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002c6:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002c9:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002ce:	88 45 be             	mov    %al,-0x42(%ebp)

	//AFTER freeing WS called followed by 2 allocations, then 2 frame taken be arr[PAGE_SIZE*11-1] and arr[PAGE_SIZE*11-1] and 5 frames are become free
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8002d1:	e8 80 14 00 00       	call   801756 <sys_pf_calculate_allocated_pages>
  8002d6:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  8002d9:	74 14                	je     8002ef <_main+0x2b7>
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 bc 1e 80 00       	push   $0x801ebc
  8002e3:	6a 29                	push   $0x29
  8002e5:	68 44 1e 80 00       	push   $0x801e44
  8002ea:	e8 3a 02 00 00       	call   800529 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8002ef:	e8 df 13 00 00       	call   8016d3 <sys_calculate_free_frames>
  8002f4:	89 c3                	mov    %eax,%ebx
  8002f6:	e8 f1 13 00 00       	call   8016ec <sys_calculate_modified_frames>
  8002fb:	01 d8                	add    %ebx,%eax
  8002fd:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != -5 )
  800300:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800303:	2b 45 b8             	sub    -0x48(%ebp),%eax
  800306:	83 f8 fb             	cmp    $0xfffffffb,%eax
  800309:	74 14                	je     80031f <_main+0x2e7>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80030b:	83 ec 04             	sub    $0x4,%esp
  80030e:	68 28 1f 80 00       	push   $0x801f28
  800313:	6a 2c                	push   $0x2c
  800315:	68 44 1e 80 00       	push   $0x801e44
  80031a:	e8 0a 02 00 00       	call   800529 <_panic>
	}

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80031f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800326:	e9 8b 00 00 00       	jmp    8003b6 <_main+0x37e>
	{
		arr[i] = -1 ;
  80032b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80032e:	05 40 30 80 00       	add    $0x803040,%eax
  800333:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  800336:	a1 04 30 80 00       	mov    0x803004,%eax
  80033b:	8b 15 00 30 80 00    	mov    0x803000,%edx
  800341:	8a 12                	mov    (%edx),%dl
  800343:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800345:	a1 00 30 80 00       	mov    0x803000,%eax
  80034a:	40                   	inc    %eax
  80034b:	a3 00 30 80 00       	mov    %eax,0x803000
  800350:	a1 04 30 80 00       	mov    0x803004,%eax
  800355:	40                   	inc    %eax
  800356:	a3 04 30 80 00       	mov    %eax,0x803004
		if(i == 6)
  80035b:	83 7d f4 06          	cmpl   $0x6,-0xc(%ebp)
  80035f:	75 4e                	jne    8003af <_main+0x377>
		{
			//cprintf("Checking Allocation in Mem & Page File... \n");
			//After freeing WS for the the second time called, then 1 frame taken be arr[6] and 6 frames are become free
			{
				if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800361:	e8 f0 13 00 00       	call   801756 <sys_pf_calculate_allocated_pages>
  800366:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  800369:	74 14                	je     80037f <_main+0x347>
  80036b:	83 ec 04             	sub    $0x4,%esp
  80036e:	68 bc 1e 80 00       	push   $0x801ebc
  800373:	6a 3f                	push   $0x3f
  800375:	68 44 1e 80 00       	push   $0x801e44
  80037a:	e8 aa 01 00 00       	call   800529 <_panic>
				uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  80037f:	e8 4f 13 00 00       	call   8016d3 <sys_calculate_free_frames>
  800384:	89 c3                	mov    %eax,%ebx
  800386:	e8 61 13 00 00       	call   8016ec <sys_calculate_modified_frames>
  80038b:	01 d8                	add    %ebx,%eax
  80038d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
				if( (freePages - freePagesAfter) != -6 )
  800390:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800393:	2b 45 b4             	sub    -0x4c(%ebp),%eax
  800396:	83 f8 fa             	cmp    $0xfffffffa,%eax
  800399:	74 14                	je     8003af <_main+0x377>
					panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80039b:	83 ec 04             	sub    $0x4,%esp
  80039e:	68 28 1f 80 00       	push   $0x801f28
  8003a3:	6a 42                	push   $0x42
  8003a5:	68 44 1e 80 00       	push   $0x801e44
  8003aa:	e8 7a 01 00 00       	call   800529 <_panic>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
	}

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8003af:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8003b6:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8003bd:	0f 8e 68 ff ff ff    	jle    80032b <_main+0x2f3>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8003c3:	e8 8e 13 00 00       	call   801756 <sys_pf_calculate_allocated_pages>
  8003c8:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  8003cb:	74 14                	je     8003e1 <_main+0x3a9>
  8003cd:	83 ec 04             	sub    $0x4,%esp
  8003d0:	68 bc 1e 80 00       	push   $0x801ebc
  8003d5:	6a 4b                	push   $0x4b
  8003d7:	68 44 1e 80 00       	push   $0x801e44
  8003dc:	e8 48 01 00 00       	call   800529 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8003e1:	e8 ed 12 00 00       	call   8016d3 <sys_calculate_free_frames>
  8003e6:	89 c3                	mov    %eax,%ebx
  8003e8:	e8 ff 12 00 00       	call   8016ec <sys_calculate_modified_frames>
  8003ed:	01 d8                	add    %ebx,%eax
  8003ef:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if( (freePages - freePagesAfter) != -2 )
  8003f2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8003f5:	2b 45 b0             	sub    -0x50(%ebp),%eax
  8003f8:	83 f8 fe             	cmp    $0xfffffffe,%eax
  8003fb:	74 14                	je     800411 <_main+0x3d9>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  8003fd:	83 ec 04             	sub    $0x4,%esp
  800400:	68 28 1f 80 00       	push   $0x801f28
  800405:	6a 4f                	push   $0x4f
  800407:	68 44 1e 80 00       	push   $0x801e44
  80040c:	e8 18 01 00 00       	call   800529 <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING RAPID PROCESS 1] is completed successfully.\n");
  800411:	83 ec 0c             	sub    $0xc,%esp
  800414:	68 a4 1f 80 00       	push   $0x801fa4
  800419:	e8 bf 03 00 00       	call   8007dd <cprintf>
  80041e:	83 c4 10             	add    $0x10,%esp
	return;
  800421:	90                   	nop
}
  800422:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800425:	c9                   	leave  
  800426:	c3                   	ret    

00800427 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800427:	55                   	push   %ebp
  800428:	89 e5                	mov    %esp,%ebp
  80042a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80042d:	e8 d6 11 00 00       	call   801608 <sys_getenvindex>
  800432:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800435:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800438:	89 d0                	mov    %edx,%eax
  80043a:	01 c0                	add    %eax,%eax
  80043c:	01 d0                	add    %edx,%eax
  80043e:	c1 e0 02             	shl    $0x2,%eax
  800441:	01 d0                	add    %edx,%eax
  800443:	c1 e0 06             	shl    $0x6,%eax
  800446:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80044b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800450:	a1 20 30 80 00       	mov    0x803020,%eax
  800455:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80045b:	84 c0                	test   %al,%al
  80045d:	74 0f                	je     80046e <libmain+0x47>
		binaryname = myEnv->prog_name;
  80045f:	a1 20 30 80 00       	mov    0x803020,%eax
  800464:	05 f4 02 00 00       	add    $0x2f4,%eax
  800469:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80046e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800472:	7e 0a                	jle    80047e <libmain+0x57>
		binaryname = argv[0];
  800474:	8b 45 0c             	mov    0xc(%ebp),%eax
  800477:	8b 00                	mov    (%eax),%eax
  800479:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80047e:	83 ec 08             	sub    $0x8,%esp
  800481:	ff 75 0c             	pushl  0xc(%ebp)
  800484:	ff 75 08             	pushl  0x8(%ebp)
  800487:	e8 ac fb ff ff       	call   800038 <_main>
  80048c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80048f:	e8 0f 13 00 00       	call   8017a3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800494:	83 ec 0c             	sub    $0xc,%esp
  800497:	68 1c 20 80 00       	push   $0x80201c
  80049c:	e8 3c 03 00 00       	call   8007dd <cprintf>
  8004a1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a9:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8004af:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b4:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8004ba:	83 ec 04             	sub    $0x4,%esp
  8004bd:	52                   	push   %edx
  8004be:	50                   	push   %eax
  8004bf:	68 44 20 80 00       	push   $0x802044
  8004c4:	e8 14 03 00 00       	call   8007dd <cprintf>
  8004c9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004cc:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d1:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8004d7:	83 ec 08             	sub    $0x8,%esp
  8004da:	50                   	push   %eax
  8004db:	68 69 20 80 00       	push   $0x802069
  8004e0:	e8 f8 02 00 00       	call   8007dd <cprintf>
  8004e5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004e8:	83 ec 0c             	sub    $0xc,%esp
  8004eb:	68 1c 20 80 00       	push   $0x80201c
  8004f0:	e8 e8 02 00 00       	call   8007dd <cprintf>
  8004f5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004f8:	e8 c0 12 00 00       	call   8017bd <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004fd:	e8 19 00 00 00       	call   80051b <exit>
}
  800502:	90                   	nop
  800503:	c9                   	leave  
  800504:	c3                   	ret    

00800505 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800505:	55                   	push   %ebp
  800506:	89 e5                	mov    %esp,%ebp
  800508:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80050b:	83 ec 0c             	sub    $0xc,%esp
  80050e:	6a 00                	push   $0x0
  800510:	e8 bf 10 00 00       	call   8015d4 <sys_env_destroy>
  800515:	83 c4 10             	add    $0x10,%esp
}
  800518:	90                   	nop
  800519:	c9                   	leave  
  80051a:	c3                   	ret    

0080051b <exit>:

void
exit(void)
{
  80051b:	55                   	push   %ebp
  80051c:	89 e5                	mov    %esp,%ebp
  80051e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800521:	e8 14 11 00 00       	call   80163a <sys_env_exit>
}
  800526:	90                   	nop
  800527:	c9                   	leave  
  800528:	c3                   	ret    

00800529 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800529:	55                   	push   %ebp
  80052a:	89 e5                	mov    %esp,%ebp
  80052c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80052f:	8d 45 10             	lea    0x10(%ebp),%eax
  800532:	83 c0 04             	add    $0x4,%eax
  800535:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800538:	a1 48 f0 80 00       	mov    0x80f048,%eax
  80053d:	85 c0                	test   %eax,%eax
  80053f:	74 16                	je     800557 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800541:	a1 48 f0 80 00       	mov    0x80f048,%eax
  800546:	83 ec 08             	sub    $0x8,%esp
  800549:	50                   	push   %eax
  80054a:	68 80 20 80 00       	push   $0x802080
  80054f:	e8 89 02 00 00       	call   8007dd <cprintf>
  800554:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800557:	a1 08 30 80 00       	mov    0x803008,%eax
  80055c:	ff 75 0c             	pushl  0xc(%ebp)
  80055f:	ff 75 08             	pushl  0x8(%ebp)
  800562:	50                   	push   %eax
  800563:	68 85 20 80 00       	push   $0x802085
  800568:	e8 70 02 00 00       	call   8007dd <cprintf>
  80056d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800570:	8b 45 10             	mov    0x10(%ebp),%eax
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	ff 75 f4             	pushl  -0xc(%ebp)
  800579:	50                   	push   %eax
  80057a:	e8 f3 01 00 00       	call   800772 <vcprintf>
  80057f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800582:	83 ec 08             	sub    $0x8,%esp
  800585:	6a 00                	push   $0x0
  800587:	68 a1 20 80 00       	push   $0x8020a1
  80058c:	e8 e1 01 00 00       	call   800772 <vcprintf>
  800591:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800594:	e8 82 ff ff ff       	call   80051b <exit>

	// should not return here
	while (1) ;
  800599:	eb fe                	jmp    800599 <_panic+0x70>

0080059b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80059b:	55                   	push   %ebp
  80059c:	89 e5                	mov    %esp,%ebp
  80059e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8005a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a6:	8b 50 74             	mov    0x74(%eax),%edx
  8005a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ac:	39 c2                	cmp    %eax,%edx
  8005ae:	74 14                	je     8005c4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005b0:	83 ec 04             	sub    $0x4,%esp
  8005b3:	68 a4 20 80 00       	push   $0x8020a4
  8005b8:	6a 26                	push   $0x26
  8005ba:	68 f0 20 80 00       	push   $0x8020f0
  8005bf:	e8 65 ff ff ff       	call   800529 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005d2:	e9 c2 00 00 00       	jmp    800699 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8005d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e4:	01 d0                	add    %edx,%eax
  8005e6:	8b 00                	mov    (%eax),%eax
  8005e8:	85 c0                	test   %eax,%eax
  8005ea:	75 08                	jne    8005f4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005ec:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005ef:	e9 a2 00 00 00       	jmp    800696 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8005f4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005fb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800602:	eb 69                	jmp    80066d <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800604:	a1 20 30 80 00       	mov    0x803020,%eax
  800609:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80060f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800612:	89 d0                	mov    %edx,%eax
  800614:	01 c0                	add    %eax,%eax
  800616:	01 d0                	add    %edx,%eax
  800618:	c1 e0 02             	shl    $0x2,%eax
  80061b:	01 c8                	add    %ecx,%eax
  80061d:	8a 40 04             	mov    0x4(%eax),%al
  800620:	84 c0                	test   %al,%al
  800622:	75 46                	jne    80066a <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800624:	a1 20 30 80 00       	mov    0x803020,%eax
  800629:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80062f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800632:	89 d0                	mov    %edx,%eax
  800634:	01 c0                	add    %eax,%eax
  800636:	01 d0                	add    %edx,%eax
  800638:	c1 e0 02             	shl    $0x2,%eax
  80063b:	01 c8                	add    %ecx,%eax
  80063d:	8b 00                	mov    (%eax),%eax
  80063f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800642:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800645:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80064a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80064c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80064f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	01 c8                	add    %ecx,%eax
  80065b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80065d:	39 c2                	cmp    %eax,%edx
  80065f:	75 09                	jne    80066a <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800661:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800668:	eb 12                	jmp    80067c <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80066a:	ff 45 e8             	incl   -0x18(%ebp)
  80066d:	a1 20 30 80 00       	mov    0x803020,%eax
  800672:	8b 50 74             	mov    0x74(%eax),%edx
  800675:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800678:	39 c2                	cmp    %eax,%edx
  80067a:	77 88                	ja     800604 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80067c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800680:	75 14                	jne    800696 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800682:	83 ec 04             	sub    $0x4,%esp
  800685:	68 fc 20 80 00       	push   $0x8020fc
  80068a:	6a 3a                	push   $0x3a
  80068c:	68 f0 20 80 00       	push   $0x8020f0
  800691:	e8 93 fe ff ff       	call   800529 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800696:	ff 45 f0             	incl   -0x10(%ebp)
  800699:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80069f:	0f 8c 32 ff ff ff    	jl     8005d7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006ac:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006b3:	eb 26                	jmp    8006db <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ba:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8006c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c3:	89 d0                	mov    %edx,%eax
  8006c5:	01 c0                	add    %eax,%eax
  8006c7:	01 d0                	add    %edx,%eax
  8006c9:	c1 e0 02             	shl    $0x2,%eax
  8006cc:	01 c8                	add    %ecx,%eax
  8006ce:	8a 40 04             	mov    0x4(%eax),%al
  8006d1:	3c 01                	cmp    $0x1,%al
  8006d3:	75 03                	jne    8006d8 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8006d5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006d8:	ff 45 e0             	incl   -0x20(%ebp)
  8006db:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e0:	8b 50 74             	mov    0x74(%eax),%edx
  8006e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006e6:	39 c2                	cmp    %eax,%edx
  8006e8:	77 cb                	ja     8006b5 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ed:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006f0:	74 14                	je     800706 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8006f2:	83 ec 04             	sub    $0x4,%esp
  8006f5:	68 50 21 80 00       	push   $0x802150
  8006fa:	6a 44                	push   $0x44
  8006fc:	68 f0 20 80 00       	push   $0x8020f0
  800701:	e8 23 fe ff ff       	call   800529 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80070f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800712:	8b 00                	mov    (%eax),%eax
  800714:	8d 48 01             	lea    0x1(%eax),%ecx
  800717:	8b 55 0c             	mov    0xc(%ebp),%edx
  80071a:	89 0a                	mov    %ecx,(%edx)
  80071c:	8b 55 08             	mov    0x8(%ebp),%edx
  80071f:	88 d1                	mov    %dl,%cl
  800721:	8b 55 0c             	mov    0xc(%ebp),%edx
  800724:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800728:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072b:	8b 00                	mov    (%eax),%eax
  80072d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800732:	75 2c                	jne    800760 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800734:	a0 24 30 80 00       	mov    0x803024,%al
  800739:	0f b6 c0             	movzbl %al,%eax
  80073c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80073f:	8b 12                	mov    (%edx),%edx
  800741:	89 d1                	mov    %edx,%ecx
  800743:	8b 55 0c             	mov    0xc(%ebp),%edx
  800746:	83 c2 08             	add    $0x8,%edx
  800749:	83 ec 04             	sub    $0x4,%esp
  80074c:	50                   	push   %eax
  80074d:	51                   	push   %ecx
  80074e:	52                   	push   %edx
  80074f:	e8 3e 0e 00 00       	call   801592 <sys_cputs>
  800754:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800757:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800760:	8b 45 0c             	mov    0xc(%ebp),%eax
  800763:	8b 40 04             	mov    0x4(%eax),%eax
  800766:	8d 50 01             	lea    0x1(%eax),%edx
  800769:	8b 45 0c             	mov    0xc(%ebp),%eax
  80076c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80076f:	90                   	nop
  800770:	c9                   	leave  
  800771:	c3                   	ret    

00800772 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800772:	55                   	push   %ebp
  800773:	89 e5                	mov    %esp,%ebp
  800775:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80077b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800782:	00 00 00 
	b.cnt = 0;
  800785:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80078c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	ff 75 08             	pushl  0x8(%ebp)
  800795:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80079b:	50                   	push   %eax
  80079c:	68 09 07 80 00       	push   $0x800709
  8007a1:	e8 11 02 00 00       	call   8009b7 <vprintfmt>
  8007a6:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007a9:	a0 24 30 80 00       	mov    0x803024,%al
  8007ae:	0f b6 c0             	movzbl %al,%eax
  8007b1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007b7:	83 ec 04             	sub    $0x4,%esp
  8007ba:	50                   	push   %eax
  8007bb:	52                   	push   %edx
  8007bc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007c2:	83 c0 08             	add    $0x8,%eax
  8007c5:	50                   	push   %eax
  8007c6:	e8 c7 0d 00 00       	call   801592 <sys_cputs>
  8007cb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007ce:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007d5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007db:	c9                   	leave  
  8007dc:	c3                   	ret    

008007dd <cprintf>:

int cprintf(const char *fmt, ...) {
  8007dd:	55                   	push   %ebp
  8007de:	89 e5                	mov    %esp,%ebp
  8007e0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007e3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007ea:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f3:	83 ec 08             	sub    $0x8,%esp
  8007f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f9:	50                   	push   %eax
  8007fa:	e8 73 ff ff ff       	call   800772 <vcprintf>
  8007ff:	83 c4 10             	add    $0x10,%esp
  800802:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800805:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800808:	c9                   	leave  
  800809:	c3                   	ret    

0080080a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80080a:	55                   	push   %ebp
  80080b:	89 e5                	mov    %esp,%ebp
  80080d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800810:	e8 8e 0f 00 00       	call   8017a3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800815:	8d 45 0c             	lea    0xc(%ebp),%eax
  800818:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80081b:	8b 45 08             	mov    0x8(%ebp),%eax
  80081e:	83 ec 08             	sub    $0x8,%esp
  800821:	ff 75 f4             	pushl  -0xc(%ebp)
  800824:	50                   	push   %eax
  800825:	e8 48 ff ff ff       	call   800772 <vcprintf>
  80082a:	83 c4 10             	add    $0x10,%esp
  80082d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800830:	e8 88 0f 00 00       	call   8017bd <sys_enable_interrupt>
	return cnt;
  800835:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800838:	c9                   	leave  
  800839:	c3                   	ret    

0080083a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80083a:	55                   	push   %ebp
  80083b:	89 e5                	mov    %esp,%ebp
  80083d:	53                   	push   %ebx
  80083e:	83 ec 14             	sub    $0x14,%esp
  800841:	8b 45 10             	mov    0x10(%ebp),%eax
  800844:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800847:	8b 45 14             	mov    0x14(%ebp),%eax
  80084a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80084d:	8b 45 18             	mov    0x18(%ebp),%eax
  800850:	ba 00 00 00 00       	mov    $0x0,%edx
  800855:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800858:	77 55                	ja     8008af <printnum+0x75>
  80085a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80085d:	72 05                	jb     800864 <printnum+0x2a>
  80085f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800862:	77 4b                	ja     8008af <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800864:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800867:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80086a:	8b 45 18             	mov    0x18(%ebp),%eax
  80086d:	ba 00 00 00 00       	mov    $0x0,%edx
  800872:	52                   	push   %edx
  800873:	50                   	push   %eax
  800874:	ff 75 f4             	pushl  -0xc(%ebp)
  800877:	ff 75 f0             	pushl  -0x10(%ebp)
  80087a:	e8 05 13 00 00       	call   801b84 <__udivdi3>
  80087f:	83 c4 10             	add    $0x10,%esp
  800882:	83 ec 04             	sub    $0x4,%esp
  800885:	ff 75 20             	pushl  0x20(%ebp)
  800888:	53                   	push   %ebx
  800889:	ff 75 18             	pushl  0x18(%ebp)
  80088c:	52                   	push   %edx
  80088d:	50                   	push   %eax
  80088e:	ff 75 0c             	pushl  0xc(%ebp)
  800891:	ff 75 08             	pushl  0x8(%ebp)
  800894:	e8 a1 ff ff ff       	call   80083a <printnum>
  800899:	83 c4 20             	add    $0x20,%esp
  80089c:	eb 1a                	jmp    8008b8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80089e:	83 ec 08             	sub    $0x8,%esp
  8008a1:	ff 75 0c             	pushl  0xc(%ebp)
  8008a4:	ff 75 20             	pushl  0x20(%ebp)
  8008a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008aa:	ff d0                	call   *%eax
  8008ac:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008af:	ff 4d 1c             	decl   0x1c(%ebp)
  8008b2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008b6:	7f e6                	jg     80089e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008b8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008bb:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c6:	53                   	push   %ebx
  8008c7:	51                   	push   %ecx
  8008c8:	52                   	push   %edx
  8008c9:	50                   	push   %eax
  8008ca:	e8 c5 13 00 00       	call   801c94 <__umoddi3>
  8008cf:	83 c4 10             	add    $0x10,%esp
  8008d2:	05 b4 23 80 00       	add    $0x8023b4,%eax
  8008d7:	8a 00                	mov    (%eax),%al
  8008d9:	0f be c0             	movsbl %al,%eax
  8008dc:	83 ec 08             	sub    $0x8,%esp
  8008df:	ff 75 0c             	pushl  0xc(%ebp)
  8008e2:	50                   	push   %eax
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	ff d0                	call   *%eax
  8008e8:	83 c4 10             	add    $0x10,%esp
}
  8008eb:	90                   	nop
  8008ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008ef:	c9                   	leave  
  8008f0:	c3                   	ret    

008008f1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008f1:	55                   	push   %ebp
  8008f2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008f4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008f8:	7e 1c                	jle    800916 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	8b 00                	mov    (%eax),%eax
  8008ff:	8d 50 08             	lea    0x8(%eax),%edx
  800902:	8b 45 08             	mov    0x8(%ebp),%eax
  800905:	89 10                	mov    %edx,(%eax)
  800907:	8b 45 08             	mov    0x8(%ebp),%eax
  80090a:	8b 00                	mov    (%eax),%eax
  80090c:	83 e8 08             	sub    $0x8,%eax
  80090f:	8b 50 04             	mov    0x4(%eax),%edx
  800912:	8b 00                	mov    (%eax),%eax
  800914:	eb 40                	jmp    800956 <getuint+0x65>
	else if (lflag)
  800916:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80091a:	74 1e                	je     80093a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80091c:	8b 45 08             	mov    0x8(%ebp),%eax
  80091f:	8b 00                	mov    (%eax),%eax
  800921:	8d 50 04             	lea    0x4(%eax),%edx
  800924:	8b 45 08             	mov    0x8(%ebp),%eax
  800927:	89 10                	mov    %edx,(%eax)
  800929:	8b 45 08             	mov    0x8(%ebp),%eax
  80092c:	8b 00                	mov    (%eax),%eax
  80092e:	83 e8 04             	sub    $0x4,%eax
  800931:	8b 00                	mov    (%eax),%eax
  800933:	ba 00 00 00 00       	mov    $0x0,%edx
  800938:	eb 1c                	jmp    800956 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80093a:	8b 45 08             	mov    0x8(%ebp),%eax
  80093d:	8b 00                	mov    (%eax),%eax
  80093f:	8d 50 04             	lea    0x4(%eax),%edx
  800942:	8b 45 08             	mov    0x8(%ebp),%eax
  800945:	89 10                	mov    %edx,(%eax)
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	8b 00                	mov    (%eax),%eax
  80094c:	83 e8 04             	sub    $0x4,%eax
  80094f:	8b 00                	mov    (%eax),%eax
  800951:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800956:	5d                   	pop    %ebp
  800957:	c3                   	ret    

00800958 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800958:	55                   	push   %ebp
  800959:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80095b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80095f:	7e 1c                	jle    80097d <getint+0x25>
		return va_arg(*ap, long long);
  800961:	8b 45 08             	mov    0x8(%ebp),%eax
  800964:	8b 00                	mov    (%eax),%eax
  800966:	8d 50 08             	lea    0x8(%eax),%edx
  800969:	8b 45 08             	mov    0x8(%ebp),%eax
  80096c:	89 10                	mov    %edx,(%eax)
  80096e:	8b 45 08             	mov    0x8(%ebp),%eax
  800971:	8b 00                	mov    (%eax),%eax
  800973:	83 e8 08             	sub    $0x8,%eax
  800976:	8b 50 04             	mov    0x4(%eax),%edx
  800979:	8b 00                	mov    (%eax),%eax
  80097b:	eb 38                	jmp    8009b5 <getint+0x5d>
	else if (lflag)
  80097d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800981:	74 1a                	je     80099d <getint+0x45>
		return va_arg(*ap, long);
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	8b 00                	mov    (%eax),%eax
  800988:	8d 50 04             	lea    0x4(%eax),%edx
  80098b:	8b 45 08             	mov    0x8(%ebp),%eax
  80098e:	89 10                	mov    %edx,(%eax)
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	8b 00                	mov    (%eax),%eax
  800995:	83 e8 04             	sub    $0x4,%eax
  800998:	8b 00                	mov    (%eax),%eax
  80099a:	99                   	cltd   
  80099b:	eb 18                	jmp    8009b5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80099d:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a0:	8b 00                	mov    (%eax),%eax
  8009a2:	8d 50 04             	lea    0x4(%eax),%edx
  8009a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a8:	89 10                	mov    %edx,(%eax)
  8009aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ad:	8b 00                	mov    (%eax),%eax
  8009af:	83 e8 04             	sub    $0x4,%eax
  8009b2:	8b 00                	mov    (%eax),%eax
  8009b4:	99                   	cltd   
}
  8009b5:	5d                   	pop    %ebp
  8009b6:	c3                   	ret    

008009b7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009b7:	55                   	push   %ebp
  8009b8:	89 e5                	mov    %esp,%ebp
  8009ba:	56                   	push   %esi
  8009bb:	53                   	push   %ebx
  8009bc:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009bf:	eb 17                	jmp    8009d8 <vprintfmt+0x21>
			if (ch == '\0')
  8009c1:	85 db                	test   %ebx,%ebx
  8009c3:	0f 84 af 03 00 00    	je     800d78 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009c9:	83 ec 08             	sub    $0x8,%esp
  8009cc:	ff 75 0c             	pushl  0xc(%ebp)
  8009cf:	53                   	push   %ebx
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	ff d0                	call   *%eax
  8009d5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009db:	8d 50 01             	lea    0x1(%eax),%edx
  8009de:	89 55 10             	mov    %edx,0x10(%ebp)
  8009e1:	8a 00                	mov    (%eax),%al
  8009e3:	0f b6 d8             	movzbl %al,%ebx
  8009e6:	83 fb 25             	cmp    $0x25,%ebx
  8009e9:	75 d6                	jne    8009c1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009eb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009ef:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009f6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009fd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a04:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a0e:	8d 50 01             	lea    0x1(%eax),%edx
  800a11:	89 55 10             	mov    %edx,0x10(%ebp)
  800a14:	8a 00                	mov    (%eax),%al
  800a16:	0f b6 d8             	movzbl %al,%ebx
  800a19:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a1c:	83 f8 55             	cmp    $0x55,%eax
  800a1f:	0f 87 2b 03 00 00    	ja     800d50 <vprintfmt+0x399>
  800a25:	8b 04 85 d8 23 80 00 	mov    0x8023d8(,%eax,4),%eax
  800a2c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a2e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a32:	eb d7                	jmp    800a0b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a34:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a38:	eb d1                	jmp    800a0b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a3a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a41:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a44:	89 d0                	mov    %edx,%eax
  800a46:	c1 e0 02             	shl    $0x2,%eax
  800a49:	01 d0                	add    %edx,%eax
  800a4b:	01 c0                	add    %eax,%eax
  800a4d:	01 d8                	add    %ebx,%eax
  800a4f:	83 e8 30             	sub    $0x30,%eax
  800a52:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a55:	8b 45 10             	mov    0x10(%ebp),%eax
  800a58:	8a 00                	mov    (%eax),%al
  800a5a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a5d:	83 fb 2f             	cmp    $0x2f,%ebx
  800a60:	7e 3e                	jle    800aa0 <vprintfmt+0xe9>
  800a62:	83 fb 39             	cmp    $0x39,%ebx
  800a65:	7f 39                	jg     800aa0 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a67:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a6a:	eb d5                	jmp    800a41 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6f:	83 c0 04             	add    $0x4,%eax
  800a72:	89 45 14             	mov    %eax,0x14(%ebp)
  800a75:	8b 45 14             	mov    0x14(%ebp),%eax
  800a78:	83 e8 04             	sub    $0x4,%eax
  800a7b:	8b 00                	mov    (%eax),%eax
  800a7d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a80:	eb 1f                	jmp    800aa1 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a82:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a86:	79 83                	jns    800a0b <vprintfmt+0x54>
				width = 0;
  800a88:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a8f:	e9 77 ff ff ff       	jmp    800a0b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a94:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a9b:	e9 6b ff ff ff       	jmp    800a0b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800aa0:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800aa1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa5:	0f 89 60 ff ff ff    	jns    800a0b <vprintfmt+0x54>
				width = precision, precision = -1;
  800aab:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ab1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ab8:	e9 4e ff ff ff       	jmp    800a0b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800abd:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ac0:	e9 46 ff ff ff       	jmp    800a0b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ac5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac8:	83 c0 04             	add    $0x4,%eax
  800acb:	89 45 14             	mov    %eax,0x14(%ebp)
  800ace:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad1:	83 e8 04             	sub    $0x4,%eax
  800ad4:	8b 00                	mov    (%eax),%eax
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	50                   	push   %eax
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	ff d0                	call   *%eax
  800ae2:	83 c4 10             	add    $0x10,%esp
			break;
  800ae5:	e9 89 02 00 00       	jmp    800d73 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800aea:	8b 45 14             	mov    0x14(%ebp),%eax
  800aed:	83 c0 04             	add    $0x4,%eax
  800af0:	89 45 14             	mov    %eax,0x14(%ebp)
  800af3:	8b 45 14             	mov    0x14(%ebp),%eax
  800af6:	83 e8 04             	sub    $0x4,%eax
  800af9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800afb:	85 db                	test   %ebx,%ebx
  800afd:	79 02                	jns    800b01 <vprintfmt+0x14a>
				err = -err;
  800aff:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b01:	83 fb 64             	cmp    $0x64,%ebx
  800b04:	7f 0b                	jg     800b11 <vprintfmt+0x15a>
  800b06:	8b 34 9d 20 22 80 00 	mov    0x802220(,%ebx,4),%esi
  800b0d:	85 f6                	test   %esi,%esi
  800b0f:	75 19                	jne    800b2a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b11:	53                   	push   %ebx
  800b12:	68 c5 23 80 00       	push   $0x8023c5
  800b17:	ff 75 0c             	pushl  0xc(%ebp)
  800b1a:	ff 75 08             	pushl  0x8(%ebp)
  800b1d:	e8 5e 02 00 00       	call   800d80 <printfmt>
  800b22:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b25:	e9 49 02 00 00       	jmp    800d73 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b2a:	56                   	push   %esi
  800b2b:	68 ce 23 80 00       	push   $0x8023ce
  800b30:	ff 75 0c             	pushl  0xc(%ebp)
  800b33:	ff 75 08             	pushl  0x8(%ebp)
  800b36:	e8 45 02 00 00       	call   800d80 <printfmt>
  800b3b:	83 c4 10             	add    $0x10,%esp
			break;
  800b3e:	e9 30 02 00 00       	jmp    800d73 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b43:	8b 45 14             	mov    0x14(%ebp),%eax
  800b46:	83 c0 04             	add    $0x4,%eax
  800b49:	89 45 14             	mov    %eax,0x14(%ebp)
  800b4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4f:	83 e8 04             	sub    $0x4,%eax
  800b52:	8b 30                	mov    (%eax),%esi
  800b54:	85 f6                	test   %esi,%esi
  800b56:	75 05                	jne    800b5d <vprintfmt+0x1a6>
				p = "(null)";
  800b58:	be d1 23 80 00       	mov    $0x8023d1,%esi
			if (width > 0 && padc != '-')
  800b5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b61:	7e 6d                	jle    800bd0 <vprintfmt+0x219>
  800b63:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b67:	74 67                	je     800bd0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b69:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	50                   	push   %eax
  800b70:	56                   	push   %esi
  800b71:	e8 0c 03 00 00       	call   800e82 <strnlen>
  800b76:	83 c4 10             	add    $0x10,%esp
  800b79:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b7c:	eb 16                	jmp    800b94 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b7e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b82:	83 ec 08             	sub    $0x8,%esp
  800b85:	ff 75 0c             	pushl  0xc(%ebp)
  800b88:	50                   	push   %eax
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	ff d0                	call   *%eax
  800b8e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b91:	ff 4d e4             	decl   -0x1c(%ebp)
  800b94:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b98:	7f e4                	jg     800b7e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b9a:	eb 34                	jmp    800bd0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b9c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ba0:	74 1c                	je     800bbe <vprintfmt+0x207>
  800ba2:	83 fb 1f             	cmp    $0x1f,%ebx
  800ba5:	7e 05                	jle    800bac <vprintfmt+0x1f5>
  800ba7:	83 fb 7e             	cmp    $0x7e,%ebx
  800baa:	7e 12                	jle    800bbe <vprintfmt+0x207>
					putch('?', putdat);
  800bac:	83 ec 08             	sub    $0x8,%esp
  800baf:	ff 75 0c             	pushl  0xc(%ebp)
  800bb2:	6a 3f                	push   $0x3f
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	ff d0                	call   *%eax
  800bb9:	83 c4 10             	add    $0x10,%esp
  800bbc:	eb 0f                	jmp    800bcd <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bbe:	83 ec 08             	sub    $0x8,%esp
  800bc1:	ff 75 0c             	pushl  0xc(%ebp)
  800bc4:	53                   	push   %ebx
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	ff d0                	call   *%eax
  800bca:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bcd:	ff 4d e4             	decl   -0x1c(%ebp)
  800bd0:	89 f0                	mov    %esi,%eax
  800bd2:	8d 70 01             	lea    0x1(%eax),%esi
  800bd5:	8a 00                	mov    (%eax),%al
  800bd7:	0f be d8             	movsbl %al,%ebx
  800bda:	85 db                	test   %ebx,%ebx
  800bdc:	74 24                	je     800c02 <vprintfmt+0x24b>
  800bde:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800be2:	78 b8                	js     800b9c <vprintfmt+0x1e5>
  800be4:	ff 4d e0             	decl   -0x20(%ebp)
  800be7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800beb:	79 af                	jns    800b9c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bed:	eb 13                	jmp    800c02 <vprintfmt+0x24b>
				putch(' ', putdat);
  800bef:	83 ec 08             	sub    $0x8,%esp
  800bf2:	ff 75 0c             	pushl  0xc(%ebp)
  800bf5:	6a 20                	push   $0x20
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	ff d0                	call   *%eax
  800bfc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bff:	ff 4d e4             	decl   -0x1c(%ebp)
  800c02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c06:	7f e7                	jg     800bef <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c08:	e9 66 01 00 00       	jmp    800d73 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c0d:	83 ec 08             	sub    $0x8,%esp
  800c10:	ff 75 e8             	pushl  -0x18(%ebp)
  800c13:	8d 45 14             	lea    0x14(%ebp),%eax
  800c16:	50                   	push   %eax
  800c17:	e8 3c fd ff ff       	call   800958 <getint>
  800c1c:	83 c4 10             	add    $0x10,%esp
  800c1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c25:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c28:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c2b:	85 d2                	test   %edx,%edx
  800c2d:	79 23                	jns    800c52 <vprintfmt+0x29b>
				putch('-', putdat);
  800c2f:	83 ec 08             	sub    $0x8,%esp
  800c32:	ff 75 0c             	pushl  0xc(%ebp)
  800c35:	6a 2d                	push   $0x2d
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	ff d0                	call   *%eax
  800c3c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c45:	f7 d8                	neg    %eax
  800c47:	83 d2 00             	adc    $0x0,%edx
  800c4a:	f7 da                	neg    %edx
  800c4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c52:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c59:	e9 bc 00 00 00       	jmp    800d1a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c5e:	83 ec 08             	sub    $0x8,%esp
  800c61:	ff 75 e8             	pushl  -0x18(%ebp)
  800c64:	8d 45 14             	lea    0x14(%ebp),%eax
  800c67:	50                   	push   %eax
  800c68:	e8 84 fc ff ff       	call   8008f1 <getuint>
  800c6d:	83 c4 10             	add    $0x10,%esp
  800c70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c73:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c76:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c7d:	e9 98 00 00 00       	jmp    800d1a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c82:	83 ec 08             	sub    $0x8,%esp
  800c85:	ff 75 0c             	pushl  0xc(%ebp)
  800c88:	6a 58                	push   $0x58
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	ff d0                	call   *%eax
  800c8f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c92:	83 ec 08             	sub    $0x8,%esp
  800c95:	ff 75 0c             	pushl  0xc(%ebp)
  800c98:	6a 58                	push   $0x58
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	ff d0                	call   *%eax
  800c9f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ca2:	83 ec 08             	sub    $0x8,%esp
  800ca5:	ff 75 0c             	pushl  0xc(%ebp)
  800ca8:	6a 58                	push   $0x58
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	ff d0                	call   *%eax
  800caf:	83 c4 10             	add    $0x10,%esp
			break;
  800cb2:	e9 bc 00 00 00       	jmp    800d73 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800cb7:	83 ec 08             	sub    $0x8,%esp
  800cba:	ff 75 0c             	pushl  0xc(%ebp)
  800cbd:	6a 30                	push   $0x30
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	ff d0                	call   *%eax
  800cc4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cc7:	83 ec 08             	sub    $0x8,%esp
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	6a 78                	push   $0x78
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	ff d0                	call   *%eax
  800cd4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cd7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cda:	83 c0 04             	add    $0x4,%eax
  800cdd:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce3:	83 e8 04             	sub    $0x4,%eax
  800ce6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ce8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ceb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cf2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800cf9:	eb 1f                	jmp    800d1a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800cfb:	83 ec 08             	sub    $0x8,%esp
  800cfe:	ff 75 e8             	pushl  -0x18(%ebp)
  800d01:	8d 45 14             	lea    0x14(%ebp),%eax
  800d04:	50                   	push   %eax
  800d05:	e8 e7 fb ff ff       	call   8008f1 <getuint>
  800d0a:	83 c4 10             	add    $0x10,%esp
  800d0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d10:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d13:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d1a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d21:	83 ec 04             	sub    $0x4,%esp
  800d24:	52                   	push   %edx
  800d25:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d28:	50                   	push   %eax
  800d29:	ff 75 f4             	pushl  -0xc(%ebp)
  800d2c:	ff 75 f0             	pushl  -0x10(%ebp)
  800d2f:	ff 75 0c             	pushl  0xc(%ebp)
  800d32:	ff 75 08             	pushl  0x8(%ebp)
  800d35:	e8 00 fb ff ff       	call   80083a <printnum>
  800d3a:	83 c4 20             	add    $0x20,%esp
			break;
  800d3d:	eb 34                	jmp    800d73 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d3f:	83 ec 08             	sub    $0x8,%esp
  800d42:	ff 75 0c             	pushl  0xc(%ebp)
  800d45:	53                   	push   %ebx
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	ff d0                	call   *%eax
  800d4b:	83 c4 10             	add    $0x10,%esp
			break;
  800d4e:	eb 23                	jmp    800d73 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d50:	83 ec 08             	sub    $0x8,%esp
  800d53:	ff 75 0c             	pushl  0xc(%ebp)
  800d56:	6a 25                	push   $0x25
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	ff d0                	call   *%eax
  800d5d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d60:	ff 4d 10             	decl   0x10(%ebp)
  800d63:	eb 03                	jmp    800d68 <vprintfmt+0x3b1>
  800d65:	ff 4d 10             	decl   0x10(%ebp)
  800d68:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6b:	48                   	dec    %eax
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	3c 25                	cmp    $0x25,%al
  800d70:	75 f3                	jne    800d65 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d72:	90                   	nop
		}
	}
  800d73:	e9 47 fc ff ff       	jmp    8009bf <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d78:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d79:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d7c:	5b                   	pop    %ebx
  800d7d:	5e                   	pop    %esi
  800d7e:	5d                   	pop    %ebp
  800d7f:	c3                   	ret    

00800d80 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d80:	55                   	push   %ebp
  800d81:	89 e5                	mov    %esp,%ebp
  800d83:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d86:	8d 45 10             	lea    0x10(%ebp),%eax
  800d89:	83 c0 04             	add    $0x4,%eax
  800d8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d92:	ff 75 f4             	pushl  -0xc(%ebp)
  800d95:	50                   	push   %eax
  800d96:	ff 75 0c             	pushl  0xc(%ebp)
  800d99:	ff 75 08             	pushl  0x8(%ebp)
  800d9c:	e8 16 fc ff ff       	call   8009b7 <vprintfmt>
  800da1:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800da4:	90                   	nop
  800da5:	c9                   	leave  
  800da6:	c3                   	ret    

00800da7 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800da7:	55                   	push   %ebp
  800da8:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dad:	8b 40 08             	mov    0x8(%eax),%eax
  800db0:	8d 50 01             	lea    0x1(%eax),%edx
  800db3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	8b 10                	mov    (%eax),%edx
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	8b 40 04             	mov    0x4(%eax),%eax
  800dc4:	39 c2                	cmp    %eax,%edx
  800dc6:	73 12                	jae    800dda <sprintputch+0x33>
		*b->buf++ = ch;
  800dc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcb:	8b 00                	mov    (%eax),%eax
  800dcd:	8d 48 01             	lea    0x1(%eax),%ecx
  800dd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd3:	89 0a                	mov    %ecx,(%edx)
  800dd5:	8b 55 08             	mov    0x8(%ebp),%edx
  800dd8:	88 10                	mov    %dl,(%eax)
}
  800dda:	90                   	nop
  800ddb:	5d                   	pop    %ebp
  800ddc:	c3                   	ret    

00800ddd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ddd:	55                   	push   %ebp
  800dde:	89 e5                	mov    %esp,%ebp
  800de0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800de9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dec:	8d 50 ff             	lea    -0x1(%eax),%edx
  800def:	8b 45 08             	mov    0x8(%ebp),%eax
  800df2:	01 d0                	add    %edx,%eax
  800df4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800dfe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e02:	74 06                	je     800e0a <vsnprintf+0x2d>
  800e04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e08:	7f 07                	jg     800e11 <vsnprintf+0x34>
		return -E_INVAL;
  800e0a:	b8 03 00 00 00       	mov    $0x3,%eax
  800e0f:	eb 20                	jmp    800e31 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e11:	ff 75 14             	pushl  0x14(%ebp)
  800e14:	ff 75 10             	pushl  0x10(%ebp)
  800e17:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e1a:	50                   	push   %eax
  800e1b:	68 a7 0d 80 00       	push   $0x800da7
  800e20:	e8 92 fb ff ff       	call   8009b7 <vprintfmt>
  800e25:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e28:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e2b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e31:	c9                   	leave  
  800e32:	c3                   	ret    

00800e33 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e33:	55                   	push   %ebp
  800e34:	89 e5                	mov    %esp,%ebp
  800e36:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e39:	8d 45 10             	lea    0x10(%ebp),%eax
  800e3c:	83 c0 04             	add    $0x4,%eax
  800e3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e42:	8b 45 10             	mov    0x10(%ebp),%eax
  800e45:	ff 75 f4             	pushl  -0xc(%ebp)
  800e48:	50                   	push   %eax
  800e49:	ff 75 0c             	pushl  0xc(%ebp)
  800e4c:	ff 75 08             	pushl  0x8(%ebp)
  800e4f:	e8 89 ff ff ff       	call   800ddd <vsnprintf>
  800e54:	83 c4 10             	add    $0x10,%esp
  800e57:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e5d:	c9                   	leave  
  800e5e:	c3                   	ret    

00800e5f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e5f:	55                   	push   %ebp
  800e60:	89 e5                	mov    %esp,%ebp
  800e62:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e65:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e6c:	eb 06                	jmp    800e74 <strlen+0x15>
		n++;
  800e6e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e71:	ff 45 08             	incl   0x8(%ebp)
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	84 c0                	test   %al,%al
  800e7b:	75 f1                	jne    800e6e <strlen+0xf>
		n++;
	return n;
  800e7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e80:	c9                   	leave  
  800e81:	c3                   	ret    

00800e82 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e82:	55                   	push   %ebp
  800e83:	89 e5                	mov    %esp,%ebp
  800e85:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e8f:	eb 09                	jmp    800e9a <strnlen+0x18>
		n++;
  800e91:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e94:	ff 45 08             	incl   0x8(%ebp)
  800e97:	ff 4d 0c             	decl   0xc(%ebp)
  800e9a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e9e:	74 09                	je     800ea9 <strnlen+0x27>
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	84 c0                	test   %al,%al
  800ea7:	75 e8                	jne    800e91 <strnlen+0xf>
		n++;
	return n;
  800ea9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eac:	c9                   	leave  
  800ead:	c3                   	ret    

00800eae <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
  800eb1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800eba:	90                   	nop
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	8d 50 01             	lea    0x1(%eax),%edx
  800ec1:	89 55 08             	mov    %edx,0x8(%ebp)
  800ec4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ec7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eca:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ecd:	8a 12                	mov    (%edx),%dl
  800ecf:	88 10                	mov    %dl,(%eax)
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	84 c0                	test   %al,%al
  800ed5:	75 e4                	jne    800ebb <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eda:	c9                   	leave  
  800edb:	c3                   	ret    

00800edc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800edc:	55                   	push   %ebp
  800edd:	89 e5                	mov    %esp,%ebp
  800edf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ee8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eef:	eb 1f                	jmp    800f10 <strncpy+0x34>
		*dst++ = *src;
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	8d 50 01             	lea    0x1(%eax),%edx
  800ef7:	89 55 08             	mov    %edx,0x8(%ebp)
  800efa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800efd:	8a 12                	mov    (%edx),%dl
  800eff:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	84 c0                	test   %al,%al
  800f08:	74 03                	je     800f0d <strncpy+0x31>
			src++;
  800f0a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f0d:	ff 45 fc             	incl   -0x4(%ebp)
  800f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f13:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f16:	72 d9                	jb     800ef1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f1b:	c9                   	leave  
  800f1c:	c3                   	ret    

00800f1d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f1d:	55                   	push   %ebp
  800f1e:	89 e5                	mov    %esp,%ebp
  800f20:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2d:	74 30                	je     800f5f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f2f:	eb 16                	jmp    800f47 <strlcpy+0x2a>
			*dst++ = *src++;
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8d 50 01             	lea    0x1(%eax),%edx
  800f37:	89 55 08             	mov    %edx,0x8(%ebp)
  800f3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f40:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f43:	8a 12                	mov    (%edx),%dl
  800f45:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f47:	ff 4d 10             	decl   0x10(%ebp)
  800f4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4e:	74 09                	je     800f59 <strlcpy+0x3c>
  800f50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	84 c0                	test   %al,%al
  800f57:	75 d8                	jne    800f31 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f5f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f65:	29 c2                	sub    %eax,%edx
  800f67:	89 d0                	mov    %edx,%eax
}
  800f69:	c9                   	leave  
  800f6a:	c3                   	ret    

00800f6b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f6b:	55                   	push   %ebp
  800f6c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f6e:	eb 06                	jmp    800f76 <strcmp+0xb>
		p++, q++;
  800f70:	ff 45 08             	incl   0x8(%ebp)
  800f73:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	84 c0                	test   %al,%al
  800f7d:	74 0e                	je     800f8d <strcmp+0x22>
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	8a 10                	mov    (%eax),%dl
  800f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	38 c2                	cmp    %al,%dl
  800f8b:	74 e3                	je     800f70 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	0f b6 d0             	movzbl %al,%edx
  800f95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	0f b6 c0             	movzbl %al,%eax
  800f9d:	29 c2                	sub    %eax,%edx
  800f9f:	89 d0                	mov    %edx,%eax
}
  800fa1:	5d                   	pop    %ebp
  800fa2:	c3                   	ret    

00800fa3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fa3:	55                   	push   %ebp
  800fa4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fa6:	eb 09                	jmp    800fb1 <strncmp+0xe>
		n--, p++, q++;
  800fa8:	ff 4d 10             	decl   0x10(%ebp)
  800fab:	ff 45 08             	incl   0x8(%ebp)
  800fae:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fb1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb5:	74 17                	je     800fce <strncmp+0x2b>
  800fb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	84 c0                	test   %al,%al
  800fbe:	74 0e                	je     800fce <strncmp+0x2b>
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 10                	mov    (%eax),%dl
  800fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc8:	8a 00                	mov    (%eax),%al
  800fca:	38 c2                	cmp    %al,%dl
  800fcc:	74 da                	je     800fa8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fd2:	75 07                	jne    800fdb <strncmp+0x38>
		return 0;
  800fd4:	b8 00 00 00 00       	mov    $0x0,%eax
  800fd9:	eb 14                	jmp    800fef <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	8a 00                	mov    (%eax),%al
  800fe0:	0f b6 d0             	movzbl %al,%edx
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f b6 c0             	movzbl %al,%eax
  800feb:	29 c2                	sub    %eax,%edx
  800fed:	89 d0                	mov    %edx,%eax
}
  800fef:	5d                   	pop    %ebp
  800ff0:	c3                   	ret    

00800ff1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ff1:	55                   	push   %ebp
  800ff2:	89 e5                	mov    %esp,%ebp
  800ff4:	83 ec 04             	sub    $0x4,%esp
  800ff7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ffd:	eb 12                	jmp    801011 <strchr+0x20>
		if (*s == c)
  800fff:	8b 45 08             	mov    0x8(%ebp),%eax
  801002:	8a 00                	mov    (%eax),%al
  801004:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801007:	75 05                	jne    80100e <strchr+0x1d>
			return (char *) s;
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	eb 11                	jmp    80101f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80100e:	ff 45 08             	incl   0x8(%ebp)
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	84 c0                	test   %al,%al
  801018:	75 e5                	jne    800fff <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80101a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80101f:	c9                   	leave  
  801020:	c3                   	ret    

00801021 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801021:	55                   	push   %ebp
  801022:	89 e5                	mov    %esp,%ebp
  801024:	83 ec 04             	sub    $0x4,%esp
  801027:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80102d:	eb 0d                	jmp    80103c <strfind+0x1b>
		if (*s == c)
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	8a 00                	mov    (%eax),%al
  801034:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801037:	74 0e                	je     801047 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801039:	ff 45 08             	incl   0x8(%ebp)
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
  80103f:	8a 00                	mov    (%eax),%al
  801041:	84 c0                	test   %al,%al
  801043:	75 ea                	jne    80102f <strfind+0xe>
  801045:	eb 01                	jmp    801048 <strfind+0x27>
		if (*s == c)
			break;
  801047:	90                   	nop
	return (char *) s;
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80104b:	c9                   	leave  
  80104c:	c3                   	ret    

0080104d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80104d:	55                   	push   %ebp
  80104e:	89 e5                	mov    %esp,%ebp
  801050:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801059:	8b 45 10             	mov    0x10(%ebp),%eax
  80105c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80105f:	eb 0e                	jmp    80106f <memset+0x22>
		*p++ = c;
  801061:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801064:	8d 50 01             	lea    0x1(%eax),%edx
  801067:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80106a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80106d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80106f:	ff 4d f8             	decl   -0x8(%ebp)
  801072:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801076:	79 e9                	jns    801061 <memset+0x14>
		*p++ = c;

	return v;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80108f:	eb 16                	jmp    8010a7 <memcpy+0x2a>
		*d++ = *s++;
  801091:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801094:	8d 50 01             	lea    0x1(%eax),%edx
  801097:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80109a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80109d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a3:	8a 12                	mov    (%edx),%dl
  8010a5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b0:	85 c0                	test   %eax,%eax
  8010b2:	75 dd                	jne    801091 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010b4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b7:	c9                   	leave  
  8010b8:	c3                   	ret    

008010b9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010b9:	55                   	push   %ebp
  8010ba:	89 e5                	mov    %esp,%ebp
  8010bc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8010bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010d1:	73 50                	jae    801123 <memmove+0x6a>
  8010d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d9:	01 d0                	add    %edx,%eax
  8010db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010de:	76 43                	jbe    801123 <memmove+0x6a>
		s += n;
  8010e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010ec:	eb 10                	jmp    8010fe <memmove+0x45>
			*--d = *--s;
  8010ee:	ff 4d f8             	decl   -0x8(%ebp)
  8010f1:	ff 4d fc             	decl   -0x4(%ebp)
  8010f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f7:	8a 10                	mov    (%eax),%dl
  8010f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801101:	8d 50 ff             	lea    -0x1(%eax),%edx
  801104:	89 55 10             	mov    %edx,0x10(%ebp)
  801107:	85 c0                	test   %eax,%eax
  801109:	75 e3                	jne    8010ee <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80110b:	eb 23                	jmp    801130 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80110d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801110:	8d 50 01             	lea    0x1(%eax),%edx
  801113:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801116:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801119:	8d 4a 01             	lea    0x1(%edx),%ecx
  80111c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80111f:	8a 12                	mov    (%edx),%dl
  801121:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801123:	8b 45 10             	mov    0x10(%ebp),%eax
  801126:	8d 50 ff             	lea    -0x1(%eax),%edx
  801129:	89 55 10             	mov    %edx,0x10(%ebp)
  80112c:	85 c0                	test   %eax,%eax
  80112e:	75 dd                	jne    80110d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
  801138:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801141:	8b 45 0c             	mov    0xc(%ebp),%eax
  801144:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801147:	eb 2a                	jmp    801173 <memcmp+0x3e>
		if (*s1 != *s2)
  801149:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114c:	8a 10                	mov    (%eax),%dl
  80114e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801151:	8a 00                	mov    (%eax),%al
  801153:	38 c2                	cmp    %al,%dl
  801155:	74 16                	je     80116d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801157:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	0f b6 d0             	movzbl %al,%edx
  80115f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	0f b6 c0             	movzbl %al,%eax
  801167:	29 c2                	sub    %eax,%edx
  801169:	89 d0                	mov    %edx,%eax
  80116b:	eb 18                	jmp    801185 <memcmp+0x50>
		s1++, s2++;
  80116d:	ff 45 fc             	incl   -0x4(%ebp)
  801170:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801173:	8b 45 10             	mov    0x10(%ebp),%eax
  801176:	8d 50 ff             	lea    -0x1(%eax),%edx
  801179:	89 55 10             	mov    %edx,0x10(%ebp)
  80117c:	85 c0                	test   %eax,%eax
  80117e:	75 c9                	jne    801149 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801180:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801185:	c9                   	leave  
  801186:	c3                   	ret    

00801187 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
  80118a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80118d:	8b 55 08             	mov    0x8(%ebp),%edx
  801190:	8b 45 10             	mov    0x10(%ebp),%eax
  801193:	01 d0                	add    %edx,%eax
  801195:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801198:	eb 15                	jmp    8011af <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	0f b6 d0             	movzbl %al,%edx
  8011a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a5:	0f b6 c0             	movzbl %al,%eax
  8011a8:	39 c2                	cmp    %eax,%edx
  8011aa:	74 0d                	je     8011b9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011ac:	ff 45 08             	incl   0x8(%ebp)
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011b5:	72 e3                	jb     80119a <memfind+0x13>
  8011b7:	eb 01                	jmp    8011ba <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011b9:	90                   	nop
	return (void *) s;
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011bd:	c9                   	leave  
  8011be:	c3                   	ret    

008011bf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011bf:	55                   	push   %ebp
  8011c0:	89 e5                	mov    %esp,%ebp
  8011c2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011cc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011d3:	eb 03                	jmp    8011d8 <strtol+0x19>
		s++;
  8011d5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	3c 20                	cmp    $0x20,%al
  8011df:	74 f4                	je     8011d5 <strtol+0x16>
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	3c 09                	cmp    $0x9,%al
  8011e8:	74 eb                	je     8011d5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	8a 00                	mov    (%eax),%al
  8011ef:	3c 2b                	cmp    $0x2b,%al
  8011f1:	75 05                	jne    8011f8 <strtol+0x39>
		s++;
  8011f3:	ff 45 08             	incl   0x8(%ebp)
  8011f6:	eb 13                	jmp    80120b <strtol+0x4c>
	else if (*s == '-')
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	3c 2d                	cmp    $0x2d,%al
  8011ff:	75 0a                	jne    80120b <strtol+0x4c>
		s++, neg = 1;
  801201:	ff 45 08             	incl   0x8(%ebp)
  801204:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80120b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80120f:	74 06                	je     801217 <strtol+0x58>
  801211:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801215:	75 20                	jne    801237 <strtol+0x78>
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	8a 00                	mov    (%eax),%al
  80121c:	3c 30                	cmp    $0x30,%al
  80121e:	75 17                	jne    801237 <strtol+0x78>
  801220:	8b 45 08             	mov    0x8(%ebp),%eax
  801223:	40                   	inc    %eax
  801224:	8a 00                	mov    (%eax),%al
  801226:	3c 78                	cmp    $0x78,%al
  801228:	75 0d                	jne    801237 <strtol+0x78>
		s += 2, base = 16;
  80122a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80122e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801235:	eb 28                	jmp    80125f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801237:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80123b:	75 15                	jne    801252 <strtol+0x93>
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	8a 00                	mov    (%eax),%al
  801242:	3c 30                	cmp    $0x30,%al
  801244:	75 0c                	jne    801252 <strtol+0x93>
		s++, base = 8;
  801246:	ff 45 08             	incl   0x8(%ebp)
  801249:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801250:	eb 0d                	jmp    80125f <strtol+0xa0>
	else if (base == 0)
  801252:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801256:	75 07                	jne    80125f <strtol+0xa0>
		base = 10;
  801258:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	8a 00                	mov    (%eax),%al
  801264:	3c 2f                	cmp    $0x2f,%al
  801266:	7e 19                	jle    801281 <strtol+0xc2>
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	8a 00                	mov    (%eax),%al
  80126d:	3c 39                	cmp    $0x39,%al
  80126f:	7f 10                	jg     801281 <strtol+0xc2>
			dig = *s - '0';
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	8a 00                	mov    (%eax),%al
  801276:	0f be c0             	movsbl %al,%eax
  801279:	83 e8 30             	sub    $0x30,%eax
  80127c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80127f:	eb 42                	jmp    8012c3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	3c 60                	cmp    $0x60,%al
  801288:	7e 19                	jle    8012a3 <strtol+0xe4>
  80128a:	8b 45 08             	mov    0x8(%ebp),%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	3c 7a                	cmp    $0x7a,%al
  801291:	7f 10                	jg     8012a3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	8a 00                	mov    (%eax),%al
  801298:	0f be c0             	movsbl %al,%eax
  80129b:	83 e8 57             	sub    $0x57,%eax
  80129e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012a1:	eb 20                	jmp    8012c3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	8a 00                	mov    (%eax),%al
  8012a8:	3c 40                	cmp    $0x40,%al
  8012aa:	7e 39                	jle    8012e5 <strtol+0x126>
  8012ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8012af:	8a 00                	mov    (%eax),%al
  8012b1:	3c 5a                	cmp    $0x5a,%al
  8012b3:	7f 30                	jg     8012e5 <strtol+0x126>
			dig = *s - 'A' + 10;
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	8a 00                	mov    (%eax),%al
  8012ba:	0f be c0             	movsbl %al,%eax
  8012bd:	83 e8 37             	sub    $0x37,%eax
  8012c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012c9:	7d 19                	jge    8012e4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012cb:	ff 45 08             	incl   0x8(%ebp)
  8012ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012d5:	89 c2                	mov    %eax,%edx
  8012d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012da:	01 d0                	add    %edx,%eax
  8012dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012df:	e9 7b ff ff ff       	jmp    80125f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012e4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e9:	74 08                	je     8012f3 <strtol+0x134>
		*endptr = (char *) s;
  8012eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012f7:	74 07                	je     801300 <strtol+0x141>
  8012f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012fc:	f7 d8                	neg    %eax
  8012fe:	eb 03                	jmp    801303 <strtol+0x144>
  801300:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <ltostr>:

void
ltostr(long value, char *str)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80130b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801312:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801319:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80131d:	79 13                	jns    801332 <ltostr+0x2d>
	{
		neg = 1;
  80131f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801326:	8b 45 0c             	mov    0xc(%ebp),%eax
  801329:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80132c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80132f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80133a:	99                   	cltd   
  80133b:	f7 f9                	idiv   %ecx
  80133d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801340:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801343:	8d 50 01             	lea    0x1(%eax),%edx
  801346:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801349:	89 c2                	mov    %eax,%edx
  80134b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134e:	01 d0                	add    %edx,%eax
  801350:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801353:	83 c2 30             	add    $0x30,%edx
  801356:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801358:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80135b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801360:	f7 e9                	imul   %ecx
  801362:	c1 fa 02             	sar    $0x2,%edx
  801365:	89 c8                	mov    %ecx,%eax
  801367:	c1 f8 1f             	sar    $0x1f,%eax
  80136a:	29 c2                	sub    %eax,%edx
  80136c:	89 d0                	mov    %edx,%eax
  80136e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801371:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801374:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801379:	f7 e9                	imul   %ecx
  80137b:	c1 fa 02             	sar    $0x2,%edx
  80137e:	89 c8                	mov    %ecx,%eax
  801380:	c1 f8 1f             	sar    $0x1f,%eax
  801383:	29 c2                	sub    %eax,%edx
  801385:	89 d0                	mov    %edx,%eax
  801387:	c1 e0 02             	shl    $0x2,%eax
  80138a:	01 d0                	add    %edx,%eax
  80138c:	01 c0                	add    %eax,%eax
  80138e:	29 c1                	sub    %eax,%ecx
  801390:	89 ca                	mov    %ecx,%edx
  801392:	85 d2                	test   %edx,%edx
  801394:	75 9c                	jne    801332 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801396:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80139d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a0:	48                   	dec    %eax
  8013a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013a8:	74 3d                	je     8013e7 <ltostr+0xe2>
		start = 1 ;
  8013aa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013b1:	eb 34                	jmp    8013e7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8013b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b9:	01 d0                	add    %edx,%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c6:	01 c2                	add    %eax,%edx
  8013c8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ce:	01 c8                	add    %ecx,%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013d4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013da:	01 c2                	add    %eax,%edx
  8013dc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013df:	88 02                	mov    %al,(%edx)
		start++ ;
  8013e1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013e4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013ed:	7c c4                	jl     8013b3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f5:	01 d0                	add    %edx,%eax
  8013f7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013fa:	90                   	nop
  8013fb:	c9                   	leave  
  8013fc:	c3                   	ret    

008013fd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013fd:	55                   	push   %ebp
  8013fe:	89 e5                	mov    %esp,%ebp
  801400:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801403:	ff 75 08             	pushl  0x8(%ebp)
  801406:	e8 54 fa ff ff       	call   800e5f <strlen>
  80140b:	83 c4 04             	add    $0x4,%esp
  80140e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801411:	ff 75 0c             	pushl  0xc(%ebp)
  801414:	e8 46 fa ff ff       	call   800e5f <strlen>
  801419:	83 c4 04             	add    $0x4,%esp
  80141c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80141f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801426:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80142d:	eb 17                	jmp    801446 <strcconcat+0x49>
		final[s] = str1[s] ;
  80142f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801432:	8b 45 10             	mov    0x10(%ebp),%eax
  801435:	01 c2                	add    %eax,%edx
  801437:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	01 c8                	add    %ecx,%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801443:	ff 45 fc             	incl   -0x4(%ebp)
  801446:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801449:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80144c:	7c e1                	jl     80142f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80144e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801455:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80145c:	eb 1f                	jmp    80147d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80145e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801461:	8d 50 01             	lea    0x1(%eax),%edx
  801464:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801467:	89 c2                	mov    %eax,%edx
  801469:	8b 45 10             	mov    0x10(%ebp),%eax
  80146c:	01 c2                	add    %eax,%edx
  80146e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801471:	8b 45 0c             	mov    0xc(%ebp),%eax
  801474:	01 c8                	add    %ecx,%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80147a:	ff 45 f8             	incl   -0x8(%ebp)
  80147d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801480:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801483:	7c d9                	jl     80145e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801485:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801488:	8b 45 10             	mov    0x10(%ebp),%eax
  80148b:	01 d0                	add    %edx,%eax
  80148d:	c6 00 00             	movb   $0x0,(%eax)
}
  801490:	90                   	nop
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801496:	8b 45 14             	mov    0x14(%ebp),%eax
  801499:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80149f:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a2:	8b 00                	mov    (%eax),%eax
  8014a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ae:	01 d0                	add    %edx,%eax
  8014b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014b6:	eb 0c                	jmp    8014c4 <strsplit+0x31>
			*string++ = 0;
  8014b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bb:	8d 50 01             	lea    0x1(%eax),%edx
  8014be:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c7:	8a 00                	mov    (%eax),%al
  8014c9:	84 c0                	test   %al,%al
  8014cb:	74 18                	je     8014e5 <strsplit+0x52>
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	8a 00                	mov    (%eax),%al
  8014d2:	0f be c0             	movsbl %al,%eax
  8014d5:	50                   	push   %eax
  8014d6:	ff 75 0c             	pushl  0xc(%ebp)
  8014d9:	e8 13 fb ff ff       	call   800ff1 <strchr>
  8014de:	83 c4 08             	add    $0x8,%esp
  8014e1:	85 c0                	test   %eax,%eax
  8014e3:	75 d3                	jne    8014b8 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	8a 00                	mov    (%eax),%al
  8014ea:	84 c0                	test   %al,%al
  8014ec:	74 5a                	je     801548 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8014ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f1:	8b 00                	mov    (%eax),%eax
  8014f3:	83 f8 0f             	cmp    $0xf,%eax
  8014f6:	75 07                	jne    8014ff <strsplit+0x6c>
		{
			return 0;
  8014f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8014fd:	eb 66                	jmp    801565 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801502:	8b 00                	mov    (%eax),%eax
  801504:	8d 48 01             	lea    0x1(%eax),%ecx
  801507:	8b 55 14             	mov    0x14(%ebp),%edx
  80150a:	89 0a                	mov    %ecx,(%edx)
  80150c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801513:	8b 45 10             	mov    0x10(%ebp),%eax
  801516:	01 c2                	add    %eax,%edx
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80151d:	eb 03                	jmp    801522 <strsplit+0x8f>
			string++;
  80151f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	8a 00                	mov    (%eax),%al
  801527:	84 c0                	test   %al,%al
  801529:	74 8b                	je     8014b6 <strsplit+0x23>
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	8a 00                	mov    (%eax),%al
  801530:	0f be c0             	movsbl %al,%eax
  801533:	50                   	push   %eax
  801534:	ff 75 0c             	pushl  0xc(%ebp)
  801537:	e8 b5 fa ff ff       	call   800ff1 <strchr>
  80153c:	83 c4 08             	add    $0x8,%esp
  80153f:	85 c0                	test   %eax,%eax
  801541:	74 dc                	je     80151f <strsplit+0x8c>
			string++;
	}
  801543:	e9 6e ff ff ff       	jmp    8014b6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801548:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801549:	8b 45 14             	mov    0x14(%ebp),%eax
  80154c:	8b 00                	mov    (%eax),%eax
  80154e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801555:	8b 45 10             	mov    0x10(%ebp),%eax
  801558:	01 d0                	add    %edx,%eax
  80155a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801560:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801565:	c9                   	leave  
  801566:	c3                   	ret    

00801567 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
  80156a:	57                   	push   %edi
  80156b:	56                   	push   %esi
  80156c:	53                   	push   %ebx
  80156d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	8b 55 0c             	mov    0xc(%ebp),%edx
  801576:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801579:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80157c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80157f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801582:	cd 30                	int    $0x30
  801584:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801587:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80158a:	83 c4 10             	add    $0x10,%esp
  80158d:	5b                   	pop    %ebx
  80158e:	5e                   	pop    %esi
  80158f:	5f                   	pop    %edi
  801590:	5d                   	pop    %ebp
  801591:	c3                   	ret    

00801592 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801592:	55                   	push   %ebp
  801593:	89 e5                	mov    %esp,%ebp
  801595:	83 ec 04             	sub    $0x4,%esp
  801598:	8b 45 10             	mov    0x10(%ebp),%eax
  80159b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80159e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	52                   	push   %edx
  8015aa:	ff 75 0c             	pushl  0xc(%ebp)
  8015ad:	50                   	push   %eax
  8015ae:	6a 00                	push   $0x0
  8015b0:	e8 b2 ff ff ff       	call   801567 <syscall>
  8015b5:	83 c4 18             	add    $0x18,%esp
}
  8015b8:	90                   	nop
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <sys_cgetc>:

int
sys_cgetc(void)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 01                	push   $0x1
  8015ca:	e8 98 ff ff ff       	call   801567 <syscall>
  8015cf:	83 c4 18             	add    $0x18,%esp
}
  8015d2:	c9                   	leave  
  8015d3:	c3                   	ret    

008015d4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015d4:	55                   	push   %ebp
  8015d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	50                   	push   %eax
  8015e3:	6a 05                	push   $0x5
  8015e5:	e8 7d ff ff ff       	call   801567 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 02                	push   $0x2
  8015fe:	e8 64 ff ff ff       	call   801567 <syscall>
  801603:	83 c4 18             	add    $0x18,%esp
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 03                	push   $0x3
  801617:	e8 4b ff ff ff       	call   801567 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 04                	push   $0x4
  801630:	e8 32 ff ff ff       	call   801567 <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_env_exit>:


void sys_env_exit(void)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	6a 06                	push   $0x6
  801649:	e8 19 ff ff ff       	call   801567 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	90                   	nop
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801657:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	52                   	push   %edx
  801664:	50                   	push   %eax
  801665:	6a 07                	push   $0x7
  801667:	e8 fb fe ff ff       	call   801567 <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
  801674:	56                   	push   %esi
  801675:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801676:	8b 75 18             	mov    0x18(%ebp),%esi
  801679:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80167c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80167f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	56                   	push   %esi
  801686:	53                   	push   %ebx
  801687:	51                   	push   %ecx
  801688:	52                   	push   %edx
  801689:	50                   	push   %eax
  80168a:	6a 08                	push   $0x8
  80168c:	e8 d6 fe ff ff       	call   801567 <syscall>
  801691:	83 c4 18             	add    $0x18,%esp
}
  801694:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801697:	5b                   	pop    %ebx
  801698:	5e                   	pop    %esi
  801699:	5d                   	pop    %ebp
  80169a:	c3                   	ret    

0080169b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80169e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	52                   	push   %edx
  8016ab:	50                   	push   %eax
  8016ac:	6a 09                	push   $0x9
  8016ae:	e8 b4 fe ff ff       	call   801567 <syscall>
  8016b3:	83 c4 18             	add    $0x18,%esp
}
  8016b6:	c9                   	leave  
  8016b7:	c3                   	ret    

008016b8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016b8:	55                   	push   %ebp
  8016b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	ff 75 0c             	pushl  0xc(%ebp)
  8016c4:	ff 75 08             	pushl  0x8(%ebp)
  8016c7:	6a 0a                	push   $0xa
  8016c9:	e8 99 fe ff ff       	call   801567 <syscall>
  8016ce:	83 c4 18             	add    $0x18,%esp
}
  8016d1:	c9                   	leave  
  8016d2:	c3                   	ret    

008016d3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016d3:	55                   	push   %ebp
  8016d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 0b                	push   $0xb
  8016e2:	e8 80 fe ff ff       	call   801567 <syscall>
  8016e7:	83 c4 18             	add    $0x18,%esp
}
  8016ea:	c9                   	leave  
  8016eb:	c3                   	ret    

008016ec <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016ec:	55                   	push   %ebp
  8016ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 0c                	push   $0xc
  8016fb:	e8 67 fe ff ff       	call   801567 <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 0d                	push   $0xd
  801714:	e8 4e fe ff ff       	call   801567 <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	ff 75 0c             	pushl  0xc(%ebp)
  80172a:	ff 75 08             	pushl  0x8(%ebp)
  80172d:	6a 11                	push   $0x11
  80172f:	e8 33 fe ff ff       	call   801567 <syscall>
  801734:	83 c4 18             	add    $0x18,%esp
	return;
  801737:	90                   	nop
}
  801738:	c9                   	leave  
  801739:	c3                   	ret    

0080173a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80173a:	55                   	push   %ebp
  80173b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	ff 75 0c             	pushl  0xc(%ebp)
  801746:	ff 75 08             	pushl  0x8(%ebp)
  801749:	6a 12                	push   $0x12
  80174b:	e8 17 fe ff ff       	call   801567 <syscall>
  801750:	83 c4 18             	add    $0x18,%esp
	return ;
  801753:	90                   	nop
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 0e                	push   $0xe
  801765:	e8 fd fd ff ff       	call   801567 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	ff 75 08             	pushl  0x8(%ebp)
  80177d:	6a 0f                	push   $0xf
  80177f:	e8 e3 fd ff ff       	call   801567 <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 10                	push   $0x10
  801798:	e8 ca fd ff ff       	call   801567 <syscall>
  80179d:	83 c4 18             	add    $0x18,%esp
}
  8017a0:	90                   	nop
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 14                	push   $0x14
  8017b2:	e8 b0 fd ff ff       	call   801567 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	90                   	nop
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 15                	push   $0x15
  8017cc:	e8 96 fd ff ff       	call   801567 <syscall>
  8017d1:	83 c4 18             	add    $0x18,%esp
}
  8017d4:	90                   	nop
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 04             	sub    $0x4,%esp
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017e3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	50                   	push   %eax
  8017f0:	6a 16                	push   $0x16
  8017f2:	e8 70 fd ff ff       	call   801567 <syscall>
  8017f7:	83 c4 18             	add    $0x18,%esp
}
  8017fa:	90                   	nop
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 17                	push   $0x17
  80180c:	e8 56 fd ff ff       	call   801567 <syscall>
  801811:	83 c4 18             	add    $0x18,%esp
}
  801814:	90                   	nop
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	ff 75 0c             	pushl  0xc(%ebp)
  801826:	50                   	push   %eax
  801827:	6a 18                	push   $0x18
  801829:	e8 39 fd ff ff       	call   801567 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801836:	8b 55 0c             	mov    0xc(%ebp),%edx
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	52                   	push   %edx
  801843:	50                   	push   %eax
  801844:	6a 1b                	push   $0x1b
  801846:	e8 1c fd ff ff       	call   801567 <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801853:	8b 55 0c             	mov    0xc(%ebp),%edx
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	52                   	push   %edx
  801860:	50                   	push   %eax
  801861:	6a 19                	push   $0x19
  801863:	e8 ff fc ff ff       	call   801567 <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
}
  80186b:	90                   	nop
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801871:	8b 55 0c             	mov    0xc(%ebp),%edx
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	52                   	push   %edx
  80187e:	50                   	push   %eax
  80187f:	6a 1a                	push   $0x1a
  801881:	e8 e1 fc ff ff       	call   801567 <syscall>
  801886:	83 c4 18             	add    $0x18,%esp
}
  801889:	90                   	nop
  80188a:	c9                   	leave  
  80188b:	c3                   	ret    

0080188c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80188c:	55                   	push   %ebp
  80188d:	89 e5                	mov    %esp,%ebp
  80188f:	83 ec 04             	sub    $0x4,%esp
  801892:	8b 45 10             	mov    0x10(%ebp),%eax
  801895:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801898:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80189b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80189f:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a2:	6a 00                	push   $0x0
  8018a4:	51                   	push   %ecx
  8018a5:	52                   	push   %edx
  8018a6:	ff 75 0c             	pushl  0xc(%ebp)
  8018a9:	50                   	push   %eax
  8018aa:	6a 1c                	push   $0x1c
  8018ac:	e8 b6 fc ff ff       	call   801567 <syscall>
  8018b1:	83 c4 18             	add    $0x18,%esp
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8018b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	52                   	push   %edx
  8018c6:	50                   	push   %eax
  8018c7:	6a 1d                	push   $0x1d
  8018c9:	e8 99 fc ff ff       	call   801567 <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	51                   	push   %ecx
  8018e4:	52                   	push   %edx
  8018e5:	50                   	push   %eax
  8018e6:	6a 1e                	push   $0x1e
  8018e8:	e8 7a fc ff ff       	call   801567 <syscall>
  8018ed:	83 c4 18             	add    $0x18,%esp
}
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	52                   	push   %edx
  801902:	50                   	push   %eax
  801903:	6a 1f                	push   $0x1f
  801905:	e8 5d fc ff ff       	call   801567 <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	6a 20                	push   $0x20
  80191e:	e8 44 fc ff ff       	call   801567 <syscall>
  801923:	83 c4 18             	add    $0x18,%esp
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	ff 75 10             	pushl  0x10(%ebp)
  801935:	ff 75 0c             	pushl  0xc(%ebp)
  801938:	50                   	push   %eax
  801939:	6a 21                	push   $0x21
  80193b:	e8 27 fc ff ff       	call   801567 <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	50                   	push   %eax
  801954:	6a 22                	push   $0x22
  801956:	e8 0c fc ff ff       	call   801567 <syscall>
  80195b:	83 c4 18             	add    $0x18,%esp
}
  80195e:	90                   	nop
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 00                	push   $0x0
  80196f:	50                   	push   %eax
  801970:	6a 23                	push   $0x23
  801972:	e8 f0 fb ff ff       	call   801567 <syscall>
  801977:	83 c4 18             	add    $0x18,%esp
}
  80197a:	90                   	nop
  80197b:	c9                   	leave  
  80197c:	c3                   	ret    

0080197d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
  801980:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801983:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801986:	8d 50 04             	lea    0x4(%eax),%edx
  801989:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	52                   	push   %edx
  801993:	50                   	push   %eax
  801994:	6a 24                	push   $0x24
  801996:	e8 cc fb ff ff       	call   801567 <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
	return result;
  80199e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019a7:	89 01                	mov    %eax,(%ecx)
  8019a9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	c9                   	leave  
  8019b0:	c2 04 00             	ret    $0x4

008019b3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	ff 75 10             	pushl  0x10(%ebp)
  8019bd:	ff 75 0c             	pushl  0xc(%ebp)
  8019c0:	ff 75 08             	pushl  0x8(%ebp)
  8019c3:	6a 13                	push   $0x13
  8019c5:	e8 9d fb ff ff       	call   801567 <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8019cd:	90                   	nop
}
  8019ce:	c9                   	leave  
  8019cf:	c3                   	ret    

008019d0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 25                	push   $0x25
  8019df:	e8 83 fb ff ff       	call   801567 <syscall>
  8019e4:	83 c4 18             	add    $0x18,%esp
}
  8019e7:	c9                   	leave  
  8019e8:	c3                   	ret    

008019e9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019e9:	55                   	push   %ebp
  8019ea:	89 e5                	mov    %esp,%ebp
  8019ec:	83 ec 04             	sub    $0x4,%esp
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019f5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	50                   	push   %eax
  801a02:	6a 26                	push   $0x26
  801a04:	e8 5e fb ff ff       	call   801567 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0c:	90                   	nop
}
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <rsttst>:
void rsttst()
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 28                	push   $0x28
  801a1e:	e8 44 fb ff ff       	call   801567 <syscall>
  801a23:	83 c4 18             	add    $0x18,%esp
	return ;
  801a26:	90                   	nop
}
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
  801a2c:	83 ec 04             	sub    $0x4,%esp
  801a2f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a32:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a35:	8b 55 18             	mov    0x18(%ebp),%edx
  801a38:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a3c:	52                   	push   %edx
  801a3d:	50                   	push   %eax
  801a3e:	ff 75 10             	pushl  0x10(%ebp)
  801a41:	ff 75 0c             	pushl  0xc(%ebp)
  801a44:	ff 75 08             	pushl  0x8(%ebp)
  801a47:	6a 27                	push   $0x27
  801a49:	e8 19 fb ff ff       	call   801567 <syscall>
  801a4e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a51:	90                   	nop
}
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <chktst>:
void chktst(uint32 n)
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	ff 75 08             	pushl  0x8(%ebp)
  801a62:	6a 29                	push   $0x29
  801a64:	e8 fe fa ff ff       	call   801567 <syscall>
  801a69:	83 c4 18             	add    $0x18,%esp
	return ;
  801a6c:	90                   	nop
}
  801a6d:	c9                   	leave  
  801a6e:	c3                   	ret    

00801a6f <inctst>:

void inctst()
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 2a                	push   $0x2a
  801a7e:	e8 e4 fa ff ff       	call   801567 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
	return ;
  801a86:	90                   	nop
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <gettst>:
uint32 gettst()
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 2b                	push   $0x2b
  801a98:	e8 ca fa ff ff       	call   801567 <syscall>
  801a9d:	83 c4 18             	add    $0x18,%esp
}
  801aa0:	c9                   	leave  
  801aa1:	c3                   	ret    

00801aa2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801aa2:	55                   	push   %ebp
  801aa3:	89 e5                	mov    %esp,%ebp
  801aa5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 2c                	push   $0x2c
  801ab4:	e8 ae fa ff ff       	call   801567 <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
  801abc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801abf:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ac3:	75 07                	jne    801acc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ac5:	b8 01 00 00 00       	mov    $0x1,%eax
  801aca:	eb 05                	jmp    801ad1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801acc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad1:	c9                   	leave  
  801ad2:	c3                   	ret    

00801ad3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ad3:	55                   	push   %ebp
  801ad4:	89 e5                	mov    %esp,%ebp
  801ad6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 2c                	push   $0x2c
  801ae5:	e8 7d fa ff ff       	call   801567 <syscall>
  801aea:	83 c4 18             	add    $0x18,%esp
  801aed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801af0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801af4:	75 07                	jne    801afd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801af6:	b8 01 00 00 00       	mov    $0x1,%eax
  801afb:	eb 05                	jmp    801b02 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801afd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b02:	c9                   	leave  
  801b03:	c3                   	ret    

00801b04 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b04:	55                   	push   %ebp
  801b05:	89 e5                	mov    %esp,%ebp
  801b07:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 2c                	push   $0x2c
  801b16:	e8 4c fa ff ff       	call   801567 <syscall>
  801b1b:	83 c4 18             	add    $0x18,%esp
  801b1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b21:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b25:	75 07                	jne    801b2e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b27:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2c:	eb 05                	jmp    801b33 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b33:	c9                   	leave  
  801b34:	c3                   	ret    

00801b35 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b35:	55                   	push   %ebp
  801b36:	89 e5                	mov    %esp,%ebp
  801b38:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 2c                	push   $0x2c
  801b47:	e8 1b fa ff ff       	call   801567 <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
  801b4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b52:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b56:	75 07                	jne    801b5f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b58:	b8 01 00 00 00       	mov    $0x1,%eax
  801b5d:	eb 05                	jmp    801b64 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b64:	c9                   	leave  
  801b65:	c3                   	ret    

00801b66 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b66:	55                   	push   %ebp
  801b67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	ff 75 08             	pushl  0x8(%ebp)
  801b74:	6a 2d                	push   $0x2d
  801b76:	e8 ec f9 ff ff       	call   801567 <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b7e:	90                   	nop
}
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    
  801b81:	66 90                	xchg   %ax,%ax
  801b83:	90                   	nop

00801b84 <__udivdi3>:
  801b84:	55                   	push   %ebp
  801b85:	57                   	push   %edi
  801b86:	56                   	push   %esi
  801b87:	53                   	push   %ebx
  801b88:	83 ec 1c             	sub    $0x1c,%esp
  801b8b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b8f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b93:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b97:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b9b:	89 ca                	mov    %ecx,%edx
  801b9d:	89 f8                	mov    %edi,%eax
  801b9f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ba3:	85 f6                	test   %esi,%esi
  801ba5:	75 2d                	jne    801bd4 <__udivdi3+0x50>
  801ba7:	39 cf                	cmp    %ecx,%edi
  801ba9:	77 65                	ja     801c10 <__udivdi3+0x8c>
  801bab:	89 fd                	mov    %edi,%ebp
  801bad:	85 ff                	test   %edi,%edi
  801baf:	75 0b                	jne    801bbc <__udivdi3+0x38>
  801bb1:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb6:	31 d2                	xor    %edx,%edx
  801bb8:	f7 f7                	div    %edi
  801bba:	89 c5                	mov    %eax,%ebp
  801bbc:	31 d2                	xor    %edx,%edx
  801bbe:	89 c8                	mov    %ecx,%eax
  801bc0:	f7 f5                	div    %ebp
  801bc2:	89 c1                	mov    %eax,%ecx
  801bc4:	89 d8                	mov    %ebx,%eax
  801bc6:	f7 f5                	div    %ebp
  801bc8:	89 cf                	mov    %ecx,%edi
  801bca:	89 fa                	mov    %edi,%edx
  801bcc:	83 c4 1c             	add    $0x1c,%esp
  801bcf:	5b                   	pop    %ebx
  801bd0:	5e                   	pop    %esi
  801bd1:	5f                   	pop    %edi
  801bd2:	5d                   	pop    %ebp
  801bd3:	c3                   	ret    
  801bd4:	39 ce                	cmp    %ecx,%esi
  801bd6:	77 28                	ja     801c00 <__udivdi3+0x7c>
  801bd8:	0f bd fe             	bsr    %esi,%edi
  801bdb:	83 f7 1f             	xor    $0x1f,%edi
  801bde:	75 40                	jne    801c20 <__udivdi3+0x9c>
  801be0:	39 ce                	cmp    %ecx,%esi
  801be2:	72 0a                	jb     801bee <__udivdi3+0x6a>
  801be4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801be8:	0f 87 9e 00 00 00    	ja     801c8c <__udivdi3+0x108>
  801bee:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf3:	89 fa                	mov    %edi,%edx
  801bf5:	83 c4 1c             	add    $0x1c,%esp
  801bf8:	5b                   	pop    %ebx
  801bf9:	5e                   	pop    %esi
  801bfa:	5f                   	pop    %edi
  801bfb:	5d                   	pop    %ebp
  801bfc:	c3                   	ret    
  801bfd:	8d 76 00             	lea    0x0(%esi),%esi
  801c00:	31 ff                	xor    %edi,%edi
  801c02:	31 c0                	xor    %eax,%eax
  801c04:	89 fa                	mov    %edi,%edx
  801c06:	83 c4 1c             	add    $0x1c,%esp
  801c09:	5b                   	pop    %ebx
  801c0a:	5e                   	pop    %esi
  801c0b:	5f                   	pop    %edi
  801c0c:	5d                   	pop    %ebp
  801c0d:	c3                   	ret    
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	89 d8                	mov    %ebx,%eax
  801c12:	f7 f7                	div    %edi
  801c14:	31 ff                	xor    %edi,%edi
  801c16:	89 fa                	mov    %edi,%edx
  801c18:	83 c4 1c             	add    $0x1c,%esp
  801c1b:	5b                   	pop    %ebx
  801c1c:	5e                   	pop    %esi
  801c1d:	5f                   	pop    %edi
  801c1e:	5d                   	pop    %ebp
  801c1f:	c3                   	ret    
  801c20:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c25:	89 eb                	mov    %ebp,%ebx
  801c27:	29 fb                	sub    %edi,%ebx
  801c29:	89 f9                	mov    %edi,%ecx
  801c2b:	d3 e6                	shl    %cl,%esi
  801c2d:	89 c5                	mov    %eax,%ebp
  801c2f:	88 d9                	mov    %bl,%cl
  801c31:	d3 ed                	shr    %cl,%ebp
  801c33:	89 e9                	mov    %ebp,%ecx
  801c35:	09 f1                	or     %esi,%ecx
  801c37:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c3b:	89 f9                	mov    %edi,%ecx
  801c3d:	d3 e0                	shl    %cl,%eax
  801c3f:	89 c5                	mov    %eax,%ebp
  801c41:	89 d6                	mov    %edx,%esi
  801c43:	88 d9                	mov    %bl,%cl
  801c45:	d3 ee                	shr    %cl,%esi
  801c47:	89 f9                	mov    %edi,%ecx
  801c49:	d3 e2                	shl    %cl,%edx
  801c4b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c4f:	88 d9                	mov    %bl,%cl
  801c51:	d3 e8                	shr    %cl,%eax
  801c53:	09 c2                	or     %eax,%edx
  801c55:	89 d0                	mov    %edx,%eax
  801c57:	89 f2                	mov    %esi,%edx
  801c59:	f7 74 24 0c          	divl   0xc(%esp)
  801c5d:	89 d6                	mov    %edx,%esi
  801c5f:	89 c3                	mov    %eax,%ebx
  801c61:	f7 e5                	mul    %ebp
  801c63:	39 d6                	cmp    %edx,%esi
  801c65:	72 19                	jb     801c80 <__udivdi3+0xfc>
  801c67:	74 0b                	je     801c74 <__udivdi3+0xf0>
  801c69:	89 d8                	mov    %ebx,%eax
  801c6b:	31 ff                	xor    %edi,%edi
  801c6d:	e9 58 ff ff ff       	jmp    801bca <__udivdi3+0x46>
  801c72:	66 90                	xchg   %ax,%ax
  801c74:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c78:	89 f9                	mov    %edi,%ecx
  801c7a:	d3 e2                	shl    %cl,%edx
  801c7c:	39 c2                	cmp    %eax,%edx
  801c7e:	73 e9                	jae    801c69 <__udivdi3+0xe5>
  801c80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c83:	31 ff                	xor    %edi,%edi
  801c85:	e9 40 ff ff ff       	jmp    801bca <__udivdi3+0x46>
  801c8a:	66 90                	xchg   %ax,%ax
  801c8c:	31 c0                	xor    %eax,%eax
  801c8e:	e9 37 ff ff ff       	jmp    801bca <__udivdi3+0x46>
  801c93:	90                   	nop

00801c94 <__umoddi3>:
  801c94:	55                   	push   %ebp
  801c95:	57                   	push   %edi
  801c96:	56                   	push   %esi
  801c97:	53                   	push   %ebx
  801c98:	83 ec 1c             	sub    $0x1c,%esp
  801c9b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c9f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ca3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ca7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801cab:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801caf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801cb3:	89 f3                	mov    %esi,%ebx
  801cb5:	89 fa                	mov    %edi,%edx
  801cb7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cbb:	89 34 24             	mov    %esi,(%esp)
  801cbe:	85 c0                	test   %eax,%eax
  801cc0:	75 1a                	jne    801cdc <__umoddi3+0x48>
  801cc2:	39 f7                	cmp    %esi,%edi
  801cc4:	0f 86 a2 00 00 00    	jbe    801d6c <__umoddi3+0xd8>
  801cca:	89 c8                	mov    %ecx,%eax
  801ccc:	89 f2                	mov    %esi,%edx
  801cce:	f7 f7                	div    %edi
  801cd0:	89 d0                	mov    %edx,%eax
  801cd2:	31 d2                	xor    %edx,%edx
  801cd4:	83 c4 1c             	add    $0x1c,%esp
  801cd7:	5b                   	pop    %ebx
  801cd8:	5e                   	pop    %esi
  801cd9:	5f                   	pop    %edi
  801cda:	5d                   	pop    %ebp
  801cdb:	c3                   	ret    
  801cdc:	39 f0                	cmp    %esi,%eax
  801cde:	0f 87 ac 00 00 00    	ja     801d90 <__umoddi3+0xfc>
  801ce4:	0f bd e8             	bsr    %eax,%ebp
  801ce7:	83 f5 1f             	xor    $0x1f,%ebp
  801cea:	0f 84 ac 00 00 00    	je     801d9c <__umoddi3+0x108>
  801cf0:	bf 20 00 00 00       	mov    $0x20,%edi
  801cf5:	29 ef                	sub    %ebp,%edi
  801cf7:	89 fe                	mov    %edi,%esi
  801cf9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cfd:	89 e9                	mov    %ebp,%ecx
  801cff:	d3 e0                	shl    %cl,%eax
  801d01:	89 d7                	mov    %edx,%edi
  801d03:	89 f1                	mov    %esi,%ecx
  801d05:	d3 ef                	shr    %cl,%edi
  801d07:	09 c7                	or     %eax,%edi
  801d09:	89 e9                	mov    %ebp,%ecx
  801d0b:	d3 e2                	shl    %cl,%edx
  801d0d:	89 14 24             	mov    %edx,(%esp)
  801d10:	89 d8                	mov    %ebx,%eax
  801d12:	d3 e0                	shl    %cl,%eax
  801d14:	89 c2                	mov    %eax,%edx
  801d16:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d1a:	d3 e0                	shl    %cl,%eax
  801d1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d20:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d24:	89 f1                	mov    %esi,%ecx
  801d26:	d3 e8                	shr    %cl,%eax
  801d28:	09 d0                	or     %edx,%eax
  801d2a:	d3 eb                	shr    %cl,%ebx
  801d2c:	89 da                	mov    %ebx,%edx
  801d2e:	f7 f7                	div    %edi
  801d30:	89 d3                	mov    %edx,%ebx
  801d32:	f7 24 24             	mull   (%esp)
  801d35:	89 c6                	mov    %eax,%esi
  801d37:	89 d1                	mov    %edx,%ecx
  801d39:	39 d3                	cmp    %edx,%ebx
  801d3b:	0f 82 87 00 00 00    	jb     801dc8 <__umoddi3+0x134>
  801d41:	0f 84 91 00 00 00    	je     801dd8 <__umoddi3+0x144>
  801d47:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d4b:	29 f2                	sub    %esi,%edx
  801d4d:	19 cb                	sbb    %ecx,%ebx
  801d4f:	89 d8                	mov    %ebx,%eax
  801d51:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d55:	d3 e0                	shl    %cl,%eax
  801d57:	89 e9                	mov    %ebp,%ecx
  801d59:	d3 ea                	shr    %cl,%edx
  801d5b:	09 d0                	or     %edx,%eax
  801d5d:	89 e9                	mov    %ebp,%ecx
  801d5f:	d3 eb                	shr    %cl,%ebx
  801d61:	89 da                	mov    %ebx,%edx
  801d63:	83 c4 1c             	add    $0x1c,%esp
  801d66:	5b                   	pop    %ebx
  801d67:	5e                   	pop    %esi
  801d68:	5f                   	pop    %edi
  801d69:	5d                   	pop    %ebp
  801d6a:	c3                   	ret    
  801d6b:	90                   	nop
  801d6c:	89 fd                	mov    %edi,%ebp
  801d6e:	85 ff                	test   %edi,%edi
  801d70:	75 0b                	jne    801d7d <__umoddi3+0xe9>
  801d72:	b8 01 00 00 00       	mov    $0x1,%eax
  801d77:	31 d2                	xor    %edx,%edx
  801d79:	f7 f7                	div    %edi
  801d7b:	89 c5                	mov    %eax,%ebp
  801d7d:	89 f0                	mov    %esi,%eax
  801d7f:	31 d2                	xor    %edx,%edx
  801d81:	f7 f5                	div    %ebp
  801d83:	89 c8                	mov    %ecx,%eax
  801d85:	f7 f5                	div    %ebp
  801d87:	89 d0                	mov    %edx,%eax
  801d89:	e9 44 ff ff ff       	jmp    801cd2 <__umoddi3+0x3e>
  801d8e:	66 90                	xchg   %ax,%ax
  801d90:	89 c8                	mov    %ecx,%eax
  801d92:	89 f2                	mov    %esi,%edx
  801d94:	83 c4 1c             	add    $0x1c,%esp
  801d97:	5b                   	pop    %ebx
  801d98:	5e                   	pop    %esi
  801d99:	5f                   	pop    %edi
  801d9a:	5d                   	pop    %ebp
  801d9b:	c3                   	ret    
  801d9c:	3b 04 24             	cmp    (%esp),%eax
  801d9f:	72 06                	jb     801da7 <__umoddi3+0x113>
  801da1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801da5:	77 0f                	ja     801db6 <__umoddi3+0x122>
  801da7:	89 f2                	mov    %esi,%edx
  801da9:	29 f9                	sub    %edi,%ecx
  801dab:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801daf:	89 14 24             	mov    %edx,(%esp)
  801db2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801db6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801dba:	8b 14 24             	mov    (%esp),%edx
  801dbd:	83 c4 1c             	add    $0x1c,%esp
  801dc0:	5b                   	pop    %ebx
  801dc1:	5e                   	pop    %esi
  801dc2:	5f                   	pop    %edi
  801dc3:	5d                   	pop    %ebp
  801dc4:	c3                   	ret    
  801dc5:	8d 76 00             	lea    0x0(%esi),%esi
  801dc8:	2b 04 24             	sub    (%esp),%eax
  801dcb:	19 fa                	sbb    %edi,%edx
  801dcd:	89 d1                	mov    %edx,%ecx
  801dcf:	89 c6                	mov    %eax,%esi
  801dd1:	e9 71 ff ff ff       	jmp    801d47 <__umoddi3+0xb3>
  801dd6:	66 90                	xchg   %ax,%ax
  801dd8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ddc:	72 ea                	jb     801dc8 <__umoddi3+0x134>
  801dde:	89 d9                	mov    %ebx,%ecx
  801de0:	e9 62 ff ff ff       	jmp    801d47 <__umoddi3+0xb3>
