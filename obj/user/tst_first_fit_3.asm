
obj/user/tst_first_fit_3:     file format elf32-i386


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
  800031:	e8 9a 0d 00 00       	call   800dd0 <libmain>
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
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp

	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 55 27 00 00       	call   80279f <sys_set_uheap_strategy>
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
  80005a:	a1 20 40 80 00       	mov    0x804020,%eax
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
  800083:	a1 20 40 80 00       	mov    0x804020,%eax
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
  80009b:	68 20 2a 80 00       	push   $0x802a20
  8000a0:	6a 16                	push   $0x16
  8000a2:	68 3c 2a 80 00       	push   $0x802a3c
  8000a7:	e8 26 0e 00 00       	call   800ed2 <_panic>
	}

	int envID = sys_getenvid();
  8000ac:	e8 77 21 00 00       	call   802228 <sys_getenvid>
  8000b1:	89 45 ec             	mov    %eax,-0x14(%ebp)



	int Mega = 1024*1024;
  8000b4:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)
	int kilo = 1024;
  8000bb:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
	void* ptr_allocations[20] = {0};
  8000c2:	8d 55 8c             	lea    -0x74(%ebp),%edx
  8000c5:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8000cf:	89 d7                	mov    %edx,%edi
  8000d1:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate Shared 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000d3:	e8 34 22 00 00       	call   80230c <sys_calculate_free_frames>
  8000d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000db:	e8 af 22 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8000e0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = smalloc("x", 1*Mega, 1);
  8000e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	6a 01                	push   $0x1
  8000eb:	50                   	push   %eax
  8000ec:	68 53 2a 80 00       	push   $0x802a53
  8000f1:	e8 1a 1e 00 00       	call   801f10 <smalloc>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if (ptr_allocations[0] != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000fc:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8000ff:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800104:	74 14                	je     80011a <_main+0xe2>
  800106:	83 ec 04             	sub    $0x4,%esp
  800109:	68 58 2a 80 00       	push   $0x802a58
  80010e:	6a 28                	push   $0x28
  800110:	68 3c 2a 80 00       	push   $0x802a3c
  800115:	e8 b8 0d 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  256+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80011a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80011d:	e8 ea 21 00 00       	call   80230c <sys_calculate_free_frames>
  800122:	29 c3                	sub    %eax,%ebx
  800124:	89 d8                	mov    %ebx,%eax
  800126:	3d 03 01 00 00       	cmp    $0x103,%eax
  80012b:	74 14                	je     800141 <_main+0x109>
  80012d:	83 ec 04             	sub    $0x4,%esp
  800130:	68 c4 2a 80 00       	push   $0x802ac4
  800135:	6a 29                	push   $0x29
  800137:	68 3c 2a 80 00       	push   $0x802a3c
  80013c:	e8 91 0d 00 00       	call   800ed2 <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800141:	e8 49 22 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800146:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800149:	74 14                	je     80015f <_main+0x127>
  80014b:	83 ec 04             	sub    $0x4,%esp
  80014e:	68 42 2b 80 00       	push   $0x802b42
  800153:	6a 2a                	push   $0x2a
  800155:	68 3c 2a 80 00       	push   $0x802a3c
  80015a:	e8 73 0d 00 00       	call   800ed2 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80015f:	e8 a8 21 00 00       	call   80230c <sys_calculate_free_frames>
  800164:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800167:	e8 23 22 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80016c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  80016f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800172:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	50                   	push   %eax
  800179:	e8 cc 1d 00 00       	call   801f4a <malloc>
  80017e:	83 c4 10             	add    $0x10,%esp
  800181:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  800184:	8b 45 90             	mov    -0x70(%ebp),%eax
  800187:	89 c2                	mov    %eax,%edx
  800189:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80018c:	05 00 00 00 80       	add    $0x80000000,%eax
  800191:	39 c2                	cmp    %eax,%edx
  800193:	74 14                	je     8001a9 <_main+0x171>
  800195:	83 ec 04             	sub    $0x4,%esp
  800198:	68 60 2b 80 00       	push   $0x802b60
  80019d:	6a 30                	push   $0x30
  80019f:	68 3c 2a 80 00       	push   $0x802a3c
  8001a4:	e8 29 0d 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8001a9:	e8 e1 21 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8001ae:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8001b1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001b6:	74 14                	je     8001cc <_main+0x194>
  8001b8:	83 ec 04             	sub    $0x4,%esp
  8001bb:	68 42 2b 80 00       	push   $0x802b42
  8001c0:	6a 32                	push   $0x32
  8001c2:	68 3c 2a 80 00       	push   $0x802a3c
  8001c7:	e8 06 0d 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001cc:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8001cf:	e8 38 21 00 00       	call   80230c <sys_calculate_free_frames>
  8001d4:	29 c3                	sub    %eax,%ebx
  8001d6:	89 d8                	mov    %ebx,%eax
  8001d8:	83 f8 01             	cmp    $0x1,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 90 2b 80 00       	push   $0x802b90
  8001e5:	6a 33                	push   $0x33
  8001e7:	68 3c 2a 80 00       	push   $0x802a3c
  8001ec:	e8 e1 0c 00 00       	call   800ed2 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001f1:	e8 16 21 00 00       	call   80230c <sys_calculate_free_frames>
  8001f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001f9:	e8 91 21 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8001fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800201:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800204:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800207:	83 ec 0c             	sub    $0xc,%esp
  80020a:	50                   	push   %eax
  80020b:	e8 3a 1d 00 00       	call   801f4a <malloc>
  800210:	83 c4 10             	add    $0x10,%esp
  800213:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800216:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800219:	89 c2                	mov    %eax,%edx
  80021b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80021e:	01 c0                	add    %eax,%eax
  800220:	05 00 00 00 80       	add    $0x80000000,%eax
  800225:	39 c2                	cmp    %eax,%edx
  800227:	74 14                	je     80023d <_main+0x205>
  800229:	83 ec 04             	sub    $0x4,%esp
  80022c:	68 60 2b 80 00       	push   $0x802b60
  800231:	6a 39                	push   $0x39
  800233:	68 3c 2a 80 00       	push   $0x802a3c
  800238:	e8 95 0c 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80023d:	e8 4d 21 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800242:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800245:	3d 00 01 00 00       	cmp    $0x100,%eax
  80024a:	74 14                	je     800260 <_main+0x228>
  80024c:	83 ec 04             	sub    $0x4,%esp
  80024f:	68 42 2b 80 00       	push   $0x802b42
  800254:	6a 3b                	push   $0x3b
  800256:	68 3c 2a 80 00       	push   $0x802a3c
  80025b:	e8 72 0c 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800260:	e8 a7 20 00 00       	call   80230c <sys_calculate_free_frames>
  800265:	89 c2                	mov    %eax,%edx
  800267:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80026a:	39 c2                	cmp    %eax,%edx
  80026c:	74 14                	je     800282 <_main+0x24a>
  80026e:	83 ec 04             	sub    $0x4,%esp
  800271:	68 90 2b 80 00       	push   $0x802b90
  800276:	6a 3c                	push   $0x3c
  800278:	68 3c 2a 80 00       	push   $0x802a3c
  80027d:	e8 50 0c 00 00       	call   800ed2 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800282:	e8 85 20 00 00       	call   80230c <sys_calculate_free_frames>
  800287:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80028a:	e8 00 21 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80028f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800292:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800295:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800298:	83 ec 0c             	sub    $0xc,%esp
  80029b:	50                   	push   %eax
  80029c:	e8 a9 1c 00 00       	call   801f4a <malloc>
  8002a1:	83 c4 10             	add    $0x10,%esp
  8002a4:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  8002a7:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002aa:	89 c1                	mov    %eax,%ecx
  8002ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002af:	89 c2                	mov    %eax,%edx
  8002b1:	01 d2                	add    %edx,%edx
  8002b3:	01 d0                	add    %edx,%eax
  8002b5:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ba:	39 c1                	cmp    %eax,%ecx
  8002bc:	74 14                	je     8002d2 <_main+0x29a>
  8002be:	83 ec 04             	sub    $0x4,%esp
  8002c1:	68 60 2b 80 00       	push   $0x802b60
  8002c6:	6a 42                	push   $0x42
  8002c8:	68 3c 2a 80 00       	push   $0x802a3c
  8002cd:	e8 00 0c 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002d2:	e8 b8 20 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8002d7:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002da:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002df:	74 14                	je     8002f5 <_main+0x2bd>
  8002e1:	83 ec 04             	sub    $0x4,%esp
  8002e4:	68 42 2b 80 00       	push   $0x802b42
  8002e9:	6a 44                	push   $0x44
  8002eb:	68 3c 2a 80 00       	push   $0x802a3c
  8002f0:	e8 dd 0b 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002f5:	e8 12 20 00 00       	call   80230c <sys_calculate_free_frames>
  8002fa:	89 c2                	mov    %eax,%edx
  8002fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ff:	39 c2                	cmp    %eax,%edx
  800301:	74 14                	je     800317 <_main+0x2df>
  800303:	83 ec 04             	sub    $0x4,%esp
  800306:	68 90 2b 80 00       	push   $0x802b90
  80030b:	6a 45                	push   $0x45
  80030d:	68 3c 2a 80 00       	push   $0x802a3c
  800312:	e8 bb 0b 00 00       	call   800ed2 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800317:	e8 f0 1f 00 00       	call   80230c <sys_calculate_free_frames>
  80031c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80031f:	e8 6b 20 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800324:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  800327:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80032a:	01 c0                	add    %eax,%eax
  80032c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	50                   	push   %eax
  800333:	e8 12 1c 00 00       	call   801f4a <malloc>
  800338:	83 c4 10             	add    $0x10,%esp
  80033b:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  80033e:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800341:	89 c2                	mov    %eax,%edx
  800343:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800346:	c1 e0 02             	shl    $0x2,%eax
  800349:	05 00 00 00 80       	add    $0x80000000,%eax
  80034e:	39 c2                	cmp    %eax,%edx
  800350:	74 14                	je     800366 <_main+0x32e>
  800352:	83 ec 04             	sub    $0x4,%esp
  800355:	68 60 2b 80 00       	push   $0x802b60
  80035a:	6a 4b                	push   $0x4b
  80035c:	68 3c 2a 80 00       	push   $0x802a3c
  800361:	e8 6c 0b 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800366:	e8 24 20 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80036b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80036e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800373:	74 14                	je     800389 <_main+0x351>
  800375:	83 ec 04             	sub    $0x4,%esp
  800378:	68 42 2b 80 00       	push   $0x802b42
  80037d:	6a 4d                	push   $0x4d
  80037f:	68 3c 2a 80 00       	push   $0x802a3c
  800384:	e8 49 0b 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800389:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80038c:	e8 7b 1f 00 00       	call   80230c <sys_calculate_free_frames>
  800391:	29 c3                	sub    %eax,%ebx
  800393:	89 d8                	mov    %ebx,%eax
  800395:	83 f8 01             	cmp    $0x1,%eax
  800398:	74 14                	je     8003ae <_main+0x376>
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 90 2b 80 00       	push   $0x802b90
  8003a2:	6a 4e                	push   $0x4e
  8003a4:	68 3c 2a 80 00       	push   $0x802a3c
  8003a9:	e8 24 0b 00 00       	call   800ed2 <_panic>

		//Allocate Shared 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8003ae:	e8 59 1f 00 00       	call   80230c <sys_calculate_free_frames>
  8003b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003b6:	e8 d4 1f 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8003bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = smalloc("y", 2*Mega, 1);
  8003be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003c1:	01 c0                	add    %eax,%eax
  8003c3:	83 ec 04             	sub    $0x4,%esp
  8003c6:	6a 01                	push   $0x1
  8003c8:	50                   	push   %eax
  8003c9:	68 a3 2b 80 00       	push   $0x802ba3
  8003ce:	e8 3d 1b 00 00       	call   801f10 <smalloc>
  8003d3:	83 c4 10             	add    $0x10,%esp
  8003d6:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if (ptr_allocations[5] != (uint32*)(USER_HEAP_START + 6*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8003d9:	8b 4d a0             	mov    -0x60(%ebp),%ecx
  8003dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003df:	89 d0                	mov    %edx,%eax
  8003e1:	01 c0                	add    %eax,%eax
  8003e3:	01 d0                	add    %edx,%eax
  8003e5:	01 c0                	add    %eax,%eax
  8003e7:	05 00 00 00 80       	add    $0x80000000,%eax
  8003ec:	39 c1                	cmp    %eax,%ecx
  8003ee:	74 14                	je     800404 <_main+0x3cc>
  8003f0:	83 ec 04             	sub    $0x4,%esp
  8003f3:	68 58 2a 80 00       	push   $0x802a58
  8003f8:	6a 54                	push   $0x54
  8003fa:	68 3c 2a 80 00       	push   $0x802a3c
  8003ff:	e8 ce 0a 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  512+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800404:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800407:	e8 00 1f 00 00       	call   80230c <sys_calculate_free_frames>
  80040c:	29 c3                	sub    %eax,%ebx
  80040e:	89 d8                	mov    %ebx,%eax
  800410:	3d 03 02 00 00       	cmp    $0x203,%eax
  800415:	74 14                	je     80042b <_main+0x3f3>
  800417:	83 ec 04             	sub    $0x4,%esp
  80041a:	68 c4 2a 80 00       	push   $0x802ac4
  80041f:	6a 55                	push   $0x55
  800421:	68 3c 2a 80 00       	push   $0x802a3c
  800426:	e8 a7 0a 00 00       	call   800ed2 <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  80042b:	e8 5f 1f 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800430:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800433:	74 14                	je     800449 <_main+0x411>
  800435:	83 ec 04             	sub    $0x4,%esp
  800438:	68 42 2b 80 00       	push   $0x802b42
  80043d:	6a 56                	push   $0x56
  80043f:	68 3c 2a 80 00       	push   $0x802a3c
  800444:	e8 89 0a 00 00       	call   800ed2 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800449:	e8 be 1e 00 00       	call   80230c <sys_calculate_free_frames>
  80044e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800451:	e8 39 1f 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800456:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  800459:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80045c:	89 c2                	mov    %eax,%edx
  80045e:	01 d2                	add    %edx,%edx
  800460:	01 d0                	add    %edx,%eax
  800462:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800465:	83 ec 0c             	sub    $0xc,%esp
  800468:	50                   	push   %eax
  800469:	e8 dc 1a 00 00       	call   801f4a <malloc>
  80046e:	83 c4 10             	add    $0x10,%esp
  800471:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800474:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800477:	89 c2                	mov    %eax,%edx
  800479:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80047c:	c1 e0 03             	shl    $0x3,%eax
  80047f:	05 00 00 00 80       	add    $0x80000000,%eax
  800484:	39 c2                	cmp    %eax,%edx
  800486:	74 14                	je     80049c <_main+0x464>
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	68 60 2b 80 00       	push   $0x802b60
  800490:	6a 5c                	push   $0x5c
  800492:	68 3c 2a 80 00       	push   $0x802a3c
  800497:	e8 36 0a 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  80049c:	e8 ee 1e 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8004a1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8004a4:	3d 00 03 00 00       	cmp    $0x300,%eax
  8004a9:	74 14                	je     8004bf <_main+0x487>
  8004ab:	83 ec 04             	sub    $0x4,%esp
  8004ae:	68 42 2b 80 00       	push   $0x802b42
  8004b3:	6a 5e                	push   $0x5e
  8004b5:	68 3c 2a 80 00       	push   $0x802a3c
  8004ba:	e8 13 0a 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004bf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8004c2:	e8 45 1e 00 00       	call   80230c <sys_calculate_free_frames>
  8004c7:	29 c3                	sub    %eax,%ebx
  8004c9:	89 d8                	mov    %ebx,%eax
  8004cb:	83 f8 01             	cmp    $0x1,%eax
  8004ce:	74 14                	je     8004e4 <_main+0x4ac>
  8004d0:	83 ec 04             	sub    $0x4,%esp
  8004d3:	68 90 2b 80 00       	push   $0x802b90
  8004d8:	6a 5f                	push   $0x5f
  8004da:	68 3c 2a 80 00       	push   $0x802a3c
  8004df:	e8 ee 09 00 00       	call   800ed2 <_panic>

		//Allocate Shared 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004e4:	e8 23 1e 00 00       	call   80230c <sys_calculate_free_frames>
  8004e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004ec:	e8 9e 1e 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8004f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = smalloc("z", 3*Mega, 0);
  8004f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004f7:	89 c2                	mov    %eax,%edx
  8004f9:	01 d2                	add    %edx,%edx
  8004fb:	01 d0                	add    %edx,%eax
  8004fd:	83 ec 04             	sub    $0x4,%esp
  800500:	6a 00                	push   $0x0
  800502:	50                   	push   %eax
  800503:	68 a5 2b 80 00       	push   $0x802ba5
  800508:	e8 03 1a 00 00       	call   801f10 <smalloc>
  80050d:	83 c4 10             	add    $0x10,%esp
  800510:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if (ptr_allocations[7] != (uint32*)(USER_HEAP_START + 11*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800513:	8b 4d a8             	mov    -0x58(%ebp),%ecx
  800516:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800519:	89 d0                	mov    %edx,%eax
  80051b:	c1 e0 02             	shl    $0x2,%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	01 c0                	add    %eax,%eax
  800522:	01 d0                	add    %edx,%eax
  800524:	05 00 00 00 80       	add    $0x80000000,%eax
  800529:	39 c1                	cmp    %eax,%ecx
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 58 2a 80 00       	push   $0x802a58
  800535:	6a 65                	push   $0x65
  800537:	68 3c 2a 80 00       	push   $0x802a3c
  80053c:	e8 91 09 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  768+2+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800541:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800544:	e8 c3 1d 00 00       	call   80230c <sys_calculate_free_frames>
  800549:	29 c3                	sub    %eax,%ebx
  80054b:	89 d8                	mov    %ebx,%eax
  80054d:	3d 04 03 00 00       	cmp    $0x304,%eax
  800552:	74 14                	je     800568 <_main+0x530>
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	68 c4 2a 80 00       	push   $0x802ac4
  80055c:	6a 66                	push   $0x66
  80055e:	68 3c 2a 80 00       	push   $0x802a3c
  800563:	e8 6a 09 00 00       	call   800ed2 <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800568:	e8 22 1e 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80056d:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800570:	74 14                	je     800586 <_main+0x54e>
  800572:	83 ec 04             	sub    $0x4,%esp
  800575:	68 42 2b 80 00       	push   $0x802b42
  80057a:	6a 67                	push   $0x67
  80057c:	68 3c 2a 80 00       	push   $0x802a3c
  800581:	e8 4c 09 00 00       	call   800ed2 <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800586:	e8 81 1d 00 00       	call   80230c <sys_calculate_free_frames>
  80058b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80058e:	e8 fc 1d 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800593:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[1]);
  800596:	8b 45 90             	mov    -0x70(%ebp),%eax
  800599:	83 ec 0c             	sub    $0xc,%esp
  80059c:	50                   	push   %eax
  80059d:	e8 c9 1a 00 00       	call   80206b <free>
  8005a2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8005a5:	e8 e5 1d 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8005aa:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005ad:	29 c2                	sub    %eax,%edx
  8005af:	89 d0                	mov    %edx,%eax
  8005b1:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005b6:	74 14                	je     8005cc <_main+0x594>
  8005b8:	83 ec 04             	sub    $0x4,%esp
  8005bb:	68 a7 2b 80 00       	push   $0x802ba7
  8005c0:	6a 71                	push   $0x71
  8005c2:	68 3c 2a 80 00       	push   $0x802a3c
  8005c7:	e8 06 09 00 00       	call   800ed2 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005cc:	e8 3b 1d 00 00       	call   80230c <sys_calculate_free_frames>
  8005d1:	89 c2                	mov    %eax,%edx
  8005d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d6:	39 c2                	cmp    %eax,%edx
  8005d8:	74 14                	je     8005ee <_main+0x5b6>
  8005da:	83 ec 04             	sub    $0x4,%esp
  8005dd:	68 be 2b 80 00       	push   $0x802bbe
  8005e2:	6a 72                	push   $0x72
  8005e4:	68 3c 2a 80 00       	push   $0x802a3c
  8005e9:	e8 e4 08 00 00       	call   800ed2 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005ee:	e8 19 1d 00 00       	call   80230c <sys_calculate_free_frames>
  8005f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005f6:	e8 94 1d 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8005fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[4]);
  8005fe:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800601:	83 ec 0c             	sub    $0xc,%esp
  800604:	50                   	push   %eax
  800605:	e8 61 1a 00 00       	call   80206b <free>
  80060a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  80060d:	e8 7d 1d 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800612:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800615:	29 c2                	sub    %eax,%edx
  800617:	89 d0                	mov    %edx,%eax
  800619:	3d 00 02 00 00       	cmp    $0x200,%eax
  80061e:	74 14                	je     800634 <_main+0x5fc>
  800620:	83 ec 04             	sub    $0x4,%esp
  800623:	68 a7 2b 80 00       	push   $0x802ba7
  800628:	6a 79                	push   $0x79
  80062a:	68 3c 2a 80 00       	push   $0x802a3c
  80062f:	e8 9e 08 00 00       	call   800ed2 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800634:	e8 d3 1c 00 00       	call   80230c <sys_calculate_free_frames>
  800639:	89 c2                	mov    %eax,%edx
  80063b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063e:	39 c2                	cmp    %eax,%edx
  800640:	74 14                	je     800656 <_main+0x61e>
  800642:	83 ec 04             	sub    $0x4,%esp
  800645:	68 be 2b 80 00       	push   $0x802bbe
  80064a:	6a 7a                	push   $0x7a
  80064c:	68 3c 2a 80 00       	push   $0x802a3c
  800651:	e8 7c 08 00 00       	call   800ed2 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800656:	e8 b1 1c 00 00       	call   80230c <sys_calculate_free_frames>
  80065b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80065e:	e8 2c 1d 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800663:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  800666:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800669:	83 ec 0c             	sub    $0xc,%esp
  80066c:	50                   	push   %eax
  80066d:	e8 f9 19 00 00       	call   80206b <free>
  800672:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800675:	e8 15 1d 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80067a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80067d:	29 c2                	sub    %eax,%edx
  80067f:	89 d0                	mov    %edx,%eax
  800681:	3d 00 03 00 00       	cmp    $0x300,%eax
  800686:	74 17                	je     80069f <_main+0x667>
  800688:	83 ec 04             	sub    $0x4,%esp
  80068b:	68 a7 2b 80 00       	push   $0x802ba7
  800690:	68 81 00 00 00       	push   $0x81
  800695:	68 3c 2a 80 00       	push   $0x802a3c
  80069a:	e8 33 08 00 00       	call   800ed2 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80069f:	e8 68 1c 00 00       	call   80230c <sys_calculate_free_frames>
  8006a4:	89 c2                	mov    %eax,%edx
  8006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a9:	39 c2                	cmp    %eax,%edx
  8006ab:	74 17                	je     8006c4 <_main+0x68c>
  8006ad:	83 ec 04             	sub    $0x4,%esp
  8006b0:	68 be 2b 80 00       	push   $0x802bbe
  8006b5:	68 82 00 00 00       	push   $0x82
  8006ba:	68 3c 2a 80 00       	push   $0x802a3c
  8006bf:	e8 0e 08 00 00       	call   800ed2 <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006c4:	e8 43 1c 00 00       	call   80230c <sys_calculate_free_frames>
  8006c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006cc:	e8 be 1c 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8006d1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006d7:	89 d0                	mov    %edx,%eax
  8006d9:	c1 e0 09             	shl    $0x9,%eax
  8006dc:	29 d0                	sub    %edx,%eax
  8006de:	83 ec 0c             	sub    $0xc,%esp
  8006e1:	50                   	push   %eax
  8006e2:	e8 63 18 00 00       	call   801f4a <malloc>
  8006e7:	83 c4 10             	add    $0x10,%esp
  8006ea:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006ed:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8006f0:	89 c2                	mov    %eax,%edx
  8006f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f5:	05 00 00 00 80       	add    $0x80000000,%eax
  8006fa:	39 c2                	cmp    %eax,%edx
  8006fc:	74 17                	je     800715 <_main+0x6dd>
  8006fe:	83 ec 04             	sub    $0x4,%esp
  800701:	68 60 2b 80 00       	push   $0x802b60
  800706:	68 8b 00 00 00       	push   $0x8b
  80070b:	68 3c 2a 80 00       	push   $0x802a3c
  800710:	e8 bd 07 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800715:	e8 75 1c 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80071a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80071d:	3d 80 00 00 00       	cmp    $0x80,%eax
  800722:	74 17                	je     80073b <_main+0x703>
  800724:	83 ec 04             	sub    $0x4,%esp
  800727:	68 42 2b 80 00       	push   $0x802b42
  80072c:	68 8d 00 00 00       	push   $0x8d
  800731:	68 3c 2a 80 00       	push   $0x802a3c
  800736:	e8 97 07 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80073b:	e8 cc 1b 00 00       	call   80230c <sys_calculate_free_frames>
  800740:	89 c2                	mov    %eax,%edx
  800742:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800745:	39 c2                	cmp    %eax,%edx
  800747:	74 17                	je     800760 <_main+0x728>
  800749:	83 ec 04             	sub    $0x4,%esp
  80074c:	68 90 2b 80 00       	push   $0x802b90
  800751:	68 8e 00 00 00       	push   $0x8e
  800756:	68 3c 2a 80 00       	push   $0x802a3c
  80075b:	e8 72 07 00 00       	call   800ed2 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800760:	e8 a7 1b 00 00       	call   80230c <sys_calculate_free_frames>
  800765:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800768:	e8 22 1c 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80076d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800770:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800773:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800776:	83 ec 0c             	sub    $0xc,%esp
  800779:	50                   	push   %eax
  80077a:	e8 cb 17 00 00       	call   801f4a <malloc>
  80077f:	83 c4 10             	add    $0x10,%esp
  800782:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800785:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800788:	89 c2                	mov    %eax,%edx
  80078a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80078d:	c1 e0 02             	shl    $0x2,%eax
  800790:	05 00 00 00 80       	add    $0x80000000,%eax
  800795:	39 c2                	cmp    %eax,%edx
  800797:	74 17                	je     8007b0 <_main+0x778>
  800799:	83 ec 04             	sub    $0x4,%esp
  80079c:	68 60 2b 80 00       	push   $0x802b60
  8007a1:	68 94 00 00 00       	push   $0x94
  8007a6:	68 3c 2a 80 00       	push   $0x802a3c
  8007ab:	e8 22 07 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007b0:	e8 da 1b 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8007b5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8007b8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007bd:	74 17                	je     8007d6 <_main+0x79e>
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	68 42 2b 80 00       	push   $0x802b42
  8007c7:	68 96 00 00 00       	push   $0x96
  8007cc:	68 3c 2a 80 00       	push   $0x802a3c
  8007d1:	e8 fc 06 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007d6:	e8 31 1b 00 00       	call   80230c <sys_calculate_free_frames>
  8007db:	89 c2                	mov    %eax,%edx
  8007dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007e0:	39 c2                	cmp    %eax,%edx
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 90 2b 80 00       	push   $0x802b90
  8007ec:	68 97 00 00 00       	push   $0x97
  8007f1:	68 3c 2a 80 00       	push   $0x802a3c
  8007f6:	e8 d7 06 00 00       	call   800ed2 <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007fb:	e8 0c 1b 00 00       	call   80230c <sys_calculate_free_frames>
  800800:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800803:	e8 87 1b 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800808:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  80080b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80080e:	89 d0                	mov    %edx,%eax
  800810:	c1 e0 08             	shl    $0x8,%eax
  800813:	29 d0                	sub    %edx,%eax
  800815:	83 ec 0c             	sub    $0xc,%esp
  800818:	50                   	push   %eax
  800819:	e8 2c 17 00 00       	call   801f4a <malloc>
  80081e:	83 c4 10             	add    $0x10,%esp
  800821:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800824:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800827:	89 c2                	mov    %eax,%edx
  800829:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80082c:	c1 e0 09             	shl    $0x9,%eax
  80082f:	89 c1                	mov    %eax,%ecx
  800831:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800834:	01 c8                	add    %ecx,%eax
  800836:	05 00 00 00 80       	add    $0x80000000,%eax
  80083b:	39 c2                	cmp    %eax,%edx
  80083d:	74 17                	je     800856 <_main+0x81e>
  80083f:	83 ec 04             	sub    $0x4,%esp
  800842:	68 60 2b 80 00       	push   $0x802b60
  800847:	68 9d 00 00 00       	push   $0x9d
  80084c:	68 3c 2a 80 00       	push   $0x802a3c
  800851:	e8 7c 06 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800856:	e8 34 1b 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80085b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80085e:	83 f8 40             	cmp    $0x40,%eax
  800861:	74 17                	je     80087a <_main+0x842>
  800863:	83 ec 04             	sub    $0x4,%esp
  800866:	68 42 2b 80 00       	push   $0x802b42
  80086b:	68 9f 00 00 00       	push   $0x9f
  800870:	68 3c 2a 80 00       	push   $0x802a3c
  800875:	e8 58 06 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80087a:	e8 8d 1a 00 00       	call   80230c <sys_calculate_free_frames>
  80087f:	89 c2                	mov    %eax,%edx
  800881:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800884:	39 c2                	cmp    %eax,%edx
  800886:	74 17                	je     80089f <_main+0x867>
  800888:	83 ec 04             	sub    $0x4,%esp
  80088b:	68 90 2b 80 00       	push   $0x802b90
  800890:	68 a0 00 00 00       	push   $0xa0
  800895:	68 3c 2a 80 00       	push   $0x802a3c
  80089a:	e8 33 06 00 00       	call   800ed2 <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80089f:	e8 68 1a 00 00       	call   80230c <sys_calculate_free_frames>
  8008a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008a7:	e8 e3 1a 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8008ac:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  8008af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008b2:	01 c0                	add    %eax,%eax
  8008b4:	83 ec 0c             	sub    $0xc,%esp
  8008b7:	50                   	push   %eax
  8008b8:	e8 8d 16 00 00       	call   801f4a <malloc>
  8008bd:	83 c4 10             	add    $0x10,%esp
  8008c0:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008c3:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8008c6:	89 c2                	mov    %eax,%edx
  8008c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008cb:	c1 e0 03             	shl    $0x3,%eax
  8008ce:	05 00 00 00 80       	add    $0x80000000,%eax
  8008d3:	39 c2                	cmp    %eax,%edx
  8008d5:	74 17                	je     8008ee <_main+0x8b6>
  8008d7:	83 ec 04             	sub    $0x4,%esp
  8008da:	68 60 2b 80 00       	push   $0x802b60
  8008df:	68 a6 00 00 00       	push   $0xa6
  8008e4:	68 3c 2a 80 00       	push   $0x802a3c
  8008e9:	e8 e4 05 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008ee:	e8 9c 1a 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8008f3:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008f6:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008fb:	74 17                	je     800914 <_main+0x8dc>
  8008fd:	83 ec 04             	sub    $0x4,%esp
  800900:	68 42 2b 80 00       	push   $0x802b42
  800905:	68 a8 00 00 00       	push   $0xa8
  80090a:	68 3c 2a 80 00       	push   $0x802a3c
  80090f:	e8 be 05 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800914:	e8 f3 19 00 00       	call   80230c <sys_calculate_free_frames>
  800919:	89 c2                	mov    %eax,%edx
  80091b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091e:	39 c2                	cmp    %eax,%edx
  800920:	74 17                	je     800939 <_main+0x901>
  800922:	83 ec 04             	sub    $0x4,%esp
  800925:	68 90 2b 80 00       	push   $0x802b90
  80092a:	68 a9 00 00 00       	push   $0xa9
  80092f:	68 3c 2a 80 00       	push   $0x802a3c
  800934:	e8 99 05 00 00       	call   800ed2 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800939:	e8 ce 19 00 00       	call   80230c <sys_calculate_free_frames>
  80093e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800941:	e8 49 1a 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800946:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  800949:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80094c:	c1 e0 02             	shl    $0x2,%eax
  80094f:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800952:	83 ec 0c             	sub    $0xc,%esp
  800955:	50                   	push   %eax
  800956:	e8 ef 15 00 00       	call   801f4a <malloc>
  80095b:	83 c4 10             	add    $0x10,%esp
  80095e:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  800961:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800964:	89 c1                	mov    %eax,%ecx
  800966:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800969:	89 d0                	mov    %edx,%eax
  80096b:	01 c0                	add    %eax,%eax
  80096d:	01 d0                	add    %edx,%eax
  80096f:	01 c0                	add    %eax,%eax
  800971:	01 d0                	add    %edx,%eax
  800973:	01 c0                	add    %eax,%eax
  800975:	05 00 00 00 80       	add    $0x80000000,%eax
  80097a:	39 c1                	cmp    %eax,%ecx
  80097c:	74 17                	je     800995 <_main+0x95d>
  80097e:	83 ec 04             	sub    $0x4,%esp
  800981:	68 60 2b 80 00       	push   $0x802b60
  800986:	68 af 00 00 00       	push   $0xaf
  80098b:	68 3c 2a 80 00       	push   $0x802a3c
  800990:	e8 3d 05 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800995:	e8 f5 19 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  80099a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80099d:	3d 00 04 00 00       	cmp    $0x400,%eax
  8009a2:	74 17                	je     8009bb <_main+0x983>
  8009a4:	83 ec 04             	sub    $0x4,%esp
  8009a7:	68 42 2b 80 00       	push   $0x802b42
  8009ac:	68 b1 00 00 00       	push   $0xb1
  8009b1:	68 3c 2a 80 00       	push   $0x802a3c
  8009b6:	e8 17 05 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: ");
  8009bb:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8009be:	e8 49 19 00 00       	call   80230c <sys_calculate_free_frames>
  8009c3:	29 c3                	sub    %eax,%ebx
  8009c5:	89 d8                	mov    %ebx,%eax
  8009c7:	83 f8 02             	cmp    $0x2,%eax
  8009ca:	74 17                	je     8009e3 <_main+0x9ab>
  8009cc:	83 ec 04             	sub    $0x4,%esp
  8009cf:	68 90 2b 80 00       	push   $0x802b90
  8009d4:	68 b2 00 00 00       	push   $0xb2
  8009d9:	68 3c 2a 80 00       	push   $0x802a3c
  8009de:	e8 ef 04 00 00       	call   800ed2 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009e3:	e8 24 19 00 00       	call   80230c <sys_calculate_free_frames>
  8009e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009eb:	e8 9f 19 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  8009f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[2]);
  8009f3:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8009f6:	83 ec 0c             	sub    $0xc,%esp
  8009f9:	50                   	push   %eax
  8009fa:	e8 6c 16 00 00       	call   80206b <free>
  8009ff:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a02:	e8 88 19 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800a07:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800a0a:	29 c2                	sub    %eax,%edx
  800a0c:	89 d0                	mov    %edx,%eax
  800a0e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a13:	74 17                	je     800a2c <_main+0x9f4>
  800a15:	83 ec 04             	sub    $0x4,%esp
  800a18:	68 a7 2b 80 00       	push   $0x802ba7
  800a1d:	68 bc 00 00 00       	push   $0xbc
  800a22:	68 3c 2a 80 00       	push   $0x802a3c
  800a27:	e8 a6 04 00 00       	call   800ed2 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a2c:	e8 db 18 00 00       	call   80230c <sys_calculate_free_frames>
  800a31:	89 c2                	mov    %eax,%edx
  800a33:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a36:	39 c2                	cmp    %eax,%edx
  800a38:	74 17                	je     800a51 <_main+0xa19>
  800a3a:	83 ec 04             	sub    $0x4,%esp
  800a3d:	68 be 2b 80 00       	push   $0x802bbe
  800a42:	68 bd 00 00 00       	push   $0xbd
  800a47:	68 3c 2a 80 00       	push   $0x802a3c
  800a4c:	e8 81 04 00 00       	call   800ed2 <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a51:	e8 b6 18 00 00       	call   80230c <sys_calculate_free_frames>
  800a56:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a59:	e8 31 19 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800a5e:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[9]);
  800a61:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800a64:	83 ec 0c             	sub    $0xc,%esp
  800a67:	50                   	push   %eax
  800a68:	e8 fe 15 00 00       	call   80206b <free>
  800a6d:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a70:	e8 1a 19 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800a75:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800a78:	29 c2                	sub    %eax,%edx
  800a7a:	89 d0                	mov    %edx,%eax
  800a7c:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a81:	74 17                	je     800a9a <_main+0xa62>
  800a83:	83 ec 04             	sub    $0x4,%esp
  800a86:	68 a7 2b 80 00       	push   $0x802ba7
  800a8b:	68 c4 00 00 00       	push   $0xc4
  800a90:	68 3c 2a 80 00       	push   $0x802a3c
  800a95:	e8 38 04 00 00       	call   800ed2 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a9a:	e8 6d 18 00 00       	call   80230c <sys_calculate_free_frames>
  800a9f:	89 c2                	mov    %eax,%edx
  800aa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa4:	39 c2                	cmp    %eax,%edx
  800aa6:	74 17                	je     800abf <_main+0xa87>
  800aa8:	83 ec 04             	sub    $0x4,%esp
  800aab:	68 be 2b 80 00       	push   $0x802bbe
  800ab0:	68 c5 00 00 00       	push   $0xc5
  800ab5:	68 3c 2a 80 00       	push   $0x802a3c
  800aba:	e8 13 04 00 00       	call   800ed2 <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800abf:	e8 48 18 00 00       	call   80230c <sys_calculate_free_frames>
  800ac4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ac7:	e8 c3 18 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800acc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[3]);
  800acf:	8b 45 98             	mov    -0x68(%ebp),%eax
  800ad2:	83 ec 0c             	sub    $0xc,%esp
  800ad5:	50                   	push   %eax
  800ad6:	e8 90 15 00 00       	call   80206b <free>
  800adb:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800ade:	e8 ac 18 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800ae3:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800ae6:	29 c2                	sub    %eax,%edx
  800ae8:	89 d0                	mov    %edx,%eax
  800aea:	3d 00 01 00 00       	cmp    $0x100,%eax
  800aef:	74 17                	je     800b08 <_main+0xad0>
  800af1:	83 ec 04             	sub    $0x4,%esp
  800af4:	68 a7 2b 80 00       	push   $0x802ba7
  800af9:	68 cc 00 00 00       	push   $0xcc
  800afe:	68 3c 2a 80 00       	push   $0x802a3c
  800b03:	e8 ca 03 00 00       	call   800ed2 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800b08:	e8 ff 17 00 00       	call   80230c <sys_calculate_free_frames>
  800b0d:	89 c2                	mov    %eax,%edx
  800b0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b12:	39 c2                	cmp    %eax,%edx
  800b14:	74 17                	je     800b2d <_main+0xaf5>
  800b16:	83 ec 04             	sub    $0x4,%esp
  800b19:	68 be 2b 80 00       	push   $0x802bbe
  800b1e:	68 cd 00 00 00       	push   $0xcd
  800b23:	68 3c 2a 80 00       	push   $0x802a3c
  800b28:	e8 a5 03 00 00       	call   800ed2 <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 1 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b2d:	e8 da 17 00 00       	call   80230c <sys_calculate_free_frames>
  800b32:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b35:	e8 55 18 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800b3a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[13] = malloc(1*Mega + 256*kilo - kilo);
  800b3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b40:	c1 e0 08             	shl    $0x8,%eax
  800b43:	89 c2                	mov    %eax,%edx
  800b45:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b48:	01 d0                	add    %edx,%eax
  800b4a:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800b4d:	83 ec 0c             	sub    $0xc,%esp
  800b50:	50                   	push   %eax
  800b51:	e8 f4 13 00 00       	call   801f4a <malloc>
  800b56:	83 c4 10             	add    $0x10,%esp
  800b59:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b5c:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800b5f:	89 c1                	mov    %eax,%ecx
  800b61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800b64:	89 d0                	mov    %edx,%eax
  800b66:	01 c0                	add    %eax,%eax
  800b68:	01 d0                	add    %edx,%eax
  800b6a:	c1 e0 08             	shl    $0x8,%eax
  800b6d:	89 c2                	mov    %eax,%edx
  800b6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b72:	01 d0                	add    %edx,%eax
  800b74:	05 00 00 00 80       	add    $0x80000000,%eax
  800b79:	39 c1                	cmp    %eax,%ecx
  800b7b:	74 17                	je     800b94 <_main+0xb5c>
  800b7d:	83 ec 04             	sub    $0x4,%esp
  800b80:	68 60 2b 80 00       	push   $0x802b60
  800b85:	68 d7 00 00 00       	push   $0xd7
  800b8a:	68 3c 2a 80 00       	push   $0x802a3c
  800b8f:	e8 3e 03 00 00       	call   800ed2 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256+64) panic("Wrong page file allocation: ");
  800b94:	e8 f6 17 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800b99:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800b9c:	3d 40 01 00 00       	cmp    $0x140,%eax
  800ba1:	74 17                	je     800bba <_main+0xb82>
  800ba3:	83 ec 04             	sub    $0x4,%esp
  800ba6:	68 42 2b 80 00       	push   $0x802b42
  800bab:	68 d9 00 00 00       	push   $0xd9
  800bb0:	68 3c 2a 80 00       	push   $0x802a3c
  800bb5:	e8 18 03 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800bba:	e8 4d 17 00 00       	call   80230c <sys_calculate_free_frames>
  800bbf:	89 c2                	mov    %eax,%edx
  800bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc4:	39 c2                	cmp    %eax,%edx
  800bc6:	74 17                	je     800bdf <_main+0xba7>
  800bc8:	83 ec 04             	sub    $0x4,%esp
  800bcb:	68 90 2b 80 00       	push   $0x802b90
  800bd0:	68 da 00 00 00       	push   $0xda
  800bd5:	68 3c 2a 80 00       	push   $0x802a3c
  800bda:	e8 f3 02 00 00       	call   800ed2 <_panic>

		//Allocate Shared 4 MB [should be placed at the end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800bdf:	e8 28 17 00 00       	call   80230c <sys_calculate_free_frames>
  800be4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800be7:	e8 a3 17 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800bec:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[14] = smalloc("w", 4*Mega, 0);
  800bef:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800bf2:	c1 e0 02             	shl    $0x2,%eax
  800bf5:	83 ec 04             	sub    $0x4,%esp
  800bf8:	6a 00                	push   $0x0
  800bfa:	50                   	push   %eax
  800bfb:	68 cb 2b 80 00       	push   $0x802bcb
  800c00:	e8 0b 13 00 00       	call   801f10 <smalloc>
  800c05:	83 c4 10             	add    $0x10,%esp
  800c08:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if (ptr_allocations[14] != (uint32*)(USER_HEAP_START + 18*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800c0b:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  800c0e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800c11:	89 d0                	mov    %edx,%eax
  800c13:	c1 e0 03             	shl    $0x3,%eax
  800c16:	01 d0                	add    %edx,%eax
  800c18:	01 c0                	add    %eax,%eax
  800c1a:	05 00 00 00 80       	add    $0x80000000,%eax
  800c1f:	39 c1                	cmp    %eax,%ecx
  800c21:	74 17                	je     800c3a <_main+0xc02>
  800c23:	83 ec 04             	sub    $0x4,%esp
  800c26:	68 58 2a 80 00       	push   $0x802a58
  800c2b:	68 e0 00 00 00       	push   $0xe0
  800c30:	68 3c 2a 80 00       	push   $0x802a3c
  800c35:	e8 98 02 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1024+2+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800c3a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800c3d:	e8 ca 16 00 00       	call   80230c <sys_calculate_free_frames>
  800c42:	29 c3                	sub    %eax,%ebx
  800c44:	89 d8                	mov    %ebx,%eax
  800c46:	3d 04 04 00 00       	cmp    $0x404,%eax
  800c4b:	74 17                	je     800c64 <_main+0xc2c>
  800c4d:	83 ec 04             	sub    $0x4,%esp
  800c50:	68 c4 2a 80 00       	push   $0x802ac4
  800c55:	68 e1 00 00 00       	push   $0xe1
  800c5a:	68 3c 2a 80 00       	push   $0x802a3c
  800c5f:	e8 6e 02 00 00       	call   800ed2 <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800c64:	e8 26 17 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800c69:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800c6c:	74 17                	je     800c85 <_main+0xc4d>
  800c6e:	83 ec 04             	sub    $0x4,%esp
  800c71:	68 42 2b 80 00       	push   $0x802b42
  800c76:	68 e2 00 00 00       	push   $0xe2
  800c7b:	68 3c 2a 80 00       	push   $0x802a3c
  800c80:	e8 4d 02 00 00       	call   800ed2 <_panic>

		//Get shared of 3 MB [should be placed in the remaining part of the contiguous (256 KB + 4 MB) hole
		freeFrames = sys_calculate_free_frames() ;
  800c85:	e8 82 16 00 00       	call   80230c <sys_calculate_free_frames>
  800c8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800c8d:	e8 fd 16 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800c92:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[15] = sget(envID, "z");
  800c95:	83 ec 08             	sub    $0x8,%esp
  800c98:	68 a5 2b 80 00       	push   $0x802ba5
  800c9d:	ff 75 ec             	pushl  -0x14(%ebp)
  800ca0:	e8 8b 12 00 00       	call   801f30 <sget>
  800ca5:	83 c4 10             	add    $0x10,%esp
  800ca8:	89 45 c8             	mov    %eax,-0x38(%ebp)
		if (ptr_allocations[15] != (uint32*)(USER_HEAP_START + 3*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800cab:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800cae:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800cb1:	89 c1                	mov    %eax,%ecx
  800cb3:	01 c9                	add    %ecx,%ecx
  800cb5:	01 c8                	add    %ecx,%eax
  800cb7:	05 00 00 00 80       	add    $0x80000000,%eax
  800cbc:	39 c2                	cmp    %eax,%edx
  800cbe:	74 17                	je     800cd7 <_main+0xc9f>
  800cc0:	83 ec 04             	sub    $0x4,%esp
  800cc3:	68 58 2a 80 00       	push   $0x802a58
  800cc8:	68 e8 00 00 00       	push   $0xe8
  800ccd:	68 3c 2a 80 00       	push   $0x802a3c
  800cd2:	e8 fb 01 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0+0+0) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800cd7:	e8 30 16 00 00       	call   80230c <sys_calculate_free_frames>
  800cdc:	89 c2                	mov    %eax,%edx
  800cde:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ce1:	39 c2                	cmp    %eax,%edx
  800ce3:	74 17                	je     800cfc <_main+0xcc4>
  800ce5:	83 ec 04             	sub    $0x4,%esp
  800ce8:	68 c4 2a 80 00       	push   $0x802ac4
  800ced:	68 e9 00 00 00       	push   $0xe9
  800cf2:	68 3c 2a 80 00       	push   $0x802a3c
  800cf7:	e8 d6 01 00 00       	call   800ed2 <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800cfc:	e8 8e 16 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800d01:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800d04:	74 17                	je     800d1d <_main+0xce5>
  800d06:	83 ec 04             	sub    $0x4,%esp
  800d09:	68 42 2b 80 00       	push   $0x802b42
  800d0e:	68 ea 00 00 00       	push   $0xea
  800d13:	68 3c 2a 80 00       	push   $0x802a3c
  800d18:	e8 b5 01 00 00       	call   800ed2 <_panic>

		//Get shared of 1st 1 MB [should be placed in the remaining part of the 3 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800d1d:	e8 ea 15 00 00       	call   80230c <sys_calculate_free_frames>
  800d22:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800d25:	e8 65 16 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800d2a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[16] = sget(envID, "x");
  800d2d:	83 ec 08             	sub    $0x8,%esp
  800d30:	68 53 2a 80 00       	push   $0x802a53
  800d35:	ff 75 ec             	pushl  -0x14(%ebp)
  800d38:	e8 f3 11 00 00       	call   801f30 <sget>
  800d3d:	83 c4 10             	add    $0x10,%esp
  800d40:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if (ptr_allocations[16] != (uint32*)(USER_HEAP_START + 10*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800d43:	8b 4d cc             	mov    -0x34(%ebp),%ecx
  800d46:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d49:	89 d0                	mov    %edx,%eax
  800d4b:	c1 e0 02             	shl    $0x2,%eax
  800d4e:	01 d0                	add    %edx,%eax
  800d50:	01 c0                	add    %eax,%eax
  800d52:	05 00 00 00 80       	add    $0x80000000,%eax
  800d57:	39 c1                	cmp    %eax,%ecx
  800d59:	74 17                	je     800d72 <_main+0xd3a>
  800d5b:	83 ec 04             	sub    $0x4,%esp
  800d5e:	68 58 2a 80 00       	push   $0x802a58
  800d63:	68 f0 00 00 00       	push   $0xf0
  800d68:	68 3c 2a 80 00       	push   $0x802a3c
  800d6d:	e8 60 01 00 00       	call   800ed2 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0+0+0) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800d72:	e8 95 15 00 00       	call   80230c <sys_calculate_free_frames>
  800d77:	89 c2                	mov    %eax,%edx
  800d79:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d7c:	39 c2                	cmp    %eax,%edx
  800d7e:	74 17                	je     800d97 <_main+0xd5f>
  800d80:	83 ec 04             	sub    $0x4,%esp
  800d83:	68 c4 2a 80 00       	push   $0x802ac4
  800d88:	68 f1 00 00 00       	push   $0xf1
  800d8d:	68 3c 2a 80 00       	push   $0x802a3c
  800d92:	e8 3b 01 00 00       	call   800ed2 <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800d97:	e8 f3 15 00 00       	call   80238f <sys_pf_calculate_allocated_pages>
  800d9c:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800d9f:	74 17                	je     800db8 <_main+0xd80>
  800da1:	83 ec 04             	sub    $0x4,%esp
  800da4:	68 42 2b 80 00       	push   $0x802b42
  800da9:	68 f2 00 00 00       	push   $0xf2
  800dae:	68 3c 2a 80 00       	push   $0x802a3c
  800db3:	e8 1a 01 00 00       	call   800ed2 <_panic>

	}
	cprintf("Congratulations!! test FIRST FIT allocation (3) completed successfully.\n");
  800db8:	83 ec 0c             	sub    $0xc,%esp
  800dbb:	68 d0 2b 80 00       	push   $0x802bd0
  800dc0:	e8 c1 03 00 00       	call   801186 <cprintf>
  800dc5:	83 c4 10             	add    $0x10,%esp

	return;
  800dc8:	90                   	nop
}
  800dc9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dcc:	5b                   	pop    %ebx
  800dcd:	5f                   	pop    %edi
  800dce:	5d                   	pop    %ebp
  800dcf:	c3                   	ret    

00800dd0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800dd0:	55                   	push   %ebp
  800dd1:	89 e5                	mov    %esp,%ebp
  800dd3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800dd6:	e8 66 14 00 00       	call   802241 <sys_getenvindex>
  800ddb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800dde:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de1:	89 d0                	mov    %edx,%eax
  800de3:	01 c0                	add    %eax,%eax
  800de5:	01 d0                	add    %edx,%eax
  800de7:	c1 e0 02             	shl    $0x2,%eax
  800dea:	01 d0                	add    %edx,%eax
  800dec:	c1 e0 06             	shl    $0x6,%eax
  800def:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800df4:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800df9:	a1 20 40 80 00       	mov    0x804020,%eax
  800dfe:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800e04:	84 c0                	test   %al,%al
  800e06:	74 0f                	je     800e17 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800e08:	a1 20 40 80 00       	mov    0x804020,%eax
  800e0d:	05 f4 02 00 00       	add    $0x2f4,%eax
  800e12:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800e17:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e1b:	7e 0a                	jle    800e27 <libmain+0x57>
		binaryname = argv[0];
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800e27:	83 ec 08             	sub    $0x8,%esp
  800e2a:	ff 75 0c             	pushl  0xc(%ebp)
  800e2d:	ff 75 08             	pushl  0x8(%ebp)
  800e30:	e8 03 f2 ff ff       	call   800038 <_main>
  800e35:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800e38:	e8 9f 15 00 00       	call   8023dc <sys_disable_interrupt>
	cprintf("**************************************\n");
  800e3d:	83 ec 0c             	sub    $0xc,%esp
  800e40:	68 34 2c 80 00       	push   $0x802c34
  800e45:	e8 3c 03 00 00       	call   801186 <cprintf>
  800e4a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800e4d:	a1 20 40 80 00       	mov    0x804020,%eax
  800e52:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800e58:	a1 20 40 80 00       	mov    0x804020,%eax
  800e5d:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800e63:	83 ec 04             	sub    $0x4,%esp
  800e66:	52                   	push   %edx
  800e67:	50                   	push   %eax
  800e68:	68 5c 2c 80 00       	push   $0x802c5c
  800e6d:	e8 14 03 00 00       	call   801186 <cprintf>
  800e72:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800e75:	a1 20 40 80 00       	mov    0x804020,%eax
  800e7a:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800e80:	83 ec 08             	sub    $0x8,%esp
  800e83:	50                   	push   %eax
  800e84:	68 81 2c 80 00       	push   $0x802c81
  800e89:	e8 f8 02 00 00       	call   801186 <cprintf>
  800e8e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800e91:	83 ec 0c             	sub    $0xc,%esp
  800e94:	68 34 2c 80 00       	push   $0x802c34
  800e99:	e8 e8 02 00 00       	call   801186 <cprintf>
  800e9e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800ea1:	e8 50 15 00 00       	call   8023f6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800ea6:	e8 19 00 00 00       	call   800ec4 <exit>
}
  800eab:	90                   	nop
  800eac:	c9                   	leave  
  800ead:	c3                   	ret    

00800eae <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
  800eb1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800eb4:	83 ec 0c             	sub    $0xc,%esp
  800eb7:	6a 00                	push   $0x0
  800eb9:	e8 4f 13 00 00       	call   80220d <sys_env_destroy>
  800ebe:	83 c4 10             	add    $0x10,%esp
}
  800ec1:	90                   	nop
  800ec2:	c9                   	leave  
  800ec3:	c3                   	ret    

00800ec4 <exit>:

void
exit(void)
{
  800ec4:	55                   	push   %ebp
  800ec5:	89 e5                	mov    %esp,%ebp
  800ec7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800eca:	e8 a4 13 00 00       	call   802273 <sys_env_exit>
}
  800ecf:	90                   	nop
  800ed0:	c9                   	leave  
  800ed1:	c3                   	ret    

00800ed2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800ed2:	55                   	push   %ebp
  800ed3:	89 e5                	mov    %esp,%ebp
  800ed5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800ed8:	8d 45 10             	lea    0x10(%ebp),%eax
  800edb:	83 c0 04             	add    $0x4,%eax
  800ede:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800ee1:	a1 30 40 80 00       	mov    0x804030,%eax
  800ee6:	85 c0                	test   %eax,%eax
  800ee8:	74 16                	je     800f00 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800eea:	a1 30 40 80 00       	mov    0x804030,%eax
  800eef:	83 ec 08             	sub    $0x8,%esp
  800ef2:	50                   	push   %eax
  800ef3:	68 98 2c 80 00       	push   $0x802c98
  800ef8:	e8 89 02 00 00       	call   801186 <cprintf>
  800efd:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800f00:	a1 00 40 80 00       	mov    0x804000,%eax
  800f05:	ff 75 0c             	pushl  0xc(%ebp)
  800f08:	ff 75 08             	pushl  0x8(%ebp)
  800f0b:	50                   	push   %eax
  800f0c:	68 9d 2c 80 00       	push   $0x802c9d
  800f11:	e8 70 02 00 00       	call   801186 <cprintf>
  800f16:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800f19:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1c:	83 ec 08             	sub    $0x8,%esp
  800f1f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f22:	50                   	push   %eax
  800f23:	e8 f3 01 00 00       	call   80111b <vcprintf>
  800f28:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800f2b:	83 ec 08             	sub    $0x8,%esp
  800f2e:	6a 00                	push   $0x0
  800f30:	68 b9 2c 80 00       	push   $0x802cb9
  800f35:	e8 e1 01 00 00       	call   80111b <vcprintf>
  800f3a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800f3d:	e8 82 ff ff ff       	call   800ec4 <exit>

	// should not return here
	while (1) ;
  800f42:	eb fe                	jmp    800f42 <_panic+0x70>

00800f44 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800f44:	55                   	push   %ebp
  800f45:	89 e5                	mov    %esp,%ebp
  800f47:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800f4a:	a1 20 40 80 00       	mov    0x804020,%eax
  800f4f:	8b 50 74             	mov    0x74(%eax),%edx
  800f52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f55:	39 c2                	cmp    %eax,%edx
  800f57:	74 14                	je     800f6d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800f59:	83 ec 04             	sub    $0x4,%esp
  800f5c:	68 bc 2c 80 00       	push   $0x802cbc
  800f61:	6a 26                	push   $0x26
  800f63:	68 08 2d 80 00       	push   $0x802d08
  800f68:	e8 65 ff ff ff       	call   800ed2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800f6d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800f74:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800f7b:	e9 c2 00 00 00       	jmp    801042 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800f80:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f83:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	01 d0                	add    %edx,%eax
  800f8f:	8b 00                	mov    (%eax),%eax
  800f91:	85 c0                	test   %eax,%eax
  800f93:	75 08                	jne    800f9d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800f95:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800f98:	e9 a2 00 00 00       	jmp    80103f <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800f9d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800fa4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800fab:	eb 69                	jmp    801016 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800fad:	a1 20 40 80 00       	mov    0x804020,%eax
  800fb2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800fb8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800fbb:	89 d0                	mov    %edx,%eax
  800fbd:	01 c0                	add    %eax,%eax
  800fbf:	01 d0                	add    %edx,%eax
  800fc1:	c1 e0 02             	shl    $0x2,%eax
  800fc4:	01 c8                	add    %ecx,%eax
  800fc6:	8a 40 04             	mov    0x4(%eax),%al
  800fc9:	84 c0                	test   %al,%al
  800fcb:	75 46                	jne    801013 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800fcd:	a1 20 40 80 00       	mov    0x804020,%eax
  800fd2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800fd8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800fdb:	89 d0                	mov    %edx,%eax
  800fdd:	01 c0                	add    %eax,%eax
  800fdf:	01 d0                	add    %edx,%eax
  800fe1:	c1 e0 02             	shl    $0x2,%eax
  800fe4:	01 c8                	add    %ecx,%eax
  800fe6:	8b 00                	mov    (%eax),%eax
  800fe8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800feb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800fee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ff3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ff5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800fff:	8b 45 08             	mov    0x8(%ebp),%eax
  801002:	01 c8                	add    %ecx,%eax
  801004:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801006:	39 c2                	cmp    %eax,%edx
  801008:	75 09                	jne    801013 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80100a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801011:	eb 12                	jmp    801025 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801013:	ff 45 e8             	incl   -0x18(%ebp)
  801016:	a1 20 40 80 00       	mov    0x804020,%eax
  80101b:	8b 50 74             	mov    0x74(%eax),%edx
  80101e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801021:	39 c2                	cmp    %eax,%edx
  801023:	77 88                	ja     800fad <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801025:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801029:	75 14                	jne    80103f <CheckWSWithoutLastIndex+0xfb>
			panic(
  80102b:	83 ec 04             	sub    $0x4,%esp
  80102e:	68 14 2d 80 00       	push   $0x802d14
  801033:	6a 3a                	push   $0x3a
  801035:	68 08 2d 80 00       	push   $0x802d08
  80103a:	e8 93 fe ff ff       	call   800ed2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80103f:	ff 45 f0             	incl   -0x10(%ebp)
  801042:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801045:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801048:	0f 8c 32 ff ff ff    	jl     800f80 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80104e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801055:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80105c:	eb 26                	jmp    801084 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80105e:	a1 20 40 80 00       	mov    0x804020,%eax
  801063:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801069:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80106c:	89 d0                	mov    %edx,%eax
  80106e:	01 c0                	add    %eax,%eax
  801070:	01 d0                	add    %edx,%eax
  801072:	c1 e0 02             	shl    $0x2,%eax
  801075:	01 c8                	add    %ecx,%eax
  801077:	8a 40 04             	mov    0x4(%eax),%al
  80107a:	3c 01                	cmp    $0x1,%al
  80107c:	75 03                	jne    801081 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80107e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801081:	ff 45 e0             	incl   -0x20(%ebp)
  801084:	a1 20 40 80 00       	mov    0x804020,%eax
  801089:	8b 50 74             	mov    0x74(%eax),%edx
  80108c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80108f:	39 c2                	cmp    %eax,%edx
  801091:	77 cb                	ja     80105e <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801093:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801096:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801099:	74 14                	je     8010af <CheckWSWithoutLastIndex+0x16b>
		panic(
  80109b:	83 ec 04             	sub    $0x4,%esp
  80109e:	68 68 2d 80 00       	push   $0x802d68
  8010a3:	6a 44                	push   $0x44
  8010a5:	68 08 2d 80 00       	push   $0x802d08
  8010aa:	e8 23 fe ff ff       	call   800ed2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8010af:	90                   	nop
  8010b0:	c9                   	leave  
  8010b1:	c3                   	ret    

008010b2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
  8010b5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8010b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bb:	8b 00                	mov    (%eax),%eax
  8010bd:	8d 48 01             	lea    0x1(%eax),%ecx
  8010c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c3:	89 0a                	mov    %ecx,(%edx)
  8010c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c8:	88 d1                	mov    %dl,%cl
  8010ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8010d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d4:	8b 00                	mov    (%eax),%eax
  8010d6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8010db:	75 2c                	jne    801109 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8010dd:	a0 24 40 80 00       	mov    0x804024,%al
  8010e2:	0f b6 c0             	movzbl %al,%eax
  8010e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e8:	8b 12                	mov    (%edx),%edx
  8010ea:	89 d1                	mov    %edx,%ecx
  8010ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ef:	83 c2 08             	add    $0x8,%edx
  8010f2:	83 ec 04             	sub    $0x4,%esp
  8010f5:	50                   	push   %eax
  8010f6:	51                   	push   %ecx
  8010f7:	52                   	push   %edx
  8010f8:	e8 ce 10 00 00       	call   8021cb <sys_cputs>
  8010fd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801100:	8b 45 0c             	mov    0xc(%ebp),%eax
  801103:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801109:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110c:	8b 40 04             	mov    0x4(%eax),%eax
  80110f:	8d 50 01             	lea    0x1(%eax),%edx
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	89 50 04             	mov    %edx,0x4(%eax)
}
  801118:	90                   	nop
  801119:	c9                   	leave  
  80111a:	c3                   	ret    

0080111b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80111b:	55                   	push   %ebp
  80111c:	89 e5                	mov    %esp,%ebp
  80111e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801124:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80112b:	00 00 00 
	b.cnt = 0;
  80112e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801135:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801138:	ff 75 0c             	pushl  0xc(%ebp)
  80113b:	ff 75 08             	pushl  0x8(%ebp)
  80113e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801144:	50                   	push   %eax
  801145:	68 b2 10 80 00       	push   $0x8010b2
  80114a:	e8 11 02 00 00       	call   801360 <vprintfmt>
  80114f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801152:	a0 24 40 80 00       	mov    0x804024,%al
  801157:	0f b6 c0             	movzbl %al,%eax
  80115a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801160:	83 ec 04             	sub    $0x4,%esp
  801163:	50                   	push   %eax
  801164:	52                   	push   %edx
  801165:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80116b:	83 c0 08             	add    $0x8,%eax
  80116e:	50                   	push   %eax
  80116f:	e8 57 10 00 00       	call   8021cb <sys_cputs>
  801174:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801177:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80117e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801184:	c9                   	leave  
  801185:	c3                   	ret    

00801186 <cprintf>:

int cprintf(const char *fmt, ...) {
  801186:	55                   	push   %ebp
  801187:	89 e5                	mov    %esp,%ebp
  801189:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80118c:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801193:	8d 45 0c             	lea    0xc(%ebp),%eax
  801196:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801199:	8b 45 08             	mov    0x8(%ebp),%eax
  80119c:	83 ec 08             	sub    $0x8,%esp
  80119f:	ff 75 f4             	pushl  -0xc(%ebp)
  8011a2:	50                   	push   %eax
  8011a3:	e8 73 ff ff ff       	call   80111b <vcprintf>
  8011a8:	83 c4 10             	add    $0x10,%esp
  8011ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8011ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011b1:	c9                   	leave  
  8011b2:	c3                   	ret    

008011b3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8011b3:	55                   	push   %ebp
  8011b4:	89 e5                	mov    %esp,%ebp
  8011b6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011b9:	e8 1e 12 00 00       	call   8023dc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8011be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8011c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	83 ec 08             	sub    $0x8,%esp
  8011ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8011cd:	50                   	push   %eax
  8011ce:	e8 48 ff ff ff       	call   80111b <vcprintf>
  8011d3:	83 c4 10             	add    $0x10,%esp
  8011d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8011d9:	e8 18 12 00 00       	call   8023f6 <sys_enable_interrupt>
	return cnt;
  8011de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
  8011e6:	53                   	push   %ebx
  8011e7:	83 ec 14             	sub    $0x14,%esp
  8011ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8011f6:	8b 45 18             	mov    0x18(%ebp),%eax
  8011f9:	ba 00 00 00 00       	mov    $0x0,%edx
  8011fe:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801201:	77 55                	ja     801258 <printnum+0x75>
  801203:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801206:	72 05                	jb     80120d <printnum+0x2a>
  801208:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80120b:	77 4b                	ja     801258 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80120d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801210:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801213:	8b 45 18             	mov    0x18(%ebp),%eax
  801216:	ba 00 00 00 00       	mov    $0x0,%edx
  80121b:	52                   	push   %edx
  80121c:	50                   	push   %eax
  80121d:	ff 75 f4             	pushl  -0xc(%ebp)
  801220:	ff 75 f0             	pushl  -0x10(%ebp)
  801223:	e8 94 15 00 00       	call   8027bc <__udivdi3>
  801228:	83 c4 10             	add    $0x10,%esp
  80122b:	83 ec 04             	sub    $0x4,%esp
  80122e:	ff 75 20             	pushl  0x20(%ebp)
  801231:	53                   	push   %ebx
  801232:	ff 75 18             	pushl  0x18(%ebp)
  801235:	52                   	push   %edx
  801236:	50                   	push   %eax
  801237:	ff 75 0c             	pushl  0xc(%ebp)
  80123a:	ff 75 08             	pushl  0x8(%ebp)
  80123d:	e8 a1 ff ff ff       	call   8011e3 <printnum>
  801242:	83 c4 20             	add    $0x20,%esp
  801245:	eb 1a                	jmp    801261 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801247:	83 ec 08             	sub    $0x8,%esp
  80124a:	ff 75 0c             	pushl  0xc(%ebp)
  80124d:	ff 75 20             	pushl  0x20(%ebp)
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	ff d0                	call   *%eax
  801255:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801258:	ff 4d 1c             	decl   0x1c(%ebp)
  80125b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80125f:	7f e6                	jg     801247 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801261:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801264:	bb 00 00 00 00       	mov    $0x0,%ebx
  801269:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80126c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80126f:	53                   	push   %ebx
  801270:	51                   	push   %ecx
  801271:	52                   	push   %edx
  801272:	50                   	push   %eax
  801273:	e8 54 16 00 00       	call   8028cc <__umoddi3>
  801278:	83 c4 10             	add    $0x10,%esp
  80127b:	05 d4 2f 80 00       	add    $0x802fd4,%eax
  801280:	8a 00                	mov    (%eax),%al
  801282:	0f be c0             	movsbl %al,%eax
  801285:	83 ec 08             	sub    $0x8,%esp
  801288:	ff 75 0c             	pushl  0xc(%ebp)
  80128b:	50                   	push   %eax
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	ff d0                	call   *%eax
  801291:	83 c4 10             	add    $0x10,%esp
}
  801294:	90                   	nop
  801295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801298:	c9                   	leave  
  801299:	c3                   	ret    

0080129a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80129d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8012a1:	7e 1c                	jle    8012bf <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	8b 00                	mov    (%eax),%eax
  8012a8:	8d 50 08             	lea    0x8(%eax),%edx
  8012ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ae:	89 10                	mov    %edx,(%eax)
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	8b 00                	mov    (%eax),%eax
  8012b5:	83 e8 08             	sub    $0x8,%eax
  8012b8:	8b 50 04             	mov    0x4(%eax),%edx
  8012bb:	8b 00                	mov    (%eax),%eax
  8012bd:	eb 40                	jmp    8012ff <getuint+0x65>
	else if (lflag)
  8012bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012c3:	74 1e                	je     8012e3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	8b 00                	mov    (%eax),%eax
  8012ca:	8d 50 04             	lea    0x4(%eax),%edx
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	89 10                	mov    %edx,(%eax)
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	8b 00                	mov    (%eax),%eax
  8012d7:	83 e8 04             	sub    $0x4,%eax
  8012da:	8b 00                	mov    (%eax),%eax
  8012dc:	ba 00 00 00 00       	mov    $0x0,%edx
  8012e1:	eb 1c                	jmp    8012ff <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e6:	8b 00                	mov    (%eax),%eax
  8012e8:	8d 50 04             	lea    0x4(%eax),%edx
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	89 10                	mov    %edx,(%eax)
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8b 00                	mov    (%eax),%eax
  8012f5:	83 e8 04             	sub    $0x4,%eax
  8012f8:	8b 00                	mov    (%eax),%eax
  8012fa:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8012ff:	5d                   	pop    %ebp
  801300:	c3                   	ret    

00801301 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801301:	55                   	push   %ebp
  801302:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801304:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801308:	7e 1c                	jle    801326 <getint+0x25>
		return va_arg(*ap, long long);
  80130a:	8b 45 08             	mov    0x8(%ebp),%eax
  80130d:	8b 00                	mov    (%eax),%eax
  80130f:	8d 50 08             	lea    0x8(%eax),%edx
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	89 10                	mov    %edx,(%eax)
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	8b 00                	mov    (%eax),%eax
  80131c:	83 e8 08             	sub    $0x8,%eax
  80131f:	8b 50 04             	mov    0x4(%eax),%edx
  801322:	8b 00                	mov    (%eax),%eax
  801324:	eb 38                	jmp    80135e <getint+0x5d>
	else if (lflag)
  801326:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80132a:	74 1a                	je     801346 <getint+0x45>
		return va_arg(*ap, long);
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	8b 00                	mov    (%eax),%eax
  801331:	8d 50 04             	lea    0x4(%eax),%edx
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	89 10                	mov    %edx,(%eax)
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8b 00                	mov    (%eax),%eax
  80133e:	83 e8 04             	sub    $0x4,%eax
  801341:	8b 00                	mov    (%eax),%eax
  801343:	99                   	cltd   
  801344:	eb 18                	jmp    80135e <getint+0x5d>
	else
		return va_arg(*ap, int);
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8b 00                	mov    (%eax),%eax
  80134b:	8d 50 04             	lea    0x4(%eax),%edx
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	89 10                	mov    %edx,(%eax)
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	8b 00                	mov    (%eax),%eax
  801358:	83 e8 04             	sub    $0x4,%eax
  80135b:	8b 00                	mov    (%eax),%eax
  80135d:	99                   	cltd   
}
  80135e:	5d                   	pop    %ebp
  80135f:	c3                   	ret    

00801360 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	56                   	push   %esi
  801364:	53                   	push   %ebx
  801365:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801368:	eb 17                	jmp    801381 <vprintfmt+0x21>
			if (ch == '\0')
  80136a:	85 db                	test   %ebx,%ebx
  80136c:	0f 84 af 03 00 00    	je     801721 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801372:	83 ec 08             	sub    $0x8,%esp
  801375:	ff 75 0c             	pushl  0xc(%ebp)
  801378:	53                   	push   %ebx
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	ff d0                	call   *%eax
  80137e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801381:	8b 45 10             	mov    0x10(%ebp),%eax
  801384:	8d 50 01             	lea    0x1(%eax),%edx
  801387:	89 55 10             	mov    %edx,0x10(%ebp)
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	0f b6 d8             	movzbl %al,%ebx
  80138f:	83 fb 25             	cmp    $0x25,%ebx
  801392:	75 d6                	jne    80136a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801394:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801398:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80139f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8013a6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8013ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8013b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b7:	8d 50 01             	lea    0x1(%eax),%edx
  8013ba:	89 55 10             	mov    %edx,0x10(%ebp)
  8013bd:	8a 00                	mov    (%eax),%al
  8013bf:	0f b6 d8             	movzbl %al,%ebx
  8013c2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8013c5:	83 f8 55             	cmp    $0x55,%eax
  8013c8:	0f 87 2b 03 00 00    	ja     8016f9 <vprintfmt+0x399>
  8013ce:	8b 04 85 f8 2f 80 00 	mov    0x802ff8(,%eax,4),%eax
  8013d5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8013d7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8013db:	eb d7                	jmp    8013b4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8013dd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8013e1:	eb d1                	jmp    8013b4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8013e3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8013ea:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8013ed:	89 d0                	mov    %edx,%eax
  8013ef:	c1 e0 02             	shl    $0x2,%eax
  8013f2:	01 d0                	add    %edx,%eax
  8013f4:	01 c0                	add    %eax,%eax
  8013f6:	01 d8                	add    %ebx,%eax
  8013f8:	83 e8 30             	sub    $0x30,%eax
  8013fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8013fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801401:	8a 00                	mov    (%eax),%al
  801403:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801406:	83 fb 2f             	cmp    $0x2f,%ebx
  801409:	7e 3e                	jle    801449 <vprintfmt+0xe9>
  80140b:	83 fb 39             	cmp    $0x39,%ebx
  80140e:	7f 39                	jg     801449 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801410:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801413:	eb d5                	jmp    8013ea <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801415:	8b 45 14             	mov    0x14(%ebp),%eax
  801418:	83 c0 04             	add    $0x4,%eax
  80141b:	89 45 14             	mov    %eax,0x14(%ebp)
  80141e:	8b 45 14             	mov    0x14(%ebp),%eax
  801421:	83 e8 04             	sub    $0x4,%eax
  801424:	8b 00                	mov    (%eax),%eax
  801426:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801429:	eb 1f                	jmp    80144a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80142b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80142f:	79 83                	jns    8013b4 <vprintfmt+0x54>
				width = 0;
  801431:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801438:	e9 77 ff ff ff       	jmp    8013b4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80143d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801444:	e9 6b ff ff ff       	jmp    8013b4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801449:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80144a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80144e:	0f 89 60 ff ff ff    	jns    8013b4 <vprintfmt+0x54>
				width = precision, precision = -1;
  801454:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801457:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80145a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801461:	e9 4e ff ff ff       	jmp    8013b4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801466:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801469:	e9 46 ff ff ff       	jmp    8013b4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80146e:	8b 45 14             	mov    0x14(%ebp),%eax
  801471:	83 c0 04             	add    $0x4,%eax
  801474:	89 45 14             	mov    %eax,0x14(%ebp)
  801477:	8b 45 14             	mov    0x14(%ebp),%eax
  80147a:	83 e8 04             	sub    $0x4,%eax
  80147d:	8b 00                	mov    (%eax),%eax
  80147f:	83 ec 08             	sub    $0x8,%esp
  801482:	ff 75 0c             	pushl  0xc(%ebp)
  801485:	50                   	push   %eax
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	ff d0                	call   *%eax
  80148b:	83 c4 10             	add    $0x10,%esp
			break;
  80148e:	e9 89 02 00 00       	jmp    80171c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801493:	8b 45 14             	mov    0x14(%ebp),%eax
  801496:	83 c0 04             	add    $0x4,%eax
  801499:	89 45 14             	mov    %eax,0x14(%ebp)
  80149c:	8b 45 14             	mov    0x14(%ebp),%eax
  80149f:	83 e8 04             	sub    $0x4,%eax
  8014a2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8014a4:	85 db                	test   %ebx,%ebx
  8014a6:	79 02                	jns    8014aa <vprintfmt+0x14a>
				err = -err;
  8014a8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8014aa:	83 fb 64             	cmp    $0x64,%ebx
  8014ad:	7f 0b                	jg     8014ba <vprintfmt+0x15a>
  8014af:	8b 34 9d 40 2e 80 00 	mov    0x802e40(,%ebx,4),%esi
  8014b6:	85 f6                	test   %esi,%esi
  8014b8:	75 19                	jne    8014d3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8014ba:	53                   	push   %ebx
  8014bb:	68 e5 2f 80 00       	push   $0x802fe5
  8014c0:	ff 75 0c             	pushl  0xc(%ebp)
  8014c3:	ff 75 08             	pushl  0x8(%ebp)
  8014c6:	e8 5e 02 00 00       	call   801729 <printfmt>
  8014cb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8014ce:	e9 49 02 00 00       	jmp    80171c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8014d3:	56                   	push   %esi
  8014d4:	68 ee 2f 80 00       	push   $0x802fee
  8014d9:	ff 75 0c             	pushl  0xc(%ebp)
  8014dc:	ff 75 08             	pushl  0x8(%ebp)
  8014df:	e8 45 02 00 00       	call   801729 <printfmt>
  8014e4:	83 c4 10             	add    $0x10,%esp
			break;
  8014e7:	e9 30 02 00 00       	jmp    80171c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8014ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ef:	83 c0 04             	add    $0x4,%eax
  8014f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8014f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f8:	83 e8 04             	sub    $0x4,%eax
  8014fb:	8b 30                	mov    (%eax),%esi
  8014fd:	85 f6                	test   %esi,%esi
  8014ff:	75 05                	jne    801506 <vprintfmt+0x1a6>
				p = "(null)";
  801501:	be f1 2f 80 00       	mov    $0x802ff1,%esi
			if (width > 0 && padc != '-')
  801506:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80150a:	7e 6d                	jle    801579 <vprintfmt+0x219>
  80150c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801510:	74 67                	je     801579 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801512:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801515:	83 ec 08             	sub    $0x8,%esp
  801518:	50                   	push   %eax
  801519:	56                   	push   %esi
  80151a:	e8 0c 03 00 00       	call   80182b <strnlen>
  80151f:	83 c4 10             	add    $0x10,%esp
  801522:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801525:	eb 16                	jmp    80153d <vprintfmt+0x1dd>
					putch(padc, putdat);
  801527:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80152b:	83 ec 08             	sub    $0x8,%esp
  80152e:	ff 75 0c             	pushl  0xc(%ebp)
  801531:	50                   	push   %eax
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	ff d0                	call   *%eax
  801537:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80153a:	ff 4d e4             	decl   -0x1c(%ebp)
  80153d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801541:	7f e4                	jg     801527 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801543:	eb 34                	jmp    801579 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801545:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801549:	74 1c                	je     801567 <vprintfmt+0x207>
  80154b:	83 fb 1f             	cmp    $0x1f,%ebx
  80154e:	7e 05                	jle    801555 <vprintfmt+0x1f5>
  801550:	83 fb 7e             	cmp    $0x7e,%ebx
  801553:	7e 12                	jle    801567 <vprintfmt+0x207>
					putch('?', putdat);
  801555:	83 ec 08             	sub    $0x8,%esp
  801558:	ff 75 0c             	pushl  0xc(%ebp)
  80155b:	6a 3f                	push   $0x3f
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	ff d0                	call   *%eax
  801562:	83 c4 10             	add    $0x10,%esp
  801565:	eb 0f                	jmp    801576 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801567:	83 ec 08             	sub    $0x8,%esp
  80156a:	ff 75 0c             	pushl  0xc(%ebp)
  80156d:	53                   	push   %ebx
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
  801571:	ff d0                	call   *%eax
  801573:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801576:	ff 4d e4             	decl   -0x1c(%ebp)
  801579:	89 f0                	mov    %esi,%eax
  80157b:	8d 70 01             	lea    0x1(%eax),%esi
  80157e:	8a 00                	mov    (%eax),%al
  801580:	0f be d8             	movsbl %al,%ebx
  801583:	85 db                	test   %ebx,%ebx
  801585:	74 24                	je     8015ab <vprintfmt+0x24b>
  801587:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80158b:	78 b8                	js     801545 <vprintfmt+0x1e5>
  80158d:	ff 4d e0             	decl   -0x20(%ebp)
  801590:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801594:	79 af                	jns    801545 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801596:	eb 13                	jmp    8015ab <vprintfmt+0x24b>
				putch(' ', putdat);
  801598:	83 ec 08             	sub    $0x8,%esp
  80159b:	ff 75 0c             	pushl  0xc(%ebp)
  80159e:	6a 20                	push   $0x20
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	ff d0                	call   *%eax
  8015a5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8015a8:	ff 4d e4             	decl   -0x1c(%ebp)
  8015ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015af:	7f e7                	jg     801598 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8015b1:	e9 66 01 00 00       	jmp    80171c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8015b6:	83 ec 08             	sub    $0x8,%esp
  8015b9:	ff 75 e8             	pushl  -0x18(%ebp)
  8015bc:	8d 45 14             	lea    0x14(%ebp),%eax
  8015bf:	50                   	push   %eax
  8015c0:	e8 3c fd ff ff       	call   801301 <getint>
  8015c5:	83 c4 10             	add    $0x10,%esp
  8015c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8015ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015d4:	85 d2                	test   %edx,%edx
  8015d6:	79 23                	jns    8015fb <vprintfmt+0x29b>
				putch('-', putdat);
  8015d8:	83 ec 08             	sub    $0x8,%esp
  8015db:	ff 75 0c             	pushl  0xc(%ebp)
  8015de:	6a 2d                	push   $0x2d
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	ff d0                	call   *%eax
  8015e5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8015e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ee:	f7 d8                	neg    %eax
  8015f0:	83 d2 00             	adc    $0x0,%edx
  8015f3:	f7 da                	neg    %edx
  8015f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8015fb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801602:	e9 bc 00 00 00       	jmp    8016c3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801607:	83 ec 08             	sub    $0x8,%esp
  80160a:	ff 75 e8             	pushl  -0x18(%ebp)
  80160d:	8d 45 14             	lea    0x14(%ebp),%eax
  801610:	50                   	push   %eax
  801611:	e8 84 fc ff ff       	call   80129a <getuint>
  801616:	83 c4 10             	add    $0x10,%esp
  801619:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80161c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80161f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801626:	e9 98 00 00 00       	jmp    8016c3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80162b:	83 ec 08             	sub    $0x8,%esp
  80162e:	ff 75 0c             	pushl  0xc(%ebp)
  801631:	6a 58                	push   $0x58
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	ff d0                	call   *%eax
  801638:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80163b:	83 ec 08             	sub    $0x8,%esp
  80163e:	ff 75 0c             	pushl  0xc(%ebp)
  801641:	6a 58                	push   $0x58
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	ff d0                	call   *%eax
  801648:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80164b:	83 ec 08             	sub    $0x8,%esp
  80164e:	ff 75 0c             	pushl  0xc(%ebp)
  801651:	6a 58                	push   $0x58
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	ff d0                	call   *%eax
  801658:	83 c4 10             	add    $0x10,%esp
			break;
  80165b:	e9 bc 00 00 00       	jmp    80171c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801660:	83 ec 08             	sub    $0x8,%esp
  801663:	ff 75 0c             	pushl  0xc(%ebp)
  801666:	6a 30                	push   $0x30
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	ff d0                	call   *%eax
  80166d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801670:	83 ec 08             	sub    $0x8,%esp
  801673:	ff 75 0c             	pushl  0xc(%ebp)
  801676:	6a 78                	push   $0x78
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	ff d0                	call   *%eax
  80167d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801680:	8b 45 14             	mov    0x14(%ebp),%eax
  801683:	83 c0 04             	add    $0x4,%eax
  801686:	89 45 14             	mov    %eax,0x14(%ebp)
  801689:	8b 45 14             	mov    0x14(%ebp),%eax
  80168c:	83 e8 04             	sub    $0x4,%eax
  80168f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801691:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801694:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80169b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8016a2:	eb 1f                	jmp    8016c3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8016a4:	83 ec 08             	sub    $0x8,%esp
  8016a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8016aa:	8d 45 14             	lea    0x14(%ebp),%eax
  8016ad:	50                   	push   %eax
  8016ae:	e8 e7 fb ff ff       	call   80129a <getuint>
  8016b3:	83 c4 10             	add    $0x10,%esp
  8016b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8016bc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8016c3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8016c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016ca:	83 ec 04             	sub    $0x4,%esp
  8016cd:	52                   	push   %edx
  8016ce:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016d1:	50                   	push   %eax
  8016d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8016d5:	ff 75 f0             	pushl  -0x10(%ebp)
  8016d8:	ff 75 0c             	pushl  0xc(%ebp)
  8016db:	ff 75 08             	pushl  0x8(%ebp)
  8016de:	e8 00 fb ff ff       	call   8011e3 <printnum>
  8016e3:	83 c4 20             	add    $0x20,%esp
			break;
  8016e6:	eb 34                	jmp    80171c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8016e8:	83 ec 08             	sub    $0x8,%esp
  8016eb:	ff 75 0c             	pushl  0xc(%ebp)
  8016ee:	53                   	push   %ebx
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	ff d0                	call   *%eax
  8016f4:	83 c4 10             	add    $0x10,%esp
			break;
  8016f7:	eb 23                	jmp    80171c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8016f9:	83 ec 08             	sub    $0x8,%esp
  8016fc:	ff 75 0c             	pushl  0xc(%ebp)
  8016ff:	6a 25                	push   $0x25
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	ff d0                	call   *%eax
  801706:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801709:	ff 4d 10             	decl   0x10(%ebp)
  80170c:	eb 03                	jmp    801711 <vprintfmt+0x3b1>
  80170e:	ff 4d 10             	decl   0x10(%ebp)
  801711:	8b 45 10             	mov    0x10(%ebp),%eax
  801714:	48                   	dec    %eax
  801715:	8a 00                	mov    (%eax),%al
  801717:	3c 25                	cmp    $0x25,%al
  801719:	75 f3                	jne    80170e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80171b:	90                   	nop
		}
	}
  80171c:	e9 47 fc ff ff       	jmp    801368 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801721:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801722:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801725:	5b                   	pop    %ebx
  801726:	5e                   	pop    %esi
  801727:	5d                   	pop    %ebp
  801728:	c3                   	ret    

00801729 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
  80172c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80172f:	8d 45 10             	lea    0x10(%ebp),%eax
  801732:	83 c0 04             	add    $0x4,%eax
  801735:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801738:	8b 45 10             	mov    0x10(%ebp),%eax
  80173b:	ff 75 f4             	pushl  -0xc(%ebp)
  80173e:	50                   	push   %eax
  80173f:	ff 75 0c             	pushl  0xc(%ebp)
  801742:	ff 75 08             	pushl  0x8(%ebp)
  801745:	e8 16 fc ff ff       	call   801360 <vprintfmt>
  80174a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80174d:	90                   	nop
  80174e:	c9                   	leave  
  80174f:	c3                   	ret    

00801750 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801750:	55                   	push   %ebp
  801751:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	8b 40 08             	mov    0x8(%eax),%eax
  801759:	8d 50 01             	lea    0x1(%eax),%edx
  80175c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801762:	8b 45 0c             	mov    0xc(%ebp),%eax
  801765:	8b 10                	mov    (%eax),%edx
  801767:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176a:	8b 40 04             	mov    0x4(%eax),%eax
  80176d:	39 c2                	cmp    %eax,%edx
  80176f:	73 12                	jae    801783 <sprintputch+0x33>
		*b->buf++ = ch;
  801771:	8b 45 0c             	mov    0xc(%ebp),%eax
  801774:	8b 00                	mov    (%eax),%eax
  801776:	8d 48 01             	lea    0x1(%eax),%ecx
  801779:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177c:	89 0a                	mov    %ecx,(%edx)
  80177e:	8b 55 08             	mov    0x8(%ebp),%edx
  801781:	88 10                	mov    %dl,(%eax)
}
  801783:	90                   	nop
  801784:	5d                   	pop    %ebp
  801785:	c3                   	ret    

00801786 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
  801789:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801792:	8b 45 0c             	mov    0xc(%ebp),%eax
  801795:	8d 50 ff             	lea    -0x1(%eax),%edx
  801798:	8b 45 08             	mov    0x8(%ebp),%eax
  80179b:	01 d0                	add    %edx,%eax
  80179d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8017a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8017a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017ab:	74 06                	je     8017b3 <vsnprintf+0x2d>
  8017ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017b1:	7f 07                	jg     8017ba <vsnprintf+0x34>
		return -E_INVAL;
  8017b3:	b8 03 00 00 00       	mov    $0x3,%eax
  8017b8:	eb 20                	jmp    8017da <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8017ba:	ff 75 14             	pushl  0x14(%ebp)
  8017bd:	ff 75 10             	pushl  0x10(%ebp)
  8017c0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8017c3:	50                   	push   %eax
  8017c4:	68 50 17 80 00       	push   $0x801750
  8017c9:	e8 92 fb ff ff       	call   801360 <vprintfmt>
  8017ce:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8017d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017d4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8017d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
  8017df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8017e2:	8d 45 10             	lea    0x10(%ebp),%eax
  8017e5:	83 c0 04             	add    $0x4,%eax
  8017e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8017eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8017f1:	50                   	push   %eax
  8017f2:	ff 75 0c             	pushl  0xc(%ebp)
  8017f5:	ff 75 08             	pushl  0x8(%ebp)
  8017f8:	e8 89 ff ff ff       	call   801786 <vsnprintf>
  8017fd:	83 c4 10             	add    $0x10,%esp
  801800:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801803:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
  80180b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80180e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801815:	eb 06                	jmp    80181d <strlen+0x15>
		n++;
  801817:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80181a:	ff 45 08             	incl   0x8(%ebp)
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	8a 00                	mov    (%eax),%al
  801822:	84 c0                	test   %al,%al
  801824:	75 f1                	jne    801817 <strlen+0xf>
		n++;
	return n;
  801826:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
  80182e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801831:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801838:	eb 09                	jmp    801843 <strnlen+0x18>
		n++;
  80183a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80183d:	ff 45 08             	incl   0x8(%ebp)
  801840:	ff 4d 0c             	decl   0xc(%ebp)
  801843:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801847:	74 09                	je     801852 <strnlen+0x27>
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	8a 00                	mov    (%eax),%al
  80184e:	84 c0                	test   %al,%al
  801850:	75 e8                	jne    80183a <strnlen+0xf>
		n++;
	return n;
  801852:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
  80185a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801863:	90                   	nop
  801864:	8b 45 08             	mov    0x8(%ebp),%eax
  801867:	8d 50 01             	lea    0x1(%eax),%edx
  80186a:	89 55 08             	mov    %edx,0x8(%ebp)
  80186d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801870:	8d 4a 01             	lea    0x1(%edx),%ecx
  801873:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801876:	8a 12                	mov    (%edx),%dl
  801878:	88 10                	mov    %dl,(%eax)
  80187a:	8a 00                	mov    (%eax),%al
  80187c:	84 c0                	test   %al,%al
  80187e:	75 e4                	jne    801864 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801880:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
  801888:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801891:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801898:	eb 1f                	jmp    8018b9 <strncpy+0x34>
		*dst++ = *src;
  80189a:	8b 45 08             	mov    0x8(%ebp),%eax
  80189d:	8d 50 01             	lea    0x1(%eax),%edx
  8018a0:	89 55 08             	mov    %edx,0x8(%ebp)
  8018a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a6:	8a 12                	mov    (%edx),%dl
  8018a8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8018aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ad:	8a 00                	mov    (%eax),%al
  8018af:	84 c0                	test   %al,%al
  8018b1:	74 03                	je     8018b6 <strncpy+0x31>
			src++;
  8018b3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8018b6:	ff 45 fc             	incl   -0x4(%ebp)
  8018b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018bc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018bf:	72 d9                	jb     80189a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8018c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
  8018c9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8018d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018d6:	74 30                	je     801908 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8018d8:	eb 16                	jmp    8018f0 <strlcpy+0x2a>
			*dst++ = *src++;
  8018da:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dd:	8d 50 01             	lea    0x1(%eax),%edx
  8018e0:	89 55 08             	mov    %edx,0x8(%ebp)
  8018e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018e9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8018ec:	8a 12                	mov    (%edx),%dl
  8018ee:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8018f0:	ff 4d 10             	decl   0x10(%ebp)
  8018f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018f7:	74 09                	je     801902 <strlcpy+0x3c>
  8018f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fc:	8a 00                	mov    (%eax),%al
  8018fe:	84 c0                	test   %al,%al
  801900:	75 d8                	jne    8018da <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801902:	8b 45 08             	mov    0x8(%ebp),%eax
  801905:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801908:	8b 55 08             	mov    0x8(%ebp),%edx
  80190b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80190e:	29 c2                	sub    %eax,%edx
  801910:	89 d0                	mov    %edx,%eax
}
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801917:	eb 06                	jmp    80191f <strcmp+0xb>
		p++, q++;
  801919:	ff 45 08             	incl   0x8(%ebp)
  80191c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80191f:	8b 45 08             	mov    0x8(%ebp),%eax
  801922:	8a 00                	mov    (%eax),%al
  801924:	84 c0                	test   %al,%al
  801926:	74 0e                	je     801936 <strcmp+0x22>
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
  80192b:	8a 10                	mov    (%eax),%dl
  80192d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801930:	8a 00                	mov    (%eax),%al
  801932:	38 c2                	cmp    %al,%dl
  801934:	74 e3                	je     801919 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801936:	8b 45 08             	mov    0x8(%ebp),%eax
  801939:	8a 00                	mov    (%eax),%al
  80193b:	0f b6 d0             	movzbl %al,%edx
  80193e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801941:	8a 00                	mov    (%eax),%al
  801943:	0f b6 c0             	movzbl %al,%eax
  801946:	29 c2                	sub    %eax,%edx
  801948:	89 d0                	mov    %edx,%eax
}
  80194a:	5d                   	pop    %ebp
  80194b:	c3                   	ret    

0080194c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80194f:	eb 09                	jmp    80195a <strncmp+0xe>
		n--, p++, q++;
  801951:	ff 4d 10             	decl   0x10(%ebp)
  801954:	ff 45 08             	incl   0x8(%ebp)
  801957:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80195a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80195e:	74 17                	je     801977 <strncmp+0x2b>
  801960:	8b 45 08             	mov    0x8(%ebp),%eax
  801963:	8a 00                	mov    (%eax),%al
  801965:	84 c0                	test   %al,%al
  801967:	74 0e                	je     801977 <strncmp+0x2b>
  801969:	8b 45 08             	mov    0x8(%ebp),%eax
  80196c:	8a 10                	mov    (%eax),%dl
  80196e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801971:	8a 00                	mov    (%eax),%al
  801973:	38 c2                	cmp    %al,%dl
  801975:	74 da                	je     801951 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801977:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80197b:	75 07                	jne    801984 <strncmp+0x38>
		return 0;
  80197d:	b8 00 00 00 00       	mov    $0x0,%eax
  801982:	eb 14                	jmp    801998 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801984:	8b 45 08             	mov    0x8(%ebp),%eax
  801987:	8a 00                	mov    (%eax),%al
  801989:	0f b6 d0             	movzbl %al,%edx
  80198c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198f:	8a 00                	mov    (%eax),%al
  801991:	0f b6 c0             	movzbl %al,%eax
  801994:	29 c2                	sub    %eax,%edx
  801996:	89 d0                	mov    %edx,%eax
}
  801998:	5d                   	pop    %ebp
  801999:	c3                   	ret    

0080199a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80199a:	55                   	push   %ebp
  80199b:	89 e5                	mov    %esp,%ebp
  80199d:	83 ec 04             	sub    $0x4,%esp
  8019a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8019a6:	eb 12                	jmp    8019ba <strchr+0x20>
		if (*s == c)
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ab:	8a 00                	mov    (%eax),%al
  8019ad:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8019b0:	75 05                	jne    8019b7 <strchr+0x1d>
			return (char *) s;
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	eb 11                	jmp    8019c8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8019b7:	ff 45 08             	incl   0x8(%ebp)
  8019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bd:	8a 00                	mov    (%eax),%al
  8019bf:	84 c0                	test   %al,%al
  8019c1:	75 e5                	jne    8019a8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8019c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019c8:	c9                   	leave  
  8019c9:	c3                   	ret    

008019ca <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8019ca:	55                   	push   %ebp
  8019cb:	89 e5                	mov    %esp,%ebp
  8019cd:	83 ec 04             	sub    $0x4,%esp
  8019d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8019d6:	eb 0d                	jmp    8019e5 <strfind+0x1b>
		if (*s == c)
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	8a 00                	mov    (%eax),%al
  8019dd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8019e0:	74 0e                	je     8019f0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8019e2:	ff 45 08             	incl   0x8(%ebp)
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	8a 00                	mov    (%eax),%al
  8019ea:	84 c0                	test   %al,%al
  8019ec:	75 ea                	jne    8019d8 <strfind+0xe>
  8019ee:	eb 01                	jmp    8019f1 <strfind+0x27>
		if (*s == c)
			break;
  8019f0:	90                   	nop
	return (char *) s;
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019f4:	c9                   	leave  
  8019f5:	c3                   	ret    

008019f6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8019f6:	55                   	push   %ebp
  8019f7:	89 e5                	mov    %esp,%ebp
  8019f9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801a02:	8b 45 10             	mov    0x10(%ebp),%eax
  801a05:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801a08:	eb 0e                	jmp    801a18 <memset+0x22>
		*p++ = c;
  801a0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a0d:	8d 50 01             	lea    0x1(%eax),%edx
  801a10:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a16:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801a18:	ff 4d f8             	decl   -0x8(%ebp)
  801a1b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801a1f:	79 e9                	jns    801a0a <memset+0x14>
		*p++ = c;

	return v;
  801a21:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
  801a29:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801a32:	8b 45 08             	mov    0x8(%ebp),%eax
  801a35:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801a38:	eb 16                	jmp    801a50 <memcpy+0x2a>
		*d++ = *s++;
  801a3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3d:	8d 50 01             	lea    0x1(%eax),%edx
  801a40:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a46:	8d 4a 01             	lea    0x1(%edx),%ecx
  801a49:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801a4c:	8a 12                	mov    (%edx),%dl
  801a4e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801a50:	8b 45 10             	mov    0x10(%ebp),%eax
  801a53:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a56:	89 55 10             	mov    %edx,0x10(%ebp)
  801a59:	85 c0                	test   %eax,%eax
  801a5b:	75 dd                	jne    801a3a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801a5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a60:	c9                   	leave  
  801a61:	c3                   	ret    

00801a62 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
  801a65:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801a68:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a71:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801a74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a77:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801a7a:	73 50                	jae    801acc <memmove+0x6a>
  801a7c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a82:	01 d0                	add    %edx,%eax
  801a84:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801a87:	76 43                	jbe    801acc <memmove+0x6a>
		s += n;
  801a89:	8b 45 10             	mov    0x10(%ebp),%eax
  801a8c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801a8f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a92:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801a95:	eb 10                	jmp    801aa7 <memmove+0x45>
			*--d = *--s;
  801a97:	ff 4d f8             	decl   -0x8(%ebp)
  801a9a:	ff 4d fc             	decl   -0x4(%ebp)
  801a9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aa0:	8a 10                	mov    (%eax),%dl
  801aa2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801aa5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801aa7:	8b 45 10             	mov    0x10(%ebp),%eax
  801aaa:	8d 50 ff             	lea    -0x1(%eax),%edx
  801aad:	89 55 10             	mov    %edx,0x10(%ebp)
  801ab0:	85 c0                	test   %eax,%eax
  801ab2:	75 e3                	jne    801a97 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801ab4:	eb 23                	jmp    801ad9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801ab6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ab9:	8d 50 01             	lea    0x1(%eax),%edx
  801abc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801abf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ac2:	8d 4a 01             	lea    0x1(%edx),%ecx
  801ac5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801ac8:	8a 12                	mov    (%edx),%dl
  801aca:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801acc:	8b 45 10             	mov    0x10(%ebp),%eax
  801acf:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ad2:	89 55 10             	mov    %edx,0x10(%ebp)
  801ad5:	85 c0                	test   %eax,%eax
  801ad7:	75 dd                	jne    801ab6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801ad9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
  801ae1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801aea:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aed:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801af0:	eb 2a                	jmp    801b1c <memcmp+0x3e>
		if (*s1 != *s2)
  801af2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801af5:	8a 10                	mov    (%eax),%dl
  801af7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801afa:	8a 00                	mov    (%eax),%al
  801afc:	38 c2                	cmp    %al,%dl
  801afe:	74 16                	je     801b16 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801b00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b03:	8a 00                	mov    (%eax),%al
  801b05:	0f b6 d0             	movzbl %al,%edx
  801b08:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b0b:	8a 00                	mov    (%eax),%al
  801b0d:	0f b6 c0             	movzbl %al,%eax
  801b10:	29 c2                	sub    %eax,%edx
  801b12:	89 d0                	mov    %edx,%eax
  801b14:	eb 18                	jmp    801b2e <memcmp+0x50>
		s1++, s2++;
  801b16:	ff 45 fc             	incl   -0x4(%ebp)
  801b19:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801b1c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b1f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b22:	89 55 10             	mov    %edx,0x10(%ebp)
  801b25:	85 c0                	test   %eax,%eax
  801b27:	75 c9                	jne    801af2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801b29:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b2e:	c9                   	leave  
  801b2f:	c3                   	ret    

00801b30 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801b30:	55                   	push   %ebp
  801b31:	89 e5                	mov    %esp,%ebp
  801b33:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801b36:	8b 55 08             	mov    0x8(%ebp),%edx
  801b39:	8b 45 10             	mov    0x10(%ebp),%eax
  801b3c:	01 d0                	add    %edx,%eax
  801b3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801b41:	eb 15                	jmp    801b58 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801b43:	8b 45 08             	mov    0x8(%ebp),%eax
  801b46:	8a 00                	mov    (%eax),%al
  801b48:	0f b6 d0             	movzbl %al,%edx
  801b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b4e:	0f b6 c0             	movzbl %al,%eax
  801b51:	39 c2                	cmp    %eax,%edx
  801b53:	74 0d                	je     801b62 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801b55:	ff 45 08             	incl   0x8(%ebp)
  801b58:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b5e:	72 e3                	jb     801b43 <memfind+0x13>
  801b60:	eb 01                	jmp    801b63 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801b62:	90                   	nop
	return (void *) s;
  801b63:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b66:	c9                   	leave  
  801b67:	c3                   	ret    

00801b68 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801b68:	55                   	push   %ebp
  801b69:	89 e5                	mov    %esp,%ebp
  801b6b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801b6e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801b75:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801b7c:	eb 03                	jmp    801b81 <strtol+0x19>
		s++;
  801b7e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801b81:	8b 45 08             	mov    0x8(%ebp),%eax
  801b84:	8a 00                	mov    (%eax),%al
  801b86:	3c 20                	cmp    $0x20,%al
  801b88:	74 f4                	je     801b7e <strtol+0x16>
  801b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8d:	8a 00                	mov    (%eax),%al
  801b8f:	3c 09                	cmp    $0x9,%al
  801b91:	74 eb                	je     801b7e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801b93:	8b 45 08             	mov    0x8(%ebp),%eax
  801b96:	8a 00                	mov    (%eax),%al
  801b98:	3c 2b                	cmp    $0x2b,%al
  801b9a:	75 05                	jne    801ba1 <strtol+0x39>
		s++;
  801b9c:	ff 45 08             	incl   0x8(%ebp)
  801b9f:	eb 13                	jmp    801bb4 <strtol+0x4c>
	else if (*s == '-')
  801ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba4:	8a 00                	mov    (%eax),%al
  801ba6:	3c 2d                	cmp    $0x2d,%al
  801ba8:	75 0a                	jne    801bb4 <strtol+0x4c>
		s++, neg = 1;
  801baa:	ff 45 08             	incl   0x8(%ebp)
  801bad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801bb4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801bb8:	74 06                	je     801bc0 <strtol+0x58>
  801bba:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801bbe:	75 20                	jne    801be0 <strtol+0x78>
  801bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc3:	8a 00                	mov    (%eax),%al
  801bc5:	3c 30                	cmp    $0x30,%al
  801bc7:	75 17                	jne    801be0 <strtol+0x78>
  801bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcc:	40                   	inc    %eax
  801bcd:	8a 00                	mov    (%eax),%al
  801bcf:	3c 78                	cmp    $0x78,%al
  801bd1:	75 0d                	jne    801be0 <strtol+0x78>
		s += 2, base = 16;
  801bd3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801bd7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801bde:	eb 28                	jmp    801c08 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801be0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801be4:	75 15                	jne    801bfb <strtol+0x93>
  801be6:	8b 45 08             	mov    0x8(%ebp),%eax
  801be9:	8a 00                	mov    (%eax),%al
  801beb:	3c 30                	cmp    $0x30,%al
  801bed:	75 0c                	jne    801bfb <strtol+0x93>
		s++, base = 8;
  801bef:	ff 45 08             	incl   0x8(%ebp)
  801bf2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801bf9:	eb 0d                	jmp    801c08 <strtol+0xa0>
	else if (base == 0)
  801bfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801bff:	75 07                	jne    801c08 <strtol+0xa0>
		base = 10;
  801c01:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801c08:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0b:	8a 00                	mov    (%eax),%al
  801c0d:	3c 2f                	cmp    $0x2f,%al
  801c0f:	7e 19                	jle    801c2a <strtol+0xc2>
  801c11:	8b 45 08             	mov    0x8(%ebp),%eax
  801c14:	8a 00                	mov    (%eax),%al
  801c16:	3c 39                	cmp    $0x39,%al
  801c18:	7f 10                	jg     801c2a <strtol+0xc2>
			dig = *s - '0';
  801c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1d:	8a 00                	mov    (%eax),%al
  801c1f:	0f be c0             	movsbl %al,%eax
  801c22:	83 e8 30             	sub    $0x30,%eax
  801c25:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801c28:	eb 42                	jmp    801c6c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2d:	8a 00                	mov    (%eax),%al
  801c2f:	3c 60                	cmp    $0x60,%al
  801c31:	7e 19                	jle    801c4c <strtol+0xe4>
  801c33:	8b 45 08             	mov    0x8(%ebp),%eax
  801c36:	8a 00                	mov    (%eax),%al
  801c38:	3c 7a                	cmp    $0x7a,%al
  801c3a:	7f 10                	jg     801c4c <strtol+0xe4>
			dig = *s - 'a' + 10;
  801c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3f:	8a 00                	mov    (%eax),%al
  801c41:	0f be c0             	movsbl %al,%eax
  801c44:	83 e8 57             	sub    $0x57,%eax
  801c47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801c4a:	eb 20                	jmp    801c6c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4f:	8a 00                	mov    (%eax),%al
  801c51:	3c 40                	cmp    $0x40,%al
  801c53:	7e 39                	jle    801c8e <strtol+0x126>
  801c55:	8b 45 08             	mov    0x8(%ebp),%eax
  801c58:	8a 00                	mov    (%eax),%al
  801c5a:	3c 5a                	cmp    $0x5a,%al
  801c5c:	7f 30                	jg     801c8e <strtol+0x126>
			dig = *s - 'A' + 10;
  801c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c61:	8a 00                	mov    (%eax),%al
  801c63:	0f be c0             	movsbl %al,%eax
  801c66:	83 e8 37             	sub    $0x37,%eax
  801c69:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c6f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801c72:	7d 19                	jge    801c8d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801c74:	ff 45 08             	incl   0x8(%ebp)
  801c77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c7a:	0f af 45 10          	imul   0x10(%ebp),%eax
  801c7e:	89 c2                	mov    %eax,%edx
  801c80:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c83:	01 d0                	add    %edx,%eax
  801c85:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801c88:	e9 7b ff ff ff       	jmp    801c08 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801c8d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801c8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c92:	74 08                	je     801c9c <strtol+0x134>
		*endptr = (char *) s;
  801c94:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c97:	8b 55 08             	mov    0x8(%ebp),%edx
  801c9a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801c9c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ca0:	74 07                	je     801ca9 <strtol+0x141>
  801ca2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ca5:	f7 d8                	neg    %eax
  801ca7:	eb 03                	jmp    801cac <strtol+0x144>
  801ca9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801cac:	c9                   	leave  
  801cad:	c3                   	ret    

00801cae <ltostr>:

void
ltostr(long value, char *str)
{
  801cae:	55                   	push   %ebp
  801caf:	89 e5                	mov    %esp,%ebp
  801cb1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801cb4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801cbb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801cc2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801cc6:	79 13                	jns    801cdb <ltostr+0x2d>
	{
		neg = 1;
  801cc8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cd2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801cd5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801cd8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cde:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801ce3:	99                   	cltd   
  801ce4:	f7 f9                	idiv   %ecx
  801ce6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801ce9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cec:	8d 50 01             	lea    0x1(%eax),%edx
  801cef:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801cf2:	89 c2                	mov    %eax,%edx
  801cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cf7:	01 d0                	add    %edx,%eax
  801cf9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801cfc:	83 c2 30             	add    $0x30,%edx
  801cff:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801d01:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d04:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d09:	f7 e9                	imul   %ecx
  801d0b:	c1 fa 02             	sar    $0x2,%edx
  801d0e:	89 c8                	mov    %ecx,%eax
  801d10:	c1 f8 1f             	sar    $0x1f,%eax
  801d13:	29 c2                	sub    %eax,%edx
  801d15:	89 d0                	mov    %edx,%eax
  801d17:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801d1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d1d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d22:	f7 e9                	imul   %ecx
  801d24:	c1 fa 02             	sar    $0x2,%edx
  801d27:	89 c8                	mov    %ecx,%eax
  801d29:	c1 f8 1f             	sar    $0x1f,%eax
  801d2c:	29 c2                	sub    %eax,%edx
  801d2e:	89 d0                	mov    %edx,%eax
  801d30:	c1 e0 02             	shl    $0x2,%eax
  801d33:	01 d0                	add    %edx,%eax
  801d35:	01 c0                	add    %eax,%eax
  801d37:	29 c1                	sub    %eax,%ecx
  801d39:	89 ca                	mov    %ecx,%edx
  801d3b:	85 d2                	test   %edx,%edx
  801d3d:	75 9c                	jne    801cdb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801d3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801d46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d49:	48                   	dec    %eax
  801d4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801d4d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d51:	74 3d                	je     801d90 <ltostr+0xe2>
		start = 1 ;
  801d53:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801d5a:	eb 34                	jmp    801d90 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801d5c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d62:	01 d0                	add    %edx,%eax
  801d64:	8a 00                	mov    (%eax),%al
  801d66:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801d69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d6f:	01 c2                	add    %eax,%edx
  801d71:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801d74:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d77:	01 c8                	add    %ecx,%eax
  801d79:	8a 00                	mov    (%eax),%al
  801d7b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801d7d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d83:	01 c2                	add    %eax,%edx
  801d85:	8a 45 eb             	mov    -0x15(%ebp),%al
  801d88:	88 02                	mov    %al,(%edx)
		start++ ;
  801d8a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801d8d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801d90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d93:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d96:	7c c4                	jl     801d5c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801d98:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801d9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d9e:	01 d0                	add    %edx,%eax
  801da0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801da3:	90                   	nop
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
  801da9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801dac:	ff 75 08             	pushl  0x8(%ebp)
  801daf:	e8 54 fa ff ff       	call   801808 <strlen>
  801db4:	83 c4 04             	add    $0x4,%esp
  801db7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801dba:	ff 75 0c             	pushl  0xc(%ebp)
  801dbd:	e8 46 fa ff ff       	call   801808 <strlen>
  801dc2:	83 c4 04             	add    $0x4,%esp
  801dc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801dc8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801dcf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801dd6:	eb 17                	jmp    801def <strcconcat+0x49>
		final[s] = str1[s] ;
  801dd8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ddb:	8b 45 10             	mov    0x10(%ebp),%eax
  801dde:	01 c2                	add    %eax,%edx
  801de0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801de3:	8b 45 08             	mov    0x8(%ebp),%eax
  801de6:	01 c8                	add    %ecx,%eax
  801de8:	8a 00                	mov    (%eax),%al
  801dea:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801dec:	ff 45 fc             	incl   -0x4(%ebp)
  801def:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801df2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801df5:	7c e1                	jl     801dd8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801df7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801dfe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801e05:	eb 1f                	jmp    801e26 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801e07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e0a:	8d 50 01             	lea    0x1(%eax),%edx
  801e0d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801e10:	89 c2                	mov    %eax,%edx
  801e12:	8b 45 10             	mov    0x10(%ebp),%eax
  801e15:	01 c2                	add    %eax,%edx
  801e17:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e1d:	01 c8                	add    %ecx,%eax
  801e1f:	8a 00                	mov    (%eax),%al
  801e21:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801e23:	ff 45 f8             	incl   -0x8(%ebp)
  801e26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e29:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e2c:	7c d9                	jl     801e07 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801e2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e31:	8b 45 10             	mov    0x10(%ebp),%eax
  801e34:	01 d0                	add    %edx,%eax
  801e36:	c6 00 00             	movb   $0x0,(%eax)
}
  801e39:	90                   	nop
  801e3a:	c9                   	leave  
  801e3b:	c3                   	ret    

00801e3c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801e3c:	55                   	push   %ebp
  801e3d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801e3f:	8b 45 14             	mov    0x14(%ebp),%eax
  801e42:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801e48:	8b 45 14             	mov    0x14(%ebp),%eax
  801e4b:	8b 00                	mov    (%eax),%eax
  801e4d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e54:	8b 45 10             	mov    0x10(%ebp),%eax
  801e57:	01 d0                	add    %edx,%eax
  801e59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801e5f:	eb 0c                	jmp    801e6d <strsplit+0x31>
			*string++ = 0;
  801e61:	8b 45 08             	mov    0x8(%ebp),%eax
  801e64:	8d 50 01             	lea    0x1(%eax),%edx
  801e67:	89 55 08             	mov    %edx,0x8(%ebp)
  801e6a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e70:	8a 00                	mov    (%eax),%al
  801e72:	84 c0                	test   %al,%al
  801e74:	74 18                	je     801e8e <strsplit+0x52>
  801e76:	8b 45 08             	mov    0x8(%ebp),%eax
  801e79:	8a 00                	mov    (%eax),%al
  801e7b:	0f be c0             	movsbl %al,%eax
  801e7e:	50                   	push   %eax
  801e7f:	ff 75 0c             	pushl  0xc(%ebp)
  801e82:	e8 13 fb ff ff       	call   80199a <strchr>
  801e87:	83 c4 08             	add    $0x8,%esp
  801e8a:	85 c0                	test   %eax,%eax
  801e8c:	75 d3                	jne    801e61 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e91:	8a 00                	mov    (%eax),%al
  801e93:	84 c0                	test   %al,%al
  801e95:	74 5a                	je     801ef1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801e97:	8b 45 14             	mov    0x14(%ebp),%eax
  801e9a:	8b 00                	mov    (%eax),%eax
  801e9c:	83 f8 0f             	cmp    $0xf,%eax
  801e9f:	75 07                	jne    801ea8 <strsplit+0x6c>
		{
			return 0;
  801ea1:	b8 00 00 00 00       	mov    $0x0,%eax
  801ea6:	eb 66                	jmp    801f0e <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ea8:	8b 45 14             	mov    0x14(%ebp),%eax
  801eab:	8b 00                	mov    (%eax),%eax
  801ead:	8d 48 01             	lea    0x1(%eax),%ecx
  801eb0:	8b 55 14             	mov    0x14(%ebp),%edx
  801eb3:	89 0a                	mov    %ecx,(%edx)
  801eb5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ebc:	8b 45 10             	mov    0x10(%ebp),%eax
  801ebf:	01 c2                	add    %eax,%edx
  801ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ec6:	eb 03                	jmp    801ecb <strsplit+0x8f>
			string++;
  801ec8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ece:	8a 00                	mov    (%eax),%al
  801ed0:	84 c0                	test   %al,%al
  801ed2:	74 8b                	je     801e5f <strsplit+0x23>
  801ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed7:	8a 00                	mov    (%eax),%al
  801ed9:	0f be c0             	movsbl %al,%eax
  801edc:	50                   	push   %eax
  801edd:	ff 75 0c             	pushl  0xc(%ebp)
  801ee0:	e8 b5 fa ff ff       	call   80199a <strchr>
  801ee5:	83 c4 08             	add    $0x8,%esp
  801ee8:	85 c0                	test   %eax,%eax
  801eea:	74 dc                	je     801ec8 <strsplit+0x8c>
			string++;
	}
  801eec:	e9 6e ff ff ff       	jmp    801e5f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801ef1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ef2:	8b 45 14             	mov    0x14(%ebp),%eax
  801ef5:	8b 00                	mov    (%eax),%eax
  801ef7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801efe:	8b 45 10             	mov    0x10(%ebp),%eax
  801f01:	01 d0                	add    %edx,%eax
  801f03:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801f09:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801f0e:	c9                   	leave  
  801f0f:	c3                   	ret    

00801f10 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801f10:	55                   	push   %ebp
  801f11:	89 e5                	mov    %esp,%ebp
  801f13:	83 ec 18             	sub    $0x18,%esp
  801f16:	8b 45 10             	mov    0x10(%ebp),%eax
  801f19:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801f1c:	83 ec 04             	sub    $0x4,%esp
  801f1f:	68 50 31 80 00       	push   $0x803150
  801f24:	6a 17                	push   $0x17
  801f26:	68 6f 31 80 00       	push   $0x80316f
  801f2b:	e8 a2 ef ff ff       	call   800ed2 <_panic>

00801f30 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801f30:	55                   	push   %ebp
  801f31:	89 e5                	mov    %esp,%ebp
  801f33:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801f36:	83 ec 04             	sub    $0x4,%esp
  801f39:	68 7b 31 80 00       	push   $0x80317b
  801f3e:	6a 2f                	push   $0x2f
  801f40:	68 6f 31 80 00       	push   $0x80316f
  801f45:	e8 88 ef ff ff       	call   800ed2 <_panic>

00801f4a <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
  801f4d:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801f50:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801f57:	8b 55 08             	mov    0x8(%ebp),%edx
  801f5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f5d:	01 d0                	add    %edx,%eax
  801f5f:	48                   	dec    %eax
  801f60:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801f63:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f66:	ba 00 00 00 00       	mov    $0x0,%edx
  801f6b:	f7 75 ec             	divl   -0x14(%ebp)
  801f6e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f71:	29 d0                	sub    %edx,%eax
  801f73:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801f76:	8b 45 08             	mov    0x8(%ebp),%eax
  801f79:	c1 e8 0c             	shr    $0xc,%eax
  801f7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801f7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801f86:	e9 c8 00 00 00       	jmp    802053 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801f8b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801f92:	eb 27                	jmp    801fbb <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801f94:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801f97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f9a:	01 c2                	add    %eax,%edx
  801f9c:	89 d0                	mov    %edx,%eax
  801f9e:	01 c0                	add    %eax,%eax
  801fa0:	01 d0                	add    %edx,%eax
  801fa2:	c1 e0 02             	shl    $0x2,%eax
  801fa5:	05 48 40 80 00       	add    $0x804048,%eax
  801faa:	8b 00                	mov    (%eax),%eax
  801fac:	85 c0                	test   %eax,%eax
  801fae:	74 08                	je     801fb8 <malloc+0x6e>
            	i += j;
  801fb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fb3:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801fb6:	eb 0b                	jmp    801fc3 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801fb8:	ff 45 f0             	incl   -0x10(%ebp)
  801fbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fbe:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801fc1:	72 d1                	jb     801f94 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801fc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fc6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801fc9:	0f 85 81 00 00 00    	jne    802050 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fd2:	05 00 00 08 00       	add    $0x80000,%eax
  801fd7:	c1 e0 0c             	shl    $0xc,%eax
  801fda:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801fdd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801fe4:	eb 1f                	jmp    802005 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801fe6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801fe9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fec:	01 c2                	add    %eax,%edx
  801fee:	89 d0                	mov    %edx,%eax
  801ff0:	01 c0                	add    %eax,%eax
  801ff2:	01 d0                	add    %edx,%eax
  801ff4:	c1 e0 02             	shl    $0x2,%eax
  801ff7:	05 48 40 80 00       	add    $0x804048,%eax
  801ffc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  802002:	ff 45 f0             	incl   -0x10(%ebp)
  802005:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802008:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80200b:	72 d9                	jb     801fe6 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80200d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802010:	89 d0                	mov    %edx,%eax
  802012:	01 c0                	add    %eax,%eax
  802014:	01 d0                	add    %edx,%eax
  802016:	c1 e0 02             	shl    $0x2,%eax
  802019:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  80201f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802022:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  802024:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802027:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80202a:	89 c8                	mov    %ecx,%eax
  80202c:	01 c0                	add    %eax,%eax
  80202e:	01 c8                	add    %ecx,%eax
  802030:	c1 e0 02             	shl    $0x2,%eax
  802033:	05 44 40 80 00       	add    $0x804044,%eax
  802038:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80203a:	83 ec 08             	sub    $0x8,%esp
  80203d:	ff 75 08             	pushl  0x8(%ebp)
  802040:	ff 75 e0             	pushl  -0x20(%ebp)
  802043:	e8 2b 03 00 00       	call   802373 <sys_allocateMem>
  802048:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80204b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80204e:	eb 19                	jmp    802069 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  802050:	ff 45 f4             	incl   -0xc(%ebp)
  802053:	a1 04 40 80 00       	mov    0x804004,%eax
  802058:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80205b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80205e:	0f 83 27 ff ff ff    	jae    801f8b <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  802064:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802069:	c9                   	leave  
  80206a:	c3                   	ret    

0080206b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  80206b:	55                   	push   %ebp
  80206c:	89 e5                	mov    %esp,%ebp
  80206e:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  802071:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802075:	0f 84 e5 00 00 00    	je     802160 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80207b:	8b 45 08             	mov    0x8(%ebp),%eax
  80207e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  802081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802084:	05 00 00 00 80       	add    $0x80000000,%eax
  802089:	c1 e8 0c             	shr    $0xc,%eax
  80208c:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80208f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802092:	89 d0                	mov    %edx,%eax
  802094:	01 c0                	add    %eax,%eax
  802096:	01 d0                	add    %edx,%eax
  802098:	c1 e0 02             	shl    $0x2,%eax
  80209b:	05 40 40 80 00       	add    $0x804040,%eax
  8020a0:	8b 00                	mov    (%eax),%eax
  8020a2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8020a5:	0f 85 b8 00 00 00    	jne    802163 <free+0xf8>
  8020ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8020ae:	89 d0                	mov    %edx,%eax
  8020b0:	01 c0                	add    %eax,%eax
  8020b2:	01 d0                	add    %edx,%eax
  8020b4:	c1 e0 02             	shl    $0x2,%eax
  8020b7:	05 48 40 80 00       	add    $0x804048,%eax
  8020bc:	8b 00                	mov    (%eax),%eax
  8020be:	85 c0                	test   %eax,%eax
  8020c0:	0f 84 9d 00 00 00    	je     802163 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8020c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8020c9:	89 d0                	mov    %edx,%eax
  8020cb:	01 c0                	add    %eax,%eax
  8020cd:	01 d0                	add    %edx,%eax
  8020cf:	c1 e0 02             	shl    $0x2,%eax
  8020d2:	05 44 40 80 00       	add    $0x804044,%eax
  8020d7:	8b 00                	mov    (%eax),%eax
  8020d9:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8020dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020df:	c1 e0 0c             	shl    $0xc,%eax
  8020e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  8020e5:	83 ec 08             	sub    $0x8,%esp
  8020e8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8020eb:	ff 75 f0             	pushl  -0x10(%ebp)
  8020ee:	e8 64 02 00 00       	call   802357 <sys_freeMem>
  8020f3:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8020f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8020fd:	eb 57                	jmp    802156 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  8020ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802102:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802105:	01 c2                	add    %eax,%edx
  802107:	89 d0                	mov    %edx,%eax
  802109:	01 c0                	add    %eax,%eax
  80210b:	01 d0                	add    %edx,%eax
  80210d:	c1 e0 02             	shl    $0x2,%eax
  802110:	05 48 40 80 00       	add    $0x804048,%eax
  802115:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80211b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80211e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802121:	01 c2                	add    %eax,%edx
  802123:	89 d0                	mov    %edx,%eax
  802125:	01 c0                	add    %eax,%eax
  802127:	01 d0                	add    %edx,%eax
  802129:	c1 e0 02             	shl    $0x2,%eax
  80212c:	05 40 40 80 00       	add    $0x804040,%eax
  802131:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  802137:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80213a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80213d:	01 c2                	add    %eax,%edx
  80213f:	89 d0                	mov    %edx,%eax
  802141:	01 c0                	add    %eax,%eax
  802143:	01 d0                	add    %edx,%eax
  802145:	c1 e0 02             	shl    $0x2,%eax
  802148:	05 44 40 80 00       	add    $0x804044,%eax
  80214d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802153:	ff 45 f4             	incl   -0xc(%ebp)
  802156:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802159:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80215c:	7c a1                	jl     8020ff <free+0x94>
  80215e:	eb 04                	jmp    802164 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  802160:	90                   	nop
  802161:	eb 01                	jmp    802164 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  802163:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
  802169:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80216c:	83 ec 04             	sub    $0x4,%esp
  80216f:	68 98 31 80 00       	push   $0x803198
  802174:	68 ae 00 00 00       	push   $0xae
  802179:	68 6f 31 80 00       	push   $0x80316f
  80217e:	e8 4f ed ff ff       	call   800ed2 <_panic>

00802183 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802183:	55                   	push   %ebp
  802184:	89 e5                	mov    %esp,%ebp
  802186:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  802189:	83 ec 04             	sub    $0x4,%esp
  80218c:	68 b8 31 80 00       	push   $0x8031b8
  802191:	68 ca 00 00 00       	push   $0xca
  802196:	68 6f 31 80 00       	push   $0x80316f
  80219b:	e8 32 ed ff ff       	call   800ed2 <_panic>

008021a0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8021a0:	55                   	push   %ebp
  8021a1:	89 e5                	mov    %esp,%ebp
  8021a3:	57                   	push   %edi
  8021a4:	56                   	push   %esi
  8021a5:	53                   	push   %ebx
  8021a6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8021a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021b5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8021b8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8021bb:	cd 30                	int    $0x30
  8021bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8021c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8021c3:	83 c4 10             	add    $0x10,%esp
  8021c6:	5b                   	pop    %ebx
  8021c7:	5e                   	pop    %esi
  8021c8:	5f                   	pop    %edi
  8021c9:	5d                   	pop    %ebp
  8021ca:	c3                   	ret    

008021cb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8021cb:	55                   	push   %ebp
  8021cc:	89 e5                	mov    %esp,%ebp
  8021ce:	83 ec 04             	sub    $0x4,%esp
  8021d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8021d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8021d7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8021db:	8b 45 08             	mov    0x8(%ebp),%eax
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	52                   	push   %edx
  8021e3:	ff 75 0c             	pushl  0xc(%ebp)
  8021e6:	50                   	push   %eax
  8021e7:	6a 00                	push   $0x0
  8021e9:	e8 b2 ff ff ff       	call   8021a0 <syscall>
  8021ee:	83 c4 18             	add    $0x18,%esp
}
  8021f1:	90                   	nop
  8021f2:	c9                   	leave  
  8021f3:	c3                   	ret    

008021f4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8021f4:	55                   	push   %ebp
  8021f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8021f7:	6a 00                	push   $0x0
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 01                	push   $0x1
  802203:	e8 98 ff ff ff       	call   8021a0 <syscall>
  802208:	83 c4 18             	add    $0x18,%esp
}
  80220b:	c9                   	leave  
  80220c:	c3                   	ret    

0080220d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80220d:	55                   	push   %ebp
  80220e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802210:	8b 45 08             	mov    0x8(%ebp),%eax
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 00                	push   $0x0
  80221b:	50                   	push   %eax
  80221c:	6a 05                	push   $0x5
  80221e:	e8 7d ff ff ff       	call   8021a0 <syscall>
  802223:	83 c4 18             	add    $0x18,%esp
}
  802226:	c9                   	leave  
  802227:	c3                   	ret    

00802228 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802228:	55                   	push   %ebp
  802229:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80222b:	6a 00                	push   $0x0
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	6a 00                	push   $0x0
  802235:	6a 02                	push   $0x2
  802237:	e8 64 ff ff ff       	call   8021a0 <syscall>
  80223c:	83 c4 18             	add    $0x18,%esp
}
  80223f:	c9                   	leave  
  802240:	c3                   	ret    

00802241 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802241:	55                   	push   %ebp
  802242:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 03                	push   $0x3
  802250:	e8 4b ff ff ff       	call   8021a0 <syscall>
  802255:	83 c4 18             	add    $0x18,%esp
}
  802258:	c9                   	leave  
  802259:	c3                   	ret    

0080225a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80225a:	55                   	push   %ebp
  80225b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	6a 00                	push   $0x0
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 04                	push   $0x4
  802269:	e8 32 ff ff ff       	call   8021a0 <syscall>
  80226e:	83 c4 18             	add    $0x18,%esp
}
  802271:	c9                   	leave  
  802272:	c3                   	ret    

00802273 <sys_env_exit>:


void sys_env_exit(void)
{
  802273:	55                   	push   %ebp
  802274:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	6a 06                	push   $0x6
  802282:	e8 19 ff ff ff       	call   8021a0 <syscall>
  802287:	83 c4 18             	add    $0x18,%esp
}
  80228a:	90                   	nop
  80228b:	c9                   	leave  
  80228c:	c3                   	ret    

0080228d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80228d:	55                   	push   %ebp
  80228e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802290:	8b 55 0c             	mov    0xc(%ebp),%edx
  802293:	8b 45 08             	mov    0x8(%ebp),%eax
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	52                   	push   %edx
  80229d:	50                   	push   %eax
  80229e:	6a 07                	push   $0x7
  8022a0:	e8 fb fe ff ff       	call   8021a0 <syscall>
  8022a5:	83 c4 18             	add    $0x18,%esp
}
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
  8022ad:	56                   	push   %esi
  8022ae:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8022af:	8b 75 18             	mov    0x18(%ebp),%esi
  8022b2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8022b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022be:	56                   	push   %esi
  8022bf:	53                   	push   %ebx
  8022c0:	51                   	push   %ecx
  8022c1:	52                   	push   %edx
  8022c2:	50                   	push   %eax
  8022c3:	6a 08                	push   $0x8
  8022c5:	e8 d6 fe ff ff       	call   8021a0 <syscall>
  8022ca:	83 c4 18             	add    $0x18,%esp
}
  8022cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8022d0:	5b                   	pop    %ebx
  8022d1:	5e                   	pop    %esi
  8022d2:	5d                   	pop    %ebp
  8022d3:	c3                   	ret    

008022d4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8022d4:	55                   	push   %ebp
  8022d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8022d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022da:	8b 45 08             	mov    0x8(%ebp),%eax
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	52                   	push   %edx
  8022e4:	50                   	push   %eax
  8022e5:	6a 09                	push   $0x9
  8022e7:	e8 b4 fe ff ff       	call   8021a0 <syscall>
  8022ec:	83 c4 18             	add    $0x18,%esp
}
  8022ef:	c9                   	leave  
  8022f0:	c3                   	ret    

008022f1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8022f1:	55                   	push   %ebp
  8022f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 00                	push   $0x0
  8022fa:	ff 75 0c             	pushl  0xc(%ebp)
  8022fd:	ff 75 08             	pushl  0x8(%ebp)
  802300:	6a 0a                	push   $0xa
  802302:	e8 99 fe ff ff       	call   8021a0 <syscall>
  802307:	83 c4 18             	add    $0x18,%esp
}
  80230a:	c9                   	leave  
  80230b:	c3                   	ret    

0080230c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80230c:	55                   	push   %ebp
  80230d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80230f:	6a 00                	push   $0x0
  802311:	6a 00                	push   $0x0
  802313:	6a 00                	push   $0x0
  802315:	6a 00                	push   $0x0
  802317:	6a 00                	push   $0x0
  802319:	6a 0b                	push   $0xb
  80231b:	e8 80 fe ff ff       	call   8021a0 <syscall>
  802320:	83 c4 18             	add    $0x18,%esp
}
  802323:	c9                   	leave  
  802324:	c3                   	ret    

00802325 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802325:	55                   	push   %ebp
  802326:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802328:	6a 00                	push   $0x0
  80232a:	6a 00                	push   $0x0
  80232c:	6a 00                	push   $0x0
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	6a 0c                	push   $0xc
  802334:	e8 67 fe ff ff       	call   8021a0 <syscall>
  802339:	83 c4 18             	add    $0x18,%esp
}
  80233c:	c9                   	leave  
  80233d:	c3                   	ret    

0080233e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80233e:	55                   	push   %ebp
  80233f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	6a 00                	push   $0x0
  802347:	6a 00                	push   $0x0
  802349:	6a 00                	push   $0x0
  80234b:	6a 0d                	push   $0xd
  80234d:	e8 4e fe ff ff       	call   8021a0 <syscall>
  802352:	83 c4 18             	add    $0x18,%esp
}
  802355:	c9                   	leave  
  802356:	c3                   	ret    

00802357 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802357:	55                   	push   %ebp
  802358:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80235a:	6a 00                	push   $0x0
  80235c:	6a 00                	push   $0x0
  80235e:	6a 00                	push   $0x0
  802360:	ff 75 0c             	pushl  0xc(%ebp)
  802363:	ff 75 08             	pushl  0x8(%ebp)
  802366:	6a 11                	push   $0x11
  802368:	e8 33 fe ff ff       	call   8021a0 <syscall>
  80236d:	83 c4 18             	add    $0x18,%esp
	return;
  802370:	90                   	nop
}
  802371:	c9                   	leave  
  802372:	c3                   	ret    

00802373 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802373:	55                   	push   %ebp
  802374:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802376:	6a 00                	push   $0x0
  802378:	6a 00                	push   $0x0
  80237a:	6a 00                	push   $0x0
  80237c:	ff 75 0c             	pushl  0xc(%ebp)
  80237f:	ff 75 08             	pushl  0x8(%ebp)
  802382:	6a 12                	push   $0x12
  802384:	e8 17 fe ff ff       	call   8021a0 <syscall>
  802389:	83 c4 18             	add    $0x18,%esp
	return ;
  80238c:	90                   	nop
}
  80238d:	c9                   	leave  
  80238e:	c3                   	ret    

0080238f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80238f:	55                   	push   %ebp
  802390:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802392:	6a 00                	push   $0x0
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 00                	push   $0x0
  80239a:	6a 00                	push   $0x0
  80239c:	6a 0e                	push   $0xe
  80239e:	e8 fd fd ff ff       	call   8021a0 <syscall>
  8023a3:	83 c4 18             	add    $0x18,%esp
}
  8023a6:	c9                   	leave  
  8023a7:	c3                   	ret    

008023a8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8023a8:	55                   	push   %ebp
  8023a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8023ab:	6a 00                	push   $0x0
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 00                	push   $0x0
  8023b1:	6a 00                	push   $0x0
  8023b3:	ff 75 08             	pushl  0x8(%ebp)
  8023b6:	6a 0f                	push   $0xf
  8023b8:	e8 e3 fd ff ff       	call   8021a0 <syscall>
  8023bd:	83 c4 18             	add    $0x18,%esp
}
  8023c0:	c9                   	leave  
  8023c1:	c3                   	ret    

008023c2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8023c2:	55                   	push   %ebp
  8023c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8023c5:	6a 00                	push   $0x0
  8023c7:	6a 00                	push   $0x0
  8023c9:	6a 00                	push   $0x0
  8023cb:	6a 00                	push   $0x0
  8023cd:	6a 00                	push   $0x0
  8023cf:	6a 10                	push   $0x10
  8023d1:	e8 ca fd ff ff       	call   8021a0 <syscall>
  8023d6:	83 c4 18             	add    $0x18,%esp
}
  8023d9:	90                   	nop
  8023da:	c9                   	leave  
  8023db:	c3                   	ret    

008023dc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8023dc:	55                   	push   %ebp
  8023dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 00                	push   $0x0
  8023e5:	6a 00                	push   $0x0
  8023e7:	6a 00                	push   $0x0
  8023e9:	6a 14                	push   $0x14
  8023eb:	e8 b0 fd ff ff       	call   8021a0 <syscall>
  8023f0:	83 c4 18             	add    $0x18,%esp
}
  8023f3:	90                   	nop
  8023f4:	c9                   	leave  
  8023f5:	c3                   	ret    

008023f6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8023f6:	55                   	push   %ebp
  8023f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	6a 00                	push   $0x0
  802401:	6a 00                	push   $0x0
  802403:	6a 15                	push   $0x15
  802405:	e8 96 fd ff ff       	call   8021a0 <syscall>
  80240a:	83 c4 18             	add    $0x18,%esp
}
  80240d:	90                   	nop
  80240e:	c9                   	leave  
  80240f:	c3                   	ret    

00802410 <sys_cputc>:


void
sys_cputc(const char c)
{
  802410:	55                   	push   %ebp
  802411:	89 e5                	mov    %esp,%ebp
  802413:	83 ec 04             	sub    $0x4,%esp
  802416:	8b 45 08             	mov    0x8(%ebp),%eax
  802419:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80241c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802420:	6a 00                	push   $0x0
  802422:	6a 00                	push   $0x0
  802424:	6a 00                	push   $0x0
  802426:	6a 00                	push   $0x0
  802428:	50                   	push   %eax
  802429:	6a 16                	push   $0x16
  80242b:	e8 70 fd ff ff       	call   8021a0 <syscall>
  802430:	83 c4 18             	add    $0x18,%esp
}
  802433:	90                   	nop
  802434:	c9                   	leave  
  802435:	c3                   	ret    

00802436 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802436:	55                   	push   %ebp
  802437:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802439:	6a 00                	push   $0x0
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 00                	push   $0x0
  802441:	6a 00                	push   $0x0
  802443:	6a 17                	push   $0x17
  802445:	e8 56 fd ff ff       	call   8021a0 <syscall>
  80244a:	83 c4 18             	add    $0x18,%esp
}
  80244d:	90                   	nop
  80244e:	c9                   	leave  
  80244f:	c3                   	ret    

00802450 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802450:	55                   	push   %ebp
  802451:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802453:	8b 45 08             	mov    0x8(%ebp),%eax
  802456:	6a 00                	push   $0x0
  802458:	6a 00                	push   $0x0
  80245a:	6a 00                	push   $0x0
  80245c:	ff 75 0c             	pushl  0xc(%ebp)
  80245f:	50                   	push   %eax
  802460:	6a 18                	push   $0x18
  802462:	e8 39 fd ff ff       	call   8021a0 <syscall>
  802467:	83 c4 18             	add    $0x18,%esp
}
  80246a:	c9                   	leave  
  80246b:	c3                   	ret    

0080246c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80246c:	55                   	push   %ebp
  80246d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80246f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802472:	8b 45 08             	mov    0x8(%ebp),%eax
  802475:	6a 00                	push   $0x0
  802477:	6a 00                	push   $0x0
  802479:	6a 00                	push   $0x0
  80247b:	52                   	push   %edx
  80247c:	50                   	push   %eax
  80247d:	6a 1b                	push   $0x1b
  80247f:	e8 1c fd ff ff       	call   8021a0 <syscall>
  802484:	83 c4 18             	add    $0x18,%esp
}
  802487:	c9                   	leave  
  802488:	c3                   	ret    

00802489 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802489:	55                   	push   %ebp
  80248a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80248c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80248f:	8b 45 08             	mov    0x8(%ebp),%eax
  802492:	6a 00                	push   $0x0
  802494:	6a 00                	push   $0x0
  802496:	6a 00                	push   $0x0
  802498:	52                   	push   %edx
  802499:	50                   	push   %eax
  80249a:	6a 19                	push   $0x19
  80249c:	e8 ff fc ff ff       	call   8021a0 <syscall>
  8024a1:	83 c4 18             	add    $0x18,%esp
}
  8024a4:	90                   	nop
  8024a5:	c9                   	leave  
  8024a6:	c3                   	ret    

008024a7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8024a7:	55                   	push   %ebp
  8024a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8024aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b0:	6a 00                	push   $0x0
  8024b2:	6a 00                	push   $0x0
  8024b4:	6a 00                	push   $0x0
  8024b6:	52                   	push   %edx
  8024b7:	50                   	push   %eax
  8024b8:	6a 1a                	push   $0x1a
  8024ba:	e8 e1 fc ff ff       	call   8021a0 <syscall>
  8024bf:	83 c4 18             	add    $0x18,%esp
}
  8024c2:	90                   	nop
  8024c3:	c9                   	leave  
  8024c4:	c3                   	ret    

008024c5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8024c5:	55                   	push   %ebp
  8024c6:	89 e5                	mov    %esp,%ebp
  8024c8:	83 ec 04             	sub    $0x4,%esp
  8024cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8024ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8024d1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8024d4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8024d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8024db:	6a 00                	push   $0x0
  8024dd:	51                   	push   %ecx
  8024de:	52                   	push   %edx
  8024df:	ff 75 0c             	pushl  0xc(%ebp)
  8024e2:	50                   	push   %eax
  8024e3:	6a 1c                	push   $0x1c
  8024e5:	e8 b6 fc ff ff       	call   8021a0 <syscall>
  8024ea:	83 c4 18             	add    $0x18,%esp
}
  8024ed:	c9                   	leave  
  8024ee:	c3                   	ret    

008024ef <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8024ef:	55                   	push   %ebp
  8024f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8024f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f8:	6a 00                	push   $0x0
  8024fa:	6a 00                	push   $0x0
  8024fc:	6a 00                	push   $0x0
  8024fe:	52                   	push   %edx
  8024ff:	50                   	push   %eax
  802500:	6a 1d                	push   $0x1d
  802502:	e8 99 fc ff ff       	call   8021a0 <syscall>
  802507:	83 c4 18             	add    $0x18,%esp
}
  80250a:	c9                   	leave  
  80250b:	c3                   	ret    

0080250c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80250c:	55                   	push   %ebp
  80250d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80250f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802512:	8b 55 0c             	mov    0xc(%ebp),%edx
  802515:	8b 45 08             	mov    0x8(%ebp),%eax
  802518:	6a 00                	push   $0x0
  80251a:	6a 00                	push   $0x0
  80251c:	51                   	push   %ecx
  80251d:	52                   	push   %edx
  80251e:	50                   	push   %eax
  80251f:	6a 1e                	push   $0x1e
  802521:	e8 7a fc ff ff       	call   8021a0 <syscall>
  802526:	83 c4 18             	add    $0x18,%esp
}
  802529:	c9                   	leave  
  80252a:	c3                   	ret    

0080252b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80252b:	55                   	push   %ebp
  80252c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80252e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802531:	8b 45 08             	mov    0x8(%ebp),%eax
  802534:	6a 00                	push   $0x0
  802536:	6a 00                	push   $0x0
  802538:	6a 00                	push   $0x0
  80253a:	52                   	push   %edx
  80253b:	50                   	push   %eax
  80253c:	6a 1f                	push   $0x1f
  80253e:	e8 5d fc ff ff       	call   8021a0 <syscall>
  802543:	83 c4 18             	add    $0x18,%esp
}
  802546:	c9                   	leave  
  802547:	c3                   	ret    

00802548 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802548:	55                   	push   %ebp
  802549:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80254b:	6a 00                	push   $0x0
  80254d:	6a 00                	push   $0x0
  80254f:	6a 00                	push   $0x0
  802551:	6a 00                	push   $0x0
  802553:	6a 00                	push   $0x0
  802555:	6a 20                	push   $0x20
  802557:	e8 44 fc ff ff       	call   8021a0 <syscall>
  80255c:	83 c4 18             	add    $0x18,%esp
}
  80255f:	c9                   	leave  
  802560:	c3                   	ret    

00802561 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802561:	55                   	push   %ebp
  802562:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802564:	8b 45 08             	mov    0x8(%ebp),%eax
  802567:	6a 00                	push   $0x0
  802569:	6a 00                	push   $0x0
  80256b:	ff 75 10             	pushl  0x10(%ebp)
  80256e:	ff 75 0c             	pushl  0xc(%ebp)
  802571:	50                   	push   %eax
  802572:	6a 21                	push   $0x21
  802574:	e8 27 fc ff ff       	call   8021a0 <syscall>
  802579:	83 c4 18             	add    $0x18,%esp
}
  80257c:	c9                   	leave  
  80257d:	c3                   	ret    

0080257e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80257e:	55                   	push   %ebp
  80257f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802581:	8b 45 08             	mov    0x8(%ebp),%eax
  802584:	6a 00                	push   $0x0
  802586:	6a 00                	push   $0x0
  802588:	6a 00                	push   $0x0
  80258a:	6a 00                	push   $0x0
  80258c:	50                   	push   %eax
  80258d:	6a 22                	push   $0x22
  80258f:	e8 0c fc ff ff       	call   8021a0 <syscall>
  802594:	83 c4 18             	add    $0x18,%esp
}
  802597:	90                   	nop
  802598:	c9                   	leave  
  802599:	c3                   	ret    

0080259a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80259a:	55                   	push   %ebp
  80259b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80259d:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a0:	6a 00                	push   $0x0
  8025a2:	6a 00                	push   $0x0
  8025a4:	6a 00                	push   $0x0
  8025a6:	6a 00                	push   $0x0
  8025a8:	50                   	push   %eax
  8025a9:	6a 23                	push   $0x23
  8025ab:	e8 f0 fb ff ff       	call   8021a0 <syscall>
  8025b0:	83 c4 18             	add    $0x18,%esp
}
  8025b3:	90                   	nop
  8025b4:	c9                   	leave  
  8025b5:	c3                   	ret    

008025b6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8025b6:	55                   	push   %ebp
  8025b7:	89 e5                	mov    %esp,%ebp
  8025b9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8025bc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8025bf:	8d 50 04             	lea    0x4(%eax),%edx
  8025c2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8025c5:	6a 00                	push   $0x0
  8025c7:	6a 00                	push   $0x0
  8025c9:	6a 00                	push   $0x0
  8025cb:	52                   	push   %edx
  8025cc:	50                   	push   %eax
  8025cd:	6a 24                	push   $0x24
  8025cf:	e8 cc fb ff ff       	call   8021a0 <syscall>
  8025d4:	83 c4 18             	add    $0x18,%esp
	return result;
  8025d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8025da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8025e0:	89 01                	mov    %eax,(%ecx)
  8025e2:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8025e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8025e8:	c9                   	leave  
  8025e9:	c2 04 00             	ret    $0x4

008025ec <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8025ec:	55                   	push   %ebp
  8025ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8025ef:	6a 00                	push   $0x0
  8025f1:	6a 00                	push   $0x0
  8025f3:	ff 75 10             	pushl  0x10(%ebp)
  8025f6:	ff 75 0c             	pushl  0xc(%ebp)
  8025f9:	ff 75 08             	pushl  0x8(%ebp)
  8025fc:	6a 13                	push   $0x13
  8025fe:	e8 9d fb ff ff       	call   8021a0 <syscall>
  802603:	83 c4 18             	add    $0x18,%esp
	return ;
  802606:	90                   	nop
}
  802607:	c9                   	leave  
  802608:	c3                   	ret    

00802609 <sys_rcr2>:
uint32 sys_rcr2()
{
  802609:	55                   	push   %ebp
  80260a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80260c:	6a 00                	push   $0x0
  80260e:	6a 00                	push   $0x0
  802610:	6a 00                	push   $0x0
  802612:	6a 00                	push   $0x0
  802614:	6a 00                	push   $0x0
  802616:	6a 25                	push   $0x25
  802618:	e8 83 fb ff ff       	call   8021a0 <syscall>
  80261d:	83 c4 18             	add    $0x18,%esp
}
  802620:	c9                   	leave  
  802621:	c3                   	ret    

00802622 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802622:	55                   	push   %ebp
  802623:	89 e5                	mov    %esp,%ebp
  802625:	83 ec 04             	sub    $0x4,%esp
  802628:	8b 45 08             	mov    0x8(%ebp),%eax
  80262b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80262e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802632:	6a 00                	push   $0x0
  802634:	6a 00                	push   $0x0
  802636:	6a 00                	push   $0x0
  802638:	6a 00                	push   $0x0
  80263a:	50                   	push   %eax
  80263b:	6a 26                	push   $0x26
  80263d:	e8 5e fb ff ff       	call   8021a0 <syscall>
  802642:	83 c4 18             	add    $0x18,%esp
	return ;
  802645:	90                   	nop
}
  802646:	c9                   	leave  
  802647:	c3                   	ret    

00802648 <rsttst>:
void rsttst()
{
  802648:	55                   	push   %ebp
  802649:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 00                	push   $0x0
  802655:	6a 28                	push   $0x28
  802657:	e8 44 fb ff ff       	call   8021a0 <syscall>
  80265c:	83 c4 18             	add    $0x18,%esp
	return ;
  80265f:	90                   	nop
}
  802660:	c9                   	leave  
  802661:	c3                   	ret    

00802662 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802662:	55                   	push   %ebp
  802663:	89 e5                	mov    %esp,%ebp
  802665:	83 ec 04             	sub    $0x4,%esp
  802668:	8b 45 14             	mov    0x14(%ebp),%eax
  80266b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80266e:	8b 55 18             	mov    0x18(%ebp),%edx
  802671:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802675:	52                   	push   %edx
  802676:	50                   	push   %eax
  802677:	ff 75 10             	pushl  0x10(%ebp)
  80267a:	ff 75 0c             	pushl  0xc(%ebp)
  80267d:	ff 75 08             	pushl  0x8(%ebp)
  802680:	6a 27                	push   $0x27
  802682:	e8 19 fb ff ff       	call   8021a0 <syscall>
  802687:	83 c4 18             	add    $0x18,%esp
	return ;
  80268a:	90                   	nop
}
  80268b:	c9                   	leave  
  80268c:	c3                   	ret    

0080268d <chktst>:
void chktst(uint32 n)
{
  80268d:	55                   	push   %ebp
  80268e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802690:	6a 00                	push   $0x0
  802692:	6a 00                	push   $0x0
  802694:	6a 00                	push   $0x0
  802696:	6a 00                	push   $0x0
  802698:	ff 75 08             	pushl  0x8(%ebp)
  80269b:	6a 29                	push   $0x29
  80269d:	e8 fe fa ff ff       	call   8021a0 <syscall>
  8026a2:	83 c4 18             	add    $0x18,%esp
	return ;
  8026a5:	90                   	nop
}
  8026a6:	c9                   	leave  
  8026a7:	c3                   	ret    

008026a8 <inctst>:

void inctst()
{
  8026a8:	55                   	push   %ebp
  8026a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8026ab:	6a 00                	push   $0x0
  8026ad:	6a 00                	push   $0x0
  8026af:	6a 00                	push   $0x0
  8026b1:	6a 00                	push   $0x0
  8026b3:	6a 00                	push   $0x0
  8026b5:	6a 2a                	push   $0x2a
  8026b7:	e8 e4 fa ff ff       	call   8021a0 <syscall>
  8026bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8026bf:	90                   	nop
}
  8026c0:	c9                   	leave  
  8026c1:	c3                   	ret    

008026c2 <gettst>:
uint32 gettst()
{
  8026c2:	55                   	push   %ebp
  8026c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8026c5:	6a 00                	push   $0x0
  8026c7:	6a 00                	push   $0x0
  8026c9:	6a 00                	push   $0x0
  8026cb:	6a 00                	push   $0x0
  8026cd:	6a 00                	push   $0x0
  8026cf:	6a 2b                	push   $0x2b
  8026d1:	e8 ca fa ff ff       	call   8021a0 <syscall>
  8026d6:	83 c4 18             	add    $0x18,%esp
}
  8026d9:	c9                   	leave  
  8026da:	c3                   	ret    

008026db <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8026db:	55                   	push   %ebp
  8026dc:	89 e5                	mov    %esp,%ebp
  8026de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026e1:	6a 00                	push   $0x0
  8026e3:	6a 00                	push   $0x0
  8026e5:	6a 00                	push   $0x0
  8026e7:	6a 00                	push   $0x0
  8026e9:	6a 00                	push   $0x0
  8026eb:	6a 2c                	push   $0x2c
  8026ed:	e8 ae fa ff ff       	call   8021a0 <syscall>
  8026f2:	83 c4 18             	add    $0x18,%esp
  8026f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8026f8:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8026fc:	75 07                	jne    802705 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8026fe:	b8 01 00 00 00       	mov    $0x1,%eax
  802703:	eb 05                	jmp    80270a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802705:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80270a:	c9                   	leave  
  80270b:	c3                   	ret    

0080270c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80270c:	55                   	push   %ebp
  80270d:	89 e5                	mov    %esp,%ebp
  80270f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802712:	6a 00                	push   $0x0
  802714:	6a 00                	push   $0x0
  802716:	6a 00                	push   $0x0
  802718:	6a 00                	push   $0x0
  80271a:	6a 00                	push   $0x0
  80271c:	6a 2c                	push   $0x2c
  80271e:	e8 7d fa ff ff       	call   8021a0 <syscall>
  802723:	83 c4 18             	add    $0x18,%esp
  802726:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802729:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80272d:	75 07                	jne    802736 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80272f:	b8 01 00 00 00       	mov    $0x1,%eax
  802734:	eb 05                	jmp    80273b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802736:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80273b:	c9                   	leave  
  80273c:	c3                   	ret    

0080273d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80273d:	55                   	push   %ebp
  80273e:	89 e5                	mov    %esp,%ebp
  802740:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802743:	6a 00                	push   $0x0
  802745:	6a 00                	push   $0x0
  802747:	6a 00                	push   $0x0
  802749:	6a 00                	push   $0x0
  80274b:	6a 00                	push   $0x0
  80274d:	6a 2c                	push   $0x2c
  80274f:	e8 4c fa ff ff       	call   8021a0 <syscall>
  802754:	83 c4 18             	add    $0x18,%esp
  802757:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80275a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80275e:	75 07                	jne    802767 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802760:	b8 01 00 00 00       	mov    $0x1,%eax
  802765:	eb 05                	jmp    80276c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802767:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80276c:	c9                   	leave  
  80276d:	c3                   	ret    

0080276e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80276e:	55                   	push   %ebp
  80276f:	89 e5                	mov    %esp,%ebp
  802771:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802774:	6a 00                	push   $0x0
  802776:	6a 00                	push   $0x0
  802778:	6a 00                	push   $0x0
  80277a:	6a 00                	push   $0x0
  80277c:	6a 00                	push   $0x0
  80277e:	6a 2c                	push   $0x2c
  802780:	e8 1b fa ff ff       	call   8021a0 <syscall>
  802785:	83 c4 18             	add    $0x18,%esp
  802788:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80278b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80278f:	75 07                	jne    802798 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802791:	b8 01 00 00 00       	mov    $0x1,%eax
  802796:	eb 05                	jmp    80279d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802798:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80279d:	c9                   	leave  
  80279e:	c3                   	ret    

0080279f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80279f:	55                   	push   %ebp
  8027a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8027a2:	6a 00                	push   $0x0
  8027a4:	6a 00                	push   $0x0
  8027a6:	6a 00                	push   $0x0
  8027a8:	6a 00                	push   $0x0
  8027aa:	ff 75 08             	pushl  0x8(%ebp)
  8027ad:	6a 2d                	push   $0x2d
  8027af:	e8 ec f9 ff ff       	call   8021a0 <syscall>
  8027b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8027b7:	90                   	nop
}
  8027b8:	c9                   	leave  
  8027b9:	c3                   	ret    
  8027ba:	66 90                	xchg   %ax,%ax

008027bc <__udivdi3>:
  8027bc:	55                   	push   %ebp
  8027bd:	57                   	push   %edi
  8027be:	56                   	push   %esi
  8027bf:	53                   	push   %ebx
  8027c0:	83 ec 1c             	sub    $0x1c,%esp
  8027c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8027c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8027cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8027cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8027d3:	89 ca                	mov    %ecx,%edx
  8027d5:	89 f8                	mov    %edi,%eax
  8027d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8027db:	85 f6                	test   %esi,%esi
  8027dd:	75 2d                	jne    80280c <__udivdi3+0x50>
  8027df:	39 cf                	cmp    %ecx,%edi
  8027e1:	77 65                	ja     802848 <__udivdi3+0x8c>
  8027e3:	89 fd                	mov    %edi,%ebp
  8027e5:	85 ff                	test   %edi,%edi
  8027e7:	75 0b                	jne    8027f4 <__udivdi3+0x38>
  8027e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8027ee:	31 d2                	xor    %edx,%edx
  8027f0:	f7 f7                	div    %edi
  8027f2:	89 c5                	mov    %eax,%ebp
  8027f4:	31 d2                	xor    %edx,%edx
  8027f6:	89 c8                	mov    %ecx,%eax
  8027f8:	f7 f5                	div    %ebp
  8027fa:	89 c1                	mov    %eax,%ecx
  8027fc:	89 d8                	mov    %ebx,%eax
  8027fe:	f7 f5                	div    %ebp
  802800:	89 cf                	mov    %ecx,%edi
  802802:	89 fa                	mov    %edi,%edx
  802804:	83 c4 1c             	add    $0x1c,%esp
  802807:	5b                   	pop    %ebx
  802808:	5e                   	pop    %esi
  802809:	5f                   	pop    %edi
  80280a:	5d                   	pop    %ebp
  80280b:	c3                   	ret    
  80280c:	39 ce                	cmp    %ecx,%esi
  80280e:	77 28                	ja     802838 <__udivdi3+0x7c>
  802810:	0f bd fe             	bsr    %esi,%edi
  802813:	83 f7 1f             	xor    $0x1f,%edi
  802816:	75 40                	jne    802858 <__udivdi3+0x9c>
  802818:	39 ce                	cmp    %ecx,%esi
  80281a:	72 0a                	jb     802826 <__udivdi3+0x6a>
  80281c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802820:	0f 87 9e 00 00 00    	ja     8028c4 <__udivdi3+0x108>
  802826:	b8 01 00 00 00       	mov    $0x1,%eax
  80282b:	89 fa                	mov    %edi,%edx
  80282d:	83 c4 1c             	add    $0x1c,%esp
  802830:	5b                   	pop    %ebx
  802831:	5e                   	pop    %esi
  802832:	5f                   	pop    %edi
  802833:	5d                   	pop    %ebp
  802834:	c3                   	ret    
  802835:	8d 76 00             	lea    0x0(%esi),%esi
  802838:	31 ff                	xor    %edi,%edi
  80283a:	31 c0                	xor    %eax,%eax
  80283c:	89 fa                	mov    %edi,%edx
  80283e:	83 c4 1c             	add    $0x1c,%esp
  802841:	5b                   	pop    %ebx
  802842:	5e                   	pop    %esi
  802843:	5f                   	pop    %edi
  802844:	5d                   	pop    %ebp
  802845:	c3                   	ret    
  802846:	66 90                	xchg   %ax,%ax
  802848:	89 d8                	mov    %ebx,%eax
  80284a:	f7 f7                	div    %edi
  80284c:	31 ff                	xor    %edi,%edi
  80284e:	89 fa                	mov    %edi,%edx
  802850:	83 c4 1c             	add    $0x1c,%esp
  802853:	5b                   	pop    %ebx
  802854:	5e                   	pop    %esi
  802855:	5f                   	pop    %edi
  802856:	5d                   	pop    %ebp
  802857:	c3                   	ret    
  802858:	bd 20 00 00 00       	mov    $0x20,%ebp
  80285d:	89 eb                	mov    %ebp,%ebx
  80285f:	29 fb                	sub    %edi,%ebx
  802861:	89 f9                	mov    %edi,%ecx
  802863:	d3 e6                	shl    %cl,%esi
  802865:	89 c5                	mov    %eax,%ebp
  802867:	88 d9                	mov    %bl,%cl
  802869:	d3 ed                	shr    %cl,%ebp
  80286b:	89 e9                	mov    %ebp,%ecx
  80286d:	09 f1                	or     %esi,%ecx
  80286f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802873:	89 f9                	mov    %edi,%ecx
  802875:	d3 e0                	shl    %cl,%eax
  802877:	89 c5                	mov    %eax,%ebp
  802879:	89 d6                	mov    %edx,%esi
  80287b:	88 d9                	mov    %bl,%cl
  80287d:	d3 ee                	shr    %cl,%esi
  80287f:	89 f9                	mov    %edi,%ecx
  802881:	d3 e2                	shl    %cl,%edx
  802883:	8b 44 24 08          	mov    0x8(%esp),%eax
  802887:	88 d9                	mov    %bl,%cl
  802889:	d3 e8                	shr    %cl,%eax
  80288b:	09 c2                	or     %eax,%edx
  80288d:	89 d0                	mov    %edx,%eax
  80288f:	89 f2                	mov    %esi,%edx
  802891:	f7 74 24 0c          	divl   0xc(%esp)
  802895:	89 d6                	mov    %edx,%esi
  802897:	89 c3                	mov    %eax,%ebx
  802899:	f7 e5                	mul    %ebp
  80289b:	39 d6                	cmp    %edx,%esi
  80289d:	72 19                	jb     8028b8 <__udivdi3+0xfc>
  80289f:	74 0b                	je     8028ac <__udivdi3+0xf0>
  8028a1:	89 d8                	mov    %ebx,%eax
  8028a3:	31 ff                	xor    %edi,%edi
  8028a5:	e9 58 ff ff ff       	jmp    802802 <__udivdi3+0x46>
  8028aa:	66 90                	xchg   %ax,%ax
  8028ac:	8b 54 24 08          	mov    0x8(%esp),%edx
  8028b0:	89 f9                	mov    %edi,%ecx
  8028b2:	d3 e2                	shl    %cl,%edx
  8028b4:	39 c2                	cmp    %eax,%edx
  8028b6:	73 e9                	jae    8028a1 <__udivdi3+0xe5>
  8028b8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8028bb:	31 ff                	xor    %edi,%edi
  8028bd:	e9 40 ff ff ff       	jmp    802802 <__udivdi3+0x46>
  8028c2:	66 90                	xchg   %ax,%ax
  8028c4:	31 c0                	xor    %eax,%eax
  8028c6:	e9 37 ff ff ff       	jmp    802802 <__udivdi3+0x46>
  8028cb:	90                   	nop

008028cc <__umoddi3>:
  8028cc:	55                   	push   %ebp
  8028cd:	57                   	push   %edi
  8028ce:	56                   	push   %esi
  8028cf:	53                   	push   %ebx
  8028d0:	83 ec 1c             	sub    $0x1c,%esp
  8028d3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8028d7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8028db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8028df:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8028e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8028e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8028eb:	89 f3                	mov    %esi,%ebx
  8028ed:	89 fa                	mov    %edi,%edx
  8028ef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8028f3:	89 34 24             	mov    %esi,(%esp)
  8028f6:	85 c0                	test   %eax,%eax
  8028f8:	75 1a                	jne    802914 <__umoddi3+0x48>
  8028fa:	39 f7                	cmp    %esi,%edi
  8028fc:	0f 86 a2 00 00 00    	jbe    8029a4 <__umoddi3+0xd8>
  802902:	89 c8                	mov    %ecx,%eax
  802904:	89 f2                	mov    %esi,%edx
  802906:	f7 f7                	div    %edi
  802908:	89 d0                	mov    %edx,%eax
  80290a:	31 d2                	xor    %edx,%edx
  80290c:	83 c4 1c             	add    $0x1c,%esp
  80290f:	5b                   	pop    %ebx
  802910:	5e                   	pop    %esi
  802911:	5f                   	pop    %edi
  802912:	5d                   	pop    %ebp
  802913:	c3                   	ret    
  802914:	39 f0                	cmp    %esi,%eax
  802916:	0f 87 ac 00 00 00    	ja     8029c8 <__umoddi3+0xfc>
  80291c:	0f bd e8             	bsr    %eax,%ebp
  80291f:	83 f5 1f             	xor    $0x1f,%ebp
  802922:	0f 84 ac 00 00 00    	je     8029d4 <__umoddi3+0x108>
  802928:	bf 20 00 00 00       	mov    $0x20,%edi
  80292d:	29 ef                	sub    %ebp,%edi
  80292f:	89 fe                	mov    %edi,%esi
  802931:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802935:	89 e9                	mov    %ebp,%ecx
  802937:	d3 e0                	shl    %cl,%eax
  802939:	89 d7                	mov    %edx,%edi
  80293b:	89 f1                	mov    %esi,%ecx
  80293d:	d3 ef                	shr    %cl,%edi
  80293f:	09 c7                	or     %eax,%edi
  802941:	89 e9                	mov    %ebp,%ecx
  802943:	d3 e2                	shl    %cl,%edx
  802945:	89 14 24             	mov    %edx,(%esp)
  802948:	89 d8                	mov    %ebx,%eax
  80294a:	d3 e0                	shl    %cl,%eax
  80294c:	89 c2                	mov    %eax,%edx
  80294e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802952:	d3 e0                	shl    %cl,%eax
  802954:	89 44 24 04          	mov    %eax,0x4(%esp)
  802958:	8b 44 24 08          	mov    0x8(%esp),%eax
  80295c:	89 f1                	mov    %esi,%ecx
  80295e:	d3 e8                	shr    %cl,%eax
  802960:	09 d0                	or     %edx,%eax
  802962:	d3 eb                	shr    %cl,%ebx
  802964:	89 da                	mov    %ebx,%edx
  802966:	f7 f7                	div    %edi
  802968:	89 d3                	mov    %edx,%ebx
  80296a:	f7 24 24             	mull   (%esp)
  80296d:	89 c6                	mov    %eax,%esi
  80296f:	89 d1                	mov    %edx,%ecx
  802971:	39 d3                	cmp    %edx,%ebx
  802973:	0f 82 87 00 00 00    	jb     802a00 <__umoddi3+0x134>
  802979:	0f 84 91 00 00 00    	je     802a10 <__umoddi3+0x144>
  80297f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802983:	29 f2                	sub    %esi,%edx
  802985:	19 cb                	sbb    %ecx,%ebx
  802987:	89 d8                	mov    %ebx,%eax
  802989:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80298d:	d3 e0                	shl    %cl,%eax
  80298f:	89 e9                	mov    %ebp,%ecx
  802991:	d3 ea                	shr    %cl,%edx
  802993:	09 d0                	or     %edx,%eax
  802995:	89 e9                	mov    %ebp,%ecx
  802997:	d3 eb                	shr    %cl,%ebx
  802999:	89 da                	mov    %ebx,%edx
  80299b:	83 c4 1c             	add    $0x1c,%esp
  80299e:	5b                   	pop    %ebx
  80299f:	5e                   	pop    %esi
  8029a0:	5f                   	pop    %edi
  8029a1:	5d                   	pop    %ebp
  8029a2:	c3                   	ret    
  8029a3:	90                   	nop
  8029a4:	89 fd                	mov    %edi,%ebp
  8029a6:	85 ff                	test   %edi,%edi
  8029a8:	75 0b                	jne    8029b5 <__umoddi3+0xe9>
  8029aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8029af:	31 d2                	xor    %edx,%edx
  8029b1:	f7 f7                	div    %edi
  8029b3:	89 c5                	mov    %eax,%ebp
  8029b5:	89 f0                	mov    %esi,%eax
  8029b7:	31 d2                	xor    %edx,%edx
  8029b9:	f7 f5                	div    %ebp
  8029bb:	89 c8                	mov    %ecx,%eax
  8029bd:	f7 f5                	div    %ebp
  8029bf:	89 d0                	mov    %edx,%eax
  8029c1:	e9 44 ff ff ff       	jmp    80290a <__umoddi3+0x3e>
  8029c6:	66 90                	xchg   %ax,%ax
  8029c8:	89 c8                	mov    %ecx,%eax
  8029ca:	89 f2                	mov    %esi,%edx
  8029cc:	83 c4 1c             	add    $0x1c,%esp
  8029cf:	5b                   	pop    %ebx
  8029d0:	5e                   	pop    %esi
  8029d1:	5f                   	pop    %edi
  8029d2:	5d                   	pop    %ebp
  8029d3:	c3                   	ret    
  8029d4:	3b 04 24             	cmp    (%esp),%eax
  8029d7:	72 06                	jb     8029df <__umoddi3+0x113>
  8029d9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8029dd:	77 0f                	ja     8029ee <__umoddi3+0x122>
  8029df:	89 f2                	mov    %esi,%edx
  8029e1:	29 f9                	sub    %edi,%ecx
  8029e3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8029e7:	89 14 24             	mov    %edx,(%esp)
  8029ea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8029ee:	8b 44 24 04          	mov    0x4(%esp),%eax
  8029f2:	8b 14 24             	mov    (%esp),%edx
  8029f5:	83 c4 1c             	add    $0x1c,%esp
  8029f8:	5b                   	pop    %ebx
  8029f9:	5e                   	pop    %esi
  8029fa:	5f                   	pop    %edi
  8029fb:	5d                   	pop    %ebp
  8029fc:	c3                   	ret    
  8029fd:	8d 76 00             	lea    0x0(%esi),%esi
  802a00:	2b 04 24             	sub    (%esp),%eax
  802a03:	19 fa                	sbb    %edi,%edx
  802a05:	89 d1                	mov    %edx,%ecx
  802a07:	89 c6                	mov    %eax,%esi
  802a09:	e9 71 ff ff ff       	jmp    80297f <__umoddi3+0xb3>
  802a0e:	66 90                	xchg   %ax,%ax
  802a10:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802a14:	72 ea                	jb     802a00 <__umoddi3+0x134>
  802a16:	89 d9                	mov    %ebx,%ecx
  802a18:	e9 62 ff ff ff       	jmp    80297f <__umoddi3+0xb3>
