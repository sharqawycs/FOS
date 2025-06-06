
obj/user/tst_free_2:     file format elf32-i386


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
  800031:	e8 b0 09 00 00       	call   8009e6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 1000 */
/* *********************************************************** */
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	81 ec d4 00 00 00    	sub    $0xd4,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800042:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800046:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004d:	eb 29                	jmp    800078 <_main+0x40>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004f:	a1 20 30 80 00       	mov    0x803020,%eax
  800054:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80005a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005d:	89 d0                	mov    %edx,%eax
  80005f:	01 c0                	add    %eax,%eax
  800061:	01 d0                	add    %edx,%eax
  800063:	c1 e0 02             	shl    $0x2,%eax
  800066:	01 c8                	add    %ecx,%eax
  800068:	8a 40 04             	mov    0x4(%eax),%al
  80006b:	84 c0                	test   %al,%al
  80006d:	74 06                	je     800075 <_main+0x3d>
			{
				fullWS = 0;
  80006f:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800073:	eb 12                	jmp    800087 <_main+0x4f>
{

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800075:	ff 45 f0             	incl   -0x10(%ebp)
  800078:	a1 20 30 80 00       	mov    0x803020,%eax
  80007d:	8b 50 74             	mov    0x74(%eax),%edx
  800080:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800083:	39 c2                	cmp    %eax,%edx
  800085:	77 c8                	ja     80004f <_main+0x17>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800087:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008b:	74 14                	je     8000a1 <_main+0x69>
  80008d:	83 ec 04             	sub    $0x4,%esp
  800090:	68 40 26 80 00       	push   $0x802640
  800095:	6a 14                	push   $0x14
  800097:	68 5c 26 80 00       	push   $0x80265c
  80009c:	e8 47 0a 00 00       	call   800ae8 <_panic>
	}

	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);
  8000a1:	83 ec 0c             	sub    $0xc,%esp
  8000a4:	6a 03                	push   $0x3
  8000a6:	e8 8d 21 00 00       	call   802238 <sys_bypassPageFault>
  8000ab:	83 c4 10             	add    $0x10,%esp





	int Mega = 1024*1024;
  8000ae:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b5:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)

	int start_freeFrames = sys_calculate_free_frames() ;
  8000bc:	e8 61 1e 00 00       	call   801f22 <sys_calculate_free_frames>
  8000c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//ALLOCATE ALL
	void* ptr_allocations[20] = {0};
  8000c4:	8d 55 80             	lea    -0x80(%ebp),%edx
  8000c7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000d1:	89 d7                	mov    %edx,%edi
  8000d3:	f3 ab                	rep stos %eax,%es:(%edi)
	int lastIndices[20] = {0};
  8000d5:	8d 95 30 ff ff ff    	lea    -0xd0(%ebp),%edx
  8000db:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000e0:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e5:	89 d7                	mov    %edx,%edi
  8000e7:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  8000e9:	e8 34 1e 00 00       	call   801f22 <sys_calculate_free_frames>
  8000ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000f1:	e8 af 1e 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8000f6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000fc:	01 c0                	add    %eax,%eax
  8000fe:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800101:	83 ec 0c             	sub    $0xc,%esp
  800104:	50                   	push   %eax
  800105:	e8 56 1a 00 00       	call   801b60 <malloc>
  80010a:	83 c4 10             	add    $0x10,%esp
  80010d:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800110:	8b 45 80             	mov    -0x80(%ebp),%eax
  800113:	85 c0                	test   %eax,%eax
  800115:	78 14                	js     80012b <_main+0xf3>
  800117:	83 ec 04             	sub    $0x4,%esp
  80011a:	68 70 26 80 00       	push   $0x802670
  80011f:	6a 2b                	push   $0x2b
  800121:	68 5c 26 80 00       	push   $0x80265c
  800126:	e8 bd 09 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80012b:	e8 75 1e 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800130:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800133:	3d 00 02 00 00       	cmp    $0x200,%eax
  800138:	74 14                	je     80014e <_main+0x116>
  80013a:	83 ec 04             	sub    $0x4,%esp
  80013d:	68 d8 26 80 00       	push   $0x8026d8
  800142:	6a 2c                	push   $0x2c
  800144:	68 5c 26 80 00       	push   $0x80265c
  800149:	e8 9a 09 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;
  80014e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800151:	01 c0                	add    %eax,%eax
  800153:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800156:	48                   	dec    %eax
  800157:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  80015d:	e8 c0 1d 00 00       	call   801f22 <sys_calculate_free_frames>
  800162:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800165:	e8 3b 1e 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80016a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  80016d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800170:	01 c0                	add    %eax,%eax
  800172:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	50                   	push   %eax
  800179:	e8 e2 19 00 00       	call   801b60 <malloc>
  80017e:	83 c4 10             	add    $0x10,%esp
  800181:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800184:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800187:	89 c2                	mov    %eax,%edx
  800189:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018c:	01 c0                	add    %eax,%eax
  80018e:	05 00 00 00 80       	add    $0x80000000,%eax
  800193:	39 c2                	cmp    %eax,%edx
  800195:	73 14                	jae    8001ab <_main+0x173>
  800197:	83 ec 04             	sub    $0x4,%esp
  80019a:	68 70 26 80 00       	push   $0x802670
  80019f:	6a 33                	push   $0x33
  8001a1:	68 5c 26 80 00       	push   $0x80265c
  8001a6:	e8 3d 09 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8001ab:	e8 f5 1d 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8001b0:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8001b3:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001b8:	74 14                	je     8001ce <_main+0x196>
  8001ba:	83 ec 04             	sub    $0x4,%esp
  8001bd:	68 d8 26 80 00       	push   $0x8026d8
  8001c2:	6a 34                	push   $0x34
  8001c4:	68 5c 26 80 00       	push   $0x80265c
  8001c9:	e8 1a 09 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;
  8001ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001d1:	01 c0                	add    %eax,%eax
  8001d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001d6:	48                   	dec    %eax
  8001d7:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8001dd:	e8 40 1d 00 00       	call   801f22 <sys_calculate_free_frames>
  8001e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001e5:	e8 bb 1d 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8001ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  8001ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001f0:	01 c0                	add    %eax,%eax
  8001f2:	83 ec 0c             	sub    $0xc,%esp
  8001f5:	50                   	push   %eax
  8001f6:	e8 65 19 00 00       	call   801b60 <malloc>
  8001fb:	83 c4 10             	add    $0x10,%esp
  8001fe:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800201:	8b 45 88             	mov    -0x78(%ebp),%eax
  800204:	89 c2                	mov    %eax,%edx
  800206:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800209:	c1 e0 02             	shl    $0x2,%eax
  80020c:	05 00 00 00 80       	add    $0x80000000,%eax
  800211:	39 c2                	cmp    %eax,%edx
  800213:	73 14                	jae    800229 <_main+0x1f1>
  800215:	83 ec 04             	sub    $0x4,%esp
  800218:	68 70 26 80 00       	push   $0x802670
  80021d:	6a 3b                	push   $0x3b
  80021f:	68 5c 26 80 00       	push   $0x80265c
  800224:	e8 bf 08 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800229:	e8 77 1d 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80022e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800231:	83 f8 01             	cmp    $0x1,%eax
  800234:	74 14                	je     80024a <_main+0x212>
  800236:	83 ec 04             	sub    $0x4,%esp
  800239:	68 d8 26 80 00       	push   $0x8026d8
  80023e:	6a 3c                	push   $0x3c
  800240:	68 5c 26 80 00       	push   $0x80265c
  800245:	e8 9e 08 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1+1 ) panic("Wrong allocation: ");
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;
  80024a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80024d:	01 c0                	add    %eax,%eax
  80024f:	48                   	dec    %eax
  800250:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  800256:	e8 c7 1c 00 00       	call   801f22 <sys_calculate_free_frames>
  80025b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80025e:	e8 42 1d 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800263:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800266:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800269:	01 c0                	add    %eax,%eax
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	50                   	push   %eax
  80026f:	e8 ec 18 00 00       	call   801b60 <malloc>
  800274:	83 c4 10             	add    $0x10,%esp
  800277:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80027a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80027d:	89 c2                	mov    %eax,%edx
  80027f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800282:	c1 e0 02             	shl    $0x2,%eax
  800285:	89 c1                	mov    %eax,%ecx
  800287:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80028a:	c1 e0 02             	shl    $0x2,%eax
  80028d:	01 c8                	add    %ecx,%eax
  80028f:	05 00 00 00 80       	add    $0x80000000,%eax
  800294:	39 c2                	cmp    %eax,%edx
  800296:	73 14                	jae    8002ac <_main+0x274>
  800298:	83 ec 04             	sub    $0x4,%esp
  80029b:	68 70 26 80 00       	push   $0x802670
  8002a0:	6a 43                	push   $0x43
  8002a2:	68 5c 26 80 00       	push   $0x80265c
  8002a7:	e8 3c 08 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  8002ac:	e8 f4 1c 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8002b1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002b4:	83 f8 01             	cmp    $0x1,%eax
  8002b7:	74 14                	je     8002cd <_main+0x295>
  8002b9:	83 ec 04             	sub    $0x4,%esp
  8002bc:	68 d8 26 80 00       	push   $0x8026d8
  8002c1:	6a 44                	push   $0x44
  8002c3:	68 5c 26 80 00       	push   $0x80265c
  8002c8:	e8 1b 08 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;
  8002cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d0:	01 c0                	add    %eax,%eax
  8002d2:	48                   	dec    %eax
  8002d3:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  8002d9:	e8 44 1c 00 00       	call   801f22 <sys_calculate_free_frames>
  8002de:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002e1:	e8 bf 1c 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8002e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  8002e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002ec:	89 d0                	mov    %edx,%eax
  8002ee:	01 c0                	add    %eax,%eax
  8002f0:	01 d0                	add    %edx,%eax
  8002f2:	01 c0                	add    %eax,%eax
  8002f4:	01 d0                	add    %edx,%eax
  8002f6:	83 ec 0c             	sub    $0xc,%esp
  8002f9:	50                   	push   %eax
  8002fa:	e8 61 18 00 00       	call   801b60 <malloc>
  8002ff:	83 c4 10             	add    $0x10,%esp
  800302:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800305:	8b 45 90             	mov    -0x70(%ebp),%eax
  800308:	89 c2                	mov    %eax,%edx
  80030a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80030d:	c1 e0 02             	shl    $0x2,%eax
  800310:	89 c1                	mov    %eax,%ecx
  800312:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800315:	c1 e0 03             	shl    $0x3,%eax
  800318:	01 c8                	add    %ecx,%eax
  80031a:	05 00 00 00 80       	add    $0x80000000,%eax
  80031f:	39 c2                	cmp    %eax,%edx
  800321:	73 14                	jae    800337 <_main+0x2ff>
  800323:	83 ec 04             	sub    $0x4,%esp
  800326:	68 70 26 80 00       	push   $0x802670
  80032b:	6a 4b                	push   $0x4b
  80032d:	68 5c 26 80 00       	push   $0x80265c
  800332:	e8 b1 07 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800337:	e8 69 1c 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80033c:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80033f:	83 f8 02             	cmp    $0x2,%eax
  800342:	74 14                	je     800358 <_main+0x320>
  800344:	83 ec 04             	sub    $0x4,%esp
  800347:	68 d8 26 80 00       	push   $0x8026d8
  80034c:	6a 4c                	push   $0x4c
  80034e:	68 5c 26 80 00       	push   $0x80265c
  800353:	e8 90 07 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 2)panic("Wrong allocation: ");
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;
  800358:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80035b:	89 d0                	mov    %edx,%eax
  80035d:	01 c0                	add    %eax,%eax
  80035f:	01 d0                	add    %edx,%eax
  800361:	01 c0                	add    %eax,%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	48                   	dec    %eax
  800366:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  80036c:	e8 b1 1b 00 00       	call   801f22 <sys_calculate_free_frames>
  800371:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800374:	e8 2c 1c 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800379:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  80037c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	01 d2                	add    %edx,%edx
  800383:	01 d0                	add    %edx,%eax
  800385:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800388:	83 ec 0c             	sub    $0xc,%esp
  80038b:	50                   	push   %eax
  80038c:	e8 cf 17 00 00       	call   801b60 <malloc>
  800391:	83 c4 10             	add    $0x10,%esp
  800394:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800397:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80039a:	89 c2                	mov    %eax,%edx
  80039c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80039f:	c1 e0 02             	shl    $0x2,%eax
  8003a2:	89 c1                	mov    %eax,%ecx
  8003a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a7:	c1 e0 04             	shl    $0x4,%eax
  8003aa:	01 c8                	add    %ecx,%eax
  8003ac:	05 00 00 00 80       	add    $0x80000000,%eax
  8003b1:	39 c2                	cmp    %eax,%edx
  8003b3:	73 14                	jae    8003c9 <_main+0x391>
  8003b5:	83 ec 04             	sub    $0x4,%esp
  8003b8:	68 70 26 80 00       	push   $0x802670
  8003bd:	6a 53                	push   $0x53
  8003bf:	68 5c 26 80 00       	push   $0x80265c
  8003c4:	e8 1f 07 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8003c9:	e8 d7 1b 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8003ce:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003d1:	89 c2                	mov    %eax,%edx
  8003d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d6:	89 c1                	mov    %eax,%ecx
  8003d8:	01 c9                	add    %ecx,%ecx
  8003da:	01 c8                	add    %ecx,%eax
  8003dc:	85 c0                	test   %eax,%eax
  8003de:	79 05                	jns    8003e5 <_main+0x3ad>
  8003e0:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003e5:	c1 f8 0c             	sar    $0xc,%eax
  8003e8:	39 c2                	cmp    %eax,%edx
  8003ea:	74 14                	je     800400 <_main+0x3c8>
  8003ec:	83 ec 04             	sub    $0x4,%esp
  8003ef:	68 d8 26 80 00       	push   $0x8026d8
  8003f4:	6a 54                	push   $0x54
  8003f6:	68 5c 26 80 00       	push   $0x80265c
  8003fb:	e8 e8 06 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 3*Mega/4096 ) panic("Wrong allocation: ");
		lastIndices[5] = (3*Mega - kilo)/sizeof(char) - 1;
  800400:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800403:	89 c2                	mov    %eax,%edx
  800405:	01 d2                	add    %edx,%edx
  800407:	01 d0                	add    %edx,%eax
  800409:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80040c:	48                   	dec    %eax
  80040d:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)

		freeFrames = sys_calculate_free_frames() ;
  800413:	e8 0a 1b 00 00       	call   801f22 <sys_calculate_free_frames>
  800418:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80041b:	e8 85 1b 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800420:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  800423:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800426:	01 c0                	add    %eax,%eax
  800428:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	50                   	push   %eax
  80042f:	e8 2c 17 00 00       	call   801b60 <malloc>
  800434:	83 c4 10             	add    $0x10,%esp
  800437:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80043a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80043d:	89 c1                	mov    %eax,%ecx
  80043f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800442:	89 d0                	mov    %edx,%eax
  800444:	01 c0                	add    %eax,%eax
  800446:	01 d0                	add    %edx,%eax
  800448:	01 c0                	add    %eax,%eax
  80044a:	01 d0                	add    %edx,%eax
  80044c:	89 c2                	mov    %eax,%edx
  80044e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800451:	c1 e0 04             	shl    $0x4,%eax
  800454:	01 d0                	add    %edx,%eax
  800456:	05 00 00 00 80       	add    $0x80000000,%eax
  80045b:	39 c1                	cmp    %eax,%ecx
  80045d:	73 14                	jae    800473 <_main+0x43b>
  80045f:	83 ec 04             	sub    $0x4,%esp
  800462:	68 70 26 80 00       	push   $0x802670
  800467:	6a 5b                	push   $0x5b
  800469:	68 5c 26 80 00       	push   $0x80265c
  80046e:	e8 75 06 00 00       	call   800ae8 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800473:	e8 2d 1b 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800478:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80047b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800480:	74 14                	je     800496 <_main+0x45e>
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 d8 26 80 00       	push   $0x8026d8
  80048a:	6a 5c                	push   $0x5c
  80048c:	68 5c 26 80 00       	push   $0x80265c
  800491:	e8 52 06 00 00       	call   800ae8 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+1 ) panic("Wrong allocation: ");
		lastIndices[6] = (2*Mega - kilo)/sizeof(char) - 1;
  800496:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800499:	01 c0                	add    %eax,%eax
  80049b:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80049e:	48                   	dec    %eax
  80049f:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
	char x ;
	int y;
	char *byteArr ;
	//FREE ALL
	{
		int freeFrames = sys_calculate_free_frames() ;
  8004a5:	e8 78 1a 00 00       	call   801f22 <sys_calculate_free_frames>
  8004aa:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004ad:	e8 f3 1a 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8004b2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[0]);
  8004b5:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004b8:	83 ec 0c             	sub    $0xc,%esp
  8004bb:	50                   	push   %eax
  8004bc:	e8 c0 17 00 00       	call   801c81 <free>
  8004c1:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8004c4:	e8 dc 1a 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8004c9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004cc:	29 c2                	sub    %eax,%edx
  8004ce:	89 d0                	mov    %edx,%eax
  8004d0:	3d 00 02 00 00       	cmp    $0x200,%eax
  8004d5:	74 14                	je     8004eb <_main+0x4b3>
  8004d7:	83 ec 04             	sub    $0x4,%esp
  8004da:	68 08 27 80 00       	push   $0x802708
  8004df:	6a 69                	push   $0x69
  8004e1:	68 5c 26 80 00       	push   $0x80265c
  8004e6:	e8 fd 05 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[0];
  8004eb:	8b 45 80             	mov    -0x80(%ebp),%eax
  8004ee:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8004f1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004f4:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8004f7:	e8 23 1d 00 00       	call   80221f <sys_rcr2>
  8004fc:	89 c2                	mov    %eax,%edx
  8004fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800501:	39 c2                	cmp    %eax,%edx
  800503:	74 14                	je     800519 <_main+0x4e1>
  800505:	83 ec 04             	sub    $0x4,%esp
  800508:	68 44 27 80 00       	push   $0x802744
  80050d:	6a 6d                	push   $0x6d
  80050f:	68 5c 26 80 00       	push   $0x80265c
  800514:	e8 cf 05 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[0]] = 10;
  800519:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  80051f:	89 c2                	mov    %eax,%edx
  800521:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800524:	01 d0                	add    %edx,%eax
  800526:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[0]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800529:	e8 f1 1c 00 00       	call   80221f <sys_rcr2>
  80052e:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  800534:	89 d1                	mov    %edx,%ecx
  800536:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800539:	01 ca                	add    %ecx,%edx
  80053b:	39 d0                	cmp    %edx,%eax
  80053d:	74 14                	je     800553 <_main+0x51b>
  80053f:	83 ec 04             	sub    $0x4,%esp
  800542:	68 44 27 80 00       	push   $0x802744
  800547:	6a 6f                	push   $0x6f
  800549:	68 5c 26 80 00       	push   $0x80265c
  80054e:	e8 95 05 00 00       	call   800ae8 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800553:	e8 ca 19 00 00       	call   801f22 <sys_calculate_free_frames>
  800558:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80055b:	e8 45 1a 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800560:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[1]);
  800563:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800566:	83 ec 0c             	sub    $0xc,%esp
  800569:	50                   	push   %eax
  80056a:	e8 12 17 00 00       	call   801c81 <free>
  80056f:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800572:	e8 2e 1a 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800577:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80057a:	29 c2                	sub    %eax,%edx
  80057c:	89 d0                	mov    %edx,%eax
  80057e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800583:	74 14                	je     800599 <_main+0x561>
  800585:	83 ec 04             	sub    $0x4,%esp
  800588:	68 08 27 80 00       	push   $0x802708
  80058d:	6a 74                	push   $0x74
  80058f:	68 5c 26 80 00       	push   $0x80265c
  800594:	e8 4f 05 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 + 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[1];
  800599:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80059c:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80059f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005a2:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8005a5:	e8 75 1c 00 00       	call   80221f <sys_rcr2>
  8005aa:	89 c2                	mov    %eax,%edx
  8005ac:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005af:	39 c2                	cmp    %eax,%edx
  8005b1:	74 14                	je     8005c7 <_main+0x58f>
  8005b3:	83 ec 04             	sub    $0x4,%esp
  8005b6:	68 44 27 80 00       	push   $0x802744
  8005bb:	6a 78                	push   $0x78
  8005bd:	68 5c 26 80 00       	push   $0x80265c
  8005c2:	e8 21 05 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[1]] = 10;
  8005c7:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  8005cd:	89 c2                	mov    %eax,%edx
  8005cf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005d2:	01 d0                	add    %edx,%eax
  8005d4:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[1]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8005d7:	e8 43 1c 00 00       	call   80221f <sys_rcr2>
  8005dc:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
  8005e2:	89 d1                	mov    %edx,%ecx
  8005e4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8005e7:	01 ca                	add    %ecx,%edx
  8005e9:	39 d0                	cmp    %edx,%eax
  8005eb:	74 14                	je     800601 <_main+0x5c9>
  8005ed:	83 ec 04             	sub    $0x4,%esp
  8005f0:	68 44 27 80 00       	push   $0x802744
  8005f5:	6a 7a                	push   $0x7a
  8005f7:	68 5c 26 80 00       	push   $0x80265c
  8005fc:	e8 e7 04 00 00       	call   800ae8 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800601:	e8 1c 19 00 00       	call   801f22 <sys_calculate_free_frames>
  800606:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800609:	e8 97 19 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80060e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[2]);
  800611:	8b 45 88             	mov    -0x78(%ebp),%eax
  800614:	83 ec 0c             	sub    $0xc,%esp
  800617:	50                   	push   %eax
  800618:	e8 64 16 00 00       	call   801c81 <free>
  80061d:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  800620:	e8 80 19 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800625:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800628:	29 c2                	sub    %eax,%edx
  80062a:	89 d0                	mov    %edx,%eax
  80062c:	83 f8 01             	cmp    $0x1,%eax
  80062f:	74 14                	je     800645 <_main+0x60d>
  800631:	83 ec 04             	sub    $0x4,%esp
  800634:	68 08 27 80 00       	push   $0x802708
  800639:	6a 7f                	push   $0x7f
  80063b:	68 5c 26 80 00       	push   $0x80265c
  800640:	e8 a3 04 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[2];
  800645:	8b 45 88             	mov    -0x78(%ebp),%eax
  800648:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80064b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80064e:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800651:	e8 c9 1b 00 00       	call   80221f <sys_rcr2>
  800656:	89 c2                	mov    %eax,%edx
  800658:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80065b:	39 c2                	cmp    %eax,%edx
  80065d:	74 17                	je     800676 <_main+0x63e>
  80065f:	83 ec 04             	sub    $0x4,%esp
  800662:	68 44 27 80 00       	push   $0x802744
  800667:	68 83 00 00 00       	push   $0x83
  80066c:	68 5c 26 80 00       	push   $0x80265c
  800671:	e8 72 04 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[2]] = 10;
  800676:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  80067c:	89 c2                	mov    %eax,%edx
  80067e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800681:	01 d0                	add    %edx,%eax
  800683:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[2]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800686:	e8 94 1b 00 00       	call   80221f <sys_rcr2>
  80068b:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800691:	89 d1                	mov    %edx,%ecx
  800693:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800696:	01 ca                	add    %ecx,%edx
  800698:	39 d0                	cmp    %edx,%eax
  80069a:	74 17                	je     8006b3 <_main+0x67b>
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	68 44 27 80 00       	push   $0x802744
  8006a4:	68 85 00 00 00       	push   $0x85
  8006a9:	68 5c 26 80 00       	push   $0x80265c
  8006ae:	e8 35 04 00 00       	call   800ae8 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8006b3:	e8 6a 18 00 00       	call   801f22 <sys_calculate_free_frames>
  8006b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006bb:	e8 e5 18 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8006c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[3]);
  8006c3:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8006c6:	83 ec 0c             	sub    $0xc,%esp
  8006c9:	50                   	push   %eax
  8006ca:	e8 b2 15 00 00       	call   801c81 <free>
  8006cf:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006d2:	e8 ce 18 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8006d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8006da:	29 c2                	sub    %eax,%edx
  8006dc:	89 d0                	mov    %edx,%eax
  8006de:	83 f8 01             	cmp    $0x1,%eax
  8006e1:	74 17                	je     8006fa <_main+0x6c2>
  8006e3:	83 ec 04             	sub    $0x4,%esp
  8006e6:	68 08 27 80 00       	push   $0x802708
  8006eb:	68 8a 00 00 00       	push   $0x8a
  8006f0:	68 5c 26 80 00       	push   $0x80265c
  8006f5:	e8 ee 03 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 1 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[3];
  8006fa:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8006fd:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800700:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800703:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800706:	e8 14 1b 00 00       	call   80221f <sys_rcr2>
  80070b:	89 c2                	mov    %eax,%edx
  80070d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800710:	39 c2                	cmp    %eax,%edx
  800712:	74 17                	je     80072b <_main+0x6f3>
  800714:	83 ec 04             	sub    $0x4,%esp
  800717:	68 44 27 80 00       	push   $0x802744
  80071c:	68 8e 00 00 00       	push   $0x8e
  800721:	68 5c 26 80 00       	push   $0x80265c
  800726:	e8 bd 03 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[3]] = 10;
  80072b:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800731:	89 c2                	mov    %eax,%edx
  800733:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800736:	01 d0                	add    %edx,%eax
  800738:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[3]])) panic("Free: successful access to freed space!! it should not be succeeded");
  80073b:	e8 df 1a 00 00       	call   80221f <sys_rcr2>
  800740:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800746:	89 d1                	mov    %edx,%ecx
  800748:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80074b:	01 ca                	add    %ecx,%edx
  80074d:	39 d0                	cmp    %edx,%eax
  80074f:	74 17                	je     800768 <_main+0x730>
  800751:	83 ec 04             	sub    $0x4,%esp
  800754:	68 44 27 80 00       	push   $0x802744
  800759:	68 90 00 00 00       	push   $0x90
  80075e:	68 5c 26 80 00       	push   $0x80265c
  800763:	e8 80 03 00 00       	call   800ae8 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800768:	e8 b5 17 00 00       	call   801f22 <sys_calculate_free_frames>
  80076d:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800770:	e8 30 18 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800775:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[4]);
  800778:	8b 45 90             	mov    -0x70(%ebp),%eax
  80077b:	83 ec 0c             	sub    $0xc,%esp
  80077e:	50                   	push   %eax
  80077f:	e8 fd 14 00 00       	call   801c81 <free>
  800784:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  800787:	e8 19 18 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80078c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80078f:	29 c2                	sub    %eax,%edx
  800791:	89 d0                	mov    %edx,%eax
  800793:	83 f8 02             	cmp    $0x2,%eax
  800796:	74 17                	je     8007af <_main+0x777>
  800798:	83 ec 04             	sub    $0x4,%esp
  80079b:	68 08 27 80 00       	push   $0x802708
  8007a0:	68 95 00 00 00       	push   $0x95
  8007a5:	68 5c 26 80 00       	push   $0x80265c
  8007aa:	e8 39 03 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[4];
  8007af:	8b 45 90             	mov    -0x70(%ebp),%eax
  8007b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  8007b5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007b8:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  8007bb:	e8 5f 1a 00 00       	call   80221f <sys_rcr2>
  8007c0:	89 c2                	mov    %eax,%edx
  8007c2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007c5:	39 c2                	cmp    %eax,%edx
  8007c7:	74 17                	je     8007e0 <_main+0x7a8>
  8007c9:	83 ec 04             	sub    $0x4,%esp
  8007cc:	68 44 27 80 00       	push   $0x802744
  8007d1:	68 99 00 00 00       	push   $0x99
  8007d6:	68 5c 26 80 00       	push   $0x80265c
  8007db:	e8 08 03 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[4]] = 10;
  8007e0:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  8007e6:	89 c2                	mov    %eax,%edx
  8007e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007eb:	01 d0                	add    %edx,%eax
  8007ed:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[4]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8007f0:	e8 2a 1a 00 00       	call   80221f <sys_rcr2>
  8007f5:	8b 95 40 ff ff ff    	mov    -0xc0(%ebp),%edx
  8007fb:	89 d1                	mov    %edx,%ecx
  8007fd:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800800:	01 ca                	add    %ecx,%edx
  800802:	39 d0                	cmp    %edx,%eax
  800804:	74 17                	je     80081d <_main+0x7e5>
  800806:	83 ec 04             	sub    $0x4,%esp
  800809:	68 44 27 80 00       	push   $0x802744
  80080e:	68 9b 00 00 00       	push   $0x9b
  800813:	68 5c 26 80 00       	push   $0x80265c
  800818:	e8 cb 02 00 00       	call   800ae8 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80081d:	e8 00 17 00 00       	call   801f22 <sys_calculate_free_frames>
  800822:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800825:	e8 7b 17 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80082a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[5]);
  80082d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800830:	83 ec 0c             	sub    $0xc,%esp
  800833:	50                   	push   %eax
  800834:	e8 48 14 00 00       	call   801c81 <free>
  800839:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096 ) panic("Wrong free: Extra or less pages are removed from PageFile");
  80083c:	e8 64 17 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  800841:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800844:	89 d1                	mov    %edx,%ecx
  800846:	29 c1                	sub    %eax,%ecx
  800848:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80084b:	89 c2                	mov    %eax,%edx
  80084d:	01 d2                	add    %edx,%edx
  80084f:	01 d0                	add    %edx,%eax
  800851:	85 c0                	test   %eax,%eax
  800853:	79 05                	jns    80085a <_main+0x822>
  800855:	05 ff 0f 00 00       	add    $0xfff,%eax
  80085a:	c1 f8 0c             	sar    $0xc,%eax
  80085d:	39 c1                	cmp    %eax,%ecx
  80085f:	74 17                	je     800878 <_main+0x840>
  800861:	83 ec 04             	sub    $0x4,%esp
  800864:	68 08 27 80 00       	push   $0x802708
  800869:	68 a0 00 00 00       	push   $0xa0
  80086e:	68 5c 26 80 00       	push   $0x80265c
  800873:	e8 70 02 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 3*Mega/4096 ) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[5];
  800878:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80087b:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  80087e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800881:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  800884:	e8 96 19 00 00       	call   80221f <sys_rcr2>
  800889:	89 c2                	mov    %eax,%edx
  80088b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80088e:	39 c2                	cmp    %eax,%edx
  800890:	74 17                	je     8008a9 <_main+0x871>
  800892:	83 ec 04             	sub    $0x4,%esp
  800895:	68 44 27 80 00       	push   $0x802744
  80089a:	68 a4 00 00 00       	push   $0xa4
  80089f:	68 5c 26 80 00       	push   $0x80265c
  8008a4:	e8 3f 02 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[5]] = 10;
  8008a9:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  8008af:	89 c2                	mov    %eax,%edx
  8008b1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8008b4:	01 d0                	add    %edx,%eax
  8008b6:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[5]])) panic("Free: successful access to freed space!! it should not be succeeded");
  8008b9:	e8 61 19 00 00       	call   80221f <sys_rcr2>
  8008be:	8b 95 44 ff ff ff    	mov    -0xbc(%ebp),%edx
  8008c4:	89 d1                	mov    %edx,%ecx
  8008c6:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8008c9:	01 ca                	add    %ecx,%edx
  8008cb:	39 d0                	cmp    %edx,%eax
  8008cd:	74 17                	je     8008e6 <_main+0x8ae>
  8008cf:	83 ec 04             	sub    $0x4,%esp
  8008d2:	68 44 27 80 00       	push   $0x802744
  8008d7:	68 a6 00 00 00       	push   $0xa6
  8008dc:	68 5c 26 80 00       	push   $0x80265c
  8008e1:	e8 02 02 00 00       	call   800ae8 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8008e6:	e8 37 16 00 00       	call   801f22 <sys_calculate_free_frames>
  8008eb:	89 45 d8             	mov    %eax,-0x28(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008ee:	e8 b2 16 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  8008f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		free(ptr_allocations[6]);
  8008f6:	8b 45 98             	mov    -0x68(%ebp),%eax
  8008f9:	83 ec 0c             	sub    $0xc,%esp
  8008fc:	50                   	push   %eax
  8008fd:	e8 7f 13 00 00       	call   801c81 <free>
  800902:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800905:	e8 9b 16 00 00       	call   801fa5 <sys_pf_calculate_allocated_pages>
  80090a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80090d:	29 c2                	sub    %eax,%edx
  80090f:	89 d0                	mov    %edx,%eax
  800911:	3d 00 02 00 00       	cmp    $0x200,%eax
  800916:	74 17                	je     80092f <_main+0x8f7>
  800918:	83 ec 04             	sub    $0x4,%esp
  80091b:	68 08 27 80 00       	push   $0x802708
  800920:	68 ab 00 00 00       	push   $0xab
  800925:	68 5c 26 80 00       	push   $0x80265c
  80092a:	e8 b9 01 00 00       	call   800ae8 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 512 + 2) panic("Wrong free: ");
		byteArr = (char *) ptr_allocations[6];
  80092f:	8b 45 98             	mov    -0x68(%ebp),%eax
  800932:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = 10;
  800935:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800938:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("Free: successful access to freed space!! it should not be succeeded");
  80093b:	e8 df 18 00 00       	call   80221f <sys_rcr2>
  800940:	89 c2                	mov    %eax,%edx
  800942:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800945:	39 c2                	cmp    %eax,%edx
  800947:	74 17                	je     800960 <_main+0x928>
  800949:	83 ec 04             	sub    $0x4,%esp
  80094c:	68 44 27 80 00       	push   $0x802744
  800951:	68 af 00 00 00       	push   $0xaf
  800956:	68 5c 26 80 00       	push   $0x80265c
  80095b:	e8 88 01 00 00       	call   800ae8 <_panic>
		byteArr[lastIndices[6]] = 10;
  800960:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800966:	89 c2                	mov    %eax,%edx
  800968:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80096b:	01 d0                	add    %edx,%eax
  80096d:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[lastIndices[6]])) panic("Free: successful access to freed space!! it should not be succeeded");
  800970:	e8 aa 18 00 00       	call   80221f <sys_rcr2>
  800975:	8b 95 48 ff ff ff    	mov    -0xb8(%ebp),%edx
  80097b:	89 d1                	mov    %edx,%ecx
  80097d:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800980:	01 ca                	add    %ecx,%edx
  800982:	39 d0                	cmp    %edx,%eax
  800984:	74 17                	je     80099d <_main+0x965>
  800986:	83 ec 04             	sub    $0x4,%esp
  800989:	68 44 27 80 00       	push   $0x802744
  80098e:	68 b1 00 00 00       	push   $0xb1
  800993:	68 5c 26 80 00       	push   $0x80265c
  800998:	e8 4b 01 00 00       	call   800ae8 <_panic>

		if(start_freeFrames != (sys_calculate_free_frames() + 3) ) {panic("Wrong free: not all pages removed correctly at end");}
  80099d:	e8 80 15 00 00       	call   801f22 <sys_calculate_free_frames>
  8009a2:	8d 50 03             	lea    0x3(%eax),%edx
  8009a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009a8:	39 c2                	cmp    %eax,%edx
  8009aa:	74 17                	je     8009c3 <_main+0x98b>
  8009ac:	83 ec 04             	sub    $0x4,%esp
  8009af:	68 88 27 80 00       	push   $0x802788
  8009b4:	68 b3 00 00 00       	push   $0xb3
  8009b9:	68 5c 26 80 00       	push   $0x80265c
  8009be:	e8 25 01 00 00       	call   800ae8 <_panic>
	}

	//set it to 0 again to cancel the bypassing option
	sys_bypassPageFault(0);
  8009c3:	83 ec 0c             	sub    $0xc,%esp
  8009c6:	6a 00                	push   $0x0
  8009c8:	e8 6b 18 00 00       	call   802238 <sys_bypassPageFault>
  8009cd:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test free [2] completed successfully.\n");
  8009d0:	83 ec 0c             	sub    $0xc,%esp
  8009d3:	68 bc 27 80 00       	push   $0x8027bc
  8009d8:	e8 bf 03 00 00       	call   800d9c <cprintf>
  8009dd:	83 c4 10             	add    $0x10,%esp

	return;
  8009e0:	90                   	nop
}
  8009e1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  8009e4:	c9                   	leave  
  8009e5:	c3                   	ret    

008009e6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8009ec:	e8 66 14 00 00       	call   801e57 <sys_getenvindex>
  8009f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8009f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f7:	89 d0                	mov    %edx,%eax
  8009f9:	01 c0                	add    %eax,%eax
  8009fb:	01 d0                	add    %edx,%eax
  8009fd:	c1 e0 02             	shl    $0x2,%eax
  800a00:	01 d0                	add    %edx,%eax
  800a02:	c1 e0 06             	shl    $0x6,%eax
  800a05:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800a0a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800a0f:	a1 20 30 80 00       	mov    0x803020,%eax
  800a14:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800a1a:	84 c0                	test   %al,%al
  800a1c:	74 0f                	je     800a2d <libmain+0x47>
		binaryname = myEnv->prog_name;
  800a1e:	a1 20 30 80 00       	mov    0x803020,%eax
  800a23:	05 f4 02 00 00       	add    $0x2f4,%eax
  800a28:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800a2d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a31:	7e 0a                	jle    800a3d <libmain+0x57>
		binaryname = argv[0];
  800a33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a36:	8b 00                	mov    (%eax),%eax
  800a38:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800a3d:	83 ec 08             	sub    $0x8,%esp
  800a40:	ff 75 0c             	pushl  0xc(%ebp)
  800a43:	ff 75 08             	pushl  0x8(%ebp)
  800a46:	e8 ed f5 ff ff       	call   800038 <_main>
  800a4b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800a4e:	e8 9f 15 00 00       	call   801ff2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800a53:	83 ec 0c             	sub    $0xc,%esp
  800a56:	68 10 28 80 00       	push   $0x802810
  800a5b:	e8 3c 03 00 00       	call   800d9c <cprintf>
  800a60:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800a63:	a1 20 30 80 00       	mov    0x803020,%eax
  800a68:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800a6e:	a1 20 30 80 00       	mov    0x803020,%eax
  800a73:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800a79:	83 ec 04             	sub    $0x4,%esp
  800a7c:	52                   	push   %edx
  800a7d:	50                   	push   %eax
  800a7e:	68 38 28 80 00       	push   $0x802838
  800a83:	e8 14 03 00 00       	call   800d9c <cprintf>
  800a88:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800a8b:	a1 20 30 80 00       	mov    0x803020,%eax
  800a90:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800a96:	83 ec 08             	sub    $0x8,%esp
  800a99:	50                   	push   %eax
  800a9a:	68 5d 28 80 00       	push   $0x80285d
  800a9f:	e8 f8 02 00 00       	call   800d9c <cprintf>
  800aa4:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800aa7:	83 ec 0c             	sub    $0xc,%esp
  800aaa:	68 10 28 80 00       	push   $0x802810
  800aaf:	e8 e8 02 00 00       	call   800d9c <cprintf>
  800ab4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800ab7:	e8 50 15 00 00       	call   80200c <sys_enable_interrupt>

	// exit gracefully
	exit();
  800abc:	e8 19 00 00 00       	call   800ada <exit>
}
  800ac1:	90                   	nop
  800ac2:	c9                   	leave  
  800ac3:	c3                   	ret    

00800ac4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
  800ac7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800aca:	83 ec 0c             	sub    $0xc,%esp
  800acd:	6a 00                	push   $0x0
  800acf:	e8 4f 13 00 00       	call   801e23 <sys_env_destroy>
  800ad4:	83 c4 10             	add    $0x10,%esp
}
  800ad7:	90                   	nop
  800ad8:	c9                   	leave  
  800ad9:	c3                   	ret    

00800ada <exit>:

void
exit(void)
{
  800ada:	55                   	push   %ebp
  800adb:	89 e5                	mov    %esp,%ebp
  800add:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800ae0:	e8 a4 13 00 00       	call   801e89 <sys_env_exit>
}
  800ae5:	90                   	nop
  800ae6:	c9                   	leave  
  800ae7:	c3                   	ret    

00800ae8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800ae8:	55                   	push   %ebp
  800ae9:	89 e5                	mov    %esp,%ebp
  800aeb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800aee:	8d 45 10             	lea    0x10(%ebp),%eax
  800af1:	83 c0 04             	add    $0x4,%eax
  800af4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800af7:	a1 30 30 80 00       	mov    0x803030,%eax
  800afc:	85 c0                	test   %eax,%eax
  800afe:	74 16                	je     800b16 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800b00:	a1 30 30 80 00       	mov    0x803030,%eax
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	50                   	push   %eax
  800b09:	68 74 28 80 00       	push   $0x802874
  800b0e:	e8 89 02 00 00       	call   800d9c <cprintf>
  800b13:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800b16:	a1 00 30 80 00       	mov    0x803000,%eax
  800b1b:	ff 75 0c             	pushl  0xc(%ebp)
  800b1e:	ff 75 08             	pushl  0x8(%ebp)
  800b21:	50                   	push   %eax
  800b22:	68 79 28 80 00       	push   $0x802879
  800b27:	e8 70 02 00 00       	call   800d9c <cprintf>
  800b2c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800b2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b32:	83 ec 08             	sub    $0x8,%esp
  800b35:	ff 75 f4             	pushl  -0xc(%ebp)
  800b38:	50                   	push   %eax
  800b39:	e8 f3 01 00 00       	call   800d31 <vcprintf>
  800b3e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800b41:	83 ec 08             	sub    $0x8,%esp
  800b44:	6a 00                	push   $0x0
  800b46:	68 95 28 80 00       	push   $0x802895
  800b4b:	e8 e1 01 00 00       	call   800d31 <vcprintf>
  800b50:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800b53:	e8 82 ff ff ff       	call   800ada <exit>

	// should not return here
	while (1) ;
  800b58:	eb fe                	jmp    800b58 <_panic+0x70>

00800b5a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800b5a:	55                   	push   %ebp
  800b5b:	89 e5                	mov    %esp,%ebp
  800b5d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800b60:	a1 20 30 80 00       	mov    0x803020,%eax
  800b65:	8b 50 74             	mov    0x74(%eax),%edx
  800b68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6b:	39 c2                	cmp    %eax,%edx
  800b6d:	74 14                	je     800b83 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800b6f:	83 ec 04             	sub    $0x4,%esp
  800b72:	68 98 28 80 00       	push   $0x802898
  800b77:	6a 26                	push   $0x26
  800b79:	68 e4 28 80 00       	push   $0x8028e4
  800b7e:	e8 65 ff ff ff       	call   800ae8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800b83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800b8a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800b91:	e9 c2 00 00 00       	jmp    800c58 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b99:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	01 d0                	add    %edx,%eax
  800ba5:	8b 00                	mov    (%eax),%eax
  800ba7:	85 c0                	test   %eax,%eax
  800ba9:	75 08                	jne    800bb3 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800bab:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800bae:	e9 a2 00 00 00       	jmp    800c55 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800bb3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800bba:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800bc1:	eb 69                	jmp    800c2c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800bc3:	a1 20 30 80 00       	mov    0x803020,%eax
  800bc8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bce:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800bd1:	89 d0                	mov    %edx,%eax
  800bd3:	01 c0                	add    %eax,%eax
  800bd5:	01 d0                	add    %edx,%eax
  800bd7:	c1 e0 02             	shl    $0x2,%eax
  800bda:	01 c8                	add    %ecx,%eax
  800bdc:	8a 40 04             	mov    0x4(%eax),%al
  800bdf:	84 c0                	test   %al,%al
  800be1:	75 46                	jne    800c29 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800be3:	a1 20 30 80 00       	mov    0x803020,%eax
  800be8:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800bee:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800bf1:	89 d0                	mov    %edx,%eax
  800bf3:	01 c0                	add    %eax,%eax
  800bf5:	01 d0                	add    %edx,%eax
  800bf7:	c1 e0 02             	shl    $0x2,%eax
  800bfa:	01 c8                	add    %ecx,%eax
  800bfc:	8b 00                	mov    (%eax),%eax
  800bfe:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800c01:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c04:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c09:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800c0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c0e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	01 c8                	add    %ecx,%eax
  800c1a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800c1c:	39 c2                	cmp    %eax,%edx
  800c1e:	75 09                	jne    800c29 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800c20:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800c27:	eb 12                	jmp    800c3b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c29:	ff 45 e8             	incl   -0x18(%ebp)
  800c2c:	a1 20 30 80 00       	mov    0x803020,%eax
  800c31:	8b 50 74             	mov    0x74(%eax),%edx
  800c34:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800c37:	39 c2                	cmp    %eax,%edx
  800c39:	77 88                	ja     800bc3 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800c3b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c3f:	75 14                	jne    800c55 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800c41:	83 ec 04             	sub    $0x4,%esp
  800c44:	68 f0 28 80 00       	push   $0x8028f0
  800c49:	6a 3a                	push   $0x3a
  800c4b:	68 e4 28 80 00       	push   $0x8028e4
  800c50:	e8 93 fe ff ff       	call   800ae8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800c55:	ff 45 f0             	incl   -0x10(%ebp)
  800c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800c5e:	0f 8c 32 ff ff ff    	jl     800b96 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800c64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c6b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800c72:	eb 26                	jmp    800c9a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800c74:	a1 20 30 80 00       	mov    0x803020,%eax
  800c79:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800c7f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c82:	89 d0                	mov    %edx,%eax
  800c84:	01 c0                	add    %eax,%eax
  800c86:	01 d0                	add    %edx,%eax
  800c88:	c1 e0 02             	shl    $0x2,%eax
  800c8b:	01 c8                	add    %ecx,%eax
  800c8d:	8a 40 04             	mov    0x4(%eax),%al
  800c90:	3c 01                	cmp    $0x1,%al
  800c92:	75 03                	jne    800c97 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800c94:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800c97:	ff 45 e0             	incl   -0x20(%ebp)
  800c9a:	a1 20 30 80 00       	mov    0x803020,%eax
  800c9f:	8b 50 74             	mov    0x74(%eax),%edx
  800ca2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca5:	39 c2                	cmp    %eax,%edx
  800ca7:	77 cb                	ja     800c74 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cac:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800caf:	74 14                	je     800cc5 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800cb1:	83 ec 04             	sub    $0x4,%esp
  800cb4:	68 44 29 80 00       	push   $0x802944
  800cb9:	6a 44                	push   $0x44
  800cbb:	68 e4 28 80 00       	push   $0x8028e4
  800cc0:	e8 23 fe ff ff       	call   800ae8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800cc5:	90                   	nop
  800cc6:	c9                   	leave  
  800cc7:	c3                   	ret    

00800cc8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
  800ccb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800cce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd1:	8b 00                	mov    (%eax),%eax
  800cd3:	8d 48 01             	lea    0x1(%eax),%ecx
  800cd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd9:	89 0a                	mov    %ecx,(%edx)
  800cdb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cde:	88 d1                	mov    %dl,%cl
  800ce0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	8b 00                	mov    (%eax),%eax
  800cec:	3d ff 00 00 00       	cmp    $0xff,%eax
  800cf1:	75 2c                	jne    800d1f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800cf3:	a0 24 30 80 00       	mov    0x803024,%al
  800cf8:	0f b6 c0             	movzbl %al,%eax
  800cfb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cfe:	8b 12                	mov    (%edx),%edx
  800d00:	89 d1                	mov    %edx,%ecx
  800d02:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d05:	83 c2 08             	add    $0x8,%edx
  800d08:	83 ec 04             	sub    $0x4,%esp
  800d0b:	50                   	push   %eax
  800d0c:	51                   	push   %ecx
  800d0d:	52                   	push   %edx
  800d0e:	e8 ce 10 00 00       	call   801de1 <sys_cputs>
  800d13:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d22:	8b 40 04             	mov    0x4(%eax),%eax
  800d25:	8d 50 01             	lea    0x1(%eax),%edx
  800d28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2b:	89 50 04             	mov    %edx,0x4(%eax)
}
  800d2e:	90                   	nop
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800d3a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800d41:	00 00 00 
	b.cnt = 0;
  800d44:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800d4b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800d4e:	ff 75 0c             	pushl  0xc(%ebp)
  800d51:	ff 75 08             	pushl  0x8(%ebp)
  800d54:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d5a:	50                   	push   %eax
  800d5b:	68 c8 0c 80 00       	push   $0x800cc8
  800d60:	e8 11 02 00 00       	call   800f76 <vprintfmt>
  800d65:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800d68:	a0 24 30 80 00       	mov    0x803024,%al
  800d6d:	0f b6 c0             	movzbl %al,%eax
  800d70:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800d76:	83 ec 04             	sub    $0x4,%esp
  800d79:	50                   	push   %eax
  800d7a:	52                   	push   %edx
  800d7b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800d81:	83 c0 08             	add    $0x8,%eax
  800d84:	50                   	push   %eax
  800d85:	e8 57 10 00 00       	call   801de1 <sys_cputs>
  800d8a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800d8d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800d94:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800d9a:	c9                   	leave  
  800d9b:	c3                   	ret    

00800d9c <cprintf>:

int cprintf(const char *fmt, ...) {
  800d9c:	55                   	push   %ebp
  800d9d:	89 e5                	mov    %esp,%ebp
  800d9f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800da2:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800da9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800dac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	83 ec 08             	sub    $0x8,%esp
  800db5:	ff 75 f4             	pushl  -0xc(%ebp)
  800db8:	50                   	push   %eax
  800db9:	e8 73 ff ff ff       	call   800d31 <vcprintf>
  800dbe:	83 c4 10             	add    $0x10,%esp
  800dc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800dc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dc7:	c9                   	leave  
  800dc8:	c3                   	ret    

00800dc9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800dc9:	55                   	push   %ebp
  800dca:	89 e5                	mov    %esp,%ebp
  800dcc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800dcf:	e8 1e 12 00 00       	call   801ff2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800dd4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800dd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	83 ec 08             	sub    $0x8,%esp
  800de0:	ff 75 f4             	pushl  -0xc(%ebp)
  800de3:	50                   	push   %eax
  800de4:	e8 48 ff ff ff       	call   800d31 <vcprintf>
  800de9:	83 c4 10             	add    $0x10,%esp
  800dec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800def:	e8 18 12 00 00       	call   80200c <sys_enable_interrupt>
	return cnt;
  800df4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800df7:	c9                   	leave  
  800df8:	c3                   	ret    

00800df9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800df9:	55                   	push   %ebp
  800dfa:	89 e5                	mov    %esp,%ebp
  800dfc:	53                   	push   %ebx
  800dfd:	83 ec 14             	sub    $0x14,%esp
  800e00:	8b 45 10             	mov    0x10(%ebp),%eax
  800e03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e06:	8b 45 14             	mov    0x14(%ebp),%eax
  800e09:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800e0c:	8b 45 18             	mov    0x18(%ebp),%eax
  800e0f:	ba 00 00 00 00       	mov    $0x0,%edx
  800e14:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e17:	77 55                	ja     800e6e <printnum+0x75>
  800e19:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800e1c:	72 05                	jb     800e23 <printnum+0x2a>
  800e1e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e21:	77 4b                	ja     800e6e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800e23:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800e26:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800e29:	8b 45 18             	mov    0x18(%ebp),%eax
  800e2c:	ba 00 00 00 00       	mov    $0x0,%edx
  800e31:	52                   	push   %edx
  800e32:	50                   	push   %eax
  800e33:	ff 75 f4             	pushl  -0xc(%ebp)
  800e36:	ff 75 f0             	pushl  -0x10(%ebp)
  800e39:	e8 92 15 00 00       	call   8023d0 <__udivdi3>
  800e3e:	83 c4 10             	add    $0x10,%esp
  800e41:	83 ec 04             	sub    $0x4,%esp
  800e44:	ff 75 20             	pushl  0x20(%ebp)
  800e47:	53                   	push   %ebx
  800e48:	ff 75 18             	pushl  0x18(%ebp)
  800e4b:	52                   	push   %edx
  800e4c:	50                   	push   %eax
  800e4d:	ff 75 0c             	pushl  0xc(%ebp)
  800e50:	ff 75 08             	pushl  0x8(%ebp)
  800e53:	e8 a1 ff ff ff       	call   800df9 <printnum>
  800e58:	83 c4 20             	add    $0x20,%esp
  800e5b:	eb 1a                	jmp    800e77 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800e5d:	83 ec 08             	sub    $0x8,%esp
  800e60:	ff 75 0c             	pushl  0xc(%ebp)
  800e63:	ff 75 20             	pushl  0x20(%ebp)
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800e6e:	ff 4d 1c             	decl   0x1c(%ebp)
  800e71:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800e75:	7f e6                	jg     800e5d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800e77:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800e7a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800e7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e85:	53                   	push   %ebx
  800e86:	51                   	push   %ecx
  800e87:	52                   	push   %edx
  800e88:	50                   	push   %eax
  800e89:	e8 52 16 00 00       	call   8024e0 <__umoddi3>
  800e8e:	83 c4 10             	add    $0x10,%esp
  800e91:	05 b4 2b 80 00       	add    $0x802bb4,%eax
  800e96:	8a 00                	mov    (%eax),%al
  800e98:	0f be c0             	movsbl %al,%eax
  800e9b:	83 ec 08             	sub    $0x8,%esp
  800e9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ea1:	50                   	push   %eax
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	ff d0                	call   *%eax
  800ea7:	83 c4 10             	add    $0x10,%esp
}
  800eaa:	90                   	nop
  800eab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800eae:	c9                   	leave  
  800eaf:	c3                   	ret    

00800eb0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800eb0:	55                   	push   %ebp
  800eb1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800eb3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800eb7:	7e 1c                	jle    800ed5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebc:	8b 00                	mov    (%eax),%eax
  800ebe:	8d 50 08             	lea    0x8(%eax),%edx
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	89 10                	mov    %edx,(%eax)
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	8b 00                	mov    (%eax),%eax
  800ecb:	83 e8 08             	sub    $0x8,%eax
  800ece:	8b 50 04             	mov    0x4(%eax),%edx
  800ed1:	8b 00                	mov    (%eax),%eax
  800ed3:	eb 40                	jmp    800f15 <getuint+0x65>
	else if (lflag)
  800ed5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ed9:	74 1e                	je     800ef9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	8b 00                	mov    (%eax),%eax
  800ee0:	8d 50 04             	lea    0x4(%eax),%edx
  800ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee6:	89 10                	mov    %edx,(%eax)
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8b 00                	mov    (%eax),%eax
  800eed:	83 e8 04             	sub    $0x4,%eax
  800ef0:	8b 00                	mov    (%eax),%eax
  800ef2:	ba 00 00 00 00       	mov    $0x0,%edx
  800ef7:	eb 1c                	jmp    800f15 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	8b 00                	mov    (%eax),%eax
  800efe:	8d 50 04             	lea    0x4(%eax),%edx
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	89 10                	mov    %edx,(%eax)
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	8b 00                	mov    (%eax),%eax
  800f0b:	83 e8 04             	sub    $0x4,%eax
  800f0e:	8b 00                	mov    (%eax),%eax
  800f10:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800f15:	5d                   	pop    %ebp
  800f16:	c3                   	ret    

00800f17 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800f17:	55                   	push   %ebp
  800f18:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800f1a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800f1e:	7e 1c                	jle    800f3c <getint+0x25>
		return va_arg(*ap, long long);
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	8b 00                	mov    (%eax),%eax
  800f25:	8d 50 08             	lea    0x8(%eax),%edx
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	89 10                	mov    %edx,(%eax)
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	8b 00                	mov    (%eax),%eax
  800f32:	83 e8 08             	sub    $0x8,%eax
  800f35:	8b 50 04             	mov    0x4(%eax),%edx
  800f38:	8b 00                	mov    (%eax),%eax
  800f3a:	eb 38                	jmp    800f74 <getint+0x5d>
	else if (lflag)
  800f3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f40:	74 1a                	je     800f5c <getint+0x45>
		return va_arg(*ap, long);
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	8b 00                	mov    (%eax),%eax
  800f47:	8d 50 04             	lea    0x4(%eax),%edx
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	89 10                	mov    %edx,(%eax)
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8b 00                	mov    (%eax),%eax
  800f54:	83 e8 04             	sub    $0x4,%eax
  800f57:	8b 00                	mov    (%eax),%eax
  800f59:	99                   	cltd   
  800f5a:	eb 18                	jmp    800f74 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8b 00                	mov    (%eax),%eax
  800f61:	8d 50 04             	lea    0x4(%eax),%edx
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	89 10                	mov    %edx,(%eax)
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	8b 00                	mov    (%eax),%eax
  800f6e:	83 e8 04             	sub    $0x4,%eax
  800f71:	8b 00                	mov    (%eax),%eax
  800f73:	99                   	cltd   
}
  800f74:	5d                   	pop    %ebp
  800f75:	c3                   	ret    

00800f76 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800f76:	55                   	push   %ebp
  800f77:	89 e5                	mov    %esp,%ebp
  800f79:	56                   	push   %esi
  800f7a:	53                   	push   %ebx
  800f7b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f7e:	eb 17                	jmp    800f97 <vprintfmt+0x21>
			if (ch == '\0')
  800f80:	85 db                	test   %ebx,%ebx
  800f82:	0f 84 af 03 00 00    	je     801337 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800f88:	83 ec 08             	sub    $0x8,%esp
  800f8b:	ff 75 0c             	pushl  0xc(%ebp)
  800f8e:	53                   	push   %ebx
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	ff d0                	call   *%eax
  800f94:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800f97:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9a:	8d 50 01             	lea    0x1(%eax),%edx
  800f9d:	89 55 10             	mov    %edx,0x10(%ebp)
  800fa0:	8a 00                	mov    (%eax),%al
  800fa2:	0f b6 d8             	movzbl %al,%ebx
  800fa5:	83 fb 25             	cmp    $0x25,%ebx
  800fa8:	75 d6                	jne    800f80 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800faa:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800fae:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800fb5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800fbc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800fc3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800fca:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcd:	8d 50 01             	lea    0x1(%eax),%edx
  800fd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd3:	8a 00                	mov    (%eax),%al
  800fd5:	0f b6 d8             	movzbl %al,%ebx
  800fd8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800fdb:	83 f8 55             	cmp    $0x55,%eax
  800fde:	0f 87 2b 03 00 00    	ja     80130f <vprintfmt+0x399>
  800fe4:	8b 04 85 d8 2b 80 00 	mov    0x802bd8(,%eax,4),%eax
  800feb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800fed:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ff1:	eb d7                	jmp    800fca <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ff3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ff7:	eb d1                	jmp    800fca <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ff9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801000:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801003:	89 d0                	mov    %edx,%eax
  801005:	c1 e0 02             	shl    $0x2,%eax
  801008:	01 d0                	add    %edx,%eax
  80100a:	01 c0                	add    %eax,%eax
  80100c:	01 d8                	add    %ebx,%eax
  80100e:	83 e8 30             	sub    $0x30,%eax
  801011:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801014:	8b 45 10             	mov    0x10(%ebp),%eax
  801017:	8a 00                	mov    (%eax),%al
  801019:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80101c:	83 fb 2f             	cmp    $0x2f,%ebx
  80101f:	7e 3e                	jle    80105f <vprintfmt+0xe9>
  801021:	83 fb 39             	cmp    $0x39,%ebx
  801024:	7f 39                	jg     80105f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801026:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801029:	eb d5                	jmp    801000 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80102b:	8b 45 14             	mov    0x14(%ebp),%eax
  80102e:	83 c0 04             	add    $0x4,%eax
  801031:	89 45 14             	mov    %eax,0x14(%ebp)
  801034:	8b 45 14             	mov    0x14(%ebp),%eax
  801037:	83 e8 04             	sub    $0x4,%eax
  80103a:	8b 00                	mov    (%eax),%eax
  80103c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80103f:	eb 1f                	jmp    801060 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801041:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801045:	79 83                	jns    800fca <vprintfmt+0x54>
				width = 0;
  801047:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80104e:	e9 77 ff ff ff       	jmp    800fca <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801053:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80105a:	e9 6b ff ff ff       	jmp    800fca <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80105f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801060:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801064:	0f 89 60 ff ff ff    	jns    800fca <vprintfmt+0x54>
				width = precision, precision = -1;
  80106a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80106d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801070:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801077:	e9 4e ff ff ff       	jmp    800fca <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80107c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80107f:	e9 46 ff ff ff       	jmp    800fca <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801084:	8b 45 14             	mov    0x14(%ebp),%eax
  801087:	83 c0 04             	add    $0x4,%eax
  80108a:	89 45 14             	mov    %eax,0x14(%ebp)
  80108d:	8b 45 14             	mov    0x14(%ebp),%eax
  801090:	83 e8 04             	sub    $0x4,%eax
  801093:	8b 00                	mov    (%eax),%eax
  801095:	83 ec 08             	sub    $0x8,%esp
  801098:	ff 75 0c             	pushl  0xc(%ebp)
  80109b:	50                   	push   %eax
  80109c:	8b 45 08             	mov    0x8(%ebp),%eax
  80109f:	ff d0                	call   *%eax
  8010a1:	83 c4 10             	add    $0x10,%esp
			break;
  8010a4:	e9 89 02 00 00       	jmp    801332 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8010a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8010ac:	83 c0 04             	add    $0x4,%eax
  8010af:	89 45 14             	mov    %eax,0x14(%ebp)
  8010b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b5:	83 e8 04             	sub    $0x4,%eax
  8010b8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8010ba:	85 db                	test   %ebx,%ebx
  8010bc:	79 02                	jns    8010c0 <vprintfmt+0x14a>
				err = -err;
  8010be:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8010c0:	83 fb 64             	cmp    $0x64,%ebx
  8010c3:	7f 0b                	jg     8010d0 <vprintfmt+0x15a>
  8010c5:	8b 34 9d 20 2a 80 00 	mov    0x802a20(,%ebx,4),%esi
  8010cc:	85 f6                	test   %esi,%esi
  8010ce:	75 19                	jne    8010e9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8010d0:	53                   	push   %ebx
  8010d1:	68 c5 2b 80 00       	push   $0x802bc5
  8010d6:	ff 75 0c             	pushl  0xc(%ebp)
  8010d9:	ff 75 08             	pushl  0x8(%ebp)
  8010dc:	e8 5e 02 00 00       	call   80133f <printfmt>
  8010e1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8010e4:	e9 49 02 00 00       	jmp    801332 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8010e9:	56                   	push   %esi
  8010ea:	68 ce 2b 80 00       	push   $0x802bce
  8010ef:	ff 75 0c             	pushl  0xc(%ebp)
  8010f2:	ff 75 08             	pushl  0x8(%ebp)
  8010f5:	e8 45 02 00 00       	call   80133f <printfmt>
  8010fa:	83 c4 10             	add    $0x10,%esp
			break;
  8010fd:	e9 30 02 00 00       	jmp    801332 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801102:	8b 45 14             	mov    0x14(%ebp),%eax
  801105:	83 c0 04             	add    $0x4,%eax
  801108:	89 45 14             	mov    %eax,0x14(%ebp)
  80110b:	8b 45 14             	mov    0x14(%ebp),%eax
  80110e:	83 e8 04             	sub    $0x4,%eax
  801111:	8b 30                	mov    (%eax),%esi
  801113:	85 f6                	test   %esi,%esi
  801115:	75 05                	jne    80111c <vprintfmt+0x1a6>
				p = "(null)";
  801117:	be d1 2b 80 00       	mov    $0x802bd1,%esi
			if (width > 0 && padc != '-')
  80111c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801120:	7e 6d                	jle    80118f <vprintfmt+0x219>
  801122:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801126:	74 67                	je     80118f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801128:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80112b:	83 ec 08             	sub    $0x8,%esp
  80112e:	50                   	push   %eax
  80112f:	56                   	push   %esi
  801130:	e8 0c 03 00 00       	call   801441 <strnlen>
  801135:	83 c4 10             	add    $0x10,%esp
  801138:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80113b:	eb 16                	jmp    801153 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80113d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801141:	83 ec 08             	sub    $0x8,%esp
  801144:	ff 75 0c             	pushl  0xc(%ebp)
  801147:	50                   	push   %eax
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	ff d0                	call   *%eax
  80114d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801150:	ff 4d e4             	decl   -0x1c(%ebp)
  801153:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801157:	7f e4                	jg     80113d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801159:	eb 34                	jmp    80118f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80115b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80115f:	74 1c                	je     80117d <vprintfmt+0x207>
  801161:	83 fb 1f             	cmp    $0x1f,%ebx
  801164:	7e 05                	jle    80116b <vprintfmt+0x1f5>
  801166:	83 fb 7e             	cmp    $0x7e,%ebx
  801169:	7e 12                	jle    80117d <vprintfmt+0x207>
					putch('?', putdat);
  80116b:	83 ec 08             	sub    $0x8,%esp
  80116e:	ff 75 0c             	pushl  0xc(%ebp)
  801171:	6a 3f                	push   $0x3f
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	ff d0                	call   *%eax
  801178:	83 c4 10             	add    $0x10,%esp
  80117b:	eb 0f                	jmp    80118c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80117d:	83 ec 08             	sub    $0x8,%esp
  801180:	ff 75 0c             	pushl  0xc(%ebp)
  801183:	53                   	push   %ebx
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	ff d0                	call   *%eax
  801189:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80118c:	ff 4d e4             	decl   -0x1c(%ebp)
  80118f:	89 f0                	mov    %esi,%eax
  801191:	8d 70 01             	lea    0x1(%eax),%esi
  801194:	8a 00                	mov    (%eax),%al
  801196:	0f be d8             	movsbl %al,%ebx
  801199:	85 db                	test   %ebx,%ebx
  80119b:	74 24                	je     8011c1 <vprintfmt+0x24b>
  80119d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011a1:	78 b8                	js     80115b <vprintfmt+0x1e5>
  8011a3:	ff 4d e0             	decl   -0x20(%ebp)
  8011a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8011aa:	79 af                	jns    80115b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011ac:	eb 13                	jmp    8011c1 <vprintfmt+0x24b>
				putch(' ', putdat);
  8011ae:	83 ec 08             	sub    $0x8,%esp
  8011b1:	ff 75 0c             	pushl  0xc(%ebp)
  8011b4:	6a 20                	push   $0x20
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	ff d0                	call   *%eax
  8011bb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8011be:	ff 4d e4             	decl   -0x1c(%ebp)
  8011c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011c5:	7f e7                	jg     8011ae <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8011c7:	e9 66 01 00 00       	jmp    801332 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8011cc:	83 ec 08             	sub    $0x8,%esp
  8011cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8011d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8011d5:	50                   	push   %eax
  8011d6:	e8 3c fd ff ff       	call   800f17 <getint>
  8011db:	83 c4 10             	add    $0x10,%esp
  8011de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8011e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ea:	85 d2                	test   %edx,%edx
  8011ec:	79 23                	jns    801211 <vprintfmt+0x29b>
				putch('-', putdat);
  8011ee:	83 ec 08             	sub    $0x8,%esp
  8011f1:	ff 75 0c             	pushl  0xc(%ebp)
  8011f4:	6a 2d                	push   $0x2d
  8011f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f9:	ff d0                	call   *%eax
  8011fb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8011fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801201:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801204:	f7 d8                	neg    %eax
  801206:	83 d2 00             	adc    $0x0,%edx
  801209:	f7 da                	neg    %edx
  80120b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80120e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801211:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801218:	e9 bc 00 00 00       	jmp    8012d9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80121d:	83 ec 08             	sub    $0x8,%esp
  801220:	ff 75 e8             	pushl  -0x18(%ebp)
  801223:	8d 45 14             	lea    0x14(%ebp),%eax
  801226:	50                   	push   %eax
  801227:	e8 84 fc ff ff       	call   800eb0 <getuint>
  80122c:	83 c4 10             	add    $0x10,%esp
  80122f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801232:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801235:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80123c:	e9 98 00 00 00       	jmp    8012d9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801241:	83 ec 08             	sub    $0x8,%esp
  801244:	ff 75 0c             	pushl  0xc(%ebp)
  801247:	6a 58                	push   $0x58
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	ff d0                	call   *%eax
  80124e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801251:	83 ec 08             	sub    $0x8,%esp
  801254:	ff 75 0c             	pushl  0xc(%ebp)
  801257:	6a 58                	push   $0x58
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	ff d0                	call   *%eax
  80125e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801261:	83 ec 08             	sub    $0x8,%esp
  801264:	ff 75 0c             	pushl  0xc(%ebp)
  801267:	6a 58                	push   $0x58
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	ff d0                	call   *%eax
  80126e:	83 c4 10             	add    $0x10,%esp
			break;
  801271:	e9 bc 00 00 00       	jmp    801332 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801276:	83 ec 08             	sub    $0x8,%esp
  801279:	ff 75 0c             	pushl  0xc(%ebp)
  80127c:	6a 30                	push   $0x30
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	ff d0                	call   *%eax
  801283:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801286:	83 ec 08             	sub    $0x8,%esp
  801289:	ff 75 0c             	pushl  0xc(%ebp)
  80128c:	6a 78                	push   $0x78
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	ff d0                	call   *%eax
  801293:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801296:	8b 45 14             	mov    0x14(%ebp),%eax
  801299:	83 c0 04             	add    $0x4,%eax
  80129c:	89 45 14             	mov    %eax,0x14(%ebp)
  80129f:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a2:	83 e8 04             	sub    $0x4,%eax
  8012a5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8012a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8012b1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8012b8:	eb 1f                	jmp    8012d9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8012ba:	83 ec 08             	sub    $0x8,%esp
  8012bd:	ff 75 e8             	pushl  -0x18(%ebp)
  8012c0:	8d 45 14             	lea    0x14(%ebp),%eax
  8012c3:	50                   	push   %eax
  8012c4:	e8 e7 fb ff ff       	call   800eb0 <getuint>
  8012c9:	83 c4 10             	add    $0x10,%esp
  8012cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8012d2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8012d9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8012dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012e0:	83 ec 04             	sub    $0x4,%esp
  8012e3:	52                   	push   %edx
  8012e4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8012e7:	50                   	push   %eax
  8012e8:	ff 75 f4             	pushl  -0xc(%ebp)
  8012eb:	ff 75 f0             	pushl  -0x10(%ebp)
  8012ee:	ff 75 0c             	pushl  0xc(%ebp)
  8012f1:	ff 75 08             	pushl  0x8(%ebp)
  8012f4:	e8 00 fb ff ff       	call   800df9 <printnum>
  8012f9:	83 c4 20             	add    $0x20,%esp
			break;
  8012fc:	eb 34                	jmp    801332 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8012fe:	83 ec 08             	sub    $0x8,%esp
  801301:	ff 75 0c             	pushl  0xc(%ebp)
  801304:	53                   	push   %ebx
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
  801308:	ff d0                	call   *%eax
  80130a:	83 c4 10             	add    $0x10,%esp
			break;
  80130d:	eb 23                	jmp    801332 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80130f:	83 ec 08             	sub    $0x8,%esp
  801312:	ff 75 0c             	pushl  0xc(%ebp)
  801315:	6a 25                	push   $0x25
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	ff d0                	call   *%eax
  80131c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80131f:	ff 4d 10             	decl   0x10(%ebp)
  801322:	eb 03                	jmp    801327 <vprintfmt+0x3b1>
  801324:	ff 4d 10             	decl   0x10(%ebp)
  801327:	8b 45 10             	mov    0x10(%ebp),%eax
  80132a:	48                   	dec    %eax
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	3c 25                	cmp    $0x25,%al
  80132f:	75 f3                	jne    801324 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801331:	90                   	nop
		}
	}
  801332:	e9 47 fc ff ff       	jmp    800f7e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801337:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801338:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80133b:	5b                   	pop    %ebx
  80133c:	5e                   	pop    %esi
  80133d:	5d                   	pop    %ebp
  80133e:	c3                   	ret    

0080133f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80133f:	55                   	push   %ebp
  801340:	89 e5                	mov    %esp,%ebp
  801342:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801345:	8d 45 10             	lea    0x10(%ebp),%eax
  801348:	83 c0 04             	add    $0x4,%eax
  80134b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80134e:	8b 45 10             	mov    0x10(%ebp),%eax
  801351:	ff 75 f4             	pushl  -0xc(%ebp)
  801354:	50                   	push   %eax
  801355:	ff 75 0c             	pushl  0xc(%ebp)
  801358:	ff 75 08             	pushl  0x8(%ebp)
  80135b:	e8 16 fc ff ff       	call   800f76 <vprintfmt>
  801360:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801363:	90                   	nop
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801369:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136c:	8b 40 08             	mov    0x8(%eax),%eax
  80136f:	8d 50 01             	lea    0x1(%eax),%edx
  801372:	8b 45 0c             	mov    0xc(%ebp),%eax
  801375:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137b:	8b 10                	mov    (%eax),%edx
  80137d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801380:	8b 40 04             	mov    0x4(%eax),%eax
  801383:	39 c2                	cmp    %eax,%edx
  801385:	73 12                	jae    801399 <sprintputch+0x33>
		*b->buf++ = ch;
  801387:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138a:	8b 00                	mov    (%eax),%eax
  80138c:	8d 48 01             	lea    0x1(%eax),%ecx
  80138f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801392:	89 0a                	mov    %ecx,(%edx)
  801394:	8b 55 08             	mov    0x8(%ebp),%edx
  801397:	88 10                	mov    %dl,(%eax)
}
  801399:	90                   	nop
  80139a:	5d                   	pop    %ebp
  80139b:	c3                   	ret    

0080139c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
  80139f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8013a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ab:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	01 d0                	add    %edx,%eax
  8013b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8013bd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013c1:	74 06                	je     8013c9 <vsnprintf+0x2d>
  8013c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013c7:	7f 07                	jg     8013d0 <vsnprintf+0x34>
		return -E_INVAL;
  8013c9:	b8 03 00 00 00       	mov    $0x3,%eax
  8013ce:	eb 20                	jmp    8013f0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8013d0:	ff 75 14             	pushl  0x14(%ebp)
  8013d3:	ff 75 10             	pushl  0x10(%ebp)
  8013d6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8013d9:	50                   	push   %eax
  8013da:	68 66 13 80 00       	push   $0x801366
  8013df:	e8 92 fb ff ff       	call   800f76 <vprintfmt>
  8013e4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8013e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013ea:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8013ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
  8013f5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8013f8:	8d 45 10             	lea    0x10(%ebp),%eax
  8013fb:	83 c0 04             	add    $0x4,%eax
  8013fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801401:	8b 45 10             	mov    0x10(%ebp),%eax
  801404:	ff 75 f4             	pushl  -0xc(%ebp)
  801407:	50                   	push   %eax
  801408:	ff 75 0c             	pushl  0xc(%ebp)
  80140b:	ff 75 08             	pushl  0x8(%ebp)
  80140e:	e8 89 ff ff ff       	call   80139c <vsnprintf>
  801413:	83 c4 10             	add    $0x10,%esp
  801416:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801419:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
  801421:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801424:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80142b:	eb 06                	jmp    801433 <strlen+0x15>
		n++;
  80142d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801430:	ff 45 08             	incl   0x8(%ebp)
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	84 c0                	test   %al,%al
  80143a:	75 f1                	jne    80142d <strlen+0xf>
		n++;
	return n;
  80143c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
  801444:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801447:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80144e:	eb 09                	jmp    801459 <strnlen+0x18>
		n++;
  801450:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801453:	ff 45 08             	incl   0x8(%ebp)
  801456:	ff 4d 0c             	decl   0xc(%ebp)
  801459:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80145d:	74 09                	je     801468 <strnlen+0x27>
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	84 c0                	test   %al,%al
  801466:	75 e8                	jne    801450 <strnlen+0xf>
		n++;
	return n;
  801468:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
  801470:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801479:	90                   	nop
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	8d 50 01             	lea    0x1(%eax),%edx
  801480:	89 55 08             	mov    %edx,0x8(%ebp)
  801483:	8b 55 0c             	mov    0xc(%ebp),%edx
  801486:	8d 4a 01             	lea    0x1(%edx),%ecx
  801489:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80148c:	8a 12                	mov    (%edx),%dl
  80148e:	88 10                	mov    %dl,(%eax)
  801490:	8a 00                	mov    (%eax),%al
  801492:	84 c0                	test   %al,%al
  801494:	75 e4                	jne    80147a <strcpy+0xd>
		/* do nothing */;
	return ret;
  801496:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
  80149e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ae:	eb 1f                	jmp    8014cf <strncpy+0x34>
		*dst++ = *src;
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	8d 50 01             	lea    0x1(%eax),%edx
  8014b6:	89 55 08             	mov    %edx,0x8(%ebp)
  8014b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bc:	8a 12                	mov    (%edx),%dl
  8014be:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	8a 00                	mov    (%eax),%al
  8014c5:	84 c0                	test   %al,%al
  8014c7:	74 03                	je     8014cc <strncpy+0x31>
			src++;
  8014c9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014cc:	ff 45 fc             	incl   -0x4(%ebp)
  8014cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014d5:	72 d9                	jb     8014b0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
  8014df:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ec:	74 30                	je     80151e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014ee:	eb 16                	jmp    801506 <strlcpy+0x2a>
			*dst++ = *src++;
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	8d 50 01             	lea    0x1(%eax),%edx
  8014f6:	89 55 08             	mov    %edx,0x8(%ebp)
  8014f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014fc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801502:	8a 12                	mov    (%edx),%dl
  801504:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801506:	ff 4d 10             	decl   0x10(%ebp)
  801509:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80150d:	74 09                	je     801518 <strlcpy+0x3c>
  80150f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801512:	8a 00                	mov    (%eax),%al
  801514:	84 c0                	test   %al,%al
  801516:	75 d8                	jne    8014f0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80151e:	8b 55 08             	mov    0x8(%ebp),%edx
  801521:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801524:	29 c2                	sub    %eax,%edx
  801526:	89 d0                	mov    %edx,%eax
}
  801528:	c9                   	leave  
  801529:	c3                   	ret    

0080152a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80152a:	55                   	push   %ebp
  80152b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80152d:	eb 06                	jmp    801535 <strcmp+0xb>
		p++, q++;
  80152f:	ff 45 08             	incl   0x8(%ebp)
  801532:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	8a 00                	mov    (%eax),%al
  80153a:	84 c0                	test   %al,%al
  80153c:	74 0e                	je     80154c <strcmp+0x22>
  80153e:	8b 45 08             	mov    0x8(%ebp),%eax
  801541:	8a 10                	mov    (%eax),%dl
  801543:	8b 45 0c             	mov    0xc(%ebp),%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	38 c2                	cmp    %al,%dl
  80154a:	74 e3                	je     80152f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	8a 00                	mov    (%eax),%al
  801551:	0f b6 d0             	movzbl %al,%edx
  801554:	8b 45 0c             	mov    0xc(%ebp),%eax
  801557:	8a 00                	mov    (%eax),%al
  801559:	0f b6 c0             	movzbl %al,%eax
  80155c:	29 c2                	sub    %eax,%edx
  80155e:	89 d0                	mov    %edx,%eax
}
  801560:	5d                   	pop    %ebp
  801561:	c3                   	ret    

00801562 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801565:	eb 09                	jmp    801570 <strncmp+0xe>
		n--, p++, q++;
  801567:	ff 4d 10             	decl   0x10(%ebp)
  80156a:	ff 45 08             	incl   0x8(%ebp)
  80156d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801570:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801574:	74 17                	je     80158d <strncmp+0x2b>
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	8a 00                	mov    (%eax),%al
  80157b:	84 c0                	test   %al,%al
  80157d:	74 0e                	je     80158d <strncmp+0x2b>
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	8a 10                	mov    (%eax),%dl
  801584:	8b 45 0c             	mov    0xc(%ebp),%eax
  801587:	8a 00                	mov    (%eax),%al
  801589:	38 c2                	cmp    %al,%dl
  80158b:	74 da                	je     801567 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80158d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801591:	75 07                	jne    80159a <strncmp+0x38>
		return 0;
  801593:	b8 00 00 00 00       	mov    $0x0,%eax
  801598:	eb 14                	jmp    8015ae <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	8a 00                	mov    (%eax),%al
  80159f:	0f b6 d0             	movzbl %al,%edx
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	0f b6 c0             	movzbl %al,%eax
  8015aa:	29 c2                	sub    %eax,%edx
  8015ac:	89 d0                	mov    %edx,%eax
}
  8015ae:	5d                   	pop    %ebp
  8015af:	c3                   	ret    

008015b0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
  8015b3:	83 ec 04             	sub    $0x4,%esp
  8015b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015bc:	eb 12                	jmp    8015d0 <strchr+0x20>
		if (*s == c)
  8015be:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c1:	8a 00                	mov    (%eax),%al
  8015c3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015c6:	75 05                	jne    8015cd <strchr+0x1d>
			return (char *) s;
  8015c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cb:	eb 11                	jmp    8015de <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015cd:	ff 45 08             	incl   0x8(%ebp)
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	8a 00                	mov    (%eax),%al
  8015d5:	84 c0                	test   %al,%al
  8015d7:	75 e5                	jne    8015be <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015de:	c9                   	leave  
  8015df:	c3                   	ret    

008015e0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015e0:	55                   	push   %ebp
  8015e1:	89 e5                	mov    %esp,%ebp
  8015e3:	83 ec 04             	sub    $0x4,%esp
  8015e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015ec:	eb 0d                	jmp    8015fb <strfind+0x1b>
		if (*s == c)
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	8a 00                	mov    (%eax),%al
  8015f3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015f6:	74 0e                	je     801606 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015f8:	ff 45 08             	incl   0x8(%ebp)
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	8a 00                	mov    (%eax),%al
  801600:	84 c0                	test   %al,%al
  801602:	75 ea                	jne    8015ee <strfind+0xe>
  801604:	eb 01                	jmp    801607 <strfind+0x27>
		if (*s == c)
			break;
  801606:	90                   	nop
	return (char *) s;
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
  80160f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801618:	8b 45 10             	mov    0x10(%ebp),%eax
  80161b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80161e:	eb 0e                	jmp    80162e <memset+0x22>
		*p++ = c;
  801620:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801623:	8d 50 01             	lea    0x1(%eax),%edx
  801626:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801629:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80162e:	ff 4d f8             	decl   -0x8(%ebp)
  801631:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801635:	79 e9                	jns    801620 <memset+0x14>
		*p++ = c;

	return v;
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
  80163f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801642:	8b 45 0c             	mov    0xc(%ebp),%eax
  801645:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801648:	8b 45 08             	mov    0x8(%ebp),%eax
  80164b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80164e:	eb 16                	jmp    801666 <memcpy+0x2a>
		*d++ = *s++;
  801650:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801653:	8d 50 01             	lea    0x1(%eax),%edx
  801656:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801659:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80165c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80165f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801662:	8a 12                	mov    (%edx),%dl
  801664:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801666:	8b 45 10             	mov    0x10(%ebp),%eax
  801669:	8d 50 ff             	lea    -0x1(%eax),%edx
  80166c:	89 55 10             	mov    %edx,0x10(%ebp)
  80166f:	85 c0                	test   %eax,%eax
  801671:	75 dd                	jne    801650 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
  80167b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  80167e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801681:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80168a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80168d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801690:	73 50                	jae    8016e2 <memmove+0x6a>
  801692:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801695:	8b 45 10             	mov    0x10(%ebp),%eax
  801698:	01 d0                	add    %edx,%eax
  80169a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80169d:	76 43                	jbe    8016e2 <memmove+0x6a>
		s += n;
  80169f:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016ab:	eb 10                	jmp    8016bd <memmove+0x45>
			*--d = *--s;
  8016ad:	ff 4d f8             	decl   -0x8(%ebp)
  8016b0:	ff 4d fc             	decl   -0x4(%ebp)
  8016b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b6:	8a 10                	mov    (%eax),%dl
  8016b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c6:	85 c0                	test   %eax,%eax
  8016c8:	75 e3                	jne    8016ad <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016ca:	eb 23                	jmp    8016ef <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016cf:	8d 50 01             	lea    0x1(%eax),%edx
  8016d2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016db:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016de:	8a 12                	mov    (%edx),%dl
  8016e0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016e8:	89 55 10             	mov    %edx,0x10(%ebp)
  8016eb:	85 c0                	test   %eax,%eax
  8016ed:	75 dd                	jne    8016cc <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
  8016f7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801700:	8b 45 0c             	mov    0xc(%ebp),%eax
  801703:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801706:	eb 2a                	jmp    801732 <memcmp+0x3e>
		if (*s1 != *s2)
  801708:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80170b:	8a 10                	mov    (%eax),%dl
  80170d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801710:	8a 00                	mov    (%eax),%al
  801712:	38 c2                	cmp    %al,%dl
  801714:	74 16                	je     80172c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801716:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801719:	8a 00                	mov    (%eax),%al
  80171b:	0f b6 d0             	movzbl %al,%edx
  80171e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801721:	8a 00                	mov    (%eax),%al
  801723:	0f b6 c0             	movzbl %al,%eax
  801726:	29 c2                	sub    %eax,%edx
  801728:	89 d0                	mov    %edx,%eax
  80172a:	eb 18                	jmp    801744 <memcmp+0x50>
		s1++, s2++;
  80172c:	ff 45 fc             	incl   -0x4(%ebp)
  80172f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801732:	8b 45 10             	mov    0x10(%ebp),%eax
  801735:	8d 50 ff             	lea    -0x1(%eax),%edx
  801738:	89 55 10             	mov    %edx,0x10(%ebp)
  80173b:	85 c0                	test   %eax,%eax
  80173d:	75 c9                	jne    801708 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80173f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
  801749:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80174c:	8b 55 08             	mov    0x8(%ebp),%edx
  80174f:	8b 45 10             	mov    0x10(%ebp),%eax
  801752:	01 d0                	add    %edx,%eax
  801754:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801757:	eb 15                	jmp    80176e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	8a 00                	mov    (%eax),%al
  80175e:	0f b6 d0             	movzbl %al,%edx
  801761:	8b 45 0c             	mov    0xc(%ebp),%eax
  801764:	0f b6 c0             	movzbl %al,%eax
  801767:	39 c2                	cmp    %eax,%edx
  801769:	74 0d                	je     801778 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80176b:	ff 45 08             	incl   0x8(%ebp)
  80176e:	8b 45 08             	mov    0x8(%ebp),%eax
  801771:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801774:	72 e3                	jb     801759 <memfind+0x13>
  801776:	eb 01                	jmp    801779 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801778:	90                   	nop
	return (void *) s;
  801779:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
  801781:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801784:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80178b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801792:	eb 03                	jmp    801797 <strtol+0x19>
		s++;
  801794:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801797:	8b 45 08             	mov    0x8(%ebp),%eax
  80179a:	8a 00                	mov    (%eax),%al
  80179c:	3c 20                	cmp    $0x20,%al
  80179e:	74 f4                	je     801794 <strtol+0x16>
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	8a 00                	mov    (%eax),%al
  8017a5:	3c 09                	cmp    $0x9,%al
  8017a7:	74 eb                	je     801794 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	3c 2b                	cmp    $0x2b,%al
  8017b0:	75 05                	jne    8017b7 <strtol+0x39>
		s++;
  8017b2:	ff 45 08             	incl   0x8(%ebp)
  8017b5:	eb 13                	jmp    8017ca <strtol+0x4c>
	else if (*s == '-')
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	8a 00                	mov    (%eax),%al
  8017bc:	3c 2d                	cmp    $0x2d,%al
  8017be:	75 0a                	jne    8017ca <strtol+0x4c>
		s++, neg = 1;
  8017c0:	ff 45 08             	incl   0x8(%ebp)
  8017c3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ce:	74 06                	je     8017d6 <strtol+0x58>
  8017d0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017d4:	75 20                	jne    8017f6 <strtol+0x78>
  8017d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d9:	8a 00                	mov    (%eax),%al
  8017db:	3c 30                	cmp    $0x30,%al
  8017dd:	75 17                	jne    8017f6 <strtol+0x78>
  8017df:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e2:	40                   	inc    %eax
  8017e3:	8a 00                	mov    (%eax),%al
  8017e5:	3c 78                	cmp    $0x78,%al
  8017e7:	75 0d                	jne    8017f6 <strtol+0x78>
		s += 2, base = 16;
  8017e9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017ed:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017f4:	eb 28                	jmp    80181e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017fa:	75 15                	jne    801811 <strtol+0x93>
  8017fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ff:	8a 00                	mov    (%eax),%al
  801801:	3c 30                	cmp    $0x30,%al
  801803:	75 0c                	jne    801811 <strtol+0x93>
		s++, base = 8;
  801805:	ff 45 08             	incl   0x8(%ebp)
  801808:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80180f:	eb 0d                	jmp    80181e <strtol+0xa0>
	else if (base == 0)
  801811:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801815:	75 07                	jne    80181e <strtol+0xa0>
		base = 10;
  801817:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80181e:	8b 45 08             	mov    0x8(%ebp),%eax
  801821:	8a 00                	mov    (%eax),%al
  801823:	3c 2f                	cmp    $0x2f,%al
  801825:	7e 19                	jle    801840 <strtol+0xc2>
  801827:	8b 45 08             	mov    0x8(%ebp),%eax
  80182a:	8a 00                	mov    (%eax),%al
  80182c:	3c 39                	cmp    $0x39,%al
  80182e:	7f 10                	jg     801840 <strtol+0xc2>
			dig = *s - '0';
  801830:	8b 45 08             	mov    0x8(%ebp),%eax
  801833:	8a 00                	mov    (%eax),%al
  801835:	0f be c0             	movsbl %al,%eax
  801838:	83 e8 30             	sub    $0x30,%eax
  80183b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80183e:	eb 42                	jmp    801882 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801840:	8b 45 08             	mov    0x8(%ebp),%eax
  801843:	8a 00                	mov    (%eax),%al
  801845:	3c 60                	cmp    $0x60,%al
  801847:	7e 19                	jle    801862 <strtol+0xe4>
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	8a 00                	mov    (%eax),%al
  80184e:	3c 7a                	cmp    $0x7a,%al
  801850:	7f 10                	jg     801862 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	8a 00                	mov    (%eax),%al
  801857:	0f be c0             	movsbl %al,%eax
  80185a:	83 e8 57             	sub    $0x57,%eax
  80185d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801860:	eb 20                	jmp    801882 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801862:	8b 45 08             	mov    0x8(%ebp),%eax
  801865:	8a 00                	mov    (%eax),%al
  801867:	3c 40                	cmp    $0x40,%al
  801869:	7e 39                	jle    8018a4 <strtol+0x126>
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	8a 00                	mov    (%eax),%al
  801870:	3c 5a                	cmp    $0x5a,%al
  801872:	7f 30                	jg     8018a4 <strtol+0x126>
			dig = *s - 'A' + 10;
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	8a 00                	mov    (%eax),%al
  801879:	0f be c0             	movsbl %al,%eax
  80187c:	83 e8 37             	sub    $0x37,%eax
  80187f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801882:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801885:	3b 45 10             	cmp    0x10(%ebp),%eax
  801888:	7d 19                	jge    8018a3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80188a:	ff 45 08             	incl   0x8(%ebp)
  80188d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801890:	0f af 45 10          	imul   0x10(%ebp),%eax
  801894:	89 c2                	mov    %eax,%edx
  801896:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801899:	01 d0                	add    %edx,%eax
  80189b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80189e:	e9 7b ff ff ff       	jmp    80181e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018a3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018a4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018a8:	74 08                	je     8018b2 <strtol+0x134>
		*endptr = (char *) s;
  8018aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8018b0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018b6:	74 07                	je     8018bf <strtol+0x141>
  8018b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018bb:	f7 d8                	neg    %eax
  8018bd:	eb 03                	jmp    8018c2 <strtol+0x144>
  8018bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <ltostr>:

void
ltostr(long value, char *str)
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
  8018c7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018dc:	79 13                	jns    8018f1 <ltostr+0x2d>
	{
		neg = 1;
  8018de:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018eb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018ee:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018f9:	99                   	cltd   
  8018fa:	f7 f9                	idiv   %ecx
  8018fc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801902:	8d 50 01             	lea    0x1(%eax),%edx
  801905:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801908:	89 c2                	mov    %eax,%edx
  80190a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80190d:	01 d0                	add    %edx,%eax
  80190f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801912:	83 c2 30             	add    $0x30,%edx
  801915:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801917:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80191a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80191f:	f7 e9                	imul   %ecx
  801921:	c1 fa 02             	sar    $0x2,%edx
  801924:	89 c8                	mov    %ecx,%eax
  801926:	c1 f8 1f             	sar    $0x1f,%eax
  801929:	29 c2                	sub    %eax,%edx
  80192b:	89 d0                	mov    %edx,%eax
  80192d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801930:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801933:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801938:	f7 e9                	imul   %ecx
  80193a:	c1 fa 02             	sar    $0x2,%edx
  80193d:	89 c8                	mov    %ecx,%eax
  80193f:	c1 f8 1f             	sar    $0x1f,%eax
  801942:	29 c2                	sub    %eax,%edx
  801944:	89 d0                	mov    %edx,%eax
  801946:	c1 e0 02             	shl    $0x2,%eax
  801949:	01 d0                	add    %edx,%eax
  80194b:	01 c0                	add    %eax,%eax
  80194d:	29 c1                	sub    %eax,%ecx
  80194f:	89 ca                	mov    %ecx,%edx
  801951:	85 d2                	test   %edx,%edx
  801953:	75 9c                	jne    8018f1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801955:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80195c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195f:	48                   	dec    %eax
  801960:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801963:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801967:	74 3d                	je     8019a6 <ltostr+0xe2>
		start = 1 ;
  801969:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801970:	eb 34                	jmp    8019a6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801972:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801975:	8b 45 0c             	mov    0xc(%ebp),%eax
  801978:	01 d0                	add    %edx,%eax
  80197a:	8a 00                	mov    (%eax),%al
  80197c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80197f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801982:	8b 45 0c             	mov    0xc(%ebp),%eax
  801985:	01 c2                	add    %eax,%edx
  801987:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80198a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198d:	01 c8                	add    %ecx,%eax
  80198f:	8a 00                	mov    (%eax),%al
  801991:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801993:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801996:	8b 45 0c             	mov    0xc(%ebp),%eax
  801999:	01 c2                	add    %eax,%edx
  80199b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80199e:	88 02                	mov    %al,(%edx)
		start++ ;
  8019a0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019a3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019ac:	7c c4                	jl     801972 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019ae:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b4:	01 d0                	add    %edx,%eax
  8019b6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019b9:	90                   	nop
  8019ba:	c9                   	leave  
  8019bb:	c3                   	ret    

008019bc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019bc:	55                   	push   %ebp
  8019bd:	89 e5                	mov    %esp,%ebp
  8019bf:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019c2:	ff 75 08             	pushl  0x8(%ebp)
  8019c5:	e8 54 fa ff ff       	call   80141e <strlen>
  8019ca:	83 c4 04             	add    $0x4,%esp
  8019cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019d0:	ff 75 0c             	pushl  0xc(%ebp)
  8019d3:	e8 46 fa ff ff       	call   80141e <strlen>
  8019d8:	83 c4 04             	add    $0x4,%esp
  8019db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019ec:	eb 17                	jmp    801a05 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f4:	01 c2                	add    %eax,%edx
  8019f6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fc:	01 c8                	add    %ecx,%eax
  8019fe:	8a 00                	mov    (%eax),%al
  801a00:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a02:	ff 45 fc             	incl   -0x4(%ebp)
  801a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a0b:	7c e1                	jl     8019ee <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a0d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a14:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a1b:	eb 1f                	jmp    801a3c <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a20:	8d 50 01             	lea    0x1(%eax),%edx
  801a23:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a26:	89 c2                	mov    %eax,%edx
  801a28:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2b:	01 c2                	add    %eax,%edx
  801a2d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a30:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a33:	01 c8                	add    %ecx,%eax
  801a35:	8a 00                	mov    (%eax),%al
  801a37:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a39:	ff 45 f8             	incl   -0x8(%ebp)
  801a3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a42:	7c d9                	jl     801a1d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a44:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a47:	8b 45 10             	mov    0x10(%ebp),%eax
  801a4a:	01 d0                	add    %edx,%eax
  801a4c:	c6 00 00             	movb   $0x0,(%eax)
}
  801a4f:	90                   	nop
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a55:	8b 45 14             	mov    0x14(%ebp),%eax
  801a58:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a5e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a61:	8b 00                	mov    (%eax),%eax
  801a63:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a6a:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6d:	01 d0                	add    %edx,%eax
  801a6f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a75:	eb 0c                	jmp    801a83 <strsplit+0x31>
			*string++ = 0;
  801a77:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7a:	8d 50 01             	lea    0x1(%eax),%edx
  801a7d:	89 55 08             	mov    %edx,0x8(%ebp)
  801a80:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	8a 00                	mov    (%eax),%al
  801a88:	84 c0                	test   %al,%al
  801a8a:	74 18                	je     801aa4 <strsplit+0x52>
  801a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8f:	8a 00                	mov    (%eax),%al
  801a91:	0f be c0             	movsbl %al,%eax
  801a94:	50                   	push   %eax
  801a95:	ff 75 0c             	pushl  0xc(%ebp)
  801a98:	e8 13 fb ff ff       	call   8015b0 <strchr>
  801a9d:	83 c4 08             	add    $0x8,%esp
  801aa0:	85 c0                	test   %eax,%eax
  801aa2:	75 d3                	jne    801a77 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa7:	8a 00                	mov    (%eax),%al
  801aa9:	84 c0                	test   %al,%al
  801aab:	74 5a                	je     801b07 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801aad:	8b 45 14             	mov    0x14(%ebp),%eax
  801ab0:	8b 00                	mov    (%eax),%eax
  801ab2:	83 f8 0f             	cmp    $0xf,%eax
  801ab5:	75 07                	jne    801abe <strsplit+0x6c>
		{
			return 0;
  801ab7:	b8 00 00 00 00       	mov    $0x0,%eax
  801abc:	eb 66                	jmp    801b24 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801abe:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac1:	8b 00                	mov    (%eax),%eax
  801ac3:	8d 48 01             	lea    0x1(%eax),%ecx
  801ac6:	8b 55 14             	mov    0x14(%ebp),%edx
  801ac9:	89 0a                	mov    %ecx,(%edx)
  801acb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ad2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad5:	01 c2                	add    %eax,%edx
  801ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ada:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801adc:	eb 03                	jmp    801ae1 <strsplit+0x8f>
			string++;
  801ade:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	8a 00                	mov    (%eax),%al
  801ae6:	84 c0                	test   %al,%al
  801ae8:	74 8b                	je     801a75 <strsplit+0x23>
  801aea:	8b 45 08             	mov    0x8(%ebp),%eax
  801aed:	8a 00                	mov    (%eax),%al
  801aef:	0f be c0             	movsbl %al,%eax
  801af2:	50                   	push   %eax
  801af3:	ff 75 0c             	pushl  0xc(%ebp)
  801af6:	e8 b5 fa ff ff       	call   8015b0 <strchr>
  801afb:	83 c4 08             	add    $0x8,%esp
  801afe:	85 c0                	test   %eax,%eax
  801b00:	74 dc                	je     801ade <strsplit+0x8c>
			string++;
	}
  801b02:	e9 6e ff ff ff       	jmp    801a75 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b07:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b08:	8b 45 14             	mov    0x14(%ebp),%eax
  801b0b:	8b 00                	mov    (%eax),%eax
  801b0d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b14:	8b 45 10             	mov    0x10(%ebp),%eax
  801b17:	01 d0                	add    %edx,%eax
  801b19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b1f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b24:	c9                   	leave  
  801b25:	c3                   	ret    

00801b26 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b26:	55                   	push   %ebp
  801b27:	89 e5                	mov    %esp,%ebp
  801b29:	83 ec 18             	sub    $0x18,%esp
  801b2c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b2f:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801b32:	83 ec 04             	sub    $0x4,%esp
  801b35:	68 30 2d 80 00       	push   $0x802d30
  801b3a:	6a 17                	push   $0x17
  801b3c:	68 4f 2d 80 00       	push   $0x802d4f
  801b41:	e8 a2 ef ff ff       	call   800ae8 <_panic>

00801b46 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b46:	55                   	push   %ebp
  801b47:	89 e5                	mov    %esp,%ebp
  801b49:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801b4c:	83 ec 04             	sub    $0x4,%esp
  801b4f:	68 5b 2d 80 00       	push   $0x802d5b
  801b54:	6a 2f                	push   $0x2f
  801b56:	68 4f 2d 80 00       	push   $0x802d4f
  801b5b:	e8 88 ef ff ff       	call   800ae8 <_panic>

00801b60 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
  801b63:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801b66:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801b6d:	8b 55 08             	mov    0x8(%ebp),%edx
  801b70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b73:	01 d0                	add    %edx,%eax
  801b75:	48                   	dec    %eax
  801b76:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801b79:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b7c:	ba 00 00 00 00       	mov    $0x0,%edx
  801b81:	f7 75 ec             	divl   -0x14(%ebp)
  801b84:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b87:	29 d0                	sub    %edx,%eax
  801b89:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8f:	c1 e8 0c             	shr    $0xc,%eax
  801b92:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801b95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b9c:	e9 c8 00 00 00       	jmp    801c69 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801ba1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ba8:	eb 27                	jmp    801bd1 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801baa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bb0:	01 c2                	add    %eax,%edx
  801bb2:	89 d0                	mov    %edx,%eax
  801bb4:	01 c0                	add    %eax,%eax
  801bb6:	01 d0                	add    %edx,%eax
  801bb8:	c1 e0 02             	shl    $0x2,%eax
  801bbb:	05 48 30 80 00       	add    $0x803048,%eax
  801bc0:	8b 00                	mov    (%eax),%eax
  801bc2:	85 c0                	test   %eax,%eax
  801bc4:	74 08                	je     801bce <malloc+0x6e>
            	i += j;
  801bc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bc9:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801bcc:	eb 0b                	jmp    801bd9 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801bce:	ff 45 f0             	incl   -0x10(%ebp)
  801bd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bd4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bd7:	72 d1                	jb     801baa <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801bd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bdc:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801bdf:	0f 85 81 00 00 00    	jne    801c66 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be8:	05 00 00 08 00       	add    $0x80000,%eax
  801bed:	c1 e0 0c             	shl    $0xc,%eax
  801bf0:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801bf3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801bfa:	eb 1f                	jmp    801c1b <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801bfc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c02:	01 c2                	add    %eax,%edx
  801c04:	89 d0                	mov    %edx,%eax
  801c06:	01 c0                	add    %eax,%eax
  801c08:	01 d0                	add    %edx,%eax
  801c0a:	c1 e0 02             	shl    $0x2,%eax
  801c0d:	05 48 30 80 00       	add    $0x803048,%eax
  801c12:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801c18:	ff 45 f0             	incl   -0x10(%ebp)
  801c1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c1e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801c21:	72 d9                	jb     801bfc <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801c23:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c26:	89 d0                	mov    %edx,%eax
  801c28:	01 c0                	add    %eax,%eax
  801c2a:	01 d0                	add    %edx,%eax
  801c2c:	c1 e0 02             	shl    $0x2,%eax
  801c2f:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801c35:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c38:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801c3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c3d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801c40:	89 c8                	mov    %ecx,%eax
  801c42:	01 c0                	add    %eax,%eax
  801c44:	01 c8                	add    %ecx,%eax
  801c46:	c1 e0 02             	shl    $0x2,%eax
  801c49:	05 44 30 80 00       	add    $0x803044,%eax
  801c4e:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801c50:	83 ec 08             	sub    $0x8,%esp
  801c53:	ff 75 08             	pushl  0x8(%ebp)
  801c56:	ff 75 e0             	pushl  -0x20(%ebp)
  801c59:	e8 2b 03 00 00       	call   801f89 <sys_allocateMem>
  801c5e:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801c61:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c64:	eb 19                	jmp    801c7f <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801c66:	ff 45 f4             	incl   -0xc(%ebp)
  801c69:	a1 04 30 80 00       	mov    0x803004,%eax
  801c6e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801c71:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c74:	0f 83 27 ff ff ff    	jae    801ba1 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801c7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    

00801c81 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c81:	55                   	push   %ebp
  801c82:	89 e5                	mov    %esp,%ebp
  801c84:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801c87:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c8b:	0f 84 e5 00 00 00    	je     801d76 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9a:	05 00 00 00 80       	add    $0x80000000,%eax
  801c9f:	c1 e8 0c             	shr    $0xc,%eax
  801ca2:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801ca5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ca8:	89 d0                	mov    %edx,%eax
  801caa:	01 c0                	add    %eax,%eax
  801cac:	01 d0                	add    %edx,%eax
  801cae:	c1 e0 02             	shl    $0x2,%eax
  801cb1:	05 40 30 80 00       	add    $0x803040,%eax
  801cb6:	8b 00                	mov    (%eax),%eax
  801cb8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801cbb:	0f 85 b8 00 00 00    	jne    801d79 <free+0xf8>
  801cc1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801cc4:	89 d0                	mov    %edx,%eax
  801cc6:	01 c0                	add    %eax,%eax
  801cc8:	01 d0                	add    %edx,%eax
  801cca:	c1 e0 02             	shl    $0x2,%eax
  801ccd:	05 48 30 80 00       	add    $0x803048,%eax
  801cd2:	8b 00                	mov    (%eax),%eax
  801cd4:	85 c0                	test   %eax,%eax
  801cd6:	0f 84 9d 00 00 00    	je     801d79 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801cdc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801cdf:	89 d0                	mov    %edx,%eax
  801ce1:	01 c0                	add    %eax,%eax
  801ce3:	01 d0                	add    %edx,%eax
  801ce5:	c1 e0 02             	shl    $0x2,%eax
  801ce8:	05 44 30 80 00       	add    $0x803044,%eax
  801ced:	8b 00                	mov    (%eax),%eax
  801cef:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801cf2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cf5:	c1 e0 0c             	shl    $0xc,%eax
  801cf8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801cfb:	83 ec 08             	sub    $0x8,%esp
  801cfe:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d01:	ff 75 f0             	pushl  -0x10(%ebp)
  801d04:	e8 64 02 00 00       	call   801f6d <sys_freeMem>
  801d09:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801d0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d13:	eb 57                	jmp    801d6c <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801d15:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d1b:	01 c2                	add    %eax,%edx
  801d1d:	89 d0                	mov    %edx,%eax
  801d1f:	01 c0                	add    %eax,%eax
  801d21:	01 d0                	add    %edx,%eax
  801d23:	c1 e0 02             	shl    $0x2,%eax
  801d26:	05 48 30 80 00       	add    $0x803048,%eax
  801d2b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801d31:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d37:	01 c2                	add    %eax,%edx
  801d39:	89 d0                	mov    %edx,%eax
  801d3b:	01 c0                	add    %eax,%eax
  801d3d:	01 d0                	add    %edx,%eax
  801d3f:	c1 e0 02             	shl    $0x2,%eax
  801d42:	05 40 30 80 00       	add    $0x803040,%eax
  801d47:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801d4d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d53:	01 c2                	add    %eax,%edx
  801d55:	89 d0                	mov    %edx,%eax
  801d57:	01 c0                	add    %eax,%eax
  801d59:	01 d0                	add    %edx,%eax
  801d5b:	c1 e0 02             	shl    $0x2,%eax
  801d5e:	05 44 30 80 00       	add    $0x803044,%eax
  801d63:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801d69:	ff 45 f4             	incl   -0xc(%ebp)
  801d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d6f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d72:	7c a1                	jl     801d15 <free+0x94>
  801d74:	eb 04                	jmp    801d7a <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801d76:	90                   	nop
  801d77:	eb 01                	jmp    801d7a <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801d79:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
  801d7f:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801d82:	83 ec 04             	sub    $0x4,%esp
  801d85:	68 78 2d 80 00       	push   $0x802d78
  801d8a:	68 ae 00 00 00       	push   $0xae
  801d8f:	68 4f 2d 80 00       	push   $0x802d4f
  801d94:	e8 4f ed ff ff       	call   800ae8 <_panic>

00801d99 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
  801d9c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801d9f:	83 ec 04             	sub    $0x4,%esp
  801da2:	68 98 2d 80 00       	push   $0x802d98
  801da7:	68 ca 00 00 00       	push   $0xca
  801dac:	68 4f 2d 80 00       	push   $0x802d4f
  801db1:	e8 32 ed ff ff       	call   800ae8 <_panic>

00801db6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
  801db9:	57                   	push   %edi
  801dba:	56                   	push   %esi
  801dbb:	53                   	push   %ebx
  801dbc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dc8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dcb:	8b 7d 18             	mov    0x18(%ebp),%edi
  801dce:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801dd1:	cd 30                	int    $0x30
  801dd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801dd9:	83 c4 10             	add    $0x10,%esp
  801ddc:	5b                   	pop    %ebx
  801ddd:	5e                   	pop    %esi
  801dde:	5f                   	pop    %edi
  801ddf:	5d                   	pop    %ebp
  801de0:	c3                   	ret    

00801de1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801de1:	55                   	push   %ebp
  801de2:	89 e5                	mov    %esp,%ebp
  801de4:	83 ec 04             	sub    $0x4,%esp
  801de7:	8b 45 10             	mov    0x10(%ebp),%eax
  801dea:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ded:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801df1:	8b 45 08             	mov    0x8(%ebp),%eax
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	52                   	push   %edx
  801df9:	ff 75 0c             	pushl  0xc(%ebp)
  801dfc:	50                   	push   %eax
  801dfd:	6a 00                	push   $0x0
  801dff:	e8 b2 ff ff ff       	call   801db6 <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
}
  801e07:	90                   	nop
  801e08:	c9                   	leave  
  801e09:	c3                   	ret    

00801e0a <sys_cgetc>:

int
sys_cgetc(void)
{
  801e0a:	55                   	push   %ebp
  801e0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 01                	push   $0x1
  801e19:	e8 98 ff ff ff       	call   801db6 <syscall>
  801e1e:	83 c4 18             	add    $0x18,%esp
}
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e26:	8b 45 08             	mov    0x8(%ebp),%eax
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	50                   	push   %eax
  801e32:	6a 05                	push   $0x5
  801e34:	e8 7d ff ff ff       	call   801db6 <syscall>
  801e39:	83 c4 18             	add    $0x18,%esp
}
  801e3c:	c9                   	leave  
  801e3d:	c3                   	ret    

00801e3e <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e3e:	55                   	push   %ebp
  801e3f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 02                	push   $0x2
  801e4d:	e8 64 ff ff ff       	call   801db6 <syscall>
  801e52:	83 c4 18             	add    $0x18,%esp
}
  801e55:	c9                   	leave  
  801e56:	c3                   	ret    

00801e57 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e57:	55                   	push   %ebp
  801e58:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 03                	push   $0x3
  801e66:	e8 4b ff ff ff       	call   801db6 <syscall>
  801e6b:	83 c4 18             	add    $0x18,%esp
}
  801e6e:	c9                   	leave  
  801e6f:	c3                   	ret    

00801e70 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e70:	55                   	push   %ebp
  801e71:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 04                	push   $0x4
  801e7f:	e8 32 ff ff ff       	call   801db6 <syscall>
  801e84:	83 c4 18             	add    $0x18,%esp
}
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <sys_env_exit>:


void sys_env_exit(void)
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 06                	push   $0x6
  801e98:	e8 19 ff ff ff       	call   801db6 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	90                   	nop
  801ea1:	c9                   	leave  
  801ea2:	c3                   	ret    

00801ea3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ea3:	55                   	push   %ebp
  801ea4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ea6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	52                   	push   %edx
  801eb3:	50                   	push   %eax
  801eb4:	6a 07                	push   $0x7
  801eb6:	e8 fb fe ff ff       	call   801db6 <syscall>
  801ebb:	83 c4 18             	add    $0x18,%esp
}
  801ebe:	c9                   	leave  
  801ebf:	c3                   	ret    

00801ec0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ec0:	55                   	push   %ebp
  801ec1:	89 e5                	mov    %esp,%ebp
  801ec3:	56                   	push   %esi
  801ec4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ec5:	8b 75 18             	mov    0x18(%ebp),%esi
  801ec8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ecb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ece:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed4:	56                   	push   %esi
  801ed5:	53                   	push   %ebx
  801ed6:	51                   	push   %ecx
  801ed7:	52                   	push   %edx
  801ed8:	50                   	push   %eax
  801ed9:	6a 08                	push   $0x8
  801edb:	e8 d6 fe ff ff       	call   801db6 <syscall>
  801ee0:	83 c4 18             	add    $0x18,%esp
}
  801ee3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ee6:	5b                   	pop    %ebx
  801ee7:	5e                   	pop    %esi
  801ee8:	5d                   	pop    %ebp
  801ee9:	c3                   	ret    

00801eea <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801eea:	55                   	push   %ebp
  801eeb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801eed:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	52                   	push   %edx
  801efa:	50                   	push   %eax
  801efb:	6a 09                	push   $0x9
  801efd:	e8 b4 fe ff ff       	call   801db6 <syscall>
  801f02:	83 c4 18             	add    $0x18,%esp
}
  801f05:	c9                   	leave  
  801f06:	c3                   	ret    

00801f07 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f07:	55                   	push   %ebp
  801f08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	ff 75 0c             	pushl  0xc(%ebp)
  801f13:	ff 75 08             	pushl  0x8(%ebp)
  801f16:	6a 0a                	push   $0xa
  801f18:	e8 99 fe ff ff       	call   801db6 <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	c9                   	leave  
  801f21:	c3                   	ret    

00801f22 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f22:	55                   	push   %ebp
  801f23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 0b                	push   $0xb
  801f31:	e8 80 fe ff ff       	call   801db6 <syscall>
  801f36:	83 c4 18             	add    $0x18,%esp
}
  801f39:	c9                   	leave  
  801f3a:	c3                   	ret    

00801f3b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f3b:	55                   	push   %ebp
  801f3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 0c                	push   $0xc
  801f4a:	e8 67 fe ff ff       	call   801db6 <syscall>
  801f4f:	83 c4 18             	add    $0x18,%esp
}
  801f52:	c9                   	leave  
  801f53:	c3                   	ret    

00801f54 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f54:	55                   	push   %ebp
  801f55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 0d                	push   $0xd
  801f63:	e8 4e fe ff ff       	call   801db6 <syscall>
  801f68:	83 c4 18             	add    $0x18,%esp
}
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	ff 75 0c             	pushl  0xc(%ebp)
  801f79:	ff 75 08             	pushl  0x8(%ebp)
  801f7c:	6a 11                	push   $0x11
  801f7e:	e8 33 fe ff ff       	call   801db6 <syscall>
  801f83:	83 c4 18             	add    $0x18,%esp
	return;
  801f86:	90                   	nop
}
  801f87:	c9                   	leave  
  801f88:	c3                   	ret    

00801f89 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	ff 75 0c             	pushl  0xc(%ebp)
  801f95:	ff 75 08             	pushl  0x8(%ebp)
  801f98:	6a 12                	push   $0x12
  801f9a:	e8 17 fe ff ff       	call   801db6 <syscall>
  801f9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa2:	90                   	nop
}
  801fa3:	c9                   	leave  
  801fa4:	c3                   	ret    

00801fa5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801fa5:	55                   	push   %ebp
  801fa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 0e                	push   $0xe
  801fb4:	e8 fd fd ff ff       	call   801db6 <syscall>
  801fb9:	83 c4 18             	add    $0x18,%esp
}
  801fbc:	c9                   	leave  
  801fbd:	c3                   	ret    

00801fbe <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fbe:	55                   	push   %ebp
  801fbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	ff 75 08             	pushl  0x8(%ebp)
  801fcc:	6a 0f                	push   $0xf
  801fce:	e8 e3 fd ff ff       	call   801db6 <syscall>
  801fd3:	83 c4 18             	add    $0x18,%esp
}
  801fd6:	c9                   	leave  
  801fd7:	c3                   	ret    

00801fd8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fd8:	55                   	push   %ebp
  801fd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 10                	push   $0x10
  801fe7:	e8 ca fd ff ff       	call   801db6 <syscall>
  801fec:	83 c4 18             	add    $0x18,%esp
}
  801fef:	90                   	nop
  801ff0:	c9                   	leave  
  801ff1:	c3                   	ret    

00801ff2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ff2:	55                   	push   %ebp
  801ff3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 14                	push   $0x14
  802001:	e8 b0 fd ff ff       	call   801db6 <syscall>
  802006:	83 c4 18             	add    $0x18,%esp
}
  802009:	90                   	nop
  80200a:	c9                   	leave  
  80200b:	c3                   	ret    

0080200c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80200c:	55                   	push   %ebp
  80200d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 15                	push   $0x15
  80201b:	e8 96 fd ff ff       	call   801db6 <syscall>
  802020:	83 c4 18             	add    $0x18,%esp
}
  802023:	90                   	nop
  802024:	c9                   	leave  
  802025:	c3                   	ret    

00802026 <sys_cputc>:


void
sys_cputc(const char c)
{
  802026:	55                   	push   %ebp
  802027:	89 e5                	mov    %esp,%ebp
  802029:	83 ec 04             	sub    $0x4,%esp
  80202c:	8b 45 08             	mov    0x8(%ebp),%eax
  80202f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802032:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	50                   	push   %eax
  80203f:	6a 16                	push   $0x16
  802041:	e8 70 fd ff ff       	call   801db6 <syscall>
  802046:	83 c4 18             	add    $0x18,%esp
}
  802049:	90                   	nop
  80204a:	c9                   	leave  
  80204b:	c3                   	ret    

0080204c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80204c:	55                   	push   %ebp
  80204d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	6a 00                	push   $0x0
  802059:	6a 17                	push   $0x17
  80205b:	e8 56 fd ff ff       	call   801db6 <syscall>
  802060:	83 c4 18             	add    $0x18,%esp
}
  802063:	90                   	nop
  802064:	c9                   	leave  
  802065:	c3                   	ret    

00802066 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802066:	55                   	push   %ebp
  802067:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802069:	8b 45 08             	mov    0x8(%ebp),%eax
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	ff 75 0c             	pushl  0xc(%ebp)
  802075:	50                   	push   %eax
  802076:	6a 18                	push   $0x18
  802078:	e8 39 fd ff ff       	call   801db6 <syscall>
  80207d:	83 c4 18             	add    $0x18,%esp
}
  802080:	c9                   	leave  
  802081:	c3                   	ret    

00802082 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802082:	55                   	push   %ebp
  802083:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802085:	8b 55 0c             	mov    0xc(%ebp),%edx
  802088:	8b 45 08             	mov    0x8(%ebp),%eax
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	52                   	push   %edx
  802092:	50                   	push   %eax
  802093:	6a 1b                	push   $0x1b
  802095:	e8 1c fd ff ff       	call   801db6 <syscall>
  80209a:	83 c4 18             	add    $0x18,%esp
}
  80209d:	c9                   	leave  
  80209e:	c3                   	ret    

0080209f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80209f:	55                   	push   %ebp
  8020a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	52                   	push   %edx
  8020af:	50                   	push   %eax
  8020b0:	6a 19                	push   $0x19
  8020b2:	e8 ff fc ff ff       	call   801db6 <syscall>
  8020b7:	83 c4 18             	add    $0x18,%esp
}
  8020ba:	90                   	nop
  8020bb:	c9                   	leave  
  8020bc:	c3                   	ret    

008020bd <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020bd:	55                   	push   %ebp
  8020be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c6:	6a 00                	push   $0x0
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	52                   	push   %edx
  8020cd:	50                   	push   %eax
  8020ce:	6a 1a                	push   $0x1a
  8020d0:	e8 e1 fc ff ff       	call   801db6 <syscall>
  8020d5:	83 c4 18             	add    $0x18,%esp
}
  8020d8:	90                   	nop
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
  8020de:	83 ec 04             	sub    $0x4,%esp
  8020e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8020e4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020e7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020ea:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f1:	6a 00                	push   $0x0
  8020f3:	51                   	push   %ecx
  8020f4:	52                   	push   %edx
  8020f5:	ff 75 0c             	pushl  0xc(%ebp)
  8020f8:	50                   	push   %eax
  8020f9:	6a 1c                	push   $0x1c
  8020fb:	e8 b6 fc ff ff       	call   801db6 <syscall>
  802100:	83 c4 18             	add    $0x18,%esp
}
  802103:	c9                   	leave  
  802104:	c3                   	ret    

00802105 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802105:	55                   	push   %ebp
  802106:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802108:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210b:	8b 45 08             	mov    0x8(%ebp),%eax
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	52                   	push   %edx
  802115:	50                   	push   %eax
  802116:	6a 1d                	push   $0x1d
  802118:	e8 99 fc ff ff       	call   801db6 <syscall>
  80211d:	83 c4 18             	add    $0x18,%esp
}
  802120:	c9                   	leave  
  802121:	c3                   	ret    

00802122 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802122:	55                   	push   %ebp
  802123:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802125:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802128:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212b:	8b 45 08             	mov    0x8(%ebp),%eax
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	51                   	push   %ecx
  802133:	52                   	push   %edx
  802134:	50                   	push   %eax
  802135:	6a 1e                	push   $0x1e
  802137:	e8 7a fc ff ff       	call   801db6 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802144:	8b 55 0c             	mov    0xc(%ebp),%edx
  802147:	8b 45 08             	mov    0x8(%ebp),%eax
  80214a:	6a 00                	push   $0x0
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	52                   	push   %edx
  802151:	50                   	push   %eax
  802152:	6a 1f                	push   $0x1f
  802154:	e8 5d fc ff ff       	call   801db6 <syscall>
  802159:	83 c4 18             	add    $0x18,%esp
}
  80215c:	c9                   	leave  
  80215d:	c3                   	ret    

0080215e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 20                	push   $0x20
  80216d:	e8 44 fc ff ff       	call   801db6 <syscall>
  802172:	83 c4 18             	add    $0x18,%esp
}
  802175:	c9                   	leave  
  802176:	c3                   	ret    

00802177 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802177:	55                   	push   %ebp
  802178:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80217a:	8b 45 08             	mov    0x8(%ebp),%eax
  80217d:	6a 00                	push   $0x0
  80217f:	6a 00                	push   $0x0
  802181:	ff 75 10             	pushl  0x10(%ebp)
  802184:	ff 75 0c             	pushl  0xc(%ebp)
  802187:	50                   	push   %eax
  802188:	6a 21                	push   $0x21
  80218a:	e8 27 fc ff ff       	call   801db6 <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	c9                   	leave  
  802193:	c3                   	ret    

00802194 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802194:	55                   	push   %ebp
  802195:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802197:	8b 45 08             	mov    0x8(%ebp),%eax
  80219a:	6a 00                	push   $0x0
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	50                   	push   %eax
  8021a3:	6a 22                	push   $0x22
  8021a5:	e8 0c fc ff ff       	call   801db6 <syscall>
  8021aa:	83 c4 18             	add    $0x18,%esp
}
  8021ad:	90                   	nop
  8021ae:	c9                   	leave  
  8021af:	c3                   	ret    

008021b0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021b0:	55                   	push   %ebp
  8021b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 00                	push   $0x0
  8021be:	50                   	push   %eax
  8021bf:	6a 23                	push   $0x23
  8021c1:	e8 f0 fb ff ff       	call   801db6 <syscall>
  8021c6:	83 c4 18             	add    $0x18,%esp
}
  8021c9:	90                   	nop
  8021ca:	c9                   	leave  
  8021cb:	c3                   	ret    

008021cc <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021cc:	55                   	push   %ebp
  8021cd:	89 e5                	mov    %esp,%ebp
  8021cf:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021d2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021d5:	8d 50 04             	lea    0x4(%eax),%edx
  8021d8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	52                   	push   %edx
  8021e2:	50                   	push   %eax
  8021e3:	6a 24                	push   $0x24
  8021e5:	e8 cc fb ff ff       	call   801db6 <syscall>
  8021ea:	83 c4 18             	add    $0x18,%esp
	return result;
  8021ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021f6:	89 01                	mov    %eax,(%ecx)
  8021f8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fe:	c9                   	leave  
  8021ff:	c2 04 00             	ret    $0x4

00802202 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802202:	55                   	push   %ebp
  802203:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802205:	6a 00                	push   $0x0
  802207:	6a 00                	push   $0x0
  802209:	ff 75 10             	pushl  0x10(%ebp)
  80220c:	ff 75 0c             	pushl  0xc(%ebp)
  80220f:	ff 75 08             	pushl  0x8(%ebp)
  802212:	6a 13                	push   $0x13
  802214:	e8 9d fb ff ff       	call   801db6 <syscall>
  802219:	83 c4 18             	add    $0x18,%esp
	return ;
  80221c:	90                   	nop
}
  80221d:	c9                   	leave  
  80221e:	c3                   	ret    

0080221f <sys_rcr2>:
uint32 sys_rcr2()
{
  80221f:	55                   	push   %ebp
  802220:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	6a 25                	push   $0x25
  80222e:	e8 83 fb ff ff       	call   801db6 <syscall>
  802233:	83 c4 18             	add    $0x18,%esp
}
  802236:	c9                   	leave  
  802237:	c3                   	ret    

00802238 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802238:	55                   	push   %ebp
  802239:	89 e5                	mov    %esp,%ebp
  80223b:	83 ec 04             	sub    $0x4,%esp
  80223e:	8b 45 08             	mov    0x8(%ebp),%eax
  802241:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802244:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	50                   	push   %eax
  802251:	6a 26                	push   $0x26
  802253:	e8 5e fb ff ff       	call   801db6 <syscall>
  802258:	83 c4 18             	add    $0x18,%esp
	return ;
  80225b:	90                   	nop
}
  80225c:	c9                   	leave  
  80225d:	c3                   	ret    

0080225e <rsttst>:
void rsttst()
{
  80225e:	55                   	push   %ebp
  80225f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802261:	6a 00                	push   $0x0
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 00                	push   $0x0
  802269:	6a 00                	push   $0x0
  80226b:	6a 28                	push   $0x28
  80226d:	e8 44 fb ff ff       	call   801db6 <syscall>
  802272:	83 c4 18             	add    $0x18,%esp
	return ;
  802275:	90                   	nop
}
  802276:	c9                   	leave  
  802277:	c3                   	ret    

00802278 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802278:	55                   	push   %ebp
  802279:	89 e5                	mov    %esp,%ebp
  80227b:	83 ec 04             	sub    $0x4,%esp
  80227e:	8b 45 14             	mov    0x14(%ebp),%eax
  802281:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802284:	8b 55 18             	mov    0x18(%ebp),%edx
  802287:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80228b:	52                   	push   %edx
  80228c:	50                   	push   %eax
  80228d:	ff 75 10             	pushl  0x10(%ebp)
  802290:	ff 75 0c             	pushl  0xc(%ebp)
  802293:	ff 75 08             	pushl  0x8(%ebp)
  802296:	6a 27                	push   $0x27
  802298:	e8 19 fb ff ff       	call   801db6 <syscall>
  80229d:	83 c4 18             	add    $0x18,%esp
	return ;
  8022a0:	90                   	nop
}
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <chktst>:
void chktst(uint32 n)
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022a6:	6a 00                	push   $0x0
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	6a 00                	push   $0x0
  8022ae:	ff 75 08             	pushl  0x8(%ebp)
  8022b1:	6a 29                	push   $0x29
  8022b3:	e8 fe fa ff ff       	call   801db6 <syscall>
  8022b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022bb:	90                   	nop
}
  8022bc:	c9                   	leave  
  8022bd:	c3                   	ret    

008022be <inctst>:

void inctst()
{
  8022be:	55                   	push   %ebp
  8022bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022c1:	6a 00                	push   $0x0
  8022c3:	6a 00                	push   $0x0
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 2a                	push   $0x2a
  8022cd:	e8 e4 fa ff ff       	call   801db6 <syscall>
  8022d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8022d5:	90                   	nop
}
  8022d6:	c9                   	leave  
  8022d7:	c3                   	ret    

008022d8 <gettst>:
uint32 gettst()
{
  8022d8:	55                   	push   %ebp
  8022d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 00                	push   $0x0
  8022e5:	6a 2b                	push   $0x2b
  8022e7:	e8 ca fa ff ff       	call   801db6 <syscall>
  8022ec:	83 c4 18             	add    $0x18,%esp
}
  8022ef:	c9                   	leave  
  8022f0:	c3                   	ret    

008022f1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022f1:	55                   	push   %ebp
  8022f2:	89 e5                	mov    %esp,%ebp
  8022f4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 2c                	push   $0x2c
  802303:	e8 ae fa ff ff       	call   801db6 <syscall>
  802308:	83 c4 18             	add    $0x18,%esp
  80230b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80230e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802312:	75 07                	jne    80231b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802314:	b8 01 00 00 00       	mov    $0x1,%eax
  802319:	eb 05                	jmp    802320 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80231b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802320:	c9                   	leave  
  802321:	c3                   	ret    

00802322 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802322:	55                   	push   %ebp
  802323:	89 e5                	mov    %esp,%ebp
  802325:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802328:	6a 00                	push   $0x0
  80232a:	6a 00                	push   $0x0
  80232c:	6a 00                	push   $0x0
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	6a 2c                	push   $0x2c
  802334:	e8 7d fa ff ff       	call   801db6 <syscall>
  802339:	83 c4 18             	add    $0x18,%esp
  80233c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80233f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802343:	75 07                	jne    80234c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802345:	b8 01 00 00 00       	mov    $0x1,%eax
  80234a:	eb 05                	jmp    802351 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80234c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802351:	c9                   	leave  
  802352:	c3                   	ret    

00802353 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802353:	55                   	push   %ebp
  802354:	89 e5                	mov    %esp,%ebp
  802356:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802359:	6a 00                	push   $0x0
  80235b:	6a 00                	push   $0x0
  80235d:	6a 00                	push   $0x0
  80235f:	6a 00                	push   $0x0
  802361:	6a 00                	push   $0x0
  802363:	6a 2c                	push   $0x2c
  802365:	e8 4c fa ff ff       	call   801db6 <syscall>
  80236a:	83 c4 18             	add    $0x18,%esp
  80236d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802370:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802374:	75 07                	jne    80237d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802376:	b8 01 00 00 00       	mov    $0x1,%eax
  80237b:	eb 05                	jmp    802382 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80237d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802382:	c9                   	leave  
  802383:	c3                   	ret    

00802384 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802384:	55                   	push   %ebp
  802385:	89 e5                	mov    %esp,%ebp
  802387:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80238a:	6a 00                	push   $0x0
  80238c:	6a 00                	push   $0x0
  80238e:	6a 00                	push   $0x0
  802390:	6a 00                	push   $0x0
  802392:	6a 00                	push   $0x0
  802394:	6a 2c                	push   $0x2c
  802396:	e8 1b fa ff ff       	call   801db6 <syscall>
  80239b:	83 c4 18             	add    $0x18,%esp
  80239e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023a1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023a5:	75 07                	jne    8023ae <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8023ac:	eb 05                	jmp    8023b3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023b3:	c9                   	leave  
  8023b4:	c3                   	ret    

008023b5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023b5:	55                   	push   %ebp
  8023b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023b8:	6a 00                	push   $0x0
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	ff 75 08             	pushl  0x8(%ebp)
  8023c3:	6a 2d                	push   $0x2d
  8023c5:	e8 ec f9 ff ff       	call   801db6 <syscall>
  8023ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8023cd:	90                   	nop
}
  8023ce:	c9                   	leave  
  8023cf:	c3                   	ret    

008023d0 <__udivdi3>:
  8023d0:	55                   	push   %ebp
  8023d1:	57                   	push   %edi
  8023d2:	56                   	push   %esi
  8023d3:	53                   	push   %ebx
  8023d4:	83 ec 1c             	sub    $0x1c,%esp
  8023d7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023db:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023e3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023e7:	89 ca                	mov    %ecx,%edx
  8023e9:	89 f8                	mov    %edi,%eax
  8023eb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023ef:	85 f6                	test   %esi,%esi
  8023f1:	75 2d                	jne    802420 <__udivdi3+0x50>
  8023f3:	39 cf                	cmp    %ecx,%edi
  8023f5:	77 65                	ja     80245c <__udivdi3+0x8c>
  8023f7:	89 fd                	mov    %edi,%ebp
  8023f9:	85 ff                	test   %edi,%edi
  8023fb:	75 0b                	jne    802408 <__udivdi3+0x38>
  8023fd:	b8 01 00 00 00       	mov    $0x1,%eax
  802402:	31 d2                	xor    %edx,%edx
  802404:	f7 f7                	div    %edi
  802406:	89 c5                	mov    %eax,%ebp
  802408:	31 d2                	xor    %edx,%edx
  80240a:	89 c8                	mov    %ecx,%eax
  80240c:	f7 f5                	div    %ebp
  80240e:	89 c1                	mov    %eax,%ecx
  802410:	89 d8                	mov    %ebx,%eax
  802412:	f7 f5                	div    %ebp
  802414:	89 cf                	mov    %ecx,%edi
  802416:	89 fa                	mov    %edi,%edx
  802418:	83 c4 1c             	add    $0x1c,%esp
  80241b:	5b                   	pop    %ebx
  80241c:	5e                   	pop    %esi
  80241d:	5f                   	pop    %edi
  80241e:	5d                   	pop    %ebp
  80241f:	c3                   	ret    
  802420:	39 ce                	cmp    %ecx,%esi
  802422:	77 28                	ja     80244c <__udivdi3+0x7c>
  802424:	0f bd fe             	bsr    %esi,%edi
  802427:	83 f7 1f             	xor    $0x1f,%edi
  80242a:	75 40                	jne    80246c <__udivdi3+0x9c>
  80242c:	39 ce                	cmp    %ecx,%esi
  80242e:	72 0a                	jb     80243a <__udivdi3+0x6a>
  802430:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802434:	0f 87 9e 00 00 00    	ja     8024d8 <__udivdi3+0x108>
  80243a:	b8 01 00 00 00       	mov    $0x1,%eax
  80243f:	89 fa                	mov    %edi,%edx
  802441:	83 c4 1c             	add    $0x1c,%esp
  802444:	5b                   	pop    %ebx
  802445:	5e                   	pop    %esi
  802446:	5f                   	pop    %edi
  802447:	5d                   	pop    %ebp
  802448:	c3                   	ret    
  802449:	8d 76 00             	lea    0x0(%esi),%esi
  80244c:	31 ff                	xor    %edi,%edi
  80244e:	31 c0                	xor    %eax,%eax
  802450:	89 fa                	mov    %edi,%edx
  802452:	83 c4 1c             	add    $0x1c,%esp
  802455:	5b                   	pop    %ebx
  802456:	5e                   	pop    %esi
  802457:	5f                   	pop    %edi
  802458:	5d                   	pop    %ebp
  802459:	c3                   	ret    
  80245a:	66 90                	xchg   %ax,%ax
  80245c:	89 d8                	mov    %ebx,%eax
  80245e:	f7 f7                	div    %edi
  802460:	31 ff                	xor    %edi,%edi
  802462:	89 fa                	mov    %edi,%edx
  802464:	83 c4 1c             	add    $0x1c,%esp
  802467:	5b                   	pop    %ebx
  802468:	5e                   	pop    %esi
  802469:	5f                   	pop    %edi
  80246a:	5d                   	pop    %ebp
  80246b:	c3                   	ret    
  80246c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802471:	89 eb                	mov    %ebp,%ebx
  802473:	29 fb                	sub    %edi,%ebx
  802475:	89 f9                	mov    %edi,%ecx
  802477:	d3 e6                	shl    %cl,%esi
  802479:	89 c5                	mov    %eax,%ebp
  80247b:	88 d9                	mov    %bl,%cl
  80247d:	d3 ed                	shr    %cl,%ebp
  80247f:	89 e9                	mov    %ebp,%ecx
  802481:	09 f1                	or     %esi,%ecx
  802483:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802487:	89 f9                	mov    %edi,%ecx
  802489:	d3 e0                	shl    %cl,%eax
  80248b:	89 c5                	mov    %eax,%ebp
  80248d:	89 d6                	mov    %edx,%esi
  80248f:	88 d9                	mov    %bl,%cl
  802491:	d3 ee                	shr    %cl,%esi
  802493:	89 f9                	mov    %edi,%ecx
  802495:	d3 e2                	shl    %cl,%edx
  802497:	8b 44 24 08          	mov    0x8(%esp),%eax
  80249b:	88 d9                	mov    %bl,%cl
  80249d:	d3 e8                	shr    %cl,%eax
  80249f:	09 c2                	or     %eax,%edx
  8024a1:	89 d0                	mov    %edx,%eax
  8024a3:	89 f2                	mov    %esi,%edx
  8024a5:	f7 74 24 0c          	divl   0xc(%esp)
  8024a9:	89 d6                	mov    %edx,%esi
  8024ab:	89 c3                	mov    %eax,%ebx
  8024ad:	f7 e5                	mul    %ebp
  8024af:	39 d6                	cmp    %edx,%esi
  8024b1:	72 19                	jb     8024cc <__udivdi3+0xfc>
  8024b3:	74 0b                	je     8024c0 <__udivdi3+0xf0>
  8024b5:	89 d8                	mov    %ebx,%eax
  8024b7:	31 ff                	xor    %edi,%edi
  8024b9:	e9 58 ff ff ff       	jmp    802416 <__udivdi3+0x46>
  8024be:	66 90                	xchg   %ax,%ax
  8024c0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024c4:	89 f9                	mov    %edi,%ecx
  8024c6:	d3 e2                	shl    %cl,%edx
  8024c8:	39 c2                	cmp    %eax,%edx
  8024ca:	73 e9                	jae    8024b5 <__udivdi3+0xe5>
  8024cc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024cf:	31 ff                	xor    %edi,%edi
  8024d1:	e9 40 ff ff ff       	jmp    802416 <__udivdi3+0x46>
  8024d6:	66 90                	xchg   %ax,%ax
  8024d8:	31 c0                	xor    %eax,%eax
  8024da:	e9 37 ff ff ff       	jmp    802416 <__udivdi3+0x46>
  8024df:	90                   	nop

008024e0 <__umoddi3>:
  8024e0:	55                   	push   %ebp
  8024e1:	57                   	push   %edi
  8024e2:	56                   	push   %esi
  8024e3:	53                   	push   %ebx
  8024e4:	83 ec 1c             	sub    $0x1c,%esp
  8024e7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024eb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024f3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024fb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024ff:	89 f3                	mov    %esi,%ebx
  802501:	89 fa                	mov    %edi,%edx
  802503:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802507:	89 34 24             	mov    %esi,(%esp)
  80250a:	85 c0                	test   %eax,%eax
  80250c:	75 1a                	jne    802528 <__umoddi3+0x48>
  80250e:	39 f7                	cmp    %esi,%edi
  802510:	0f 86 a2 00 00 00    	jbe    8025b8 <__umoddi3+0xd8>
  802516:	89 c8                	mov    %ecx,%eax
  802518:	89 f2                	mov    %esi,%edx
  80251a:	f7 f7                	div    %edi
  80251c:	89 d0                	mov    %edx,%eax
  80251e:	31 d2                	xor    %edx,%edx
  802520:	83 c4 1c             	add    $0x1c,%esp
  802523:	5b                   	pop    %ebx
  802524:	5e                   	pop    %esi
  802525:	5f                   	pop    %edi
  802526:	5d                   	pop    %ebp
  802527:	c3                   	ret    
  802528:	39 f0                	cmp    %esi,%eax
  80252a:	0f 87 ac 00 00 00    	ja     8025dc <__umoddi3+0xfc>
  802530:	0f bd e8             	bsr    %eax,%ebp
  802533:	83 f5 1f             	xor    $0x1f,%ebp
  802536:	0f 84 ac 00 00 00    	je     8025e8 <__umoddi3+0x108>
  80253c:	bf 20 00 00 00       	mov    $0x20,%edi
  802541:	29 ef                	sub    %ebp,%edi
  802543:	89 fe                	mov    %edi,%esi
  802545:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802549:	89 e9                	mov    %ebp,%ecx
  80254b:	d3 e0                	shl    %cl,%eax
  80254d:	89 d7                	mov    %edx,%edi
  80254f:	89 f1                	mov    %esi,%ecx
  802551:	d3 ef                	shr    %cl,%edi
  802553:	09 c7                	or     %eax,%edi
  802555:	89 e9                	mov    %ebp,%ecx
  802557:	d3 e2                	shl    %cl,%edx
  802559:	89 14 24             	mov    %edx,(%esp)
  80255c:	89 d8                	mov    %ebx,%eax
  80255e:	d3 e0                	shl    %cl,%eax
  802560:	89 c2                	mov    %eax,%edx
  802562:	8b 44 24 08          	mov    0x8(%esp),%eax
  802566:	d3 e0                	shl    %cl,%eax
  802568:	89 44 24 04          	mov    %eax,0x4(%esp)
  80256c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802570:	89 f1                	mov    %esi,%ecx
  802572:	d3 e8                	shr    %cl,%eax
  802574:	09 d0                	or     %edx,%eax
  802576:	d3 eb                	shr    %cl,%ebx
  802578:	89 da                	mov    %ebx,%edx
  80257a:	f7 f7                	div    %edi
  80257c:	89 d3                	mov    %edx,%ebx
  80257e:	f7 24 24             	mull   (%esp)
  802581:	89 c6                	mov    %eax,%esi
  802583:	89 d1                	mov    %edx,%ecx
  802585:	39 d3                	cmp    %edx,%ebx
  802587:	0f 82 87 00 00 00    	jb     802614 <__umoddi3+0x134>
  80258d:	0f 84 91 00 00 00    	je     802624 <__umoddi3+0x144>
  802593:	8b 54 24 04          	mov    0x4(%esp),%edx
  802597:	29 f2                	sub    %esi,%edx
  802599:	19 cb                	sbb    %ecx,%ebx
  80259b:	89 d8                	mov    %ebx,%eax
  80259d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025a1:	d3 e0                	shl    %cl,%eax
  8025a3:	89 e9                	mov    %ebp,%ecx
  8025a5:	d3 ea                	shr    %cl,%edx
  8025a7:	09 d0                	or     %edx,%eax
  8025a9:	89 e9                	mov    %ebp,%ecx
  8025ab:	d3 eb                	shr    %cl,%ebx
  8025ad:	89 da                	mov    %ebx,%edx
  8025af:	83 c4 1c             	add    $0x1c,%esp
  8025b2:	5b                   	pop    %ebx
  8025b3:	5e                   	pop    %esi
  8025b4:	5f                   	pop    %edi
  8025b5:	5d                   	pop    %ebp
  8025b6:	c3                   	ret    
  8025b7:	90                   	nop
  8025b8:	89 fd                	mov    %edi,%ebp
  8025ba:	85 ff                	test   %edi,%edi
  8025bc:	75 0b                	jne    8025c9 <__umoddi3+0xe9>
  8025be:	b8 01 00 00 00       	mov    $0x1,%eax
  8025c3:	31 d2                	xor    %edx,%edx
  8025c5:	f7 f7                	div    %edi
  8025c7:	89 c5                	mov    %eax,%ebp
  8025c9:	89 f0                	mov    %esi,%eax
  8025cb:	31 d2                	xor    %edx,%edx
  8025cd:	f7 f5                	div    %ebp
  8025cf:	89 c8                	mov    %ecx,%eax
  8025d1:	f7 f5                	div    %ebp
  8025d3:	89 d0                	mov    %edx,%eax
  8025d5:	e9 44 ff ff ff       	jmp    80251e <__umoddi3+0x3e>
  8025da:	66 90                	xchg   %ax,%ax
  8025dc:	89 c8                	mov    %ecx,%eax
  8025de:	89 f2                	mov    %esi,%edx
  8025e0:	83 c4 1c             	add    $0x1c,%esp
  8025e3:	5b                   	pop    %ebx
  8025e4:	5e                   	pop    %esi
  8025e5:	5f                   	pop    %edi
  8025e6:	5d                   	pop    %ebp
  8025e7:	c3                   	ret    
  8025e8:	3b 04 24             	cmp    (%esp),%eax
  8025eb:	72 06                	jb     8025f3 <__umoddi3+0x113>
  8025ed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025f1:	77 0f                	ja     802602 <__umoddi3+0x122>
  8025f3:	89 f2                	mov    %esi,%edx
  8025f5:	29 f9                	sub    %edi,%ecx
  8025f7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025fb:	89 14 24             	mov    %edx,(%esp)
  8025fe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802602:	8b 44 24 04          	mov    0x4(%esp),%eax
  802606:	8b 14 24             	mov    (%esp),%edx
  802609:	83 c4 1c             	add    $0x1c,%esp
  80260c:	5b                   	pop    %ebx
  80260d:	5e                   	pop    %esi
  80260e:	5f                   	pop    %edi
  80260f:	5d                   	pop    %ebp
  802610:	c3                   	ret    
  802611:	8d 76 00             	lea    0x0(%esi),%esi
  802614:	2b 04 24             	sub    (%esp),%eax
  802617:	19 fa                	sbb    %edi,%edx
  802619:	89 d1                	mov    %edx,%ecx
  80261b:	89 c6                	mov    %eax,%esi
  80261d:	e9 71 ff ff ff       	jmp    802593 <__umoddi3+0xb3>
  802622:	66 90                	xchg   %ax,%ax
  802624:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802628:	72 ea                	jb     802614 <__umoddi3+0x134>
  80262a:	89 d9                	mov    %ebx,%ecx
  80262c:	e9 62 ff ff ff       	jmp    802593 <__umoddi3+0xb3>
