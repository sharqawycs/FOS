
obj/user/tst_best_fit_2:     file format elf32-i386


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
  800031:	e8 a5 08 00 00       	call   8008db <libmain>
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
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 60 22 00 00       	call   8022aa <sys_set_uheap_strategy>
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
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);

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
  80009b:	68 40 25 80 00       	push   $0x802540
  8000a0:	6a 1b                	push   $0x1b
  8000a2:	68 5c 25 80 00       	push   $0x80255c
  8000a7:	e8 31 09 00 00       	call   8009dd <_panic>
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
  8000d3:	e8 7d 19 00 00       	call   801a55 <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 90             	mov    %eax,-0x70(%ebp)
		if (ptr_allocations[0] != NULL) panic("Malloc: Attempt to allocate more than heap size, should return NULL");
  8000de:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000e1:	85 c0                	test   %eax,%eax
  8000e3:	74 14                	je     8000f9 <_main+0xc1>
  8000e5:	83 ec 04             	sub    $0x4,%esp
  8000e8:	68 74 25 80 00       	push   $0x802574
  8000ed:	6a 25                	push   $0x25
  8000ef:	68 5c 25 80 00       	push   $0x80255c
  8000f4:	e8 e4 08 00 00       	call   8009dd <_panic>
	}
	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  8000f9:	e8 19 1d 00 00       	call   801e17 <sys_calculate_free_frames>
  8000fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800101:	e8 94 1d 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800106:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800109:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	50                   	push   %eax
  800115:	e8 3b 19 00 00       	call   801a55 <malloc>
  80011a:	83 c4 10             	add    $0x10,%esp
  80011d:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START) ) panic("Wrong start address for the allocated space... ");
  800120:	8b 45 90             	mov    -0x70(%ebp),%eax
  800123:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800128:	74 14                	je     80013e <_main+0x106>
  80012a:	83 ec 04             	sub    $0x4,%esp
  80012d:	68 b8 25 80 00       	push   $0x8025b8
  800132:	6a 2e                	push   $0x2e
  800134:	68 5c 25 80 00       	push   $0x80255c
  800139:	e8 9f 08 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80013e:	e8 57 1d 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800143:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800146:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014b:	74 14                	je     800161 <_main+0x129>
  80014d:	83 ec 04             	sub    $0x4,%esp
  800150:	68 e8 25 80 00       	push   $0x8025e8
  800155:	6a 30                	push   $0x30
  800157:	68 5c 25 80 00       	push   $0x80255c
  80015c:	e8 7c 08 00 00       	call   8009dd <_panic>

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800161:	e8 b1 1c 00 00       	call   801e17 <sys_calculate_free_frames>
  800166:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800169:	e8 2c 1d 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80016e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800171:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800174:	01 c0                	add    %eax,%eax
  800176:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	50                   	push   %eax
  80017d:	e8 d3 18 00 00       	call   801a55 <malloc>
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
  80019e:	68 b8 25 80 00       	push   $0x8025b8
  8001a3:	6a 36                	push   $0x36
  8001a5:	68 5c 25 80 00       	push   $0x80255c
  8001aa:	e8 2e 08 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8001af:	e8 e6 1c 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8001b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001b7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 e8 25 80 00       	push   $0x8025e8
  8001c6:	6a 38                	push   $0x38
  8001c8:	68 5c 25 80 00       	push   $0x80255c
  8001cd:	e8 0b 08 00 00       	call   8009dd <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001d2:	e8 40 1c 00 00       	call   801e17 <sys_calculate_free_frames>
  8001d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001da:	e8 bb 1c 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8001df:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	50                   	push   %eax
  8001eb:	e8 65 18 00 00       	call   801a55 <malloc>
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
  80020d:	68 b8 25 80 00       	push   $0x8025b8
  800212:	6a 3e                	push   $0x3e
  800214:	68 5c 25 80 00       	push   $0x80255c
  800219:	e8 bf 07 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  80021e:	e8 77 1c 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800223:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800226:	83 f8 01             	cmp    $0x1,%eax
  800229:	74 14                	je     80023f <_main+0x207>
  80022b:	83 ec 04             	sub    $0x4,%esp
  80022e:	68 e8 25 80 00       	push   $0x8025e8
  800233:	6a 40                	push   $0x40
  800235:	68 5c 25 80 00       	push   $0x80255c
  80023a:	e8 9e 07 00 00       	call   8009dd <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80023f:	e8 d3 1b 00 00       	call   801e17 <sys_calculate_free_frames>
  800244:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800247:	e8 4e 1c 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80024c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  80024f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800252:	01 c0                	add    %eax,%eax
  800254:	83 ec 0c             	sub    $0xc,%esp
  800257:	50                   	push   %eax
  800258:	e8 f8 17 00 00       	call   801a55 <malloc>
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
  800284:	68 b8 25 80 00       	push   $0x8025b8
  800289:	6a 46                	push   $0x46
  80028b:	68 5c 25 80 00       	push   $0x80255c
  800290:	e8 48 07 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Wrong page file allocation: ");
  800295:	e8 00 1c 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80029a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80029d:	83 f8 01             	cmp    $0x1,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 e8 25 80 00       	push   $0x8025e8
  8002aa:	6a 48                	push   $0x48
  8002ac:	68 5c 25 80 00       	push   $0x80255c
  8002b1:	e8 27 07 00 00       	call   8009dd <_panic>

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002b6:	e8 5c 1b 00 00       	call   801e17 <sys_calculate_free_frames>
  8002bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8002be:	e8 d7 1b 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8002c6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002c9:	83 ec 0c             	sub    $0xc,%esp
  8002cc:	50                   	push   %eax
  8002cd:	e8 a4 18 00 00       	call   801b76 <free>
  8002d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1) panic("Wrong free: ");
		if( (usedDiskPages-sys_pf_calculate_allocated_pages()) !=  1) panic("Wrong page file free: ");
  8002d5:	e8 c0 1b 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8002da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002dd:	29 c2                	sub    %eax,%edx
  8002df:	89 d0                	mov    %edx,%eax
  8002e1:	83 f8 01             	cmp    $0x1,%eax
  8002e4:	74 14                	je     8002fa <_main+0x2c2>
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	68 05 26 80 00       	push   $0x802605
  8002ee:	6a 4f                	push   $0x4f
  8002f0:	68 5c 25 80 00       	push   $0x80255c
  8002f5:	e8 e3 06 00 00       	call   8009dd <_panic>

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 18 1b 00 00       	call   801e17 <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800302:	e8 93 1b 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
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
  80031b:	e8 35 17 00 00       	call   801a55 <malloc>
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
  800347:	68 b8 25 80 00       	push   $0x8025b8
  80034c:	6a 55                	push   $0x55
  80034e:	68 5c 25 80 00       	push   $0x80255c
  800353:	e8 85 06 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  800358:	e8 3d 1b 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80035d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800360:	83 f8 02             	cmp    $0x2,%eax
  800363:	74 14                	je     800379 <_main+0x341>
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	68 e8 25 80 00       	push   $0x8025e8
  80036d:	6a 57                	push   $0x57
  80036f:	68 5c 25 80 00       	push   $0x80255c
  800374:	e8 64 06 00 00       	call   8009dd <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800379:	e8 99 1a 00 00       	call   801e17 <sys_calculate_free_frames>
  80037e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800381:	e8 14 1b 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800386:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[0]);
  800389:	8b 45 90             	mov    -0x70(%ebp),%eax
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	50                   	push   %eax
  800390:	e8 e1 17 00 00       	call   801b76 <free>
  800395:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  800398:	e8 fd 1a 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80039d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003a0:	29 c2                	sub    %eax,%edx
  8003a2:	89 d0                	mov    %edx,%eax
  8003a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003a9:	74 14                	je     8003bf <_main+0x387>
  8003ab:	83 ec 04             	sub    $0x4,%esp
  8003ae:	68 05 26 80 00       	push   $0x802605
  8003b3:	6a 5e                	push   $0x5e
  8003b5:	68 5c 25 80 00       	push   $0x80255c
  8003ba:	e8 1e 06 00 00       	call   8009dd <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003bf:	e8 53 1a 00 00       	call   801e17 <sys_calculate_free_frames>
  8003c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003c7:	e8 ce 1a 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8003cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8003cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d2:	89 c2                	mov    %eax,%edx
  8003d4:	01 d2                	add    %edx,%edx
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003db:	83 ec 0c             	sub    $0xc,%esp
  8003de:	50                   	push   %eax
  8003df:	e8 71 16 00 00       	call   801a55 <malloc>
  8003e4:	83 c4 10             	add    $0x10,%esp
  8003e7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
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
  80040b:	68 b8 25 80 00       	push   $0x8025b8
  800410:	6a 64                	push   $0x64
  800412:	68 5c 25 80 00       	push   $0x80255c
  800417:	e8 c1 05 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  80041c:	e8 79 1a 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
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
  800442:	68 e8 25 80 00       	push   $0x8025e8
  800447:	6a 66                	push   $0x66
  800449:	68 5c 25 80 00       	push   $0x80255c
  80044e:	e8 8a 05 00 00       	call   8009dd <_panic>

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  800453:	e8 bf 19 00 00       	call   801e17 <sys_calculate_free_frames>
  800458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80045b:	e8 3a 1a 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
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
  800477:	e8 d9 15 00 00       	call   801a55 <malloc>
  80047c:	83 c4 10             	add    $0x10,%esp
  80047f:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
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
  8004aa:	68 b8 25 80 00       	push   $0x8025b8
  8004af:	6a 6c                	push   $0x6c
  8004b1:	68 5c 25 80 00       	push   $0x80255c
  8004b6:	e8 22 05 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 514+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  514) panic("Wrong page file allocation: ");
  8004bb:	e8 da 19 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8004c0:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004c3:	3d 02 02 00 00       	cmp    $0x202,%eax
  8004c8:	74 14                	je     8004de <_main+0x4a6>
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	68 e8 25 80 00       	push   $0x8025e8
  8004d2:	6a 6e                	push   $0x6e
  8004d4:	68 5c 25 80 00       	push   $0x80255c
  8004d9:	e8 ff 04 00 00       	call   8009dd <_panic>

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 34 19 00 00       	call   801e17 <sys_calculate_free_frames>
  8004e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 af 19 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8004eb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  8004ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004f1:	89 d0                	mov    %edx,%eax
  8004f3:	c1 e0 02             	shl    $0x2,%eax
  8004f6:	01 d0                	add    %edx,%eax
  8004f8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004fb:	83 ec 0c             	sub    $0xc,%esp
  8004fe:	50                   	push   %eax
  8004ff:	e8 51 15 00 00       	call   801a55 <malloc>
  800504:	83 c4 10             	add    $0x10,%esp
  800507:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 9*Mega + 24*kilo)) panic("Wrong start address for the allocated space... ");
  80050a:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80050d:	89 c1                	mov    %eax,%ecx
  80050f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800512:	89 d0                	mov    %edx,%eax
  800514:	c1 e0 03             	shl    $0x3,%eax
  800517:	01 d0                	add    %edx,%eax
  800519:	89 c3                	mov    %eax,%ebx
  80051b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80051e:	89 d0                	mov    %edx,%eax
  800520:	01 c0                	add    %eax,%eax
  800522:	01 d0                	add    %edx,%eax
  800524:	c1 e0 03             	shl    $0x3,%eax
  800527:	01 d8                	add    %ebx,%eax
  800529:	05 00 00 00 80       	add    $0x80000000,%eax
  80052e:	39 c1                	cmp    %eax,%ecx
  800530:	74 14                	je     800546 <_main+0x50e>
  800532:	83 ec 04             	sub    $0x4,%esp
  800535:	68 b8 25 80 00       	push   $0x8025b8
  80053a:	6a 74                	push   $0x74
  80053c:	68 5c 25 80 00       	push   $0x80255c
  800541:	e8 97 04 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 5*Mega/4096 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/4096) panic("Wrong page file allocation: ");
  800546:	e8 4f 19 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80054b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80054e:	89 c1                	mov    %eax,%ecx
  800550:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800553:	89 d0                	mov    %edx,%eax
  800555:	c1 e0 02             	shl    $0x2,%eax
  800558:	01 d0                	add    %edx,%eax
  80055a:	85 c0                	test   %eax,%eax
  80055c:	79 05                	jns    800563 <_main+0x52b>
  80055e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800563:	c1 f8 0c             	sar    $0xc,%eax
  800566:	39 c1                	cmp    %eax,%ecx
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 e8 25 80 00       	push   $0x8025e8
  800572:	6a 76                	push   $0x76
  800574:	68 5c 25 80 00       	push   $0x80255c
  800579:	e8 5f 04 00 00       	call   8009dd <_panic>

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  80057e:	e8 94 18 00 00       	call   801e17 <sys_calculate_free_frames>
  800583:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800586:	e8 0f 19 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80058b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  80058e:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800591:	83 ec 0c             	sub    $0xc,%esp
  800594:	50                   	push   %eax
  800595:	e8 dc 15 00 00       	call   801b76 <free>
  80059a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 514) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  514) panic("Wrong page file free: ");
  80059d:	e8 f8 18 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8005a2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a5:	29 c2                	sub    %eax,%edx
  8005a7:	89 d0                	mov    %edx,%eax
  8005a9:	3d 02 02 00 00       	cmp    $0x202,%eax
  8005ae:	74 14                	je     8005c4 <_main+0x58c>
  8005b0:	83 ec 04             	sub    $0x4,%esp
  8005b3:	68 05 26 80 00       	push   $0x802605
  8005b8:	6a 7d                	push   $0x7d
  8005ba:	68 5c 25 80 00       	push   $0x80255c
  8005bf:	e8 19 04 00 00       	call   8009dd <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005c4:	e8 4e 18 00 00       	call   801e17 <sys_calculate_free_frames>
  8005c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005cc:	e8 c9 18 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8005d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005d4:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005d7:	83 ec 0c             	sub    $0xc,%esp
  8005da:	50                   	push   %eax
  8005db:	e8 96 15 00 00       	call   801b76 <free>
  8005e0:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages() ) !=  512) panic("Wrong page file free: ");
  8005e3:	e8 b2 18 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8005e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005eb:	29 c2                	sub    %eax,%edx
  8005ed:	89 d0                	mov    %edx,%eax
  8005ef:	3d 00 02 00 00       	cmp    $0x200,%eax
  8005f4:	74 17                	je     80060d <_main+0x5d5>
  8005f6:	83 ec 04             	sub    $0x4,%esp
  8005f9:	68 05 26 80 00       	push   $0x802605
  8005fe:	68 84 00 00 00       	push   $0x84
  800603:	68 5c 25 80 00       	push   $0x80255c
  800608:	e8 d0 03 00 00       	call   8009dd <_panic>

		//2 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  80060d:	e8 05 18 00 00       	call   801e17 <sys_calculate_free_frames>
  800612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800615:	e8 80 18 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80061a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(2*Mega-kilo);
  80061d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800620:	01 c0                	add    %eax,%eax
  800622:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800625:	83 ec 0c             	sub    $0xc,%esp
  800628:	50                   	push   %eax
  800629:	e8 27 14 00 00       	call   801a55 <malloc>
  80062e:	83 c4 10             	add    $0x10,%esp
  800631:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800634:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800637:	89 c1                	mov    %eax,%ecx
  800639:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80063c:	89 d0                	mov    %edx,%eax
  80063e:	01 c0                	add    %eax,%eax
  800640:	01 d0                	add    %edx,%eax
  800642:	01 c0                	add    %eax,%eax
  800644:	01 d0                	add    %edx,%eax
  800646:	89 c2                	mov    %eax,%edx
  800648:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80064b:	c1 e0 04             	shl    $0x4,%eax
  80064e:	01 d0                	add    %edx,%eax
  800650:	05 00 00 00 80       	add    $0x80000000,%eax
  800655:	39 c1                	cmp    %eax,%ecx
  800657:	74 17                	je     800670 <_main+0x638>
  800659:	83 ec 04             	sub    $0x4,%esp
  80065c:	68 b8 25 80 00       	push   $0x8025b8
  800661:	68 8a 00 00 00       	push   $0x8a
  800666:	68 5c 25 80 00       	push   $0x80255c
  80066b:	e8 6d 03 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800670:	e8 25 18 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800675:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800678:	3d 00 02 00 00       	cmp    $0x200,%eax
  80067d:	74 17                	je     800696 <_main+0x65e>
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 e8 25 80 00       	push   $0x8025e8
  800687:	68 8c 00 00 00       	push   $0x8c
  80068c:	68 5c 25 80 00       	push   $0x80255c
  800691:	e8 47 03 00 00       	call   8009dd <_panic>

		//6 KB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800696:	e8 7c 17 00 00       	call   801e17 <sys_calculate_free_frames>
  80069b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80069e:	e8 f7 17 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8006a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(6*kilo);
  8006a6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006a9:	89 d0                	mov    %edx,%eax
  8006ab:	01 c0                	add    %eax,%eax
  8006ad:	01 d0                	add    %edx,%eax
  8006af:	01 c0                	add    %eax,%eax
  8006b1:	83 ec 0c             	sub    $0xc,%esp
  8006b4:	50                   	push   %eax
  8006b5:	e8 9b 13 00 00       	call   801a55 <malloc>
  8006ba:	83 c4 10             	add    $0x10,%esp
  8006bd:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 9*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  8006c0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006c3:	89 c1                	mov    %eax,%ecx
  8006c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006c8:	89 d0                	mov    %edx,%eax
  8006ca:	c1 e0 03             	shl    $0x3,%eax
  8006cd:	01 d0                	add    %edx,%eax
  8006cf:	89 c2                	mov    %eax,%edx
  8006d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d4:	c1 e0 04             	shl    $0x4,%eax
  8006d7:	01 d0                	add    %edx,%eax
  8006d9:	05 00 00 00 80       	add    $0x80000000,%eax
  8006de:	39 c1                	cmp    %eax,%ecx
  8006e0:	74 17                	je     8006f9 <_main+0x6c1>
  8006e2:	83 ec 04             	sub    $0x4,%esp
  8006e5:	68 b8 25 80 00       	push   $0x8025b8
  8006ea:	68 92 00 00 00       	push   $0x92
  8006ef:	68 5c 25 80 00       	push   $0x80255c
  8006f4:	e8 e4 02 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2) panic("Wrong page file allocation: ");
  8006f9:	e8 9c 17 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8006fe:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800701:	83 f8 02             	cmp    $0x2,%eax
  800704:	74 17                	je     80071d <_main+0x6e5>
  800706:	83 ec 04             	sub    $0x4,%esp
  800709:	68 e8 25 80 00       	push   $0x8025e8
  80070e:	68 94 00 00 00       	push   $0x94
  800713:	68 5c 25 80 00       	push   $0x80255c
  800718:	e8 c0 02 00 00       	call   8009dd <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80071d:	e8 f5 16 00 00       	call   801e17 <sys_calculate_free_frames>
  800722:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800725:	e8 70 17 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80072a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  80072d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800730:	83 ec 0c             	sub    $0xc,%esp
  800733:	50                   	push   %eax
  800734:	e8 3d 14 00 00       	call   801b76 <free>
  800739:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  80073c:	e8 59 17 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800741:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800744:	29 c2                	sub    %eax,%edx
  800746:	89 d0                	mov    %edx,%eax
  800748:	3d 00 03 00 00       	cmp    $0x300,%eax
  80074d:	74 17                	je     800766 <_main+0x72e>
  80074f:	83 ec 04             	sub    $0x4,%esp
  800752:	68 05 26 80 00       	push   $0x802605
  800757:	68 9b 00 00 00       	push   $0x9b
  80075c:	68 5c 25 80 00       	push   $0x80255c
  800761:	e8 77 02 00 00       	call   8009dd <_panic>

		//3 MB [BEST FIT Case]
		freeFrames = sys_calculate_free_frames() ;
  800766:	e8 ac 16 00 00       	call   801e17 <sys_calculate_free_frames>
  80076b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80076e:	e8 27 17 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  800773:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(3*Mega-kilo);
  800776:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800779:	89 c2                	mov    %eax,%edx
  80077b:	01 d2                	add    %edx,%edx
  80077d:	01 d0                	add    %edx,%eax
  80077f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800782:	83 ec 0c             	sub    $0xc,%esp
  800785:	50                   	push   %eax
  800786:	e8 ca 12 00 00       	call   801a55 <malloc>
  80078b:	83 c4 10             	add    $0x10,%esp
  80078e:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... ");
  800791:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800794:	89 c2                	mov    %eax,%edx
  800796:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800799:	c1 e0 02             	shl    $0x2,%eax
  80079c:	89 c1                	mov    %eax,%ecx
  80079e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007a1:	c1 e0 04             	shl    $0x4,%eax
  8007a4:	01 c8                	add    %ecx,%eax
  8007a6:	05 00 00 00 80       	add    $0x80000000,%eax
  8007ab:	39 c2                	cmp    %eax,%edx
  8007ad:	74 17                	je     8007c6 <_main+0x78e>
  8007af:	83 ec 04             	sub    $0x4,%esp
  8007b2:	68 b8 25 80 00       	push   $0x8025b8
  8007b7:	68 a1 00 00 00       	push   $0xa1
  8007bc:	68 5c 25 80 00       	push   $0x80255c
  8007c1:	e8 17 02 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*Mega/4096) panic("Wrong page file allocation: ");
  8007c6:	e8 cf 16 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  8007cb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007ce:	89 c2                	mov    %eax,%edx
  8007d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d3:	89 c1                	mov    %eax,%ecx
  8007d5:	01 c9                	add    %ecx,%ecx
  8007d7:	01 c8                	add    %ecx,%eax
  8007d9:	85 c0                	test   %eax,%eax
  8007db:	79 05                	jns    8007e2 <_main+0x7aa>
  8007dd:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007e2:	c1 f8 0c             	sar    $0xc,%eax
  8007e5:	39 c2                	cmp    %eax,%edx
  8007e7:	74 17                	je     800800 <_main+0x7c8>
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	68 e8 25 80 00       	push   $0x8025e8
  8007f1:	68 a3 00 00 00       	push   $0xa3
  8007f6:	68 5c 25 80 00       	push   $0x80255c
  8007fb:	e8 dd 01 00 00       	call   8009dd <_panic>

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  800800:	e8 12 16 00 00       	call   801e17 <sys_calculate_free_frames>
  800805:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800808:	e8 8d 16 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80080d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega-kilo);
  800810:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800813:	c1 e0 02             	shl    $0x2,%eax
  800816:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800819:	83 ec 0c             	sub    $0xc,%esp
  80081c:	50                   	push   %eax
  80081d:	e8 33 12 00 00       	call   801a55 <malloc>
  800822:	83 c4 10             	add    $0x10,%esp
  800825:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800828:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80082b:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800830:	74 17                	je     800849 <_main+0x811>
  800832:	83 ec 04             	sub    $0x4,%esp
  800835:	68 b8 25 80 00       	push   $0x8025b8
  80083a:	68 a9 00 00 00       	push   $0xa9
  80083f:	68 5c 25 80 00       	push   $0x80255c
  800844:	e8 94 01 00 00       	call   8009dd <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 4*Mega/4096) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/4096) panic("Wrong page file allocation: ");
  800849:	e8 4c 16 00 00       	call   801e9a <sys_pf_calculate_allocated_pages>
  80084e:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800851:	89 c2                	mov    %eax,%edx
  800853:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800856:	c1 e0 02             	shl    $0x2,%eax
  800859:	85 c0                	test   %eax,%eax
  80085b:	79 05                	jns    800862 <_main+0x82a>
  80085d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800862:	c1 f8 0c             	sar    $0xc,%eax
  800865:	39 c2                	cmp    %eax,%edx
  800867:	74 17                	je     800880 <_main+0x848>
  800869:	83 ec 04             	sub    $0x4,%esp
  80086c:	68 e8 25 80 00       	push   $0x8025e8
  800871:	68 ab 00 00 00       	push   $0xab
  800876:	68 5c 25 80 00       	push   $0x80255c
  80087b:	e8 5d 01 00 00       	call   8009dd <_panic>
	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		//int freeFrames = sys_calculate_free_frames() ;
		//usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[12] = malloc((USER_HEAP_MAX - USER_HEAP_START - 14*Mega));
  800880:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800883:	89 d0                	mov    %edx,%eax
  800885:	01 c0                	add    %eax,%eax
  800887:	01 d0                	add    %edx,%eax
  800889:	01 c0                	add    %eax,%eax
  80088b:	01 d0                	add    %edx,%eax
  80088d:	01 c0                	add    %eax,%eax
  80088f:	f7 d8                	neg    %eax
  800891:	05 00 00 00 20       	add    $0x20000000,%eax
  800896:	83 ec 0c             	sub    $0xc,%esp
  800899:	50                   	push   %eax
  80089a:	e8 b6 11 00 00       	call   801a55 <malloc>
  80089f:	83 c4 10             	add    $0x10,%esp
  8008a2:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if (ptr_allocations[12] != NULL) panic("Malloc: Attempt to allocate large segment with no suitable fragment to fit on, should return NULL");
  8008a5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8008a8:	85 c0                	test   %eax,%eax
  8008aa:	74 17                	je     8008c3 <_main+0x88b>
  8008ac:	83 ec 04             	sub    $0x4,%esp
  8008af:	68 1c 26 80 00       	push   $0x80261c
  8008b4:	68 b4 00 00 00       	push   $0xb4
  8008b9:	68 5c 25 80 00       	push   $0x80255c
  8008be:	e8 1a 01 00 00       	call   8009dd <_panic>

		cprintf("Congratulations!! test BEST FIT allocation (2) completed successfully.\n");
  8008c3:	83 ec 0c             	sub    $0xc,%esp
  8008c6:	68 80 26 80 00       	push   $0x802680
  8008cb:	e8 c1 03 00 00       	call   800c91 <cprintf>
  8008d0:	83 c4 10             	add    $0x10,%esp

		return;
  8008d3:	90                   	nop
	}
}
  8008d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d7:	5b                   	pop    %ebx
  8008d8:	5f                   	pop    %edi
  8008d9:	5d                   	pop    %ebp
  8008da:	c3                   	ret    

008008db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
  8008de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8008e1:	e8 66 14 00 00       	call   801d4c <sys_getenvindex>
  8008e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8008e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ec:	89 d0                	mov    %edx,%eax
  8008ee:	01 c0                	add    %eax,%eax
  8008f0:	01 d0                	add    %edx,%eax
  8008f2:	c1 e0 02             	shl    $0x2,%eax
  8008f5:	01 d0                	add    %edx,%eax
  8008f7:	c1 e0 06             	shl    $0x6,%eax
  8008fa:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8008ff:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800904:	a1 20 30 80 00       	mov    0x803020,%eax
  800909:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  80090f:	84 c0                	test   %al,%al
  800911:	74 0f                	je     800922 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800913:	a1 20 30 80 00       	mov    0x803020,%eax
  800918:	05 f4 02 00 00       	add    $0x2f4,%eax
  80091d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800922:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800926:	7e 0a                	jle    800932 <libmain+0x57>
		binaryname = argv[0];
  800928:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092b:	8b 00                	mov    (%eax),%eax
  80092d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	ff 75 0c             	pushl  0xc(%ebp)
  800938:	ff 75 08             	pushl  0x8(%ebp)
  80093b:	e8 f8 f6 ff ff       	call   800038 <_main>
  800940:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800943:	e8 9f 15 00 00       	call   801ee7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800948:	83 ec 0c             	sub    $0xc,%esp
  80094b:	68 e0 26 80 00       	push   $0x8026e0
  800950:	e8 3c 03 00 00       	call   800c91 <cprintf>
  800955:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800958:	a1 20 30 80 00       	mov    0x803020,%eax
  80095d:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800963:	a1 20 30 80 00       	mov    0x803020,%eax
  800968:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  80096e:	83 ec 04             	sub    $0x4,%esp
  800971:	52                   	push   %edx
  800972:	50                   	push   %eax
  800973:	68 08 27 80 00       	push   $0x802708
  800978:	e8 14 03 00 00       	call   800c91 <cprintf>
  80097d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800980:	a1 20 30 80 00       	mov    0x803020,%eax
  800985:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80098b:	83 ec 08             	sub    $0x8,%esp
  80098e:	50                   	push   %eax
  80098f:	68 2d 27 80 00       	push   $0x80272d
  800994:	e8 f8 02 00 00       	call   800c91 <cprintf>
  800999:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80099c:	83 ec 0c             	sub    $0xc,%esp
  80099f:	68 e0 26 80 00       	push   $0x8026e0
  8009a4:	e8 e8 02 00 00       	call   800c91 <cprintf>
  8009a9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8009ac:	e8 50 15 00 00       	call   801f01 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8009b1:	e8 19 00 00 00       	call   8009cf <exit>
}
  8009b6:	90                   	nop
  8009b7:	c9                   	leave  
  8009b8:	c3                   	ret    

008009b9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8009b9:	55                   	push   %ebp
  8009ba:	89 e5                	mov    %esp,%ebp
  8009bc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8009bf:	83 ec 0c             	sub    $0xc,%esp
  8009c2:	6a 00                	push   $0x0
  8009c4:	e8 4f 13 00 00       	call   801d18 <sys_env_destroy>
  8009c9:	83 c4 10             	add    $0x10,%esp
}
  8009cc:	90                   	nop
  8009cd:	c9                   	leave  
  8009ce:	c3                   	ret    

008009cf <exit>:

void
exit(void)
{
  8009cf:	55                   	push   %ebp
  8009d0:	89 e5                	mov    %esp,%ebp
  8009d2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8009d5:	e8 a4 13 00 00       	call   801d7e <sys_env_exit>
}
  8009da:	90                   	nop
  8009db:	c9                   	leave  
  8009dc:	c3                   	ret    

008009dd <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8009dd:	55                   	push   %ebp
  8009de:	89 e5                	mov    %esp,%ebp
  8009e0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8009e3:	8d 45 10             	lea    0x10(%ebp),%eax
  8009e6:	83 c0 04             	add    $0x4,%eax
  8009e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8009ec:	a1 30 30 80 00       	mov    0x803030,%eax
  8009f1:	85 c0                	test   %eax,%eax
  8009f3:	74 16                	je     800a0b <_panic+0x2e>
		cprintf("%s: ", argv0);
  8009f5:	a1 30 30 80 00       	mov    0x803030,%eax
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	50                   	push   %eax
  8009fe:	68 44 27 80 00       	push   $0x802744
  800a03:	e8 89 02 00 00       	call   800c91 <cprintf>
  800a08:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800a0b:	a1 00 30 80 00       	mov    0x803000,%eax
  800a10:	ff 75 0c             	pushl  0xc(%ebp)
  800a13:	ff 75 08             	pushl  0x8(%ebp)
  800a16:	50                   	push   %eax
  800a17:	68 49 27 80 00       	push   $0x802749
  800a1c:	e8 70 02 00 00       	call   800c91 <cprintf>
  800a21:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800a24:	8b 45 10             	mov    0x10(%ebp),%eax
  800a27:	83 ec 08             	sub    $0x8,%esp
  800a2a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2d:	50                   	push   %eax
  800a2e:	e8 f3 01 00 00       	call   800c26 <vcprintf>
  800a33:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800a36:	83 ec 08             	sub    $0x8,%esp
  800a39:	6a 00                	push   $0x0
  800a3b:	68 65 27 80 00       	push   $0x802765
  800a40:	e8 e1 01 00 00       	call   800c26 <vcprintf>
  800a45:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800a48:	e8 82 ff ff ff       	call   8009cf <exit>

	// should not return here
	while (1) ;
  800a4d:	eb fe                	jmp    800a4d <_panic+0x70>

00800a4f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800a4f:	55                   	push   %ebp
  800a50:	89 e5                	mov    %esp,%ebp
  800a52:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800a55:	a1 20 30 80 00       	mov    0x803020,%eax
  800a5a:	8b 50 74             	mov    0x74(%eax),%edx
  800a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a60:	39 c2                	cmp    %eax,%edx
  800a62:	74 14                	je     800a78 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a64:	83 ec 04             	sub    $0x4,%esp
  800a67:	68 68 27 80 00       	push   $0x802768
  800a6c:	6a 26                	push   $0x26
  800a6e:	68 b4 27 80 00       	push   $0x8027b4
  800a73:	e8 65 ff ff ff       	call   8009dd <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a7f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a86:	e9 c2 00 00 00       	jmp    800b4d <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800a8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	01 d0                	add    %edx,%eax
  800a9a:	8b 00                	mov    (%eax),%eax
  800a9c:	85 c0                	test   %eax,%eax
  800a9e:	75 08                	jne    800aa8 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800aa0:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800aa3:	e9 a2 00 00 00       	jmp    800b4a <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800aa8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800aaf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800ab6:	eb 69                	jmp    800b21 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800ab8:	a1 20 30 80 00       	mov    0x803020,%eax
  800abd:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ac3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ac6:	89 d0                	mov    %edx,%eax
  800ac8:	01 c0                	add    %eax,%eax
  800aca:	01 d0                	add    %edx,%eax
  800acc:	c1 e0 02             	shl    $0x2,%eax
  800acf:	01 c8                	add    %ecx,%eax
  800ad1:	8a 40 04             	mov    0x4(%eax),%al
  800ad4:	84 c0                	test   %al,%al
  800ad6:	75 46                	jne    800b1e <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ad8:	a1 20 30 80 00       	mov    0x803020,%eax
  800add:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ae3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ae6:	89 d0                	mov    %edx,%eax
  800ae8:	01 c0                	add    %eax,%eax
  800aea:	01 d0                	add    %edx,%eax
  800aec:	c1 e0 02             	shl    $0x2,%eax
  800aef:	01 c8                	add    %ecx,%eax
  800af1:	8b 00                	mov    (%eax),%eax
  800af3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800af6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800af9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800afe:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b03:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	01 c8                	add    %ecx,%eax
  800b0f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800b11:	39 c2                	cmp    %eax,%edx
  800b13:	75 09                	jne    800b1e <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800b15:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800b1c:	eb 12                	jmp    800b30 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b1e:	ff 45 e8             	incl   -0x18(%ebp)
  800b21:	a1 20 30 80 00       	mov    0x803020,%eax
  800b26:	8b 50 74             	mov    0x74(%eax),%edx
  800b29:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b2c:	39 c2                	cmp    %eax,%edx
  800b2e:	77 88                	ja     800ab8 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800b30:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b34:	75 14                	jne    800b4a <CheckWSWithoutLastIndex+0xfb>
			panic(
  800b36:	83 ec 04             	sub    $0x4,%esp
  800b39:	68 c0 27 80 00       	push   $0x8027c0
  800b3e:	6a 3a                	push   $0x3a
  800b40:	68 b4 27 80 00       	push   $0x8027b4
  800b45:	e8 93 fe ff ff       	call   8009dd <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800b4a:	ff 45 f0             	incl   -0x10(%ebp)
  800b4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b50:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800b53:	0f 8c 32 ff ff ff    	jl     800a8b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800b59:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b60:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b67:	eb 26                	jmp    800b8f <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b69:	a1 20 30 80 00       	mov    0x803020,%eax
  800b6e:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800b74:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b77:	89 d0                	mov    %edx,%eax
  800b79:	01 c0                	add    %eax,%eax
  800b7b:	01 d0                	add    %edx,%eax
  800b7d:	c1 e0 02             	shl    $0x2,%eax
  800b80:	01 c8                	add    %ecx,%eax
  800b82:	8a 40 04             	mov    0x4(%eax),%al
  800b85:	3c 01                	cmp    $0x1,%al
  800b87:	75 03                	jne    800b8c <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800b89:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b8c:	ff 45 e0             	incl   -0x20(%ebp)
  800b8f:	a1 20 30 80 00       	mov    0x803020,%eax
  800b94:	8b 50 74             	mov    0x74(%eax),%edx
  800b97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b9a:	39 c2                	cmp    %eax,%edx
  800b9c:	77 cb                	ja     800b69 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ba1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ba4:	74 14                	je     800bba <CheckWSWithoutLastIndex+0x16b>
		panic(
  800ba6:	83 ec 04             	sub    $0x4,%esp
  800ba9:	68 14 28 80 00       	push   $0x802814
  800bae:	6a 44                	push   $0x44
  800bb0:	68 b4 27 80 00       	push   $0x8027b4
  800bb5:	e8 23 fe ff ff       	call   8009dd <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800bba:	90                   	nop
  800bbb:	c9                   	leave  
  800bbc:	c3                   	ret    

00800bbd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800bbd:	55                   	push   %ebp
  800bbe:	89 e5                	mov    %esp,%ebp
  800bc0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc6:	8b 00                	mov    (%eax),%eax
  800bc8:	8d 48 01             	lea    0x1(%eax),%ecx
  800bcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bce:	89 0a                	mov    %ecx,(%edx)
  800bd0:	8b 55 08             	mov    0x8(%ebp),%edx
  800bd3:	88 d1                	mov    %dl,%cl
  800bd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bd8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdf:	8b 00                	mov    (%eax),%eax
  800be1:	3d ff 00 00 00       	cmp    $0xff,%eax
  800be6:	75 2c                	jne    800c14 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800be8:	a0 24 30 80 00       	mov    0x803024,%al
  800bed:	0f b6 c0             	movzbl %al,%eax
  800bf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf3:	8b 12                	mov    (%edx),%edx
  800bf5:	89 d1                	mov    %edx,%ecx
  800bf7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bfa:	83 c2 08             	add    $0x8,%edx
  800bfd:	83 ec 04             	sub    $0x4,%esp
  800c00:	50                   	push   %eax
  800c01:	51                   	push   %ecx
  800c02:	52                   	push   %edx
  800c03:	e8 ce 10 00 00       	call   801cd6 <sys_cputs>
  800c08:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800c14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c17:	8b 40 04             	mov    0x4(%eax),%eax
  800c1a:	8d 50 01             	lea    0x1(%eax),%edx
  800c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c20:	89 50 04             	mov    %edx,0x4(%eax)
}
  800c23:	90                   	nop
  800c24:	c9                   	leave  
  800c25:	c3                   	ret    

00800c26 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800c2f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800c36:	00 00 00 
	b.cnt = 0;
  800c39:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800c40:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800c43:	ff 75 0c             	pushl  0xc(%ebp)
  800c46:	ff 75 08             	pushl  0x8(%ebp)
  800c49:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c4f:	50                   	push   %eax
  800c50:	68 bd 0b 80 00       	push   $0x800bbd
  800c55:	e8 11 02 00 00       	call   800e6b <vprintfmt>
  800c5a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c5d:	a0 24 30 80 00       	mov    0x803024,%al
  800c62:	0f b6 c0             	movzbl %al,%eax
  800c65:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c6b:	83 ec 04             	sub    $0x4,%esp
  800c6e:	50                   	push   %eax
  800c6f:	52                   	push   %edx
  800c70:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c76:	83 c0 08             	add    $0x8,%eax
  800c79:	50                   	push   %eax
  800c7a:	e8 57 10 00 00       	call   801cd6 <sys_cputs>
  800c7f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c82:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800c89:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c97:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800c9e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ca1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	83 ec 08             	sub    $0x8,%esp
  800caa:	ff 75 f4             	pushl  -0xc(%ebp)
  800cad:	50                   	push   %eax
  800cae:	e8 73 ff ff ff       	call   800c26 <vcprintf>
  800cb3:	83 c4 10             	add    $0x10,%esp
  800cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800cb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cbc:	c9                   	leave  
  800cbd:	c3                   	ret    

00800cbe <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800cbe:	55                   	push   %ebp
  800cbf:	89 e5                	mov    %esp,%ebp
  800cc1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800cc4:	e8 1e 12 00 00       	call   801ee7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800cc9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	83 ec 08             	sub    $0x8,%esp
  800cd5:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd8:	50                   	push   %eax
  800cd9:	e8 48 ff ff ff       	call   800c26 <vcprintf>
  800cde:	83 c4 10             	add    $0x10,%esp
  800ce1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ce4:	e8 18 12 00 00       	call   801f01 <sys_enable_interrupt>
	return cnt;
  800ce9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cec:	c9                   	leave  
  800ced:	c3                   	ret    

00800cee <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800cee:	55                   	push   %ebp
  800cef:	89 e5                	mov    %esp,%ebp
  800cf1:	53                   	push   %ebx
  800cf2:	83 ec 14             	sub    $0x14,%esp
  800cf5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cfb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800d01:	8b 45 18             	mov    0x18(%ebp),%eax
  800d04:	ba 00 00 00 00       	mov    $0x0,%edx
  800d09:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d0c:	77 55                	ja     800d63 <printnum+0x75>
  800d0e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800d11:	72 05                	jb     800d18 <printnum+0x2a>
  800d13:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800d16:	77 4b                	ja     800d63 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800d18:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800d1b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800d1e:	8b 45 18             	mov    0x18(%ebp),%eax
  800d21:	ba 00 00 00 00       	mov    $0x0,%edx
  800d26:	52                   	push   %edx
  800d27:	50                   	push   %eax
  800d28:	ff 75 f4             	pushl  -0xc(%ebp)
  800d2b:	ff 75 f0             	pushl  -0x10(%ebp)
  800d2e:	e8 95 15 00 00       	call   8022c8 <__udivdi3>
  800d33:	83 c4 10             	add    $0x10,%esp
  800d36:	83 ec 04             	sub    $0x4,%esp
  800d39:	ff 75 20             	pushl  0x20(%ebp)
  800d3c:	53                   	push   %ebx
  800d3d:	ff 75 18             	pushl  0x18(%ebp)
  800d40:	52                   	push   %edx
  800d41:	50                   	push   %eax
  800d42:	ff 75 0c             	pushl  0xc(%ebp)
  800d45:	ff 75 08             	pushl  0x8(%ebp)
  800d48:	e8 a1 ff ff ff       	call   800cee <printnum>
  800d4d:	83 c4 20             	add    $0x20,%esp
  800d50:	eb 1a                	jmp    800d6c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800d52:	83 ec 08             	sub    $0x8,%esp
  800d55:	ff 75 0c             	pushl  0xc(%ebp)
  800d58:	ff 75 20             	pushl  0x20(%ebp)
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	ff d0                	call   *%eax
  800d60:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d63:	ff 4d 1c             	decl   0x1c(%ebp)
  800d66:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d6a:	7f e6                	jg     800d52 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d6c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d6f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d74:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d77:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d7a:	53                   	push   %ebx
  800d7b:	51                   	push   %ecx
  800d7c:	52                   	push   %edx
  800d7d:	50                   	push   %eax
  800d7e:	e8 55 16 00 00       	call   8023d8 <__umoddi3>
  800d83:	83 c4 10             	add    $0x10,%esp
  800d86:	05 74 2a 80 00       	add    $0x802a74,%eax
  800d8b:	8a 00                	mov    (%eax),%al
  800d8d:	0f be c0             	movsbl %al,%eax
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	50                   	push   %eax
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	ff d0                	call   *%eax
  800d9c:	83 c4 10             	add    $0x10,%esp
}
  800d9f:	90                   	nop
  800da0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800da3:	c9                   	leave  
  800da4:	c3                   	ret    

00800da5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800da5:	55                   	push   %ebp
  800da6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800da8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800dac:	7e 1c                	jle    800dca <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	8b 00                	mov    (%eax),%eax
  800db3:	8d 50 08             	lea    0x8(%eax),%edx
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	89 10                	mov    %edx,(%eax)
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	8b 00                	mov    (%eax),%eax
  800dc0:	83 e8 08             	sub    $0x8,%eax
  800dc3:	8b 50 04             	mov    0x4(%eax),%edx
  800dc6:	8b 00                	mov    (%eax),%eax
  800dc8:	eb 40                	jmp    800e0a <getuint+0x65>
	else if (lflag)
  800dca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dce:	74 1e                	je     800dee <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	8b 00                	mov    (%eax),%eax
  800dd5:	8d 50 04             	lea    0x4(%eax),%edx
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	89 10                	mov    %edx,(%eax)
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8b 00                	mov    (%eax),%eax
  800de2:	83 e8 04             	sub    $0x4,%eax
  800de5:	8b 00                	mov    (%eax),%eax
  800de7:	ba 00 00 00 00       	mov    $0x0,%edx
  800dec:	eb 1c                	jmp    800e0a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	8b 00                	mov    (%eax),%eax
  800df3:	8d 50 04             	lea    0x4(%eax),%edx
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	89 10                	mov    %edx,(%eax)
  800dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfe:	8b 00                	mov    (%eax),%eax
  800e00:	83 e8 04             	sub    $0x4,%eax
  800e03:	8b 00                	mov    (%eax),%eax
  800e05:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800e0a:	5d                   	pop    %ebp
  800e0b:	c3                   	ret    

00800e0c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800e0c:	55                   	push   %ebp
  800e0d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800e0f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800e13:	7e 1c                	jle    800e31 <getint+0x25>
		return va_arg(*ap, long long);
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	8b 00                	mov    (%eax),%eax
  800e1a:	8d 50 08             	lea    0x8(%eax),%edx
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	89 10                	mov    %edx,(%eax)
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	8b 00                	mov    (%eax),%eax
  800e27:	83 e8 08             	sub    $0x8,%eax
  800e2a:	8b 50 04             	mov    0x4(%eax),%edx
  800e2d:	8b 00                	mov    (%eax),%eax
  800e2f:	eb 38                	jmp    800e69 <getint+0x5d>
	else if (lflag)
  800e31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e35:	74 1a                	je     800e51 <getint+0x45>
		return va_arg(*ap, long);
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	8b 00                	mov    (%eax),%eax
  800e3c:	8d 50 04             	lea    0x4(%eax),%edx
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	89 10                	mov    %edx,(%eax)
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8b 00                	mov    (%eax),%eax
  800e49:	83 e8 04             	sub    $0x4,%eax
  800e4c:	8b 00                	mov    (%eax),%eax
  800e4e:	99                   	cltd   
  800e4f:	eb 18                	jmp    800e69 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800e51:	8b 45 08             	mov    0x8(%ebp),%eax
  800e54:	8b 00                	mov    (%eax),%eax
  800e56:	8d 50 04             	lea    0x4(%eax),%edx
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	89 10                	mov    %edx,(%eax)
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	8b 00                	mov    (%eax),%eax
  800e63:	83 e8 04             	sub    $0x4,%eax
  800e66:	8b 00                	mov    (%eax),%eax
  800e68:	99                   	cltd   
}
  800e69:	5d                   	pop    %ebp
  800e6a:	c3                   	ret    

00800e6b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e6b:	55                   	push   %ebp
  800e6c:	89 e5                	mov    %esp,%ebp
  800e6e:	56                   	push   %esi
  800e6f:	53                   	push   %ebx
  800e70:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e73:	eb 17                	jmp    800e8c <vprintfmt+0x21>
			if (ch == '\0')
  800e75:	85 db                	test   %ebx,%ebx
  800e77:	0f 84 af 03 00 00    	je     80122c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e7d:	83 ec 08             	sub    $0x8,%esp
  800e80:	ff 75 0c             	pushl  0xc(%ebp)
  800e83:	53                   	push   %ebx
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	ff d0                	call   *%eax
  800e89:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8f:	8d 50 01             	lea    0x1(%eax),%edx
  800e92:	89 55 10             	mov    %edx,0x10(%ebp)
  800e95:	8a 00                	mov    (%eax),%al
  800e97:	0f b6 d8             	movzbl %al,%ebx
  800e9a:	83 fb 25             	cmp    $0x25,%ebx
  800e9d:	75 d6                	jne    800e75 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e9f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ea3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800eaa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800eb1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800eb8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ebf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec2:	8d 50 01             	lea    0x1(%eax),%edx
  800ec5:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	0f b6 d8             	movzbl %al,%ebx
  800ecd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ed0:	83 f8 55             	cmp    $0x55,%eax
  800ed3:	0f 87 2b 03 00 00    	ja     801204 <vprintfmt+0x399>
  800ed9:	8b 04 85 98 2a 80 00 	mov    0x802a98(,%eax,4),%eax
  800ee0:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ee2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ee6:	eb d7                	jmp    800ebf <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ee8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800eec:	eb d1                	jmp    800ebf <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800eee:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ef5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ef8:	89 d0                	mov    %edx,%eax
  800efa:	c1 e0 02             	shl    $0x2,%eax
  800efd:	01 d0                	add    %edx,%eax
  800eff:	01 c0                	add    %eax,%eax
  800f01:	01 d8                	add    %ebx,%eax
  800f03:	83 e8 30             	sub    $0x30,%eax
  800f06:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800f09:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0c:	8a 00                	mov    (%eax),%al
  800f0e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800f11:	83 fb 2f             	cmp    $0x2f,%ebx
  800f14:	7e 3e                	jle    800f54 <vprintfmt+0xe9>
  800f16:	83 fb 39             	cmp    $0x39,%ebx
  800f19:	7f 39                	jg     800f54 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800f1b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800f1e:	eb d5                	jmp    800ef5 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800f20:	8b 45 14             	mov    0x14(%ebp),%eax
  800f23:	83 c0 04             	add    $0x4,%eax
  800f26:	89 45 14             	mov    %eax,0x14(%ebp)
  800f29:	8b 45 14             	mov    0x14(%ebp),%eax
  800f2c:	83 e8 04             	sub    $0x4,%eax
  800f2f:	8b 00                	mov    (%eax),%eax
  800f31:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800f34:	eb 1f                	jmp    800f55 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800f36:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f3a:	79 83                	jns    800ebf <vprintfmt+0x54>
				width = 0;
  800f3c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800f43:	e9 77 ff ff ff       	jmp    800ebf <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800f48:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800f4f:	e9 6b ff ff ff       	jmp    800ebf <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800f54:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800f55:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f59:	0f 89 60 ff ff ff    	jns    800ebf <vprintfmt+0x54>
				width = precision, precision = -1;
  800f5f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f62:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f65:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f6c:	e9 4e ff ff ff       	jmp    800ebf <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f71:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f74:	e9 46 ff ff ff       	jmp    800ebf <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f79:	8b 45 14             	mov    0x14(%ebp),%eax
  800f7c:	83 c0 04             	add    $0x4,%eax
  800f7f:	89 45 14             	mov    %eax,0x14(%ebp)
  800f82:	8b 45 14             	mov    0x14(%ebp),%eax
  800f85:	83 e8 04             	sub    $0x4,%eax
  800f88:	8b 00                	mov    (%eax),%eax
  800f8a:	83 ec 08             	sub    $0x8,%esp
  800f8d:	ff 75 0c             	pushl  0xc(%ebp)
  800f90:	50                   	push   %eax
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	ff d0                	call   *%eax
  800f96:	83 c4 10             	add    $0x10,%esp
			break;
  800f99:	e9 89 02 00 00       	jmp    801227 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa1:	83 c0 04             	add    $0x4,%eax
  800fa4:	89 45 14             	mov    %eax,0x14(%ebp)
  800fa7:	8b 45 14             	mov    0x14(%ebp),%eax
  800faa:	83 e8 04             	sub    $0x4,%eax
  800fad:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800faf:	85 db                	test   %ebx,%ebx
  800fb1:	79 02                	jns    800fb5 <vprintfmt+0x14a>
				err = -err;
  800fb3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800fb5:	83 fb 64             	cmp    $0x64,%ebx
  800fb8:	7f 0b                	jg     800fc5 <vprintfmt+0x15a>
  800fba:	8b 34 9d e0 28 80 00 	mov    0x8028e0(,%ebx,4),%esi
  800fc1:	85 f6                	test   %esi,%esi
  800fc3:	75 19                	jne    800fde <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800fc5:	53                   	push   %ebx
  800fc6:	68 85 2a 80 00       	push   $0x802a85
  800fcb:	ff 75 0c             	pushl  0xc(%ebp)
  800fce:	ff 75 08             	pushl  0x8(%ebp)
  800fd1:	e8 5e 02 00 00       	call   801234 <printfmt>
  800fd6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800fd9:	e9 49 02 00 00       	jmp    801227 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800fde:	56                   	push   %esi
  800fdf:	68 8e 2a 80 00       	push   $0x802a8e
  800fe4:	ff 75 0c             	pushl  0xc(%ebp)
  800fe7:	ff 75 08             	pushl  0x8(%ebp)
  800fea:	e8 45 02 00 00       	call   801234 <printfmt>
  800fef:	83 c4 10             	add    $0x10,%esp
			break;
  800ff2:	e9 30 02 00 00       	jmp    801227 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ff7:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffa:	83 c0 04             	add    $0x4,%eax
  800ffd:	89 45 14             	mov    %eax,0x14(%ebp)
  801000:	8b 45 14             	mov    0x14(%ebp),%eax
  801003:	83 e8 04             	sub    $0x4,%eax
  801006:	8b 30                	mov    (%eax),%esi
  801008:	85 f6                	test   %esi,%esi
  80100a:	75 05                	jne    801011 <vprintfmt+0x1a6>
				p = "(null)";
  80100c:	be 91 2a 80 00       	mov    $0x802a91,%esi
			if (width > 0 && padc != '-')
  801011:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801015:	7e 6d                	jle    801084 <vprintfmt+0x219>
  801017:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80101b:	74 67                	je     801084 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80101d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801020:	83 ec 08             	sub    $0x8,%esp
  801023:	50                   	push   %eax
  801024:	56                   	push   %esi
  801025:	e8 0c 03 00 00       	call   801336 <strnlen>
  80102a:	83 c4 10             	add    $0x10,%esp
  80102d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801030:	eb 16                	jmp    801048 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801032:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801036:	83 ec 08             	sub    $0x8,%esp
  801039:	ff 75 0c             	pushl  0xc(%ebp)
  80103c:	50                   	push   %eax
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	ff d0                	call   *%eax
  801042:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801045:	ff 4d e4             	decl   -0x1c(%ebp)
  801048:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80104c:	7f e4                	jg     801032 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80104e:	eb 34                	jmp    801084 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801050:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801054:	74 1c                	je     801072 <vprintfmt+0x207>
  801056:	83 fb 1f             	cmp    $0x1f,%ebx
  801059:	7e 05                	jle    801060 <vprintfmt+0x1f5>
  80105b:	83 fb 7e             	cmp    $0x7e,%ebx
  80105e:	7e 12                	jle    801072 <vprintfmt+0x207>
					putch('?', putdat);
  801060:	83 ec 08             	sub    $0x8,%esp
  801063:	ff 75 0c             	pushl  0xc(%ebp)
  801066:	6a 3f                	push   $0x3f
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	ff d0                	call   *%eax
  80106d:	83 c4 10             	add    $0x10,%esp
  801070:	eb 0f                	jmp    801081 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801072:	83 ec 08             	sub    $0x8,%esp
  801075:	ff 75 0c             	pushl  0xc(%ebp)
  801078:	53                   	push   %ebx
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	ff d0                	call   *%eax
  80107e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801081:	ff 4d e4             	decl   -0x1c(%ebp)
  801084:	89 f0                	mov    %esi,%eax
  801086:	8d 70 01             	lea    0x1(%eax),%esi
  801089:	8a 00                	mov    (%eax),%al
  80108b:	0f be d8             	movsbl %al,%ebx
  80108e:	85 db                	test   %ebx,%ebx
  801090:	74 24                	je     8010b6 <vprintfmt+0x24b>
  801092:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801096:	78 b8                	js     801050 <vprintfmt+0x1e5>
  801098:	ff 4d e0             	decl   -0x20(%ebp)
  80109b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80109f:	79 af                	jns    801050 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010a1:	eb 13                	jmp    8010b6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8010a3:	83 ec 08             	sub    $0x8,%esp
  8010a6:	ff 75 0c             	pushl  0xc(%ebp)
  8010a9:	6a 20                	push   $0x20
  8010ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ae:	ff d0                	call   *%eax
  8010b0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8010b3:	ff 4d e4             	decl   -0x1c(%ebp)
  8010b6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8010ba:	7f e7                	jg     8010a3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8010bc:	e9 66 01 00 00       	jmp    801227 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8010c1:	83 ec 08             	sub    $0x8,%esp
  8010c4:	ff 75 e8             	pushl  -0x18(%ebp)
  8010c7:	8d 45 14             	lea    0x14(%ebp),%eax
  8010ca:	50                   	push   %eax
  8010cb:	e8 3c fd ff ff       	call   800e0c <getint>
  8010d0:	83 c4 10             	add    $0x10,%esp
  8010d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8010d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010df:	85 d2                	test   %edx,%edx
  8010e1:	79 23                	jns    801106 <vprintfmt+0x29b>
				putch('-', putdat);
  8010e3:	83 ec 08             	sub    $0x8,%esp
  8010e6:	ff 75 0c             	pushl  0xc(%ebp)
  8010e9:	6a 2d                	push   $0x2d
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	ff d0                	call   *%eax
  8010f0:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8010f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010f9:	f7 d8                	neg    %eax
  8010fb:	83 d2 00             	adc    $0x0,%edx
  8010fe:	f7 da                	neg    %edx
  801100:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801103:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801106:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80110d:	e9 bc 00 00 00       	jmp    8011ce <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801112:	83 ec 08             	sub    $0x8,%esp
  801115:	ff 75 e8             	pushl  -0x18(%ebp)
  801118:	8d 45 14             	lea    0x14(%ebp),%eax
  80111b:	50                   	push   %eax
  80111c:	e8 84 fc ff ff       	call   800da5 <getuint>
  801121:	83 c4 10             	add    $0x10,%esp
  801124:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801127:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80112a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801131:	e9 98 00 00 00       	jmp    8011ce <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801136:	83 ec 08             	sub    $0x8,%esp
  801139:	ff 75 0c             	pushl  0xc(%ebp)
  80113c:	6a 58                	push   $0x58
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	ff d0                	call   *%eax
  801143:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801146:	83 ec 08             	sub    $0x8,%esp
  801149:	ff 75 0c             	pushl  0xc(%ebp)
  80114c:	6a 58                	push   $0x58
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	ff d0                	call   *%eax
  801153:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801156:	83 ec 08             	sub    $0x8,%esp
  801159:	ff 75 0c             	pushl  0xc(%ebp)
  80115c:	6a 58                	push   $0x58
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	ff d0                	call   *%eax
  801163:	83 c4 10             	add    $0x10,%esp
			break;
  801166:	e9 bc 00 00 00       	jmp    801227 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80116b:	83 ec 08             	sub    $0x8,%esp
  80116e:	ff 75 0c             	pushl  0xc(%ebp)
  801171:	6a 30                	push   $0x30
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	ff d0                	call   *%eax
  801178:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80117b:	83 ec 08             	sub    $0x8,%esp
  80117e:	ff 75 0c             	pushl  0xc(%ebp)
  801181:	6a 78                	push   $0x78
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	ff d0                	call   *%eax
  801188:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80118b:	8b 45 14             	mov    0x14(%ebp),%eax
  80118e:	83 c0 04             	add    $0x4,%eax
  801191:	89 45 14             	mov    %eax,0x14(%ebp)
  801194:	8b 45 14             	mov    0x14(%ebp),%eax
  801197:	83 e8 04             	sub    $0x4,%eax
  80119a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80119c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80119f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8011a6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8011ad:	eb 1f                	jmp    8011ce <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8011af:	83 ec 08             	sub    $0x8,%esp
  8011b2:	ff 75 e8             	pushl  -0x18(%ebp)
  8011b5:	8d 45 14             	lea    0x14(%ebp),%eax
  8011b8:	50                   	push   %eax
  8011b9:	e8 e7 fb ff ff       	call   800da5 <getuint>
  8011be:	83 c4 10             	add    $0x10,%esp
  8011c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8011c7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8011ce:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8011d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d5:	83 ec 04             	sub    $0x4,%esp
  8011d8:	52                   	push   %edx
  8011d9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8011dc:	50                   	push   %eax
  8011dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8011e0:	ff 75 f0             	pushl  -0x10(%ebp)
  8011e3:	ff 75 0c             	pushl  0xc(%ebp)
  8011e6:	ff 75 08             	pushl  0x8(%ebp)
  8011e9:	e8 00 fb ff ff       	call   800cee <printnum>
  8011ee:	83 c4 20             	add    $0x20,%esp
			break;
  8011f1:	eb 34                	jmp    801227 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8011f3:	83 ec 08             	sub    $0x8,%esp
  8011f6:	ff 75 0c             	pushl  0xc(%ebp)
  8011f9:	53                   	push   %ebx
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	ff d0                	call   *%eax
  8011ff:	83 c4 10             	add    $0x10,%esp
			break;
  801202:	eb 23                	jmp    801227 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801204:	83 ec 08             	sub    $0x8,%esp
  801207:	ff 75 0c             	pushl  0xc(%ebp)
  80120a:	6a 25                	push   $0x25
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	ff d0                	call   *%eax
  801211:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801214:	ff 4d 10             	decl   0x10(%ebp)
  801217:	eb 03                	jmp    80121c <vprintfmt+0x3b1>
  801219:	ff 4d 10             	decl   0x10(%ebp)
  80121c:	8b 45 10             	mov    0x10(%ebp),%eax
  80121f:	48                   	dec    %eax
  801220:	8a 00                	mov    (%eax),%al
  801222:	3c 25                	cmp    $0x25,%al
  801224:	75 f3                	jne    801219 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801226:	90                   	nop
		}
	}
  801227:	e9 47 fc ff ff       	jmp    800e73 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80122c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80122d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801230:	5b                   	pop    %ebx
  801231:	5e                   	pop    %esi
  801232:	5d                   	pop    %ebp
  801233:	c3                   	ret    

00801234 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801234:	55                   	push   %ebp
  801235:	89 e5                	mov    %esp,%ebp
  801237:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80123a:	8d 45 10             	lea    0x10(%ebp),%eax
  80123d:	83 c0 04             	add    $0x4,%eax
  801240:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801243:	8b 45 10             	mov    0x10(%ebp),%eax
  801246:	ff 75 f4             	pushl  -0xc(%ebp)
  801249:	50                   	push   %eax
  80124a:	ff 75 0c             	pushl  0xc(%ebp)
  80124d:	ff 75 08             	pushl  0x8(%ebp)
  801250:	e8 16 fc ff ff       	call   800e6b <vprintfmt>
  801255:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801258:	90                   	nop
  801259:	c9                   	leave  
  80125a:	c3                   	ret    

0080125b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80125e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801261:	8b 40 08             	mov    0x8(%eax),%eax
  801264:	8d 50 01             	lea    0x1(%eax),%edx
  801267:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80126d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801270:	8b 10                	mov    (%eax),%edx
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	8b 40 04             	mov    0x4(%eax),%eax
  801278:	39 c2                	cmp    %eax,%edx
  80127a:	73 12                	jae    80128e <sprintputch+0x33>
		*b->buf++ = ch;
  80127c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127f:	8b 00                	mov    (%eax),%eax
  801281:	8d 48 01             	lea    0x1(%eax),%ecx
  801284:	8b 55 0c             	mov    0xc(%ebp),%edx
  801287:	89 0a                	mov    %ecx,(%edx)
  801289:	8b 55 08             	mov    0x8(%ebp),%edx
  80128c:	88 10                	mov    %dl,(%eax)
}
  80128e:	90                   	nop
  80128f:	5d                   	pop    %ebp
  801290:	c3                   	ret    

00801291 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8012b2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012b6:	74 06                	je     8012be <vsnprintf+0x2d>
  8012b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012bc:	7f 07                	jg     8012c5 <vsnprintf+0x34>
		return -E_INVAL;
  8012be:	b8 03 00 00 00       	mov    $0x3,%eax
  8012c3:	eb 20                	jmp    8012e5 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8012c5:	ff 75 14             	pushl  0x14(%ebp)
  8012c8:	ff 75 10             	pushl  0x10(%ebp)
  8012cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8012ce:	50                   	push   %eax
  8012cf:	68 5b 12 80 00       	push   $0x80125b
  8012d4:	e8 92 fb ff ff       	call   800e6b <vprintfmt>
  8012d9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8012dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012df:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8012e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8012e5:	c9                   	leave  
  8012e6:	c3                   	ret    

008012e7 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8012e7:	55                   	push   %ebp
  8012e8:	89 e5                	mov    %esp,%ebp
  8012ea:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8012ed:	8d 45 10             	lea    0x10(%ebp),%eax
  8012f0:	83 c0 04             	add    $0x4,%eax
  8012f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8012f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8012fc:	50                   	push   %eax
  8012fd:	ff 75 0c             	pushl  0xc(%ebp)
  801300:	ff 75 08             	pushl  0x8(%ebp)
  801303:	e8 89 ff ff ff       	call   801291 <vsnprintf>
  801308:	83 c4 10             	add    $0x10,%esp
  80130b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80130e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801311:	c9                   	leave  
  801312:	c3                   	ret    

00801313 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801313:	55                   	push   %ebp
  801314:	89 e5                	mov    %esp,%ebp
  801316:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801319:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801320:	eb 06                	jmp    801328 <strlen+0x15>
		n++;
  801322:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801325:	ff 45 08             	incl   0x8(%ebp)
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	84 c0                	test   %al,%al
  80132f:	75 f1                	jne    801322 <strlen+0xf>
		n++;
	return n;
  801331:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
  801339:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80133c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801343:	eb 09                	jmp    80134e <strnlen+0x18>
		n++;
  801345:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801348:	ff 45 08             	incl   0x8(%ebp)
  80134b:	ff 4d 0c             	decl   0xc(%ebp)
  80134e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801352:	74 09                	je     80135d <strnlen+0x27>
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	84 c0                	test   %al,%al
  80135b:	75 e8                	jne    801345 <strnlen+0xf>
		n++;
	return n;
  80135d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
  801365:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80136e:	90                   	nop
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8d 50 01             	lea    0x1(%eax),%edx
  801375:	89 55 08             	mov    %edx,0x8(%ebp)
  801378:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80137e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801381:	8a 12                	mov    (%edx),%dl
  801383:	88 10                	mov    %dl,(%eax)
  801385:	8a 00                	mov    (%eax),%al
  801387:	84 c0                	test   %al,%al
  801389:	75 e4                	jne    80136f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80138b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
  801393:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80139c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013a3:	eb 1f                	jmp    8013c4 <strncpy+0x34>
		*dst++ = *src;
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	8d 50 01             	lea    0x1(%eax),%edx
  8013ab:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b1:	8a 12                	mov    (%edx),%dl
  8013b3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	84 c0                	test   %al,%al
  8013bc:	74 03                	je     8013c1 <strncpy+0x31>
			src++;
  8013be:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013c1:	ff 45 fc             	incl   -0x4(%ebp)
  8013c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013ca:	72 d9                	jb     8013a5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
  8013d4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e1:	74 30                	je     801413 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013e3:	eb 16                	jmp    8013fb <strlcpy+0x2a>
			*dst++ = *src++;
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	8d 50 01             	lea    0x1(%eax),%edx
  8013eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013f4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013f7:	8a 12                	mov    (%edx),%dl
  8013f9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013fb:	ff 4d 10             	decl   0x10(%ebp)
  8013fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801402:	74 09                	je     80140d <strlcpy+0x3c>
  801404:	8b 45 0c             	mov    0xc(%ebp),%eax
  801407:	8a 00                	mov    (%eax),%al
  801409:	84 c0                	test   %al,%al
  80140b:	75 d8                	jne    8013e5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801413:	8b 55 08             	mov    0x8(%ebp),%edx
  801416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801419:	29 c2                	sub    %eax,%edx
  80141b:	89 d0                	mov    %edx,%eax
}
  80141d:	c9                   	leave  
  80141e:	c3                   	ret    

0080141f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80141f:	55                   	push   %ebp
  801420:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801422:	eb 06                	jmp    80142a <strcmp+0xb>
		p++, q++;
  801424:	ff 45 08             	incl   0x8(%ebp)
  801427:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	84 c0                	test   %al,%al
  801431:	74 0e                	je     801441 <strcmp+0x22>
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 10                	mov    (%eax),%dl
  801438:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143b:	8a 00                	mov    (%eax),%al
  80143d:	38 c2                	cmp    %al,%dl
  80143f:	74 e3                	je     801424 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	0f b6 d0             	movzbl %al,%edx
  801449:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144c:	8a 00                	mov    (%eax),%al
  80144e:	0f b6 c0             	movzbl %al,%eax
  801451:	29 c2                	sub    %eax,%edx
  801453:	89 d0                	mov    %edx,%eax
}
  801455:	5d                   	pop    %ebp
  801456:	c3                   	ret    

00801457 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80145a:	eb 09                	jmp    801465 <strncmp+0xe>
		n--, p++, q++;
  80145c:	ff 4d 10             	decl   0x10(%ebp)
  80145f:	ff 45 08             	incl   0x8(%ebp)
  801462:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801465:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801469:	74 17                	je     801482 <strncmp+0x2b>
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	84 c0                	test   %al,%al
  801472:	74 0e                	je     801482 <strncmp+0x2b>
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	8a 10                	mov    (%eax),%dl
  801479:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	38 c2                	cmp    %al,%dl
  801480:	74 da                	je     80145c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801482:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801486:	75 07                	jne    80148f <strncmp+0x38>
		return 0;
  801488:	b8 00 00 00 00       	mov    $0x0,%eax
  80148d:	eb 14                	jmp    8014a3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	0f b6 d0             	movzbl %al,%edx
  801497:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149a:	8a 00                	mov    (%eax),%al
  80149c:	0f b6 c0             	movzbl %al,%eax
  80149f:	29 c2                	sub    %eax,%edx
  8014a1:	89 d0                	mov    %edx,%eax
}
  8014a3:	5d                   	pop    %ebp
  8014a4:	c3                   	ret    

008014a5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014a5:	55                   	push   %ebp
  8014a6:	89 e5                	mov    %esp,%ebp
  8014a8:	83 ec 04             	sub    $0x4,%esp
  8014ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ae:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014b1:	eb 12                	jmp    8014c5 <strchr+0x20>
		if (*s == c)
  8014b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b6:	8a 00                	mov    (%eax),%al
  8014b8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014bb:	75 05                	jne    8014c2 <strchr+0x1d>
			return (char *) s;
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	eb 11                	jmp    8014d3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014c2:	ff 45 08             	incl   0x8(%ebp)
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	8a 00                	mov    (%eax),%al
  8014ca:	84 c0                	test   %al,%al
  8014cc:	75 e5                	jne    8014b3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014d3:	c9                   	leave  
  8014d4:	c3                   	ret    

008014d5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014d5:	55                   	push   %ebp
  8014d6:	89 e5                	mov    %esp,%ebp
  8014d8:	83 ec 04             	sub    $0x4,%esp
  8014db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014de:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014e1:	eb 0d                	jmp    8014f0 <strfind+0x1b>
		if (*s == c)
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	8a 00                	mov    (%eax),%al
  8014e8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014eb:	74 0e                	je     8014fb <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014ed:	ff 45 08             	incl   0x8(%ebp)
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	8a 00                	mov    (%eax),%al
  8014f5:	84 c0                	test   %al,%al
  8014f7:	75 ea                	jne    8014e3 <strfind+0xe>
  8014f9:	eb 01                	jmp    8014fc <strfind+0x27>
		if (*s == c)
			break;
  8014fb:	90                   	nop
	return (char *) s;
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014ff:	c9                   	leave  
  801500:	c3                   	ret    

00801501 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801501:	55                   	push   %ebp
  801502:	89 e5                	mov    %esp,%ebp
  801504:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80150d:	8b 45 10             	mov    0x10(%ebp),%eax
  801510:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801513:	eb 0e                	jmp    801523 <memset+0x22>
		*p++ = c;
  801515:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801518:	8d 50 01             	lea    0x1(%eax),%edx
  80151b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80151e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801521:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801523:	ff 4d f8             	decl   -0x8(%ebp)
  801526:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80152a:	79 e9                	jns    801515 <memset+0x14>
		*p++ = c;

	return v;
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80152f:	c9                   	leave  
  801530:	c3                   	ret    

00801531 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
  801534:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801543:	eb 16                	jmp    80155b <memcpy+0x2a>
		*d++ = *s++;
  801545:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801548:	8d 50 01             	lea    0x1(%eax),%edx
  80154b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80154e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801551:	8d 4a 01             	lea    0x1(%edx),%ecx
  801554:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801557:	8a 12                	mov    (%edx),%dl
  801559:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80155b:	8b 45 10             	mov    0x10(%ebp),%eax
  80155e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801561:	89 55 10             	mov    %edx,0x10(%ebp)
  801564:	85 c0                	test   %eax,%eax
  801566:	75 dd                	jne    801545 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
  801570:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801573:	8b 45 0c             	mov    0xc(%ebp),%eax
  801576:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80157f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801582:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801585:	73 50                	jae    8015d7 <memmove+0x6a>
  801587:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80158a:	8b 45 10             	mov    0x10(%ebp),%eax
  80158d:	01 d0                	add    %edx,%eax
  80158f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801592:	76 43                	jbe    8015d7 <memmove+0x6a>
		s += n;
  801594:	8b 45 10             	mov    0x10(%ebp),%eax
  801597:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80159a:	8b 45 10             	mov    0x10(%ebp),%eax
  80159d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015a0:	eb 10                	jmp    8015b2 <memmove+0x45>
			*--d = *--s;
  8015a2:	ff 4d f8             	decl   -0x8(%ebp)
  8015a5:	ff 4d fc             	decl   -0x4(%ebp)
  8015a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ab:	8a 10                	mov    (%eax),%dl
  8015ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b8:	89 55 10             	mov    %edx,0x10(%ebp)
  8015bb:	85 c0                	test   %eax,%eax
  8015bd:	75 e3                	jne    8015a2 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015bf:	eb 23                	jmp    8015e4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c4:	8d 50 01             	lea    0x1(%eax),%edx
  8015c7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015d0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015d3:	8a 12                	mov    (%edx),%dl
  8015d5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015dd:	89 55 10             	mov    %edx,0x10(%ebp)
  8015e0:	85 c0                	test   %eax,%eax
  8015e2:	75 dd                	jne    8015c1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015fb:	eb 2a                	jmp    801627 <memcmp+0x3e>
		if (*s1 != *s2)
  8015fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801600:	8a 10                	mov    (%eax),%dl
  801602:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801605:	8a 00                	mov    (%eax),%al
  801607:	38 c2                	cmp    %al,%dl
  801609:	74 16                	je     801621 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80160b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160e:	8a 00                	mov    (%eax),%al
  801610:	0f b6 d0             	movzbl %al,%edx
  801613:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801616:	8a 00                	mov    (%eax),%al
  801618:	0f b6 c0             	movzbl %al,%eax
  80161b:	29 c2                	sub    %eax,%edx
  80161d:	89 d0                	mov    %edx,%eax
  80161f:	eb 18                	jmp    801639 <memcmp+0x50>
		s1++, s2++;
  801621:	ff 45 fc             	incl   -0x4(%ebp)
  801624:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801627:	8b 45 10             	mov    0x10(%ebp),%eax
  80162a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80162d:	89 55 10             	mov    %edx,0x10(%ebp)
  801630:	85 c0                	test   %eax,%eax
  801632:	75 c9                	jne    8015fd <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801634:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
  80163e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801641:	8b 55 08             	mov    0x8(%ebp),%edx
  801644:	8b 45 10             	mov    0x10(%ebp),%eax
  801647:	01 d0                	add    %edx,%eax
  801649:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80164c:	eb 15                	jmp    801663 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	0f b6 d0             	movzbl %al,%edx
  801656:	8b 45 0c             	mov    0xc(%ebp),%eax
  801659:	0f b6 c0             	movzbl %al,%eax
  80165c:	39 c2                	cmp    %eax,%edx
  80165e:	74 0d                	je     80166d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801660:	ff 45 08             	incl   0x8(%ebp)
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801669:	72 e3                	jb     80164e <memfind+0x13>
  80166b:	eb 01                	jmp    80166e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80166d:	90                   	nop
	return (void *) s;
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
  801676:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801679:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801680:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801687:	eb 03                	jmp    80168c <strtol+0x19>
		s++;
  801689:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	8a 00                	mov    (%eax),%al
  801691:	3c 20                	cmp    $0x20,%al
  801693:	74 f4                	je     801689 <strtol+0x16>
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	8a 00                	mov    (%eax),%al
  80169a:	3c 09                	cmp    $0x9,%al
  80169c:	74 eb                	je     801689 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	3c 2b                	cmp    $0x2b,%al
  8016a5:	75 05                	jne    8016ac <strtol+0x39>
		s++;
  8016a7:	ff 45 08             	incl   0x8(%ebp)
  8016aa:	eb 13                	jmp    8016bf <strtol+0x4c>
	else if (*s == '-')
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	3c 2d                	cmp    $0x2d,%al
  8016b3:	75 0a                	jne    8016bf <strtol+0x4c>
		s++, neg = 1;
  8016b5:	ff 45 08             	incl   0x8(%ebp)
  8016b8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c3:	74 06                	je     8016cb <strtol+0x58>
  8016c5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016c9:	75 20                	jne    8016eb <strtol+0x78>
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	8a 00                	mov    (%eax),%al
  8016d0:	3c 30                	cmp    $0x30,%al
  8016d2:	75 17                	jne    8016eb <strtol+0x78>
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	40                   	inc    %eax
  8016d8:	8a 00                	mov    (%eax),%al
  8016da:	3c 78                	cmp    $0x78,%al
  8016dc:	75 0d                	jne    8016eb <strtol+0x78>
		s += 2, base = 16;
  8016de:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016e2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016e9:	eb 28                	jmp    801713 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016ef:	75 15                	jne    801706 <strtol+0x93>
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	3c 30                	cmp    $0x30,%al
  8016f8:	75 0c                	jne    801706 <strtol+0x93>
		s++, base = 8;
  8016fa:	ff 45 08             	incl   0x8(%ebp)
  8016fd:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801704:	eb 0d                	jmp    801713 <strtol+0xa0>
	else if (base == 0)
  801706:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80170a:	75 07                	jne    801713 <strtol+0xa0>
		base = 10;
  80170c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	8a 00                	mov    (%eax),%al
  801718:	3c 2f                	cmp    $0x2f,%al
  80171a:	7e 19                	jle    801735 <strtol+0xc2>
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	8a 00                	mov    (%eax),%al
  801721:	3c 39                	cmp    $0x39,%al
  801723:	7f 10                	jg     801735 <strtol+0xc2>
			dig = *s - '0';
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	8a 00                	mov    (%eax),%al
  80172a:	0f be c0             	movsbl %al,%eax
  80172d:	83 e8 30             	sub    $0x30,%eax
  801730:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801733:	eb 42                	jmp    801777 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
  801738:	8a 00                	mov    (%eax),%al
  80173a:	3c 60                	cmp    $0x60,%al
  80173c:	7e 19                	jle    801757 <strtol+0xe4>
  80173e:	8b 45 08             	mov    0x8(%ebp),%eax
  801741:	8a 00                	mov    (%eax),%al
  801743:	3c 7a                	cmp    $0x7a,%al
  801745:	7f 10                	jg     801757 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801747:	8b 45 08             	mov    0x8(%ebp),%eax
  80174a:	8a 00                	mov    (%eax),%al
  80174c:	0f be c0             	movsbl %al,%eax
  80174f:	83 e8 57             	sub    $0x57,%eax
  801752:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801755:	eb 20                	jmp    801777 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801757:	8b 45 08             	mov    0x8(%ebp),%eax
  80175a:	8a 00                	mov    (%eax),%al
  80175c:	3c 40                	cmp    $0x40,%al
  80175e:	7e 39                	jle    801799 <strtol+0x126>
  801760:	8b 45 08             	mov    0x8(%ebp),%eax
  801763:	8a 00                	mov    (%eax),%al
  801765:	3c 5a                	cmp    $0x5a,%al
  801767:	7f 30                	jg     801799 <strtol+0x126>
			dig = *s - 'A' + 10;
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	8a 00                	mov    (%eax),%al
  80176e:	0f be c0             	movsbl %al,%eax
  801771:	83 e8 37             	sub    $0x37,%eax
  801774:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801777:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80177a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80177d:	7d 19                	jge    801798 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80177f:	ff 45 08             	incl   0x8(%ebp)
  801782:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801785:	0f af 45 10          	imul   0x10(%ebp),%eax
  801789:	89 c2                	mov    %eax,%edx
  80178b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80178e:	01 d0                	add    %edx,%eax
  801790:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801793:	e9 7b ff ff ff       	jmp    801713 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801798:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801799:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80179d:	74 08                	je     8017a7 <strtol+0x134>
		*endptr = (char *) s;
  80179f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a2:	8b 55 08             	mov    0x8(%ebp),%edx
  8017a5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017ab:	74 07                	je     8017b4 <strtol+0x141>
  8017ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b0:	f7 d8                	neg    %eax
  8017b2:	eb 03                	jmp    8017b7 <strtol+0x144>
  8017b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017b7:	c9                   	leave  
  8017b8:	c3                   	ret    

008017b9 <ltostr>:

void
ltostr(long value, char *str)
{
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
  8017bc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017d1:	79 13                	jns    8017e6 <ltostr+0x2d>
	{
		neg = 1;
  8017d3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017dd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017e0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017e3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017ee:	99                   	cltd   
  8017ef:	f7 f9                	idiv   %ecx
  8017f1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f7:	8d 50 01             	lea    0x1(%eax),%edx
  8017fa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017fd:	89 c2                	mov    %eax,%edx
  8017ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801802:	01 d0                	add    %edx,%eax
  801804:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801807:	83 c2 30             	add    $0x30,%edx
  80180a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80180c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80180f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801814:	f7 e9                	imul   %ecx
  801816:	c1 fa 02             	sar    $0x2,%edx
  801819:	89 c8                	mov    %ecx,%eax
  80181b:	c1 f8 1f             	sar    $0x1f,%eax
  80181e:	29 c2                	sub    %eax,%edx
  801820:	89 d0                	mov    %edx,%eax
  801822:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801825:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801828:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80182d:	f7 e9                	imul   %ecx
  80182f:	c1 fa 02             	sar    $0x2,%edx
  801832:	89 c8                	mov    %ecx,%eax
  801834:	c1 f8 1f             	sar    $0x1f,%eax
  801837:	29 c2                	sub    %eax,%edx
  801839:	89 d0                	mov    %edx,%eax
  80183b:	c1 e0 02             	shl    $0x2,%eax
  80183e:	01 d0                	add    %edx,%eax
  801840:	01 c0                	add    %eax,%eax
  801842:	29 c1                	sub    %eax,%ecx
  801844:	89 ca                	mov    %ecx,%edx
  801846:	85 d2                	test   %edx,%edx
  801848:	75 9c                	jne    8017e6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80184a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801851:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801854:	48                   	dec    %eax
  801855:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801858:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80185c:	74 3d                	je     80189b <ltostr+0xe2>
		start = 1 ;
  80185e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801865:	eb 34                	jmp    80189b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801867:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80186a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186d:	01 d0                	add    %edx,%eax
  80186f:	8a 00                	mov    (%eax),%al
  801871:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801874:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801877:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187a:	01 c2                	add    %eax,%edx
  80187c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80187f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801882:	01 c8                	add    %ecx,%eax
  801884:	8a 00                	mov    (%eax),%al
  801886:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801888:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80188b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188e:	01 c2                	add    %eax,%edx
  801890:	8a 45 eb             	mov    -0x15(%ebp),%al
  801893:	88 02                	mov    %al,(%edx)
		start++ ;
  801895:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801898:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80189b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80189e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018a1:	7c c4                	jl     801867 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018a3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a9:	01 d0                	add    %edx,%eax
  8018ab:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018ae:	90                   	nop
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
  8018b4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018b7:	ff 75 08             	pushl  0x8(%ebp)
  8018ba:	e8 54 fa ff ff       	call   801313 <strlen>
  8018bf:	83 c4 04             	add    $0x4,%esp
  8018c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018c5:	ff 75 0c             	pushl  0xc(%ebp)
  8018c8:	e8 46 fa ff ff       	call   801313 <strlen>
  8018cd:	83 c4 04             	add    $0x4,%esp
  8018d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018e1:	eb 17                	jmp    8018fa <strcconcat+0x49>
		final[s] = str1[s] ;
  8018e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e9:	01 c2                	add    %eax,%edx
  8018eb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	01 c8                	add    %ecx,%eax
  8018f3:	8a 00                	mov    (%eax),%al
  8018f5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018f7:	ff 45 fc             	incl   -0x4(%ebp)
  8018fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018fd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801900:	7c e1                	jl     8018e3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801902:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801909:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801910:	eb 1f                	jmp    801931 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801912:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801915:	8d 50 01             	lea    0x1(%eax),%edx
  801918:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80191b:	89 c2                	mov    %eax,%edx
  80191d:	8b 45 10             	mov    0x10(%ebp),%eax
  801920:	01 c2                	add    %eax,%edx
  801922:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801925:	8b 45 0c             	mov    0xc(%ebp),%eax
  801928:	01 c8                	add    %ecx,%eax
  80192a:	8a 00                	mov    (%eax),%al
  80192c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80192e:	ff 45 f8             	incl   -0x8(%ebp)
  801931:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801934:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801937:	7c d9                	jl     801912 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801939:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80193c:	8b 45 10             	mov    0x10(%ebp),%eax
  80193f:	01 d0                	add    %edx,%eax
  801941:	c6 00 00             	movb   $0x0,(%eax)
}
  801944:	90                   	nop
  801945:	c9                   	leave  
  801946:	c3                   	ret    

00801947 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801947:	55                   	push   %ebp
  801948:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80194a:	8b 45 14             	mov    0x14(%ebp),%eax
  80194d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801953:	8b 45 14             	mov    0x14(%ebp),%eax
  801956:	8b 00                	mov    (%eax),%eax
  801958:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80195f:	8b 45 10             	mov    0x10(%ebp),%eax
  801962:	01 d0                	add    %edx,%eax
  801964:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80196a:	eb 0c                	jmp    801978 <strsplit+0x31>
			*string++ = 0;
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	8d 50 01             	lea    0x1(%eax),%edx
  801972:	89 55 08             	mov    %edx,0x8(%ebp)
  801975:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801978:	8b 45 08             	mov    0x8(%ebp),%eax
  80197b:	8a 00                	mov    (%eax),%al
  80197d:	84 c0                	test   %al,%al
  80197f:	74 18                	je     801999 <strsplit+0x52>
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	8a 00                	mov    (%eax),%al
  801986:	0f be c0             	movsbl %al,%eax
  801989:	50                   	push   %eax
  80198a:	ff 75 0c             	pushl  0xc(%ebp)
  80198d:	e8 13 fb ff ff       	call   8014a5 <strchr>
  801992:	83 c4 08             	add    $0x8,%esp
  801995:	85 c0                	test   %eax,%eax
  801997:	75 d3                	jne    80196c <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	8a 00                	mov    (%eax),%al
  80199e:	84 c0                	test   %al,%al
  8019a0:	74 5a                	je     8019fc <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8019a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a5:	8b 00                	mov    (%eax),%eax
  8019a7:	83 f8 0f             	cmp    $0xf,%eax
  8019aa:	75 07                	jne    8019b3 <strsplit+0x6c>
		{
			return 0;
  8019ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8019b1:	eb 66                	jmp    801a19 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b6:	8b 00                	mov    (%eax),%eax
  8019b8:	8d 48 01             	lea    0x1(%eax),%ecx
  8019bb:	8b 55 14             	mov    0x14(%ebp),%edx
  8019be:	89 0a                	mov    %ecx,(%edx)
  8019c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ca:	01 c2                	add    %eax,%edx
  8019cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cf:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019d1:	eb 03                	jmp    8019d6 <strsplit+0x8f>
			string++;
  8019d3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d9:	8a 00                	mov    (%eax),%al
  8019db:	84 c0                	test   %al,%al
  8019dd:	74 8b                	je     80196a <strsplit+0x23>
  8019df:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e2:	8a 00                	mov    (%eax),%al
  8019e4:	0f be c0             	movsbl %al,%eax
  8019e7:	50                   	push   %eax
  8019e8:	ff 75 0c             	pushl  0xc(%ebp)
  8019eb:	e8 b5 fa ff ff       	call   8014a5 <strchr>
  8019f0:	83 c4 08             	add    $0x8,%esp
  8019f3:	85 c0                	test   %eax,%eax
  8019f5:	74 dc                	je     8019d3 <strsplit+0x8c>
			string++;
	}
  8019f7:	e9 6e ff ff ff       	jmp    80196a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019fc:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801a00:	8b 00                	mov    (%eax),%eax
  801a02:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a09:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0c:	01 d0                	add    %edx,%eax
  801a0e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a14:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
  801a1e:	83 ec 18             	sub    $0x18,%esp
  801a21:	8b 45 10             	mov    0x10(%ebp),%eax
  801a24:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801a27:	83 ec 04             	sub    $0x4,%esp
  801a2a:	68 f0 2b 80 00       	push   $0x802bf0
  801a2f:	6a 17                	push   $0x17
  801a31:	68 0f 2c 80 00       	push   $0x802c0f
  801a36:	e8 a2 ef ff ff       	call   8009dd <_panic>

00801a3b <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a3b:	55                   	push   %ebp
  801a3c:	89 e5                	mov    %esp,%ebp
  801a3e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801a41:	83 ec 04             	sub    $0x4,%esp
  801a44:	68 1b 2c 80 00       	push   $0x802c1b
  801a49:	6a 2f                	push   $0x2f
  801a4b:	68 0f 2c 80 00       	push   $0x802c0f
  801a50:	e8 88 ef ff ff       	call   8009dd <_panic>

00801a55 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
  801a58:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801a5b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801a62:	8b 55 08             	mov    0x8(%ebp),%edx
  801a65:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a68:	01 d0                	add    %edx,%eax
  801a6a:	48                   	dec    %eax
  801a6b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801a6e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a71:	ba 00 00 00 00       	mov    $0x0,%edx
  801a76:	f7 75 ec             	divl   -0x14(%ebp)
  801a79:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a7c:	29 d0                	sub    %edx,%eax
  801a7e:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	c1 e8 0c             	shr    $0xc,%eax
  801a87:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801a8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a91:	e9 c8 00 00 00       	jmp    801b5e <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801a96:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a9d:	eb 27                	jmp    801ac6 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801a9f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801aa5:	01 c2                	add    %eax,%edx
  801aa7:	89 d0                	mov    %edx,%eax
  801aa9:	01 c0                	add    %eax,%eax
  801aab:	01 d0                	add    %edx,%eax
  801aad:	c1 e0 02             	shl    $0x2,%eax
  801ab0:	05 48 30 80 00       	add    $0x803048,%eax
  801ab5:	8b 00                	mov    (%eax),%eax
  801ab7:	85 c0                	test   %eax,%eax
  801ab9:	74 08                	je     801ac3 <malloc+0x6e>
            	i += j;
  801abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801abe:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801ac1:	eb 0b                	jmp    801ace <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801ac3:	ff 45 f0             	incl   -0x10(%ebp)
  801ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ac9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801acc:	72 d1                	jb     801a9f <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ad1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ad4:	0f 85 81 00 00 00    	jne    801b5b <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801add:	05 00 00 08 00       	add    $0x80000,%eax
  801ae2:	c1 e0 0c             	shl    $0xc,%eax
  801ae5:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801ae8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801aef:	eb 1f                	jmp    801b10 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801af1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801af7:	01 c2                	add    %eax,%edx
  801af9:	89 d0                	mov    %edx,%eax
  801afb:	01 c0                	add    %eax,%eax
  801afd:	01 d0                	add    %edx,%eax
  801aff:	c1 e0 02             	shl    $0x2,%eax
  801b02:	05 48 30 80 00       	add    $0x803048,%eax
  801b07:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801b0d:	ff 45 f0             	incl   -0x10(%ebp)
  801b10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b13:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b16:	72 d9                	jb     801af1 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801b18:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b1b:	89 d0                	mov    %edx,%eax
  801b1d:	01 c0                	add    %eax,%eax
  801b1f:	01 d0                	add    %edx,%eax
  801b21:	c1 e0 02             	shl    $0x2,%eax
  801b24:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801b2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b2d:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801b2f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801b32:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801b35:	89 c8                	mov    %ecx,%eax
  801b37:	01 c0                	add    %eax,%eax
  801b39:	01 c8                	add    %ecx,%eax
  801b3b:	c1 e0 02             	shl    $0x2,%eax
  801b3e:	05 44 30 80 00       	add    $0x803044,%eax
  801b43:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801b45:	83 ec 08             	sub    $0x8,%esp
  801b48:	ff 75 08             	pushl  0x8(%ebp)
  801b4b:	ff 75 e0             	pushl  -0x20(%ebp)
  801b4e:	e8 2b 03 00 00       	call   801e7e <sys_allocateMem>
  801b53:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801b56:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b59:	eb 19                	jmp    801b74 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b5b:	ff 45 f4             	incl   -0xc(%ebp)
  801b5e:	a1 04 30 80 00       	mov    0x803004,%eax
  801b63:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801b66:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b69:	0f 83 27 ff ff ff    	jae    801a96 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801b6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b74:	c9                   	leave  
  801b75:	c3                   	ret    

00801b76 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801b76:	55                   	push   %ebp
  801b77:	89 e5                	mov    %esp,%ebp
  801b79:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801b7c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b80:	0f 84 e5 00 00 00    	je     801c6b <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801b86:	8b 45 08             	mov    0x8(%ebp),%eax
  801b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801b8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b8f:	05 00 00 00 80       	add    $0x80000000,%eax
  801b94:	c1 e8 0c             	shr    $0xc,%eax
  801b97:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801b9a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b9d:	89 d0                	mov    %edx,%eax
  801b9f:	01 c0                	add    %eax,%eax
  801ba1:	01 d0                	add    %edx,%eax
  801ba3:	c1 e0 02             	shl    $0x2,%eax
  801ba6:	05 40 30 80 00       	add    $0x803040,%eax
  801bab:	8b 00                	mov    (%eax),%eax
  801bad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bb0:	0f 85 b8 00 00 00    	jne    801c6e <free+0xf8>
  801bb6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bb9:	89 d0                	mov    %edx,%eax
  801bbb:	01 c0                	add    %eax,%eax
  801bbd:	01 d0                	add    %edx,%eax
  801bbf:	c1 e0 02             	shl    $0x2,%eax
  801bc2:	05 48 30 80 00       	add    $0x803048,%eax
  801bc7:	8b 00                	mov    (%eax),%eax
  801bc9:	85 c0                	test   %eax,%eax
  801bcb:	0f 84 9d 00 00 00    	je     801c6e <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801bd1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bd4:	89 d0                	mov    %edx,%eax
  801bd6:	01 c0                	add    %eax,%eax
  801bd8:	01 d0                	add    %edx,%eax
  801bda:	c1 e0 02             	shl    $0x2,%eax
  801bdd:	05 44 30 80 00       	add    $0x803044,%eax
  801be2:	8b 00                	mov    (%eax),%eax
  801be4:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801be7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801bea:	c1 e0 0c             	shl    $0xc,%eax
  801bed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801bf0:	83 ec 08             	sub    $0x8,%esp
  801bf3:	ff 75 e4             	pushl  -0x1c(%ebp)
  801bf6:	ff 75 f0             	pushl  -0x10(%ebp)
  801bf9:	e8 64 02 00 00       	call   801e62 <sys_freeMem>
  801bfe:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c08:	eb 57                	jmp    801c61 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801c0a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c10:	01 c2                	add    %eax,%edx
  801c12:	89 d0                	mov    %edx,%eax
  801c14:	01 c0                	add    %eax,%eax
  801c16:	01 d0                	add    %edx,%eax
  801c18:	c1 e0 02             	shl    $0x2,%eax
  801c1b:	05 48 30 80 00       	add    $0x803048,%eax
  801c20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801c26:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c2c:	01 c2                	add    %eax,%edx
  801c2e:	89 d0                	mov    %edx,%eax
  801c30:	01 c0                	add    %eax,%eax
  801c32:	01 d0                	add    %edx,%eax
  801c34:	c1 e0 02             	shl    $0x2,%eax
  801c37:	05 40 30 80 00       	add    $0x803040,%eax
  801c3c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801c42:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c48:	01 c2                	add    %eax,%edx
  801c4a:	89 d0                	mov    %edx,%eax
  801c4c:	01 c0                	add    %eax,%eax
  801c4e:	01 d0                	add    %edx,%eax
  801c50:	c1 e0 02             	shl    $0x2,%eax
  801c53:	05 44 30 80 00       	add    $0x803044,%eax
  801c58:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801c5e:	ff 45 f4             	incl   -0xc(%ebp)
  801c61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c64:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c67:	7c a1                	jl     801c0a <free+0x94>
  801c69:	eb 04                	jmp    801c6f <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c6b:	90                   	nop
  801c6c:	eb 01                	jmp    801c6f <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801c6e:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801c6f:	c9                   	leave  
  801c70:	c3                   	ret    

00801c71 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801c71:	55                   	push   %ebp
  801c72:	89 e5                	mov    %esp,%ebp
  801c74:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801c77:	83 ec 04             	sub    $0x4,%esp
  801c7a:	68 38 2c 80 00       	push   $0x802c38
  801c7f:	68 ae 00 00 00       	push   $0xae
  801c84:	68 0f 2c 80 00       	push   $0x802c0f
  801c89:	e8 4f ed ff ff       	call   8009dd <_panic>

00801c8e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
  801c91:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801c94:	83 ec 04             	sub    $0x4,%esp
  801c97:	68 58 2c 80 00       	push   $0x802c58
  801c9c:	68 ca 00 00 00       	push   $0xca
  801ca1:	68 0f 2c 80 00       	push   $0x802c0f
  801ca6:	e8 32 ed ff ff       	call   8009dd <_panic>

00801cab <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	57                   	push   %edi
  801caf:	56                   	push   %esi
  801cb0:	53                   	push   %ebx
  801cb1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cbd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cc0:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cc3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cc6:	cd 30                	int    $0x30
  801cc8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ccb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cce:	83 c4 10             	add    $0x10,%esp
  801cd1:	5b                   	pop    %ebx
  801cd2:	5e                   	pop    %esi
  801cd3:	5f                   	pop    %edi
  801cd4:	5d                   	pop    %ebp
  801cd5:	c3                   	ret    

00801cd6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801cd6:	55                   	push   %ebp
  801cd7:	89 e5                	mov    %esp,%ebp
  801cd9:	83 ec 04             	sub    $0x4,%esp
  801cdc:	8b 45 10             	mov    0x10(%ebp),%eax
  801cdf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ce2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 00                	push   $0x0
  801ced:	52                   	push   %edx
  801cee:	ff 75 0c             	pushl  0xc(%ebp)
  801cf1:	50                   	push   %eax
  801cf2:	6a 00                	push   $0x0
  801cf4:	e8 b2 ff ff ff       	call   801cab <syscall>
  801cf9:	83 c4 18             	add    $0x18,%esp
}
  801cfc:	90                   	nop
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <sys_cgetc>:

int
sys_cgetc(void)
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 01                	push   $0x1
  801d0e:	e8 98 ff ff ff       	call   801cab <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
}
  801d16:	c9                   	leave  
  801d17:	c3                   	ret    

00801d18 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	50                   	push   %eax
  801d27:	6a 05                	push   $0x5
  801d29:	e8 7d ff ff ff       	call   801cab <syscall>
  801d2e:	83 c4 18             	add    $0x18,%esp
}
  801d31:	c9                   	leave  
  801d32:	c3                   	ret    

00801d33 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d33:	55                   	push   %ebp
  801d34:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 02                	push   $0x2
  801d42:	e8 64 ff ff ff       	call   801cab <syscall>
  801d47:	83 c4 18             	add    $0x18,%esp
}
  801d4a:	c9                   	leave  
  801d4b:	c3                   	ret    

00801d4c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d4c:	55                   	push   %ebp
  801d4d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 03                	push   $0x3
  801d5b:	e8 4b ff ff ff       	call   801cab <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    

00801d65 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 04                	push   $0x4
  801d74:	e8 32 ff ff ff       	call   801cab <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
}
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <sys_env_exit>:


void sys_env_exit(void)
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 06                	push   $0x6
  801d8d:	e8 19 ff ff ff       	call   801cab <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	90                   	nop
  801d96:	c9                   	leave  
  801d97:	c3                   	ret    

00801d98 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d98:	55                   	push   %ebp
  801d99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	52                   	push   %edx
  801da8:	50                   	push   %eax
  801da9:	6a 07                	push   $0x7
  801dab:	e8 fb fe ff ff       	call   801cab <syscall>
  801db0:	83 c4 18             	add    $0x18,%esp
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    

00801db5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801db5:	55                   	push   %ebp
  801db6:	89 e5                	mov    %esp,%ebp
  801db8:	56                   	push   %esi
  801db9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801dba:	8b 75 18             	mov    0x18(%ebp),%esi
  801dbd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dc0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc9:	56                   	push   %esi
  801dca:	53                   	push   %ebx
  801dcb:	51                   	push   %ecx
  801dcc:	52                   	push   %edx
  801dcd:	50                   	push   %eax
  801dce:	6a 08                	push   $0x8
  801dd0:	e8 d6 fe ff ff       	call   801cab <syscall>
  801dd5:	83 c4 18             	add    $0x18,%esp
}
  801dd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ddb:	5b                   	pop    %ebx
  801ddc:	5e                   	pop    %esi
  801ddd:	5d                   	pop    %ebp
  801dde:	c3                   	ret    

00801ddf <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801de2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de5:	8b 45 08             	mov    0x8(%ebp),%eax
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	52                   	push   %edx
  801def:	50                   	push   %eax
  801df0:	6a 09                	push   $0x9
  801df2:	e8 b4 fe ff ff       	call   801cab <syscall>
  801df7:	83 c4 18             	add    $0x18,%esp
}
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801dfc:	55                   	push   %ebp
  801dfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	ff 75 0c             	pushl  0xc(%ebp)
  801e08:	ff 75 08             	pushl  0x8(%ebp)
  801e0b:	6a 0a                	push   $0xa
  801e0d:	e8 99 fe ff ff       	call   801cab <syscall>
  801e12:	83 c4 18             	add    $0x18,%esp
}
  801e15:	c9                   	leave  
  801e16:	c3                   	ret    

00801e17 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e17:	55                   	push   %ebp
  801e18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 0b                	push   $0xb
  801e26:	e8 80 fe ff ff       	call   801cab <syscall>
  801e2b:	83 c4 18             	add    $0x18,%esp
}
  801e2e:	c9                   	leave  
  801e2f:	c3                   	ret    

00801e30 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e30:	55                   	push   %ebp
  801e31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 0c                	push   $0xc
  801e3f:	e8 67 fe ff ff       	call   801cab <syscall>
  801e44:	83 c4 18             	add    $0x18,%esp
}
  801e47:	c9                   	leave  
  801e48:	c3                   	ret    

00801e49 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e49:	55                   	push   %ebp
  801e4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 0d                	push   $0xd
  801e58:	e8 4e fe ff ff       	call   801cab <syscall>
  801e5d:	83 c4 18             	add    $0x18,%esp
}
  801e60:	c9                   	leave  
  801e61:	c3                   	ret    

00801e62 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e62:	55                   	push   %ebp
  801e63:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	ff 75 0c             	pushl  0xc(%ebp)
  801e6e:	ff 75 08             	pushl  0x8(%ebp)
  801e71:	6a 11                	push   $0x11
  801e73:	e8 33 fe ff ff       	call   801cab <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
	return;
  801e7b:	90                   	nop
}
  801e7c:	c9                   	leave  
  801e7d:	c3                   	ret    

00801e7e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e7e:	55                   	push   %ebp
  801e7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	ff 75 0c             	pushl  0xc(%ebp)
  801e8a:	ff 75 08             	pushl  0x8(%ebp)
  801e8d:	6a 12                	push   $0x12
  801e8f:	e8 17 fe ff ff       	call   801cab <syscall>
  801e94:	83 c4 18             	add    $0x18,%esp
	return ;
  801e97:	90                   	nop
}
  801e98:	c9                   	leave  
  801e99:	c3                   	ret    

00801e9a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e9a:	55                   	push   %ebp
  801e9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 0e                	push   $0xe
  801ea9:	e8 fd fd ff ff       	call   801cab <syscall>
  801eae:	83 c4 18             	add    $0x18,%esp
}
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	ff 75 08             	pushl  0x8(%ebp)
  801ec1:	6a 0f                	push   $0xf
  801ec3:	e8 e3 fd ff ff       	call   801cab <syscall>
  801ec8:	83 c4 18             	add    $0x18,%esp
}
  801ecb:	c9                   	leave  
  801ecc:	c3                   	ret    

00801ecd <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ecd:	55                   	push   %ebp
  801ece:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 10                	push   $0x10
  801edc:	e8 ca fd ff ff       	call   801cab <syscall>
  801ee1:	83 c4 18             	add    $0x18,%esp
}
  801ee4:	90                   	nop
  801ee5:	c9                   	leave  
  801ee6:	c3                   	ret    

00801ee7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ee7:	55                   	push   %ebp
  801ee8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 14                	push   $0x14
  801ef6:	e8 b0 fd ff ff       	call   801cab <syscall>
  801efb:	83 c4 18             	add    $0x18,%esp
}
  801efe:	90                   	nop
  801eff:	c9                   	leave  
  801f00:	c3                   	ret    

00801f01 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f01:	55                   	push   %ebp
  801f02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 15                	push   $0x15
  801f10:	e8 96 fd ff ff       	call   801cab <syscall>
  801f15:	83 c4 18             	add    $0x18,%esp
}
  801f18:	90                   	nop
  801f19:	c9                   	leave  
  801f1a:	c3                   	ret    

00801f1b <sys_cputc>:


void
sys_cputc(const char c)
{
  801f1b:	55                   	push   %ebp
  801f1c:	89 e5                	mov    %esp,%ebp
  801f1e:	83 ec 04             	sub    $0x4,%esp
  801f21:	8b 45 08             	mov    0x8(%ebp),%eax
  801f24:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f27:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	50                   	push   %eax
  801f34:	6a 16                	push   $0x16
  801f36:	e8 70 fd ff ff       	call   801cab <syscall>
  801f3b:	83 c4 18             	add    $0x18,%esp
}
  801f3e:	90                   	nop
  801f3f:	c9                   	leave  
  801f40:	c3                   	ret    

00801f41 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f41:	55                   	push   %ebp
  801f42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 17                	push   $0x17
  801f50:	e8 56 fd ff ff       	call   801cab <syscall>
  801f55:	83 c4 18             	add    $0x18,%esp
}
  801f58:	90                   	nop
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	ff 75 0c             	pushl  0xc(%ebp)
  801f6a:	50                   	push   %eax
  801f6b:	6a 18                	push   $0x18
  801f6d:	e8 39 fd ff ff       	call   801cab <syscall>
  801f72:	83 c4 18             	add    $0x18,%esp
}
  801f75:	c9                   	leave  
  801f76:	c3                   	ret    

00801f77 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f77:	55                   	push   %ebp
  801f78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	52                   	push   %edx
  801f87:	50                   	push   %eax
  801f88:	6a 1b                	push   $0x1b
  801f8a:	e8 1c fd ff ff       	call   801cab <syscall>
  801f8f:	83 c4 18             	add    $0x18,%esp
}
  801f92:	c9                   	leave  
  801f93:	c3                   	ret    

00801f94 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f94:	55                   	push   %ebp
  801f95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	6a 00                	push   $0x0
  801fa3:	52                   	push   %edx
  801fa4:	50                   	push   %eax
  801fa5:	6a 19                	push   $0x19
  801fa7:	e8 ff fc ff ff       	call   801cab <syscall>
  801fac:	83 c4 18             	add    $0x18,%esp
}
  801faf:	90                   	nop
  801fb0:	c9                   	leave  
  801fb1:	c3                   	ret    

00801fb2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fb2:	55                   	push   %ebp
  801fb3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	52                   	push   %edx
  801fc2:	50                   	push   %eax
  801fc3:	6a 1a                	push   $0x1a
  801fc5:	e8 e1 fc ff ff       	call   801cab <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
}
  801fcd:	90                   	nop
  801fce:	c9                   	leave  
  801fcf:	c3                   	ret    

00801fd0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fd0:	55                   	push   %ebp
  801fd1:	89 e5                	mov    %esp,%ebp
  801fd3:	83 ec 04             	sub    $0x4,%esp
  801fd6:	8b 45 10             	mov    0x10(%ebp),%eax
  801fd9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801fdc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fdf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe6:	6a 00                	push   $0x0
  801fe8:	51                   	push   %ecx
  801fe9:	52                   	push   %edx
  801fea:	ff 75 0c             	pushl  0xc(%ebp)
  801fed:	50                   	push   %eax
  801fee:	6a 1c                	push   $0x1c
  801ff0:	e8 b6 fc ff ff       	call   801cab <syscall>
  801ff5:	83 c4 18             	add    $0x18,%esp
}
  801ff8:	c9                   	leave  
  801ff9:	c3                   	ret    

00801ffa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ffa:	55                   	push   %ebp
  801ffb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ffd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802000:	8b 45 08             	mov    0x8(%ebp),%eax
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	52                   	push   %edx
  80200a:	50                   	push   %eax
  80200b:	6a 1d                	push   $0x1d
  80200d:	e8 99 fc ff ff       	call   801cab <syscall>
  802012:	83 c4 18             	add    $0x18,%esp
}
  802015:	c9                   	leave  
  802016:	c3                   	ret    

00802017 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802017:	55                   	push   %ebp
  802018:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80201a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80201d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802020:	8b 45 08             	mov    0x8(%ebp),%eax
  802023:	6a 00                	push   $0x0
  802025:	6a 00                	push   $0x0
  802027:	51                   	push   %ecx
  802028:	52                   	push   %edx
  802029:	50                   	push   %eax
  80202a:	6a 1e                	push   $0x1e
  80202c:	e8 7a fc ff ff       	call   801cab <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802039:	8b 55 0c             	mov    0xc(%ebp),%edx
  80203c:	8b 45 08             	mov    0x8(%ebp),%eax
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	52                   	push   %edx
  802046:	50                   	push   %eax
  802047:	6a 1f                	push   $0x1f
  802049:	e8 5d fc ff ff       	call   801cab <syscall>
  80204e:	83 c4 18             	add    $0x18,%esp
}
  802051:	c9                   	leave  
  802052:	c3                   	ret    

00802053 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802053:	55                   	push   %ebp
  802054:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 20                	push   $0x20
  802062:	e8 44 fc ff ff       	call   801cab <syscall>
  802067:	83 c4 18             	add    $0x18,%esp
}
  80206a:	c9                   	leave  
  80206b:	c3                   	ret    

0080206c <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80206c:	55                   	push   %ebp
  80206d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80206f:	8b 45 08             	mov    0x8(%ebp),%eax
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	ff 75 10             	pushl  0x10(%ebp)
  802079:	ff 75 0c             	pushl  0xc(%ebp)
  80207c:	50                   	push   %eax
  80207d:	6a 21                	push   $0x21
  80207f:	e8 27 fc ff ff       	call   801cab <syscall>
  802084:	83 c4 18             	add    $0x18,%esp
}
  802087:	c9                   	leave  
  802088:	c3                   	ret    

00802089 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802089:	55                   	push   %ebp
  80208a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80208c:	8b 45 08             	mov    0x8(%ebp),%eax
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	50                   	push   %eax
  802098:	6a 22                	push   $0x22
  80209a:	e8 0c fc ff ff       	call   801cab <syscall>
  80209f:	83 c4 18             	add    $0x18,%esp
}
  8020a2:	90                   	nop
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	50                   	push   %eax
  8020b4:	6a 23                	push   $0x23
  8020b6:	e8 f0 fb ff ff       	call   801cab <syscall>
  8020bb:	83 c4 18             	add    $0x18,%esp
}
  8020be:	90                   	nop
  8020bf:	c9                   	leave  
  8020c0:	c3                   	ret    

008020c1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020c1:	55                   	push   %ebp
  8020c2:	89 e5                	mov    %esp,%ebp
  8020c4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020c7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020ca:	8d 50 04             	lea    0x4(%eax),%edx
  8020cd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	52                   	push   %edx
  8020d7:	50                   	push   %eax
  8020d8:	6a 24                	push   $0x24
  8020da:	e8 cc fb ff ff       	call   801cab <syscall>
  8020df:	83 c4 18             	add    $0x18,%esp
	return result;
  8020e2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020eb:	89 01                	mov    %eax,(%ecx)
  8020ed:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f3:	c9                   	leave  
  8020f4:	c2 04 00             	ret    $0x4

008020f7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020f7:	55                   	push   %ebp
  8020f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	ff 75 10             	pushl  0x10(%ebp)
  802101:	ff 75 0c             	pushl  0xc(%ebp)
  802104:	ff 75 08             	pushl  0x8(%ebp)
  802107:	6a 13                	push   $0x13
  802109:	e8 9d fb ff ff       	call   801cab <syscall>
  80210e:	83 c4 18             	add    $0x18,%esp
	return ;
  802111:	90                   	nop
}
  802112:	c9                   	leave  
  802113:	c3                   	ret    

00802114 <sys_rcr2>:
uint32 sys_rcr2()
{
  802114:	55                   	push   %ebp
  802115:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 00                	push   $0x0
  80211d:	6a 00                	push   $0x0
  80211f:	6a 00                	push   $0x0
  802121:	6a 25                	push   $0x25
  802123:	e8 83 fb ff ff       	call   801cab <syscall>
  802128:	83 c4 18             	add    $0x18,%esp
}
  80212b:	c9                   	leave  
  80212c:	c3                   	ret    

0080212d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80212d:	55                   	push   %ebp
  80212e:	89 e5                	mov    %esp,%ebp
  802130:	83 ec 04             	sub    $0x4,%esp
  802133:	8b 45 08             	mov    0x8(%ebp),%eax
  802136:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802139:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	50                   	push   %eax
  802146:	6a 26                	push   $0x26
  802148:	e8 5e fb ff ff       	call   801cab <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
	return ;
  802150:	90                   	nop
}
  802151:	c9                   	leave  
  802152:	c3                   	ret    

00802153 <rsttst>:
void rsttst()
{
  802153:	55                   	push   %ebp
  802154:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 28                	push   $0x28
  802162:	e8 44 fb ff ff       	call   801cab <syscall>
  802167:	83 c4 18             	add    $0x18,%esp
	return ;
  80216a:	90                   	nop
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
  802170:	83 ec 04             	sub    $0x4,%esp
  802173:	8b 45 14             	mov    0x14(%ebp),%eax
  802176:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802179:	8b 55 18             	mov    0x18(%ebp),%edx
  80217c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802180:	52                   	push   %edx
  802181:	50                   	push   %eax
  802182:	ff 75 10             	pushl  0x10(%ebp)
  802185:	ff 75 0c             	pushl  0xc(%ebp)
  802188:	ff 75 08             	pushl  0x8(%ebp)
  80218b:	6a 27                	push   $0x27
  80218d:	e8 19 fb ff ff       	call   801cab <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
	return ;
  802195:	90                   	nop
}
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <chktst>:
void chktst(uint32 n)
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	ff 75 08             	pushl  0x8(%ebp)
  8021a6:	6a 29                	push   $0x29
  8021a8:	e8 fe fa ff ff       	call   801cab <syscall>
  8021ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8021b0:	90                   	nop
}
  8021b1:	c9                   	leave  
  8021b2:	c3                   	ret    

008021b3 <inctst>:

void inctst()
{
  8021b3:	55                   	push   %ebp
  8021b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 00                	push   $0x0
  8021be:	6a 00                	push   $0x0
  8021c0:	6a 2a                	push   $0x2a
  8021c2:	e8 e4 fa ff ff       	call   801cab <syscall>
  8021c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ca:	90                   	nop
}
  8021cb:	c9                   	leave  
  8021cc:	c3                   	ret    

008021cd <gettst>:
uint32 gettst()
{
  8021cd:	55                   	push   %ebp
  8021ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 2b                	push   $0x2b
  8021dc:	e8 ca fa ff ff       	call   801cab <syscall>
  8021e1:	83 c4 18             	add    $0x18,%esp
}
  8021e4:	c9                   	leave  
  8021e5:	c3                   	ret    

008021e6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021e6:	55                   	push   %ebp
  8021e7:	89 e5                	mov    %esp,%ebp
  8021e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ec:	6a 00                	push   $0x0
  8021ee:	6a 00                	push   $0x0
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 2c                	push   $0x2c
  8021f8:	e8 ae fa ff ff       	call   801cab <syscall>
  8021fd:	83 c4 18             	add    $0x18,%esp
  802200:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802203:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802207:	75 07                	jne    802210 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802209:	b8 01 00 00 00       	mov    $0x1,%eax
  80220e:	eb 05                	jmp    802215 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802210:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802215:	c9                   	leave  
  802216:	c3                   	ret    

00802217 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802217:	55                   	push   %ebp
  802218:	89 e5                	mov    %esp,%ebp
  80221a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 2c                	push   $0x2c
  802229:	e8 7d fa ff ff       	call   801cab <syscall>
  80222e:	83 c4 18             	add    $0x18,%esp
  802231:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802234:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802238:	75 07                	jne    802241 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80223a:	b8 01 00 00 00       	mov    $0x1,%eax
  80223f:	eb 05                	jmp    802246 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802241:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802246:	c9                   	leave  
  802247:	c3                   	ret    

00802248 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802248:	55                   	push   %ebp
  802249:	89 e5                	mov    %esp,%ebp
  80224b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 2c                	push   $0x2c
  80225a:	e8 4c fa ff ff       	call   801cab <syscall>
  80225f:	83 c4 18             	add    $0x18,%esp
  802262:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802265:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802269:	75 07                	jne    802272 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80226b:	b8 01 00 00 00       	mov    $0x1,%eax
  802270:	eb 05                	jmp    802277 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802272:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802277:	c9                   	leave  
  802278:	c3                   	ret    

00802279 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802279:	55                   	push   %ebp
  80227a:	89 e5                	mov    %esp,%ebp
  80227c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	6a 00                	push   $0x0
  802289:	6a 2c                	push   $0x2c
  80228b:	e8 1b fa ff ff       	call   801cab <syscall>
  802290:	83 c4 18             	add    $0x18,%esp
  802293:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802296:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80229a:	75 07                	jne    8022a3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80229c:	b8 01 00 00 00       	mov    $0x1,%eax
  8022a1:	eb 05                	jmp    8022a8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	ff 75 08             	pushl  0x8(%ebp)
  8022b8:	6a 2d                	push   $0x2d
  8022ba:	e8 ec f9 ff ff       	call   801cab <syscall>
  8022bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c2:	90                   	nop
}
  8022c3:	c9                   	leave  
  8022c4:	c3                   	ret    
  8022c5:	66 90                	xchg   %ax,%ax
  8022c7:	90                   	nop

008022c8 <__udivdi3>:
  8022c8:	55                   	push   %ebp
  8022c9:	57                   	push   %edi
  8022ca:	56                   	push   %esi
  8022cb:	53                   	push   %ebx
  8022cc:	83 ec 1c             	sub    $0x1c,%esp
  8022cf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022d3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022db:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022df:	89 ca                	mov    %ecx,%edx
  8022e1:	89 f8                	mov    %edi,%eax
  8022e3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022e7:	85 f6                	test   %esi,%esi
  8022e9:	75 2d                	jne    802318 <__udivdi3+0x50>
  8022eb:	39 cf                	cmp    %ecx,%edi
  8022ed:	77 65                	ja     802354 <__udivdi3+0x8c>
  8022ef:	89 fd                	mov    %edi,%ebp
  8022f1:	85 ff                	test   %edi,%edi
  8022f3:	75 0b                	jne    802300 <__udivdi3+0x38>
  8022f5:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fa:	31 d2                	xor    %edx,%edx
  8022fc:	f7 f7                	div    %edi
  8022fe:	89 c5                	mov    %eax,%ebp
  802300:	31 d2                	xor    %edx,%edx
  802302:	89 c8                	mov    %ecx,%eax
  802304:	f7 f5                	div    %ebp
  802306:	89 c1                	mov    %eax,%ecx
  802308:	89 d8                	mov    %ebx,%eax
  80230a:	f7 f5                	div    %ebp
  80230c:	89 cf                	mov    %ecx,%edi
  80230e:	89 fa                	mov    %edi,%edx
  802310:	83 c4 1c             	add    $0x1c,%esp
  802313:	5b                   	pop    %ebx
  802314:	5e                   	pop    %esi
  802315:	5f                   	pop    %edi
  802316:	5d                   	pop    %ebp
  802317:	c3                   	ret    
  802318:	39 ce                	cmp    %ecx,%esi
  80231a:	77 28                	ja     802344 <__udivdi3+0x7c>
  80231c:	0f bd fe             	bsr    %esi,%edi
  80231f:	83 f7 1f             	xor    $0x1f,%edi
  802322:	75 40                	jne    802364 <__udivdi3+0x9c>
  802324:	39 ce                	cmp    %ecx,%esi
  802326:	72 0a                	jb     802332 <__udivdi3+0x6a>
  802328:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80232c:	0f 87 9e 00 00 00    	ja     8023d0 <__udivdi3+0x108>
  802332:	b8 01 00 00 00       	mov    $0x1,%eax
  802337:	89 fa                	mov    %edi,%edx
  802339:	83 c4 1c             	add    $0x1c,%esp
  80233c:	5b                   	pop    %ebx
  80233d:	5e                   	pop    %esi
  80233e:	5f                   	pop    %edi
  80233f:	5d                   	pop    %ebp
  802340:	c3                   	ret    
  802341:	8d 76 00             	lea    0x0(%esi),%esi
  802344:	31 ff                	xor    %edi,%edi
  802346:	31 c0                	xor    %eax,%eax
  802348:	89 fa                	mov    %edi,%edx
  80234a:	83 c4 1c             	add    $0x1c,%esp
  80234d:	5b                   	pop    %ebx
  80234e:	5e                   	pop    %esi
  80234f:	5f                   	pop    %edi
  802350:	5d                   	pop    %ebp
  802351:	c3                   	ret    
  802352:	66 90                	xchg   %ax,%ax
  802354:	89 d8                	mov    %ebx,%eax
  802356:	f7 f7                	div    %edi
  802358:	31 ff                	xor    %edi,%edi
  80235a:	89 fa                	mov    %edi,%edx
  80235c:	83 c4 1c             	add    $0x1c,%esp
  80235f:	5b                   	pop    %ebx
  802360:	5e                   	pop    %esi
  802361:	5f                   	pop    %edi
  802362:	5d                   	pop    %ebp
  802363:	c3                   	ret    
  802364:	bd 20 00 00 00       	mov    $0x20,%ebp
  802369:	89 eb                	mov    %ebp,%ebx
  80236b:	29 fb                	sub    %edi,%ebx
  80236d:	89 f9                	mov    %edi,%ecx
  80236f:	d3 e6                	shl    %cl,%esi
  802371:	89 c5                	mov    %eax,%ebp
  802373:	88 d9                	mov    %bl,%cl
  802375:	d3 ed                	shr    %cl,%ebp
  802377:	89 e9                	mov    %ebp,%ecx
  802379:	09 f1                	or     %esi,%ecx
  80237b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80237f:	89 f9                	mov    %edi,%ecx
  802381:	d3 e0                	shl    %cl,%eax
  802383:	89 c5                	mov    %eax,%ebp
  802385:	89 d6                	mov    %edx,%esi
  802387:	88 d9                	mov    %bl,%cl
  802389:	d3 ee                	shr    %cl,%esi
  80238b:	89 f9                	mov    %edi,%ecx
  80238d:	d3 e2                	shl    %cl,%edx
  80238f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802393:	88 d9                	mov    %bl,%cl
  802395:	d3 e8                	shr    %cl,%eax
  802397:	09 c2                	or     %eax,%edx
  802399:	89 d0                	mov    %edx,%eax
  80239b:	89 f2                	mov    %esi,%edx
  80239d:	f7 74 24 0c          	divl   0xc(%esp)
  8023a1:	89 d6                	mov    %edx,%esi
  8023a3:	89 c3                	mov    %eax,%ebx
  8023a5:	f7 e5                	mul    %ebp
  8023a7:	39 d6                	cmp    %edx,%esi
  8023a9:	72 19                	jb     8023c4 <__udivdi3+0xfc>
  8023ab:	74 0b                	je     8023b8 <__udivdi3+0xf0>
  8023ad:	89 d8                	mov    %ebx,%eax
  8023af:	31 ff                	xor    %edi,%edi
  8023b1:	e9 58 ff ff ff       	jmp    80230e <__udivdi3+0x46>
  8023b6:	66 90                	xchg   %ax,%ax
  8023b8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8023bc:	89 f9                	mov    %edi,%ecx
  8023be:	d3 e2                	shl    %cl,%edx
  8023c0:	39 c2                	cmp    %eax,%edx
  8023c2:	73 e9                	jae    8023ad <__udivdi3+0xe5>
  8023c4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8023c7:	31 ff                	xor    %edi,%edi
  8023c9:	e9 40 ff ff ff       	jmp    80230e <__udivdi3+0x46>
  8023ce:	66 90                	xchg   %ax,%ax
  8023d0:	31 c0                	xor    %eax,%eax
  8023d2:	e9 37 ff ff ff       	jmp    80230e <__udivdi3+0x46>
  8023d7:	90                   	nop

008023d8 <__umoddi3>:
  8023d8:	55                   	push   %ebp
  8023d9:	57                   	push   %edi
  8023da:	56                   	push   %esi
  8023db:	53                   	push   %ebx
  8023dc:	83 ec 1c             	sub    $0x1c,%esp
  8023df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023e3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023eb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023f3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023f7:	89 f3                	mov    %esi,%ebx
  8023f9:	89 fa                	mov    %edi,%edx
  8023fb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ff:	89 34 24             	mov    %esi,(%esp)
  802402:	85 c0                	test   %eax,%eax
  802404:	75 1a                	jne    802420 <__umoddi3+0x48>
  802406:	39 f7                	cmp    %esi,%edi
  802408:	0f 86 a2 00 00 00    	jbe    8024b0 <__umoddi3+0xd8>
  80240e:	89 c8                	mov    %ecx,%eax
  802410:	89 f2                	mov    %esi,%edx
  802412:	f7 f7                	div    %edi
  802414:	89 d0                	mov    %edx,%eax
  802416:	31 d2                	xor    %edx,%edx
  802418:	83 c4 1c             	add    $0x1c,%esp
  80241b:	5b                   	pop    %ebx
  80241c:	5e                   	pop    %esi
  80241d:	5f                   	pop    %edi
  80241e:	5d                   	pop    %ebp
  80241f:	c3                   	ret    
  802420:	39 f0                	cmp    %esi,%eax
  802422:	0f 87 ac 00 00 00    	ja     8024d4 <__umoddi3+0xfc>
  802428:	0f bd e8             	bsr    %eax,%ebp
  80242b:	83 f5 1f             	xor    $0x1f,%ebp
  80242e:	0f 84 ac 00 00 00    	je     8024e0 <__umoddi3+0x108>
  802434:	bf 20 00 00 00       	mov    $0x20,%edi
  802439:	29 ef                	sub    %ebp,%edi
  80243b:	89 fe                	mov    %edi,%esi
  80243d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802441:	89 e9                	mov    %ebp,%ecx
  802443:	d3 e0                	shl    %cl,%eax
  802445:	89 d7                	mov    %edx,%edi
  802447:	89 f1                	mov    %esi,%ecx
  802449:	d3 ef                	shr    %cl,%edi
  80244b:	09 c7                	or     %eax,%edi
  80244d:	89 e9                	mov    %ebp,%ecx
  80244f:	d3 e2                	shl    %cl,%edx
  802451:	89 14 24             	mov    %edx,(%esp)
  802454:	89 d8                	mov    %ebx,%eax
  802456:	d3 e0                	shl    %cl,%eax
  802458:	89 c2                	mov    %eax,%edx
  80245a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80245e:	d3 e0                	shl    %cl,%eax
  802460:	89 44 24 04          	mov    %eax,0x4(%esp)
  802464:	8b 44 24 08          	mov    0x8(%esp),%eax
  802468:	89 f1                	mov    %esi,%ecx
  80246a:	d3 e8                	shr    %cl,%eax
  80246c:	09 d0                	or     %edx,%eax
  80246e:	d3 eb                	shr    %cl,%ebx
  802470:	89 da                	mov    %ebx,%edx
  802472:	f7 f7                	div    %edi
  802474:	89 d3                	mov    %edx,%ebx
  802476:	f7 24 24             	mull   (%esp)
  802479:	89 c6                	mov    %eax,%esi
  80247b:	89 d1                	mov    %edx,%ecx
  80247d:	39 d3                	cmp    %edx,%ebx
  80247f:	0f 82 87 00 00 00    	jb     80250c <__umoddi3+0x134>
  802485:	0f 84 91 00 00 00    	je     80251c <__umoddi3+0x144>
  80248b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80248f:	29 f2                	sub    %esi,%edx
  802491:	19 cb                	sbb    %ecx,%ebx
  802493:	89 d8                	mov    %ebx,%eax
  802495:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802499:	d3 e0                	shl    %cl,%eax
  80249b:	89 e9                	mov    %ebp,%ecx
  80249d:	d3 ea                	shr    %cl,%edx
  80249f:	09 d0                	or     %edx,%eax
  8024a1:	89 e9                	mov    %ebp,%ecx
  8024a3:	d3 eb                	shr    %cl,%ebx
  8024a5:	89 da                	mov    %ebx,%edx
  8024a7:	83 c4 1c             	add    $0x1c,%esp
  8024aa:	5b                   	pop    %ebx
  8024ab:	5e                   	pop    %esi
  8024ac:	5f                   	pop    %edi
  8024ad:	5d                   	pop    %ebp
  8024ae:	c3                   	ret    
  8024af:	90                   	nop
  8024b0:	89 fd                	mov    %edi,%ebp
  8024b2:	85 ff                	test   %edi,%edi
  8024b4:	75 0b                	jne    8024c1 <__umoddi3+0xe9>
  8024b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8024bb:	31 d2                	xor    %edx,%edx
  8024bd:	f7 f7                	div    %edi
  8024bf:	89 c5                	mov    %eax,%ebp
  8024c1:	89 f0                	mov    %esi,%eax
  8024c3:	31 d2                	xor    %edx,%edx
  8024c5:	f7 f5                	div    %ebp
  8024c7:	89 c8                	mov    %ecx,%eax
  8024c9:	f7 f5                	div    %ebp
  8024cb:	89 d0                	mov    %edx,%eax
  8024cd:	e9 44 ff ff ff       	jmp    802416 <__umoddi3+0x3e>
  8024d2:	66 90                	xchg   %ax,%ax
  8024d4:	89 c8                	mov    %ecx,%eax
  8024d6:	89 f2                	mov    %esi,%edx
  8024d8:	83 c4 1c             	add    $0x1c,%esp
  8024db:	5b                   	pop    %ebx
  8024dc:	5e                   	pop    %esi
  8024dd:	5f                   	pop    %edi
  8024de:	5d                   	pop    %ebp
  8024df:	c3                   	ret    
  8024e0:	3b 04 24             	cmp    (%esp),%eax
  8024e3:	72 06                	jb     8024eb <__umoddi3+0x113>
  8024e5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024e9:	77 0f                	ja     8024fa <__umoddi3+0x122>
  8024eb:	89 f2                	mov    %esi,%edx
  8024ed:	29 f9                	sub    %edi,%ecx
  8024ef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024f3:	89 14 24             	mov    %edx,(%esp)
  8024f6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024fa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024fe:	8b 14 24             	mov    (%esp),%edx
  802501:	83 c4 1c             	add    $0x1c,%esp
  802504:	5b                   	pop    %ebx
  802505:	5e                   	pop    %esi
  802506:	5f                   	pop    %edi
  802507:	5d                   	pop    %ebp
  802508:	c3                   	ret    
  802509:	8d 76 00             	lea    0x0(%esi),%esi
  80250c:	2b 04 24             	sub    (%esp),%eax
  80250f:	19 fa                	sbb    %edi,%edx
  802511:	89 d1                	mov    %edx,%ecx
  802513:	89 c6                	mov    %eax,%esi
  802515:	e9 71 ff ff ff       	jmp    80248b <__umoddi3+0xb3>
  80251a:	66 90                	xchg   %ax,%ax
  80251c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802520:	72 ea                	jb     80250c <__umoddi3+0x134>
  802522:	89 d9                	mov    %ebx,%ecx
  802524:	e9 62 ff ff ff       	jmp    80248b <__umoddi3+0xb3>
