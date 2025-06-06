
obj/user/tst_realloc_2:     file format elf32-i386


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
  800031:	e8 b7 12 00 00       	call   8012ed <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 c4 80             	add    $0xffffff80,%esp
	int Mega = 1024*1024;
  800040:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)
	int kilo = 1024;
  800047:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
	void* ptr_allocations[20] = {0};
  80004e:	8d 95 78 ff ff ff    	lea    -0x88(%ebp),%edx
  800054:	b9 14 00 00 00       	mov    $0x14,%ecx
  800059:	b8 00 00 00 00       	mov    $0x0,%eax
  80005e:	89 d7                	mov    %edx,%edi
  800060:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  800062:	83 ec 0c             	sub    $0xc,%esp
  800065:	68 40 2f 80 00       	push   $0x802f40
  80006a:	e8 34 16 00 00       	call   8016a3 <cprintf>
  80006f:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800072:	e8 b2 27 00 00       	call   802829 <sys_calculate_free_frames>
  800077:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80007a:	e8 2d 28 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80007f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  800082:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800085:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800088:	83 ec 0c             	sub    $0xc,%esp
  80008b:	50                   	push   %eax
  80008c:	e8 d6 23 00 00       	call   802467 <malloc>
  800091:	83 c4 10             	add    $0x10,%esp
  800094:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
		if ((uint32) ptr_allocations[0] !=  (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80009a:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8000a0:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000a5:	74 14                	je     8000bb <_main+0x83>
  8000a7:	83 ec 04             	sub    $0x4,%esp
  8000aa:	68 64 2f 80 00       	push   $0x802f64
  8000af:	6a 11                	push   $0x11
  8000b1:	68 94 2f 80 00       	push   $0x802f94
  8000b6:	e8 34 13 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000bb:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8000be:	e8 66 27 00 00       	call   802829 <sys_calculate_free_frames>
  8000c3:	29 c3                	sub    %eax,%ebx
  8000c5:	89 d8                	mov    %ebx,%eax
  8000c7:	83 f8 01             	cmp    $0x1,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 ac 2f 80 00       	push   $0x802fac
  8000d4:	6a 13                	push   $0x13
  8000d6:	68 94 2f 80 00       	push   $0x802f94
  8000db:	e8 0f 13 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  8000e0:	e8 c7 27 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8000e5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000e8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8000ed:	74 14                	je     800103 <_main+0xcb>
  8000ef:	83 ec 04             	sub    $0x4,%esp
  8000f2:	68 18 30 80 00       	push   $0x803018
  8000f7:	6a 14                	push   $0x14
  8000f9:	68 94 2f 80 00       	push   $0x802f94
  8000fe:	e8 ec 12 00 00       	call   8013ef <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800103:	e8 21 27 00 00       	call   802829 <sys_calculate_free_frames>
  800108:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80010b:	e8 9c 27 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800110:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800113:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800116:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	50                   	push   %eax
  80011d:	e8 45 23 00 00       	call   802467 <malloc>
  800122:	83 c4 10             	add    $0x10,%esp
  800125:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80012b:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800131:	89 c2                	mov    %eax,%edx
  800133:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800136:	05 00 00 00 80       	add    $0x80000000,%eax
  80013b:	39 c2                	cmp    %eax,%edx
  80013d:	74 14                	je     800153 <_main+0x11b>
  80013f:	83 ec 04             	sub    $0x4,%esp
  800142:	68 64 2f 80 00       	push   $0x802f64
  800147:	6a 1a                	push   $0x1a
  800149:	68 94 2f 80 00       	push   $0x802f94
  80014e:	e8 9c 12 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800153:	e8 d1 26 00 00       	call   802829 <sys_calculate_free_frames>
  800158:	89 c2                	mov    %eax,%edx
  80015a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80015d:	39 c2                	cmp    %eax,%edx
  80015f:	74 14                	je     800175 <_main+0x13d>
  800161:	83 ec 04             	sub    $0x4,%esp
  800164:	68 ac 2f 80 00       	push   $0x802fac
  800169:	6a 1c                	push   $0x1c
  80016b:	68 94 2f 80 00       	push   $0x802f94
  800170:	e8 7a 12 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800175:	e8 32 27 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80017a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80017d:	3d 00 01 00 00       	cmp    $0x100,%eax
  800182:	74 14                	je     800198 <_main+0x160>
  800184:	83 ec 04             	sub    $0x4,%esp
  800187:	68 18 30 80 00       	push   $0x803018
  80018c:	6a 1d                	push   $0x1d
  80018e:	68 94 2f 80 00       	push   $0x802f94
  800193:	e8 57 12 00 00       	call   8013ef <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800198:	e8 8c 26 00 00       	call   802829 <sys_calculate_free_frames>
  80019d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001a0:	e8 07 27 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8001a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001ab:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001ae:	83 ec 0c             	sub    $0xc,%esp
  8001b1:	50                   	push   %eax
  8001b2:	e8 b0 22 00 00       	call   802467 <malloc>
  8001b7:	83 c4 10             	add    $0x10,%esp
  8001ba:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  8001bd:	8b 45 80             	mov    -0x80(%ebp),%eax
  8001c0:	89 c2                	mov    %eax,%edx
  8001c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001c5:	01 c0                	add    %eax,%eax
  8001c7:	05 00 00 00 80       	add    $0x80000000,%eax
  8001cc:	39 c2                	cmp    %eax,%edx
  8001ce:	74 14                	je     8001e4 <_main+0x1ac>
  8001d0:	83 ec 04             	sub    $0x4,%esp
  8001d3:	68 64 2f 80 00       	push   $0x802f64
  8001d8:	6a 23                	push   $0x23
  8001da:	68 94 2f 80 00       	push   $0x802f94
  8001df:	e8 0b 12 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001e4:	e8 40 26 00 00       	call   802829 <sys_calculate_free_frames>
  8001e9:	89 c2                	mov    %eax,%edx
  8001eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001ee:	39 c2                	cmp    %eax,%edx
  8001f0:	74 14                	je     800206 <_main+0x1ce>
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	68 ac 2f 80 00       	push   $0x802fac
  8001fa:	6a 25                	push   $0x25
  8001fc:	68 94 2f 80 00       	push   $0x802f94
  800201:	e8 e9 11 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800206:	e8 a1 26 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80020b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80020e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800213:	74 14                	je     800229 <_main+0x1f1>
  800215:	83 ec 04             	sub    $0x4,%esp
  800218:	68 18 30 80 00       	push   $0x803018
  80021d:	6a 26                	push   $0x26
  80021f:	68 94 2f 80 00       	push   $0x802f94
  800224:	e8 c6 11 00 00       	call   8013ef <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800229:	e8 fb 25 00 00       	call   802829 <sys_calculate_free_frames>
  80022e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800231:	e8 76 26 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800236:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800239:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80023c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80023f:	83 ec 0c             	sub    $0xc,%esp
  800242:	50                   	push   %eax
  800243:	e8 1f 22 00 00       	call   802467 <malloc>
  800248:	83 c4 10             	add    $0x10,%esp
  80024b:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  80024e:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800251:	89 c1                	mov    %eax,%ecx
  800253:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800256:	89 c2                	mov    %eax,%edx
  800258:	01 d2                	add    %edx,%edx
  80025a:	01 d0                	add    %edx,%eax
  80025c:	05 00 00 00 80       	add    $0x80000000,%eax
  800261:	39 c1                	cmp    %eax,%ecx
  800263:	74 14                	je     800279 <_main+0x241>
  800265:	83 ec 04             	sub    $0x4,%esp
  800268:	68 64 2f 80 00       	push   $0x802f64
  80026d:	6a 2c                	push   $0x2c
  80026f:	68 94 2f 80 00       	push   $0x802f94
  800274:	e8 76 11 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800279:	e8 ab 25 00 00       	call   802829 <sys_calculate_free_frames>
  80027e:	89 c2                	mov    %eax,%edx
  800280:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800283:	39 c2                	cmp    %eax,%edx
  800285:	74 14                	je     80029b <_main+0x263>
  800287:	83 ec 04             	sub    $0x4,%esp
  80028a:	68 ac 2f 80 00       	push   $0x802fac
  80028f:	6a 2e                	push   $0x2e
  800291:	68 94 2f 80 00       	push   $0x802f94
  800296:	e8 54 11 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  80029b:	e8 0c 26 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8002a0:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002a3:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002a8:	74 14                	je     8002be <_main+0x286>
  8002aa:	83 ec 04             	sub    $0x4,%esp
  8002ad:	68 18 30 80 00       	push   $0x803018
  8002b2:	6a 2f                	push   $0x2f
  8002b4:	68 94 2f 80 00       	push   $0x802f94
  8002b9:	e8 31 11 00 00       	call   8013ef <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8002be:	e8 66 25 00 00       	call   802829 <sys_calculate_free_frames>
  8002c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002c6:	e8 e1 25 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8002cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  8002ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002d1:	01 c0                	add    %eax,%eax
  8002d3:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8002d6:	83 ec 0c             	sub    $0xc,%esp
  8002d9:	50                   	push   %eax
  8002da:	e8 88 21 00 00       	call   802467 <malloc>
  8002df:	83 c4 10             	add    $0x10,%esp
  8002e2:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8002e5:	8b 45 88             	mov    -0x78(%ebp),%eax
  8002e8:	89 c2                	mov    %eax,%edx
  8002ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002ed:	c1 e0 02             	shl    $0x2,%eax
  8002f0:	05 00 00 00 80       	add    $0x80000000,%eax
  8002f5:	39 c2                	cmp    %eax,%edx
  8002f7:	74 14                	je     80030d <_main+0x2d5>
  8002f9:	83 ec 04             	sub    $0x4,%esp
  8002fc:	68 64 2f 80 00       	push   $0x802f64
  800301:	6a 35                	push   $0x35
  800303:	68 94 2f 80 00       	push   $0x802f94
  800308:	e8 e2 10 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80030d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800310:	e8 14 25 00 00       	call   802829 <sys_calculate_free_frames>
  800315:	29 c3                	sub    %eax,%ebx
  800317:	89 d8                	mov    %ebx,%eax
  800319:	83 f8 01             	cmp    $0x1,%eax
  80031c:	74 14                	je     800332 <_main+0x2fa>
  80031e:	83 ec 04             	sub    $0x4,%esp
  800321:	68 ac 2f 80 00       	push   $0x802fac
  800326:	6a 37                	push   $0x37
  800328:	68 94 2f 80 00       	push   $0x802f94
  80032d:	e8 bd 10 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800332:	e8 75 25 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800337:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80033a:	3d 00 02 00 00       	cmp    $0x200,%eax
  80033f:	74 14                	je     800355 <_main+0x31d>
  800341:	83 ec 04             	sub    $0x4,%esp
  800344:	68 18 30 80 00       	push   $0x803018
  800349:	6a 38                	push   $0x38
  80034b:	68 94 2f 80 00       	push   $0x802f94
  800350:	e8 9a 10 00 00       	call   8013ef <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800355:	e8 cf 24 00 00       	call   802829 <sys_calculate_free_frames>
  80035a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80035d:	e8 4a 25 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800362:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  800365:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800368:	01 c0                	add    %eax,%eax
  80036a:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80036d:	83 ec 0c             	sub    $0xc,%esp
  800370:	50                   	push   %eax
  800371:	e8 f1 20 00 00       	call   802467 <malloc>
  800376:	83 c4 10             	add    $0x10,%esp
  800379:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  80037c:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80037f:	89 c1                	mov    %eax,%ecx
  800381:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800384:	89 d0                	mov    %edx,%eax
  800386:	01 c0                	add    %eax,%eax
  800388:	01 d0                	add    %edx,%eax
  80038a:	01 c0                	add    %eax,%eax
  80038c:	05 00 00 00 80       	add    $0x80000000,%eax
  800391:	39 c1                	cmp    %eax,%ecx
  800393:	74 14                	je     8003a9 <_main+0x371>
  800395:	83 ec 04             	sub    $0x4,%esp
  800398:	68 64 2f 80 00       	push   $0x802f64
  80039d:	6a 3e                	push   $0x3e
  80039f:	68 94 2f 80 00       	push   $0x802f94
  8003a4:	e8 46 10 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8003a9:	e8 7b 24 00 00       	call   802829 <sys_calculate_free_frames>
  8003ae:	89 c2                	mov    %eax,%edx
  8003b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b3:	39 c2                	cmp    %eax,%edx
  8003b5:	74 14                	je     8003cb <_main+0x393>
  8003b7:	83 ec 04             	sub    $0x4,%esp
  8003ba:	68 ac 2f 80 00       	push   $0x802fac
  8003bf:	6a 40                	push   $0x40
  8003c1:	68 94 2f 80 00       	push   $0x802f94
  8003c6:	e8 24 10 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8003cb:	e8 dc 24 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8003d0:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003d3:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003d8:	74 14                	je     8003ee <_main+0x3b6>
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 18 30 80 00       	push   $0x803018
  8003e2:	6a 41                	push   $0x41
  8003e4:	68 94 2f 80 00       	push   $0x802f94
  8003e9:	e8 01 10 00 00       	call   8013ef <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003ee:	e8 36 24 00 00       	call   802829 <sys_calculate_free_frames>
  8003f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003f6:	e8 b1 24 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8003fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8003fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800401:	89 c2                	mov    %eax,%edx
  800403:	01 d2                	add    %edx,%edx
  800405:	01 d0                	add    %edx,%eax
  800407:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80040a:	83 ec 0c             	sub    $0xc,%esp
  80040d:	50                   	push   %eax
  80040e:	e8 54 20 00 00       	call   802467 <malloc>
  800413:	83 c4 10             	add    $0x10,%esp
  800416:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800419:	8b 45 90             	mov    -0x70(%ebp),%eax
  80041c:	89 c2                	mov    %eax,%edx
  80041e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800421:	c1 e0 03             	shl    $0x3,%eax
  800424:	05 00 00 00 80       	add    $0x80000000,%eax
  800429:	39 c2                	cmp    %eax,%edx
  80042b:	74 14                	je     800441 <_main+0x409>
  80042d:	83 ec 04             	sub    $0x4,%esp
  800430:	68 64 2f 80 00       	push   $0x802f64
  800435:	6a 47                	push   $0x47
  800437:	68 94 2f 80 00       	push   $0x802f94
  80043c:	e8 ae 0f 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800441:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800444:	e8 e0 23 00 00       	call   802829 <sys_calculate_free_frames>
  800449:	29 c3                	sub    %eax,%ebx
  80044b:	89 d8                	mov    %ebx,%eax
  80044d:	83 f8 01             	cmp    $0x1,%eax
  800450:	74 14                	je     800466 <_main+0x42e>
  800452:	83 ec 04             	sub    $0x4,%esp
  800455:	68 ac 2f 80 00       	push   $0x802fac
  80045a:	6a 49                	push   $0x49
  80045c:	68 94 2f 80 00       	push   $0x802f94
  800461:	e8 89 0f 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800466:	e8 41 24 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80046b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80046e:	3d 00 03 00 00       	cmp    $0x300,%eax
  800473:	74 14                	je     800489 <_main+0x451>
  800475:	83 ec 04             	sub    $0x4,%esp
  800478:	68 18 30 80 00       	push   $0x803018
  80047d:	6a 4a                	push   $0x4a
  80047f:	68 94 2f 80 00       	push   $0x802f94
  800484:	e8 66 0f 00 00       	call   8013ef <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800489:	e8 9b 23 00 00       	call   802829 <sys_calculate_free_frames>
  80048e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800491:	e8 16 24 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800496:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  800499:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80049c:	89 c2                	mov    %eax,%edx
  80049e:	01 d2                	add    %edx,%edx
  8004a0:	01 d0                	add    %edx,%eax
  8004a2:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8004a5:	83 ec 0c             	sub    $0xc,%esp
  8004a8:	50                   	push   %eax
  8004a9:	e8 b9 1f 00 00       	call   802467 <malloc>
  8004ae:	83 c4 10             	add    $0x10,%esp
  8004b1:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[7] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8004b4:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004b7:	89 c1                	mov    %eax,%ecx
  8004b9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004bc:	89 d0                	mov    %edx,%eax
  8004be:	c1 e0 02             	shl    $0x2,%eax
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	01 c0                	add    %eax,%eax
  8004c5:	01 d0                	add    %edx,%eax
  8004c7:	05 00 00 00 80       	add    $0x80000000,%eax
  8004cc:	39 c1                	cmp    %eax,%ecx
  8004ce:	74 14                	je     8004e4 <_main+0x4ac>
  8004d0:	83 ec 04             	sub    $0x4,%esp
  8004d3:	68 64 2f 80 00       	push   $0x802f64
  8004d8:	6a 50                	push   $0x50
  8004da:	68 94 2f 80 00       	push   $0x802f94
  8004df:	e8 0b 0f 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8004e4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8004e7:	e8 3d 23 00 00       	call   802829 <sys_calculate_free_frames>
  8004ec:	29 c3                	sub    %eax,%ebx
  8004ee:	89 d8                	mov    %ebx,%eax
  8004f0:	83 f8 01             	cmp    $0x1,%eax
  8004f3:	74 14                	je     800509 <_main+0x4d1>
  8004f5:	83 ec 04             	sub    $0x4,%esp
  8004f8:	68 ac 2f 80 00       	push   $0x802fac
  8004fd:	6a 52                	push   $0x52
  8004ff:	68 94 2f 80 00       	push   $0x802f94
  800504:	e8 e6 0e 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800509:	e8 9e 23 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80050e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800511:	3d 00 03 00 00       	cmp    $0x300,%eax
  800516:	74 14                	je     80052c <_main+0x4f4>
  800518:	83 ec 04             	sub    $0x4,%esp
  80051b:	68 18 30 80 00       	push   $0x803018
  800520:	6a 53                	push   $0x53
  800522:	68 94 2f 80 00       	push   $0x802f94
  800527:	e8 c3 0e 00 00       	call   8013ef <_panic>

		//Allocate the remaining space in user heap
		freeFrames = sys_calculate_free_frames() ;
  80052c:	e8 f8 22 00 00       	call   802829 <sys_calculate_free_frames>
  800531:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800534:	e8 73 23 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800539:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc((USER_HEAP_MAX - USER_HEAP_START) - 14 * Mega - kilo);
  80053c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80053f:	89 d0                	mov    %edx,%eax
  800541:	01 c0                	add    %eax,%eax
  800543:	01 d0                	add    %edx,%eax
  800545:	01 c0                	add    %eax,%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	01 c0                	add    %eax,%eax
  80054b:	f7 d8                	neg    %eax
  80054d:	89 c2                	mov    %eax,%edx
  80054f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800552:	29 c2                	sub    %eax,%edx
  800554:	89 d0                	mov    %edx,%eax
  800556:	05 00 00 00 20       	add    $0x20000000,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 03 1f 00 00       	call   802467 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  80056a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80056d:	89 c1                	mov    %eax,%ecx
  80056f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800572:	89 d0                	mov    %edx,%eax
  800574:	01 c0                	add    %eax,%eax
  800576:	01 d0                	add    %edx,%eax
  800578:	01 c0                	add    %eax,%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	01 c0                	add    %eax,%eax
  80057e:	05 00 00 00 80       	add    $0x80000000,%eax
  800583:	39 c1                	cmp    %eax,%ecx
  800585:	74 14                	je     80059b <_main+0x563>
  800587:	83 ec 04             	sub    $0x4,%esp
  80058a:	68 64 2f 80 00       	push   $0x802f64
  80058f:	6a 59                	push   $0x59
  800591:	68 94 2f 80 00       	push   $0x802f94
  800596:	e8 54 0e 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 124) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80059b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80059e:	e8 86 22 00 00       	call   802829 <sys_calculate_free_frames>
  8005a3:	29 c3                	sub    %eax,%ebx
  8005a5:	89 d8                	mov    %ebx,%eax
  8005a7:	83 f8 7c             	cmp    $0x7c,%eax
  8005aa:	74 14                	je     8005c0 <_main+0x588>
  8005ac:	83 ec 04             	sub    $0x4,%esp
  8005af:	68 ac 2f 80 00       	push   $0x802fac
  8005b4:	6a 5b                	push   $0x5b
  8005b6:	68 94 2f 80 00       	push   $0x802f94
  8005bb:	e8 2f 0e 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 127488) panic("Extra or less pages are allocated in PageFile");
  8005c0:	e8 e7 22 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8005c5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8005c8:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  8005cd:	74 14                	je     8005e3 <_main+0x5ab>
  8005cf:	83 ec 04             	sub    $0x4,%esp
  8005d2:	68 18 30 80 00       	push   $0x803018
  8005d7:	6a 5c                	push   $0x5c
  8005d9:	68 94 2f 80 00       	push   $0x802f94
  8005de:	e8 0c 0e 00 00       	call   8013ef <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005e3:	e8 41 22 00 00       	call   802829 <sys_calculate_free_frames>
  8005e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005eb:	e8 bc 22 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8005f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[1]);
  8005f3:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005f9:	83 ec 0c             	sub    $0xc,%esp
  8005fc:	50                   	push   %eax
  8005fd:	e8 86 1f 00 00       	call   802588 <free>
  800602:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  800605:	e8 a2 22 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80060a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80060d:	29 c2                	sub    %eax,%edx
  80060f:	89 d0                	mov    %edx,%eax
  800611:	3d 00 01 00 00       	cmp    $0x100,%eax
  800616:	74 14                	je     80062c <_main+0x5f4>
  800618:	83 ec 04             	sub    $0x4,%esp
  80061b:	68 48 30 80 00       	push   $0x803048
  800620:	6a 67                	push   $0x67
  800622:	68 94 2f 80 00       	push   $0x802f94
  800627:	e8 c3 0d 00 00       	call   8013ef <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80062c:	e8 f8 21 00 00       	call   802829 <sys_calculate_free_frames>
  800631:	89 c2                	mov    %eax,%edx
  800633:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800636:	39 c2                	cmp    %eax,%edx
  800638:	74 14                	je     80064e <_main+0x616>
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	68 84 30 80 00       	push   $0x803084
  800642:	6a 68                	push   $0x68
  800644:	68 94 2f 80 00       	push   $0x802f94
  800649:	e8 a1 0d 00 00       	call   8013ef <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80064e:	e8 d6 21 00 00       	call   802829 <sys_calculate_free_frames>
  800653:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800656:	e8 51 22 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80065b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[4]);
  80065e:	8b 45 88             	mov    -0x78(%ebp),%eax
  800661:	83 ec 0c             	sub    $0xc,%esp
  800664:	50                   	push   %eax
  800665:	e8 1e 1f 00 00       	call   802588 <free>
  80066a:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  80066d:	e8 3a 22 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800672:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800675:	29 c2                	sub    %eax,%edx
  800677:	89 d0                	mov    %edx,%eax
  800679:	3d 00 02 00 00       	cmp    $0x200,%eax
  80067e:	74 14                	je     800694 <_main+0x65c>
  800680:	83 ec 04             	sub    $0x4,%esp
  800683:	68 48 30 80 00       	push   $0x803048
  800688:	6a 6f                	push   $0x6f
  80068a:	68 94 2f 80 00       	push   $0x802f94
  80068f:	e8 5b 0d 00 00       	call   8013ef <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800694:	e8 90 21 00 00       	call   802829 <sys_calculate_free_frames>
  800699:	89 c2                	mov    %eax,%edx
  80069b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80069e:	39 c2                	cmp    %eax,%edx
  8006a0:	74 14                	je     8006b6 <_main+0x67e>
  8006a2:	83 ec 04             	sub    $0x4,%esp
  8006a5:	68 84 30 80 00       	push   $0x803084
  8006aa:	6a 70                	push   $0x70
  8006ac:	68 94 2f 80 00       	push   $0x802f94
  8006b1:	e8 39 0d 00 00       	call   8013ef <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8006b6:	e8 6e 21 00 00       	call   802829 <sys_calculate_free_frames>
  8006bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006be:	e8 e9 21 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8006c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  8006c6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8006c9:	83 ec 0c             	sub    $0xc,%esp
  8006cc:	50                   	push   %eax
  8006cd:	e8 b6 1e 00 00       	call   802588 <free>
  8006d2:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 768) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006d5:	e8 d2 21 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8006da:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8006dd:	29 c2                	sub    %eax,%edx
  8006df:	89 d0                	mov    %edx,%eax
  8006e1:	3d 00 03 00 00       	cmp    $0x300,%eax
  8006e6:	74 14                	je     8006fc <_main+0x6c4>
  8006e8:	83 ec 04             	sub    $0x4,%esp
  8006eb:	68 48 30 80 00       	push   $0x803048
  8006f0:	6a 77                	push   $0x77
  8006f2:	68 94 2f 80 00       	push   $0x802f94
  8006f7:	e8 f3 0c 00 00       	call   8013ef <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8006fc:	e8 28 21 00 00       	call   802829 <sys_calculate_free_frames>
  800701:	89 c2                	mov    %eax,%edx
  800703:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800706:	39 c2                	cmp    %eax,%edx
  800708:	74 14                	je     80071e <_main+0x6e6>
  80070a:	83 ec 04             	sub    $0x4,%esp
  80070d:	68 84 30 80 00       	push   $0x803084
  800712:	6a 78                	push   $0x78
  800714:	68 94 2f 80 00       	push   $0x802f94
  800719:	e8 d1 0c 00 00       	call   8013ef <_panic>
//		free(ptr_allocations[8]);
//		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
//		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 127488) panic("Wrong free: Extra or less pages are removed from PageFile");
//		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
	}
	int cnt = 0;
  80071e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
	//and continue executing the remaining code
	sys_bypassPageFault(3);
  800725:	83 ec 0c             	sub    $0xc,%esp
  800728:	6a 03                	push   $0x3
  80072a:	e8 10 24 00 00       	call   802b3f <sys_bypassPageFault>
  80072f:	83 c4 10             	add    $0x10,%esp

	//[3] Test Re-allocation
	{
		/*CASE1: Re-allocate with size = 0*/

		char *byteArr = (char *) ptr_allocations[0];
  800732:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800738:	89 45 d8             	mov    %eax,-0x28(%ebp)

		//Reallocate with size = 0 [delete it]
		freeFrames = sys_calculate_free_frames() ;
  80073b:	e8 e9 20 00 00       	call   802829 <sys_calculate_free_frames>
  800740:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800743:	e8 64 21 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800748:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 0);
  80074b:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800751:	83 ec 08             	sub    $0x8,%esp
  800754:	6a 00                	push   $0x0
  800756:	50                   	push   %eax
  800757:	e8 44 1f 00 00       	call   8026a0 <realloc>
  80075c:	83 c4 10             	add    $0x10,%esp
  80075f:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != 0) panic("Wrong start address for the re-allocated space...it should return NULL!");
  800765:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  80076b:	85 c0                	test   %eax,%eax
  80076d:	74 17                	je     800786 <_main+0x74e>
  80076f:	83 ec 04             	sub    $0x4,%esp
  800772:	68 d0 30 80 00       	push   $0x8030d0
  800777:	68 94 00 00 00       	push   $0x94
  80077c:	68 94 2f 80 00       	push   $0x802f94
  800781:	e8 69 0c 00 00       	call   8013ef <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  800786:	e8 9e 20 00 00       	call   802829 <sys_calculate_free_frames>
  80078b:	89 c2                	mov    %eax,%edx
  80078d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800790:	39 c2                	cmp    %eax,%edx
  800792:	74 17                	je     8007ab <_main+0x773>
  800794:	83 ec 04             	sub    $0x4,%esp
  800797:	68 18 31 80 00       	push   $0x803118
  80079c:	68 96 00 00 00       	push   $0x96
  8007a1:	68 94 2f 80 00       	push   $0x802f94
  8007a6:	e8 44 0c 00 00       	call   8013ef <_panic>
		if((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Extra or less pages are re-allocated in PageFile");
  8007ab:	e8 fc 20 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8007b0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8007b3:	29 c2                	sub    %eax,%edx
  8007b5:	89 d0                	mov    %edx,%eax
  8007b7:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007bc:	74 17                	je     8007d5 <_main+0x79d>
  8007be:	83 ec 04             	sub    $0x4,%esp
  8007c1:	68 88 31 80 00       	push   $0x803188
  8007c6:	68 97 00 00 00       	push   $0x97
  8007cb:	68 94 2f 80 00       	push   $0x802f94
  8007d0:	e8 1a 0c 00 00       	call   8013ef <_panic>

		//[2] test memory access
		byteArr[0] = 10;
  8007d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007d8:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[0])) panic("successful access to re-allocated space with size 0!! it should not be succeeded");
  8007db:	e8 46 23 00 00       	call   802b26 <sys_rcr2>
  8007e0:	89 c2                	mov    %eax,%edx
  8007e2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007e5:	39 c2                	cmp    %eax,%edx
  8007e7:	74 17                	je     800800 <_main+0x7c8>
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	68 bc 31 80 00       	push   $0x8031bc
  8007f1:	68 9b 00 00 00       	push   $0x9b
  8007f6:	68 94 2f 80 00       	push   $0x802f94
  8007fb:	e8 ef 0b 00 00       	call   8013ef <_panic>
		byteArr[(1*Mega-kilo)/sizeof(char) - 1] = 10;
  800800:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800803:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800806:	8d 50 ff             	lea    -0x1(%eax),%edx
  800809:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80080c:	01 d0                	add    %edx,%eax
  80080e:	c6 00 0a             	movb   $0xa,(%eax)
		if (sys_rcr2() != (uint32)&(byteArr[(1*Mega-kilo)/sizeof(char) - 1])) panic("successful access to reallocated space of size 0!! it should not be succeeded");
  800811:	e8 10 23 00 00       	call   802b26 <sys_rcr2>
  800816:	89 c2                	mov    %eax,%edx
  800818:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80081e:	8d 48 ff             	lea    -0x1(%eax),%ecx
  800821:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800824:	01 c8                	add    %ecx,%eax
  800826:	39 c2                	cmp    %eax,%edx
  800828:	74 17                	je     800841 <_main+0x809>
  80082a:	83 ec 04             	sub    $0x4,%esp
  80082d:	68 10 32 80 00       	push   $0x803210
  800832:	68 9d 00 00 00       	push   $0x9d
  800837:	68 94 2f 80 00       	push   $0x802f94
  80083c:	e8 ae 0b 00 00       	call   8013ef <_panic>

		//set it to 0 again to cancel the bypassing option
		sys_bypassPageFault(0);
  800841:	83 ec 0c             	sub    $0xc,%esp
  800844:	6a 00                	push   $0x0
  800846:	e8 f4 22 00 00       	call   802b3f <sys_bypassPageFault>
  80084b:	83 c4 10             	add    $0x10,%esp

		vcprintf("\b\b\b20%", NULL);
  80084e:	83 ec 08             	sub    $0x8,%esp
  800851:	6a 00                	push   $0x0
  800853:	68 5e 32 80 00       	push   $0x80325e
  800858:	e8 db 0d 00 00       	call   801638 <vcprintf>
  80085d:	83 c4 10             	add    $0x10,%esp

		/*CASE2: Re-allocate with address = NULL*/

		//new allocation with size = 2.5 MB, should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800860:	e8 c4 1f 00 00       	call   802829 <sys_calculate_free_frames>
  800865:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800868:	e8 3f 20 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80086d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = realloc(NULL, 2*Mega + 510*kilo);
  800870:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800873:	89 d0                	mov    %edx,%eax
  800875:	c1 e0 08             	shl    $0x8,%eax
  800878:	29 d0                	sub    %edx,%eax
  80087a:	89 c2                	mov    %eax,%edx
  80087c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80087f:	01 d0                	add    %edx,%eax
  800881:	01 c0                	add    %eax,%eax
  800883:	83 ec 08             	sub    $0x8,%esp
  800886:	50                   	push   %eax
  800887:	6a 00                	push   $0x0
  800889:	e8 12 1e 00 00       	call   8026a0 <realloc>
  80088e:	83 c4 10             	add    $0x10,%esp
  800891:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800894:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800897:	89 c2                	mov    %eax,%edx
  800899:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80089c:	c1 e0 03             	shl    $0x3,%eax
  80089f:	05 00 00 00 80       	add    $0x80000000,%eax
  8008a4:	39 c2                	cmp    %eax,%edx
  8008a6:	74 17                	je     8008bf <_main+0x887>
  8008a8:	83 ec 04             	sub    $0x4,%esp
  8008ab:	68 64 2f 80 00       	push   $0x802f64
  8008b0:	68 aa 00 00 00       	push   $0xaa
  8008b5:	68 94 2f 80 00       	push   $0x802f94
  8008ba:	e8 30 0b 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 640) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  8008bf:	e8 65 1f 00 00       	call   802829 <sys_calculate_free_frames>
  8008c4:	89 c2                	mov    %eax,%edx
  8008c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c9:	39 c2                	cmp    %eax,%edx
  8008cb:	74 17                	je     8008e4 <_main+0x8ac>
  8008cd:	83 ec 04             	sub    $0x4,%esp
  8008d0:	68 18 31 80 00       	push   $0x803118
  8008d5:	68 ac 00 00 00       	push   $0xac
  8008da:	68 94 2f 80 00       	push   $0x802f94
  8008df:	e8 0b 0b 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 640) panic("Extra or less pages are re-allocated in PageFile");
  8008e4:	e8 c3 1f 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8008e9:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008ec:	3d 80 02 00 00       	cmp    $0x280,%eax
  8008f1:	74 17                	je     80090a <_main+0x8d2>
  8008f3:	83 ec 04             	sub    $0x4,%esp
  8008f6:	68 88 31 80 00       	push   $0x803188
  8008fb:	68 ad 00 00 00       	push   $0xad
  800900:	68 94 2f 80 00       	push   $0x802f94
  800905:	e8 e5 0a 00 00       	call   8013ef <_panic>

		//Fill it with data
		int *intArr = (int*) ptr_allocations[10];
  80090a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80090d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfInt1 = (2*Mega + 510*kilo)/sizeof(int) - 1;
  800910:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800913:	89 d0                	mov    %edx,%eax
  800915:	c1 e0 08             	shl    $0x8,%eax
  800918:	29 d0                	sub    %edx,%eax
  80091a:	89 c2                	mov    %eax,%edx
  80091c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80091f:	01 d0                	add    %edx,%eax
  800921:	01 c0                	add    %eax,%eax
  800923:	c1 e8 02             	shr    $0x2,%eax
  800926:	48                   	dec    %eax
  800927:	89 45 d0             	mov    %eax,-0x30(%ebp)

		int i = 0;
  80092a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
//		{
//			intArr[i] = i ;
//		}

		//fill the first 100 elements
		for(i = 0; i < 100; i++)
  800931:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800938:	eb 17                	jmp    800951 <_main+0x919>
		{
			intArr[i] = i;
  80093a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80093d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800944:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800947:	01 c2                	add    %eax,%edx
  800949:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094c:	89 02                	mov    %eax,(%edx)
//		{
//			intArr[i] = i ;
//		}

		//fill the first 100 elements
		for(i = 0; i < 100; i++)
  80094e:	ff 45 f0             	incl   -0x10(%ebp)
  800951:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800955:	7e e3                	jle    80093a <_main+0x902>
			intArr[i] = i;
		}


		//fill the last 100 element
		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  800957:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80095a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80095d:	eb 17                	jmp    800976 <_main+0x93e>
		{
			intArr[i] = i;
  80095f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800962:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800969:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80096c:	01 c2                	add    %eax,%edx
  80096e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800971:	89 02                	mov    %eax,(%edx)
			intArr[i] = i;
		}


		//fill the last 100 element
		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  800973:	ff 4d f0             	decl   -0x10(%ebp)
  800976:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800979:	83 e8 63             	sub    $0x63,%eax
  80097c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80097f:	7e de                	jle    80095f <_main+0x927>
		{
			intArr[i] = i;
		}

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  800981:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800988:	eb 33                	jmp    8009bd <_main+0x985>
		{
			cnt++;
  80098a:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80098d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800990:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800997:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80099a:	01 d0                	add    %edx,%eax
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009a1:	74 17                	je     8009ba <_main+0x982>
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	68 68 32 80 00       	push   $0x803268
  8009ab:	68 ca 00 00 00       	push   $0xca
  8009b0:	68 94 2f 80 00       	push   $0x802f94
  8009b5:	e8 35 0a 00 00       	call   8013ef <_panic>
		{
			intArr[i] = i;
		}

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  8009ba:	ff 45 f0             	incl   -0x10(%ebp)
  8009bd:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  8009c1:	7e c7                	jle    80098a <_main+0x952>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  8009c3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8009c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009c9:	eb 33                	jmp    8009fe <_main+0x9c6>
		{
			cnt++;
  8009cb:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8009db:	01 d0                	add    %edx,%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009e2:	74 17                	je     8009fb <_main+0x9c3>
  8009e4:	83 ec 04             	sub    $0x4,%esp
  8009e7:	68 68 32 80 00       	push   $0x803268
  8009ec:	68 d0 00 00 00       	push   $0xd0
  8009f1:	68 94 2f 80 00       	push   $0x802f94
  8009f6:	e8 f4 09 00 00       	call   8013ef <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i >= lastIndexOfInt1 - 99; i--)
  8009fb:	ff 4d f0             	decl   -0x10(%ebp)
  8009fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a01:	83 e8 63             	sub    $0x63,%eax
  800a04:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a07:	7e c2                	jle    8009cb <_main+0x993>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		vcprintf("\b\b\b40%", NULL);
  800a09:	83 ec 08             	sub    $0x8,%esp
  800a0c:	6a 00                	push   $0x0
  800a0e:	68 a0 32 80 00       	push   $0x8032a0
  800a13:	e8 20 0c 00 00       	call   801638 <vcprintf>
  800a18:	83 c4 10             	add    $0x10,%esp

		/*CASE3: Re-allocate in the existing internal fragment (no additional pages are required)*/

		//Reallocate last allocation with 1 extra KB [should be placed in the existing 2 KB internal fragment]
		freeFrames = sys_calculate_free_frames() ;
  800a1b:	e8 09 1e 00 00       	call   802829 <sys_calculate_free_frames>
  800a20:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800a23:	e8 84 1e 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800a28:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = realloc(ptr_allocations[10], 2*Mega + 510*kilo + kilo);
  800a2b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800a2e:	89 d0                	mov    %edx,%eax
  800a30:	c1 e0 08             	shl    $0x8,%eax
  800a33:	29 d0                	sub    %edx,%eax
  800a35:	89 c2                	mov    %eax,%edx
  800a37:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3a:	01 d0                	add    %edx,%eax
  800a3c:	01 c0                	add    %eax,%eax
  800a3e:	89 c2                	mov    %eax,%edx
  800a40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a43:	01 d0                	add    %edx,%eax
  800a45:	89 c2                	mov    %eax,%edx
  800a47:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	52                   	push   %edx
  800a4e:	50                   	push   %eax
  800a4f:	e8 4c 1c 00 00       	call   8026a0 <realloc>
  800a54:	83 c4 10             	add    $0x10,%esp
  800a57:	89 45 a0             	mov    %eax,-0x60(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the re-allocated space... ");
  800a5a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800a5d:	89 c2                	mov    %eax,%edx
  800a5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a62:	c1 e0 03             	shl    $0x3,%eax
  800a65:	05 00 00 00 80       	add    $0x80000000,%eax
  800a6a:	39 c2                	cmp    %eax,%edx
  800a6c:	74 17                	je     800a85 <_main+0xa4d>
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	68 a8 32 80 00       	push   $0x8032a8
  800a76:	68 dc 00 00 00       	push   $0xdc
  800a7b:	68 94 2f 80 00       	push   $0x802f94
  800a80:	e8 6a 09 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation");

		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  800a85:	e8 9f 1d 00 00       	call   802829 <sys_calculate_free_frames>
  800a8a:	89 c2                	mov    %eax,%edx
  800a8c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8f:	39 c2                	cmp    %eax,%edx
  800a91:	74 17                	je     800aaa <_main+0xa72>
  800a93:	83 ec 04             	sub    $0x4,%esp
  800a96:	68 18 31 80 00       	push   $0x803118
  800a9b:	68 df 00 00 00       	push   $0xdf
  800aa0:	68 94 2f 80 00       	push   $0x802f94
  800aa5:	e8 45 09 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");
  800aaa:	e8 fd 1d 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800aaf:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800ab2:	74 17                	je     800acb <_main+0xa93>
  800ab4:	83 ec 04             	sub    $0x4,%esp
  800ab7:	68 88 31 80 00       	push   $0x803188
  800abc:	68 e0 00 00 00       	push   $0xe0
  800ac1:	68 94 2f 80 00       	push   $0x802f94
  800ac6:	e8 24 09 00 00       	call   8013ef <_panic>

		//[2] test memory access
		int lastIndexOfInt2 = (2*Mega + 510*kilo + kilo)/sizeof(int) - 1;
  800acb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ace:	89 d0                	mov    %edx,%eax
  800ad0:	c1 e0 08             	shl    $0x8,%eax
  800ad3:	29 d0                	sub    %edx,%eax
  800ad5:	89 c2                	mov    %eax,%edx
  800ad7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ada:	01 d0                	add    %edx,%eax
  800adc:	01 c0                	add    %eax,%eax
  800ade:	89 c2                	mov    %eax,%edx
  800ae0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ae3:	01 d0                	add    %edx,%eax
  800ae5:	c1 e8 02             	shr    $0x2,%eax
  800ae8:	48                   	dec    %eax
  800ae9:	89 45 cc             	mov    %eax,-0x34(%ebp)

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800aec:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800aef:	40                   	inc    %eax
  800af0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af3:	eb 17                	jmp    800b0c <_main+0xad4>
		{
			intArr[i] = i ;
  800af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800aff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b02:	01 c2                	add    %eax,%edx
  800b04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b07:	89 02                	mov    %eax,(%edx)
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");

		//[2] test memory access
		int lastIndexOfInt2 = (2*Mega + 510*kilo + kilo)/sizeof(int) - 1;

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800b09:	ff 45 f0             	incl   -0x10(%ebp)
  800b0c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b0f:	83 c0 65             	add    $0x65,%eax
  800b12:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b15:	7f de                	jg     800af5 <_main+0xabd>
		{
			intArr[i] = i ;
		}


		for (i=lastIndexOfInt2 ; i >= lastIndexOfInt2 - 99 ; i--)
  800b17:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1d:	eb 17                	jmp    800b36 <_main+0xafe>
		{
			intArr[i] = i ;
  800b1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b29:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b2c:	01 c2                	add    %eax,%edx
  800b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b31:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}


		for (i=lastIndexOfInt2 ; i >= lastIndexOfInt2 - 99 ; i--)
  800b33:	ff 4d f0             	decl   -0x10(%ebp)
  800b36:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800b39:	83 e8 63             	sub    $0x63,%eax
  800b3c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b3f:	7e de                	jle    800b1f <_main+0xae7>
		{
			intArr[i] = i ;
		}


		for (i=0; i < 100 ; i++)
  800b41:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800b48:	eb 33                	jmp    800b7d <_main+0xb45>
		{
			cnt++;
  800b4a:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800b4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b50:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b57:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b5a:	01 d0                	add    %edx,%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b61:	74 17                	je     800b7a <_main+0xb42>
  800b63:	83 ec 04             	sub    $0x4,%esp
  800b66:	68 68 32 80 00       	push   $0x803268
  800b6b:	68 f4 00 00 00       	push   $0xf4
  800b70:	68 94 2f 80 00       	push   $0x802f94
  800b75:	e8 75 08 00 00       	call   8013ef <_panic>
		{
			intArr[i] = i ;
		}


		for (i=0; i < 100 ; i++)
  800b7a:	ff 45 f0             	incl   -0x10(%ebp)
  800b7d:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800b81:	7e c7                	jle    800b4a <_main+0xb12>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 - 1; i >= lastIndexOfInt1 - 99 ; i--)
  800b83:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b86:	48                   	dec    %eax
  800b87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b8a:	eb 33                	jmp    800bbf <_main+0xb87>
		{
			cnt++;
  800b8c:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800b99:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b9c:	01 d0                	add    %edx,%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ba3:	74 17                	je     800bbc <_main+0xb84>
  800ba5:	83 ec 04             	sub    $0x4,%esp
  800ba8:	68 68 32 80 00       	push   $0x803268
  800bad:	68 f9 00 00 00       	push   $0xf9
  800bb2:	68 94 2f 80 00       	push   $0x802f94
  800bb7:	e8 33 08 00 00       	call   8013ef <_panic>
		for (i=0; i < 100 ; i++)
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 - 1; i >= lastIndexOfInt1 - 99 ; i--)
  800bbc:	ff 4d f0             	decl   -0x10(%ebp)
  800bbf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800bc2:	83 e8 63             	sub    $0x63,%eax
  800bc5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bc8:	7e c2                	jle    800b8c <_main+0xb54>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800bca:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800bcd:	40                   	inc    %eax
  800bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd1:	eb 33                	jmp    800c06 <_main+0xbce>
		{
			cnt++;
  800bd3:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bd9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800be0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800be3:	01 d0                	add    %edx,%eax
  800be5:	8b 00                	mov    (%eax),%eax
  800be7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bea:	74 17                	je     800c03 <_main+0xbcb>
  800bec:	83 ec 04             	sub    $0x4,%esp
  800bef:	68 68 32 80 00       	push   $0x803268
  800bf4:	68 fe 00 00 00       	push   $0xfe
  800bf9:	68 94 2f 80 00       	push   $0x802f94
  800bfe:	e8 ec 07 00 00       	call   8013ef <_panic>
		for (i=lastIndexOfInt1 - 1; i >= lastIndexOfInt1 - 99 ; i--)
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  800c03:	ff 45 f0             	incl   -0x10(%ebp)
  800c06:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800c09:	83 c0 65             	add    $0x65,%eax
  800c0c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c0f:	7f c2                	jg     800bd3 <_main+0xb9b>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt2; i >= lastIndexOfInt2 - 99 ; i--)
  800c11:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800c14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c17:	eb 33                	jmp    800c4c <_main+0xc14>
		{
			cnt++;
  800c19:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800c1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c1f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c26:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c29:	01 d0                	add    %edx,%eax
  800c2b:	8b 00                	mov    (%eax),%eax
  800c2d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c30:	74 17                	je     800c49 <_main+0xc11>
  800c32:	83 ec 04             	sub    $0x4,%esp
  800c35:	68 68 32 80 00       	push   $0x803268
  800c3a:	68 03 01 00 00       	push   $0x103
  800c3f:	68 94 2f 80 00       	push   $0x802f94
  800c44:	e8 a6 07 00 00       	call   8013ef <_panic>
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}
		for (i=lastIndexOfInt2; i >= lastIndexOfInt2 - 99 ; i--)
  800c49:	ff 4d f0             	decl   -0x10(%ebp)
  800c4c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800c4f:	83 e8 63             	sub    $0x63,%eax
  800c52:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c55:	7e c2                	jle    800c19 <_main+0xbe1>
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}


		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800c57:	e8 cd 1b 00 00       	call   802829 <sys_calculate_free_frames>
  800c5c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c5f:	e8 48 1c 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800c64:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[10]);
  800c67:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800c6a:	83 ec 0c             	sub    $0xc,%esp
  800c6d:	50                   	push   %eax
  800c6e:	e8 15 19 00 00       	call   802588 <free>
  800c73:	83 c4 10             	add    $0x10,%esp

		//if ((sys_calculate_free_frames() - freeFrames) != 640) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 640) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800c76:	e8 31 1c 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800c7b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c7e:	29 c2                	sub    %eax,%edx
  800c80:	89 d0                	mov    %edx,%eax
  800c82:	3d 80 02 00 00       	cmp    $0x280,%eax
  800c87:	74 17                	je     800ca0 <_main+0xc68>
  800c89:	83 ec 04             	sub    $0x4,%esp
  800c8c:	68 dc 32 80 00       	push   $0x8032dc
  800c91:	68 0d 01 00 00       	push   $0x10d
  800c96:	68 94 2f 80 00       	push   $0x802f94
  800c9b:	e8 4f 07 00 00       	call   8013ef <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");
  800ca0:	e8 84 1b 00 00       	call   802829 <sys_calculate_free_frames>
  800ca5:	89 c2                	mov    %eax,%edx
  800ca7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800caa:	29 c2                	sub    %eax,%edx
  800cac:	89 d0                	mov    %edx,%eax
  800cae:	83 f8 03             	cmp    $0x3,%eax
  800cb1:	74 17                	je     800cca <_main+0xc92>
  800cb3:	83 ec 04             	sub    $0x4,%esp
  800cb6:	68 30 33 80 00       	push   $0x803330
  800cbb:	68 0e 01 00 00       	push   $0x10e
  800cc0:	68 94 2f 80 00       	push   $0x802f94
  800cc5:	e8 25 07 00 00       	call   8013ef <_panic>

		vcprintf("\b\b\b60%", NULL);
  800cca:	83 ec 08             	sub    $0x8,%esp
  800ccd:	6a 00                	push   $0x0
  800ccf:	68 94 33 80 00       	push   $0x803394
  800cd4:	e8 5f 09 00 00       	call   801638 <vcprintf>
  800cd9:	83 c4 10             	add    $0x10,%esp

		/*CASE4: Re-allocate that can NOT fit in any free fragment*/

		//Fill 3rd allocation with data
		intArr = (int*) ptr_allocations[2];
  800cdc:	8b 45 80             	mov    -0x80(%ebp),%eax
  800cdf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;
  800ce2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ce5:	c1 e8 02             	shr    $0x2,%eax
  800ce8:	48                   	dec    %eax
  800ce9:	89 45 d0             	mov    %eax,-0x30(%ebp)

		i = 0;
  800cec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		//filling the first 100 element
		for (i=0; i < 100 ; i++)
  800cf3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800cfa:	eb 17                	jmp    800d13 <_main+0xcdb>
		{
			intArr[i] = i ;
  800cfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d06:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d09:	01 c2                	add    %eax,%edx
  800d0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d0e:	89 02                	mov    %eax,(%edx)
		intArr = (int*) ptr_allocations[2];
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;

		i = 0;
		//filling the first 100 element
		for (i=0; i < 100 ; i++)
  800d10:	ff 45 f0             	incl   -0x10(%ebp)
  800d13:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800d17:	7e e3                	jle    800cfc <_main+0xcc4>
		{
			intArr[i] = i ;
		}

		//filling the last 100 element
		for(int i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d19:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d1f:	eb 17                	jmp    800d38 <_main+0xd00>
		{
			intArr[i] = i;
  800d21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d24:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d2b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d2e:	01 c2                	add    %eax,%edx
  800d30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d33:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 element
		for(int i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d35:	ff 4d ec             	decl   -0x14(%ebp)
  800d38:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d3b:	83 e8 64             	sub    $0x64,%eax
  800d3e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800d41:	7c de                	jl     800d21 <_main+0xce9>
		{
			intArr[i] = i;
		}

		//Reallocate it to large size that can't be fit in any free segment
		freeFrames = sys_calculate_free_frames() ;
  800d43:	e8 e1 1a 00 00       	call   802829 <sys_calculate_free_frames>
  800d48:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d4b:	e8 5c 1b 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800d50:	89 45 dc             	mov    %eax,-0x24(%ebp)
		void* origAddress = ptr_allocations[2];
  800d53:	8b 45 80             	mov    -0x80(%ebp),%eax
  800d56:	89 45 c8             	mov    %eax,-0x38(%ebp)
		ptr_allocations[2] = realloc(ptr_allocations[2], (USER_HEAP_MAX - USER_HEAP_START - 13*Mega));
  800d59:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d5c:	89 d0                	mov    %edx,%eax
  800d5e:	01 c0                	add    %eax,%eax
  800d60:	01 d0                	add    %edx,%eax
  800d62:	c1 e0 02             	shl    $0x2,%eax
  800d65:	01 d0                	add    %edx,%eax
  800d67:	f7 d8                	neg    %eax
  800d69:	8d 90 00 00 00 20    	lea    0x20000000(%eax),%edx
  800d6f:	8b 45 80             	mov    -0x80(%ebp),%eax
  800d72:	83 ec 08             	sub    $0x8,%esp
  800d75:	52                   	push   %edx
  800d76:	50                   	push   %eax
  800d77:	e8 24 19 00 00       	call   8026a0 <realloc>
  800d7c:	83 c4 10             	add    $0x10,%esp
  800d7f:	89 45 80             	mov    %eax,-0x80(%ebp)

		//cprintf("%x\n", ptr_allocations[2]);
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[2] != 0) panic("Wrong start address for the re-allocated space... ");
  800d82:	8b 45 80             	mov    -0x80(%ebp),%eax
  800d85:	85 c0                	test   %eax,%eax
  800d87:	74 17                	je     800da0 <_main+0xd68>
  800d89:	83 ec 04             	sub    $0x4,%esp
  800d8c:	68 a8 32 80 00       	push   $0x8032a8
  800d91:	68 2d 01 00 00       	push   $0x12d
  800d96:	68 94 2f 80 00       	push   $0x802f94
  800d9b:	e8 4f 06 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  800da0:	e8 84 1a 00 00       	call   802829 <sys_calculate_free_frames>
  800da5:	89 c2                	mov    %eax,%edx
  800da7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800daa:	39 c2                	cmp    %eax,%edx
  800dac:	74 17                	je     800dc5 <_main+0xd8d>
  800dae:	83 ec 04             	sub    $0x4,%esp
  800db1:	68 18 31 80 00       	push   $0x803118
  800db6:	68 2f 01 00 00       	push   $0x12f
  800dbb:	68 94 2f 80 00       	push   $0x802f94
  800dc0:	e8 2a 06 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");
  800dc5:	e8 e2 1a 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800dca:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800dcd:	74 17                	je     800de6 <_main+0xdae>
  800dcf:	83 ec 04             	sub    $0x4,%esp
  800dd2:	68 88 31 80 00       	push   $0x803188
  800dd7:	68 30 01 00 00       	push   $0x130
  800ddc:	68 94 2f 80 00       	push   $0x802f94
  800de1:	e8 09 06 00 00       	call   8013ef <_panic>

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  800de6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ded:	eb 33                	jmp    800e22 <_main+0xdea>
		{
			cnt++;
  800def:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800dfc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dff:	01 d0                	add    %edx,%eax
  800e01:	8b 00                	mov    (%eax),%eax
  800e03:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e06:	74 17                	je     800e1f <_main+0xde7>
  800e08:	83 ec 04             	sub    $0x4,%esp
  800e0b:	68 68 32 80 00       	push   $0x803268
  800e10:	68 36 01 00 00       	push   $0x136
  800e15:	68 94 2f 80 00       	push   $0x802f94
  800e1a:	e8 d0 05 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0) panic("Extra or less pages are re-allocated in PageFile");

		//[2] test memory access
		for (i=0; i < 100 ; i++)
  800e1f:	ff 45 f0             	incl   -0x10(%ebp)
  800e22:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  800e26:	7e c7                	jle    800def <_main+0xdb7>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800e28:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2e:	eb 33                	jmp    800e63 <_main+0xe2b>
		{
			cnt++;
  800e30:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800e3d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e40:	01 d0                	add    %edx,%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e47:	74 17                	je     800e60 <_main+0xe28>
  800e49:	83 ec 04             	sub    $0x4,%esp
  800e4c:	68 68 32 80 00       	push   $0x803268
  800e51:	68 3c 01 00 00       	push   $0x13c
  800e56:	68 94 2f 80 00       	push   $0x802f94
  800e5b:	e8 8f 05 00 00       	call   8013ef <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800e60:	ff 4d f0             	decl   -0x10(%ebp)
  800e63:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e66:	83 e8 64             	sub    $0x64,%eax
  800e69:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e6c:	7c c2                	jl     800e30 <_main+0xdf8>
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after FAILURE expansion
		freeFrames = sys_calculate_free_frames() ;
  800e6e:	e8 b6 19 00 00       	call   802829 <sys_calculate_free_frames>
  800e73:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e76:	e8 31 1a 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800e7b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(origAddress);
  800e7e:	83 ec 0c             	sub    $0xc,%esp
  800e81:	ff 75 c8             	pushl  -0x38(%ebp)
  800e84:	e8 ff 16 00 00       	call   802588 <free>
  800e89:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800e8c:	e8 1b 1a 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800e91:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800e94:	29 c2                	sub    %eax,%edx
  800e96:	89 d0                	mov    %edx,%eax
  800e98:	3d 00 01 00 00       	cmp    $0x100,%eax
  800e9d:	74 17                	je     800eb6 <_main+0xe7e>
  800e9f:	83 ec 04             	sub    $0x4,%esp
  800ea2:	68 dc 32 80 00       	push   $0x8032dc
  800ea7:	68 44 01 00 00       	push   $0x144
  800eac:	68 94 2f 80 00       	push   $0x802f94
  800eb1:	e8 39 05 00 00       	call   8013ef <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");
  800eb6:	e8 6e 19 00 00       	call   802829 <sys_calculate_free_frames>
  800ebb:	89 c2                	mov    %eax,%edx
  800ebd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ec0:	29 c2                	sub    %eax,%edx
  800ec2:	89 d0                	mov    %edx,%eax
  800ec4:	83 f8 03             	cmp    $0x3,%eax
  800ec7:	74 17                	je     800ee0 <_main+0xea8>
  800ec9:	83 ec 04             	sub    $0x4,%esp
  800ecc:	68 30 33 80 00       	push   $0x803330
  800ed1:	68 45 01 00 00       	push   $0x145
  800ed6:	68 94 2f 80 00       	push   $0x802f94
  800edb:	e8 0f 05 00 00       	call   8013ef <_panic>

		vcprintf("\b\b\b80%", NULL);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	6a 00                	push   $0x0
  800ee5:	68 9b 33 80 00       	push   $0x80339b
  800eea:	e8 49 07 00 00       	call   801638 <vcprintf>
  800eef:	83 c4 10             	add    $0x10,%esp
		/*CASE5: Re-allocate that test FIRST FIT strategy*/

		//[1] create 4 MB hole at beginning of the heap

		//Take 2 MB from currently 3 MB hole at beginning of the heap
		freeFrames = sys_calculate_free_frames() ;
  800ef2:	e8 32 19 00 00       	call   802829 <sys_calculate_free_frames>
  800ef7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800efa:	e8 ad 19 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800eff:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = malloc(2*Mega-kilo);
  800f02:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800f05:	01 c0                	add    %eax,%eax
  800f07:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800f0a:	83 ec 0c             	sub    $0xc,%esp
  800f0d:	50                   	push   %eax
  800f0e:	e8 54 15 00 00       	call   802467 <malloc>
  800f13:	83 c4 10             	add    $0x10,%esp
  800f16:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800f19:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800f1c:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800f21:	74 17                	je     800f3a <_main+0xf02>
  800f23:	83 ec 04             	sub    $0x4,%esp
  800f26:	68 64 2f 80 00       	push   $0x802f64
  800f2b:	68 51 01 00 00       	push   $0x151
  800f30:	68 94 2f 80 00       	push   $0x802f94
  800f35:	e8 b5 04 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800f3a:	e8 ea 18 00 00       	call   802829 <sys_calculate_free_frames>
  800f3f:	89 c2                	mov    %eax,%edx
  800f41:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f44:	39 c2                	cmp    %eax,%edx
  800f46:	74 17                	je     800f5f <_main+0xf27>
  800f48:	83 ec 04             	sub    $0x4,%esp
  800f4b:	68 ac 2f 80 00       	push   $0x802fac
  800f50:	68 53 01 00 00       	push   $0x153
  800f55:	68 94 2f 80 00       	push   $0x802f94
  800f5a:	e8 90 04 00 00       	call   8013ef <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800f5f:	e8 48 19 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800f64:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800f67:	3d 00 02 00 00       	cmp    $0x200,%eax
  800f6c:	74 17                	je     800f85 <_main+0xf4d>
  800f6e:	83 ec 04             	sub    $0x4,%esp
  800f71:	68 18 30 80 00       	push   $0x803018
  800f76:	68 54 01 00 00       	push   $0x154
  800f7b:	68 94 2f 80 00       	push   $0x802f94
  800f80:	e8 6a 04 00 00       	call   8013ef <_panic>

		//remove 1 MB allocation between 1 MB hole and 2 MB hole to create 4 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800f85:	e8 9f 18 00 00       	call   802829 <sys_calculate_free_frames>
  800f8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f8d:	e8 1a 19 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800f92:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[3]);
  800f95:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800f98:	83 ec 0c             	sub    $0xc,%esp
  800f9b:	50                   	push   %eax
  800f9c:	e8 e7 15 00 00       	call   802588 <free>
  800fa1:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fa4:	e8 03 19 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  800fa9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800fac:	29 c2                	sub    %eax,%edx
  800fae:	89 d0                	mov    %edx,%eax
  800fb0:	3d 00 01 00 00       	cmp    $0x100,%eax
  800fb5:	74 17                	je     800fce <_main+0xf96>
  800fb7:	83 ec 04             	sub    $0x4,%esp
  800fba:	68 48 30 80 00       	push   $0x803048
  800fbf:	68 5b 01 00 00       	push   $0x15b
  800fc4:	68 94 2f 80 00       	push   $0x802f94
  800fc9:	e8 21 04 00 00       	call   8013ef <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800fce:	e8 56 18 00 00       	call   802829 <sys_calculate_free_frames>
  800fd3:	89 c2                	mov    %eax,%edx
  800fd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fd8:	39 c2                	cmp    %eax,%edx
  800fda:	74 17                	je     800ff3 <_main+0xfbb>
  800fdc:	83 ec 04             	sub    $0x4,%esp
  800fdf:	68 84 30 80 00       	push   $0x803084
  800fe4:	68 5c 01 00 00       	push   $0x15c
  800fe9:	68 94 2f 80 00       	push   $0x802f94
  800fee:	e8 fc 03 00 00       	call   8013ef <_panic>
		{
			//allocate 1 page after each 3 MB
			sys_allocateMem(i, PAGE_SIZE) ;
		}*/

		malloc(5*Mega-kilo);
  800ff3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ff6:	89 d0                	mov    %edx,%eax
  800ff8:	c1 e0 02             	shl    $0x2,%eax
  800ffb:	01 d0                	add    %edx,%eax
  800ffd:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801000:	83 ec 0c             	sub    $0xc,%esp
  801003:	50                   	push   %eax
  801004:	e8 5e 14 00 00       	call   802467 <malloc>
  801009:	83 c4 10             	add    $0x10,%esp

		//Fill last 3MB allocation with data
		intArr = (int*) ptr_allocations[7];
  80100c:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80100f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		lastIndexOfInt1 = (3*Mega-kilo)/sizeof(int) - 1;
  801012:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801015:	89 c2                	mov    %eax,%edx
  801017:	01 d2                	add    %edx,%edx
  801019:	01 d0                	add    %edx,%eax
  80101b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80101e:	c1 e8 02             	shr    $0x2,%eax
  801021:	48                   	dec    %eax
  801022:	89 45 d0             	mov    %eax,-0x30(%ebp)

		i = 0;
  801025:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		//filling the first 100 elements of the last 3 mega
		for (i=0; i < 100 ; i++)
  80102c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801033:	eb 17                	jmp    80104c <_main+0x1014>
		{
			intArr[i] = i ;
  801035:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801038:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80103f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801042:	01 c2                	add    %eax,%edx
  801044:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801047:	89 02                	mov    %eax,(%edx)
		intArr = (int*) ptr_allocations[7];
		lastIndexOfInt1 = (3*Mega-kilo)/sizeof(int) - 1;

		i = 0;
		//filling the first 100 elements of the last 3 mega
		for (i=0; i < 100 ; i++)
  801049:	ff 45 f0             	incl   -0x10(%ebp)
  80104c:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  801050:	7e e3                	jle    801035 <_main+0xffd>
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801052:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801055:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801058:	eb 17                	jmp    801071 <_main+0x1039>
		{
			intArr[i] = i;
  80105a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80105d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801064:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801067:	01 c2                	add    %eax,%edx
  801069:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80106c:	89 02                	mov    %eax,(%edx)
		for (i=0; i < 100 ; i++)
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  80106e:	ff 4d f0             	decl   -0x10(%ebp)
  801071:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801074:	83 e8 64             	sub    $0x64,%eax
  801077:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80107a:	7c de                	jl     80105a <_main+0x1022>
		{
			intArr[i] = i;
		}

		//Reallocate it to 4 MB, so that it can only fit at the 1st fragment
		freeFrames = sys_calculate_free_frames() ;
  80107c:	e8 a8 17 00 00       	call   802829 <sys_calculate_free_frames>
  801081:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801084:	e8 23 18 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  801089:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = realloc(ptr_allocations[7], 4*Mega-kilo);
  80108c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80108f:	c1 e0 02             	shl    $0x2,%eax
  801092:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801095:	89 c2                	mov    %eax,%edx
  801097:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80109a:	83 ec 08             	sub    $0x8,%esp
  80109d:	52                   	push   %edx
  80109e:	50                   	push   %eax
  80109f:	e8 fc 15 00 00       	call   8026a0 <realloc>
  8010a4:	83 c4 10             	add    $0x10,%esp
  8010a7:	89 45 94             	mov    %eax,-0x6c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the re-allocated space... ");
  8010aa:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8010ad:	89 c2                	mov    %eax,%edx
  8010af:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010b2:	01 c0                	add    %eax,%eax
  8010b4:	05 00 00 00 80       	add    $0x80000000,%eax
  8010b9:	39 c2                	cmp    %eax,%edx
  8010bb:	74 17                	je     8010d4 <_main+0x109c>
  8010bd:	83 ec 04             	sub    $0x4,%esp
  8010c0:	68 a8 32 80 00       	push   $0x8032a8
  8010c5:	68 7d 01 00 00       	push   $0x17d
  8010ca:	68 94 2f 80 00       	push   $0x802f94
  8010cf:	e8 1b 03 00 00       	call   8013ef <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 - 1) panic("Wrong re-allocation");
		//if((sys_calculate_free_frames() - freeFrames) != 2 + 2) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are re-allocated in PageFile");
  8010d4:	e8 d3 17 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  8010d9:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8010dc:	3d 00 01 00 00       	cmp    $0x100,%eax
  8010e1:	74 17                	je     8010fa <_main+0x10c2>
  8010e3:	83 ec 04             	sub    $0x4,%esp
  8010e6:	68 88 31 80 00       	push   $0x803188
  8010eb:	68 80 01 00 00       	push   $0x180
  8010f0:	68 94 2f 80 00       	push   $0x802f94
  8010f5:	e8 f5 02 00 00       	call   8013ef <_panic>


		//[2] test memory access
		lastIndexOfInt2 = (4*Mega-kilo)/sizeof(int) - 1;
  8010fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8010fd:	c1 e0 02             	shl    $0x2,%eax
  801100:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801103:	c1 e8 02             	shr    $0x2,%eax
  801106:	48                   	dec    %eax
  801107:	89 45 cc             	mov    %eax,-0x34(%ebp)
		intArr = (int*) ptr_allocations[7];
  80110a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80110d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  801110:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801113:	40                   	inc    %eax
  801114:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801117:	eb 17                	jmp    801130 <_main+0x10f8>
		{
			intArr[i] = i ;
  801119:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80111c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801123:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801126:	01 c2                	add    %eax,%edx
  801128:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80112b:	89 02                	mov    %eax,(%edx)


		//[2] test memory access
		lastIndexOfInt2 = (4*Mega-kilo)/sizeof(int) - 1;
		intArr = (int*) ptr_allocations[7];
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  80112d:	ff 45 f0             	incl   -0x10(%ebp)
  801130:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801133:	83 c0 65             	add    $0x65,%eax
  801136:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801139:	7f de                	jg     801119 <_main+0x10e1>
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80113b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80113e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801141:	eb 17                	jmp    80115a <_main+0x1122>
		{
			intArr[i] = i;
  801143:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801146:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80114d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801150:	01 c2                	add    %eax,%edx
  801152:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801155:	89 02                	mov    %eax,(%edx)
		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
		{
			intArr[i] = i ;
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  801157:	ff 4d f0             	decl   -0x10(%ebp)
  80115a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80115d:	83 e8 64             	sub    $0x64,%eax
  801160:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801163:	7c de                	jl     801143 <_main+0x110b>
		{
			intArr[i] = i;
		}

		for (i=0; i < 100 ; i++)
  801165:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80116c:	eb 33                	jmp    8011a1 <_main+0x1169>
		{
			cnt++;
  80116e:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  801171:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801174:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80117b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80117e:	01 d0                	add    %edx,%eax
  801180:	8b 00                	mov    (%eax),%eax
  801182:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801185:	74 17                	je     80119e <_main+0x1166>
  801187:	83 ec 04             	sub    $0x4,%esp
  80118a:	68 68 32 80 00       	push   $0x803268
  80118f:	68 93 01 00 00       	push   $0x193
  801194:	68 94 2f 80 00       	push   $0x802f94
  801199:	e8 51 02 00 00       	call   8013ef <_panic>
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
		{
			intArr[i] = i;
		}

		for (i=0; i < 100 ; i++)
  80119e:	ff 45 f0             	incl   -0x10(%ebp)
  8011a1:	83 7d f0 63          	cmpl   $0x63,-0x10(%ebp)
  8011a5:	7e c7                	jle    80116e <_main+0x1136>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  8011a7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8011aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011ad:	eb 33                	jmp    8011e2 <_main+0x11aa>
		{
			cnt++;
  8011af:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8011b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011bc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8011bf:	01 d0                	add    %edx,%eax
  8011c1:	8b 00                	mov    (%eax),%eax
  8011c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011c6:	74 17                	je     8011df <_main+0x11a7>
  8011c8:	83 ec 04             	sub    $0x4,%esp
  8011cb:	68 68 32 80 00       	push   $0x803268
  8011d0:	68 99 01 00 00       	push   $0x199
  8011d5:	68 94 2f 80 00       	push   $0x802f94
  8011da:	e8 10 02 00 00       	call   8013ef <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  8011df:	ff 4d f0             	decl   -0x10(%ebp)
  8011e2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8011e5:	83 e8 64             	sub    $0x64,%eax
  8011e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011eb:	7c c2                	jl     8011af <_main+0x1177>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  8011ed:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8011f0:	40                   	inc    %eax
  8011f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011f4:	eb 33                	jmp    801229 <_main+0x11f1>
		{
			cnt++;
  8011f6:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8011f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801203:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801206:	01 d0                	add    %edx,%eax
  801208:	8b 00                	mov    (%eax),%eax
  80120a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80120d:	74 17                	je     801226 <_main+0x11ee>
  80120f:	83 ec 04             	sub    $0x4,%esp
  801212:	68 68 32 80 00       	push   $0x803268
  801217:	68 9f 01 00 00       	push   $0x19f
  80121c:	68 94 2f 80 00       	push   $0x802f94
  801221:	e8 c9 01 00 00       	call   8013ef <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for (i=lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101 ; i++)
  801226:	ff 45 f0             	incl   -0x10(%ebp)
  801229:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80122c:	83 c0 65             	add    $0x65,%eax
  80122f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801232:	7f c2                	jg     8011f6 <_main+0x11be>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  801234:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801237:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80123a:	eb 33                	jmp    80126f <_main+0x1237>
		{
			cnt++;
  80123c:	ff 45 f4             	incl   -0xc(%ebp)
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80123f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801242:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801249:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	8b 00                	mov    (%eax),%eax
  801250:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801253:	74 17                	je     80126c <_main+0x1234>
  801255:	83 ec 04             	sub    $0x4,%esp
  801258:	68 68 32 80 00       	push   $0x803268
  80125d:	68 a5 01 00 00       	push   $0x1a5
  801262:	68 94 2f 80 00       	push   $0x802f94
  801267:	e8 83 01 00 00       	call   8013ef <_panic>
		{
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80126c:	ff 4d f0             	decl   -0x10(%ebp)
  80126f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801272:	83 e8 64             	sub    $0x64,%eax
  801275:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801278:	7c c2                	jl     80123c <_main+0x1204>
			cnt++;
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  80127a:	e8 aa 15 00 00       	call   802829 <sys_calculate_free_frames>
  80127f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801282:	e8 25 16 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  801287:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[7]);
  80128a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80128d:	83 ec 0c             	sub    $0xc,%esp
  801290:	50                   	push   %eax
  801291:	e8 f2 12 00 00       	call   802588 <free>
  801296:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1024) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1024) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  801299:	e8 0e 16 00 00       	call   8028ac <sys_pf_calculate_allocated_pages>
  80129e:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8012a1:	29 c2                	sub    %eax,%edx
  8012a3:	89 d0                	mov    %edx,%eax
  8012a5:	3d 00 04 00 00       	cmp    $0x400,%eax
  8012aa:	74 17                	je     8012c3 <_main+0x128b>
  8012ac:	83 ec 04             	sub    $0x4,%esp
  8012af:	68 dc 32 80 00       	push   $0x8032dc
  8012b4:	68 ad 01 00 00       	push   $0x1ad
  8012b9:	68 94 2f 80 00       	push   $0x802f94
  8012be:	e8 2c 01 00 00       	call   8013ef <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b100%\n", NULL);
  8012c3:	83 ec 08             	sub    $0x8,%esp
  8012c6:	6a 00                	push   $0x0
  8012c8:	68 a2 33 80 00       	push   $0x8033a2
  8012cd:	e8 66 03 00 00       	call   801638 <vcprintf>
  8012d2:	83 c4 10             	add    $0x10,%esp
	}



	cprintf("Congratulations!! test realloc [2] completed successfully.\n");
  8012d5:	83 ec 0c             	sub    $0xc,%esp
  8012d8:	68 ac 33 80 00       	push   $0x8033ac
  8012dd:	e8 c1 03 00 00       	call   8016a3 <cprintf>
  8012e2:	83 c4 10             	add    $0x10,%esp

	return;
  8012e5:	90                   	nop
}
  8012e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012e9:	5b                   	pop    %ebx
  8012ea:	5f                   	pop    %edi
  8012eb:	5d                   	pop    %ebp
  8012ec:	c3                   	ret    

008012ed <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
  8012f0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8012f3:	e8 66 14 00 00       	call   80275e <sys_getenvindex>
  8012f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8012fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012fe:	89 d0                	mov    %edx,%eax
  801300:	01 c0                	add    %eax,%eax
  801302:	01 d0                	add    %edx,%eax
  801304:	c1 e0 02             	shl    $0x2,%eax
  801307:	01 d0                	add    %edx,%eax
  801309:	c1 e0 06             	shl    $0x6,%eax
  80130c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  801311:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801316:	a1 20 40 80 00       	mov    0x804020,%eax
  80131b:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  801321:	84 c0                	test   %al,%al
  801323:	74 0f                	je     801334 <libmain+0x47>
		binaryname = myEnv->prog_name;
  801325:	a1 20 40 80 00       	mov    0x804020,%eax
  80132a:	05 f4 02 00 00       	add    $0x2f4,%eax
  80132f:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801334:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801338:	7e 0a                	jle    801344 <libmain+0x57>
		binaryname = argv[0];
  80133a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133d:	8b 00                	mov    (%eax),%eax
  80133f:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801344:	83 ec 08             	sub    $0x8,%esp
  801347:	ff 75 0c             	pushl  0xc(%ebp)
  80134a:	ff 75 08             	pushl  0x8(%ebp)
  80134d:	e8 e6 ec ff ff       	call   800038 <_main>
  801352:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801355:	e8 9f 15 00 00       	call   8028f9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80135a:	83 ec 0c             	sub    $0xc,%esp
  80135d:	68 00 34 80 00       	push   $0x803400
  801362:	e8 3c 03 00 00       	call   8016a3 <cprintf>
  801367:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80136a:	a1 20 40 80 00       	mov    0x804020,%eax
  80136f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  801375:	a1 20 40 80 00       	mov    0x804020,%eax
  80137a:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801380:	83 ec 04             	sub    $0x4,%esp
  801383:	52                   	push   %edx
  801384:	50                   	push   %eax
  801385:	68 28 34 80 00       	push   $0x803428
  80138a:	e8 14 03 00 00       	call   8016a3 <cprintf>
  80138f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801392:	a1 20 40 80 00       	mov    0x804020,%eax
  801397:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80139d:	83 ec 08             	sub    $0x8,%esp
  8013a0:	50                   	push   %eax
  8013a1:	68 4d 34 80 00       	push   $0x80344d
  8013a6:	e8 f8 02 00 00       	call   8016a3 <cprintf>
  8013ab:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8013ae:	83 ec 0c             	sub    $0xc,%esp
  8013b1:	68 00 34 80 00       	push   $0x803400
  8013b6:	e8 e8 02 00 00       	call   8016a3 <cprintf>
  8013bb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8013be:	e8 50 15 00 00       	call   802913 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8013c3:	e8 19 00 00 00       	call   8013e1 <exit>
}
  8013c8:	90                   	nop
  8013c9:	c9                   	leave  
  8013ca:	c3                   	ret    

008013cb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
  8013ce:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8013d1:	83 ec 0c             	sub    $0xc,%esp
  8013d4:	6a 00                	push   $0x0
  8013d6:	e8 4f 13 00 00       	call   80272a <sys_env_destroy>
  8013db:	83 c4 10             	add    $0x10,%esp
}
  8013de:	90                   	nop
  8013df:	c9                   	leave  
  8013e0:	c3                   	ret    

008013e1 <exit>:

void
exit(void)
{
  8013e1:	55                   	push   %ebp
  8013e2:	89 e5                	mov    %esp,%ebp
  8013e4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8013e7:	e8 a4 13 00 00       	call   802790 <sys_env_exit>
}
  8013ec:	90                   	nop
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
  8013f2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8013f5:	8d 45 10             	lea    0x10(%ebp),%eax
  8013f8:	83 c0 04             	add    $0x4,%eax
  8013fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8013fe:	a1 30 40 80 00       	mov    0x804030,%eax
  801403:	85 c0                	test   %eax,%eax
  801405:	74 16                	je     80141d <_panic+0x2e>
		cprintf("%s: ", argv0);
  801407:	a1 30 40 80 00       	mov    0x804030,%eax
  80140c:	83 ec 08             	sub    $0x8,%esp
  80140f:	50                   	push   %eax
  801410:	68 64 34 80 00       	push   $0x803464
  801415:	e8 89 02 00 00       	call   8016a3 <cprintf>
  80141a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80141d:	a1 00 40 80 00       	mov    0x804000,%eax
  801422:	ff 75 0c             	pushl  0xc(%ebp)
  801425:	ff 75 08             	pushl  0x8(%ebp)
  801428:	50                   	push   %eax
  801429:	68 69 34 80 00       	push   $0x803469
  80142e:	e8 70 02 00 00       	call   8016a3 <cprintf>
  801433:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801436:	8b 45 10             	mov    0x10(%ebp),%eax
  801439:	83 ec 08             	sub    $0x8,%esp
  80143c:	ff 75 f4             	pushl  -0xc(%ebp)
  80143f:	50                   	push   %eax
  801440:	e8 f3 01 00 00       	call   801638 <vcprintf>
  801445:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801448:	83 ec 08             	sub    $0x8,%esp
  80144b:	6a 00                	push   $0x0
  80144d:	68 85 34 80 00       	push   $0x803485
  801452:	e8 e1 01 00 00       	call   801638 <vcprintf>
  801457:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80145a:	e8 82 ff ff ff       	call   8013e1 <exit>

	// should not return here
	while (1) ;
  80145f:	eb fe                	jmp    80145f <_panic+0x70>

00801461 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
  801464:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801467:	a1 20 40 80 00       	mov    0x804020,%eax
  80146c:	8b 50 74             	mov    0x74(%eax),%edx
  80146f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801472:	39 c2                	cmp    %eax,%edx
  801474:	74 14                	je     80148a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801476:	83 ec 04             	sub    $0x4,%esp
  801479:	68 88 34 80 00       	push   $0x803488
  80147e:	6a 26                	push   $0x26
  801480:	68 d4 34 80 00       	push   $0x8034d4
  801485:	e8 65 ff ff ff       	call   8013ef <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80148a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801491:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801498:	e9 c2 00 00 00       	jmp    80155f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80149d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014a0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	01 d0                	add    %edx,%eax
  8014ac:	8b 00                	mov    (%eax),%eax
  8014ae:	85 c0                	test   %eax,%eax
  8014b0:	75 08                	jne    8014ba <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8014b2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8014b5:	e9 a2 00 00 00       	jmp    80155c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8014ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8014c1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8014c8:	eb 69                	jmp    801533 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8014ca:	a1 20 40 80 00       	mov    0x804020,%eax
  8014cf:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8014d5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8014d8:	89 d0                	mov    %edx,%eax
  8014da:	01 c0                	add    %eax,%eax
  8014dc:	01 d0                	add    %edx,%eax
  8014de:	c1 e0 02             	shl    $0x2,%eax
  8014e1:	01 c8                	add    %ecx,%eax
  8014e3:	8a 40 04             	mov    0x4(%eax),%al
  8014e6:	84 c0                	test   %al,%al
  8014e8:	75 46                	jne    801530 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8014ea:	a1 20 40 80 00       	mov    0x804020,%eax
  8014ef:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8014f5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8014f8:	89 d0                	mov    %edx,%eax
  8014fa:	01 c0                	add    %eax,%eax
  8014fc:	01 d0                	add    %edx,%eax
  8014fe:	c1 e0 02             	shl    $0x2,%eax
  801501:	01 c8                	add    %ecx,%eax
  801503:	8b 00                	mov    (%eax),%eax
  801505:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801508:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80150b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801510:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801512:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801515:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80151c:	8b 45 08             	mov    0x8(%ebp),%eax
  80151f:	01 c8                	add    %ecx,%eax
  801521:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801523:	39 c2                	cmp    %eax,%edx
  801525:	75 09                	jne    801530 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801527:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80152e:	eb 12                	jmp    801542 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801530:	ff 45 e8             	incl   -0x18(%ebp)
  801533:	a1 20 40 80 00       	mov    0x804020,%eax
  801538:	8b 50 74             	mov    0x74(%eax),%edx
  80153b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80153e:	39 c2                	cmp    %eax,%edx
  801540:	77 88                	ja     8014ca <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801542:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801546:	75 14                	jne    80155c <CheckWSWithoutLastIndex+0xfb>
			panic(
  801548:	83 ec 04             	sub    $0x4,%esp
  80154b:	68 e0 34 80 00       	push   $0x8034e0
  801550:	6a 3a                	push   $0x3a
  801552:	68 d4 34 80 00       	push   $0x8034d4
  801557:	e8 93 fe ff ff       	call   8013ef <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80155c:	ff 45 f0             	incl   -0x10(%ebp)
  80155f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801562:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801565:	0f 8c 32 ff ff ff    	jl     80149d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80156b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801572:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801579:	eb 26                	jmp    8015a1 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80157b:	a1 20 40 80 00       	mov    0x804020,%eax
  801580:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801586:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801589:	89 d0                	mov    %edx,%eax
  80158b:	01 c0                	add    %eax,%eax
  80158d:	01 d0                	add    %edx,%eax
  80158f:	c1 e0 02             	shl    $0x2,%eax
  801592:	01 c8                	add    %ecx,%eax
  801594:	8a 40 04             	mov    0x4(%eax),%al
  801597:	3c 01                	cmp    $0x1,%al
  801599:	75 03                	jne    80159e <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80159b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80159e:	ff 45 e0             	incl   -0x20(%ebp)
  8015a1:	a1 20 40 80 00       	mov    0x804020,%eax
  8015a6:	8b 50 74             	mov    0x74(%eax),%edx
  8015a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015ac:	39 c2                	cmp    %eax,%edx
  8015ae:	77 cb                	ja     80157b <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8015b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015b3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8015b6:	74 14                	je     8015cc <CheckWSWithoutLastIndex+0x16b>
		panic(
  8015b8:	83 ec 04             	sub    $0x4,%esp
  8015bb:	68 34 35 80 00       	push   $0x803534
  8015c0:	6a 44                	push   $0x44
  8015c2:	68 d4 34 80 00       	push   $0x8034d4
  8015c7:	e8 23 fe ff ff       	call   8013ef <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8015cc:	90                   	nop
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
  8015d2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8015d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d8:	8b 00                	mov    (%eax),%eax
  8015da:	8d 48 01             	lea    0x1(%eax),%ecx
  8015dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e0:	89 0a                	mov    %ecx,(%edx)
  8015e2:	8b 55 08             	mov    0x8(%ebp),%edx
  8015e5:	88 d1                	mov    %dl,%cl
  8015e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ea:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8015ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f1:	8b 00                	mov    (%eax),%eax
  8015f3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8015f8:	75 2c                	jne    801626 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8015fa:	a0 24 40 80 00       	mov    0x804024,%al
  8015ff:	0f b6 c0             	movzbl %al,%eax
  801602:	8b 55 0c             	mov    0xc(%ebp),%edx
  801605:	8b 12                	mov    (%edx),%edx
  801607:	89 d1                	mov    %edx,%ecx
  801609:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160c:	83 c2 08             	add    $0x8,%edx
  80160f:	83 ec 04             	sub    $0x4,%esp
  801612:	50                   	push   %eax
  801613:	51                   	push   %ecx
  801614:	52                   	push   %edx
  801615:	e8 ce 10 00 00       	call   8026e8 <sys_cputs>
  80161a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80161d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801620:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801626:	8b 45 0c             	mov    0xc(%ebp),%eax
  801629:	8b 40 04             	mov    0x4(%eax),%eax
  80162c:	8d 50 01             	lea    0x1(%eax),%edx
  80162f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801632:	89 50 04             	mov    %edx,0x4(%eax)
}
  801635:	90                   	nop
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801641:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801648:	00 00 00 
	b.cnt = 0;
  80164b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801652:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801655:	ff 75 0c             	pushl  0xc(%ebp)
  801658:	ff 75 08             	pushl  0x8(%ebp)
  80165b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801661:	50                   	push   %eax
  801662:	68 cf 15 80 00       	push   $0x8015cf
  801667:	e8 11 02 00 00       	call   80187d <vprintfmt>
  80166c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80166f:	a0 24 40 80 00       	mov    0x804024,%al
  801674:	0f b6 c0             	movzbl %al,%eax
  801677:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80167d:	83 ec 04             	sub    $0x4,%esp
  801680:	50                   	push   %eax
  801681:	52                   	push   %edx
  801682:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801688:	83 c0 08             	add    $0x8,%eax
  80168b:	50                   	push   %eax
  80168c:	e8 57 10 00 00       	call   8026e8 <sys_cputs>
  801691:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801694:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80169b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
  8016a6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8016a9:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  8016b0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8016b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	83 ec 08             	sub    $0x8,%esp
  8016bc:	ff 75 f4             	pushl  -0xc(%ebp)
  8016bf:	50                   	push   %eax
  8016c0:	e8 73 ff ff ff       	call   801638 <vcprintf>
  8016c5:	83 c4 10             	add    $0x10,%esp
  8016c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8016cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
  8016d3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8016d6:	e8 1e 12 00 00       	call   8028f9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8016db:	8d 45 0c             	lea    0xc(%ebp),%eax
  8016de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	83 ec 08             	sub    $0x8,%esp
  8016e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8016ea:	50                   	push   %eax
  8016eb:	e8 48 ff ff ff       	call   801638 <vcprintf>
  8016f0:	83 c4 10             	add    $0x10,%esp
  8016f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8016f6:	e8 18 12 00 00       	call   802913 <sys_enable_interrupt>
	return cnt;
  8016fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016fe:	c9                   	leave  
  8016ff:	c3                   	ret    

00801700 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801700:	55                   	push   %ebp
  801701:	89 e5                	mov    %esp,%ebp
  801703:	53                   	push   %ebx
  801704:	83 ec 14             	sub    $0x14,%esp
  801707:	8b 45 10             	mov    0x10(%ebp),%eax
  80170a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80170d:	8b 45 14             	mov    0x14(%ebp),%eax
  801710:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801713:	8b 45 18             	mov    0x18(%ebp),%eax
  801716:	ba 00 00 00 00       	mov    $0x0,%edx
  80171b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80171e:	77 55                	ja     801775 <printnum+0x75>
  801720:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801723:	72 05                	jb     80172a <printnum+0x2a>
  801725:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801728:	77 4b                	ja     801775 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80172a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80172d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801730:	8b 45 18             	mov    0x18(%ebp),%eax
  801733:	ba 00 00 00 00       	mov    $0x0,%edx
  801738:	52                   	push   %edx
  801739:	50                   	push   %eax
  80173a:	ff 75 f4             	pushl  -0xc(%ebp)
  80173d:	ff 75 f0             	pushl  -0x10(%ebp)
  801740:	e8 93 15 00 00       	call   802cd8 <__udivdi3>
  801745:	83 c4 10             	add    $0x10,%esp
  801748:	83 ec 04             	sub    $0x4,%esp
  80174b:	ff 75 20             	pushl  0x20(%ebp)
  80174e:	53                   	push   %ebx
  80174f:	ff 75 18             	pushl  0x18(%ebp)
  801752:	52                   	push   %edx
  801753:	50                   	push   %eax
  801754:	ff 75 0c             	pushl  0xc(%ebp)
  801757:	ff 75 08             	pushl  0x8(%ebp)
  80175a:	e8 a1 ff ff ff       	call   801700 <printnum>
  80175f:	83 c4 20             	add    $0x20,%esp
  801762:	eb 1a                	jmp    80177e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801764:	83 ec 08             	sub    $0x8,%esp
  801767:	ff 75 0c             	pushl  0xc(%ebp)
  80176a:	ff 75 20             	pushl  0x20(%ebp)
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	ff d0                	call   *%eax
  801772:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801775:	ff 4d 1c             	decl   0x1c(%ebp)
  801778:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80177c:	7f e6                	jg     801764 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80177e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801781:	bb 00 00 00 00       	mov    $0x0,%ebx
  801786:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801789:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80178c:	53                   	push   %ebx
  80178d:	51                   	push   %ecx
  80178e:	52                   	push   %edx
  80178f:	50                   	push   %eax
  801790:	e8 53 16 00 00       	call   802de8 <__umoddi3>
  801795:	83 c4 10             	add    $0x10,%esp
  801798:	05 94 37 80 00       	add    $0x803794,%eax
  80179d:	8a 00                	mov    (%eax),%al
  80179f:	0f be c0             	movsbl %al,%eax
  8017a2:	83 ec 08             	sub    $0x8,%esp
  8017a5:	ff 75 0c             	pushl  0xc(%ebp)
  8017a8:	50                   	push   %eax
  8017a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ac:	ff d0                	call   *%eax
  8017ae:	83 c4 10             	add    $0x10,%esp
}
  8017b1:	90                   	nop
  8017b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8017b5:	c9                   	leave  
  8017b6:	c3                   	ret    

008017b7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8017b7:	55                   	push   %ebp
  8017b8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8017ba:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8017be:	7e 1c                	jle    8017dc <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8017c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c3:	8b 00                	mov    (%eax),%eax
  8017c5:	8d 50 08             	lea    0x8(%eax),%edx
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	89 10                	mov    %edx,(%eax)
  8017cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d0:	8b 00                	mov    (%eax),%eax
  8017d2:	83 e8 08             	sub    $0x8,%eax
  8017d5:	8b 50 04             	mov    0x4(%eax),%edx
  8017d8:	8b 00                	mov    (%eax),%eax
  8017da:	eb 40                	jmp    80181c <getuint+0x65>
	else if (lflag)
  8017dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017e0:	74 1e                	je     801800 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8017e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e5:	8b 00                	mov    (%eax),%eax
  8017e7:	8d 50 04             	lea    0x4(%eax),%edx
  8017ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ed:	89 10                	mov    %edx,(%eax)
  8017ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f2:	8b 00                	mov    (%eax),%eax
  8017f4:	83 e8 04             	sub    $0x4,%eax
  8017f7:	8b 00                	mov    (%eax),%eax
  8017f9:	ba 00 00 00 00       	mov    $0x0,%edx
  8017fe:	eb 1c                	jmp    80181c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	8b 00                	mov    (%eax),%eax
  801805:	8d 50 04             	lea    0x4(%eax),%edx
  801808:	8b 45 08             	mov    0x8(%ebp),%eax
  80180b:	89 10                	mov    %edx,(%eax)
  80180d:	8b 45 08             	mov    0x8(%ebp),%eax
  801810:	8b 00                	mov    (%eax),%eax
  801812:	83 e8 04             	sub    $0x4,%eax
  801815:	8b 00                	mov    (%eax),%eax
  801817:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80181c:	5d                   	pop    %ebp
  80181d:	c3                   	ret    

0080181e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80181e:	55                   	push   %ebp
  80181f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801821:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801825:	7e 1c                	jle    801843 <getint+0x25>
		return va_arg(*ap, long long);
  801827:	8b 45 08             	mov    0x8(%ebp),%eax
  80182a:	8b 00                	mov    (%eax),%eax
  80182c:	8d 50 08             	lea    0x8(%eax),%edx
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	89 10                	mov    %edx,(%eax)
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	8b 00                	mov    (%eax),%eax
  801839:	83 e8 08             	sub    $0x8,%eax
  80183c:	8b 50 04             	mov    0x4(%eax),%edx
  80183f:	8b 00                	mov    (%eax),%eax
  801841:	eb 38                	jmp    80187b <getint+0x5d>
	else if (lflag)
  801843:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801847:	74 1a                	je     801863 <getint+0x45>
		return va_arg(*ap, long);
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	8b 00                	mov    (%eax),%eax
  80184e:	8d 50 04             	lea    0x4(%eax),%edx
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	89 10                	mov    %edx,(%eax)
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	8b 00                	mov    (%eax),%eax
  80185b:	83 e8 04             	sub    $0x4,%eax
  80185e:	8b 00                	mov    (%eax),%eax
  801860:	99                   	cltd   
  801861:	eb 18                	jmp    80187b <getint+0x5d>
	else
		return va_arg(*ap, int);
  801863:	8b 45 08             	mov    0x8(%ebp),%eax
  801866:	8b 00                	mov    (%eax),%eax
  801868:	8d 50 04             	lea    0x4(%eax),%edx
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	89 10                	mov    %edx,(%eax)
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	8b 00                	mov    (%eax),%eax
  801875:	83 e8 04             	sub    $0x4,%eax
  801878:	8b 00                	mov    (%eax),%eax
  80187a:	99                   	cltd   
}
  80187b:	5d                   	pop    %ebp
  80187c:	c3                   	ret    

0080187d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80187d:	55                   	push   %ebp
  80187e:	89 e5                	mov    %esp,%ebp
  801880:	56                   	push   %esi
  801881:	53                   	push   %ebx
  801882:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801885:	eb 17                	jmp    80189e <vprintfmt+0x21>
			if (ch == '\0')
  801887:	85 db                	test   %ebx,%ebx
  801889:	0f 84 af 03 00 00    	je     801c3e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80188f:	83 ec 08             	sub    $0x8,%esp
  801892:	ff 75 0c             	pushl  0xc(%ebp)
  801895:	53                   	push   %ebx
  801896:	8b 45 08             	mov    0x8(%ebp),%eax
  801899:	ff d0                	call   *%eax
  80189b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80189e:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a1:	8d 50 01             	lea    0x1(%eax),%edx
  8018a4:	89 55 10             	mov    %edx,0x10(%ebp)
  8018a7:	8a 00                	mov    (%eax),%al
  8018a9:	0f b6 d8             	movzbl %al,%ebx
  8018ac:	83 fb 25             	cmp    $0x25,%ebx
  8018af:	75 d6                	jne    801887 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8018b1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8018b5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8018bc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8018c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8018ca:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8018d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d4:	8d 50 01             	lea    0x1(%eax),%edx
  8018d7:	89 55 10             	mov    %edx,0x10(%ebp)
  8018da:	8a 00                	mov    (%eax),%al
  8018dc:	0f b6 d8             	movzbl %al,%ebx
  8018df:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8018e2:	83 f8 55             	cmp    $0x55,%eax
  8018e5:	0f 87 2b 03 00 00    	ja     801c16 <vprintfmt+0x399>
  8018eb:	8b 04 85 b8 37 80 00 	mov    0x8037b8(,%eax,4),%eax
  8018f2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8018f4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8018f8:	eb d7                	jmp    8018d1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8018fa:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8018fe:	eb d1                	jmp    8018d1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801900:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801907:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80190a:	89 d0                	mov    %edx,%eax
  80190c:	c1 e0 02             	shl    $0x2,%eax
  80190f:	01 d0                	add    %edx,%eax
  801911:	01 c0                	add    %eax,%eax
  801913:	01 d8                	add    %ebx,%eax
  801915:	83 e8 30             	sub    $0x30,%eax
  801918:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80191b:	8b 45 10             	mov    0x10(%ebp),%eax
  80191e:	8a 00                	mov    (%eax),%al
  801920:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801923:	83 fb 2f             	cmp    $0x2f,%ebx
  801926:	7e 3e                	jle    801966 <vprintfmt+0xe9>
  801928:	83 fb 39             	cmp    $0x39,%ebx
  80192b:	7f 39                	jg     801966 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80192d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801930:	eb d5                	jmp    801907 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801932:	8b 45 14             	mov    0x14(%ebp),%eax
  801935:	83 c0 04             	add    $0x4,%eax
  801938:	89 45 14             	mov    %eax,0x14(%ebp)
  80193b:	8b 45 14             	mov    0x14(%ebp),%eax
  80193e:	83 e8 04             	sub    $0x4,%eax
  801941:	8b 00                	mov    (%eax),%eax
  801943:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801946:	eb 1f                	jmp    801967 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801948:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80194c:	79 83                	jns    8018d1 <vprintfmt+0x54>
				width = 0;
  80194e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801955:	e9 77 ff ff ff       	jmp    8018d1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80195a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801961:	e9 6b ff ff ff       	jmp    8018d1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801966:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801967:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80196b:	0f 89 60 ff ff ff    	jns    8018d1 <vprintfmt+0x54>
				width = precision, precision = -1;
  801971:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801974:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801977:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80197e:	e9 4e ff ff ff       	jmp    8018d1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801983:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801986:	e9 46 ff ff ff       	jmp    8018d1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80198b:	8b 45 14             	mov    0x14(%ebp),%eax
  80198e:	83 c0 04             	add    $0x4,%eax
  801991:	89 45 14             	mov    %eax,0x14(%ebp)
  801994:	8b 45 14             	mov    0x14(%ebp),%eax
  801997:	83 e8 04             	sub    $0x4,%eax
  80199a:	8b 00                	mov    (%eax),%eax
  80199c:	83 ec 08             	sub    $0x8,%esp
  80199f:	ff 75 0c             	pushl  0xc(%ebp)
  8019a2:	50                   	push   %eax
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	ff d0                	call   *%eax
  8019a8:	83 c4 10             	add    $0x10,%esp
			break;
  8019ab:	e9 89 02 00 00       	jmp    801c39 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8019b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b3:	83 c0 04             	add    $0x4,%eax
  8019b6:	89 45 14             	mov    %eax,0x14(%ebp)
  8019b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8019bc:	83 e8 04             	sub    $0x4,%eax
  8019bf:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8019c1:	85 db                	test   %ebx,%ebx
  8019c3:	79 02                	jns    8019c7 <vprintfmt+0x14a>
				err = -err;
  8019c5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8019c7:	83 fb 64             	cmp    $0x64,%ebx
  8019ca:	7f 0b                	jg     8019d7 <vprintfmt+0x15a>
  8019cc:	8b 34 9d 00 36 80 00 	mov    0x803600(,%ebx,4),%esi
  8019d3:	85 f6                	test   %esi,%esi
  8019d5:	75 19                	jne    8019f0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8019d7:	53                   	push   %ebx
  8019d8:	68 a5 37 80 00       	push   $0x8037a5
  8019dd:	ff 75 0c             	pushl  0xc(%ebp)
  8019e0:	ff 75 08             	pushl  0x8(%ebp)
  8019e3:	e8 5e 02 00 00       	call   801c46 <printfmt>
  8019e8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8019eb:	e9 49 02 00 00       	jmp    801c39 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8019f0:	56                   	push   %esi
  8019f1:	68 ae 37 80 00       	push   $0x8037ae
  8019f6:	ff 75 0c             	pushl  0xc(%ebp)
  8019f9:	ff 75 08             	pushl  0x8(%ebp)
  8019fc:	e8 45 02 00 00       	call   801c46 <printfmt>
  801a01:	83 c4 10             	add    $0x10,%esp
			break;
  801a04:	e9 30 02 00 00       	jmp    801c39 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801a09:	8b 45 14             	mov    0x14(%ebp),%eax
  801a0c:	83 c0 04             	add    $0x4,%eax
  801a0f:	89 45 14             	mov    %eax,0x14(%ebp)
  801a12:	8b 45 14             	mov    0x14(%ebp),%eax
  801a15:	83 e8 04             	sub    $0x4,%eax
  801a18:	8b 30                	mov    (%eax),%esi
  801a1a:	85 f6                	test   %esi,%esi
  801a1c:	75 05                	jne    801a23 <vprintfmt+0x1a6>
				p = "(null)";
  801a1e:	be b1 37 80 00       	mov    $0x8037b1,%esi
			if (width > 0 && padc != '-')
  801a23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a27:	7e 6d                	jle    801a96 <vprintfmt+0x219>
  801a29:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801a2d:	74 67                	je     801a96 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801a2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a32:	83 ec 08             	sub    $0x8,%esp
  801a35:	50                   	push   %eax
  801a36:	56                   	push   %esi
  801a37:	e8 0c 03 00 00       	call   801d48 <strnlen>
  801a3c:	83 c4 10             	add    $0x10,%esp
  801a3f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801a42:	eb 16                	jmp    801a5a <vprintfmt+0x1dd>
					putch(padc, putdat);
  801a44:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801a48:	83 ec 08             	sub    $0x8,%esp
  801a4b:	ff 75 0c             	pushl  0xc(%ebp)
  801a4e:	50                   	push   %eax
  801a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a52:	ff d0                	call   *%eax
  801a54:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801a57:	ff 4d e4             	decl   -0x1c(%ebp)
  801a5a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a5e:	7f e4                	jg     801a44 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801a60:	eb 34                	jmp    801a96 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801a62:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801a66:	74 1c                	je     801a84 <vprintfmt+0x207>
  801a68:	83 fb 1f             	cmp    $0x1f,%ebx
  801a6b:	7e 05                	jle    801a72 <vprintfmt+0x1f5>
  801a6d:	83 fb 7e             	cmp    $0x7e,%ebx
  801a70:	7e 12                	jle    801a84 <vprintfmt+0x207>
					putch('?', putdat);
  801a72:	83 ec 08             	sub    $0x8,%esp
  801a75:	ff 75 0c             	pushl  0xc(%ebp)
  801a78:	6a 3f                	push   $0x3f
  801a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7d:	ff d0                	call   *%eax
  801a7f:	83 c4 10             	add    $0x10,%esp
  801a82:	eb 0f                	jmp    801a93 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801a84:	83 ec 08             	sub    $0x8,%esp
  801a87:	ff 75 0c             	pushl  0xc(%ebp)
  801a8a:	53                   	push   %ebx
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	ff d0                	call   *%eax
  801a90:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801a93:	ff 4d e4             	decl   -0x1c(%ebp)
  801a96:	89 f0                	mov    %esi,%eax
  801a98:	8d 70 01             	lea    0x1(%eax),%esi
  801a9b:	8a 00                	mov    (%eax),%al
  801a9d:	0f be d8             	movsbl %al,%ebx
  801aa0:	85 db                	test   %ebx,%ebx
  801aa2:	74 24                	je     801ac8 <vprintfmt+0x24b>
  801aa4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801aa8:	78 b8                	js     801a62 <vprintfmt+0x1e5>
  801aaa:	ff 4d e0             	decl   -0x20(%ebp)
  801aad:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801ab1:	79 af                	jns    801a62 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ab3:	eb 13                	jmp    801ac8 <vprintfmt+0x24b>
				putch(' ', putdat);
  801ab5:	83 ec 08             	sub    $0x8,%esp
  801ab8:	ff 75 0c             	pushl  0xc(%ebp)
  801abb:	6a 20                	push   $0x20
  801abd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac0:	ff d0                	call   *%eax
  801ac2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ac5:	ff 4d e4             	decl   -0x1c(%ebp)
  801ac8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801acc:	7f e7                	jg     801ab5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801ace:	e9 66 01 00 00       	jmp    801c39 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801ad3:	83 ec 08             	sub    $0x8,%esp
  801ad6:	ff 75 e8             	pushl  -0x18(%ebp)
  801ad9:	8d 45 14             	lea    0x14(%ebp),%eax
  801adc:	50                   	push   %eax
  801add:	e8 3c fd ff ff       	call   80181e <getint>
  801ae2:	83 c4 10             	add    $0x10,%esp
  801ae5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ae8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801af1:	85 d2                	test   %edx,%edx
  801af3:	79 23                	jns    801b18 <vprintfmt+0x29b>
				putch('-', putdat);
  801af5:	83 ec 08             	sub    $0x8,%esp
  801af8:	ff 75 0c             	pushl  0xc(%ebp)
  801afb:	6a 2d                	push   $0x2d
  801afd:	8b 45 08             	mov    0x8(%ebp),%eax
  801b00:	ff d0                	call   *%eax
  801b02:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b0b:	f7 d8                	neg    %eax
  801b0d:	83 d2 00             	adc    $0x0,%edx
  801b10:	f7 da                	neg    %edx
  801b12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b15:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801b18:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801b1f:	e9 bc 00 00 00       	jmp    801be0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801b24:	83 ec 08             	sub    $0x8,%esp
  801b27:	ff 75 e8             	pushl  -0x18(%ebp)
  801b2a:	8d 45 14             	lea    0x14(%ebp),%eax
  801b2d:	50                   	push   %eax
  801b2e:	e8 84 fc ff ff       	call   8017b7 <getuint>
  801b33:	83 c4 10             	add    $0x10,%esp
  801b36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b39:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801b3c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801b43:	e9 98 00 00 00       	jmp    801be0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801b48:	83 ec 08             	sub    $0x8,%esp
  801b4b:	ff 75 0c             	pushl  0xc(%ebp)
  801b4e:	6a 58                	push   $0x58
  801b50:	8b 45 08             	mov    0x8(%ebp),%eax
  801b53:	ff d0                	call   *%eax
  801b55:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801b58:	83 ec 08             	sub    $0x8,%esp
  801b5b:	ff 75 0c             	pushl  0xc(%ebp)
  801b5e:	6a 58                	push   $0x58
  801b60:	8b 45 08             	mov    0x8(%ebp),%eax
  801b63:	ff d0                	call   *%eax
  801b65:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801b68:	83 ec 08             	sub    $0x8,%esp
  801b6b:	ff 75 0c             	pushl  0xc(%ebp)
  801b6e:	6a 58                	push   $0x58
  801b70:	8b 45 08             	mov    0x8(%ebp),%eax
  801b73:	ff d0                	call   *%eax
  801b75:	83 c4 10             	add    $0x10,%esp
			break;
  801b78:	e9 bc 00 00 00       	jmp    801c39 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801b7d:	83 ec 08             	sub    $0x8,%esp
  801b80:	ff 75 0c             	pushl  0xc(%ebp)
  801b83:	6a 30                	push   $0x30
  801b85:	8b 45 08             	mov    0x8(%ebp),%eax
  801b88:	ff d0                	call   *%eax
  801b8a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801b8d:	83 ec 08             	sub    $0x8,%esp
  801b90:	ff 75 0c             	pushl  0xc(%ebp)
  801b93:	6a 78                	push   $0x78
  801b95:	8b 45 08             	mov    0x8(%ebp),%eax
  801b98:	ff d0                	call   *%eax
  801b9a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801b9d:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba0:	83 c0 04             	add    $0x4,%eax
  801ba3:	89 45 14             	mov    %eax,0x14(%ebp)
  801ba6:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba9:	83 e8 04             	sub    $0x4,%eax
  801bac:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801bae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801bb1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801bb8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801bbf:	eb 1f                	jmp    801be0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801bc1:	83 ec 08             	sub    $0x8,%esp
  801bc4:	ff 75 e8             	pushl  -0x18(%ebp)
  801bc7:	8d 45 14             	lea    0x14(%ebp),%eax
  801bca:	50                   	push   %eax
  801bcb:	e8 e7 fb ff ff       	call   8017b7 <getuint>
  801bd0:	83 c4 10             	add    $0x10,%esp
  801bd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801bd6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801bd9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801be0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801be4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801be7:	83 ec 04             	sub    $0x4,%esp
  801bea:	52                   	push   %edx
  801beb:	ff 75 e4             	pushl  -0x1c(%ebp)
  801bee:	50                   	push   %eax
  801bef:	ff 75 f4             	pushl  -0xc(%ebp)
  801bf2:	ff 75 f0             	pushl  -0x10(%ebp)
  801bf5:	ff 75 0c             	pushl  0xc(%ebp)
  801bf8:	ff 75 08             	pushl  0x8(%ebp)
  801bfb:	e8 00 fb ff ff       	call   801700 <printnum>
  801c00:	83 c4 20             	add    $0x20,%esp
			break;
  801c03:	eb 34                	jmp    801c39 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801c05:	83 ec 08             	sub    $0x8,%esp
  801c08:	ff 75 0c             	pushl  0xc(%ebp)
  801c0b:	53                   	push   %ebx
  801c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0f:	ff d0                	call   *%eax
  801c11:	83 c4 10             	add    $0x10,%esp
			break;
  801c14:	eb 23                	jmp    801c39 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801c16:	83 ec 08             	sub    $0x8,%esp
  801c19:	ff 75 0c             	pushl  0xc(%ebp)
  801c1c:	6a 25                	push   $0x25
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	ff d0                	call   *%eax
  801c23:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801c26:	ff 4d 10             	decl   0x10(%ebp)
  801c29:	eb 03                	jmp    801c2e <vprintfmt+0x3b1>
  801c2b:	ff 4d 10             	decl   0x10(%ebp)
  801c2e:	8b 45 10             	mov    0x10(%ebp),%eax
  801c31:	48                   	dec    %eax
  801c32:	8a 00                	mov    (%eax),%al
  801c34:	3c 25                	cmp    $0x25,%al
  801c36:	75 f3                	jne    801c2b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801c38:	90                   	nop
		}
	}
  801c39:	e9 47 fc ff ff       	jmp    801885 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801c3e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801c3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c42:	5b                   	pop    %ebx
  801c43:	5e                   	pop    %esi
  801c44:	5d                   	pop    %ebp
  801c45:	c3                   	ret    

00801c46 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
  801c49:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801c4c:	8d 45 10             	lea    0x10(%ebp),%eax
  801c4f:	83 c0 04             	add    $0x4,%eax
  801c52:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801c55:	8b 45 10             	mov    0x10(%ebp),%eax
  801c58:	ff 75 f4             	pushl  -0xc(%ebp)
  801c5b:	50                   	push   %eax
  801c5c:	ff 75 0c             	pushl  0xc(%ebp)
  801c5f:	ff 75 08             	pushl  0x8(%ebp)
  801c62:	e8 16 fc ff ff       	call   80187d <vprintfmt>
  801c67:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801c6a:	90                   	nop
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c73:	8b 40 08             	mov    0x8(%eax),%eax
  801c76:	8d 50 01             	lea    0x1(%eax),%edx
  801c79:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c7c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c82:	8b 10                	mov    (%eax),%edx
  801c84:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c87:	8b 40 04             	mov    0x4(%eax),%eax
  801c8a:	39 c2                	cmp    %eax,%edx
  801c8c:	73 12                	jae    801ca0 <sprintputch+0x33>
		*b->buf++ = ch;
  801c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c91:	8b 00                	mov    (%eax),%eax
  801c93:	8d 48 01             	lea    0x1(%eax),%ecx
  801c96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c99:	89 0a                	mov    %ecx,(%edx)
  801c9b:	8b 55 08             	mov    0x8(%ebp),%edx
  801c9e:	88 10                	mov    %dl,(%eax)
}
  801ca0:	90                   	nop
  801ca1:	5d                   	pop    %ebp
  801ca2:	c3                   	ret    

00801ca3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
  801ca6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801caf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cb2:	8d 50 ff             	lea    -0x1(%eax),%edx
  801cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb8:	01 d0                	add    %edx,%eax
  801cba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cbd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801cc4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801cc8:	74 06                	je     801cd0 <vsnprintf+0x2d>
  801cca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801cce:	7f 07                	jg     801cd7 <vsnprintf+0x34>
		return -E_INVAL;
  801cd0:	b8 03 00 00 00       	mov    $0x3,%eax
  801cd5:	eb 20                	jmp    801cf7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801cd7:	ff 75 14             	pushl  0x14(%ebp)
  801cda:	ff 75 10             	pushl  0x10(%ebp)
  801cdd:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801ce0:	50                   	push   %eax
  801ce1:	68 6d 1c 80 00       	push   $0x801c6d
  801ce6:	e8 92 fb ff ff       	call   80187d <vprintfmt>
  801ceb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801cee:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801cf1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801cf7:	c9                   	leave  
  801cf8:	c3                   	ret    

00801cf9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
  801cfc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801cff:	8d 45 10             	lea    0x10(%ebp),%eax
  801d02:	83 c0 04             	add    $0x4,%eax
  801d05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801d08:	8b 45 10             	mov    0x10(%ebp),%eax
  801d0b:	ff 75 f4             	pushl  -0xc(%ebp)
  801d0e:	50                   	push   %eax
  801d0f:	ff 75 0c             	pushl  0xc(%ebp)
  801d12:	ff 75 08             	pushl  0x8(%ebp)
  801d15:	e8 89 ff ff ff       	call   801ca3 <vsnprintf>
  801d1a:	83 c4 10             	add    $0x10,%esp
  801d1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801d20:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d23:	c9                   	leave  
  801d24:	c3                   	ret    

00801d25 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801d25:	55                   	push   %ebp
  801d26:	89 e5                	mov    %esp,%ebp
  801d28:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801d2b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d32:	eb 06                	jmp    801d3a <strlen+0x15>
		n++;
  801d34:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801d37:	ff 45 08             	incl   0x8(%ebp)
  801d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3d:	8a 00                	mov    (%eax),%al
  801d3f:	84 c0                	test   %al,%al
  801d41:	75 f1                	jne    801d34 <strlen+0xf>
		n++;
	return n;
  801d43:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
  801d4b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801d4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d55:	eb 09                	jmp    801d60 <strnlen+0x18>
		n++;
  801d57:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801d5a:	ff 45 08             	incl   0x8(%ebp)
  801d5d:	ff 4d 0c             	decl   0xc(%ebp)
  801d60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801d64:	74 09                	je     801d6f <strnlen+0x27>
  801d66:	8b 45 08             	mov    0x8(%ebp),%eax
  801d69:	8a 00                	mov    (%eax),%al
  801d6b:	84 c0                	test   %al,%al
  801d6d:	75 e8                	jne    801d57 <strnlen+0xf>
		n++;
	return n;
  801d6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801d72:	c9                   	leave  
  801d73:	c3                   	ret    

00801d74 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801d74:	55                   	push   %ebp
  801d75:	89 e5                	mov    %esp,%ebp
  801d77:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801d80:	90                   	nop
  801d81:	8b 45 08             	mov    0x8(%ebp),%eax
  801d84:	8d 50 01             	lea    0x1(%eax),%edx
  801d87:	89 55 08             	mov    %edx,0x8(%ebp)
  801d8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801d90:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801d93:	8a 12                	mov    (%edx),%dl
  801d95:	88 10                	mov    %dl,(%eax)
  801d97:	8a 00                	mov    (%eax),%al
  801d99:	84 c0                	test   %al,%al
  801d9b:	75 e4                	jne    801d81 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801d9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801da0:	c9                   	leave  
  801da1:	c3                   	ret    

00801da2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801da2:	55                   	push   %ebp
  801da3:	89 e5                	mov    %esp,%ebp
  801da5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801da8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dab:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801dae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801db5:	eb 1f                	jmp    801dd6 <strncpy+0x34>
		*dst++ = *src;
  801db7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dba:	8d 50 01             	lea    0x1(%eax),%edx
  801dbd:	89 55 08             	mov    %edx,0x8(%ebp)
  801dc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc3:	8a 12                	mov    (%edx),%dl
  801dc5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dca:	8a 00                	mov    (%eax),%al
  801dcc:	84 c0                	test   %al,%al
  801dce:	74 03                	je     801dd3 <strncpy+0x31>
			src++;
  801dd0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801dd3:	ff 45 fc             	incl   -0x4(%ebp)
  801dd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801dd9:	3b 45 10             	cmp    0x10(%ebp),%eax
  801ddc:	72 d9                	jb     801db7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801dde:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801de1:	c9                   	leave  
  801de2:	c3                   	ret    

00801de3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801de3:	55                   	push   %ebp
  801de4:	89 e5                	mov    %esp,%ebp
  801de6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801de9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801def:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801df3:	74 30                	je     801e25 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801df5:	eb 16                	jmp    801e0d <strlcpy+0x2a>
			*dst++ = *src++;
  801df7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfa:	8d 50 01             	lea    0x1(%eax),%edx
  801dfd:	89 55 08             	mov    %edx,0x8(%ebp)
  801e00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e03:	8d 4a 01             	lea    0x1(%edx),%ecx
  801e06:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801e09:	8a 12                	mov    (%edx),%dl
  801e0b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801e0d:	ff 4d 10             	decl   0x10(%ebp)
  801e10:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e14:	74 09                	je     801e1f <strlcpy+0x3c>
  801e16:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e19:	8a 00                	mov    (%eax),%al
  801e1b:	84 c0                	test   %al,%al
  801e1d:	75 d8                	jne    801df7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e22:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801e25:	8b 55 08             	mov    0x8(%ebp),%edx
  801e28:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e2b:	29 c2                	sub    %eax,%edx
  801e2d:	89 d0                	mov    %edx,%eax
}
  801e2f:	c9                   	leave  
  801e30:	c3                   	ret    

00801e31 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801e31:	55                   	push   %ebp
  801e32:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801e34:	eb 06                	jmp    801e3c <strcmp+0xb>
		p++, q++;
  801e36:	ff 45 08             	incl   0x8(%ebp)
  801e39:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	8a 00                	mov    (%eax),%al
  801e41:	84 c0                	test   %al,%al
  801e43:	74 0e                	je     801e53 <strcmp+0x22>
  801e45:	8b 45 08             	mov    0x8(%ebp),%eax
  801e48:	8a 10                	mov    (%eax),%dl
  801e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e4d:	8a 00                	mov    (%eax),%al
  801e4f:	38 c2                	cmp    %al,%dl
  801e51:	74 e3                	je     801e36 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801e53:	8b 45 08             	mov    0x8(%ebp),%eax
  801e56:	8a 00                	mov    (%eax),%al
  801e58:	0f b6 d0             	movzbl %al,%edx
  801e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e5e:	8a 00                	mov    (%eax),%al
  801e60:	0f b6 c0             	movzbl %al,%eax
  801e63:	29 c2                	sub    %eax,%edx
  801e65:	89 d0                	mov    %edx,%eax
}
  801e67:	5d                   	pop    %ebp
  801e68:	c3                   	ret    

00801e69 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801e69:	55                   	push   %ebp
  801e6a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801e6c:	eb 09                	jmp    801e77 <strncmp+0xe>
		n--, p++, q++;
  801e6e:	ff 4d 10             	decl   0x10(%ebp)
  801e71:	ff 45 08             	incl   0x8(%ebp)
  801e74:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801e77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e7b:	74 17                	je     801e94 <strncmp+0x2b>
  801e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e80:	8a 00                	mov    (%eax),%al
  801e82:	84 c0                	test   %al,%al
  801e84:	74 0e                	je     801e94 <strncmp+0x2b>
  801e86:	8b 45 08             	mov    0x8(%ebp),%eax
  801e89:	8a 10                	mov    (%eax),%dl
  801e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e8e:	8a 00                	mov    (%eax),%al
  801e90:	38 c2                	cmp    %al,%dl
  801e92:	74 da                	je     801e6e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801e94:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801e98:	75 07                	jne    801ea1 <strncmp+0x38>
		return 0;
  801e9a:	b8 00 00 00 00       	mov    $0x0,%eax
  801e9f:	eb 14                	jmp    801eb5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea4:	8a 00                	mov    (%eax),%al
  801ea6:	0f b6 d0             	movzbl %al,%edx
  801ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801eac:	8a 00                	mov    (%eax),%al
  801eae:	0f b6 c0             	movzbl %al,%eax
  801eb1:	29 c2                	sub    %eax,%edx
  801eb3:	89 d0                	mov    %edx,%eax
}
  801eb5:	5d                   	pop    %ebp
  801eb6:	c3                   	ret    

00801eb7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
  801eba:	83 ec 04             	sub    $0x4,%esp
  801ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ec0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801ec3:	eb 12                	jmp    801ed7 <strchr+0x20>
		if (*s == c)
  801ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec8:	8a 00                	mov    (%eax),%al
  801eca:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801ecd:	75 05                	jne    801ed4 <strchr+0x1d>
			return (char *) s;
  801ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed2:	eb 11                	jmp    801ee5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801ed4:	ff 45 08             	incl   0x8(%ebp)
  801ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eda:	8a 00                	mov    (%eax),%al
  801edc:	84 c0                	test   %al,%al
  801ede:	75 e5                	jne    801ec5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801ee0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ee5:	c9                   	leave  
  801ee6:	c3                   	ret    

00801ee7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801ee7:	55                   	push   %ebp
  801ee8:	89 e5                	mov    %esp,%ebp
  801eea:	83 ec 04             	sub    $0x4,%esp
  801eed:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ef0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801ef3:	eb 0d                	jmp    801f02 <strfind+0x1b>
		if (*s == c)
  801ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef8:	8a 00                	mov    (%eax),%al
  801efa:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801efd:	74 0e                	je     801f0d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801eff:	ff 45 08             	incl   0x8(%ebp)
  801f02:	8b 45 08             	mov    0x8(%ebp),%eax
  801f05:	8a 00                	mov    (%eax),%al
  801f07:	84 c0                	test   %al,%al
  801f09:	75 ea                	jne    801ef5 <strfind+0xe>
  801f0b:	eb 01                	jmp    801f0e <strfind+0x27>
		if (*s == c)
			break;
  801f0d:	90                   	nop
	return (char *) s;
  801f0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f11:	c9                   	leave  
  801f12:	c3                   	ret    

00801f13 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801f13:	55                   	push   %ebp
  801f14:	89 e5                	mov    %esp,%ebp
  801f16:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801f19:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801f1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f22:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801f25:	eb 0e                	jmp    801f35 <memset+0x22>
		*p++ = c;
  801f27:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f2a:	8d 50 01             	lea    0x1(%eax),%edx
  801f2d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801f30:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f33:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801f35:	ff 4d f8             	decl   -0x8(%ebp)
  801f38:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801f3c:	79 e9                	jns    801f27 <memset+0x14>
		*p++ = c;

	return v;
  801f3e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
  801f46:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f52:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801f55:	eb 16                	jmp    801f6d <memcpy+0x2a>
		*d++ = *s++;
  801f57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f5a:	8d 50 01             	lea    0x1(%eax),%edx
  801f5d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801f60:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f63:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f66:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801f69:	8a 12                	mov    (%edx),%dl
  801f6b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801f6d:	8b 45 10             	mov    0x10(%ebp),%eax
  801f70:	8d 50 ff             	lea    -0x1(%eax),%edx
  801f73:	89 55 10             	mov    %edx,0x10(%ebp)
  801f76:	85 c0                	test   %eax,%eax
  801f78:	75 dd                	jne    801f57 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801f7a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f7d:	c9                   	leave  
  801f7e:	c3                   	ret    

00801f7f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801f7f:	55                   	push   %ebp
  801f80:	89 e5                	mov    %esp,%ebp
  801f82:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801f85:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801f91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f94:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801f97:	73 50                	jae    801fe9 <memmove+0x6a>
  801f99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f9c:	8b 45 10             	mov    0x10(%ebp),%eax
  801f9f:	01 d0                	add    %edx,%eax
  801fa1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801fa4:	76 43                	jbe    801fe9 <memmove+0x6a>
		s += n;
  801fa6:	8b 45 10             	mov    0x10(%ebp),%eax
  801fa9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801fac:	8b 45 10             	mov    0x10(%ebp),%eax
  801faf:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801fb2:	eb 10                	jmp    801fc4 <memmove+0x45>
			*--d = *--s;
  801fb4:	ff 4d f8             	decl   -0x8(%ebp)
  801fb7:	ff 4d fc             	decl   -0x4(%ebp)
  801fba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801fbd:	8a 10                	mov    (%eax),%dl
  801fbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fc2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801fc4:	8b 45 10             	mov    0x10(%ebp),%eax
  801fc7:	8d 50 ff             	lea    -0x1(%eax),%edx
  801fca:	89 55 10             	mov    %edx,0x10(%ebp)
  801fcd:	85 c0                	test   %eax,%eax
  801fcf:	75 e3                	jne    801fb4 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801fd1:	eb 23                	jmp    801ff6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801fd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fd6:	8d 50 01             	lea    0x1(%eax),%edx
  801fd9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801fdc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fdf:	8d 4a 01             	lea    0x1(%edx),%ecx
  801fe2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801fe5:	8a 12                	mov    (%edx),%dl
  801fe7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  801fec:	8d 50 ff             	lea    -0x1(%eax),%edx
  801fef:	89 55 10             	mov    %edx,0x10(%ebp)
  801ff2:	85 c0                	test   %eax,%eax
  801ff4:	75 dd                	jne    801fd3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801ff6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801ff9:	c9                   	leave  
  801ffa:	c3                   	ret    

00801ffb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801ffb:	55                   	push   %ebp
  801ffc:	89 e5                	mov    %esp,%ebp
  801ffe:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802001:	8b 45 08             	mov    0x8(%ebp),%eax
  802004:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802007:	8b 45 0c             	mov    0xc(%ebp),%eax
  80200a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80200d:	eb 2a                	jmp    802039 <memcmp+0x3e>
		if (*s1 != *s2)
  80200f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802012:	8a 10                	mov    (%eax),%dl
  802014:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802017:	8a 00                	mov    (%eax),%al
  802019:	38 c2                	cmp    %al,%dl
  80201b:	74 16                	je     802033 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80201d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802020:	8a 00                	mov    (%eax),%al
  802022:	0f b6 d0             	movzbl %al,%edx
  802025:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802028:	8a 00                	mov    (%eax),%al
  80202a:	0f b6 c0             	movzbl %al,%eax
  80202d:	29 c2                	sub    %eax,%edx
  80202f:	89 d0                	mov    %edx,%eax
  802031:	eb 18                	jmp    80204b <memcmp+0x50>
		s1++, s2++;
  802033:	ff 45 fc             	incl   -0x4(%ebp)
  802036:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802039:	8b 45 10             	mov    0x10(%ebp),%eax
  80203c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80203f:	89 55 10             	mov    %edx,0x10(%ebp)
  802042:	85 c0                	test   %eax,%eax
  802044:	75 c9                	jne    80200f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802046:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80204b:	c9                   	leave  
  80204c:	c3                   	ret    

0080204d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80204d:	55                   	push   %ebp
  80204e:	89 e5                	mov    %esp,%ebp
  802050:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802053:	8b 55 08             	mov    0x8(%ebp),%edx
  802056:	8b 45 10             	mov    0x10(%ebp),%eax
  802059:	01 d0                	add    %edx,%eax
  80205b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80205e:	eb 15                	jmp    802075 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802060:	8b 45 08             	mov    0x8(%ebp),%eax
  802063:	8a 00                	mov    (%eax),%al
  802065:	0f b6 d0             	movzbl %al,%edx
  802068:	8b 45 0c             	mov    0xc(%ebp),%eax
  80206b:	0f b6 c0             	movzbl %al,%eax
  80206e:	39 c2                	cmp    %eax,%edx
  802070:	74 0d                	je     80207f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802072:	ff 45 08             	incl   0x8(%ebp)
  802075:	8b 45 08             	mov    0x8(%ebp),%eax
  802078:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80207b:	72 e3                	jb     802060 <memfind+0x13>
  80207d:	eb 01                	jmp    802080 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80207f:	90                   	nop
	return (void *) s;
  802080:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802083:	c9                   	leave  
  802084:	c3                   	ret    

00802085 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802085:	55                   	push   %ebp
  802086:	89 e5                	mov    %esp,%ebp
  802088:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80208b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802092:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802099:	eb 03                	jmp    80209e <strtol+0x19>
		s++;
  80209b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80209e:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a1:	8a 00                	mov    (%eax),%al
  8020a3:	3c 20                	cmp    $0x20,%al
  8020a5:	74 f4                	je     80209b <strtol+0x16>
  8020a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020aa:	8a 00                	mov    (%eax),%al
  8020ac:	3c 09                	cmp    $0x9,%al
  8020ae:	74 eb                	je     80209b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8020b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b3:	8a 00                	mov    (%eax),%al
  8020b5:	3c 2b                	cmp    $0x2b,%al
  8020b7:	75 05                	jne    8020be <strtol+0x39>
		s++;
  8020b9:	ff 45 08             	incl   0x8(%ebp)
  8020bc:	eb 13                	jmp    8020d1 <strtol+0x4c>
	else if (*s == '-')
  8020be:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c1:	8a 00                	mov    (%eax),%al
  8020c3:	3c 2d                	cmp    $0x2d,%al
  8020c5:	75 0a                	jne    8020d1 <strtol+0x4c>
		s++, neg = 1;
  8020c7:	ff 45 08             	incl   0x8(%ebp)
  8020ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8020d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8020d5:	74 06                	je     8020dd <strtol+0x58>
  8020d7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8020db:	75 20                	jne    8020fd <strtol+0x78>
  8020dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e0:	8a 00                	mov    (%eax),%al
  8020e2:	3c 30                	cmp    $0x30,%al
  8020e4:	75 17                	jne    8020fd <strtol+0x78>
  8020e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e9:	40                   	inc    %eax
  8020ea:	8a 00                	mov    (%eax),%al
  8020ec:	3c 78                	cmp    $0x78,%al
  8020ee:	75 0d                	jne    8020fd <strtol+0x78>
		s += 2, base = 16;
  8020f0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8020f4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8020fb:	eb 28                	jmp    802125 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8020fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802101:	75 15                	jne    802118 <strtol+0x93>
  802103:	8b 45 08             	mov    0x8(%ebp),%eax
  802106:	8a 00                	mov    (%eax),%al
  802108:	3c 30                	cmp    $0x30,%al
  80210a:	75 0c                	jne    802118 <strtol+0x93>
		s++, base = 8;
  80210c:	ff 45 08             	incl   0x8(%ebp)
  80210f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802116:	eb 0d                	jmp    802125 <strtol+0xa0>
	else if (base == 0)
  802118:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80211c:	75 07                	jne    802125 <strtol+0xa0>
		base = 10;
  80211e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802125:	8b 45 08             	mov    0x8(%ebp),%eax
  802128:	8a 00                	mov    (%eax),%al
  80212a:	3c 2f                	cmp    $0x2f,%al
  80212c:	7e 19                	jle    802147 <strtol+0xc2>
  80212e:	8b 45 08             	mov    0x8(%ebp),%eax
  802131:	8a 00                	mov    (%eax),%al
  802133:	3c 39                	cmp    $0x39,%al
  802135:	7f 10                	jg     802147 <strtol+0xc2>
			dig = *s - '0';
  802137:	8b 45 08             	mov    0x8(%ebp),%eax
  80213a:	8a 00                	mov    (%eax),%al
  80213c:	0f be c0             	movsbl %al,%eax
  80213f:	83 e8 30             	sub    $0x30,%eax
  802142:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802145:	eb 42                	jmp    802189 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802147:	8b 45 08             	mov    0x8(%ebp),%eax
  80214a:	8a 00                	mov    (%eax),%al
  80214c:	3c 60                	cmp    $0x60,%al
  80214e:	7e 19                	jle    802169 <strtol+0xe4>
  802150:	8b 45 08             	mov    0x8(%ebp),%eax
  802153:	8a 00                	mov    (%eax),%al
  802155:	3c 7a                	cmp    $0x7a,%al
  802157:	7f 10                	jg     802169 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802159:	8b 45 08             	mov    0x8(%ebp),%eax
  80215c:	8a 00                	mov    (%eax),%al
  80215e:	0f be c0             	movsbl %al,%eax
  802161:	83 e8 57             	sub    $0x57,%eax
  802164:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802167:	eb 20                	jmp    802189 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  802169:	8b 45 08             	mov    0x8(%ebp),%eax
  80216c:	8a 00                	mov    (%eax),%al
  80216e:	3c 40                	cmp    $0x40,%al
  802170:	7e 39                	jle    8021ab <strtol+0x126>
  802172:	8b 45 08             	mov    0x8(%ebp),%eax
  802175:	8a 00                	mov    (%eax),%al
  802177:	3c 5a                	cmp    $0x5a,%al
  802179:	7f 30                	jg     8021ab <strtol+0x126>
			dig = *s - 'A' + 10;
  80217b:	8b 45 08             	mov    0x8(%ebp),%eax
  80217e:	8a 00                	mov    (%eax),%al
  802180:	0f be c0             	movsbl %al,%eax
  802183:	83 e8 37             	sub    $0x37,%eax
  802186:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802189:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80218c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80218f:	7d 19                	jge    8021aa <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802191:	ff 45 08             	incl   0x8(%ebp)
  802194:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802197:	0f af 45 10          	imul   0x10(%ebp),%eax
  80219b:	89 c2                	mov    %eax,%edx
  80219d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021a0:	01 d0                	add    %edx,%eax
  8021a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8021a5:	e9 7b ff ff ff       	jmp    802125 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8021aa:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8021ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8021af:	74 08                	je     8021b9 <strtol+0x134>
		*endptr = (char *) s;
  8021b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8021b7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8021b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8021bd:	74 07                	je     8021c6 <strtol+0x141>
  8021bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021c2:	f7 d8                	neg    %eax
  8021c4:	eb 03                	jmp    8021c9 <strtol+0x144>
  8021c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8021c9:	c9                   	leave  
  8021ca:	c3                   	ret    

008021cb <ltostr>:

void
ltostr(long value, char *str)
{
  8021cb:	55                   	push   %ebp
  8021cc:	89 e5                	mov    %esp,%ebp
  8021ce:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8021d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8021d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8021df:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8021e3:	79 13                	jns    8021f8 <ltostr+0x2d>
	{
		neg = 1;
  8021e5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8021ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021ef:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8021f2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8021f5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8021f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802200:	99                   	cltd   
  802201:	f7 f9                	idiv   %ecx
  802203:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802206:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802209:	8d 50 01             	lea    0x1(%eax),%edx
  80220c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80220f:	89 c2                	mov    %eax,%edx
  802211:	8b 45 0c             	mov    0xc(%ebp),%eax
  802214:	01 d0                	add    %edx,%eax
  802216:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802219:	83 c2 30             	add    $0x30,%edx
  80221c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80221e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802221:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802226:	f7 e9                	imul   %ecx
  802228:	c1 fa 02             	sar    $0x2,%edx
  80222b:	89 c8                	mov    %ecx,%eax
  80222d:	c1 f8 1f             	sar    $0x1f,%eax
  802230:	29 c2                	sub    %eax,%edx
  802232:	89 d0                	mov    %edx,%eax
  802234:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802237:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80223a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80223f:	f7 e9                	imul   %ecx
  802241:	c1 fa 02             	sar    $0x2,%edx
  802244:	89 c8                	mov    %ecx,%eax
  802246:	c1 f8 1f             	sar    $0x1f,%eax
  802249:	29 c2                	sub    %eax,%edx
  80224b:	89 d0                	mov    %edx,%eax
  80224d:	c1 e0 02             	shl    $0x2,%eax
  802250:	01 d0                	add    %edx,%eax
  802252:	01 c0                	add    %eax,%eax
  802254:	29 c1                	sub    %eax,%ecx
  802256:	89 ca                	mov    %ecx,%edx
  802258:	85 d2                	test   %edx,%edx
  80225a:	75 9c                	jne    8021f8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80225c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802263:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802266:	48                   	dec    %eax
  802267:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80226a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80226e:	74 3d                	je     8022ad <ltostr+0xe2>
		start = 1 ;
  802270:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802277:	eb 34                	jmp    8022ad <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802279:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80227c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80227f:	01 d0                	add    %edx,%eax
  802281:	8a 00                	mov    (%eax),%al
  802283:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802286:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80228c:	01 c2                	add    %eax,%edx
  80228e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802291:	8b 45 0c             	mov    0xc(%ebp),%eax
  802294:	01 c8                	add    %ecx,%eax
  802296:	8a 00                	mov    (%eax),%al
  802298:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80229a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80229d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022a0:	01 c2                	add    %eax,%edx
  8022a2:	8a 45 eb             	mov    -0x15(%ebp),%al
  8022a5:	88 02                	mov    %al,(%edx)
		start++ ;
  8022a7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8022aa:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8022ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022b0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8022b3:	7c c4                	jl     802279 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8022b5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8022b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022bb:	01 d0                	add    %edx,%eax
  8022bd:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8022c0:	90                   	nop
  8022c1:	c9                   	leave  
  8022c2:	c3                   	ret    

008022c3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8022c3:	55                   	push   %ebp
  8022c4:	89 e5                	mov    %esp,%ebp
  8022c6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8022c9:	ff 75 08             	pushl  0x8(%ebp)
  8022cc:	e8 54 fa ff ff       	call   801d25 <strlen>
  8022d1:	83 c4 04             	add    $0x4,%esp
  8022d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8022d7:	ff 75 0c             	pushl  0xc(%ebp)
  8022da:	e8 46 fa ff ff       	call   801d25 <strlen>
  8022df:	83 c4 04             	add    $0x4,%esp
  8022e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8022e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8022ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8022f3:	eb 17                	jmp    80230c <strcconcat+0x49>
		final[s] = str1[s] ;
  8022f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8022fb:	01 c2                	add    %eax,%edx
  8022fd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802300:	8b 45 08             	mov    0x8(%ebp),%eax
  802303:	01 c8                	add    %ecx,%eax
  802305:	8a 00                	mov    (%eax),%al
  802307:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802309:	ff 45 fc             	incl   -0x4(%ebp)
  80230c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80230f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802312:	7c e1                	jl     8022f5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802314:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80231b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  802322:	eb 1f                	jmp    802343 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802324:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802327:	8d 50 01             	lea    0x1(%eax),%edx
  80232a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80232d:	89 c2                	mov    %eax,%edx
  80232f:	8b 45 10             	mov    0x10(%ebp),%eax
  802332:	01 c2                	add    %eax,%edx
  802334:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802337:	8b 45 0c             	mov    0xc(%ebp),%eax
  80233a:	01 c8                	add    %ecx,%eax
  80233c:	8a 00                	mov    (%eax),%al
  80233e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  802340:	ff 45 f8             	incl   -0x8(%ebp)
  802343:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802346:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802349:	7c d9                	jl     802324 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80234b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80234e:	8b 45 10             	mov    0x10(%ebp),%eax
  802351:	01 d0                	add    %edx,%eax
  802353:	c6 00 00             	movb   $0x0,(%eax)
}
  802356:	90                   	nop
  802357:	c9                   	leave  
  802358:	c3                   	ret    

00802359 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802359:	55                   	push   %ebp
  80235a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80235c:	8b 45 14             	mov    0x14(%ebp),%eax
  80235f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802365:	8b 45 14             	mov    0x14(%ebp),%eax
  802368:	8b 00                	mov    (%eax),%eax
  80236a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802371:	8b 45 10             	mov    0x10(%ebp),%eax
  802374:	01 d0                	add    %edx,%eax
  802376:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80237c:	eb 0c                	jmp    80238a <strsplit+0x31>
			*string++ = 0;
  80237e:	8b 45 08             	mov    0x8(%ebp),%eax
  802381:	8d 50 01             	lea    0x1(%eax),%edx
  802384:	89 55 08             	mov    %edx,0x8(%ebp)
  802387:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80238a:	8b 45 08             	mov    0x8(%ebp),%eax
  80238d:	8a 00                	mov    (%eax),%al
  80238f:	84 c0                	test   %al,%al
  802391:	74 18                	je     8023ab <strsplit+0x52>
  802393:	8b 45 08             	mov    0x8(%ebp),%eax
  802396:	8a 00                	mov    (%eax),%al
  802398:	0f be c0             	movsbl %al,%eax
  80239b:	50                   	push   %eax
  80239c:	ff 75 0c             	pushl  0xc(%ebp)
  80239f:	e8 13 fb ff ff       	call   801eb7 <strchr>
  8023a4:	83 c4 08             	add    $0x8,%esp
  8023a7:	85 c0                	test   %eax,%eax
  8023a9:	75 d3                	jne    80237e <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8023ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ae:	8a 00                	mov    (%eax),%al
  8023b0:	84 c0                	test   %al,%al
  8023b2:	74 5a                	je     80240e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8023b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8023b7:	8b 00                	mov    (%eax),%eax
  8023b9:	83 f8 0f             	cmp    $0xf,%eax
  8023bc:	75 07                	jne    8023c5 <strsplit+0x6c>
		{
			return 0;
  8023be:	b8 00 00 00 00       	mov    $0x0,%eax
  8023c3:	eb 66                	jmp    80242b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8023c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8023c8:	8b 00                	mov    (%eax),%eax
  8023ca:	8d 48 01             	lea    0x1(%eax),%ecx
  8023cd:	8b 55 14             	mov    0x14(%ebp),%edx
  8023d0:	89 0a                	mov    %ecx,(%edx)
  8023d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8023d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8023dc:	01 c2                	add    %eax,%edx
  8023de:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8023e3:	eb 03                	jmp    8023e8 <strsplit+0x8f>
			string++;
  8023e5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8023e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023eb:	8a 00                	mov    (%eax),%al
  8023ed:	84 c0                	test   %al,%al
  8023ef:	74 8b                	je     80237c <strsplit+0x23>
  8023f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f4:	8a 00                	mov    (%eax),%al
  8023f6:	0f be c0             	movsbl %al,%eax
  8023f9:	50                   	push   %eax
  8023fa:	ff 75 0c             	pushl  0xc(%ebp)
  8023fd:	e8 b5 fa ff ff       	call   801eb7 <strchr>
  802402:	83 c4 08             	add    $0x8,%esp
  802405:	85 c0                	test   %eax,%eax
  802407:	74 dc                	je     8023e5 <strsplit+0x8c>
			string++;
	}
  802409:	e9 6e ff ff ff       	jmp    80237c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80240e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80240f:	8b 45 14             	mov    0x14(%ebp),%eax
  802412:	8b 00                	mov    (%eax),%eax
  802414:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80241b:	8b 45 10             	mov    0x10(%ebp),%eax
  80241e:	01 d0                	add    %edx,%eax
  802420:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802426:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80242b:	c9                   	leave  
  80242c:	c3                   	ret    

0080242d <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80242d:	55                   	push   %ebp
  80242e:	89 e5                	mov    %esp,%ebp
  802430:	83 ec 18             	sub    $0x18,%esp
  802433:	8b 45 10             	mov    0x10(%ebp),%eax
  802436:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  802439:	83 ec 04             	sub    $0x4,%esp
  80243c:	68 10 39 80 00       	push   $0x803910
  802441:	6a 17                	push   $0x17
  802443:	68 2f 39 80 00       	push   $0x80392f
  802448:	e8 a2 ef ff ff       	call   8013ef <_panic>

0080244d <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80244d:	55                   	push   %ebp
  80244e:	89 e5                	mov    %esp,%ebp
  802450:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  802453:	83 ec 04             	sub    $0x4,%esp
  802456:	68 3b 39 80 00       	push   $0x80393b
  80245b:	6a 2f                	push   $0x2f
  80245d:	68 2f 39 80 00       	push   $0x80392f
  802462:	e8 88 ef ff ff       	call   8013ef <_panic>

00802467 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  802467:	55                   	push   %ebp
  802468:	89 e5                	mov    %esp,%ebp
  80246a:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80246d:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  802474:	8b 55 08             	mov    0x8(%ebp),%edx
  802477:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80247a:	01 d0                	add    %edx,%eax
  80247c:	48                   	dec    %eax
  80247d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  802480:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802483:	ba 00 00 00 00       	mov    $0x0,%edx
  802488:	f7 75 ec             	divl   -0x14(%ebp)
  80248b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80248e:	29 d0                	sub    %edx,%eax
  802490:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  802493:	8b 45 08             	mov    0x8(%ebp),%eax
  802496:	c1 e8 0c             	shr    $0xc,%eax
  802499:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80249c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8024a3:	e9 c8 00 00 00       	jmp    802570 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8024a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8024af:	eb 27                	jmp    8024d8 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8024b1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8024b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024b7:	01 c2                	add    %eax,%edx
  8024b9:	89 d0                	mov    %edx,%eax
  8024bb:	01 c0                	add    %eax,%eax
  8024bd:	01 d0                	add    %edx,%eax
  8024bf:	c1 e0 02             	shl    $0x2,%eax
  8024c2:	05 48 40 80 00       	add    $0x804048,%eax
  8024c7:	8b 00                	mov    (%eax),%eax
  8024c9:	85 c0                	test   %eax,%eax
  8024cb:	74 08                	je     8024d5 <malloc+0x6e>
            	i += j;
  8024cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8024d0:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  8024d3:	eb 0b                	jmp    8024e0 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  8024d5:	ff 45 f0             	incl   -0x10(%ebp)
  8024d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8024db:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8024de:	72 d1                	jb     8024b1 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  8024e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8024e3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8024e6:	0f 85 81 00 00 00    	jne    80256d <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  8024ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024ef:	05 00 00 08 00       	add    $0x80000,%eax
  8024f4:	c1 e0 0c             	shl    $0xc,%eax
  8024f7:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  8024fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802501:	eb 1f                	jmp    802522 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  802503:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802506:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802509:	01 c2                	add    %eax,%edx
  80250b:	89 d0                	mov    %edx,%eax
  80250d:	01 c0                	add    %eax,%eax
  80250f:	01 d0                	add    %edx,%eax
  802511:	c1 e0 02             	shl    $0x2,%eax
  802514:	05 48 40 80 00       	add    $0x804048,%eax
  802519:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80251f:	ff 45 f0             	incl   -0x10(%ebp)
  802522:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802525:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802528:	72 d9                	jb     802503 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80252a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80252d:	89 d0                	mov    %edx,%eax
  80252f:	01 c0                	add    %eax,%eax
  802531:	01 d0                	add    %edx,%eax
  802533:	c1 e0 02             	shl    $0x2,%eax
  802536:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  80253c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80253f:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  802541:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802544:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  802547:	89 c8                	mov    %ecx,%eax
  802549:	01 c0                	add    %eax,%eax
  80254b:	01 c8                	add    %ecx,%eax
  80254d:	c1 e0 02             	shl    $0x2,%eax
  802550:	05 44 40 80 00       	add    $0x804044,%eax
  802555:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  802557:	83 ec 08             	sub    $0x8,%esp
  80255a:	ff 75 08             	pushl  0x8(%ebp)
  80255d:	ff 75 e0             	pushl  -0x20(%ebp)
  802560:	e8 2b 03 00 00       	call   802890 <sys_allocateMem>
  802565:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  802568:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80256b:	eb 19                	jmp    802586 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80256d:	ff 45 f4             	incl   -0xc(%ebp)
  802570:	a1 04 40 80 00       	mov    0x804004,%eax
  802575:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  802578:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80257b:	0f 83 27 ff ff ff    	jae    8024a8 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  802581:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802586:	c9                   	leave  
  802587:	c3                   	ret    

00802588 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  802588:	55                   	push   %ebp
  802589:	89 e5                	mov    %esp,%ebp
  80258b:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80258e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802592:	0f 84 e5 00 00 00    	je     80267d <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  802598:	8b 45 08             	mov    0x8(%ebp),%eax
  80259b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80259e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8025a1:	05 00 00 00 80       	add    $0x80000000,%eax
  8025a6:	c1 e8 0c             	shr    $0xc,%eax
  8025a9:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8025ac:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8025af:	89 d0                	mov    %edx,%eax
  8025b1:	01 c0                	add    %eax,%eax
  8025b3:	01 d0                	add    %edx,%eax
  8025b5:	c1 e0 02             	shl    $0x2,%eax
  8025b8:	05 40 40 80 00       	add    $0x804040,%eax
  8025bd:	8b 00                	mov    (%eax),%eax
  8025bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8025c2:	0f 85 b8 00 00 00    	jne    802680 <free+0xf8>
  8025c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8025cb:	89 d0                	mov    %edx,%eax
  8025cd:	01 c0                	add    %eax,%eax
  8025cf:	01 d0                	add    %edx,%eax
  8025d1:	c1 e0 02             	shl    $0x2,%eax
  8025d4:	05 48 40 80 00       	add    $0x804048,%eax
  8025d9:	8b 00                	mov    (%eax),%eax
  8025db:	85 c0                	test   %eax,%eax
  8025dd:	0f 84 9d 00 00 00    	je     802680 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  8025e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8025e6:	89 d0                	mov    %edx,%eax
  8025e8:	01 c0                	add    %eax,%eax
  8025ea:	01 d0                	add    %edx,%eax
  8025ec:	c1 e0 02             	shl    $0x2,%eax
  8025ef:	05 44 40 80 00       	add    $0x804044,%eax
  8025f4:	8b 00                	mov    (%eax),%eax
  8025f6:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  8025f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8025fc:	c1 e0 0c             	shl    $0xc,%eax
  8025ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  802602:	83 ec 08             	sub    $0x8,%esp
  802605:	ff 75 e4             	pushl  -0x1c(%ebp)
  802608:	ff 75 f0             	pushl  -0x10(%ebp)
  80260b:	e8 64 02 00 00       	call   802874 <sys_freeMem>
  802610:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802613:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80261a:	eb 57                	jmp    802673 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80261c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80261f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802622:	01 c2                	add    %eax,%edx
  802624:	89 d0                	mov    %edx,%eax
  802626:	01 c0                	add    %eax,%eax
  802628:	01 d0                	add    %edx,%eax
  80262a:	c1 e0 02             	shl    $0x2,%eax
  80262d:	05 48 40 80 00       	add    $0x804048,%eax
  802632:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  802638:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80263b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80263e:	01 c2                	add    %eax,%edx
  802640:	89 d0                	mov    %edx,%eax
  802642:	01 c0                	add    %eax,%eax
  802644:	01 d0                	add    %edx,%eax
  802646:	c1 e0 02             	shl    $0x2,%eax
  802649:	05 40 40 80 00       	add    $0x804040,%eax
  80264e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  802654:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802657:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80265a:	01 c2                	add    %eax,%edx
  80265c:	89 d0                	mov    %edx,%eax
  80265e:	01 c0                	add    %eax,%eax
  802660:	01 d0                	add    %edx,%eax
  802662:	c1 e0 02             	shl    $0x2,%eax
  802665:	05 44 40 80 00       	add    $0x804044,%eax
  80266a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802670:	ff 45 f4             	incl   -0xc(%ebp)
  802673:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802676:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802679:	7c a1                	jl     80261c <free+0x94>
  80267b:	eb 04                	jmp    802681 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80267d:	90                   	nop
  80267e:	eb 01                	jmp    802681 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  802680:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  802681:	c9                   	leave  
  802682:	c3                   	ret    

00802683 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  802683:	55                   	push   %ebp
  802684:	89 e5                	mov    %esp,%ebp
  802686:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  802689:	83 ec 04             	sub    $0x4,%esp
  80268c:	68 58 39 80 00       	push   $0x803958
  802691:	68 ae 00 00 00       	push   $0xae
  802696:	68 2f 39 80 00       	push   $0x80392f
  80269b:	e8 4f ed ff ff       	call   8013ef <_panic>

008026a0 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8026a0:	55                   	push   %ebp
  8026a1:	89 e5                	mov    %esp,%ebp
  8026a3:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8026a6:	83 ec 04             	sub    $0x4,%esp
  8026a9:	68 78 39 80 00       	push   $0x803978
  8026ae:	68 ca 00 00 00       	push   $0xca
  8026b3:	68 2f 39 80 00       	push   $0x80392f
  8026b8:	e8 32 ed ff ff       	call   8013ef <_panic>

008026bd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8026bd:	55                   	push   %ebp
  8026be:	89 e5                	mov    %esp,%ebp
  8026c0:	57                   	push   %edi
  8026c1:	56                   	push   %esi
  8026c2:	53                   	push   %ebx
  8026c3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8026c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8026c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8026cf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8026d2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8026d5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8026d8:	cd 30                	int    $0x30
  8026da:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8026dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8026e0:	83 c4 10             	add    $0x10,%esp
  8026e3:	5b                   	pop    %ebx
  8026e4:	5e                   	pop    %esi
  8026e5:	5f                   	pop    %edi
  8026e6:	5d                   	pop    %ebp
  8026e7:	c3                   	ret    

008026e8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8026e8:	55                   	push   %ebp
  8026e9:	89 e5                	mov    %esp,%ebp
  8026eb:	83 ec 04             	sub    $0x4,%esp
  8026ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8026f1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8026f4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8026f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8026fb:	6a 00                	push   $0x0
  8026fd:	6a 00                	push   $0x0
  8026ff:	52                   	push   %edx
  802700:	ff 75 0c             	pushl  0xc(%ebp)
  802703:	50                   	push   %eax
  802704:	6a 00                	push   $0x0
  802706:	e8 b2 ff ff ff       	call   8026bd <syscall>
  80270b:	83 c4 18             	add    $0x18,%esp
}
  80270e:	90                   	nop
  80270f:	c9                   	leave  
  802710:	c3                   	ret    

00802711 <sys_cgetc>:

int
sys_cgetc(void)
{
  802711:	55                   	push   %ebp
  802712:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802714:	6a 00                	push   $0x0
  802716:	6a 00                	push   $0x0
  802718:	6a 00                	push   $0x0
  80271a:	6a 00                	push   $0x0
  80271c:	6a 00                	push   $0x0
  80271e:	6a 01                	push   $0x1
  802720:	e8 98 ff ff ff       	call   8026bd <syscall>
  802725:	83 c4 18             	add    $0x18,%esp
}
  802728:	c9                   	leave  
  802729:	c3                   	ret    

0080272a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80272a:	55                   	push   %ebp
  80272b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80272d:	8b 45 08             	mov    0x8(%ebp),%eax
  802730:	6a 00                	push   $0x0
  802732:	6a 00                	push   $0x0
  802734:	6a 00                	push   $0x0
  802736:	6a 00                	push   $0x0
  802738:	50                   	push   %eax
  802739:	6a 05                	push   $0x5
  80273b:	e8 7d ff ff ff       	call   8026bd <syscall>
  802740:	83 c4 18             	add    $0x18,%esp
}
  802743:	c9                   	leave  
  802744:	c3                   	ret    

00802745 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802745:	55                   	push   %ebp
  802746:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802748:	6a 00                	push   $0x0
  80274a:	6a 00                	push   $0x0
  80274c:	6a 00                	push   $0x0
  80274e:	6a 00                	push   $0x0
  802750:	6a 00                	push   $0x0
  802752:	6a 02                	push   $0x2
  802754:	e8 64 ff ff ff       	call   8026bd <syscall>
  802759:	83 c4 18             	add    $0x18,%esp
}
  80275c:	c9                   	leave  
  80275d:	c3                   	ret    

0080275e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80275e:	55                   	push   %ebp
  80275f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802761:	6a 00                	push   $0x0
  802763:	6a 00                	push   $0x0
  802765:	6a 00                	push   $0x0
  802767:	6a 00                	push   $0x0
  802769:	6a 00                	push   $0x0
  80276b:	6a 03                	push   $0x3
  80276d:	e8 4b ff ff ff       	call   8026bd <syscall>
  802772:	83 c4 18             	add    $0x18,%esp
}
  802775:	c9                   	leave  
  802776:	c3                   	ret    

00802777 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802777:	55                   	push   %ebp
  802778:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80277a:	6a 00                	push   $0x0
  80277c:	6a 00                	push   $0x0
  80277e:	6a 00                	push   $0x0
  802780:	6a 00                	push   $0x0
  802782:	6a 00                	push   $0x0
  802784:	6a 04                	push   $0x4
  802786:	e8 32 ff ff ff       	call   8026bd <syscall>
  80278b:	83 c4 18             	add    $0x18,%esp
}
  80278e:	c9                   	leave  
  80278f:	c3                   	ret    

00802790 <sys_env_exit>:


void sys_env_exit(void)
{
  802790:	55                   	push   %ebp
  802791:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802793:	6a 00                	push   $0x0
  802795:	6a 00                	push   $0x0
  802797:	6a 00                	push   $0x0
  802799:	6a 00                	push   $0x0
  80279b:	6a 00                	push   $0x0
  80279d:	6a 06                	push   $0x6
  80279f:	e8 19 ff ff ff       	call   8026bd <syscall>
  8027a4:	83 c4 18             	add    $0x18,%esp
}
  8027a7:	90                   	nop
  8027a8:	c9                   	leave  
  8027a9:	c3                   	ret    

008027aa <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8027aa:	55                   	push   %ebp
  8027ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8027ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8027b3:	6a 00                	push   $0x0
  8027b5:	6a 00                	push   $0x0
  8027b7:	6a 00                	push   $0x0
  8027b9:	52                   	push   %edx
  8027ba:	50                   	push   %eax
  8027bb:	6a 07                	push   $0x7
  8027bd:	e8 fb fe ff ff       	call   8026bd <syscall>
  8027c2:	83 c4 18             	add    $0x18,%esp
}
  8027c5:	c9                   	leave  
  8027c6:	c3                   	ret    

008027c7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8027c7:	55                   	push   %ebp
  8027c8:	89 e5                	mov    %esp,%ebp
  8027ca:	56                   	push   %esi
  8027cb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8027cc:	8b 75 18             	mov    0x18(%ebp),%esi
  8027cf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8027d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8027d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8027db:	56                   	push   %esi
  8027dc:	53                   	push   %ebx
  8027dd:	51                   	push   %ecx
  8027de:	52                   	push   %edx
  8027df:	50                   	push   %eax
  8027e0:	6a 08                	push   $0x8
  8027e2:	e8 d6 fe ff ff       	call   8026bd <syscall>
  8027e7:	83 c4 18             	add    $0x18,%esp
}
  8027ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8027ed:	5b                   	pop    %ebx
  8027ee:	5e                   	pop    %esi
  8027ef:	5d                   	pop    %ebp
  8027f0:	c3                   	ret    

008027f1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8027f1:	55                   	push   %ebp
  8027f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8027f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8027fa:	6a 00                	push   $0x0
  8027fc:	6a 00                	push   $0x0
  8027fe:	6a 00                	push   $0x0
  802800:	52                   	push   %edx
  802801:	50                   	push   %eax
  802802:	6a 09                	push   $0x9
  802804:	e8 b4 fe ff ff       	call   8026bd <syscall>
  802809:	83 c4 18             	add    $0x18,%esp
}
  80280c:	c9                   	leave  
  80280d:	c3                   	ret    

0080280e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80280e:	55                   	push   %ebp
  80280f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802811:	6a 00                	push   $0x0
  802813:	6a 00                	push   $0x0
  802815:	6a 00                	push   $0x0
  802817:	ff 75 0c             	pushl  0xc(%ebp)
  80281a:	ff 75 08             	pushl  0x8(%ebp)
  80281d:	6a 0a                	push   $0xa
  80281f:	e8 99 fe ff ff       	call   8026bd <syscall>
  802824:	83 c4 18             	add    $0x18,%esp
}
  802827:	c9                   	leave  
  802828:	c3                   	ret    

00802829 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802829:	55                   	push   %ebp
  80282a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80282c:	6a 00                	push   $0x0
  80282e:	6a 00                	push   $0x0
  802830:	6a 00                	push   $0x0
  802832:	6a 00                	push   $0x0
  802834:	6a 00                	push   $0x0
  802836:	6a 0b                	push   $0xb
  802838:	e8 80 fe ff ff       	call   8026bd <syscall>
  80283d:	83 c4 18             	add    $0x18,%esp
}
  802840:	c9                   	leave  
  802841:	c3                   	ret    

00802842 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802842:	55                   	push   %ebp
  802843:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802845:	6a 00                	push   $0x0
  802847:	6a 00                	push   $0x0
  802849:	6a 00                	push   $0x0
  80284b:	6a 00                	push   $0x0
  80284d:	6a 00                	push   $0x0
  80284f:	6a 0c                	push   $0xc
  802851:	e8 67 fe ff ff       	call   8026bd <syscall>
  802856:	83 c4 18             	add    $0x18,%esp
}
  802859:	c9                   	leave  
  80285a:	c3                   	ret    

0080285b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80285b:	55                   	push   %ebp
  80285c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80285e:	6a 00                	push   $0x0
  802860:	6a 00                	push   $0x0
  802862:	6a 00                	push   $0x0
  802864:	6a 00                	push   $0x0
  802866:	6a 00                	push   $0x0
  802868:	6a 0d                	push   $0xd
  80286a:	e8 4e fe ff ff       	call   8026bd <syscall>
  80286f:	83 c4 18             	add    $0x18,%esp
}
  802872:	c9                   	leave  
  802873:	c3                   	ret    

00802874 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802874:	55                   	push   %ebp
  802875:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802877:	6a 00                	push   $0x0
  802879:	6a 00                	push   $0x0
  80287b:	6a 00                	push   $0x0
  80287d:	ff 75 0c             	pushl  0xc(%ebp)
  802880:	ff 75 08             	pushl  0x8(%ebp)
  802883:	6a 11                	push   $0x11
  802885:	e8 33 fe ff ff       	call   8026bd <syscall>
  80288a:	83 c4 18             	add    $0x18,%esp
	return;
  80288d:	90                   	nop
}
  80288e:	c9                   	leave  
  80288f:	c3                   	ret    

00802890 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802890:	55                   	push   %ebp
  802891:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802893:	6a 00                	push   $0x0
  802895:	6a 00                	push   $0x0
  802897:	6a 00                	push   $0x0
  802899:	ff 75 0c             	pushl  0xc(%ebp)
  80289c:	ff 75 08             	pushl  0x8(%ebp)
  80289f:	6a 12                	push   $0x12
  8028a1:	e8 17 fe ff ff       	call   8026bd <syscall>
  8028a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8028a9:	90                   	nop
}
  8028aa:	c9                   	leave  
  8028ab:	c3                   	ret    

008028ac <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8028ac:	55                   	push   %ebp
  8028ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8028af:	6a 00                	push   $0x0
  8028b1:	6a 00                	push   $0x0
  8028b3:	6a 00                	push   $0x0
  8028b5:	6a 00                	push   $0x0
  8028b7:	6a 00                	push   $0x0
  8028b9:	6a 0e                	push   $0xe
  8028bb:	e8 fd fd ff ff       	call   8026bd <syscall>
  8028c0:	83 c4 18             	add    $0x18,%esp
}
  8028c3:	c9                   	leave  
  8028c4:	c3                   	ret    

008028c5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8028c5:	55                   	push   %ebp
  8028c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8028c8:	6a 00                	push   $0x0
  8028ca:	6a 00                	push   $0x0
  8028cc:	6a 00                	push   $0x0
  8028ce:	6a 00                	push   $0x0
  8028d0:	ff 75 08             	pushl  0x8(%ebp)
  8028d3:	6a 0f                	push   $0xf
  8028d5:	e8 e3 fd ff ff       	call   8026bd <syscall>
  8028da:	83 c4 18             	add    $0x18,%esp
}
  8028dd:	c9                   	leave  
  8028de:	c3                   	ret    

008028df <sys_scarce_memory>:

void sys_scarce_memory()
{
  8028df:	55                   	push   %ebp
  8028e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8028e2:	6a 00                	push   $0x0
  8028e4:	6a 00                	push   $0x0
  8028e6:	6a 00                	push   $0x0
  8028e8:	6a 00                	push   $0x0
  8028ea:	6a 00                	push   $0x0
  8028ec:	6a 10                	push   $0x10
  8028ee:	e8 ca fd ff ff       	call   8026bd <syscall>
  8028f3:	83 c4 18             	add    $0x18,%esp
}
  8028f6:	90                   	nop
  8028f7:	c9                   	leave  
  8028f8:	c3                   	ret    

008028f9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8028f9:	55                   	push   %ebp
  8028fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8028fc:	6a 00                	push   $0x0
  8028fe:	6a 00                	push   $0x0
  802900:	6a 00                	push   $0x0
  802902:	6a 00                	push   $0x0
  802904:	6a 00                	push   $0x0
  802906:	6a 14                	push   $0x14
  802908:	e8 b0 fd ff ff       	call   8026bd <syscall>
  80290d:	83 c4 18             	add    $0x18,%esp
}
  802910:	90                   	nop
  802911:	c9                   	leave  
  802912:	c3                   	ret    

00802913 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802913:	55                   	push   %ebp
  802914:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802916:	6a 00                	push   $0x0
  802918:	6a 00                	push   $0x0
  80291a:	6a 00                	push   $0x0
  80291c:	6a 00                	push   $0x0
  80291e:	6a 00                	push   $0x0
  802920:	6a 15                	push   $0x15
  802922:	e8 96 fd ff ff       	call   8026bd <syscall>
  802927:	83 c4 18             	add    $0x18,%esp
}
  80292a:	90                   	nop
  80292b:	c9                   	leave  
  80292c:	c3                   	ret    

0080292d <sys_cputc>:


void
sys_cputc(const char c)
{
  80292d:	55                   	push   %ebp
  80292e:	89 e5                	mov    %esp,%ebp
  802930:	83 ec 04             	sub    $0x4,%esp
  802933:	8b 45 08             	mov    0x8(%ebp),%eax
  802936:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802939:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80293d:	6a 00                	push   $0x0
  80293f:	6a 00                	push   $0x0
  802941:	6a 00                	push   $0x0
  802943:	6a 00                	push   $0x0
  802945:	50                   	push   %eax
  802946:	6a 16                	push   $0x16
  802948:	e8 70 fd ff ff       	call   8026bd <syscall>
  80294d:	83 c4 18             	add    $0x18,%esp
}
  802950:	90                   	nop
  802951:	c9                   	leave  
  802952:	c3                   	ret    

00802953 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802953:	55                   	push   %ebp
  802954:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802956:	6a 00                	push   $0x0
  802958:	6a 00                	push   $0x0
  80295a:	6a 00                	push   $0x0
  80295c:	6a 00                	push   $0x0
  80295e:	6a 00                	push   $0x0
  802960:	6a 17                	push   $0x17
  802962:	e8 56 fd ff ff       	call   8026bd <syscall>
  802967:	83 c4 18             	add    $0x18,%esp
}
  80296a:	90                   	nop
  80296b:	c9                   	leave  
  80296c:	c3                   	ret    

0080296d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80296d:	55                   	push   %ebp
  80296e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802970:	8b 45 08             	mov    0x8(%ebp),%eax
  802973:	6a 00                	push   $0x0
  802975:	6a 00                	push   $0x0
  802977:	6a 00                	push   $0x0
  802979:	ff 75 0c             	pushl  0xc(%ebp)
  80297c:	50                   	push   %eax
  80297d:	6a 18                	push   $0x18
  80297f:	e8 39 fd ff ff       	call   8026bd <syscall>
  802984:	83 c4 18             	add    $0x18,%esp
}
  802987:	c9                   	leave  
  802988:	c3                   	ret    

00802989 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802989:	55                   	push   %ebp
  80298a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80298c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80298f:	8b 45 08             	mov    0x8(%ebp),%eax
  802992:	6a 00                	push   $0x0
  802994:	6a 00                	push   $0x0
  802996:	6a 00                	push   $0x0
  802998:	52                   	push   %edx
  802999:	50                   	push   %eax
  80299a:	6a 1b                	push   $0x1b
  80299c:	e8 1c fd ff ff       	call   8026bd <syscall>
  8029a1:	83 c4 18             	add    $0x18,%esp
}
  8029a4:	c9                   	leave  
  8029a5:	c3                   	ret    

008029a6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8029a6:	55                   	push   %ebp
  8029a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8029a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8029af:	6a 00                	push   $0x0
  8029b1:	6a 00                	push   $0x0
  8029b3:	6a 00                	push   $0x0
  8029b5:	52                   	push   %edx
  8029b6:	50                   	push   %eax
  8029b7:	6a 19                	push   $0x19
  8029b9:	e8 ff fc ff ff       	call   8026bd <syscall>
  8029be:	83 c4 18             	add    $0x18,%esp
}
  8029c1:	90                   	nop
  8029c2:	c9                   	leave  
  8029c3:	c3                   	ret    

008029c4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8029c4:	55                   	push   %ebp
  8029c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8029c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8029ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8029cd:	6a 00                	push   $0x0
  8029cf:	6a 00                	push   $0x0
  8029d1:	6a 00                	push   $0x0
  8029d3:	52                   	push   %edx
  8029d4:	50                   	push   %eax
  8029d5:	6a 1a                	push   $0x1a
  8029d7:	e8 e1 fc ff ff       	call   8026bd <syscall>
  8029dc:	83 c4 18             	add    $0x18,%esp
}
  8029df:	90                   	nop
  8029e0:	c9                   	leave  
  8029e1:	c3                   	ret    

008029e2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8029e2:	55                   	push   %ebp
  8029e3:	89 e5                	mov    %esp,%ebp
  8029e5:	83 ec 04             	sub    $0x4,%esp
  8029e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8029eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8029ee:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8029f1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8029f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8029f8:	6a 00                	push   $0x0
  8029fa:	51                   	push   %ecx
  8029fb:	52                   	push   %edx
  8029fc:	ff 75 0c             	pushl  0xc(%ebp)
  8029ff:	50                   	push   %eax
  802a00:	6a 1c                	push   $0x1c
  802a02:	e8 b6 fc ff ff       	call   8026bd <syscall>
  802a07:	83 c4 18             	add    $0x18,%esp
}
  802a0a:	c9                   	leave  
  802a0b:	c3                   	ret    

00802a0c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802a0c:	55                   	push   %ebp
  802a0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802a0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802a12:	8b 45 08             	mov    0x8(%ebp),%eax
  802a15:	6a 00                	push   $0x0
  802a17:	6a 00                	push   $0x0
  802a19:	6a 00                	push   $0x0
  802a1b:	52                   	push   %edx
  802a1c:	50                   	push   %eax
  802a1d:	6a 1d                	push   $0x1d
  802a1f:	e8 99 fc ff ff       	call   8026bd <syscall>
  802a24:	83 c4 18             	add    $0x18,%esp
}
  802a27:	c9                   	leave  
  802a28:	c3                   	ret    

00802a29 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802a29:	55                   	push   %ebp
  802a2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802a2c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802a2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802a32:	8b 45 08             	mov    0x8(%ebp),%eax
  802a35:	6a 00                	push   $0x0
  802a37:	6a 00                	push   $0x0
  802a39:	51                   	push   %ecx
  802a3a:	52                   	push   %edx
  802a3b:	50                   	push   %eax
  802a3c:	6a 1e                	push   $0x1e
  802a3e:	e8 7a fc ff ff       	call   8026bd <syscall>
  802a43:	83 c4 18             	add    $0x18,%esp
}
  802a46:	c9                   	leave  
  802a47:	c3                   	ret    

00802a48 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802a48:	55                   	push   %ebp
  802a49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802a4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  802a51:	6a 00                	push   $0x0
  802a53:	6a 00                	push   $0x0
  802a55:	6a 00                	push   $0x0
  802a57:	52                   	push   %edx
  802a58:	50                   	push   %eax
  802a59:	6a 1f                	push   $0x1f
  802a5b:	e8 5d fc ff ff       	call   8026bd <syscall>
  802a60:	83 c4 18             	add    $0x18,%esp
}
  802a63:	c9                   	leave  
  802a64:	c3                   	ret    

00802a65 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802a65:	55                   	push   %ebp
  802a66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802a68:	6a 00                	push   $0x0
  802a6a:	6a 00                	push   $0x0
  802a6c:	6a 00                	push   $0x0
  802a6e:	6a 00                	push   $0x0
  802a70:	6a 00                	push   $0x0
  802a72:	6a 20                	push   $0x20
  802a74:	e8 44 fc ff ff       	call   8026bd <syscall>
  802a79:	83 c4 18             	add    $0x18,%esp
}
  802a7c:	c9                   	leave  
  802a7d:	c3                   	ret    

00802a7e <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802a7e:	55                   	push   %ebp
  802a7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802a81:	8b 45 08             	mov    0x8(%ebp),%eax
  802a84:	6a 00                	push   $0x0
  802a86:	6a 00                	push   $0x0
  802a88:	ff 75 10             	pushl  0x10(%ebp)
  802a8b:	ff 75 0c             	pushl  0xc(%ebp)
  802a8e:	50                   	push   %eax
  802a8f:	6a 21                	push   $0x21
  802a91:	e8 27 fc ff ff       	call   8026bd <syscall>
  802a96:	83 c4 18             	add    $0x18,%esp
}
  802a99:	c9                   	leave  
  802a9a:	c3                   	ret    

00802a9b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802a9b:	55                   	push   %ebp
  802a9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  802aa1:	6a 00                	push   $0x0
  802aa3:	6a 00                	push   $0x0
  802aa5:	6a 00                	push   $0x0
  802aa7:	6a 00                	push   $0x0
  802aa9:	50                   	push   %eax
  802aaa:	6a 22                	push   $0x22
  802aac:	e8 0c fc ff ff       	call   8026bd <syscall>
  802ab1:	83 c4 18             	add    $0x18,%esp
}
  802ab4:	90                   	nop
  802ab5:	c9                   	leave  
  802ab6:	c3                   	ret    

00802ab7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802ab7:	55                   	push   %ebp
  802ab8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802aba:	8b 45 08             	mov    0x8(%ebp),%eax
  802abd:	6a 00                	push   $0x0
  802abf:	6a 00                	push   $0x0
  802ac1:	6a 00                	push   $0x0
  802ac3:	6a 00                	push   $0x0
  802ac5:	50                   	push   %eax
  802ac6:	6a 23                	push   $0x23
  802ac8:	e8 f0 fb ff ff       	call   8026bd <syscall>
  802acd:	83 c4 18             	add    $0x18,%esp
}
  802ad0:	90                   	nop
  802ad1:	c9                   	leave  
  802ad2:	c3                   	ret    

00802ad3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802ad3:	55                   	push   %ebp
  802ad4:	89 e5                	mov    %esp,%ebp
  802ad6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802ad9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802adc:	8d 50 04             	lea    0x4(%eax),%edx
  802adf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802ae2:	6a 00                	push   $0x0
  802ae4:	6a 00                	push   $0x0
  802ae6:	6a 00                	push   $0x0
  802ae8:	52                   	push   %edx
  802ae9:	50                   	push   %eax
  802aea:	6a 24                	push   $0x24
  802aec:	e8 cc fb ff ff       	call   8026bd <syscall>
  802af1:	83 c4 18             	add    $0x18,%esp
	return result;
  802af4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802af7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802afa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802afd:	89 01                	mov    %eax,(%ecx)
  802aff:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802b02:	8b 45 08             	mov    0x8(%ebp),%eax
  802b05:	c9                   	leave  
  802b06:	c2 04 00             	ret    $0x4

00802b09 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802b09:	55                   	push   %ebp
  802b0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802b0c:	6a 00                	push   $0x0
  802b0e:	6a 00                	push   $0x0
  802b10:	ff 75 10             	pushl  0x10(%ebp)
  802b13:	ff 75 0c             	pushl  0xc(%ebp)
  802b16:	ff 75 08             	pushl  0x8(%ebp)
  802b19:	6a 13                	push   $0x13
  802b1b:	e8 9d fb ff ff       	call   8026bd <syscall>
  802b20:	83 c4 18             	add    $0x18,%esp
	return ;
  802b23:	90                   	nop
}
  802b24:	c9                   	leave  
  802b25:	c3                   	ret    

00802b26 <sys_rcr2>:
uint32 sys_rcr2()
{
  802b26:	55                   	push   %ebp
  802b27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802b29:	6a 00                	push   $0x0
  802b2b:	6a 00                	push   $0x0
  802b2d:	6a 00                	push   $0x0
  802b2f:	6a 00                	push   $0x0
  802b31:	6a 00                	push   $0x0
  802b33:	6a 25                	push   $0x25
  802b35:	e8 83 fb ff ff       	call   8026bd <syscall>
  802b3a:	83 c4 18             	add    $0x18,%esp
}
  802b3d:	c9                   	leave  
  802b3e:	c3                   	ret    

00802b3f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802b3f:	55                   	push   %ebp
  802b40:	89 e5                	mov    %esp,%ebp
  802b42:	83 ec 04             	sub    $0x4,%esp
  802b45:	8b 45 08             	mov    0x8(%ebp),%eax
  802b48:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802b4b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802b4f:	6a 00                	push   $0x0
  802b51:	6a 00                	push   $0x0
  802b53:	6a 00                	push   $0x0
  802b55:	6a 00                	push   $0x0
  802b57:	50                   	push   %eax
  802b58:	6a 26                	push   $0x26
  802b5a:	e8 5e fb ff ff       	call   8026bd <syscall>
  802b5f:	83 c4 18             	add    $0x18,%esp
	return ;
  802b62:	90                   	nop
}
  802b63:	c9                   	leave  
  802b64:	c3                   	ret    

00802b65 <rsttst>:
void rsttst()
{
  802b65:	55                   	push   %ebp
  802b66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802b68:	6a 00                	push   $0x0
  802b6a:	6a 00                	push   $0x0
  802b6c:	6a 00                	push   $0x0
  802b6e:	6a 00                	push   $0x0
  802b70:	6a 00                	push   $0x0
  802b72:	6a 28                	push   $0x28
  802b74:	e8 44 fb ff ff       	call   8026bd <syscall>
  802b79:	83 c4 18             	add    $0x18,%esp
	return ;
  802b7c:	90                   	nop
}
  802b7d:	c9                   	leave  
  802b7e:	c3                   	ret    

00802b7f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802b7f:	55                   	push   %ebp
  802b80:	89 e5                	mov    %esp,%ebp
  802b82:	83 ec 04             	sub    $0x4,%esp
  802b85:	8b 45 14             	mov    0x14(%ebp),%eax
  802b88:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802b8b:	8b 55 18             	mov    0x18(%ebp),%edx
  802b8e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802b92:	52                   	push   %edx
  802b93:	50                   	push   %eax
  802b94:	ff 75 10             	pushl  0x10(%ebp)
  802b97:	ff 75 0c             	pushl  0xc(%ebp)
  802b9a:	ff 75 08             	pushl  0x8(%ebp)
  802b9d:	6a 27                	push   $0x27
  802b9f:	e8 19 fb ff ff       	call   8026bd <syscall>
  802ba4:	83 c4 18             	add    $0x18,%esp
	return ;
  802ba7:	90                   	nop
}
  802ba8:	c9                   	leave  
  802ba9:	c3                   	ret    

00802baa <chktst>:
void chktst(uint32 n)
{
  802baa:	55                   	push   %ebp
  802bab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802bad:	6a 00                	push   $0x0
  802baf:	6a 00                	push   $0x0
  802bb1:	6a 00                	push   $0x0
  802bb3:	6a 00                	push   $0x0
  802bb5:	ff 75 08             	pushl  0x8(%ebp)
  802bb8:	6a 29                	push   $0x29
  802bba:	e8 fe fa ff ff       	call   8026bd <syscall>
  802bbf:	83 c4 18             	add    $0x18,%esp
	return ;
  802bc2:	90                   	nop
}
  802bc3:	c9                   	leave  
  802bc4:	c3                   	ret    

00802bc5 <inctst>:

void inctst()
{
  802bc5:	55                   	push   %ebp
  802bc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802bc8:	6a 00                	push   $0x0
  802bca:	6a 00                	push   $0x0
  802bcc:	6a 00                	push   $0x0
  802bce:	6a 00                	push   $0x0
  802bd0:	6a 00                	push   $0x0
  802bd2:	6a 2a                	push   $0x2a
  802bd4:	e8 e4 fa ff ff       	call   8026bd <syscall>
  802bd9:	83 c4 18             	add    $0x18,%esp
	return ;
  802bdc:	90                   	nop
}
  802bdd:	c9                   	leave  
  802bde:	c3                   	ret    

00802bdf <gettst>:
uint32 gettst()
{
  802bdf:	55                   	push   %ebp
  802be0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802be2:	6a 00                	push   $0x0
  802be4:	6a 00                	push   $0x0
  802be6:	6a 00                	push   $0x0
  802be8:	6a 00                	push   $0x0
  802bea:	6a 00                	push   $0x0
  802bec:	6a 2b                	push   $0x2b
  802bee:	e8 ca fa ff ff       	call   8026bd <syscall>
  802bf3:	83 c4 18             	add    $0x18,%esp
}
  802bf6:	c9                   	leave  
  802bf7:	c3                   	ret    

00802bf8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802bf8:	55                   	push   %ebp
  802bf9:	89 e5                	mov    %esp,%ebp
  802bfb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802bfe:	6a 00                	push   $0x0
  802c00:	6a 00                	push   $0x0
  802c02:	6a 00                	push   $0x0
  802c04:	6a 00                	push   $0x0
  802c06:	6a 00                	push   $0x0
  802c08:	6a 2c                	push   $0x2c
  802c0a:	e8 ae fa ff ff       	call   8026bd <syscall>
  802c0f:	83 c4 18             	add    $0x18,%esp
  802c12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802c15:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802c19:	75 07                	jne    802c22 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802c1b:	b8 01 00 00 00       	mov    $0x1,%eax
  802c20:	eb 05                	jmp    802c27 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802c22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c27:	c9                   	leave  
  802c28:	c3                   	ret    

00802c29 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802c29:	55                   	push   %ebp
  802c2a:	89 e5                	mov    %esp,%ebp
  802c2c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802c2f:	6a 00                	push   $0x0
  802c31:	6a 00                	push   $0x0
  802c33:	6a 00                	push   $0x0
  802c35:	6a 00                	push   $0x0
  802c37:	6a 00                	push   $0x0
  802c39:	6a 2c                	push   $0x2c
  802c3b:	e8 7d fa ff ff       	call   8026bd <syscall>
  802c40:	83 c4 18             	add    $0x18,%esp
  802c43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802c46:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802c4a:	75 07                	jne    802c53 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802c4c:	b8 01 00 00 00       	mov    $0x1,%eax
  802c51:	eb 05                	jmp    802c58 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802c53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c58:	c9                   	leave  
  802c59:	c3                   	ret    

00802c5a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802c5a:	55                   	push   %ebp
  802c5b:	89 e5                	mov    %esp,%ebp
  802c5d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802c60:	6a 00                	push   $0x0
  802c62:	6a 00                	push   $0x0
  802c64:	6a 00                	push   $0x0
  802c66:	6a 00                	push   $0x0
  802c68:	6a 00                	push   $0x0
  802c6a:	6a 2c                	push   $0x2c
  802c6c:	e8 4c fa ff ff       	call   8026bd <syscall>
  802c71:	83 c4 18             	add    $0x18,%esp
  802c74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802c77:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802c7b:	75 07                	jne    802c84 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802c7d:	b8 01 00 00 00       	mov    $0x1,%eax
  802c82:	eb 05                	jmp    802c89 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802c84:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802c89:	c9                   	leave  
  802c8a:	c3                   	ret    

00802c8b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802c8b:	55                   	push   %ebp
  802c8c:	89 e5                	mov    %esp,%ebp
  802c8e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802c91:	6a 00                	push   $0x0
  802c93:	6a 00                	push   $0x0
  802c95:	6a 00                	push   $0x0
  802c97:	6a 00                	push   $0x0
  802c99:	6a 00                	push   $0x0
  802c9b:	6a 2c                	push   $0x2c
  802c9d:	e8 1b fa ff ff       	call   8026bd <syscall>
  802ca2:	83 c4 18             	add    $0x18,%esp
  802ca5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802ca8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802cac:	75 07                	jne    802cb5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802cae:	b8 01 00 00 00       	mov    $0x1,%eax
  802cb3:	eb 05                	jmp    802cba <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802cb5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802cba:	c9                   	leave  
  802cbb:	c3                   	ret    

00802cbc <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802cbc:	55                   	push   %ebp
  802cbd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802cbf:	6a 00                	push   $0x0
  802cc1:	6a 00                	push   $0x0
  802cc3:	6a 00                	push   $0x0
  802cc5:	6a 00                	push   $0x0
  802cc7:	ff 75 08             	pushl  0x8(%ebp)
  802cca:	6a 2d                	push   $0x2d
  802ccc:	e8 ec f9 ff ff       	call   8026bd <syscall>
  802cd1:	83 c4 18             	add    $0x18,%esp
	return ;
  802cd4:	90                   	nop
}
  802cd5:	c9                   	leave  
  802cd6:	c3                   	ret    
  802cd7:	90                   	nop

00802cd8 <__udivdi3>:
  802cd8:	55                   	push   %ebp
  802cd9:	57                   	push   %edi
  802cda:	56                   	push   %esi
  802cdb:	53                   	push   %ebx
  802cdc:	83 ec 1c             	sub    $0x1c,%esp
  802cdf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802ce3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802ce7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802ceb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802cef:	89 ca                	mov    %ecx,%edx
  802cf1:	89 f8                	mov    %edi,%eax
  802cf3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802cf7:	85 f6                	test   %esi,%esi
  802cf9:	75 2d                	jne    802d28 <__udivdi3+0x50>
  802cfb:	39 cf                	cmp    %ecx,%edi
  802cfd:	77 65                	ja     802d64 <__udivdi3+0x8c>
  802cff:	89 fd                	mov    %edi,%ebp
  802d01:	85 ff                	test   %edi,%edi
  802d03:	75 0b                	jne    802d10 <__udivdi3+0x38>
  802d05:	b8 01 00 00 00       	mov    $0x1,%eax
  802d0a:	31 d2                	xor    %edx,%edx
  802d0c:	f7 f7                	div    %edi
  802d0e:	89 c5                	mov    %eax,%ebp
  802d10:	31 d2                	xor    %edx,%edx
  802d12:	89 c8                	mov    %ecx,%eax
  802d14:	f7 f5                	div    %ebp
  802d16:	89 c1                	mov    %eax,%ecx
  802d18:	89 d8                	mov    %ebx,%eax
  802d1a:	f7 f5                	div    %ebp
  802d1c:	89 cf                	mov    %ecx,%edi
  802d1e:	89 fa                	mov    %edi,%edx
  802d20:	83 c4 1c             	add    $0x1c,%esp
  802d23:	5b                   	pop    %ebx
  802d24:	5e                   	pop    %esi
  802d25:	5f                   	pop    %edi
  802d26:	5d                   	pop    %ebp
  802d27:	c3                   	ret    
  802d28:	39 ce                	cmp    %ecx,%esi
  802d2a:	77 28                	ja     802d54 <__udivdi3+0x7c>
  802d2c:	0f bd fe             	bsr    %esi,%edi
  802d2f:	83 f7 1f             	xor    $0x1f,%edi
  802d32:	75 40                	jne    802d74 <__udivdi3+0x9c>
  802d34:	39 ce                	cmp    %ecx,%esi
  802d36:	72 0a                	jb     802d42 <__udivdi3+0x6a>
  802d38:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802d3c:	0f 87 9e 00 00 00    	ja     802de0 <__udivdi3+0x108>
  802d42:	b8 01 00 00 00       	mov    $0x1,%eax
  802d47:	89 fa                	mov    %edi,%edx
  802d49:	83 c4 1c             	add    $0x1c,%esp
  802d4c:	5b                   	pop    %ebx
  802d4d:	5e                   	pop    %esi
  802d4e:	5f                   	pop    %edi
  802d4f:	5d                   	pop    %ebp
  802d50:	c3                   	ret    
  802d51:	8d 76 00             	lea    0x0(%esi),%esi
  802d54:	31 ff                	xor    %edi,%edi
  802d56:	31 c0                	xor    %eax,%eax
  802d58:	89 fa                	mov    %edi,%edx
  802d5a:	83 c4 1c             	add    $0x1c,%esp
  802d5d:	5b                   	pop    %ebx
  802d5e:	5e                   	pop    %esi
  802d5f:	5f                   	pop    %edi
  802d60:	5d                   	pop    %ebp
  802d61:	c3                   	ret    
  802d62:	66 90                	xchg   %ax,%ax
  802d64:	89 d8                	mov    %ebx,%eax
  802d66:	f7 f7                	div    %edi
  802d68:	31 ff                	xor    %edi,%edi
  802d6a:	89 fa                	mov    %edi,%edx
  802d6c:	83 c4 1c             	add    $0x1c,%esp
  802d6f:	5b                   	pop    %ebx
  802d70:	5e                   	pop    %esi
  802d71:	5f                   	pop    %edi
  802d72:	5d                   	pop    %ebp
  802d73:	c3                   	ret    
  802d74:	bd 20 00 00 00       	mov    $0x20,%ebp
  802d79:	89 eb                	mov    %ebp,%ebx
  802d7b:	29 fb                	sub    %edi,%ebx
  802d7d:	89 f9                	mov    %edi,%ecx
  802d7f:	d3 e6                	shl    %cl,%esi
  802d81:	89 c5                	mov    %eax,%ebp
  802d83:	88 d9                	mov    %bl,%cl
  802d85:	d3 ed                	shr    %cl,%ebp
  802d87:	89 e9                	mov    %ebp,%ecx
  802d89:	09 f1                	or     %esi,%ecx
  802d8b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802d8f:	89 f9                	mov    %edi,%ecx
  802d91:	d3 e0                	shl    %cl,%eax
  802d93:	89 c5                	mov    %eax,%ebp
  802d95:	89 d6                	mov    %edx,%esi
  802d97:	88 d9                	mov    %bl,%cl
  802d99:	d3 ee                	shr    %cl,%esi
  802d9b:	89 f9                	mov    %edi,%ecx
  802d9d:	d3 e2                	shl    %cl,%edx
  802d9f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802da3:	88 d9                	mov    %bl,%cl
  802da5:	d3 e8                	shr    %cl,%eax
  802da7:	09 c2                	or     %eax,%edx
  802da9:	89 d0                	mov    %edx,%eax
  802dab:	89 f2                	mov    %esi,%edx
  802dad:	f7 74 24 0c          	divl   0xc(%esp)
  802db1:	89 d6                	mov    %edx,%esi
  802db3:	89 c3                	mov    %eax,%ebx
  802db5:	f7 e5                	mul    %ebp
  802db7:	39 d6                	cmp    %edx,%esi
  802db9:	72 19                	jb     802dd4 <__udivdi3+0xfc>
  802dbb:	74 0b                	je     802dc8 <__udivdi3+0xf0>
  802dbd:	89 d8                	mov    %ebx,%eax
  802dbf:	31 ff                	xor    %edi,%edi
  802dc1:	e9 58 ff ff ff       	jmp    802d1e <__udivdi3+0x46>
  802dc6:	66 90                	xchg   %ax,%ax
  802dc8:	8b 54 24 08          	mov    0x8(%esp),%edx
  802dcc:	89 f9                	mov    %edi,%ecx
  802dce:	d3 e2                	shl    %cl,%edx
  802dd0:	39 c2                	cmp    %eax,%edx
  802dd2:	73 e9                	jae    802dbd <__udivdi3+0xe5>
  802dd4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802dd7:	31 ff                	xor    %edi,%edi
  802dd9:	e9 40 ff ff ff       	jmp    802d1e <__udivdi3+0x46>
  802dde:	66 90                	xchg   %ax,%ax
  802de0:	31 c0                	xor    %eax,%eax
  802de2:	e9 37 ff ff ff       	jmp    802d1e <__udivdi3+0x46>
  802de7:	90                   	nop

00802de8 <__umoddi3>:
  802de8:	55                   	push   %ebp
  802de9:	57                   	push   %edi
  802dea:	56                   	push   %esi
  802deb:	53                   	push   %ebx
  802dec:	83 ec 1c             	sub    $0x1c,%esp
  802def:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802df3:	8b 74 24 34          	mov    0x34(%esp),%esi
  802df7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802dfb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802dff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802e03:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802e07:	89 f3                	mov    %esi,%ebx
  802e09:	89 fa                	mov    %edi,%edx
  802e0b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802e0f:	89 34 24             	mov    %esi,(%esp)
  802e12:	85 c0                	test   %eax,%eax
  802e14:	75 1a                	jne    802e30 <__umoddi3+0x48>
  802e16:	39 f7                	cmp    %esi,%edi
  802e18:	0f 86 a2 00 00 00    	jbe    802ec0 <__umoddi3+0xd8>
  802e1e:	89 c8                	mov    %ecx,%eax
  802e20:	89 f2                	mov    %esi,%edx
  802e22:	f7 f7                	div    %edi
  802e24:	89 d0                	mov    %edx,%eax
  802e26:	31 d2                	xor    %edx,%edx
  802e28:	83 c4 1c             	add    $0x1c,%esp
  802e2b:	5b                   	pop    %ebx
  802e2c:	5e                   	pop    %esi
  802e2d:	5f                   	pop    %edi
  802e2e:	5d                   	pop    %ebp
  802e2f:	c3                   	ret    
  802e30:	39 f0                	cmp    %esi,%eax
  802e32:	0f 87 ac 00 00 00    	ja     802ee4 <__umoddi3+0xfc>
  802e38:	0f bd e8             	bsr    %eax,%ebp
  802e3b:	83 f5 1f             	xor    $0x1f,%ebp
  802e3e:	0f 84 ac 00 00 00    	je     802ef0 <__umoddi3+0x108>
  802e44:	bf 20 00 00 00       	mov    $0x20,%edi
  802e49:	29 ef                	sub    %ebp,%edi
  802e4b:	89 fe                	mov    %edi,%esi
  802e4d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802e51:	89 e9                	mov    %ebp,%ecx
  802e53:	d3 e0                	shl    %cl,%eax
  802e55:	89 d7                	mov    %edx,%edi
  802e57:	89 f1                	mov    %esi,%ecx
  802e59:	d3 ef                	shr    %cl,%edi
  802e5b:	09 c7                	or     %eax,%edi
  802e5d:	89 e9                	mov    %ebp,%ecx
  802e5f:	d3 e2                	shl    %cl,%edx
  802e61:	89 14 24             	mov    %edx,(%esp)
  802e64:	89 d8                	mov    %ebx,%eax
  802e66:	d3 e0                	shl    %cl,%eax
  802e68:	89 c2                	mov    %eax,%edx
  802e6a:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e6e:	d3 e0                	shl    %cl,%eax
  802e70:	89 44 24 04          	mov    %eax,0x4(%esp)
  802e74:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e78:	89 f1                	mov    %esi,%ecx
  802e7a:	d3 e8                	shr    %cl,%eax
  802e7c:	09 d0                	or     %edx,%eax
  802e7e:	d3 eb                	shr    %cl,%ebx
  802e80:	89 da                	mov    %ebx,%edx
  802e82:	f7 f7                	div    %edi
  802e84:	89 d3                	mov    %edx,%ebx
  802e86:	f7 24 24             	mull   (%esp)
  802e89:	89 c6                	mov    %eax,%esi
  802e8b:	89 d1                	mov    %edx,%ecx
  802e8d:	39 d3                	cmp    %edx,%ebx
  802e8f:	0f 82 87 00 00 00    	jb     802f1c <__umoddi3+0x134>
  802e95:	0f 84 91 00 00 00    	je     802f2c <__umoddi3+0x144>
  802e9b:	8b 54 24 04          	mov    0x4(%esp),%edx
  802e9f:	29 f2                	sub    %esi,%edx
  802ea1:	19 cb                	sbb    %ecx,%ebx
  802ea3:	89 d8                	mov    %ebx,%eax
  802ea5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802ea9:	d3 e0                	shl    %cl,%eax
  802eab:	89 e9                	mov    %ebp,%ecx
  802ead:	d3 ea                	shr    %cl,%edx
  802eaf:	09 d0                	or     %edx,%eax
  802eb1:	89 e9                	mov    %ebp,%ecx
  802eb3:	d3 eb                	shr    %cl,%ebx
  802eb5:	89 da                	mov    %ebx,%edx
  802eb7:	83 c4 1c             	add    $0x1c,%esp
  802eba:	5b                   	pop    %ebx
  802ebb:	5e                   	pop    %esi
  802ebc:	5f                   	pop    %edi
  802ebd:	5d                   	pop    %ebp
  802ebe:	c3                   	ret    
  802ebf:	90                   	nop
  802ec0:	89 fd                	mov    %edi,%ebp
  802ec2:	85 ff                	test   %edi,%edi
  802ec4:	75 0b                	jne    802ed1 <__umoddi3+0xe9>
  802ec6:	b8 01 00 00 00       	mov    $0x1,%eax
  802ecb:	31 d2                	xor    %edx,%edx
  802ecd:	f7 f7                	div    %edi
  802ecf:	89 c5                	mov    %eax,%ebp
  802ed1:	89 f0                	mov    %esi,%eax
  802ed3:	31 d2                	xor    %edx,%edx
  802ed5:	f7 f5                	div    %ebp
  802ed7:	89 c8                	mov    %ecx,%eax
  802ed9:	f7 f5                	div    %ebp
  802edb:	89 d0                	mov    %edx,%eax
  802edd:	e9 44 ff ff ff       	jmp    802e26 <__umoddi3+0x3e>
  802ee2:	66 90                	xchg   %ax,%ax
  802ee4:	89 c8                	mov    %ecx,%eax
  802ee6:	89 f2                	mov    %esi,%edx
  802ee8:	83 c4 1c             	add    $0x1c,%esp
  802eeb:	5b                   	pop    %ebx
  802eec:	5e                   	pop    %esi
  802eed:	5f                   	pop    %edi
  802eee:	5d                   	pop    %ebp
  802eef:	c3                   	ret    
  802ef0:	3b 04 24             	cmp    (%esp),%eax
  802ef3:	72 06                	jb     802efb <__umoddi3+0x113>
  802ef5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802ef9:	77 0f                	ja     802f0a <__umoddi3+0x122>
  802efb:	89 f2                	mov    %esi,%edx
  802efd:	29 f9                	sub    %edi,%ecx
  802eff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802f03:	89 14 24             	mov    %edx,(%esp)
  802f06:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802f0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  802f0e:	8b 14 24             	mov    (%esp),%edx
  802f11:	83 c4 1c             	add    $0x1c,%esp
  802f14:	5b                   	pop    %ebx
  802f15:	5e                   	pop    %esi
  802f16:	5f                   	pop    %edi
  802f17:	5d                   	pop    %ebp
  802f18:	c3                   	ret    
  802f19:	8d 76 00             	lea    0x0(%esi),%esi
  802f1c:	2b 04 24             	sub    (%esp),%eax
  802f1f:	19 fa                	sbb    %edi,%edx
  802f21:	89 d1                	mov    %edx,%ecx
  802f23:	89 c6                	mov    %eax,%esi
  802f25:	e9 71 ff ff ff       	jmp    802e9b <__umoddi3+0xb3>
  802f2a:	66 90                	xchg   %ax,%ax
  802f2c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802f30:	72 ea                	jb     802f1c <__umoddi3+0x134>
  802f32:	89 d9                	mov    %ebx,%ecx
  802f34:	e9 62 ff ff ff       	jmp    802e9b <__umoddi3+0xb3>
