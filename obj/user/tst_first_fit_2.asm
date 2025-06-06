
obj/user/tst_first_fit_2:     file format elf32-i386


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
  800031:	e8 bb 06 00 00       	call   8006f1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 76 20 00 00       	call   8020c0 <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 29                	jmp    800083 <_main+0x4b>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	89 d0                	mov    %edx,%eax
  80006a:	01 c0                	add    %eax,%eax
  80006c:	01 d0                	add    %edx,%eax
  80006e:	c1 e0 02             	shl    $0x2,%eax
  800071:	01 c8                	add    %ecx,%eax
  800073:	8a 40 04             	mov    0x4(%eax),%al
  800076:	84 c0                	test   %al,%al
  800078:	74 06                	je     800080 <_main+0x48>
			{
				fullWS = 0;
  80007a:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80007e:	eb 12                	jmp    800092 <_main+0x5a>
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800080:	ff 45 f0             	incl   -0x10(%ebp)
  800083:	a1 20 30 80 00       	mov    0x803020,%eax
  800088:	8b 50 74             	mov    0x74(%eax),%edx
  80008b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80008e:	39 c2                	cmp    %eax,%edx
  800090:	77 c8                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800092:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800096:	74 14                	je     8000ac <_main+0x74>
  800098:	83 ec 04             	sub    $0x4,%esp
  80009b:	68 40 23 80 00       	push   $0x802340
  8000a0:	6a 1b                	push   $0x1b
  8000a2:	68 5c 23 80 00       	push   $0x80235c
  8000a7:	e8 47 07 00 00       	call   8007f3 <_panic>
	}


	int Mega = 1024*1024;
  8000ac:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b3:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000ba:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000bd:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c7:	89 d7                	mov    %edx,%edi
  8000c9:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	68 01 00 00 20       	push   $0x20000001
  8000d3:	e8 93 17 00 00       	call   80186b <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000de:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e1:	85 c0                	test   %eax,%eax
  8000e3:	74 14                	je     8000f9 <_main+0xc1>
  8000e5:	83 ec 04             	sub    $0x4,%esp
  8000e8:	68 74 23 80 00       	push   $0x802374
  8000ed:	6a 26                	push   $0x26
  8000ef:	68 5c 23 80 00       	push   $0x80235c
  8000f4:	e8 fa 06 00 00       	call   8007f3 <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f9:	e8 2f 1b 00 00       	call   801c2d <sys_calculate_free_frames>
  8000fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800101:	e8 aa 1b 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800106:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800109:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	50                   	push   %eax
  800115:	e8 51 17 00 00       	call   80186b <malloc>
  80011a:	83 c4 10             	add    $0x10,%esp
  80011d:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800120:	8b 45 90             	mov    -0x70(%ebp),%eax
  800123:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800128:	74 14                	je     80013e <_main+0x106>
  80012a:	83 ec 04             	sub    $0x4,%esp
  80012d:	68 b8 23 80 00       	push   $0x8023b8
  800132:	6a 2f                	push   $0x2f
  800134:	68 5c 23 80 00       	push   $0x80235c
  800139:	e8 b5 06 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013e:	e8 6d 1b 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800143:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800146:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014b:	74 14                	je     800161 <_main+0x129>
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 e8 23 80 00       	push   $0x8023e8
  800155:	6a 31                	push   $0x31
  800157:	68 5c 23 80 00       	push   $0x80235c
  80015c:	e8 92 06 00 00       	call   8007f3 <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800161:	e8 c7 1a 00 00       	call   801c2d <sys_calculate_free_frames>
  800166:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800169:	e8 42 1b 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  80016e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800171:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800174:	01 c0                	add    %eax,%eax
  800176:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	50                   	push   %eax
  80017d:	e8 e9 16 00 00       	call   80186b <malloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800188:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018b:	89 c2                	mov    %eax,%edx
  80018d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800190:	01 c0                	add    %eax,%eax
  800192:	05 00 00 00 80       	add    $0x80000000,%eax
  800197:	39 c2                	cmp    %eax,%edx
  800199:	74 14                	je     8001af <_main+0x177>
  80019b:	83 ec 04             	sub    $0x4,%esp
  80019e:	68 b8 23 80 00       	push   $0x8023b8
  8001a3:	6a 37                	push   $0x37
  8001a5:	68 5c 23 80 00       	push   $0x80235c
  8001aa:	e8 44 06 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001af:	e8 fc 1a 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8001b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 e8 23 80 00       	push   $0x8023e8
  8001c6:	6a 39                	push   $0x39
  8001c8:	68 5c 23 80 00       	push   $0x80235c
  8001cd:	e8 21 06 00 00       	call   8007f3 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d2:	e8 56 1a 00 00       	call   801c2d <sys_calculate_free_frames>
  8001d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001da:	e8 d1 1a 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8001df:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	50                   	push   %eax
  8001eb:	e8 7b 16 00 00       	call   80186b <malloc>
  8001f0:	83 c4 10             	add    $0x10,%esp
  8001f3:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8001f6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001f9:	89 c2                	mov    %eax,%edx
  8001fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001fe:	c1 e0 02             	shl    $0x2,%eax
  800201:	05 00 00 00 80       	add    $0x80000000,%eax
  800206:	39 c2                	cmp    %eax,%edx
  800208:	74 14                	je     80021e <_main+0x1e6>
  80020a:	83 ec 04             	sub    $0x4,%esp
  80020d:	68 b8 23 80 00       	push   $0x8023b8
  800212:	6a 3f                	push   $0x3f
  800214:	68 5c 23 80 00       	push   $0x80235c
  800219:	e8 d5 05 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021e:	e8 8d 1a 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800223:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800226:	83 f8 01             	cmp    $0x1,%eax
  800229:	74 14                	je     80023f <_main+0x207>
  80022b:	83 ec 04             	sub    $0x4,%esp
  80022e:	68 e8 23 80 00       	push   $0x8023e8
  800233:	6a 41                	push   $0x41
  800235:	68 5c 23 80 00       	push   $0x80235c
  80023a:	e8 b4 05 00 00       	call   8007f3 <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80023f:	e8 e9 19 00 00       	call   801c2d <sys_calculate_free_frames>
  800244:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800247:	e8 64 1a 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  80024c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  80024f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800252:	01 c0                	add    %eax,%eax
  800254:	83 ec 0c             	sub    $0xc,%esp
  800257:	50                   	push   %eax
  800258:	e8 0e 16 00 00       	call   80186b <malloc>
  80025d:	83 c4 10             	add    $0x10,%esp
  800260:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... ");
  800263:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800266:	89 c2                	mov    %eax,%edx
  800268:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80026b:	c1 e0 02             	shl    $0x2,%eax
  80026e:	89 c1                	mov    %eax,%ecx
  800270:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800273:	c1 e0 02             	shl    $0x2,%eax
  800276:	01 c8                	add    %ecx,%eax
  800278:	05 00 00 00 80       	add    $0x80000000,%eax
  80027d:	39 c2                	cmp    %eax,%edx
  80027f:	74 14                	je     800295 <_main+0x25d>
  800281:	83 ec 04             	sub    $0x4,%esp
  800284:	68 b8 23 80 00       	push   $0x8023b8
  800289:	6a 47                	push   $0x47
  80028b:	68 5c 23 80 00       	push   $0x80235c
  800290:	e8 5e 05 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800295:	e8 16 1a 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  80029a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029d:	83 f8 01             	cmp    $0x1,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 e8 23 80 00       	push   $0x8023e8
  8002aa:	6a 49                	push   $0x49
  8002ac:	68 5c 23 80 00       	push   $0x80235c
  8002b1:	e8 3d 05 00 00       	call   8007f3 <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b6:	e8 72 19 00 00       	call   801c2d <sys_calculate_free_frames>
  8002bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002be:	e8 ed 19 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002c9:	83 ec 0c             	sub    $0xc,%esp
  8002cc:	50                   	push   %eax
  8002cd:	e8 ba 16 00 00       	call   80198c <free>
  8002d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d5:	e8 d6 19 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8002da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002dd:	29 c2                	sub    %eax,%edx
  8002df:	89 d0                	mov    %edx,%eax
  8002e1:	83 f8 01             	cmp    $0x1,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 05 24 80 00       	push   $0x802405
  8002ee:	6a 50                	push   $0x50
  8002f0:	68 5c 23 80 00       	push   $0x80235c
  8002f5:	e8 f9 04 00 00       	call   8007f3 <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 2e 19 00 00       	call   801c2d <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800302:	e8 a9 19 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800307:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80030a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80030d:	89 d0                	mov    %edx,%eax
  80030f:	01 c0                	add    %eax,%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	01 c0                	add    %eax,%eax
  800315:	01 d0                	add    %edx,%eax
  800317:	83 ec 0c             	sub    $0xc,%esp
  80031a:	50                   	push   %eax
  80031b:	e8 4b 15 00 00       	call   80186b <malloc>
  800320:	83 c4 10             	add    $0x10,%esp
  800323:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... ");
  800326:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800329:	89 c2                	mov    %eax,%edx
  80032b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80032e:	c1 e0 02             	shl    $0x2,%eax
  800331:	89 c1                	mov    %eax,%ecx
  800333:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800336:	c1 e0 03             	shl    $0x3,%eax
  800339:	01 c8                	add    %ecx,%eax
  80033b:	05 00 00 00 80       	add    $0x80000000,%eax
  800340:	39 c2                	cmp    %eax,%edx
  800342:	74 14                	je     800358 <_main+0x320>
  800344:	83 ec 04             	sub    $0x4,%esp
  800347:	68 b8 23 80 00       	push   $0x8023b8
  80034c:	6a 56                	push   $0x56
  80034e:	68 5c 23 80 00       	push   $0x80235c
  800353:	e8 9b 04 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800358:	e8 53 19 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  80035d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800360:	83 f8 02             	cmp    $0x2,%eax
  800363:	74 14                	je     800379 <_main+0x341>
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 e8 23 80 00       	push   $0x8023e8
  80036d:	6a 58                	push   $0x58
  80036f:	68 5c 23 80 00       	push   $0x80235c
  800374:	e8 7a 04 00 00       	call   8007f3 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800379:	e8 af 18 00 00       	call   801c2d <sys_calculate_free_frames>
  80037e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800381:	e8 2a 19 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800386:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  800389:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	50                   	push   %eax
  800390:	e8 f7 15 00 00       	call   80198c <free>
  800395:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800398:	e8 13 19 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  80039d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a0:	29 c2                	sub    %eax,%edx
  8003a2:	89 d0                	mov    %edx,%eax
  8003a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003a9:	74 14                	je     8003bf <_main+0x387>
  8003ab:	83 ec 04             	sub    $0x4,%esp
  8003ae:	68 05 24 80 00       	push   $0x802405
  8003b3:	6a 5f                	push   $0x5f
  8003b5:	68 5c 23 80 00       	push   $0x80235c
  8003ba:	e8 34 04 00 00       	call   8007f3 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bf:	e8 69 18 00 00       	call   801c2d <sys_calculate_free_frames>
  8003c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c7:	e8 e4 18 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8003cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	01 d2                	add    %edx,%edx
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003db:	83 ec 0c             	sub    $0xc,%esp
  8003de:	50                   	push   %eax
  8003df:	e8 87 14 00 00       	call   80186b <malloc>
  8003e4:	83 c4 10             	add    $0x10,%esp
  8003e7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8003ea:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003ed:	89 c2                	mov    %eax,%edx
  8003ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003f2:	c1 e0 02             	shl    $0x2,%eax
  8003f5:	89 c1                	mov    %eax,%ecx
  8003f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003fa:	c1 e0 04             	shl    $0x4,%eax
  8003fd:	01 c8                	add    %ecx,%eax
  8003ff:	05 00 00 00 80       	add    $0x80000000,%eax
  800404:	39 c2                	cmp    %eax,%edx
  800406:	74 14                	je     80041c <_main+0x3e4>
  800408:	83 ec 04             	sub    $0x4,%esp
  80040b:	68 b8 23 80 00       	push   $0x8023b8
  800410:	6a 65                	push   $0x65
  800412:	68 5c 23 80 00       	push   $0x80235c
  800417:	e8 d7 03 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041c:	e8 8f 18 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800421:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800424:	89 c2                	mov    %eax,%edx
  800426:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800429:	89 c1                	mov    %eax,%ecx
  80042b:	01 c9                	add    %ecx,%ecx
  80042d:	01 c8                	add    %ecx,%eax
  80042f:	85 c0                	test   %eax,%eax
  800431:	79 05                	jns    800438 <_main+0x400>
  800433:	05 ff 0f 00 00       	add    $0xfff,%eax
  800438:	c1 f8 0c             	sar    $0xc,%eax
  80043b:	39 c2                	cmp    %eax,%edx
  80043d:	74 14                	je     800453 <_main+0x41b>
  80043f:	83 ec 04             	sub    $0x4,%esp
  800442:	68 e8 23 80 00       	push   $0x8023e8
  800447:	6a 67                	push   $0x67
  800449:	68 5c 23 80 00       	push   $0x80235c
  80044e:	e8 a0 03 00 00       	call   8007f3 <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800453:	e8 d5 17 00 00       	call   801c2d <sys_calculate_free_frames>
  800458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045b:	e8 50 18 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800460:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  800463:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800466:	89 c2                	mov    %eax,%edx
  800468:	01 d2                	add    %edx,%edx
  80046a:	01 c2                	add    %eax,%edx
  80046c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046f:	01 d0                	add    %edx,%eax
  800471:	01 c0                	add    %eax,%eax
  800473:	83 ec 0c             	sub    $0xc,%esp
  800476:	50                   	push   %eax
  800477:	e8 ef 13 00 00       	call   80186b <malloc>
  80047c:	83 c4 10             	add    $0x10,%esp
  80047f:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800482:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800485:	89 c1                	mov    %eax,%ecx
  800487:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80048a:	89 d0                	mov    %edx,%eax
  80048c:	01 c0                	add    %eax,%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	01 c0                	add    %eax,%eax
  800492:	01 d0                	add    %edx,%eax
  800494:	89 c2                	mov    %eax,%edx
  800496:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800499:	c1 e0 04             	shl    $0x4,%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	05 00 00 00 80       	add    $0x80000000,%eax
  8004a3:	39 c1                	cmp    %eax,%ecx
  8004a5:	74 14                	je     8004bb <_main+0x483>
  8004a7:	83 ec 04             	sub    $0x4,%esp
  8004aa:	68 b8 23 80 00       	push   $0x8023b8
  8004af:	6a 6d                	push   $0x6d
  8004b1:	68 5c 23 80 00       	push   $0x80235c
  8004b6:	e8 38 03 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bb:	e8 f0 17 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8004c0:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c3:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c8:	74 14                	je     8004de <_main+0x4a6>
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	68 e8 23 80 00       	push   $0x8023e8
  8004d2:	6a 6f                	push   $0x6f
  8004d4:	68 5c 23 80 00       	push   $0x80235c
  8004d9:	e8 15 03 00 00       	call   8007f3 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 4a 17 00 00       	call   801c2d <sys_calculate_free_frames>
  8004e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 c5 17 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8004eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  8004ee:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004f1:	83 ec 0c             	sub    $0xc,%esp
  8004f4:	50                   	push   %eax
  8004f5:	e8 92 14 00 00       	call   80198c <free>
  8004fa:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  8004fd:	e8 ae 17 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800502:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800505:	29 c2                	sub    %eax,%edx
  800507:	89 d0                	mov    %edx,%eax
  800509:	3d 00 03 00 00       	cmp    $0x300,%eax
  80050e:	74 14                	je     800524 <_main+0x4ec>
  800510:	83 ec 04             	sub    $0x4,%esp
  800513:	68 05 24 80 00       	push   $0x802405
  800518:	6a 76                	push   $0x76
  80051a:	68 5c 23 80 00       	push   $0x80235c
  80051f:	e8 cf 02 00 00       	call   8007f3 <_panic>

		//2 MB Hole [Resulting Hole = 2 MB + 2 MB + 4 KB = 4 MB + 4 KB]
		freeFrames = sys_calculate_free_frames() ;
  800524:	e8 04 17 00 00       	call   801c2d <sys_calculate_free_frames>
  800529:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80052c:	e8 7f 17 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800531:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800534:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800537:	83 ec 0c             	sub    $0xc,%esp
  80053a:	50                   	push   %eax
  80053b:	e8 4c 14 00 00       	call   80198c <free>
  800540:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800543:	e8 68 17 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800548:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054b:	29 c2                	sub    %eax,%edx
  80054d:	89 d0                	mov    %edx,%eax
  80054f:	3d 00 02 00 00       	cmp    $0x200,%eax
  800554:	74 14                	je     80056a <_main+0x532>
  800556:	83 ec 04             	sub    $0x4,%esp
  800559:	68 05 24 80 00       	push   $0x802405
  80055e:	6a 7d                	push   $0x7d
  800560:	68 5c 23 80 00       	push   $0x80235c
  800565:	e8 89 02 00 00       	call   8007f3 <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  80056a:	e8 be 16 00 00       	call   801c2d <sys_calculate_free_frames>
  80056f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800572:	e8 39 17 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800577:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  80057a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80057d:	89 d0                	mov    %edx,%eax
  80057f:	c1 e0 02             	shl    $0x2,%eax
  800582:	01 d0                	add    %edx,%eax
  800584:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800587:	83 ec 0c             	sub    $0xc,%esp
  80058a:	50                   	push   %eax
  80058b:	e8 db 12 00 00       	call   80186b <malloc>
  800590:	83 c4 10             	add    $0x10,%esp
  800593:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  800596:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800599:	89 c1                	mov    %eax,%ecx
  80059b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80059e:	89 d0                	mov    %edx,%eax
  8005a0:	c1 e0 03             	shl    $0x3,%eax
  8005a3:	01 d0                	add    %edx,%eax
  8005a5:	89 c3                	mov    %eax,%ebx
  8005a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005aa:	89 d0                	mov    %edx,%eax
  8005ac:	01 c0                	add    %eax,%eax
  8005ae:	01 d0                	add    %edx,%eax
  8005b0:	c1 e0 03             	shl    $0x3,%eax
  8005b3:	01 d8                	add    %ebx,%eax
  8005b5:	05 00 00 00 80       	add    $0x80000000,%eax
  8005ba:	39 c1                	cmp    %eax,%ecx
  8005bc:	74 17                	je     8005d5 <_main+0x59d>
  8005be:	83 ec 04             	sub    $0x4,%esp
  8005c1:	68 b8 23 80 00       	push   $0x8023b8
  8005c6:	68 83 00 00 00       	push   $0x83
  8005cb:	68 5c 23 80 00       	push   $0x80235c
  8005d0:	e8 1e 02 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  8005d5:	e8 d6 16 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  8005da:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005dd:	89 c1                	mov    %eax,%ecx
  8005df:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005e2:	89 d0                	mov    %edx,%eax
  8005e4:	c1 e0 02             	shl    $0x2,%eax
  8005e7:	01 d0                	add    %edx,%eax
  8005e9:	85 c0                	test   %eax,%eax
  8005eb:	79 05                	jns    8005f2 <_main+0x5ba>
  8005ed:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f2:	c1 f8 0c             	sar    $0xc,%eax
  8005f5:	39 c1                	cmp    %eax,%ecx
  8005f7:	74 17                	je     800610 <_main+0x5d8>
  8005f9:	83 ec 04             	sub    $0x4,%esp
  8005fc:	68 e8 23 80 00       	push   $0x8023e8
  800601:	68 85 00 00 00       	push   $0x85
  800606:	68 5c 23 80 00       	push   $0x80235c
  80060b:	e8 e3 01 00 00       	call   8007f3 <_panic>
//		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
//		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");

		//[FIRST FIT Case]
		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800610:	e8 18 16 00 00       	call   801c2d <sys_calculate_free_frames>
  800615:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800618:	e8 93 16 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  80061d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(3*Mega-kilo);
  800620:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800623:	89 c2                	mov    %eax,%edx
  800625:	01 d2                	add    %edx,%edx
  800627:	01 d0                	add    %edx,%eax
  800629:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80062c:	83 ec 0c             	sub    $0xc,%esp
  80062f:	50                   	push   %eax
  800630:	e8 36 12 00 00       	call   80186b <malloc>
  800635:	83 c4 10             	add    $0x10,%esp
  800638:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80063b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80063e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800643:	74 17                	je     80065c <_main+0x624>
  800645:	83 ec 04             	sub    $0x4,%esp
  800648:	68 b8 23 80 00       	push   $0x8023b8
  80064d:	68 93 00 00 00       	push   $0x93
  800652:	68 5c 23 80 00       	push   $0x80235c
  800657:	e8 97 01 00 00       	call   8007f3 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80065c:	e8 4f 16 00 00       	call   801cb0 <sys_pf_calculate_allocated_pages>
  800661:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800664:	89 c2                	mov    %eax,%edx
  800666:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800669:	89 c1                	mov    %eax,%ecx
  80066b:	01 c9                	add    %ecx,%ecx
  80066d:	01 c8                	add    %ecx,%eax
  80066f:	85 c0                	test   %eax,%eax
  800671:	79 05                	jns    800678 <_main+0x640>
  800673:	05 ff 0f 00 00       	add    $0xfff,%eax
  800678:	c1 f8 0c             	sar    $0xc,%eax
  80067b:	39 c2                	cmp    %eax,%edx
  80067d:	74 17                	je     800696 <_main+0x65e>
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 e8 23 80 00       	push   $0x8023e8
  800687:	68 95 00 00 00       	push   $0x95
  80068c:	68 5c 23 80 00       	push   $0x80235c
  800691:	e8 5d 01 00 00       	call   8007f3 <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800696:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800699:	89 d0                	mov    %edx,%eax
  80069b:	01 c0                	add    %eax,%eax
  80069d:	01 d0                	add    %edx,%eax
  80069f:	01 c0                	add    %eax,%eax
  8006a1:	01 d0                	add    %edx,%eax
  8006a3:	01 c0                	add    %eax,%eax
  8006a5:	f7 d8                	neg    %eax
  8006a7:	05 00 00 00 20       	add    $0x20000000,%eax
  8006ac:	83 ec 0c             	sub    $0xc,%esp
  8006af:	50                   	push   %eax
  8006b0:	e8 b6 11 00 00       	call   80186b <malloc>
  8006b5:	83 c4 10             	add    $0x10,%esp
  8006b8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if (ptr_allocations[9] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8006bb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006be:	85 c0                	test   %eax,%eax
  8006c0:	74 17                	je     8006d9 <_main+0x6a1>
  8006c2:	83 ec 04             	sub    $0x4,%esp
  8006c5:	68 1c 24 80 00       	push   $0x80241c
  8006ca:	68 9e 00 00 00       	push   $0x9e
  8006cf:	68 5c 23 80 00       	push   $0x80235c
  8006d4:	e8 1a 01 00 00       	call   8007f3 <_panic>

		cprintf("Congratulations!! test FIRST FIT allocation (2) completed successfully.\n");
  8006d9:	83 ec 0c             	sub    $0xc,%esp
  8006dc:	68 80 24 80 00       	push   $0x802480
  8006e1:	e8 c1 03 00 00       	call   800aa7 <cprintf>
  8006e6:	83 c4 10             	add    $0x10,%esp

		return;
  8006e9:	90                   	nop
	}
}
  8006ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8006ed:	5b                   	pop    %ebx
  8006ee:	5f                   	pop    %edi
  8006ef:	5d                   	pop    %ebp
  8006f0:	c3                   	ret    

008006f1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006f1:	55                   	push   %ebp
  8006f2:	89 e5                	mov    %esp,%ebp
  8006f4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006f7:	e8 66 14 00 00       	call   801b62 <sys_getenvindex>
  8006fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800702:	89 d0                	mov    %edx,%eax
  800704:	01 c0                	add    %eax,%eax
  800706:	01 d0                	add    %edx,%eax
  800708:	c1 e0 02             	shl    $0x2,%eax
  80070b:	01 d0                	add    %edx,%eax
  80070d:	c1 e0 06             	shl    $0x6,%eax
  800710:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800715:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80071a:	a1 20 30 80 00       	mov    0x803020,%eax
  80071f:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800725:	84 c0                	test   %al,%al
  800727:	74 0f                	je     800738 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800729:	a1 20 30 80 00       	mov    0x803020,%eax
  80072e:	05 f4 02 00 00       	add    $0x2f4,%eax
  800733:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800738:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80073c:	7e 0a                	jle    800748 <libmain+0x57>
		binaryname = argv[0];
  80073e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800741:	8b 00                	mov    (%eax),%eax
  800743:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 0c             	pushl  0xc(%ebp)
  80074e:	ff 75 08             	pushl  0x8(%ebp)
  800751:	e8 e2 f8 ff ff       	call   800038 <_main>
  800756:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800759:	e8 9f 15 00 00       	call   801cfd <sys_disable_interrupt>
	cprintf("**************************************\n");
  80075e:	83 ec 0c             	sub    $0xc,%esp
  800761:	68 e4 24 80 00       	push   $0x8024e4
  800766:	e8 3c 03 00 00       	call   800aa7 <cprintf>
  80076b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80076e:	a1 20 30 80 00       	mov    0x803020,%eax
  800773:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800779:	a1 20 30 80 00       	mov    0x803020,%eax
  80077e:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800784:	83 ec 04             	sub    $0x4,%esp
  800787:	52                   	push   %edx
  800788:	50                   	push   %eax
  800789:	68 0c 25 80 00       	push   $0x80250c
  80078e:	e8 14 03 00 00       	call   800aa7 <cprintf>
  800793:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800796:	a1 20 30 80 00       	mov    0x803020,%eax
  80079b:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	50                   	push   %eax
  8007a5:	68 31 25 80 00       	push   $0x802531
  8007aa:	e8 f8 02 00 00       	call   800aa7 <cprintf>
  8007af:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8007b2:	83 ec 0c             	sub    $0xc,%esp
  8007b5:	68 e4 24 80 00       	push   $0x8024e4
  8007ba:	e8 e8 02 00 00       	call   800aa7 <cprintf>
  8007bf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007c2:	e8 50 15 00 00       	call   801d17 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007c7:	e8 19 00 00 00       	call   8007e5 <exit>
}
  8007cc:	90                   	nop
  8007cd:	c9                   	leave  
  8007ce:	c3                   	ret    

008007cf <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007cf:	55                   	push   %ebp
  8007d0:	89 e5                	mov    %esp,%ebp
  8007d2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007d5:	83 ec 0c             	sub    $0xc,%esp
  8007d8:	6a 00                	push   $0x0
  8007da:	e8 4f 13 00 00       	call   801b2e <sys_env_destroy>
  8007df:	83 c4 10             	add    $0x10,%esp
}
  8007e2:	90                   	nop
  8007e3:	c9                   	leave  
  8007e4:	c3                   	ret    

008007e5 <exit>:

void
exit(void)
{
  8007e5:	55                   	push   %ebp
  8007e6:	89 e5                	mov    %esp,%ebp
  8007e8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007eb:	e8 a4 13 00 00       	call   801b94 <sys_env_exit>
}
  8007f0:	90                   	nop
  8007f1:	c9                   	leave  
  8007f2:	c3                   	ret    

008007f3 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007f3:	55                   	push   %ebp
  8007f4:	89 e5                	mov    %esp,%ebp
  8007f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007f9:	8d 45 10             	lea    0x10(%ebp),%eax
  8007fc:	83 c0 04             	add    $0x4,%eax
  8007ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800802:	a1 30 30 80 00       	mov    0x803030,%eax
  800807:	85 c0                	test   %eax,%eax
  800809:	74 16                	je     800821 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80080b:	a1 30 30 80 00       	mov    0x803030,%eax
  800810:	83 ec 08             	sub    $0x8,%esp
  800813:	50                   	push   %eax
  800814:	68 48 25 80 00       	push   $0x802548
  800819:	e8 89 02 00 00       	call   800aa7 <cprintf>
  80081e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800821:	a1 00 30 80 00       	mov    0x803000,%eax
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	ff 75 08             	pushl  0x8(%ebp)
  80082c:	50                   	push   %eax
  80082d:	68 4d 25 80 00       	push   $0x80254d
  800832:	e8 70 02 00 00       	call   800aa7 <cprintf>
  800837:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80083a:	8b 45 10             	mov    0x10(%ebp),%eax
  80083d:	83 ec 08             	sub    $0x8,%esp
  800840:	ff 75 f4             	pushl  -0xc(%ebp)
  800843:	50                   	push   %eax
  800844:	e8 f3 01 00 00       	call   800a3c <vcprintf>
  800849:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80084c:	83 ec 08             	sub    $0x8,%esp
  80084f:	6a 00                	push   $0x0
  800851:	68 69 25 80 00       	push   $0x802569
  800856:	e8 e1 01 00 00       	call   800a3c <vcprintf>
  80085b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80085e:	e8 82 ff ff ff       	call   8007e5 <exit>

	// should not return here
	while (1) ;
  800863:	eb fe                	jmp    800863 <_panic+0x70>

00800865 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800865:	55                   	push   %ebp
  800866:	89 e5                	mov    %esp,%ebp
  800868:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80086b:	a1 20 30 80 00       	mov    0x803020,%eax
  800870:	8b 50 74             	mov    0x74(%eax),%edx
  800873:	8b 45 0c             	mov    0xc(%ebp),%eax
  800876:	39 c2                	cmp    %eax,%edx
  800878:	74 14                	je     80088e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80087a:	83 ec 04             	sub    $0x4,%esp
  80087d:	68 6c 25 80 00       	push   $0x80256c
  800882:	6a 26                	push   $0x26
  800884:	68 b8 25 80 00       	push   $0x8025b8
  800889:	e8 65 ff ff ff       	call   8007f3 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80088e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800895:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80089c:	e9 c2 00 00 00       	jmp    800963 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8008a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	01 d0                	add    %edx,%eax
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	85 c0                	test   %eax,%eax
  8008b4:	75 08                	jne    8008be <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008b6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008b9:	e9 a2 00 00 00       	jmp    800960 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8008be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008cc:	eb 69                	jmp    800937 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008d9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008dc:	89 d0                	mov    %edx,%eax
  8008de:	01 c0                	add    %eax,%eax
  8008e0:	01 d0                	add    %edx,%eax
  8008e2:	c1 e0 02             	shl    $0x2,%eax
  8008e5:	01 c8                	add    %ecx,%eax
  8008e7:	8a 40 04             	mov    0x4(%eax),%al
  8008ea:	84 c0                	test   %al,%al
  8008ec:	75 46                	jne    800934 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8008f3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008f9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008fc:	89 d0                	mov    %edx,%eax
  8008fe:	01 c0                	add    %eax,%eax
  800900:	01 d0                	add    %edx,%eax
  800902:	c1 e0 02             	shl    $0x2,%eax
  800905:	01 c8                	add    %ecx,%eax
  800907:	8b 00                	mov    (%eax),%eax
  800909:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80090c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80090f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800914:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800916:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800919:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	01 c8                	add    %ecx,%eax
  800925:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800927:	39 c2                	cmp    %eax,%edx
  800929:	75 09                	jne    800934 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80092b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800932:	eb 12                	jmp    800946 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800934:	ff 45 e8             	incl   -0x18(%ebp)
  800937:	a1 20 30 80 00       	mov    0x803020,%eax
  80093c:	8b 50 74             	mov    0x74(%eax),%edx
  80093f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800942:	39 c2                	cmp    %eax,%edx
  800944:	77 88                	ja     8008ce <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800946:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80094a:	75 14                	jne    800960 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80094c:	83 ec 04             	sub    $0x4,%esp
  80094f:	68 c4 25 80 00       	push   $0x8025c4
  800954:	6a 3a                	push   $0x3a
  800956:	68 b8 25 80 00       	push   $0x8025b8
  80095b:	e8 93 fe ff ff       	call   8007f3 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800960:	ff 45 f0             	incl   -0x10(%ebp)
  800963:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800966:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800969:	0f 8c 32 ff ff ff    	jl     8008a1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80096f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800976:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80097d:	eb 26                	jmp    8009a5 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80097f:	a1 20 30 80 00       	mov    0x803020,%eax
  800984:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80098a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80098d:	89 d0                	mov    %edx,%eax
  80098f:	01 c0                	add    %eax,%eax
  800991:	01 d0                	add    %edx,%eax
  800993:	c1 e0 02             	shl    $0x2,%eax
  800996:	01 c8                	add    %ecx,%eax
  800998:	8a 40 04             	mov    0x4(%eax),%al
  80099b:	3c 01                	cmp    $0x1,%al
  80099d:	75 03                	jne    8009a2 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80099f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009a2:	ff 45 e0             	incl   -0x20(%ebp)
  8009a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8009aa:	8b 50 74             	mov    0x74(%eax),%edx
  8009ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b0:	39 c2                	cmp    %eax,%edx
  8009b2:	77 cb                	ja     80097f <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009b7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009ba:	74 14                	je     8009d0 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8009bc:	83 ec 04             	sub    $0x4,%esp
  8009bf:	68 18 26 80 00       	push   $0x802618
  8009c4:	6a 44                	push   $0x44
  8009c6:	68 b8 25 80 00       	push   $0x8025b8
  8009cb:	e8 23 fe ff ff       	call   8007f3 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009d0:	90                   	nop
  8009d1:	c9                   	leave  
  8009d2:	c3                   	ret    

008009d3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009d3:	55                   	push   %ebp
  8009d4:	89 e5                	mov    %esp,%ebp
  8009d6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dc:	8b 00                	mov    (%eax),%eax
  8009de:	8d 48 01             	lea    0x1(%eax),%ecx
  8009e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e4:	89 0a                	mov    %ecx,(%edx)
  8009e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8009e9:	88 d1                	mov    %dl,%cl
  8009eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ee:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f5:	8b 00                	mov    (%eax),%eax
  8009f7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009fc:	75 2c                	jne    800a2a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009fe:	a0 24 30 80 00       	mov    0x803024,%al
  800a03:	0f b6 c0             	movzbl %al,%eax
  800a06:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a09:	8b 12                	mov    (%edx),%edx
  800a0b:	89 d1                	mov    %edx,%ecx
  800a0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a10:	83 c2 08             	add    $0x8,%edx
  800a13:	83 ec 04             	sub    $0x4,%esp
  800a16:	50                   	push   %eax
  800a17:	51                   	push   %ecx
  800a18:	52                   	push   %edx
  800a19:	e8 ce 10 00 00       	call   801aec <sys_cputs>
  800a1e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a24:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2d:	8b 40 04             	mov    0x4(%eax),%eax
  800a30:	8d 50 01             	lea    0x1(%eax),%edx
  800a33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a36:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a39:	90                   	nop
  800a3a:	c9                   	leave  
  800a3b:	c3                   	ret    

00800a3c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a3c:	55                   	push   %ebp
  800a3d:	89 e5                	mov    %esp,%ebp
  800a3f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a45:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a4c:	00 00 00 
	b.cnt = 0;
  800a4f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a56:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a59:	ff 75 0c             	pushl  0xc(%ebp)
  800a5c:	ff 75 08             	pushl  0x8(%ebp)
  800a5f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a65:	50                   	push   %eax
  800a66:	68 d3 09 80 00       	push   $0x8009d3
  800a6b:	e8 11 02 00 00       	call   800c81 <vprintfmt>
  800a70:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a73:	a0 24 30 80 00       	mov    0x803024,%al
  800a78:	0f b6 c0             	movzbl %al,%eax
  800a7b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a81:	83 ec 04             	sub    $0x4,%esp
  800a84:	50                   	push   %eax
  800a85:	52                   	push   %edx
  800a86:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a8c:	83 c0 08             	add    $0x8,%eax
  800a8f:	50                   	push   %eax
  800a90:	e8 57 10 00 00       	call   801aec <sys_cputs>
  800a95:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a98:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800a9f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800aa5:	c9                   	leave  
  800aa6:	c3                   	ret    

00800aa7 <cprintf>:

int cprintf(const char *fmt, ...) {
  800aa7:	55                   	push   %ebp
  800aa8:	89 e5                	mov    %esp,%ebp
  800aaa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800aad:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ab4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ab7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	83 ec 08             	sub    $0x8,%esp
  800ac0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac3:	50                   	push   %eax
  800ac4:	e8 73 ff ff ff       	call   800a3c <vcprintf>
  800ac9:	83 c4 10             	add    $0x10,%esp
  800acc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800acf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ad2:	c9                   	leave  
  800ad3:	c3                   	ret    

00800ad4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ad4:	55                   	push   %ebp
  800ad5:	89 e5                	mov    %esp,%ebp
  800ad7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ada:	e8 1e 12 00 00       	call   801cfd <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800adf:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ae2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	83 ec 08             	sub    $0x8,%esp
  800aeb:	ff 75 f4             	pushl  -0xc(%ebp)
  800aee:	50                   	push   %eax
  800aef:	e8 48 ff ff ff       	call   800a3c <vcprintf>
  800af4:	83 c4 10             	add    $0x10,%esp
  800af7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800afa:	e8 18 12 00 00       	call   801d17 <sys_enable_interrupt>
	return cnt;
  800aff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b02:	c9                   	leave  
  800b03:	c3                   	ret    

00800b04 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b04:	55                   	push   %ebp
  800b05:	89 e5                	mov    %esp,%ebp
  800b07:	53                   	push   %ebx
  800b08:	83 ec 14             	sub    $0x14,%esp
  800b0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b11:	8b 45 14             	mov    0x14(%ebp),%eax
  800b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b17:	8b 45 18             	mov    0x18(%ebp),%eax
  800b1a:	ba 00 00 00 00       	mov    $0x0,%edx
  800b1f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b22:	77 55                	ja     800b79 <printnum+0x75>
  800b24:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b27:	72 05                	jb     800b2e <printnum+0x2a>
  800b29:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b2c:	77 4b                	ja     800b79 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b2e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b31:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b34:	8b 45 18             	mov    0x18(%ebp),%eax
  800b37:	ba 00 00 00 00       	mov    $0x0,%edx
  800b3c:	52                   	push   %edx
  800b3d:	50                   	push   %eax
  800b3e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b41:	ff 75 f0             	pushl  -0x10(%ebp)
  800b44:	e8 93 15 00 00       	call   8020dc <__udivdi3>
  800b49:	83 c4 10             	add    $0x10,%esp
  800b4c:	83 ec 04             	sub    $0x4,%esp
  800b4f:	ff 75 20             	pushl  0x20(%ebp)
  800b52:	53                   	push   %ebx
  800b53:	ff 75 18             	pushl  0x18(%ebp)
  800b56:	52                   	push   %edx
  800b57:	50                   	push   %eax
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	ff 75 08             	pushl  0x8(%ebp)
  800b5e:	e8 a1 ff ff ff       	call   800b04 <printnum>
  800b63:	83 c4 20             	add    $0x20,%esp
  800b66:	eb 1a                	jmp    800b82 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b68:	83 ec 08             	sub    $0x8,%esp
  800b6b:	ff 75 0c             	pushl  0xc(%ebp)
  800b6e:	ff 75 20             	pushl  0x20(%ebp)
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	ff d0                	call   *%eax
  800b76:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b79:	ff 4d 1c             	decl   0x1c(%ebp)
  800b7c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b80:	7f e6                	jg     800b68 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b82:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b85:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b90:	53                   	push   %ebx
  800b91:	51                   	push   %ecx
  800b92:	52                   	push   %edx
  800b93:	50                   	push   %eax
  800b94:	e8 53 16 00 00       	call   8021ec <__umoddi3>
  800b99:	83 c4 10             	add    $0x10,%esp
  800b9c:	05 94 28 80 00       	add    $0x802894,%eax
  800ba1:	8a 00                	mov    (%eax),%al
  800ba3:	0f be c0             	movsbl %al,%eax
  800ba6:	83 ec 08             	sub    $0x8,%esp
  800ba9:	ff 75 0c             	pushl  0xc(%ebp)
  800bac:	50                   	push   %eax
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	ff d0                	call   *%eax
  800bb2:	83 c4 10             	add    $0x10,%esp
}
  800bb5:	90                   	nop
  800bb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bb9:	c9                   	leave  
  800bba:	c3                   	ret    

00800bbb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bbb:	55                   	push   %ebp
  800bbc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bbe:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bc2:	7e 1c                	jle    800be0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	8b 00                	mov    (%eax),%eax
  800bc9:	8d 50 08             	lea    0x8(%eax),%edx
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	89 10                	mov    %edx,(%eax)
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8b 00                	mov    (%eax),%eax
  800bd6:	83 e8 08             	sub    $0x8,%eax
  800bd9:	8b 50 04             	mov    0x4(%eax),%edx
  800bdc:	8b 00                	mov    (%eax),%eax
  800bde:	eb 40                	jmp    800c20 <getuint+0x65>
	else if (lflag)
  800be0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800be4:	74 1e                	je     800c04 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800be6:	8b 45 08             	mov    0x8(%ebp),%eax
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	8d 50 04             	lea    0x4(%eax),%edx
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	89 10                	mov    %edx,(%eax)
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	8b 00                	mov    (%eax),%eax
  800bf8:	83 e8 04             	sub    $0x4,%eax
  800bfb:	8b 00                	mov    (%eax),%eax
  800bfd:	ba 00 00 00 00       	mov    $0x0,%edx
  800c02:	eb 1c                	jmp    800c20 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	8d 50 04             	lea    0x4(%eax),%edx
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	89 10                	mov    %edx,(%eax)
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	8b 00                	mov    (%eax),%eax
  800c16:	83 e8 04             	sub    $0x4,%eax
  800c19:	8b 00                	mov    (%eax),%eax
  800c1b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c20:	5d                   	pop    %ebp
  800c21:	c3                   	ret    

00800c22 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c22:	55                   	push   %ebp
  800c23:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c25:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c29:	7e 1c                	jle    800c47 <getint+0x25>
		return va_arg(*ap, long long);
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	8d 50 08             	lea    0x8(%eax),%edx
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	89 10                	mov    %edx,(%eax)
  800c38:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3b:	8b 00                	mov    (%eax),%eax
  800c3d:	83 e8 08             	sub    $0x8,%eax
  800c40:	8b 50 04             	mov    0x4(%eax),%edx
  800c43:	8b 00                	mov    (%eax),%eax
  800c45:	eb 38                	jmp    800c7f <getint+0x5d>
	else if (lflag)
  800c47:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c4b:	74 1a                	je     800c67 <getint+0x45>
		return va_arg(*ap, long);
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8b 00                	mov    (%eax),%eax
  800c52:	8d 50 04             	lea    0x4(%eax),%edx
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
  800c58:	89 10                	mov    %edx,(%eax)
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8b 00                	mov    (%eax),%eax
  800c5f:	83 e8 04             	sub    $0x4,%eax
  800c62:	8b 00                	mov    (%eax),%eax
  800c64:	99                   	cltd   
  800c65:	eb 18                	jmp    800c7f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	8b 00                	mov    (%eax),%eax
  800c6c:	8d 50 04             	lea    0x4(%eax),%edx
  800c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c72:	89 10                	mov    %edx,(%eax)
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	8b 00                	mov    (%eax),%eax
  800c79:	83 e8 04             	sub    $0x4,%eax
  800c7c:	8b 00                	mov    (%eax),%eax
  800c7e:	99                   	cltd   
}
  800c7f:	5d                   	pop    %ebp
  800c80:	c3                   	ret    

00800c81 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c81:	55                   	push   %ebp
  800c82:	89 e5                	mov    %esp,%ebp
  800c84:	56                   	push   %esi
  800c85:	53                   	push   %ebx
  800c86:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c89:	eb 17                	jmp    800ca2 <vprintfmt+0x21>
			if (ch == '\0')
  800c8b:	85 db                	test   %ebx,%ebx
  800c8d:	0f 84 af 03 00 00    	je     801042 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c93:	83 ec 08             	sub    $0x8,%esp
  800c96:	ff 75 0c             	pushl  0xc(%ebp)
  800c99:	53                   	push   %ebx
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	ff d0                	call   *%eax
  800c9f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ca2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca5:	8d 50 01             	lea    0x1(%eax),%edx
  800ca8:	89 55 10             	mov    %edx,0x10(%ebp)
  800cab:	8a 00                	mov    (%eax),%al
  800cad:	0f b6 d8             	movzbl %al,%ebx
  800cb0:	83 fb 25             	cmp    $0x25,%ebx
  800cb3:	75 d6                	jne    800c8b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cb5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cb9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cc0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cc7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cce:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd8:	8d 50 01             	lea    0x1(%eax),%edx
  800cdb:	89 55 10             	mov    %edx,0x10(%ebp)
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	0f b6 d8             	movzbl %al,%ebx
  800ce3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ce6:	83 f8 55             	cmp    $0x55,%eax
  800ce9:	0f 87 2b 03 00 00    	ja     80101a <vprintfmt+0x399>
  800cef:	8b 04 85 b8 28 80 00 	mov    0x8028b8(,%eax,4),%eax
  800cf6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cf8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cfc:	eb d7                	jmp    800cd5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cfe:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d02:	eb d1                	jmp    800cd5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d04:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d0b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d0e:	89 d0                	mov    %edx,%eax
  800d10:	c1 e0 02             	shl    $0x2,%eax
  800d13:	01 d0                	add    %edx,%eax
  800d15:	01 c0                	add    %eax,%eax
  800d17:	01 d8                	add    %ebx,%eax
  800d19:	83 e8 30             	sub    $0x30,%eax
  800d1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d27:	83 fb 2f             	cmp    $0x2f,%ebx
  800d2a:	7e 3e                	jle    800d6a <vprintfmt+0xe9>
  800d2c:	83 fb 39             	cmp    $0x39,%ebx
  800d2f:	7f 39                	jg     800d6a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d31:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d34:	eb d5                	jmp    800d0b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d36:	8b 45 14             	mov    0x14(%ebp),%eax
  800d39:	83 c0 04             	add    $0x4,%eax
  800d3c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d42:	83 e8 04             	sub    $0x4,%eax
  800d45:	8b 00                	mov    (%eax),%eax
  800d47:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d4a:	eb 1f                	jmp    800d6b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d50:	79 83                	jns    800cd5 <vprintfmt+0x54>
				width = 0;
  800d52:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d59:	e9 77 ff ff ff       	jmp    800cd5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d5e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d65:	e9 6b ff ff ff       	jmp    800cd5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d6a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d6b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d6f:	0f 89 60 ff ff ff    	jns    800cd5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d75:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d7b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d82:	e9 4e ff ff ff       	jmp    800cd5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d87:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d8a:	e9 46 ff ff ff       	jmp    800cd5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d92:	83 c0 04             	add    $0x4,%eax
  800d95:	89 45 14             	mov    %eax,0x14(%ebp)
  800d98:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9b:	83 e8 04             	sub    $0x4,%eax
  800d9e:	8b 00                	mov    (%eax),%eax
  800da0:	83 ec 08             	sub    $0x8,%esp
  800da3:	ff 75 0c             	pushl  0xc(%ebp)
  800da6:	50                   	push   %eax
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	ff d0                	call   *%eax
  800dac:	83 c4 10             	add    $0x10,%esp
			break;
  800daf:	e9 89 02 00 00       	jmp    80103d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800db4:	8b 45 14             	mov    0x14(%ebp),%eax
  800db7:	83 c0 04             	add    $0x4,%eax
  800dba:	89 45 14             	mov    %eax,0x14(%ebp)
  800dbd:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc0:	83 e8 04             	sub    $0x4,%eax
  800dc3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dc5:	85 db                	test   %ebx,%ebx
  800dc7:	79 02                	jns    800dcb <vprintfmt+0x14a>
				err = -err;
  800dc9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dcb:	83 fb 64             	cmp    $0x64,%ebx
  800dce:	7f 0b                	jg     800ddb <vprintfmt+0x15a>
  800dd0:	8b 34 9d 00 27 80 00 	mov    0x802700(,%ebx,4),%esi
  800dd7:	85 f6                	test   %esi,%esi
  800dd9:	75 19                	jne    800df4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ddb:	53                   	push   %ebx
  800ddc:	68 a5 28 80 00       	push   $0x8028a5
  800de1:	ff 75 0c             	pushl  0xc(%ebp)
  800de4:	ff 75 08             	pushl  0x8(%ebp)
  800de7:	e8 5e 02 00 00       	call   80104a <printfmt>
  800dec:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800def:	e9 49 02 00 00       	jmp    80103d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800df4:	56                   	push   %esi
  800df5:	68 ae 28 80 00       	push   $0x8028ae
  800dfa:	ff 75 0c             	pushl  0xc(%ebp)
  800dfd:	ff 75 08             	pushl  0x8(%ebp)
  800e00:	e8 45 02 00 00       	call   80104a <printfmt>
  800e05:	83 c4 10             	add    $0x10,%esp
			break;
  800e08:	e9 30 02 00 00       	jmp    80103d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e10:	83 c0 04             	add    $0x4,%eax
  800e13:	89 45 14             	mov    %eax,0x14(%ebp)
  800e16:	8b 45 14             	mov    0x14(%ebp),%eax
  800e19:	83 e8 04             	sub    $0x4,%eax
  800e1c:	8b 30                	mov    (%eax),%esi
  800e1e:	85 f6                	test   %esi,%esi
  800e20:	75 05                	jne    800e27 <vprintfmt+0x1a6>
				p = "(null)";
  800e22:	be b1 28 80 00       	mov    $0x8028b1,%esi
			if (width > 0 && padc != '-')
  800e27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2b:	7e 6d                	jle    800e9a <vprintfmt+0x219>
  800e2d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e31:	74 67                	je     800e9a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e33:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e36:	83 ec 08             	sub    $0x8,%esp
  800e39:	50                   	push   %eax
  800e3a:	56                   	push   %esi
  800e3b:	e8 0c 03 00 00       	call   80114c <strnlen>
  800e40:	83 c4 10             	add    $0x10,%esp
  800e43:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e46:	eb 16                	jmp    800e5e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e48:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e4c:	83 ec 08             	sub    $0x8,%esp
  800e4f:	ff 75 0c             	pushl  0xc(%ebp)
  800e52:	50                   	push   %eax
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
  800e56:	ff d0                	call   *%eax
  800e58:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e5b:	ff 4d e4             	decl   -0x1c(%ebp)
  800e5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e62:	7f e4                	jg     800e48 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e64:	eb 34                	jmp    800e9a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e66:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e6a:	74 1c                	je     800e88 <vprintfmt+0x207>
  800e6c:	83 fb 1f             	cmp    $0x1f,%ebx
  800e6f:	7e 05                	jle    800e76 <vprintfmt+0x1f5>
  800e71:	83 fb 7e             	cmp    $0x7e,%ebx
  800e74:	7e 12                	jle    800e88 <vprintfmt+0x207>
					putch('?', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 3f                	push   $0x3f
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
  800e86:	eb 0f                	jmp    800e97 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e88:	83 ec 08             	sub    $0x8,%esp
  800e8b:	ff 75 0c             	pushl  0xc(%ebp)
  800e8e:	53                   	push   %ebx
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	ff d0                	call   *%eax
  800e94:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e97:	ff 4d e4             	decl   -0x1c(%ebp)
  800e9a:	89 f0                	mov    %esi,%eax
  800e9c:	8d 70 01             	lea    0x1(%eax),%esi
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	0f be d8             	movsbl %al,%ebx
  800ea4:	85 db                	test   %ebx,%ebx
  800ea6:	74 24                	je     800ecc <vprintfmt+0x24b>
  800ea8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eac:	78 b8                	js     800e66 <vprintfmt+0x1e5>
  800eae:	ff 4d e0             	decl   -0x20(%ebp)
  800eb1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb5:	79 af                	jns    800e66 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eb7:	eb 13                	jmp    800ecc <vprintfmt+0x24b>
				putch(' ', putdat);
  800eb9:	83 ec 08             	sub    $0x8,%esp
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	6a 20                	push   $0x20
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	ff d0                	call   *%eax
  800ec6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ec9:	ff 4d e4             	decl   -0x1c(%ebp)
  800ecc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ed0:	7f e7                	jg     800eb9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ed2:	e9 66 01 00 00       	jmp    80103d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ed7:	83 ec 08             	sub    $0x8,%esp
  800eda:	ff 75 e8             	pushl  -0x18(%ebp)
  800edd:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee0:	50                   	push   %eax
  800ee1:	e8 3c fd ff ff       	call   800c22 <getint>
  800ee6:	83 c4 10             	add    $0x10,%esp
  800ee9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ef2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef5:	85 d2                	test   %edx,%edx
  800ef7:	79 23                	jns    800f1c <vprintfmt+0x29b>
				putch('-', putdat);
  800ef9:	83 ec 08             	sub    $0x8,%esp
  800efc:	ff 75 0c             	pushl  0xc(%ebp)
  800eff:	6a 2d                	push   $0x2d
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	ff d0                	call   *%eax
  800f06:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0f:	f7 d8                	neg    %eax
  800f11:	83 d2 00             	adc    $0x0,%edx
  800f14:	f7 da                	neg    %edx
  800f16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f1c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f23:	e9 bc 00 00 00       	jmp    800fe4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f28:	83 ec 08             	sub    $0x8,%esp
  800f2b:	ff 75 e8             	pushl  -0x18(%ebp)
  800f2e:	8d 45 14             	lea    0x14(%ebp),%eax
  800f31:	50                   	push   %eax
  800f32:	e8 84 fc ff ff       	call   800bbb <getuint>
  800f37:	83 c4 10             	add    $0x10,%esp
  800f3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f3d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f40:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f47:	e9 98 00 00 00       	jmp    800fe4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f4c:	83 ec 08             	sub    $0x8,%esp
  800f4f:	ff 75 0c             	pushl  0xc(%ebp)
  800f52:	6a 58                	push   $0x58
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	ff d0                	call   *%eax
  800f59:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f5c:	83 ec 08             	sub    $0x8,%esp
  800f5f:	ff 75 0c             	pushl  0xc(%ebp)
  800f62:	6a 58                	push   $0x58
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	ff d0                	call   *%eax
  800f69:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f6c:	83 ec 08             	sub    $0x8,%esp
  800f6f:	ff 75 0c             	pushl  0xc(%ebp)
  800f72:	6a 58                	push   $0x58
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	ff d0                	call   *%eax
  800f79:	83 c4 10             	add    $0x10,%esp
			break;
  800f7c:	e9 bc 00 00 00       	jmp    80103d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f81:	83 ec 08             	sub    $0x8,%esp
  800f84:	ff 75 0c             	pushl  0xc(%ebp)
  800f87:	6a 30                	push   $0x30
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	ff d0                	call   *%eax
  800f8e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f91:	83 ec 08             	sub    $0x8,%esp
  800f94:	ff 75 0c             	pushl  0xc(%ebp)
  800f97:	6a 78                	push   $0x78
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	ff d0                	call   *%eax
  800f9e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fa1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa4:	83 c0 04             	add    $0x4,%eax
  800fa7:	89 45 14             	mov    %eax,0x14(%ebp)
  800faa:	8b 45 14             	mov    0x14(%ebp),%eax
  800fad:	83 e8 04             	sub    $0x4,%eax
  800fb0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fbc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fc3:	eb 1f                	jmp    800fe4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fc5:	83 ec 08             	sub    $0x8,%esp
  800fc8:	ff 75 e8             	pushl  -0x18(%ebp)
  800fcb:	8d 45 14             	lea    0x14(%ebp),%eax
  800fce:	50                   	push   %eax
  800fcf:	e8 e7 fb ff ff       	call   800bbb <getuint>
  800fd4:	83 c4 10             	add    $0x10,%esp
  800fd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fda:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fdd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fe4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fe8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800feb:	83 ec 04             	sub    $0x4,%esp
  800fee:	52                   	push   %edx
  800fef:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ff2:	50                   	push   %eax
  800ff3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff6:	ff 75 f0             	pushl  -0x10(%ebp)
  800ff9:	ff 75 0c             	pushl  0xc(%ebp)
  800ffc:	ff 75 08             	pushl  0x8(%ebp)
  800fff:	e8 00 fb ff ff       	call   800b04 <printnum>
  801004:	83 c4 20             	add    $0x20,%esp
			break;
  801007:	eb 34                	jmp    80103d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801009:	83 ec 08             	sub    $0x8,%esp
  80100c:	ff 75 0c             	pushl  0xc(%ebp)
  80100f:	53                   	push   %ebx
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	ff d0                	call   *%eax
  801015:	83 c4 10             	add    $0x10,%esp
			break;
  801018:	eb 23                	jmp    80103d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80101a:	83 ec 08             	sub    $0x8,%esp
  80101d:	ff 75 0c             	pushl  0xc(%ebp)
  801020:	6a 25                	push   $0x25
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	ff d0                	call   *%eax
  801027:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80102a:	ff 4d 10             	decl   0x10(%ebp)
  80102d:	eb 03                	jmp    801032 <vprintfmt+0x3b1>
  80102f:	ff 4d 10             	decl   0x10(%ebp)
  801032:	8b 45 10             	mov    0x10(%ebp),%eax
  801035:	48                   	dec    %eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	3c 25                	cmp    $0x25,%al
  80103a:	75 f3                	jne    80102f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80103c:	90                   	nop
		}
	}
  80103d:	e9 47 fc ff ff       	jmp    800c89 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801042:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801043:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801046:	5b                   	pop    %ebx
  801047:	5e                   	pop    %esi
  801048:	5d                   	pop    %ebp
  801049:	c3                   	ret    

0080104a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801050:	8d 45 10             	lea    0x10(%ebp),%eax
  801053:	83 c0 04             	add    $0x4,%eax
  801056:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801059:	8b 45 10             	mov    0x10(%ebp),%eax
  80105c:	ff 75 f4             	pushl  -0xc(%ebp)
  80105f:	50                   	push   %eax
  801060:	ff 75 0c             	pushl  0xc(%ebp)
  801063:	ff 75 08             	pushl  0x8(%ebp)
  801066:	e8 16 fc ff ff       	call   800c81 <vprintfmt>
  80106b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80106e:	90                   	nop
  80106f:	c9                   	leave  
  801070:	c3                   	ret    

00801071 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801071:	55                   	push   %ebp
  801072:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801074:	8b 45 0c             	mov    0xc(%ebp),%eax
  801077:	8b 40 08             	mov    0x8(%eax),%eax
  80107a:	8d 50 01             	lea    0x1(%eax),%edx
  80107d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801080:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801083:	8b 45 0c             	mov    0xc(%ebp),%eax
  801086:	8b 10                	mov    (%eax),%edx
  801088:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108b:	8b 40 04             	mov    0x4(%eax),%eax
  80108e:	39 c2                	cmp    %eax,%edx
  801090:	73 12                	jae    8010a4 <sprintputch+0x33>
		*b->buf++ = ch;
  801092:	8b 45 0c             	mov    0xc(%ebp),%eax
  801095:	8b 00                	mov    (%eax),%eax
  801097:	8d 48 01             	lea    0x1(%eax),%ecx
  80109a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109d:	89 0a                	mov    %ecx,(%edx)
  80109f:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a2:	88 10                	mov    %dl,(%eax)
}
  8010a4:	90                   	nop
  8010a5:	5d                   	pop    %ebp
  8010a6:	c3                   	ret    

008010a7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
  8010aa:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	01 d0                	add    %edx,%eax
  8010be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010cc:	74 06                	je     8010d4 <vsnprintf+0x2d>
  8010ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010d2:	7f 07                	jg     8010db <vsnprintf+0x34>
		return -E_INVAL;
  8010d4:	b8 03 00 00 00       	mov    $0x3,%eax
  8010d9:	eb 20                	jmp    8010fb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010db:	ff 75 14             	pushl  0x14(%ebp)
  8010de:	ff 75 10             	pushl  0x10(%ebp)
  8010e1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010e4:	50                   	push   %eax
  8010e5:	68 71 10 80 00       	push   $0x801071
  8010ea:	e8 92 fb ff ff       	call   800c81 <vprintfmt>
  8010ef:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010f5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010fb:	c9                   	leave  
  8010fc:	c3                   	ret    

008010fd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010fd:	55                   	push   %ebp
  8010fe:	89 e5                	mov    %esp,%ebp
  801100:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801103:	8d 45 10             	lea    0x10(%ebp),%eax
  801106:	83 c0 04             	add    $0x4,%eax
  801109:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80110c:	8b 45 10             	mov    0x10(%ebp),%eax
  80110f:	ff 75 f4             	pushl  -0xc(%ebp)
  801112:	50                   	push   %eax
  801113:	ff 75 0c             	pushl  0xc(%ebp)
  801116:	ff 75 08             	pushl  0x8(%ebp)
  801119:	e8 89 ff ff ff       	call   8010a7 <vsnprintf>
  80111e:	83 c4 10             	add    $0x10,%esp
  801121:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801124:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801127:	c9                   	leave  
  801128:	c3                   	ret    

00801129 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801129:	55                   	push   %ebp
  80112a:	89 e5                	mov    %esp,%ebp
  80112c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80112f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801136:	eb 06                	jmp    80113e <strlen+0x15>
		n++;
  801138:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80113b:	ff 45 08             	incl   0x8(%ebp)
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8a 00                	mov    (%eax),%al
  801143:	84 c0                	test   %al,%al
  801145:	75 f1                	jne    801138 <strlen+0xf>
		n++;
	return n;
  801147:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
  80114f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801152:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801159:	eb 09                	jmp    801164 <strnlen+0x18>
		n++;
  80115b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80115e:	ff 45 08             	incl   0x8(%ebp)
  801161:	ff 4d 0c             	decl   0xc(%ebp)
  801164:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801168:	74 09                	je     801173 <strnlen+0x27>
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	84 c0                	test   %al,%al
  801171:	75 e8                	jne    80115b <strnlen+0xf>
		n++;
	return n;
  801173:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
  80117b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801184:	90                   	nop
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	8d 50 01             	lea    0x1(%eax),%edx
  80118b:	89 55 08             	mov    %edx,0x8(%ebp)
  80118e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801191:	8d 4a 01             	lea    0x1(%edx),%ecx
  801194:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801197:	8a 12                	mov    (%edx),%dl
  801199:	88 10                	mov    %dl,(%eax)
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	84 c0                	test   %al,%al
  80119f:	75 e4                	jne    801185 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8011a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011a4:	c9                   	leave  
  8011a5:	c3                   	ret    

008011a6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8011a6:	55                   	push   %ebp
  8011a7:	89 e5                	mov    %esp,%ebp
  8011a9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8011b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011b9:	eb 1f                	jmp    8011da <strncpy+0x34>
		*dst++ = *src;
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	8d 50 01             	lea    0x1(%eax),%edx
  8011c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8011c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011c7:	8a 12                	mov    (%edx),%dl
  8011c9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ce:	8a 00                	mov    (%eax),%al
  8011d0:	84 c0                	test   %al,%al
  8011d2:	74 03                	je     8011d7 <strncpy+0x31>
			src++;
  8011d4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8011d7:	ff 45 fc             	incl   -0x4(%ebp)
  8011da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011dd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011e0:	72 d9                	jb     8011bb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8011e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011e5:	c9                   	leave  
  8011e6:	c3                   	ret    

008011e7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
  8011ea:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8011f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011f7:	74 30                	je     801229 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8011f9:	eb 16                	jmp    801211 <strlcpy+0x2a>
			*dst++ = *src++;
  8011fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fe:	8d 50 01             	lea    0x1(%eax),%edx
  801201:	89 55 08             	mov    %edx,0x8(%ebp)
  801204:	8b 55 0c             	mov    0xc(%ebp),%edx
  801207:	8d 4a 01             	lea    0x1(%edx),%ecx
  80120a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80120d:	8a 12                	mov    (%edx),%dl
  80120f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801211:	ff 4d 10             	decl   0x10(%ebp)
  801214:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801218:	74 09                	je     801223 <strlcpy+0x3c>
  80121a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121d:	8a 00                	mov    (%eax),%al
  80121f:	84 c0                	test   %al,%al
  801221:	75 d8                	jne    8011fb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801223:	8b 45 08             	mov    0x8(%ebp),%eax
  801226:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801229:	8b 55 08             	mov    0x8(%ebp),%edx
  80122c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122f:	29 c2                	sub    %eax,%edx
  801231:	89 d0                	mov    %edx,%eax
}
  801233:	c9                   	leave  
  801234:	c3                   	ret    

00801235 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801235:	55                   	push   %ebp
  801236:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801238:	eb 06                	jmp    801240 <strcmp+0xb>
		p++, q++;
  80123a:	ff 45 08             	incl   0x8(%ebp)
  80123d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801240:	8b 45 08             	mov    0x8(%ebp),%eax
  801243:	8a 00                	mov    (%eax),%al
  801245:	84 c0                	test   %al,%al
  801247:	74 0e                	je     801257 <strcmp+0x22>
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	8a 10                	mov    (%eax),%dl
  80124e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	38 c2                	cmp    %al,%dl
  801255:	74 e3                	je     80123a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	0f b6 d0             	movzbl %al,%edx
  80125f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801262:	8a 00                	mov    (%eax),%al
  801264:	0f b6 c0             	movzbl %al,%eax
  801267:	29 c2                	sub    %eax,%edx
  801269:	89 d0                	mov    %edx,%eax
}
  80126b:	5d                   	pop    %ebp
  80126c:	c3                   	ret    

0080126d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80126d:	55                   	push   %ebp
  80126e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801270:	eb 09                	jmp    80127b <strncmp+0xe>
		n--, p++, q++;
  801272:	ff 4d 10             	decl   0x10(%ebp)
  801275:	ff 45 08             	incl   0x8(%ebp)
  801278:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80127b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80127f:	74 17                	je     801298 <strncmp+0x2b>
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	8a 00                	mov    (%eax),%al
  801286:	84 c0                	test   %al,%al
  801288:	74 0e                	je     801298 <strncmp+0x2b>
  80128a:	8b 45 08             	mov    0x8(%ebp),%eax
  80128d:	8a 10                	mov    (%eax),%dl
  80128f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801292:	8a 00                	mov    (%eax),%al
  801294:	38 c2                	cmp    %al,%dl
  801296:	74 da                	je     801272 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801298:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80129c:	75 07                	jne    8012a5 <strncmp+0x38>
		return 0;
  80129e:	b8 00 00 00 00       	mov    $0x0,%eax
  8012a3:	eb 14                	jmp    8012b9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	8a 00                	mov    (%eax),%al
  8012aa:	0f b6 d0             	movzbl %al,%edx
  8012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	0f b6 c0             	movzbl %al,%eax
  8012b5:	29 c2                	sub    %eax,%edx
  8012b7:	89 d0                	mov    %edx,%eax
}
  8012b9:	5d                   	pop    %ebp
  8012ba:	c3                   	ret    

008012bb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
  8012be:	83 ec 04             	sub    $0x4,%esp
  8012c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012c7:	eb 12                	jmp    8012db <strchr+0x20>
		if (*s == c)
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	8a 00                	mov    (%eax),%al
  8012ce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012d1:	75 05                	jne    8012d8 <strchr+0x1d>
			return (char *) s;
  8012d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d6:	eb 11                	jmp    8012e9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8012d8:	ff 45 08             	incl   0x8(%ebp)
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	8a 00                	mov    (%eax),%al
  8012e0:	84 c0                	test   %al,%al
  8012e2:	75 e5                	jne    8012c9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8012e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
  8012ee:	83 ec 04             	sub    $0x4,%esp
  8012f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012f7:	eb 0d                	jmp    801306 <strfind+0x1b>
		if (*s == c)
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	8a 00                	mov    (%eax),%al
  8012fe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801301:	74 0e                	je     801311 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801303:	ff 45 08             	incl   0x8(%ebp)
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	8a 00                	mov    (%eax),%al
  80130b:	84 c0                	test   %al,%al
  80130d:	75 ea                	jne    8012f9 <strfind+0xe>
  80130f:	eb 01                	jmp    801312 <strfind+0x27>
		if (*s == c)
			break;
  801311:	90                   	nop
	return (char *) s;
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
  80131a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801323:	8b 45 10             	mov    0x10(%ebp),%eax
  801326:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801329:	eb 0e                	jmp    801339 <memset+0x22>
		*p++ = c;
  80132b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132e:	8d 50 01             	lea    0x1(%eax),%edx
  801331:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801334:	8b 55 0c             	mov    0xc(%ebp),%edx
  801337:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801339:	ff 4d f8             	decl   -0x8(%ebp)
  80133c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801340:	79 e9                	jns    80132b <memset+0x14>
		*p++ = c;

	return v;
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801345:	c9                   	leave  
  801346:	c3                   	ret    

00801347 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
  80134a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80134d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801350:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801359:	eb 16                	jmp    801371 <memcpy+0x2a>
		*d++ = *s++;
  80135b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80135e:	8d 50 01             	lea    0x1(%eax),%edx
  801361:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801364:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801367:	8d 4a 01             	lea    0x1(%edx),%ecx
  80136a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80136d:	8a 12                	mov    (%edx),%dl
  80136f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801371:	8b 45 10             	mov    0x10(%ebp),%eax
  801374:	8d 50 ff             	lea    -0x1(%eax),%edx
  801377:	89 55 10             	mov    %edx,0x10(%ebp)
  80137a:	85 c0                	test   %eax,%eax
  80137c:	75 dd                	jne    80135b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
  801386:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801389:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801395:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801398:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80139b:	73 50                	jae    8013ed <memmove+0x6a>
  80139d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a3:	01 d0                	add    %edx,%eax
  8013a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013a8:	76 43                	jbe    8013ed <memmove+0x6a>
		s += n;
  8013aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ad:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8013b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8013b6:	eb 10                	jmp    8013c8 <memmove+0x45>
			*--d = *--s;
  8013b8:	ff 4d f8             	decl   -0x8(%ebp)
  8013bb:	ff 4d fc             	decl   -0x4(%ebp)
  8013be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c1:	8a 10                	mov    (%eax),%dl
  8013c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013cb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013ce:	89 55 10             	mov    %edx,0x10(%ebp)
  8013d1:	85 c0                	test   %eax,%eax
  8013d3:	75 e3                	jne    8013b8 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8013d5:	eb 23                	jmp    8013fa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8013d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013da:	8d 50 01             	lea    0x1(%eax),%edx
  8013dd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013e3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013e6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013e9:	8a 12                	mov    (%edx),%dl
  8013eb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8013f6:	85 c0                	test   %eax,%eax
  8013f8:	75 dd                	jne    8013d7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
  801402:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80140b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801411:	eb 2a                	jmp    80143d <memcmp+0x3e>
		if (*s1 != *s2)
  801413:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801416:	8a 10                	mov    (%eax),%dl
  801418:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	38 c2                	cmp    %al,%dl
  80141f:	74 16                	je     801437 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801421:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	0f b6 d0             	movzbl %al,%edx
  801429:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	0f b6 c0             	movzbl %al,%eax
  801431:	29 c2                	sub    %eax,%edx
  801433:	89 d0                	mov    %edx,%eax
  801435:	eb 18                	jmp    80144f <memcmp+0x50>
		s1++, s2++;
  801437:	ff 45 fc             	incl   -0x4(%ebp)
  80143a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80143d:	8b 45 10             	mov    0x10(%ebp),%eax
  801440:	8d 50 ff             	lea    -0x1(%eax),%edx
  801443:	89 55 10             	mov    %edx,0x10(%ebp)
  801446:	85 c0                	test   %eax,%eax
  801448:	75 c9                	jne    801413 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80144a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80144f:	c9                   	leave  
  801450:	c3                   	ret    

00801451 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
  801454:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801457:	8b 55 08             	mov    0x8(%ebp),%edx
  80145a:	8b 45 10             	mov    0x10(%ebp),%eax
  80145d:	01 d0                	add    %edx,%eax
  80145f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801462:	eb 15                	jmp    801479 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	0f b6 d0             	movzbl %al,%edx
  80146c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146f:	0f b6 c0             	movzbl %al,%eax
  801472:	39 c2                	cmp    %eax,%edx
  801474:	74 0d                	je     801483 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801476:	ff 45 08             	incl   0x8(%ebp)
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80147f:	72 e3                	jb     801464 <memfind+0x13>
  801481:	eb 01                	jmp    801484 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801483:	90                   	nop
	return (void *) s;
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801487:	c9                   	leave  
  801488:	c3                   	ret    

00801489 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801489:	55                   	push   %ebp
  80148a:	89 e5                	mov    %esp,%ebp
  80148c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80148f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801496:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80149d:	eb 03                	jmp    8014a2 <strtol+0x19>
		s++;
  80149f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	3c 20                	cmp    $0x20,%al
  8014a9:	74 f4                	je     80149f <strtol+0x16>
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	8a 00                	mov    (%eax),%al
  8014b0:	3c 09                	cmp    $0x9,%al
  8014b2:	74 eb                	je     80149f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	8a 00                	mov    (%eax),%al
  8014b9:	3c 2b                	cmp    $0x2b,%al
  8014bb:	75 05                	jne    8014c2 <strtol+0x39>
		s++;
  8014bd:	ff 45 08             	incl   0x8(%ebp)
  8014c0:	eb 13                	jmp    8014d5 <strtol+0x4c>
	else if (*s == '-')
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	3c 2d                	cmp    $0x2d,%al
  8014c9:	75 0a                	jne    8014d5 <strtol+0x4c>
		s++, neg = 1;
  8014cb:	ff 45 08             	incl   0x8(%ebp)
  8014ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8014d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d9:	74 06                	je     8014e1 <strtol+0x58>
  8014db:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8014df:	75 20                	jne    801501 <strtol+0x78>
  8014e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e4:	8a 00                	mov    (%eax),%al
  8014e6:	3c 30                	cmp    $0x30,%al
  8014e8:	75 17                	jne    801501 <strtol+0x78>
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	40                   	inc    %eax
  8014ee:	8a 00                	mov    (%eax),%al
  8014f0:	3c 78                	cmp    $0x78,%al
  8014f2:	75 0d                	jne    801501 <strtol+0x78>
		s += 2, base = 16;
  8014f4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8014f8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8014ff:	eb 28                	jmp    801529 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801501:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801505:	75 15                	jne    80151c <strtol+0x93>
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	8a 00                	mov    (%eax),%al
  80150c:	3c 30                	cmp    $0x30,%al
  80150e:	75 0c                	jne    80151c <strtol+0x93>
		s++, base = 8;
  801510:	ff 45 08             	incl   0x8(%ebp)
  801513:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80151a:	eb 0d                	jmp    801529 <strtol+0xa0>
	else if (base == 0)
  80151c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801520:	75 07                	jne    801529 <strtol+0xa0>
		base = 10;
  801522:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	8a 00                	mov    (%eax),%al
  80152e:	3c 2f                	cmp    $0x2f,%al
  801530:	7e 19                	jle    80154b <strtol+0xc2>
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	3c 39                	cmp    $0x39,%al
  801539:	7f 10                	jg     80154b <strtol+0xc2>
			dig = *s - '0';
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	0f be c0             	movsbl %al,%eax
  801543:	83 e8 30             	sub    $0x30,%eax
  801546:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801549:	eb 42                	jmp    80158d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	8a 00                	mov    (%eax),%al
  801550:	3c 60                	cmp    $0x60,%al
  801552:	7e 19                	jle    80156d <strtol+0xe4>
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	8a 00                	mov    (%eax),%al
  801559:	3c 7a                	cmp    $0x7a,%al
  80155b:	7f 10                	jg     80156d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	8a 00                	mov    (%eax),%al
  801562:	0f be c0             	movsbl %al,%eax
  801565:	83 e8 57             	sub    $0x57,%eax
  801568:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80156b:	eb 20                	jmp    80158d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	8a 00                	mov    (%eax),%al
  801572:	3c 40                	cmp    $0x40,%al
  801574:	7e 39                	jle    8015af <strtol+0x126>
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	8a 00                	mov    (%eax),%al
  80157b:	3c 5a                	cmp    $0x5a,%al
  80157d:	7f 30                	jg     8015af <strtol+0x126>
			dig = *s - 'A' + 10;
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	8a 00                	mov    (%eax),%al
  801584:	0f be c0             	movsbl %al,%eax
  801587:	83 e8 37             	sub    $0x37,%eax
  80158a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80158d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801590:	3b 45 10             	cmp    0x10(%ebp),%eax
  801593:	7d 19                	jge    8015ae <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801595:	ff 45 08             	incl   0x8(%ebp)
  801598:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80159b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80159f:	89 c2                	mov    %eax,%edx
  8015a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015a4:	01 d0                	add    %edx,%eax
  8015a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8015a9:	e9 7b ff ff ff       	jmp    801529 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8015ae:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8015af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015b3:	74 08                	je     8015bd <strtol+0x134>
		*endptr = (char *) s;
  8015b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8015bb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015c1:	74 07                	je     8015ca <strtol+0x141>
  8015c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c6:	f7 d8                	neg    %eax
  8015c8:	eb 03                	jmp    8015cd <strtol+0x144>
  8015ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <ltostr>:

void
ltostr(long value, char *str)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
  8015d2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8015d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8015dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8015e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015e7:	79 13                	jns    8015fc <ltostr+0x2d>
	{
		neg = 1;
  8015e9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8015f6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8015f9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801604:	99                   	cltd   
  801605:	f7 f9                	idiv   %ecx
  801607:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80160a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80160d:	8d 50 01             	lea    0x1(%eax),%edx
  801610:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801613:	89 c2                	mov    %eax,%edx
  801615:	8b 45 0c             	mov    0xc(%ebp),%eax
  801618:	01 d0                	add    %edx,%eax
  80161a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80161d:	83 c2 30             	add    $0x30,%edx
  801620:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801622:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801625:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80162a:	f7 e9                	imul   %ecx
  80162c:	c1 fa 02             	sar    $0x2,%edx
  80162f:	89 c8                	mov    %ecx,%eax
  801631:	c1 f8 1f             	sar    $0x1f,%eax
  801634:	29 c2                	sub    %eax,%edx
  801636:	89 d0                	mov    %edx,%eax
  801638:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80163b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80163e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801643:	f7 e9                	imul   %ecx
  801645:	c1 fa 02             	sar    $0x2,%edx
  801648:	89 c8                	mov    %ecx,%eax
  80164a:	c1 f8 1f             	sar    $0x1f,%eax
  80164d:	29 c2                	sub    %eax,%edx
  80164f:	89 d0                	mov    %edx,%eax
  801651:	c1 e0 02             	shl    $0x2,%eax
  801654:	01 d0                	add    %edx,%eax
  801656:	01 c0                	add    %eax,%eax
  801658:	29 c1                	sub    %eax,%ecx
  80165a:	89 ca                	mov    %ecx,%edx
  80165c:	85 d2                	test   %edx,%edx
  80165e:	75 9c                	jne    8015fc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801660:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801667:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80166a:	48                   	dec    %eax
  80166b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80166e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801672:	74 3d                	je     8016b1 <ltostr+0xe2>
		start = 1 ;
  801674:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80167b:	eb 34                	jmp    8016b1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80167d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801680:	8b 45 0c             	mov    0xc(%ebp),%eax
  801683:	01 d0                	add    %edx,%eax
  801685:	8a 00                	mov    (%eax),%al
  801687:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80168a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80168d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801690:	01 c2                	add    %eax,%edx
  801692:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801695:	8b 45 0c             	mov    0xc(%ebp),%eax
  801698:	01 c8                	add    %ecx,%eax
  80169a:	8a 00                	mov    (%eax),%al
  80169c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80169e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a4:	01 c2                	add    %eax,%edx
  8016a6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8016a9:	88 02                	mov    %al,(%edx)
		start++ ;
  8016ab:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8016ae:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8016b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016b7:	7c c4                	jl     80167d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016bf:	01 d0                	add    %edx,%eax
  8016c1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016c4:	90                   	nop
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
  8016ca:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8016cd:	ff 75 08             	pushl  0x8(%ebp)
  8016d0:	e8 54 fa ff ff       	call   801129 <strlen>
  8016d5:	83 c4 04             	add    $0x4,%esp
  8016d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8016db:	ff 75 0c             	pushl  0xc(%ebp)
  8016de:	e8 46 fa ff ff       	call   801129 <strlen>
  8016e3:	83 c4 04             	add    $0x4,%esp
  8016e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016f7:	eb 17                	jmp    801710 <strcconcat+0x49>
		final[s] = str1[s] ;
  8016f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ff:	01 c2                	add    %eax,%edx
  801701:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	01 c8                	add    %ecx,%eax
  801709:	8a 00                	mov    (%eax),%al
  80170b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80170d:	ff 45 fc             	incl   -0x4(%ebp)
  801710:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801713:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801716:	7c e1                	jl     8016f9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801718:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80171f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801726:	eb 1f                	jmp    801747 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801728:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80172b:	8d 50 01             	lea    0x1(%eax),%edx
  80172e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801731:	89 c2                	mov    %eax,%edx
  801733:	8b 45 10             	mov    0x10(%ebp),%eax
  801736:	01 c2                	add    %eax,%edx
  801738:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80173b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173e:	01 c8                	add    %ecx,%eax
  801740:	8a 00                	mov    (%eax),%al
  801742:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801744:	ff 45 f8             	incl   -0x8(%ebp)
  801747:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80174a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80174d:	7c d9                	jl     801728 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80174f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801752:	8b 45 10             	mov    0x10(%ebp),%eax
  801755:	01 d0                	add    %edx,%eax
  801757:	c6 00 00             	movb   $0x0,(%eax)
}
  80175a:	90                   	nop
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801760:	8b 45 14             	mov    0x14(%ebp),%eax
  801763:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801769:	8b 45 14             	mov    0x14(%ebp),%eax
  80176c:	8b 00                	mov    (%eax),%eax
  80176e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801775:	8b 45 10             	mov    0x10(%ebp),%eax
  801778:	01 d0                	add    %edx,%eax
  80177a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801780:	eb 0c                	jmp    80178e <strsplit+0x31>
			*string++ = 0;
  801782:	8b 45 08             	mov    0x8(%ebp),%eax
  801785:	8d 50 01             	lea    0x1(%eax),%edx
  801788:	89 55 08             	mov    %edx,0x8(%ebp)
  80178b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80178e:	8b 45 08             	mov    0x8(%ebp),%eax
  801791:	8a 00                	mov    (%eax),%al
  801793:	84 c0                	test   %al,%al
  801795:	74 18                	je     8017af <strsplit+0x52>
  801797:	8b 45 08             	mov    0x8(%ebp),%eax
  80179a:	8a 00                	mov    (%eax),%al
  80179c:	0f be c0             	movsbl %al,%eax
  80179f:	50                   	push   %eax
  8017a0:	ff 75 0c             	pushl  0xc(%ebp)
  8017a3:	e8 13 fb ff ff       	call   8012bb <strchr>
  8017a8:	83 c4 08             	add    $0x8,%esp
  8017ab:	85 c0                	test   %eax,%eax
  8017ad:	75 d3                	jne    801782 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b2:	8a 00                	mov    (%eax),%al
  8017b4:	84 c0                	test   %al,%al
  8017b6:	74 5a                	je     801812 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8017b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8017bb:	8b 00                	mov    (%eax),%eax
  8017bd:	83 f8 0f             	cmp    $0xf,%eax
  8017c0:	75 07                	jne    8017c9 <strsplit+0x6c>
		{
			return 0;
  8017c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8017c7:	eb 66                	jmp    80182f <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8017cc:	8b 00                	mov    (%eax),%eax
  8017ce:	8d 48 01             	lea    0x1(%eax),%ecx
  8017d1:	8b 55 14             	mov    0x14(%ebp),%edx
  8017d4:	89 0a                	mov    %ecx,(%edx)
  8017d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e0:	01 c2                	add    %eax,%edx
  8017e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017e7:	eb 03                	jmp    8017ec <strsplit+0x8f>
			string++;
  8017e9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	8a 00                	mov    (%eax),%al
  8017f1:	84 c0                	test   %al,%al
  8017f3:	74 8b                	je     801780 <strsplit+0x23>
  8017f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f8:	8a 00                	mov    (%eax),%al
  8017fa:	0f be c0             	movsbl %al,%eax
  8017fd:	50                   	push   %eax
  8017fe:	ff 75 0c             	pushl  0xc(%ebp)
  801801:	e8 b5 fa ff ff       	call   8012bb <strchr>
  801806:	83 c4 08             	add    $0x8,%esp
  801809:	85 c0                	test   %eax,%eax
  80180b:	74 dc                	je     8017e9 <strsplit+0x8c>
			string++;
	}
  80180d:	e9 6e ff ff ff       	jmp    801780 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801812:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801813:	8b 45 14             	mov    0x14(%ebp),%eax
  801816:	8b 00                	mov    (%eax),%eax
  801818:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80181f:	8b 45 10             	mov    0x10(%ebp),%eax
  801822:	01 d0                	add    %edx,%eax
  801824:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80182a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80182f:	c9                   	leave  
  801830:	c3                   	ret    

00801831 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
  801834:	83 ec 18             	sub    $0x18,%esp
  801837:	8b 45 10             	mov    0x10(%ebp),%eax
  80183a:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80183d:	83 ec 04             	sub    $0x4,%esp
  801840:	68 10 2a 80 00       	push   $0x802a10
  801845:	6a 17                	push   $0x17
  801847:	68 2f 2a 80 00       	push   $0x802a2f
  80184c:	e8 a2 ef ff ff       	call   8007f3 <_panic>

00801851 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
  801854:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801857:	83 ec 04             	sub    $0x4,%esp
  80185a:	68 3b 2a 80 00       	push   $0x802a3b
  80185f:	6a 2f                	push   $0x2f
  801861:	68 2f 2a 80 00       	push   $0x802a2f
  801866:	e8 88 ef ff ff       	call   8007f3 <_panic>

0080186b <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
  80186e:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801871:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801878:	8b 55 08             	mov    0x8(%ebp),%edx
  80187b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80187e:	01 d0                	add    %edx,%eax
  801880:	48                   	dec    %eax
  801881:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801884:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801887:	ba 00 00 00 00       	mov    $0x0,%edx
  80188c:	f7 75 ec             	divl   -0x14(%ebp)
  80188f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801892:	29 d0                	sub    %edx,%eax
  801894:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801897:	8b 45 08             	mov    0x8(%ebp),%eax
  80189a:	c1 e8 0c             	shr    $0xc,%eax
  80189d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8018a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8018a7:	e9 c8 00 00 00       	jmp    801974 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8018ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018b3:	eb 27                	jmp    8018dc <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8018b5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018bb:	01 c2                	add    %eax,%edx
  8018bd:	89 d0                	mov    %edx,%eax
  8018bf:	01 c0                	add    %eax,%eax
  8018c1:	01 d0                	add    %edx,%eax
  8018c3:	c1 e0 02             	shl    $0x2,%eax
  8018c6:	05 48 30 80 00       	add    $0x803048,%eax
  8018cb:	8b 00                	mov    (%eax),%eax
  8018cd:	85 c0                	test   %eax,%eax
  8018cf:	74 08                	je     8018d9 <malloc+0x6e>
            	i += j;
  8018d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d4:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8018d7:	eb 0b                	jmp    8018e4 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8018d9:	ff 45 f0             	incl   -0x10(%ebp)
  8018dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018df:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018e2:	72 d1                	jb     8018b5 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8018e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018e7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8018ea:	0f 85 81 00 00 00    	jne    801971 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8018f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018f3:	05 00 00 08 00       	add    $0x80000,%eax
  8018f8:	c1 e0 0c             	shl    $0xc,%eax
  8018fb:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8018fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801905:	eb 1f                	jmp    801926 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801907:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80190a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80190d:	01 c2                	add    %eax,%edx
  80190f:	89 d0                	mov    %edx,%eax
  801911:	01 c0                	add    %eax,%eax
  801913:	01 d0                	add    %edx,%eax
  801915:	c1 e0 02             	shl    $0x2,%eax
  801918:	05 48 30 80 00       	add    $0x803048,%eax
  80191d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801923:	ff 45 f0             	incl   -0x10(%ebp)
  801926:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801929:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80192c:	72 d9                	jb     801907 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80192e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801931:	89 d0                	mov    %edx,%eax
  801933:	01 c0                	add    %eax,%eax
  801935:	01 d0                	add    %edx,%eax
  801937:	c1 e0 02             	shl    $0x2,%eax
  80193a:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801940:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801943:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801945:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801948:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80194b:	89 c8                	mov    %ecx,%eax
  80194d:	01 c0                	add    %eax,%eax
  80194f:	01 c8                	add    %ecx,%eax
  801951:	c1 e0 02             	shl    $0x2,%eax
  801954:	05 44 30 80 00       	add    $0x803044,%eax
  801959:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80195b:	83 ec 08             	sub    $0x8,%esp
  80195e:	ff 75 08             	pushl  0x8(%ebp)
  801961:	ff 75 e0             	pushl  -0x20(%ebp)
  801964:	e8 2b 03 00 00       	call   801c94 <sys_allocateMem>
  801969:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80196c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80196f:	eb 19                	jmp    80198a <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801971:	ff 45 f4             	incl   -0xc(%ebp)
  801974:	a1 04 30 80 00       	mov    0x803004,%eax
  801979:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80197c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80197f:	0f 83 27 ff ff ff    	jae    8018ac <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801985:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80198a:	c9                   	leave  
  80198b:	c3                   	ret    

0080198c <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
  80198f:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801992:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801996:	0f 84 e5 00 00 00    	je     801a81 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8019a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019a5:	05 00 00 00 80       	add    $0x80000000,%eax
  8019aa:	c1 e8 0c             	shr    $0xc,%eax
  8019ad:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8019b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019b3:	89 d0                	mov    %edx,%eax
  8019b5:	01 c0                	add    %eax,%eax
  8019b7:	01 d0                	add    %edx,%eax
  8019b9:	c1 e0 02             	shl    $0x2,%eax
  8019bc:	05 40 30 80 00       	add    $0x803040,%eax
  8019c1:	8b 00                	mov    (%eax),%eax
  8019c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019c6:	0f 85 b8 00 00 00    	jne    801a84 <free+0xf8>
  8019cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019cf:	89 d0                	mov    %edx,%eax
  8019d1:	01 c0                	add    %eax,%eax
  8019d3:	01 d0                	add    %edx,%eax
  8019d5:	c1 e0 02             	shl    $0x2,%eax
  8019d8:	05 48 30 80 00       	add    $0x803048,%eax
  8019dd:	8b 00                	mov    (%eax),%eax
  8019df:	85 c0                	test   %eax,%eax
  8019e1:	0f 84 9d 00 00 00    	je     801a84 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8019e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019ea:	89 d0                	mov    %edx,%eax
  8019ec:	01 c0                	add    %eax,%eax
  8019ee:	01 d0                	add    %edx,%eax
  8019f0:	c1 e0 02             	shl    $0x2,%eax
  8019f3:	05 44 30 80 00       	add    $0x803044,%eax
  8019f8:	8b 00                	mov    (%eax),%eax
  8019fa:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8019fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a00:	c1 e0 0c             	shl    $0xc,%eax
  801a03:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801a06:	83 ec 08             	sub    $0x8,%esp
  801a09:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a0c:	ff 75 f0             	pushl  -0x10(%ebp)
  801a0f:	e8 64 02 00 00       	call   801c78 <sys_freeMem>
  801a14:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801a17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a1e:	eb 57                	jmp    801a77 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801a20:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a26:	01 c2                	add    %eax,%edx
  801a28:	89 d0                	mov    %edx,%eax
  801a2a:	01 c0                	add    %eax,%eax
  801a2c:	01 d0                	add    %edx,%eax
  801a2e:	c1 e0 02             	shl    $0x2,%eax
  801a31:	05 48 30 80 00       	add    $0x803048,%eax
  801a36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801a3c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a42:	01 c2                	add    %eax,%edx
  801a44:	89 d0                	mov    %edx,%eax
  801a46:	01 c0                	add    %eax,%eax
  801a48:	01 d0                	add    %edx,%eax
  801a4a:	c1 e0 02             	shl    $0x2,%eax
  801a4d:	05 40 30 80 00       	add    $0x803040,%eax
  801a52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801a58:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a5e:	01 c2                	add    %eax,%edx
  801a60:	89 d0                	mov    %edx,%eax
  801a62:	01 c0                	add    %eax,%eax
  801a64:	01 d0                	add    %edx,%eax
  801a66:	c1 e0 02             	shl    $0x2,%eax
  801a69:	05 44 30 80 00       	add    $0x803044,%eax
  801a6e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801a74:	ff 45 f4             	incl   -0xc(%ebp)
  801a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a7a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a7d:	7c a1                	jl     801a20 <free+0x94>
  801a7f:	eb 04                	jmp    801a85 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801a81:	90                   	nop
  801a82:	eb 01                	jmp    801a85 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801a84:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
  801a8a:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801a8d:	83 ec 04             	sub    $0x4,%esp
  801a90:	68 58 2a 80 00       	push   $0x802a58
  801a95:	68 ae 00 00 00       	push   $0xae
  801a9a:	68 2f 2a 80 00       	push   $0x802a2f
  801a9f:	e8 4f ed ff ff       	call   8007f3 <_panic>

00801aa4 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
  801aa7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801aaa:	83 ec 04             	sub    $0x4,%esp
  801aad:	68 78 2a 80 00       	push   $0x802a78
  801ab2:	68 ca 00 00 00       	push   $0xca
  801ab7:	68 2f 2a 80 00       	push   $0x802a2f
  801abc:	e8 32 ed ff ff       	call   8007f3 <_panic>

00801ac1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
  801ac4:	57                   	push   %edi
  801ac5:	56                   	push   %esi
  801ac6:	53                   	push   %ebx
  801ac7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801aca:	8b 45 08             	mov    0x8(%ebp),%eax
  801acd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ad3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ad6:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ad9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801adc:	cd 30                	int    $0x30
  801ade:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ae1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ae4:	83 c4 10             	add    $0x10,%esp
  801ae7:	5b                   	pop    %ebx
  801ae8:	5e                   	pop    %esi
  801ae9:	5f                   	pop    %edi
  801aea:	5d                   	pop    %ebp
  801aeb:	c3                   	ret    

00801aec <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801aec:	55                   	push   %ebp
  801aed:	89 e5                	mov    %esp,%ebp
  801aef:	83 ec 04             	sub    $0x4,%esp
  801af2:	8b 45 10             	mov    0x10(%ebp),%eax
  801af5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801af8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801afc:	8b 45 08             	mov    0x8(%ebp),%eax
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	52                   	push   %edx
  801b04:	ff 75 0c             	pushl  0xc(%ebp)
  801b07:	50                   	push   %eax
  801b08:	6a 00                	push   $0x0
  801b0a:	e8 b2 ff ff ff       	call   801ac1 <syscall>
  801b0f:	83 c4 18             	add    $0x18,%esp
}
  801b12:	90                   	nop
  801b13:	c9                   	leave  
  801b14:	c3                   	ret    

00801b15 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b15:	55                   	push   %ebp
  801b16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 01                	push   $0x1
  801b24:	e8 98 ff ff ff       	call   801ac1 <syscall>
  801b29:	83 c4 18             	add    $0x18,%esp
}
  801b2c:	c9                   	leave  
  801b2d:	c3                   	ret    

00801b2e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b2e:	55                   	push   %ebp
  801b2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b31:	8b 45 08             	mov    0x8(%ebp),%eax
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	50                   	push   %eax
  801b3d:	6a 05                	push   $0x5
  801b3f:	e8 7d ff ff ff       	call   801ac1 <syscall>
  801b44:	83 c4 18             	add    $0x18,%esp
}
  801b47:	c9                   	leave  
  801b48:	c3                   	ret    

00801b49 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 02                	push   $0x2
  801b58:	e8 64 ff ff ff       	call   801ac1 <syscall>
  801b5d:	83 c4 18             	add    $0x18,%esp
}
  801b60:	c9                   	leave  
  801b61:	c3                   	ret    

00801b62 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b62:	55                   	push   %ebp
  801b63:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 03                	push   $0x3
  801b71:	e8 4b ff ff ff       	call   801ac1 <syscall>
  801b76:	83 c4 18             	add    $0x18,%esp
}
  801b79:	c9                   	leave  
  801b7a:	c3                   	ret    

00801b7b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 04                	push   $0x4
  801b8a:	e8 32 ff ff ff       	call   801ac1 <syscall>
  801b8f:	83 c4 18             	add    $0x18,%esp
}
  801b92:	c9                   	leave  
  801b93:	c3                   	ret    

00801b94 <sys_env_exit>:


void sys_env_exit(void)
{
  801b94:	55                   	push   %ebp
  801b95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 06                	push   $0x6
  801ba3:	e8 19 ff ff ff       	call   801ac1 <syscall>
  801ba8:	83 c4 18             	add    $0x18,%esp
}
  801bab:	90                   	nop
  801bac:	c9                   	leave  
  801bad:	c3                   	ret    

00801bae <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bb1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	52                   	push   %edx
  801bbe:	50                   	push   %eax
  801bbf:	6a 07                	push   $0x7
  801bc1:	e8 fb fe ff ff       	call   801ac1 <syscall>
  801bc6:	83 c4 18             	add    $0x18,%esp
}
  801bc9:	c9                   	leave  
  801bca:	c3                   	ret    

00801bcb <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bcb:	55                   	push   %ebp
  801bcc:	89 e5                	mov    %esp,%ebp
  801bce:	56                   	push   %esi
  801bcf:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bd0:	8b 75 18             	mov    0x18(%ebp),%esi
  801bd3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bd6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdf:	56                   	push   %esi
  801be0:	53                   	push   %ebx
  801be1:	51                   	push   %ecx
  801be2:	52                   	push   %edx
  801be3:	50                   	push   %eax
  801be4:	6a 08                	push   $0x8
  801be6:	e8 d6 fe ff ff       	call   801ac1 <syscall>
  801beb:	83 c4 18             	add    $0x18,%esp
}
  801bee:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bf1:	5b                   	pop    %ebx
  801bf2:	5e                   	pop    %esi
  801bf3:	5d                   	pop    %ebp
  801bf4:	c3                   	ret    

00801bf5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	52                   	push   %edx
  801c05:	50                   	push   %eax
  801c06:	6a 09                	push   $0x9
  801c08:	e8 b4 fe ff ff       	call   801ac1 <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
}
  801c10:	c9                   	leave  
  801c11:	c3                   	ret    

00801c12 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c12:	55                   	push   %ebp
  801c13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	ff 75 0c             	pushl  0xc(%ebp)
  801c1e:	ff 75 08             	pushl  0x8(%ebp)
  801c21:	6a 0a                	push   $0xa
  801c23:	e8 99 fe ff ff       	call   801ac1 <syscall>
  801c28:	83 c4 18             	add    $0x18,%esp
}
  801c2b:	c9                   	leave  
  801c2c:	c3                   	ret    

00801c2d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 0b                	push   $0xb
  801c3c:	e8 80 fe ff ff       	call   801ac1 <syscall>
  801c41:	83 c4 18             	add    $0x18,%esp
}
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 0c                	push   $0xc
  801c55:	e8 67 fe ff ff       	call   801ac1 <syscall>
  801c5a:	83 c4 18             	add    $0x18,%esp
}
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 0d                	push   $0xd
  801c6e:	e8 4e fe ff ff       	call   801ac1 <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
}
  801c76:	c9                   	leave  
  801c77:	c3                   	ret    

00801c78 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c78:	55                   	push   %ebp
  801c79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	ff 75 0c             	pushl  0xc(%ebp)
  801c84:	ff 75 08             	pushl  0x8(%ebp)
  801c87:	6a 11                	push   $0x11
  801c89:	e8 33 fe ff ff       	call   801ac1 <syscall>
  801c8e:	83 c4 18             	add    $0x18,%esp
	return;
  801c91:	90                   	nop
}
  801c92:	c9                   	leave  
  801c93:	c3                   	ret    

00801c94 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c94:	55                   	push   %ebp
  801c95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ca0:	ff 75 08             	pushl  0x8(%ebp)
  801ca3:	6a 12                	push   $0x12
  801ca5:	e8 17 fe ff ff       	call   801ac1 <syscall>
  801caa:	83 c4 18             	add    $0x18,%esp
	return ;
  801cad:	90                   	nop
}
  801cae:	c9                   	leave  
  801caf:	c3                   	ret    

00801cb0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cb0:	55                   	push   %ebp
  801cb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 0e                	push   $0xe
  801cbf:	e8 fd fd ff ff       	call   801ac1 <syscall>
  801cc4:	83 c4 18             	add    $0x18,%esp
}
  801cc7:	c9                   	leave  
  801cc8:	c3                   	ret    

00801cc9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cc9:	55                   	push   %ebp
  801cca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	ff 75 08             	pushl  0x8(%ebp)
  801cd7:	6a 0f                	push   $0xf
  801cd9:	e8 e3 fd ff ff       	call   801ac1 <syscall>
  801cde:	83 c4 18             	add    $0x18,%esp
}
  801ce1:	c9                   	leave  
  801ce2:	c3                   	ret    

00801ce3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ce3:	55                   	push   %ebp
  801ce4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 10                	push   $0x10
  801cf2:	e8 ca fd ff ff       	call   801ac1 <syscall>
  801cf7:	83 c4 18             	add    $0x18,%esp
}
  801cfa:	90                   	nop
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 14                	push   $0x14
  801d0c:	e8 b0 fd ff ff       	call   801ac1 <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
}
  801d14:	90                   	nop
  801d15:	c9                   	leave  
  801d16:	c3                   	ret    

00801d17 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 15                	push   $0x15
  801d26:	e8 96 fd ff ff       	call   801ac1 <syscall>
  801d2b:	83 c4 18             	add    $0x18,%esp
}
  801d2e:	90                   	nop
  801d2f:	c9                   	leave  
  801d30:	c3                   	ret    

00801d31 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d31:	55                   	push   %ebp
  801d32:	89 e5                	mov    %esp,%ebp
  801d34:	83 ec 04             	sub    $0x4,%esp
  801d37:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d3d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	50                   	push   %eax
  801d4a:	6a 16                	push   $0x16
  801d4c:	e8 70 fd ff ff       	call   801ac1 <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
}
  801d54:	90                   	nop
  801d55:	c9                   	leave  
  801d56:	c3                   	ret    

00801d57 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d57:	55                   	push   %ebp
  801d58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 17                	push   $0x17
  801d66:	e8 56 fd ff ff       	call   801ac1 <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
}
  801d6e:	90                   	nop
  801d6f:	c9                   	leave  
  801d70:	c3                   	ret    

00801d71 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d74:	8b 45 08             	mov    0x8(%ebp),%eax
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	ff 75 0c             	pushl  0xc(%ebp)
  801d80:	50                   	push   %eax
  801d81:	6a 18                	push   $0x18
  801d83:	e8 39 fd ff ff       	call   801ac1 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d93:	8b 45 08             	mov    0x8(%ebp),%eax
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	52                   	push   %edx
  801d9d:	50                   	push   %eax
  801d9e:	6a 1b                	push   $0x1b
  801da0:	e8 1c fd ff ff       	call   801ac1 <syscall>
  801da5:	83 c4 18             	add    $0x18,%esp
}
  801da8:	c9                   	leave  
  801da9:	c3                   	ret    

00801daa <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dad:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db0:	8b 45 08             	mov    0x8(%ebp),%eax
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	52                   	push   %edx
  801dba:	50                   	push   %eax
  801dbb:	6a 19                	push   $0x19
  801dbd:	e8 ff fc ff ff       	call   801ac1 <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	90                   	nop
  801dc6:	c9                   	leave  
  801dc7:	c3                   	ret    

00801dc8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dc8:	55                   	push   %ebp
  801dc9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dce:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	52                   	push   %edx
  801dd8:	50                   	push   %eax
  801dd9:	6a 1a                	push   $0x1a
  801ddb:	e8 e1 fc ff ff       	call   801ac1 <syscall>
  801de0:	83 c4 18             	add    $0x18,%esp
}
  801de3:	90                   	nop
  801de4:	c9                   	leave  
  801de5:	c3                   	ret    

00801de6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801de6:	55                   	push   %ebp
  801de7:	89 e5                	mov    %esp,%ebp
  801de9:	83 ec 04             	sub    $0x4,%esp
  801dec:	8b 45 10             	mov    0x10(%ebp),%eax
  801def:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801df2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801df5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801df9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfc:	6a 00                	push   $0x0
  801dfe:	51                   	push   %ecx
  801dff:	52                   	push   %edx
  801e00:	ff 75 0c             	pushl  0xc(%ebp)
  801e03:	50                   	push   %eax
  801e04:	6a 1c                	push   $0x1c
  801e06:	e8 b6 fc ff ff       	call   801ac1 <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
}
  801e0e:	c9                   	leave  
  801e0f:	c3                   	ret    

00801e10 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e10:	55                   	push   %ebp
  801e11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e16:	8b 45 08             	mov    0x8(%ebp),%eax
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	52                   	push   %edx
  801e20:	50                   	push   %eax
  801e21:	6a 1d                	push   $0x1d
  801e23:	e8 99 fc ff ff       	call   801ac1 <syscall>
  801e28:	83 c4 18             	add    $0x18,%esp
}
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e30:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e36:	8b 45 08             	mov    0x8(%ebp),%eax
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	51                   	push   %ecx
  801e3e:	52                   	push   %edx
  801e3f:	50                   	push   %eax
  801e40:	6a 1e                	push   $0x1e
  801e42:	e8 7a fc ff ff       	call   801ac1 <syscall>
  801e47:	83 c4 18             	add    $0x18,%esp
}
  801e4a:	c9                   	leave  
  801e4b:	c3                   	ret    

00801e4c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e4c:	55                   	push   %ebp
  801e4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e52:	8b 45 08             	mov    0x8(%ebp),%eax
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	52                   	push   %edx
  801e5c:	50                   	push   %eax
  801e5d:	6a 1f                	push   $0x1f
  801e5f:	e8 5d fc ff ff       	call   801ac1 <syscall>
  801e64:	83 c4 18             	add    $0x18,%esp
}
  801e67:	c9                   	leave  
  801e68:	c3                   	ret    

00801e69 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e69:	55                   	push   %ebp
  801e6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 20                	push   $0x20
  801e78:	e8 44 fc ff ff       	call   801ac1 <syscall>
  801e7d:	83 c4 18             	add    $0x18,%esp
}
  801e80:	c9                   	leave  
  801e81:	c3                   	ret    

00801e82 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801e82:	55                   	push   %ebp
  801e83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801e85:	8b 45 08             	mov    0x8(%ebp),%eax
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	ff 75 10             	pushl  0x10(%ebp)
  801e8f:	ff 75 0c             	pushl  0xc(%ebp)
  801e92:	50                   	push   %eax
  801e93:	6a 21                	push   $0x21
  801e95:	e8 27 fc ff ff       	call   801ac1 <syscall>
  801e9a:	83 c4 18             	add    $0x18,%esp
}
  801e9d:	c9                   	leave  
  801e9e:	c3                   	ret    

00801e9f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e9f:	55                   	push   %ebp
  801ea0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	50                   	push   %eax
  801eae:	6a 22                	push   $0x22
  801eb0:	e8 0c fc ff ff       	call   801ac1 <syscall>
  801eb5:	83 c4 18             	add    $0x18,%esp
}
  801eb8:	90                   	nop
  801eb9:	c9                   	leave  
  801eba:	c3                   	ret    

00801ebb <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ebb:	55                   	push   %ebp
  801ebc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	50                   	push   %eax
  801eca:	6a 23                	push   $0x23
  801ecc:	e8 f0 fb ff ff       	call   801ac1 <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
}
  801ed4:	90                   	nop
  801ed5:	c9                   	leave  
  801ed6:	c3                   	ret    

00801ed7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ed7:	55                   	push   %ebp
  801ed8:	89 e5                	mov    %esp,%ebp
  801eda:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801edd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ee0:	8d 50 04             	lea    0x4(%eax),%edx
  801ee3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	52                   	push   %edx
  801eed:	50                   	push   %eax
  801eee:	6a 24                	push   $0x24
  801ef0:	e8 cc fb ff ff       	call   801ac1 <syscall>
  801ef5:	83 c4 18             	add    $0x18,%esp
	return result;
  801ef8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801efb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801efe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f01:	89 01                	mov    %eax,(%ecx)
  801f03:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f06:	8b 45 08             	mov    0x8(%ebp),%eax
  801f09:	c9                   	leave  
  801f0a:	c2 04 00             	ret    $0x4

00801f0d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	ff 75 10             	pushl  0x10(%ebp)
  801f17:	ff 75 0c             	pushl  0xc(%ebp)
  801f1a:	ff 75 08             	pushl  0x8(%ebp)
  801f1d:	6a 13                	push   $0x13
  801f1f:	e8 9d fb ff ff       	call   801ac1 <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
	return ;
  801f27:	90                   	nop
}
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_rcr2>:
uint32 sys_rcr2()
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 25                	push   $0x25
  801f39:	e8 83 fb ff ff       	call   801ac1 <syscall>
  801f3e:	83 c4 18             	add    $0x18,%esp
}
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
  801f46:	83 ec 04             	sub    $0x4,%esp
  801f49:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f4f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	50                   	push   %eax
  801f5c:	6a 26                	push   $0x26
  801f5e:	e8 5e fb ff ff       	call   801ac1 <syscall>
  801f63:	83 c4 18             	add    $0x18,%esp
	return ;
  801f66:	90                   	nop
}
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <rsttst>:
void rsttst()
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 28                	push   $0x28
  801f78:	e8 44 fb ff ff       	call   801ac1 <syscall>
  801f7d:	83 c4 18             	add    $0x18,%esp
	return ;
  801f80:	90                   	nop
}
  801f81:	c9                   	leave  
  801f82:	c3                   	ret    

00801f83 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f83:	55                   	push   %ebp
  801f84:	89 e5                	mov    %esp,%ebp
  801f86:	83 ec 04             	sub    $0x4,%esp
  801f89:	8b 45 14             	mov    0x14(%ebp),%eax
  801f8c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f8f:	8b 55 18             	mov    0x18(%ebp),%edx
  801f92:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f96:	52                   	push   %edx
  801f97:	50                   	push   %eax
  801f98:	ff 75 10             	pushl  0x10(%ebp)
  801f9b:	ff 75 0c             	pushl  0xc(%ebp)
  801f9e:	ff 75 08             	pushl  0x8(%ebp)
  801fa1:	6a 27                	push   $0x27
  801fa3:	e8 19 fb ff ff       	call   801ac1 <syscall>
  801fa8:	83 c4 18             	add    $0x18,%esp
	return ;
  801fab:	90                   	nop
}
  801fac:	c9                   	leave  
  801fad:	c3                   	ret    

00801fae <chktst>:
void chktst(uint32 n)
{
  801fae:	55                   	push   %ebp
  801faf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	ff 75 08             	pushl  0x8(%ebp)
  801fbc:	6a 29                	push   $0x29
  801fbe:	e8 fe fa ff ff       	call   801ac1 <syscall>
  801fc3:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc6:	90                   	nop
}
  801fc7:	c9                   	leave  
  801fc8:	c3                   	ret    

00801fc9 <inctst>:

void inctst()
{
  801fc9:	55                   	push   %ebp
  801fca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 2a                	push   $0x2a
  801fd8:	e8 e4 fa ff ff       	call   801ac1 <syscall>
  801fdd:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe0:	90                   	nop
}
  801fe1:	c9                   	leave  
  801fe2:	c3                   	ret    

00801fe3 <gettst>:
uint32 gettst()
{
  801fe3:	55                   	push   %ebp
  801fe4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 2b                	push   $0x2b
  801ff2:	e8 ca fa ff ff       	call   801ac1 <syscall>
  801ff7:	83 c4 18             	add    $0x18,%esp
}
  801ffa:	c9                   	leave  
  801ffb:	c3                   	ret    

00801ffc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ffc:	55                   	push   %ebp
  801ffd:	89 e5                	mov    %esp,%ebp
  801fff:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 2c                	push   $0x2c
  80200e:	e8 ae fa ff ff       	call   801ac1 <syscall>
  802013:	83 c4 18             	add    $0x18,%esp
  802016:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802019:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80201d:	75 07                	jne    802026 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80201f:	b8 01 00 00 00       	mov    $0x1,%eax
  802024:	eb 05                	jmp    80202b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802026:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80202b:	c9                   	leave  
  80202c:	c3                   	ret    

0080202d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80202d:	55                   	push   %ebp
  80202e:	89 e5                	mov    %esp,%ebp
  802030:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 2c                	push   $0x2c
  80203f:	e8 7d fa ff ff       	call   801ac1 <syscall>
  802044:	83 c4 18             	add    $0x18,%esp
  802047:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80204a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80204e:	75 07                	jne    802057 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802050:	b8 01 00 00 00       	mov    $0x1,%eax
  802055:	eb 05                	jmp    80205c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802057:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80205c:	c9                   	leave  
  80205d:	c3                   	ret    

0080205e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80205e:	55                   	push   %ebp
  80205f:	89 e5                	mov    %esp,%ebp
  802061:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 2c                	push   $0x2c
  802070:	e8 4c fa ff ff       	call   801ac1 <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
  802078:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80207b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80207f:	75 07                	jne    802088 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802081:	b8 01 00 00 00       	mov    $0x1,%eax
  802086:	eb 05                	jmp    80208d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802088:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80208d:	c9                   	leave  
  80208e:	c3                   	ret    

0080208f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80208f:	55                   	push   %ebp
  802090:	89 e5                	mov    %esp,%ebp
  802092:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 2c                	push   $0x2c
  8020a1:	e8 1b fa ff ff       	call   801ac1 <syscall>
  8020a6:	83 c4 18             	add    $0x18,%esp
  8020a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020ac:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020b0:	75 07                	jne    8020b9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8020b7:	eb 05                	jmp    8020be <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	ff 75 08             	pushl  0x8(%ebp)
  8020ce:	6a 2d                	push   $0x2d
  8020d0:	e8 ec f9 ff ff       	call   801ac1 <syscall>
  8020d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d8:	90                   	nop
}
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    
  8020db:	90                   	nop

008020dc <__udivdi3>:
  8020dc:	55                   	push   %ebp
  8020dd:	57                   	push   %edi
  8020de:	56                   	push   %esi
  8020df:	53                   	push   %ebx
  8020e0:	83 ec 1c             	sub    $0x1c,%esp
  8020e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020f3:	89 ca                	mov    %ecx,%edx
  8020f5:	89 f8                	mov    %edi,%eax
  8020f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020fb:	85 f6                	test   %esi,%esi
  8020fd:	75 2d                	jne    80212c <__udivdi3+0x50>
  8020ff:	39 cf                	cmp    %ecx,%edi
  802101:	77 65                	ja     802168 <__udivdi3+0x8c>
  802103:	89 fd                	mov    %edi,%ebp
  802105:	85 ff                	test   %edi,%edi
  802107:	75 0b                	jne    802114 <__udivdi3+0x38>
  802109:	b8 01 00 00 00       	mov    $0x1,%eax
  80210e:	31 d2                	xor    %edx,%edx
  802110:	f7 f7                	div    %edi
  802112:	89 c5                	mov    %eax,%ebp
  802114:	31 d2                	xor    %edx,%edx
  802116:	89 c8                	mov    %ecx,%eax
  802118:	f7 f5                	div    %ebp
  80211a:	89 c1                	mov    %eax,%ecx
  80211c:	89 d8                	mov    %ebx,%eax
  80211e:	f7 f5                	div    %ebp
  802120:	89 cf                	mov    %ecx,%edi
  802122:	89 fa                	mov    %edi,%edx
  802124:	83 c4 1c             	add    $0x1c,%esp
  802127:	5b                   	pop    %ebx
  802128:	5e                   	pop    %esi
  802129:	5f                   	pop    %edi
  80212a:	5d                   	pop    %ebp
  80212b:	c3                   	ret    
  80212c:	39 ce                	cmp    %ecx,%esi
  80212e:	77 28                	ja     802158 <__udivdi3+0x7c>
  802130:	0f bd fe             	bsr    %esi,%edi
  802133:	83 f7 1f             	xor    $0x1f,%edi
  802136:	75 40                	jne    802178 <__udivdi3+0x9c>
  802138:	39 ce                	cmp    %ecx,%esi
  80213a:	72 0a                	jb     802146 <__udivdi3+0x6a>
  80213c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802140:	0f 87 9e 00 00 00    	ja     8021e4 <__udivdi3+0x108>
  802146:	b8 01 00 00 00       	mov    $0x1,%eax
  80214b:	89 fa                	mov    %edi,%edx
  80214d:	83 c4 1c             	add    $0x1c,%esp
  802150:	5b                   	pop    %ebx
  802151:	5e                   	pop    %esi
  802152:	5f                   	pop    %edi
  802153:	5d                   	pop    %ebp
  802154:	c3                   	ret    
  802155:	8d 76 00             	lea    0x0(%esi),%esi
  802158:	31 ff                	xor    %edi,%edi
  80215a:	31 c0                	xor    %eax,%eax
  80215c:	89 fa                	mov    %edi,%edx
  80215e:	83 c4 1c             	add    $0x1c,%esp
  802161:	5b                   	pop    %ebx
  802162:	5e                   	pop    %esi
  802163:	5f                   	pop    %edi
  802164:	5d                   	pop    %ebp
  802165:	c3                   	ret    
  802166:	66 90                	xchg   %ax,%ax
  802168:	89 d8                	mov    %ebx,%eax
  80216a:	f7 f7                	div    %edi
  80216c:	31 ff                	xor    %edi,%edi
  80216e:	89 fa                	mov    %edi,%edx
  802170:	83 c4 1c             	add    $0x1c,%esp
  802173:	5b                   	pop    %ebx
  802174:	5e                   	pop    %esi
  802175:	5f                   	pop    %edi
  802176:	5d                   	pop    %ebp
  802177:	c3                   	ret    
  802178:	bd 20 00 00 00       	mov    $0x20,%ebp
  80217d:	89 eb                	mov    %ebp,%ebx
  80217f:	29 fb                	sub    %edi,%ebx
  802181:	89 f9                	mov    %edi,%ecx
  802183:	d3 e6                	shl    %cl,%esi
  802185:	89 c5                	mov    %eax,%ebp
  802187:	88 d9                	mov    %bl,%cl
  802189:	d3 ed                	shr    %cl,%ebp
  80218b:	89 e9                	mov    %ebp,%ecx
  80218d:	09 f1                	or     %esi,%ecx
  80218f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802193:	89 f9                	mov    %edi,%ecx
  802195:	d3 e0                	shl    %cl,%eax
  802197:	89 c5                	mov    %eax,%ebp
  802199:	89 d6                	mov    %edx,%esi
  80219b:	88 d9                	mov    %bl,%cl
  80219d:	d3 ee                	shr    %cl,%esi
  80219f:	89 f9                	mov    %edi,%ecx
  8021a1:	d3 e2                	shl    %cl,%edx
  8021a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021a7:	88 d9                	mov    %bl,%cl
  8021a9:	d3 e8                	shr    %cl,%eax
  8021ab:	09 c2                	or     %eax,%edx
  8021ad:	89 d0                	mov    %edx,%eax
  8021af:	89 f2                	mov    %esi,%edx
  8021b1:	f7 74 24 0c          	divl   0xc(%esp)
  8021b5:	89 d6                	mov    %edx,%esi
  8021b7:	89 c3                	mov    %eax,%ebx
  8021b9:	f7 e5                	mul    %ebp
  8021bb:	39 d6                	cmp    %edx,%esi
  8021bd:	72 19                	jb     8021d8 <__udivdi3+0xfc>
  8021bf:	74 0b                	je     8021cc <__udivdi3+0xf0>
  8021c1:	89 d8                	mov    %ebx,%eax
  8021c3:	31 ff                	xor    %edi,%edi
  8021c5:	e9 58 ff ff ff       	jmp    802122 <__udivdi3+0x46>
  8021ca:	66 90                	xchg   %ax,%ax
  8021cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021d0:	89 f9                	mov    %edi,%ecx
  8021d2:	d3 e2                	shl    %cl,%edx
  8021d4:	39 c2                	cmp    %eax,%edx
  8021d6:	73 e9                	jae    8021c1 <__udivdi3+0xe5>
  8021d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021db:	31 ff                	xor    %edi,%edi
  8021dd:	e9 40 ff ff ff       	jmp    802122 <__udivdi3+0x46>
  8021e2:	66 90                	xchg   %ax,%ax
  8021e4:	31 c0                	xor    %eax,%eax
  8021e6:	e9 37 ff ff ff       	jmp    802122 <__udivdi3+0x46>
  8021eb:	90                   	nop

008021ec <__umoddi3>:
  8021ec:	55                   	push   %ebp
  8021ed:	57                   	push   %edi
  8021ee:	56                   	push   %esi
  8021ef:	53                   	push   %ebx
  8021f0:	83 ec 1c             	sub    $0x1c,%esp
  8021f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802203:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802207:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80220b:	89 f3                	mov    %esi,%ebx
  80220d:	89 fa                	mov    %edi,%edx
  80220f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802213:	89 34 24             	mov    %esi,(%esp)
  802216:	85 c0                	test   %eax,%eax
  802218:	75 1a                	jne    802234 <__umoddi3+0x48>
  80221a:	39 f7                	cmp    %esi,%edi
  80221c:	0f 86 a2 00 00 00    	jbe    8022c4 <__umoddi3+0xd8>
  802222:	89 c8                	mov    %ecx,%eax
  802224:	89 f2                	mov    %esi,%edx
  802226:	f7 f7                	div    %edi
  802228:	89 d0                	mov    %edx,%eax
  80222a:	31 d2                	xor    %edx,%edx
  80222c:	83 c4 1c             	add    $0x1c,%esp
  80222f:	5b                   	pop    %ebx
  802230:	5e                   	pop    %esi
  802231:	5f                   	pop    %edi
  802232:	5d                   	pop    %ebp
  802233:	c3                   	ret    
  802234:	39 f0                	cmp    %esi,%eax
  802236:	0f 87 ac 00 00 00    	ja     8022e8 <__umoddi3+0xfc>
  80223c:	0f bd e8             	bsr    %eax,%ebp
  80223f:	83 f5 1f             	xor    $0x1f,%ebp
  802242:	0f 84 ac 00 00 00    	je     8022f4 <__umoddi3+0x108>
  802248:	bf 20 00 00 00       	mov    $0x20,%edi
  80224d:	29 ef                	sub    %ebp,%edi
  80224f:	89 fe                	mov    %edi,%esi
  802251:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802255:	89 e9                	mov    %ebp,%ecx
  802257:	d3 e0                	shl    %cl,%eax
  802259:	89 d7                	mov    %edx,%edi
  80225b:	89 f1                	mov    %esi,%ecx
  80225d:	d3 ef                	shr    %cl,%edi
  80225f:	09 c7                	or     %eax,%edi
  802261:	89 e9                	mov    %ebp,%ecx
  802263:	d3 e2                	shl    %cl,%edx
  802265:	89 14 24             	mov    %edx,(%esp)
  802268:	89 d8                	mov    %ebx,%eax
  80226a:	d3 e0                	shl    %cl,%eax
  80226c:	89 c2                	mov    %eax,%edx
  80226e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802272:	d3 e0                	shl    %cl,%eax
  802274:	89 44 24 04          	mov    %eax,0x4(%esp)
  802278:	8b 44 24 08          	mov    0x8(%esp),%eax
  80227c:	89 f1                	mov    %esi,%ecx
  80227e:	d3 e8                	shr    %cl,%eax
  802280:	09 d0                	or     %edx,%eax
  802282:	d3 eb                	shr    %cl,%ebx
  802284:	89 da                	mov    %ebx,%edx
  802286:	f7 f7                	div    %edi
  802288:	89 d3                	mov    %edx,%ebx
  80228a:	f7 24 24             	mull   (%esp)
  80228d:	89 c6                	mov    %eax,%esi
  80228f:	89 d1                	mov    %edx,%ecx
  802291:	39 d3                	cmp    %edx,%ebx
  802293:	0f 82 87 00 00 00    	jb     802320 <__umoddi3+0x134>
  802299:	0f 84 91 00 00 00    	je     802330 <__umoddi3+0x144>
  80229f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022a3:	29 f2                	sub    %esi,%edx
  8022a5:	19 cb                	sbb    %ecx,%ebx
  8022a7:	89 d8                	mov    %ebx,%eax
  8022a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022ad:	d3 e0                	shl    %cl,%eax
  8022af:	89 e9                	mov    %ebp,%ecx
  8022b1:	d3 ea                	shr    %cl,%edx
  8022b3:	09 d0                	or     %edx,%eax
  8022b5:	89 e9                	mov    %ebp,%ecx
  8022b7:	d3 eb                	shr    %cl,%ebx
  8022b9:	89 da                	mov    %ebx,%edx
  8022bb:	83 c4 1c             	add    $0x1c,%esp
  8022be:	5b                   	pop    %ebx
  8022bf:	5e                   	pop    %esi
  8022c0:	5f                   	pop    %edi
  8022c1:	5d                   	pop    %ebp
  8022c2:	c3                   	ret    
  8022c3:	90                   	nop
  8022c4:	89 fd                	mov    %edi,%ebp
  8022c6:	85 ff                	test   %edi,%edi
  8022c8:	75 0b                	jne    8022d5 <__umoddi3+0xe9>
  8022ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8022cf:	31 d2                	xor    %edx,%edx
  8022d1:	f7 f7                	div    %edi
  8022d3:	89 c5                	mov    %eax,%ebp
  8022d5:	89 f0                	mov    %esi,%eax
  8022d7:	31 d2                	xor    %edx,%edx
  8022d9:	f7 f5                	div    %ebp
  8022db:	89 c8                	mov    %ecx,%eax
  8022dd:	f7 f5                	div    %ebp
  8022df:	89 d0                	mov    %edx,%eax
  8022e1:	e9 44 ff ff ff       	jmp    80222a <__umoddi3+0x3e>
  8022e6:	66 90                	xchg   %ax,%ax
  8022e8:	89 c8                	mov    %ecx,%eax
  8022ea:	89 f2                	mov    %esi,%edx
  8022ec:	83 c4 1c             	add    $0x1c,%esp
  8022ef:	5b                   	pop    %ebx
  8022f0:	5e                   	pop    %esi
  8022f1:	5f                   	pop    %edi
  8022f2:	5d                   	pop    %ebp
  8022f3:	c3                   	ret    
  8022f4:	3b 04 24             	cmp    (%esp),%eax
  8022f7:	72 06                	jb     8022ff <__umoddi3+0x113>
  8022f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022fd:	77 0f                	ja     80230e <__umoddi3+0x122>
  8022ff:	89 f2                	mov    %esi,%edx
  802301:	29 f9                	sub    %edi,%ecx
  802303:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802307:	89 14 24             	mov    %edx,(%esp)
  80230a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80230e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802312:	8b 14 24             	mov    (%esp),%edx
  802315:	83 c4 1c             	add    $0x1c,%esp
  802318:	5b                   	pop    %ebx
  802319:	5e                   	pop    %esi
  80231a:	5f                   	pop    %edi
  80231b:	5d                   	pop    %ebp
  80231c:	c3                   	ret    
  80231d:	8d 76 00             	lea    0x0(%esi),%esi
  802320:	2b 04 24             	sub    (%esp),%eax
  802323:	19 fa                	sbb    %edi,%edx
  802325:	89 d1                	mov    %edx,%ecx
  802327:	89 c6                	mov    %eax,%esi
  802329:	e9 71 ff ff ff       	jmp    80229f <__umoddi3+0xb3>
  80232e:	66 90                	xchg   %ax,%ax
  802330:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802334:	72 ea                	jb     802320 <__umoddi3+0x134>
  802336:	89 d9                	mov    %ebx,%ecx
  802338:	e9 62 ff ff ff       	jmp    80229f <__umoddi3+0xb3>
