
obj/user/tst_malloc:     file format elf32-i386


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
  800031:	e8 ee 03 00 00       	call   800424 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
///MAKE SURE PAGE_WS_MAX_SIZE = 15
///MAKE SURE TABLE_WS_MAX_SIZE = 15
#include <inc/lib.h>

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 24             	sub    $0x24,%esp
//	cprintf("envID = %d\n",envID);

	
	

	int Mega = 1024*1024;
  80003f:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  800046:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)


	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80004d:	e8 91 19 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  800052:	89 45 ec             	mov    %eax,-0x14(%ebp)
	{
		int freeFrames = sys_calculate_free_frames() ;
  800055:	e8 06 19 00 00       	call   801960 <sys_calculate_free_frames>
  80005a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*Mega) != USER_HEAP_START) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80005d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800060:	01 c0                	add    %eax,%eax
  800062:	83 ec 0c             	sub    $0xc,%esp
  800065:	50                   	push   %eax
  800066:	e8 33 15 00 00       	call   80159e <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  800073:	74 14                	je     800089 <_main+0x51>
  800075:	83 ec 04             	sub    $0x4,%esp
  800078:	68 80 20 80 00       	push   $0x802080
  80007d:	6a 14                	push   $0x14
  80007f:	68 e5 20 80 00       	push   $0x8020e5
  800084:	e8 9d 04 00 00       	call   800526 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1*1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800089:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  80008c:	e8 cf 18 00 00       	call   801960 <sys_calculate_free_frames>
  800091:	29 c3                	sub    %eax,%ebx
  800093:	89 d8                	mov    %ebx,%eax
  800095:	83 f8 01             	cmp    $0x1,%eax
  800098:	74 14                	je     8000ae <_main+0x76>
  80009a:	83 ec 04             	sub    $0x4,%esp
  80009d:	68 f8 20 80 00       	push   $0x8020f8
  8000a2:	6a 15                	push   $0x15
  8000a4:	68 e5 20 80 00       	push   $0x8020e5
  8000a9:	e8 78 04 00 00       	call   800526 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8000ae:	e8 ad 18 00 00       	call   801960 <sys_calculate_free_frames>
  8000b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*Mega) != USER_HEAP_START + 2*Mega) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8000b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b9:	01 c0                	add    %eax,%eax
  8000bb:	83 ec 0c             	sub    $0xc,%esp
  8000be:	50                   	push   %eax
  8000bf:	e8 da 14 00 00       	call   80159e <malloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 c2                	mov    %eax,%edx
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	01 c0                	add    %eax,%eax
  8000ce:	05 00 00 00 80       	add    $0x80000000,%eax
  8000d3:	39 c2                	cmp    %eax,%edx
  8000d5:	74 14                	je     8000eb <_main+0xb3>
  8000d7:	83 ec 04             	sub    $0x4,%esp
  8000da:	68 80 20 80 00       	push   $0x802080
  8000df:	6a 18                	push   $0x18
  8000e1:	68 e5 20 80 00       	push   $0x8020e5
  8000e6:	e8 3b 04 00 00       	call   800526 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000eb:	e8 70 18 00 00       	call   801960 <sys_calculate_free_frames>
  8000f0:	89 c2                	mov    %eax,%edx
  8000f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f5:	39 c2                	cmp    %eax,%edx
  8000f7:	74 14                	je     80010d <_main+0xd5>
  8000f9:	83 ec 04             	sub    $0x4,%esp
  8000fc:	68 f8 20 80 00       	push   $0x8020f8
  800101:	6a 19                	push   $0x19
  800103:	68 e5 20 80 00       	push   $0x8020e5
  800108:	e8 19 04 00 00       	call   800526 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80010d:	e8 4e 18 00 00       	call   801960 <sys_calculate_free_frames>
  800112:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*kilo) != USER_HEAP_START+ 4*Mega) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800115:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800118:	01 c0                	add    %eax,%eax
  80011a:	83 ec 0c             	sub    $0xc,%esp
  80011d:	50                   	push   %eax
  80011e:	e8 7b 14 00 00       	call   80159e <malloc>
  800123:	83 c4 10             	add    $0x10,%esp
  800126:	89 c2                	mov    %eax,%edx
  800128:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80012b:	c1 e0 02             	shl    $0x2,%eax
  80012e:	05 00 00 00 80       	add    $0x80000000,%eax
  800133:	39 c2                	cmp    %eax,%edx
  800135:	74 14                	je     80014b <_main+0x113>
  800137:	83 ec 04             	sub    $0x4,%esp
  80013a:	68 80 20 80 00       	push   $0x802080
  80013f:	6a 1c                	push   $0x1c
  800141:	68 e5 20 80 00       	push   $0x8020e5
  800146:	e8 db 03 00 00       	call   800526 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1*1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80014b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  80014e:	e8 0d 18 00 00       	call   801960 <sys_calculate_free_frames>
  800153:	29 c3                	sub    %eax,%ebx
  800155:	89 d8                	mov    %ebx,%eax
  800157:	83 f8 01             	cmp    $0x1,%eax
  80015a:	74 14                	je     800170 <_main+0x138>
  80015c:	83 ec 04             	sub    $0x4,%esp
  80015f:	68 f8 20 80 00       	push   $0x8020f8
  800164:	6a 1d                	push   $0x1d
  800166:	68 e5 20 80 00       	push   $0x8020e5
  80016b:	e8 b6 03 00 00       	call   800526 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800170:	e8 eb 17 00 00       	call   801960 <sys_calculate_free_frames>
  800175:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(3*kilo) != USER_HEAP_START+ 4*Mega+ 2*kilo) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800178:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80017b:	89 c2                	mov    %eax,%edx
  80017d:	01 d2                	add    %edx,%edx
  80017f:	01 d0                	add    %edx,%eax
  800181:	83 ec 0c             	sub    $0xc,%esp
  800184:	50                   	push   %eax
  800185:	e8 14 14 00 00       	call   80159e <malloc>
  80018a:	83 c4 10             	add    $0x10,%esp
  80018d:	89 c2                	mov    %eax,%edx
  80018f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800192:	c1 e0 02             	shl    $0x2,%eax
  800195:	89 c1                	mov    %eax,%ecx
  800197:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80019a:	01 c0                	add    %eax,%eax
  80019c:	01 c8                	add    %ecx,%eax
  80019e:	05 00 00 00 80       	add    $0x80000000,%eax
  8001a3:	39 c2                	cmp    %eax,%edx
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 80 20 80 00       	push   $0x802080
  8001af:	6a 20                	push   $0x20
  8001b1:	68 e5 20 80 00       	push   $0x8020e5
  8001b6:	e8 6b 03 00 00       	call   800526 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0)panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001bb:	e8 a0 17 00 00       	call   801960 <sys_calculate_free_frames>
  8001c0:	89 c2                	mov    %eax,%edx
  8001c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001c5:	39 c2                	cmp    %eax,%edx
  8001c7:	74 14                	je     8001dd <_main+0x1a5>
  8001c9:	83 ec 04             	sub    $0x4,%esp
  8001cc:	68 f8 20 80 00       	push   $0x8020f8
  8001d1:	6a 21                	push   $0x21
  8001d3:	68 e5 20 80 00       	push   $0x8020e5
  8001d8:	e8 49 03 00 00       	call   800526 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  8001dd:	e8 7e 17 00 00       	call   801960 <sys_calculate_free_frames>
  8001e2:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(3*Mega) != USER_HEAP_START + 4*Mega + 5*kilo)  panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8001e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001e8:	89 c2                	mov    %eax,%edx
  8001ea:	01 d2                	add    %edx,%edx
  8001ec:	01 d0                	add    %edx,%eax
  8001ee:	83 ec 0c             	sub    $0xc,%esp
  8001f1:	50                   	push   %eax
  8001f2:	e8 a7 13 00 00       	call   80159e <malloc>
  8001f7:	83 c4 10             	add    $0x10,%esp
  8001fa:	89 c1                	mov    %eax,%ecx
  8001fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001ff:	c1 e0 02             	shl    $0x2,%eax
  800202:	89 c3                	mov    %eax,%ebx
  800204:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800207:	89 d0                	mov    %edx,%eax
  800209:	c1 e0 02             	shl    $0x2,%eax
  80020c:	01 d0                	add    %edx,%eax
  80020e:	01 d8                	add    %ebx,%eax
  800210:	05 00 00 00 80       	add    $0x80000000,%eax
  800215:	39 c1                	cmp    %eax,%ecx
  800217:	74 14                	je     80022d <_main+0x1f5>
  800219:	83 ec 04             	sub    $0x4,%esp
  80021c:	68 80 20 80 00       	push   $0x802080
  800221:	6a 24                	push   $0x24
  800223:	68 e5 20 80 00       	push   $0x8020e5
  800228:	e8 f9 02 00 00       	call   800526 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80022d:	e8 2e 17 00 00       	call   801960 <sys_calculate_free_frames>
  800232:	89 c2                	mov    %eax,%edx
  800234:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800237:	39 c2                	cmp    %eax,%edx
  800239:	74 14                	je     80024f <_main+0x217>
  80023b:	83 ec 04             	sub    $0x4,%esp
  80023e:	68 f8 20 80 00       	push   $0x8020f8
  800243:	6a 25                	push   $0x25
  800245:	68 e5 20 80 00       	push   $0x8020e5
  80024a:	e8 d7 02 00 00       	call   800526 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  80024f:	e8 0c 17 00 00       	call   801960 <sys_calculate_free_frames>
  800254:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if ((uint32)malloc(2*Mega) != USER_HEAP_START + 7*Mega  + 5*kilo) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800257:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80025a:	01 c0                	add    %eax,%eax
  80025c:	83 ec 0c             	sub    $0xc,%esp
  80025f:	50                   	push   %eax
  800260:	e8 39 13 00 00       	call   80159e <malloc>
  800265:	83 c4 10             	add    $0x10,%esp
  800268:	89 c1                	mov    %eax,%ecx
  80026a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80026d:	89 d0                	mov    %edx,%eax
  80026f:	01 c0                	add    %eax,%eax
  800271:	01 d0                	add    %edx,%eax
  800273:	01 c0                	add    %eax,%eax
  800275:	01 d0                	add    %edx,%eax
  800277:	89 c3                	mov    %eax,%ebx
  800279:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80027c:	89 d0                	mov    %edx,%eax
  80027e:	c1 e0 02             	shl    $0x2,%eax
  800281:	01 d0                	add    %edx,%eax
  800283:	01 d8                	add    %ebx,%eax
  800285:	05 00 00 00 80       	add    $0x80000000,%eax
  80028a:	39 c1                	cmp    %eax,%ecx
  80028c:	74 14                	je     8002a2 <_main+0x26a>
  80028e:	83 ec 04             	sub    $0x4,%esp
  800291:	68 80 20 80 00       	push   $0x802080
  800296:	6a 28                	push   $0x28
  800298:	68 e5 20 80 00       	push   $0x8020e5
  80029d:	e8 84 02 00 00       	call   800526 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1*1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002a2:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8002a5:	e8 b6 16 00 00       	call   801960 <sys_calculate_free_frames>
  8002aa:	29 c3                	sub    %eax,%ebx
  8002ac:	89 d8                	mov    %ebx,%eax
  8002ae:	83 f8 01             	cmp    $0x1,%eax
  8002b1:	74 14                	je     8002c7 <_main+0x28f>
  8002b3:	83 ec 04             	sub    $0x4,%esp
  8002b6:	68 f8 20 80 00       	push   $0x8020f8
  8002bb:	6a 29                	push   $0x29
  8002bd:	68 e5 20 80 00       	push   $0x8020e5
  8002c2:	e8 5f 02 00 00       	call   800526 <_panic>
	}
	//make sure that the pages added to page file = 9MB / 4KB
	if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != (9<<8)+2 ) panic("Extra or less pages are allocated in PageFile");
  8002c7:	e8 17 17 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  8002cc:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8002cf:	3d 02 09 00 00       	cmp    $0x902,%eax
  8002d4:	74 14                	je     8002ea <_main+0x2b2>
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	68 64 21 80 00       	push   $0x802164
  8002de:	6a 2c                	push   $0x2c
  8002e0:	68 e5 20 80 00       	push   $0x8020e5
  8002e5:	e8 3c 02 00 00       	call   800526 <_panic>

	cprintf("Step A of test malloc completed successfully.\n\n\n");
  8002ea:	83 ec 0c             	sub    $0xc,%esp
  8002ed:	68 94 21 80 00       	push   $0x802194
  8002f2:	e8 e3 04 00 00       	call   8007da <cprintf>
  8002f7:	83 c4 10             	add    $0x10,%esp

	///====================

	int freeFrames = sys_calculate_free_frames() ;
  8002fa:	e8 61 16 00 00       	call   801960 <sys_calculate_free_frames>
  8002ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	{
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800302:	e8 dc 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  800307:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(2*kilo);
  80030a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80030d:	01 c0                	add    %eax,%eax
  80030f:	83 ec 0c             	sub    $0xc,%esp
  800312:	50                   	push   %eax
  800313:	e8 86 12 00 00       	call   80159e <malloc>
  800318:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  80031b:	e8 c3 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  800320:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800323:	74 14                	je     800339 <_main+0x301>
  800325:	83 ec 04             	sub    $0x4,%esp
  800328:	68 c8 21 80 00       	push   $0x8021c8
  80032d:	6a 36                	push   $0x36
  80032f:	68 e5 20 80 00       	push   $0x8020e5
  800334:	e8 ed 01 00 00       	call   800526 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800339:	e8 a5 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  80033e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(2*kilo);
  800341:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800344:	01 c0                	add    %eax,%eax
  800346:	83 ec 0c             	sub    $0xc,%esp
  800349:	50                   	push   %eax
  80034a:	e8 4f 12 00 00       	call   80159e <malloc>
  80034f:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  800352:	e8 8c 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  800357:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80035a:	83 f8 01             	cmp    $0x1,%eax
  80035d:	74 14                	je     800373 <_main+0x33b>
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	68 c8 21 80 00       	push   $0x8021c8
  800367:	6a 3a                	push   $0x3a
  800369:	68 e5 20 80 00       	push   $0x8020e5
  80036e:	e8 b3 01 00 00       	call   800526 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800373:	e8 6b 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  800378:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(3*kilo);
  80037b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037e:	89 c2                	mov    %eax,%edx
  800380:	01 d2                	add    %edx,%edx
  800382:	01 d0                	add    %edx,%eax
  800384:	83 ec 0c             	sub    $0xc,%esp
  800387:	50                   	push   %eax
  800388:	e8 11 12 00 00       	call   80159e <malloc>
  80038d:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 0 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  800390:	e8 4e 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  800395:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800398:	74 14                	je     8003ae <_main+0x376>
  80039a:	83 ec 04             	sub    $0x4,%esp
  80039d:	68 c8 21 80 00       	push   $0x8021c8
  8003a2:	6a 3e                	push   $0x3e
  8003a4:	68 e5 20 80 00       	push   $0x8020e5
  8003a9:	e8 78 01 00 00       	call   800526 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003ae:	e8 30 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  8003b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		malloc(3*kilo);
  8003b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b9:	89 c2                	mov    %eax,%edx
  8003bb:	01 d2                	add    %edx,%edx
  8003bd:	01 d0                	add    %edx,%eax
  8003bf:	83 ec 0c             	sub    $0xc,%esp
  8003c2:	50                   	push   %eax
  8003c3:	e8 d6 11 00 00       	call   80159e <malloc>
  8003c8:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile.. check allocation boundaries (make sure of rounding up and down)");
  8003cb:	e8 13 16 00 00       	call   8019e3 <sys_pf_calculate_allocated_pages>
  8003d0:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8003d3:	83 f8 01             	cmp    $0x1,%eax
  8003d6:	74 14                	je     8003ec <_main+0x3b4>
  8003d8:	83 ec 04             	sub    $0x4,%esp
  8003db:	68 c8 21 80 00       	push   $0x8021c8
  8003e0:	6a 42                	push   $0x42
  8003e2:	68 e5 20 80 00       	push   $0x8020e5
  8003e7:	e8 3a 01 00 00       	call   800526 <_panic>
	}

	if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: either extra pages are allocated in memory");
  8003ec:	e8 6f 15 00 00       	call   801960 <sys_calculate_free_frames>
  8003f1:	89 c2                	mov    %eax,%edx
  8003f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003f6:	39 c2                	cmp    %eax,%edx
  8003f8:	74 14                	je     80040e <_main+0x3d6>
  8003fa:	83 ec 04             	sub    $0x4,%esp
  8003fd:	68 38 22 80 00       	push   $0x802238
  800402:	6a 45                	push   $0x45
  800404:	68 e5 20 80 00       	push   $0x8020e5
  800409:	e8 18 01 00 00       	call   800526 <_panic>

	cprintf("Congratulations!! test malloc completed successfully.\n");
  80040e:	83 ec 0c             	sub    $0xc,%esp
  800411:	68 78 22 80 00       	push   $0x802278
  800416:	e8 bf 03 00 00       	call   8007da <cprintf>
  80041b:	83 c4 10             	add    $0x10,%esp

	return;
  80041e:	90                   	nop
}
  80041f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800422:	c9                   	leave  
  800423:	c3                   	ret    

00800424 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800424:	55                   	push   %ebp
  800425:	89 e5                	mov    %esp,%ebp
  800427:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80042a:	e8 66 14 00 00       	call   801895 <sys_getenvindex>
  80042f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800432:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800435:	89 d0                	mov    %edx,%eax
  800437:	01 c0                	add    %eax,%eax
  800439:	01 d0                	add    %edx,%eax
  80043b:	c1 e0 02             	shl    $0x2,%eax
  80043e:	01 d0                	add    %edx,%eax
  800440:	c1 e0 06             	shl    $0x6,%eax
  800443:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800448:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80044d:	a1 20 30 80 00       	mov    0x803020,%eax
  800452:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800458:	84 c0                	test   %al,%al
  80045a:	74 0f                	je     80046b <libmain+0x47>
		binaryname = myEnv->prog_name;
  80045c:	a1 20 30 80 00       	mov    0x803020,%eax
  800461:	05 f4 02 00 00       	add    $0x2f4,%eax
  800466:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80046b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80046f:	7e 0a                	jle    80047b <libmain+0x57>
		binaryname = argv[0];
  800471:	8b 45 0c             	mov    0xc(%ebp),%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80047b:	83 ec 08             	sub    $0x8,%esp
  80047e:	ff 75 0c             	pushl  0xc(%ebp)
  800481:	ff 75 08             	pushl  0x8(%ebp)
  800484:	e8 af fb ff ff       	call   800038 <_main>
  800489:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80048c:	e8 9f 15 00 00       	call   801a30 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800491:	83 ec 0c             	sub    $0xc,%esp
  800494:	68 c8 22 80 00       	push   $0x8022c8
  800499:	e8 3c 03 00 00       	call   8007da <cprintf>
  80049e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a6:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8004ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b1:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8004b7:	83 ec 04             	sub    $0x4,%esp
  8004ba:	52                   	push   %edx
  8004bb:	50                   	push   %eax
  8004bc:	68 f0 22 80 00       	push   $0x8022f0
  8004c1:	e8 14 03 00 00       	call   8007da <cprintf>
  8004c6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ce:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8004d4:	83 ec 08             	sub    $0x8,%esp
  8004d7:	50                   	push   %eax
  8004d8:	68 15 23 80 00       	push   $0x802315
  8004dd:	e8 f8 02 00 00       	call   8007da <cprintf>
  8004e2:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004e5:	83 ec 0c             	sub    $0xc,%esp
  8004e8:	68 c8 22 80 00       	push   $0x8022c8
  8004ed:	e8 e8 02 00 00       	call   8007da <cprintf>
  8004f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004f5:	e8 50 15 00 00       	call   801a4a <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004fa:	e8 19 00 00 00       	call   800518 <exit>
}
  8004ff:	90                   	nop
  800500:	c9                   	leave  
  800501:	c3                   	ret    

00800502 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800508:	83 ec 0c             	sub    $0xc,%esp
  80050b:	6a 00                	push   $0x0
  80050d:	e8 4f 13 00 00       	call   801861 <sys_env_destroy>
  800512:	83 c4 10             	add    $0x10,%esp
}
  800515:	90                   	nop
  800516:	c9                   	leave  
  800517:	c3                   	ret    

00800518 <exit>:

void
exit(void)
{
  800518:	55                   	push   %ebp
  800519:	89 e5                	mov    %esp,%ebp
  80051b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80051e:	e8 a4 13 00 00       	call   8018c7 <sys_env_exit>
}
  800523:	90                   	nop
  800524:	c9                   	leave  
  800525:	c3                   	ret    

00800526 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800526:	55                   	push   %ebp
  800527:	89 e5                	mov    %esp,%ebp
  800529:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80052c:	8d 45 10             	lea    0x10(%ebp),%eax
  80052f:	83 c0 04             	add    $0x4,%eax
  800532:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800535:	a1 30 30 80 00       	mov    0x803030,%eax
  80053a:	85 c0                	test   %eax,%eax
  80053c:	74 16                	je     800554 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80053e:	a1 30 30 80 00       	mov    0x803030,%eax
  800543:	83 ec 08             	sub    $0x8,%esp
  800546:	50                   	push   %eax
  800547:	68 2c 23 80 00       	push   $0x80232c
  80054c:	e8 89 02 00 00       	call   8007da <cprintf>
  800551:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800554:	a1 00 30 80 00       	mov    0x803000,%eax
  800559:	ff 75 0c             	pushl  0xc(%ebp)
  80055c:	ff 75 08             	pushl  0x8(%ebp)
  80055f:	50                   	push   %eax
  800560:	68 31 23 80 00       	push   $0x802331
  800565:	e8 70 02 00 00       	call   8007da <cprintf>
  80056a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80056d:	8b 45 10             	mov    0x10(%ebp),%eax
  800570:	83 ec 08             	sub    $0x8,%esp
  800573:	ff 75 f4             	pushl  -0xc(%ebp)
  800576:	50                   	push   %eax
  800577:	e8 f3 01 00 00       	call   80076f <vcprintf>
  80057c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80057f:	83 ec 08             	sub    $0x8,%esp
  800582:	6a 00                	push   $0x0
  800584:	68 4d 23 80 00       	push   $0x80234d
  800589:	e8 e1 01 00 00       	call   80076f <vcprintf>
  80058e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800591:	e8 82 ff ff ff       	call   800518 <exit>

	// should not return here
	while (1) ;
  800596:	eb fe                	jmp    800596 <_panic+0x70>

00800598 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800598:	55                   	push   %ebp
  800599:	89 e5                	mov    %esp,%ebp
  80059b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80059e:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a3:	8b 50 74             	mov    0x74(%eax),%edx
  8005a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a9:	39 c2                	cmp    %eax,%edx
  8005ab:	74 14                	je     8005c1 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005ad:	83 ec 04             	sub    $0x4,%esp
  8005b0:	68 50 23 80 00       	push   $0x802350
  8005b5:	6a 26                	push   $0x26
  8005b7:	68 9c 23 80 00       	push   $0x80239c
  8005bc:	e8 65 ff ff ff       	call   800526 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005cf:	e9 c2 00 00 00       	jmp    800696 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8005d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005de:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e1:	01 d0                	add    %edx,%eax
  8005e3:	8b 00                	mov    (%eax),%eax
  8005e5:	85 c0                	test   %eax,%eax
  8005e7:	75 08                	jne    8005f1 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005e9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005ec:	e9 a2 00 00 00       	jmp    800693 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8005f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005ff:	eb 69                	jmp    80066a <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800601:	a1 20 30 80 00       	mov    0x803020,%eax
  800606:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80060c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80060f:	89 d0                	mov    %edx,%eax
  800611:	01 c0                	add    %eax,%eax
  800613:	01 d0                	add    %edx,%eax
  800615:	c1 e0 02             	shl    $0x2,%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8a 40 04             	mov    0x4(%eax),%al
  80061d:	84 c0                	test   %al,%al
  80061f:	75 46                	jne    800667 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800621:	a1 20 30 80 00       	mov    0x803020,%eax
  800626:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80062c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80062f:	89 d0                	mov    %edx,%eax
  800631:	01 c0                	add    %eax,%eax
  800633:	01 d0                	add    %edx,%eax
  800635:	c1 e0 02             	shl    $0x2,%eax
  800638:	01 c8                	add    %ecx,%eax
  80063a:	8b 00                	mov    (%eax),%eax
  80063c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80063f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800642:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800647:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800649:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80064c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800653:	8b 45 08             	mov    0x8(%ebp),%eax
  800656:	01 c8                	add    %ecx,%eax
  800658:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80065a:	39 c2                	cmp    %eax,%edx
  80065c:	75 09                	jne    800667 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80065e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800665:	eb 12                	jmp    800679 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800667:	ff 45 e8             	incl   -0x18(%ebp)
  80066a:	a1 20 30 80 00       	mov    0x803020,%eax
  80066f:	8b 50 74             	mov    0x74(%eax),%edx
  800672:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800675:	39 c2                	cmp    %eax,%edx
  800677:	77 88                	ja     800601 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800679:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80067d:	75 14                	jne    800693 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	68 a8 23 80 00       	push   $0x8023a8
  800687:	6a 3a                	push   $0x3a
  800689:	68 9c 23 80 00       	push   $0x80239c
  80068e:	e8 93 fe ff ff       	call   800526 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800693:	ff 45 f0             	incl   -0x10(%ebp)
  800696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800699:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80069c:	0f 8c 32 ff ff ff    	jl     8005d4 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8006a2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006b0:	eb 26                	jmp    8006d8 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b7:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8006bd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c0:	89 d0                	mov    %edx,%eax
  8006c2:	01 c0                	add    %eax,%eax
  8006c4:	01 d0                	add    %edx,%eax
  8006c6:	c1 e0 02             	shl    $0x2,%eax
  8006c9:	01 c8                	add    %ecx,%eax
  8006cb:	8a 40 04             	mov    0x4(%eax),%al
  8006ce:	3c 01                	cmp    $0x1,%al
  8006d0:	75 03                	jne    8006d5 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8006d2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006d5:	ff 45 e0             	incl   -0x20(%ebp)
  8006d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8006dd:	8b 50 74             	mov    0x74(%eax),%edx
  8006e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006e3:	39 c2                	cmp    %eax,%edx
  8006e5:	77 cb                	ja     8006b2 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006ea:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006ed:	74 14                	je     800703 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8006ef:	83 ec 04             	sub    $0x4,%esp
  8006f2:	68 fc 23 80 00       	push   $0x8023fc
  8006f7:	6a 44                	push   $0x44
  8006f9:	68 9c 23 80 00       	push   $0x80239c
  8006fe:	e8 23 fe ff ff       	call   800526 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800703:	90                   	nop
  800704:	c9                   	leave  
  800705:	c3                   	ret    

00800706 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800706:	55                   	push   %ebp
  800707:	89 e5                	mov    %esp,%ebp
  800709:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80070c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80070f:	8b 00                	mov    (%eax),%eax
  800711:	8d 48 01             	lea    0x1(%eax),%ecx
  800714:	8b 55 0c             	mov    0xc(%ebp),%edx
  800717:	89 0a                	mov    %ecx,(%edx)
  800719:	8b 55 08             	mov    0x8(%ebp),%edx
  80071c:	88 d1                	mov    %dl,%cl
  80071e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800721:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800725:	8b 45 0c             	mov    0xc(%ebp),%eax
  800728:	8b 00                	mov    (%eax),%eax
  80072a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80072f:	75 2c                	jne    80075d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800731:	a0 24 30 80 00       	mov    0x803024,%al
  800736:	0f b6 c0             	movzbl %al,%eax
  800739:	8b 55 0c             	mov    0xc(%ebp),%edx
  80073c:	8b 12                	mov    (%edx),%edx
  80073e:	89 d1                	mov    %edx,%ecx
  800740:	8b 55 0c             	mov    0xc(%ebp),%edx
  800743:	83 c2 08             	add    $0x8,%edx
  800746:	83 ec 04             	sub    $0x4,%esp
  800749:	50                   	push   %eax
  80074a:	51                   	push   %ecx
  80074b:	52                   	push   %edx
  80074c:	e8 ce 10 00 00       	call   80181f <sys_cputs>
  800751:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800754:	8b 45 0c             	mov    0xc(%ebp),%eax
  800757:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80075d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800760:	8b 40 04             	mov    0x4(%eax),%eax
  800763:	8d 50 01             	lea    0x1(%eax),%edx
  800766:	8b 45 0c             	mov    0xc(%ebp),%eax
  800769:	89 50 04             	mov    %edx,0x4(%eax)
}
  80076c:	90                   	nop
  80076d:	c9                   	leave  
  80076e:	c3                   	ret    

0080076f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80076f:	55                   	push   %ebp
  800770:	89 e5                	mov    %esp,%ebp
  800772:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800778:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80077f:	00 00 00 
	b.cnt = 0;
  800782:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800789:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	ff 75 08             	pushl  0x8(%ebp)
  800792:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800798:	50                   	push   %eax
  800799:	68 06 07 80 00       	push   $0x800706
  80079e:	e8 11 02 00 00       	call   8009b4 <vprintfmt>
  8007a3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007a6:	a0 24 30 80 00       	mov    0x803024,%al
  8007ab:	0f b6 c0             	movzbl %al,%eax
  8007ae:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007b4:	83 ec 04             	sub    $0x4,%esp
  8007b7:	50                   	push   %eax
  8007b8:	52                   	push   %edx
  8007b9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007bf:	83 c0 08             	add    $0x8,%eax
  8007c2:	50                   	push   %eax
  8007c3:	e8 57 10 00 00       	call   80181f <sys_cputs>
  8007c8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007cb:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007d2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007d8:	c9                   	leave  
  8007d9:	c3                   	ret    

008007da <cprintf>:

int cprintf(const char *fmt, ...) {
  8007da:	55                   	push   %ebp
  8007db:	89 e5                	mov    %esp,%ebp
  8007dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007e0:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007e7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f0:	83 ec 08             	sub    $0x8,%esp
  8007f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f6:	50                   	push   %eax
  8007f7:	e8 73 ff ff ff       	call   80076f <vcprintf>
  8007fc:	83 c4 10             	add    $0x10,%esp
  8007ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800802:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800805:	c9                   	leave  
  800806:	c3                   	ret    

00800807 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800807:	55                   	push   %ebp
  800808:	89 e5                	mov    %esp,%ebp
  80080a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80080d:	e8 1e 12 00 00       	call   801a30 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800812:	8d 45 0c             	lea    0xc(%ebp),%eax
  800815:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 f4             	pushl  -0xc(%ebp)
  800821:	50                   	push   %eax
  800822:	e8 48 ff ff ff       	call   80076f <vcprintf>
  800827:	83 c4 10             	add    $0x10,%esp
  80082a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80082d:	e8 18 12 00 00       	call   801a4a <sys_enable_interrupt>
	return cnt;
  800832:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800835:	c9                   	leave  
  800836:	c3                   	ret    

00800837 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800837:	55                   	push   %ebp
  800838:	89 e5                	mov    %esp,%ebp
  80083a:	53                   	push   %ebx
  80083b:	83 ec 14             	sub    $0x14,%esp
  80083e:	8b 45 10             	mov    0x10(%ebp),%eax
  800841:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800844:	8b 45 14             	mov    0x14(%ebp),%eax
  800847:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80084a:	8b 45 18             	mov    0x18(%ebp),%eax
  80084d:	ba 00 00 00 00       	mov    $0x0,%edx
  800852:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800855:	77 55                	ja     8008ac <printnum+0x75>
  800857:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80085a:	72 05                	jb     800861 <printnum+0x2a>
  80085c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80085f:	77 4b                	ja     8008ac <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800861:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800864:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800867:	8b 45 18             	mov    0x18(%ebp),%eax
  80086a:	ba 00 00 00 00       	mov    $0x0,%edx
  80086f:	52                   	push   %edx
  800870:	50                   	push   %eax
  800871:	ff 75 f4             	pushl  -0xc(%ebp)
  800874:	ff 75 f0             	pushl  -0x10(%ebp)
  800877:	e8 94 15 00 00       	call   801e10 <__udivdi3>
  80087c:	83 c4 10             	add    $0x10,%esp
  80087f:	83 ec 04             	sub    $0x4,%esp
  800882:	ff 75 20             	pushl  0x20(%ebp)
  800885:	53                   	push   %ebx
  800886:	ff 75 18             	pushl  0x18(%ebp)
  800889:	52                   	push   %edx
  80088a:	50                   	push   %eax
  80088b:	ff 75 0c             	pushl  0xc(%ebp)
  80088e:	ff 75 08             	pushl  0x8(%ebp)
  800891:	e8 a1 ff ff ff       	call   800837 <printnum>
  800896:	83 c4 20             	add    $0x20,%esp
  800899:	eb 1a                	jmp    8008b5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	ff 75 0c             	pushl  0xc(%ebp)
  8008a1:	ff 75 20             	pushl  0x20(%ebp)
  8008a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a7:	ff d0                	call   *%eax
  8008a9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8008ac:	ff 4d 1c             	decl   0x1c(%ebp)
  8008af:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008b3:	7f e6                	jg     80089b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008b5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008b8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c3:	53                   	push   %ebx
  8008c4:	51                   	push   %ecx
  8008c5:	52                   	push   %edx
  8008c6:	50                   	push   %eax
  8008c7:	e8 54 16 00 00       	call   801f20 <__umoddi3>
  8008cc:	83 c4 10             	add    $0x10,%esp
  8008cf:	05 74 26 80 00       	add    $0x802674,%eax
  8008d4:	8a 00                	mov    (%eax),%al
  8008d6:	0f be c0             	movsbl %al,%eax
  8008d9:	83 ec 08             	sub    $0x8,%esp
  8008dc:	ff 75 0c             	pushl  0xc(%ebp)
  8008df:	50                   	push   %eax
  8008e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e3:	ff d0                	call   *%eax
  8008e5:	83 c4 10             	add    $0x10,%esp
}
  8008e8:	90                   	nop
  8008e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008f1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008f5:	7e 1c                	jle    800913 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fa:	8b 00                	mov    (%eax),%eax
  8008fc:	8d 50 08             	lea    0x8(%eax),%edx
  8008ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800902:	89 10                	mov    %edx,(%eax)
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	8b 00                	mov    (%eax),%eax
  800909:	83 e8 08             	sub    $0x8,%eax
  80090c:	8b 50 04             	mov    0x4(%eax),%edx
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	eb 40                	jmp    800953 <getuint+0x65>
	else if (lflag)
  800913:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800917:	74 1e                	je     800937 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800919:	8b 45 08             	mov    0x8(%ebp),%eax
  80091c:	8b 00                	mov    (%eax),%eax
  80091e:	8d 50 04             	lea    0x4(%eax),%edx
  800921:	8b 45 08             	mov    0x8(%ebp),%eax
  800924:	89 10                	mov    %edx,(%eax)
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	8b 00                	mov    (%eax),%eax
  80092b:	83 e8 04             	sub    $0x4,%eax
  80092e:	8b 00                	mov    (%eax),%eax
  800930:	ba 00 00 00 00       	mov    $0x0,%edx
  800935:	eb 1c                	jmp    800953 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	8b 00                	mov    (%eax),%eax
  80093c:	8d 50 04             	lea    0x4(%eax),%edx
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	89 10                	mov    %edx,(%eax)
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	8b 00                	mov    (%eax),%eax
  800949:	83 e8 04             	sub    $0x4,%eax
  80094c:	8b 00                	mov    (%eax),%eax
  80094e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800953:	5d                   	pop    %ebp
  800954:	c3                   	ret    

00800955 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800955:	55                   	push   %ebp
  800956:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800958:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80095c:	7e 1c                	jle    80097a <getint+0x25>
		return va_arg(*ap, long long);
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	8b 00                	mov    (%eax),%eax
  800963:	8d 50 08             	lea    0x8(%eax),%edx
  800966:	8b 45 08             	mov    0x8(%ebp),%eax
  800969:	89 10                	mov    %edx,(%eax)
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	8b 00                	mov    (%eax),%eax
  800970:	83 e8 08             	sub    $0x8,%eax
  800973:	8b 50 04             	mov    0x4(%eax),%edx
  800976:	8b 00                	mov    (%eax),%eax
  800978:	eb 38                	jmp    8009b2 <getint+0x5d>
	else if (lflag)
  80097a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80097e:	74 1a                	je     80099a <getint+0x45>
		return va_arg(*ap, long);
  800980:	8b 45 08             	mov    0x8(%ebp),%eax
  800983:	8b 00                	mov    (%eax),%eax
  800985:	8d 50 04             	lea    0x4(%eax),%edx
  800988:	8b 45 08             	mov    0x8(%ebp),%eax
  80098b:	89 10                	mov    %edx,(%eax)
  80098d:	8b 45 08             	mov    0x8(%ebp),%eax
  800990:	8b 00                	mov    (%eax),%eax
  800992:	83 e8 04             	sub    $0x4,%eax
  800995:	8b 00                	mov    (%eax),%eax
  800997:	99                   	cltd   
  800998:	eb 18                	jmp    8009b2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	8d 50 04             	lea    0x4(%eax),%edx
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	89 10                	mov    %edx,(%eax)
  8009a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009aa:	8b 00                	mov    (%eax),%eax
  8009ac:	83 e8 04             	sub    $0x4,%eax
  8009af:	8b 00                	mov    (%eax),%eax
  8009b1:	99                   	cltd   
}
  8009b2:	5d                   	pop    %ebp
  8009b3:	c3                   	ret    

008009b4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009b4:	55                   	push   %ebp
  8009b5:	89 e5                	mov    %esp,%ebp
  8009b7:	56                   	push   %esi
  8009b8:	53                   	push   %ebx
  8009b9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009bc:	eb 17                	jmp    8009d5 <vprintfmt+0x21>
			if (ch == '\0')
  8009be:	85 db                	test   %ebx,%ebx
  8009c0:	0f 84 af 03 00 00    	je     800d75 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009c6:	83 ec 08             	sub    $0x8,%esp
  8009c9:	ff 75 0c             	pushl  0xc(%ebp)
  8009cc:	53                   	push   %ebx
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	ff d0                	call   *%eax
  8009d2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8009d8:	8d 50 01             	lea    0x1(%eax),%edx
  8009db:	89 55 10             	mov    %edx,0x10(%ebp)
  8009de:	8a 00                	mov    (%eax),%al
  8009e0:	0f b6 d8             	movzbl %al,%ebx
  8009e3:	83 fb 25             	cmp    $0x25,%ebx
  8009e6:	75 d6                	jne    8009be <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009e8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009ec:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009f3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009fa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a01:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a08:	8b 45 10             	mov    0x10(%ebp),%eax
  800a0b:	8d 50 01             	lea    0x1(%eax),%edx
  800a0e:	89 55 10             	mov    %edx,0x10(%ebp)
  800a11:	8a 00                	mov    (%eax),%al
  800a13:	0f b6 d8             	movzbl %al,%ebx
  800a16:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a19:	83 f8 55             	cmp    $0x55,%eax
  800a1c:	0f 87 2b 03 00 00    	ja     800d4d <vprintfmt+0x399>
  800a22:	8b 04 85 98 26 80 00 	mov    0x802698(,%eax,4),%eax
  800a29:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a2b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a2f:	eb d7                	jmp    800a08 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a31:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a35:	eb d1                	jmp    800a08 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a37:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a3e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a41:	89 d0                	mov    %edx,%eax
  800a43:	c1 e0 02             	shl    $0x2,%eax
  800a46:	01 d0                	add    %edx,%eax
  800a48:	01 c0                	add    %eax,%eax
  800a4a:	01 d8                	add    %ebx,%eax
  800a4c:	83 e8 30             	sub    $0x30,%eax
  800a4f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a52:	8b 45 10             	mov    0x10(%ebp),%eax
  800a55:	8a 00                	mov    (%eax),%al
  800a57:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a5a:	83 fb 2f             	cmp    $0x2f,%ebx
  800a5d:	7e 3e                	jle    800a9d <vprintfmt+0xe9>
  800a5f:	83 fb 39             	cmp    $0x39,%ebx
  800a62:	7f 39                	jg     800a9d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a64:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a67:	eb d5                	jmp    800a3e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a69:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6c:	83 c0 04             	add    $0x4,%eax
  800a6f:	89 45 14             	mov    %eax,0x14(%ebp)
  800a72:	8b 45 14             	mov    0x14(%ebp),%eax
  800a75:	83 e8 04             	sub    $0x4,%eax
  800a78:	8b 00                	mov    (%eax),%eax
  800a7a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a7d:	eb 1f                	jmp    800a9e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a83:	79 83                	jns    800a08 <vprintfmt+0x54>
				width = 0;
  800a85:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a8c:	e9 77 ff ff ff       	jmp    800a08 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a91:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a98:	e9 6b ff ff ff       	jmp    800a08 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a9d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a9e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa2:	0f 89 60 ff ff ff    	jns    800a08 <vprintfmt+0x54>
				width = precision, precision = -1;
  800aa8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800aae:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ab5:	e9 4e ff ff ff       	jmp    800a08 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800aba:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800abd:	e9 46 ff ff ff       	jmp    800a08 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ac2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac5:	83 c0 04             	add    $0x4,%eax
  800ac8:	89 45 14             	mov    %eax,0x14(%ebp)
  800acb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ace:	83 e8 04             	sub    $0x4,%eax
  800ad1:	8b 00                	mov    (%eax),%eax
  800ad3:	83 ec 08             	sub    $0x8,%esp
  800ad6:	ff 75 0c             	pushl  0xc(%ebp)
  800ad9:	50                   	push   %eax
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	ff d0                	call   *%eax
  800adf:	83 c4 10             	add    $0x10,%esp
			break;
  800ae2:	e9 89 02 00 00       	jmp    800d70 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ae7:	8b 45 14             	mov    0x14(%ebp),%eax
  800aea:	83 c0 04             	add    $0x4,%eax
  800aed:	89 45 14             	mov    %eax,0x14(%ebp)
  800af0:	8b 45 14             	mov    0x14(%ebp),%eax
  800af3:	83 e8 04             	sub    $0x4,%eax
  800af6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800af8:	85 db                	test   %ebx,%ebx
  800afa:	79 02                	jns    800afe <vprintfmt+0x14a>
				err = -err;
  800afc:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800afe:	83 fb 64             	cmp    $0x64,%ebx
  800b01:	7f 0b                	jg     800b0e <vprintfmt+0x15a>
  800b03:	8b 34 9d e0 24 80 00 	mov    0x8024e0(,%ebx,4),%esi
  800b0a:	85 f6                	test   %esi,%esi
  800b0c:	75 19                	jne    800b27 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b0e:	53                   	push   %ebx
  800b0f:	68 85 26 80 00       	push   $0x802685
  800b14:	ff 75 0c             	pushl  0xc(%ebp)
  800b17:	ff 75 08             	pushl  0x8(%ebp)
  800b1a:	e8 5e 02 00 00       	call   800d7d <printfmt>
  800b1f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b22:	e9 49 02 00 00       	jmp    800d70 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b27:	56                   	push   %esi
  800b28:	68 8e 26 80 00       	push   $0x80268e
  800b2d:	ff 75 0c             	pushl  0xc(%ebp)
  800b30:	ff 75 08             	pushl  0x8(%ebp)
  800b33:	e8 45 02 00 00       	call   800d7d <printfmt>
  800b38:	83 c4 10             	add    $0x10,%esp
			break;
  800b3b:	e9 30 02 00 00       	jmp    800d70 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b40:	8b 45 14             	mov    0x14(%ebp),%eax
  800b43:	83 c0 04             	add    $0x4,%eax
  800b46:	89 45 14             	mov    %eax,0x14(%ebp)
  800b49:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4c:	83 e8 04             	sub    $0x4,%eax
  800b4f:	8b 30                	mov    (%eax),%esi
  800b51:	85 f6                	test   %esi,%esi
  800b53:	75 05                	jne    800b5a <vprintfmt+0x1a6>
				p = "(null)";
  800b55:	be 91 26 80 00       	mov    $0x802691,%esi
			if (width > 0 && padc != '-')
  800b5a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b5e:	7e 6d                	jle    800bcd <vprintfmt+0x219>
  800b60:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b64:	74 67                	je     800bcd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b66:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b69:	83 ec 08             	sub    $0x8,%esp
  800b6c:	50                   	push   %eax
  800b6d:	56                   	push   %esi
  800b6e:	e8 0c 03 00 00       	call   800e7f <strnlen>
  800b73:	83 c4 10             	add    $0x10,%esp
  800b76:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b79:	eb 16                	jmp    800b91 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b7b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b7f:	83 ec 08             	sub    $0x8,%esp
  800b82:	ff 75 0c             	pushl  0xc(%ebp)
  800b85:	50                   	push   %eax
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	ff d0                	call   *%eax
  800b8b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b8e:	ff 4d e4             	decl   -0x1c(%ebp)
  800b91:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b95:	7f e4                	jg     800b7b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b97:	eb 34                	jmp    800bcd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b99:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b9d:	74 1c                	je     800bbb <vprintfmt+0x207>
  800b9f:	83 fb 1f             	cmp    $0x1f,%ebx
  800ba2:	7e 05                	jle    800ba9 <vprintfmt+0x1f5>
  800ba4:	83 fb 7e             	cmp    $0x7e,%ebx
  800ba7:	7e 12                	jle    800bbb <vprintfmt+0x207>
					putch('?', putdat);
  800ba9:	83 ec 08             	sub    $0x8,%esp
  800bac:	ff 75 0c             	pushl  0xc(%ebp)
  800baf:	6a 3f                	push   $0x3f
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	ff d0                	call   *%eax
  800bb6:	83 c4 10             	add    $0x10,%esp
  800bb9:	eb 0f                	jmp    800bca <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800bbb:	83 ec 08             	sub    $0x8,%esp
  800bbe:	ff 75 0c             	pushl  0xc(%ebp)
  800bc1:	53                   	push   %ebx
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	ff d0                	call   *%eax
  800bc7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bca:	ff 4d e4             	decl   -0x1c(%ebp)
  800bcd:	89 f0                	mov    %esi,%eax
  800bcf:	8d 70 01             	lea    0x1(%eax),%esi
  800bd2:	8a 00                	mov    (%eax),%al
  800bd4:	0f be d8             	movsbl %al,%ebx
  800bd7:	85 db                	test   %ebx,%ebx
  800bd9:	74 24                	je     800bff <vprintfmt+0x24b>
  800bdb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bdf:	78 b8                	js     800b99 <vprintfmt+0x1e5>
  800be1:	ff 4d e0             	decl   -0x20(%ebp)
  800be4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800be8:	79 af                	jns    800b99 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bea:	eb 13                	jmp    800bff <vprintfmt+0x24b>
				putch(' ', putdat);
  800bec:	83 ec 08             	sub    $0x8,%esp
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	6a 20                	push   $0x20
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	ff d0                	call   *%eax
  800bf9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bfc:	ff 4d e4             	decl   -0x1c(%ebp)
  800bff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c03:	7f e7                	jg     800bec <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c05:	e9 66 01 00 00       	jmp    800d70 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c0a:	83 ec 08             	sub    $0x8,%esp
  800c0d:	ff 75 e8             	pushl  -0x18(%ebp)
  800c10:	8d 45 14             	lea    0x14(%ebp),%eax
  800c13:	50                   	push   %eax
  800c14:	e8 3c fd ff ff       	call   800955 <getint>
  800c19:	83 c4 10             	add    $0x10,%esp
  800c1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c25:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c28:	85 d2                	test   %edx,%edx
  800c2a:	79 23                	jns    800c4f <vprintfmt+0x29b>
				putch('-', putdat);
  800c2c:	83 ec 08             	sub    $0x8,%esp
  800c2f:	ff 75 0c             	pushl  0xc(%ebp)
  800c32:	6a 2d                	push   $0x2d
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	ff d0                	call   *%eax
  800c39:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c42:	f7 d8                	neg    %eax
  800c44:	83 d2 00             	adc    $0x0,%edx
  800c47:	f7 da                	neg    %edx
  800c49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c4f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c56:	e9 bc 00 00 00       	jmp    800d17 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c5b:	83 ec 08             	sub    $0x8,%esp
  800c5e:	ff 75 e8             	pushl  -0x18(%ebp)
  800c61:	8d 45 14             	lea    0x14(%ebp),%eax
  800c64:	50                   	push   %eax
  800c65:	e8 84 fc ff ff       	call   8008ee <getuint>
  800c6a:	83 c4 10             	add    $0x10,%esp
  800c6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c73:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c7a:	e9 98 00 00 00       	jmp    800d17 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c7f:	83 ec 08             	sub    $0x8,%esp
  800c82:	ff 75 0c             	pushl  0xc(%ebp)
  800c85:	6a 58                	push   $0x58
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	ff d0                	call   *%eax
  800c8c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c8f:	83 ec 08             	sub    $0x8,%esp
  800c92:	ff 75 0c             	pushl  0xc(%ebp)
  800c95:	6a 58                	push   $0x58
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	ff d0                	call   *%eax
  800c9c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c9f:	83 ec 08             	sub    $0x8,%esp
  800ca2:	ff 75 0c             	pushl  0xc(%ebp)
  800ca5:	6a 58                	push   $0x58
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	ff d0                	call   *%eax
  800cac:	83 c4 10             	add    $0x10,%esp
			break;
  800caf:	e9 bc 00 00 00       	jmp    800d70 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800cb4:	83 ec 08             	sub    $0x8,%esp
  800cb7:	ff 75 0c             	pushl  0xc(%ebp)
  800cba:	6a 30                	push   $0x30
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	ff d0                	call   *%eax
  800cc1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cc4:	83 ec 08             	sub    $0x8,%esp
  800cc7:	ff 75 0c             	pushl  0xc(%ebp)
  800cca:	6a 78                	push   $0x78
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	ff d0                	call   *%eax
  800cd1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cd4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd7:	83 c0 04             	add    $0x4,%eax
  800cda:	89 45 14             	mov    %eax,0x14(%ebp)
  800cdd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce0:	83 e8 04             	sub    $0x4,%eax
  800ce3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ce5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cef:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800cf6:	eb 1f                	jmp    800d17 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800cf8:	83 ec 08             	sub    $0x8,%esp
  800cfb:	ff 75 e8             	pushl  -0x18(%ebp)
  800cfe:	8d 45 14             	lea    0x14(%ebp),%eax
  800d01:	50                   	push   %eax
  800d02:	e8 e7 fb ff ff       	call   8008ee <getuint>
  800d07:	83 c4 10             	add    $0x10,%esp
  800d0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d0d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d10:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d17:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d1e:	83 ec 04             	sub    $0x4,%esp
  800d21:	52                   	push   %edx
  800d22:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d25:	50                   	push   %eax
  800d26:	ff 75 f4             	pushl  -0xc(%ebp)
  800d29:	ff 75 f0             	pushl  -0x10(%ebp)
  800d2c:	ff 75 0c             	pushl  0xc(%ebp)
  800d2f:	ff 75 08             	pushl  0x8(%ebp)
  800d32:	e8 00 fb ff ff       	call   800837 <printnum>
  800d37:	83 c4 20             	add    $0x20,%esp
			break;
  800d3a:	eb 34                	jmp    800d70 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d3c:	83 ec 08             	sub    $0x8,%esp
  800d3f:	ff 75 0c             	pushl  0xc(%ebp)
  800d42:	53                   	push   %ebx
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	ff d0                	call   *%eax
  800d48:	83 c4 10             	add    $0x10,%esp
			break;
  800d4b:	eb 23                	jmp    800d70 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d4d:	83 ec 08             	sub    $0x8,%esp
  800d50:	ff 75 0c             	pushl  0xc(%ebp)
  800d53:	6a 25                	push   $0x25
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	ff d0                	call   *%eax
  800d5a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d5d:	ff 4d 10             	decl   0x10(%ebp)
  800d60:	eb 03                	jmp    800d65 <vprintfmt+0x3b1>
  800d62:	ff 4d 10             	decl   0x10(%ebp)
  800d65:	8b 45 10             	mov    0x10(%ebp),%eax
  800d68:	48                   	dec    %eax
  800d69:	8a 00                	mov    (%eax),%al
  800d6b:	3c 25                	cmp    $0x25,%al
  800d6d:	75 f3                	jne    800d62 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d6f:	90                   	nop
		}
	}
  800d70:	e9 47 fc ff ff       	jmp    8009bc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d75:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d76:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d79:	5b                   	pop    %ebx
  800d7a:	5e                   	pop    %esi
  800d7b:	5d                   	pop    %ebp
  800d7c:	c3                   	ret    

00800d7d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d7d:	55                   	push   %ebp
  800d7e:	89 e5                	mov    %esp,%ebp
  800d80:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d83:	8d 45 10             	lea    0x10(%ebp),%eax
  800d86:	83 c0 04             	add    $0x4,%eax
  800d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8f:	ff 75 f4             	pushl  -0xc(%ebp)
  800d92:	50                   	push   %eax
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	ff 75 08             	pushl  0x8(%ebp)
  800d99:	e8 16 fc ff ff       	call   8009b4 <vprintfmt>
  800d9e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800da1:	90                   	nop
  800da2:	c9                   	leave  
  800da3:	c3                   	ret    

00800da4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800da4:	55                   	push   %ebp
  800da5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800da7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daa:	8b 40 08             	mov    0x8(%eax),%eax
  800dad:	8d 50 01             	lea    0x1(%eax),%edx
  800db0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800db6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db9:	8b 10                	mov    (%eax),%edx
  800dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbe:	8b 40 04             	mov    0x4(%eax),%eax
  800dc1:	39 c2                	cmp    %eax,%edx
  800dc3:	73 12                	jae    800dd7 <sprintputch+0x33>
		*b->buf++ = ch;
  800dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc8:	8b 00                	mov    (%eax),%eax
  800dca:	8d 48 01             	lea    0x1(%eax),%ecx
  800dcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd0:	89 0a                	mov    %ecx,(%edx)
  800dd2:	8b 55 08             	mov    0x8(%ebp),%edx
  800dd5:	88 10                	mov    %dl,(%eax)
}
  800dd7:	90                   	nop
  800dd8:	5d                   	pop    %ebp
  800dd9:	c3                   	ret    

00800dda <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800dda:	55                   	push   %ebp
  800ddb:	89 e5                	mov    %esp,%ebp
  800ddd:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	01 d0                	add    %edx,%eax
  800df1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800dfb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dff:	74 06                	je     800e07 <vsnprintf+0x2d>
  800e01:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e05:	7f 07                	jg     800e0e <vsnprintf+0x34>
		return -E_INVAL;
  800e07:	b8 03 00 00 00       	mov    $0x3,%eax
  800e0c:	eb 20                	jmp    800e2e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e0e:	ff 75 14             	pushl  0x14(%ebp)
  800e11:	ff 75 10             	pushl  0x10(%ebp)
  800e14:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e17:	50                   	push   %eax
  800e18:	68 a4 0d 80 00       	push   $0x800da4
  800e1d:	e8 92 fb ff ff       	call   8009b4 <vprintfmt>
  800e22:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e28:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e2e:	c9                   	leave  
  800e2f:	c3                   	ret    

00800e30 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e30:	55                   	push   %ebp
  800e31:	89 e5                	mov    %esp,%ebp
  800e33:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e36:	8d 45 10             	lea    0x10(%ebp),%eax
  800e39:	83 c0 04             	add    $0x4,%eax
  800e3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e42:	ff 75 f4             	pushl  -0xc(%ebp)
  800e45:	50                   	push   %eax
  800e46:	ff 75 0c             	pushl  0xc(%ebp)
  800e49:	ff 75 08             	pushl  0x8(%ebp)
  800e4c:	e8 89 ff ff ff       	call   800dda <vsnprintf>
  800e51:	83 c4 10             	add    $0x10,%esp
  800e54:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e5a:	c9                   	leave  
  800e5b:	c3                   	ret    

00800e5c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e5c:	55                   	push   %ebp
  800e5d:	89 e5                	mov    %esp,%ebp
  800e5f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e69:	eb 06                	jmp    800e71 <strlen+0x15>
		n++;
  800e6b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e6e:	ff 45 08             	incl   0x8(%ebp)
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	84 c0                	test   %al,%al
  800e78:	75 f1                	jne    800e6b <strlen+0xf>
		n++;
	return n;
  800e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e7d:	c9                   	leave  
  800e7e:	c3                   	ret    

00800e7f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e7f:	55                   	push   %ebp
  800e80:	89 e5                	mov    %esp,%ebp
  800e82:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e8c:	eb 09                	jmp    800e97 <strnlen+0x18>
		n++;
  800e8e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e91:	ff 45 08             	incl   0x8(%ebp)
  800e94:	ff 4d 0c             	decl   0xc(%ebp)
  800e97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e9b:	74 09                	je     800ea6 <strnlen+0x27>
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	8a 00                	mov    (%eax),%al
  800ea2:	84 c0                	test   %al,%al
  800ea4:	75 e8                	jne    800e8e <strnlen+0xf>
		n++;
	return n;
  800ea6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ea9:	c9                   	leave  
  800eaa:	c3                   	ret    

00800eab <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800eab:	55                   	push   %ebp
  800eac:	89 e5                	mov    %esp,%ebp
  800eae:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800eb7:	90                   	nop
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	8d 50 01             	lea    0x1(%eax),%edx
  800ebe:	89 55 08             	mov    %edx,0x8(%ebp)
  800ec1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ec4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ec7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eca:	8a 12                	mov    (%edx),%dl
  800ecc:	88 10                	mov    %dl,(%eax)
  800ece:	8a 00                	mov    (%eax),%al
  800ed0:	84 c0                	test   %al,%al
  800ed2:	75 e4                	jne    800eb8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ed4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ed7:	c9                   	leave  
  800ed8:	c3                   	ret    

00800ed9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ed9:	55                   	push   %ebp
  800eda:	89 e5                	mov    %esp,%ebp
  800edc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ee5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eec:	eb 1f                	jmp    800f0d <strncpy+0x34>
		*dst++ = *src;
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8d 50 01             	lea    0x1(%eax),%edx
  800ef4:	89 55 08             	mov    %edx,0x8(%ebp)
  800ef7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800efa:	8a 12                	mov    (%edx),%dl
  800efc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800efe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	84 c0                	test   %al,%al
  800f05:	74 03                	je     800f0a <strncpy+0x31>
			src++;
  800f07:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f0a:	ff 45 fc             	incl   -0x4(%ebp)
  800f0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f10:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f13:	72 d9                	jb     800eee <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f15:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f18:	c9                   	leave  
  800f19:	c3                   	ret    

00800f1a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f1a:	55                   	push   %ebp
  800f1b:	89 e5                	mov    %esp,%ebp
  800f1d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2a:	74 30                	je     800f5c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f2c:	eb 16                	jmp    800f44 <strlcpy+0x2a>
			*dst++ = *src++;
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	8d 50 01             	lea    0x1(%eax),%edx
  800f34:	89 55 08             	mov    %edx,0x8(%ebp)
  800f37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f3a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f3d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f40:	8a 12                	mov    (%edx),%dl
  800f42:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f44:	ff 4d 10             	decl   0x10(%ebp)
  800f47:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4b:	74 09                	je     800f56 <strlcpy+0x3c>
  800f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f50:	8a 00                	mov    (%eax),%al
  800f52:	84 c0                	test   %al,%al
  800f54:	75 d8                	jne    800f2e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
  800f59:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f5c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f62:	29 c2                	sub    %eax,%edx
  800f64:	89 d0                	mov    %edx,%eax
}
  800f66:	c9                   	leave  
  800f67:	c3                   	ret    

00800f68 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f68:	55                   	push   %ebp
  800f69:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f6b:	eb 06                	jmp    800f73 <strcmp+0xb>
		p++, q++;
  800f6d:	ff 45 08             	incl   0x8(%ebp)
  800f70:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	84 c0                	test   %al,%al
  800f7a:	74 0e                	je     800f8a <strcmp+0x22>
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 10                	mov    (%eax),%dl
  800f81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	38 c2                	cmp    %al,%dl
  800f88:	74 e3                	je     800f6d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	0f b6 d0             	movzbl %al,%edx
  800f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	0f b6 c0             	movzbl %al,%eax
  800f9a:	29 c2                	sub    %eax,%edx
  800f9c:	89 d0                	mov    %edx,%eax
}
  800f9e:	5d                   	pop    %ebp
  800f9f:	c3                   	ret    

00800fa0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800fa3:	eb 09                	jmp    800fae <strncmp+0xe>
		n--, p++, q++;
  800fa5:	ff 4d 10             	decl   0x10(%ebp)
  800fa8:	ff 45 08             	incl   0x8(%ebp)
  800fab:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800fae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fb2:	74 17                	je     800fcb <strncmp+0x2b>
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	84 c0                	test   %al,%al
  800fbb:	74 0e                	je     800fcb <strncmp+0x2b>
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 10                	mov    (%eax),%dl
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8a 00                	mov    (%eax),%al
  800fc7:	38 c2                	cmp    %al,%dl
  800fc9:	74 da                	je     800fa5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fcb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fcf:	75 07                	jne    800fd8 <strncmp+0x38>
		return 0;
  800fd1:	b8 00 00 00 00       	mov    $0x0,%eax
  800fd6:	eb 14                	jmp    800fec <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	0f b6 d0             	movzbl %al,%edx
  800fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f b6 c0             	movzbl %al,%eax
  800fe8:	29 c2                	sub    %eax,%edx
  800fea:	89 d0                	mov    %edx,%eax
}
  800fec:	5d                   	pop    %ebp
  800fed:	c3                   	ret    

00800fee <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fee:	55                   	push   %ebp
  800fef:	89 e5                	mov    %esp,%ebp
  800ff1:	83 ec 04             	sub    $0x4,%esp
  800ff4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ffa:	eb 12                	jmp    80100e <strchr+0x20>
		if (*s == c)
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801004:	75 05                	jne    80100b <strchr+0x1d>
			return (char *) s;
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	eb 11                	jmp    80101c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80100b:	ff 45 08             	incl   0x8(%ebp)
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	84 c0                	test   %al,%al
  801015:	75 e5                	jne    800ffc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801017:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80101c:	c9                   	leave  
  80101d:	c3                   	ret    

0080101e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80101e:	55                   	push   %ebp
  80101f:	89 e5                	mov    %esp,%ebp
  801021:	83 ec 04             	sub    $0x4,%esp
  801024:	8b 45 0c             	mov    0xc(%ebp),%eax
  801027:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80102a:	eb 0d                	jmp    801039 <strfind+0x1b>
		if (*s == c)
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	8a 00                	mov    (%eax),%al
  801031:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801034:	74 0e                	je     801044 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801036:	ff 45 08             	incl   0x8(%ebp)
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	8a 00                	mov    (%eax),%al
  80103e:	84 c0                	test   %al,%al
  801040:	75 ea                	jne    80102c <strfind+0xe>
  801042:	eb 01                	jmp    801045 <strfind+0x27>
		if (*s == c)
			break;
  801044:	90                   	nop
	return (char *) s;
  801045:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801056:	8b 45 10             	mov    0x10(%ebp),%eax
  801059:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80105c:	eb 0e                	jmp    80106c <memset+0x22>
		*p++ = c;
  80105e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801061:	8d 50 01             	lea    0x1(%eax),%edx
  801064:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801067:	8b 55 0c             	mov    0xc(%ebp),%edx
  80106a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80106c:	ff 4d f8             	decl   -0x8(%ebp)
  80106f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801073:	79 e9                	jns    80105e <memset+0x14>
		*p++ = c;

	return v;
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801078:	c9                   	leave  
  801079:	c3                   	ret    

0080107a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80107a:	55                   	push   %ebp
  80107b:	89 e5                	mov    %esp,%ebp
  80107d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801080:	8b 45 0c             	mov    0xc(%ebp),%eax
  801083:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80108c:	eb 16                	jmp    8010a4 <memcpy+0x2a>
		*d++ = *s++;
  80108e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801091:	8d 50 01             	lea    0x1(%eax),%edx
  801094:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801097:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80109a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a0:	8a 12                	mov    (%edx),%dl
  8010a2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ad:	85 c0                	test   %eax,%eax
  8010af:	75 dd                	jne    80108e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010b4:	c9                   	leave  
  8010b5:	c3                   	ret    

008010b6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010b6:	55                   	push   %ebp
  8010b7:	89 e5                	mov    %esp,%ebp
  8010b9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8010bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010ce:	73 50                	jae    801120 <memmove+0x6a>
  8010d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d6:	01 d0                	add    %edx,%eax
  8010d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010db:	76 43                	jbe    801120 <memmove+0x6a>
		s += n;
  8010dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010e9:	eb 10                	jmp    8010fb <memmove+0x45>
			*--d = *--s;
  8010eb:	ff 4d f8             	decl   -0x8(%ebp)
  8010ee:	ff 4d fc             	decl   -0x4(%ebp)
  8010f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f4:	8a 10                	mov    (%eax),%dl
  8010f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801101:	89 55 10             	mov    %edx,0x10(%ebp)
  801104:	85 c0                	test   %eax,%eax
  801106:	75 e3                	jne    8010eb <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801108:	eb 23                	jmp    80112d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80110a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110d:	8d 50 01             	lea    0x1(%eax),%edx
  801110:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801113:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801116:	8d 4a 01             	lea    0x1(%edx),%ecx
  801119:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80111c:	8a 12                	mov    (%edx),%dl
  80111e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801120:	8b 45 10             	mov    0x10(%ebp),%eax
  801123:	8d 50 ff             	lea    -0x1(%eax),%edx
  801126:	89 55 10             	mov    %edx,0x10(%ebp)
  801129:	85 c0                	test   %eax,%eax
  80112b:	75 dd                	jne    80110a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80112d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801130:	c9                   	leave  
  801131:	c3                   	ret    

00801132 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801132:	55                   	push   %ebp
  801133:	89 e5                	mov    %esp,%ebp
  801135:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80113e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801141:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801144:	eb 2a                	jmp    801170 <memcmp+0x3e>
		if (*s1 != *s2)
  801146:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801149:	8a 10                	mov    (%eax),%dl
  80114b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	38 c2                	cmp    %al,%dl
  801152:	74 16                	je     80116a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801154:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	0f b6 d0             	movzbl %al,%edx
  80115c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115f:	8a 00                	mov    (%eax),%al
  801161:	0f b6 c0             	movzbl %al,%eax
  801164:	29 c2                	sub    %eax,%edx
  801166:	89 d0                	mov    %edx,%eax
  801168:	eb 18                	jmp    801182 <memcmp+0x50>
		s1++, s2++;
  80116a:	ff 45 fc             	incl   -0x4(%ebp)
  80116d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801170:	8b 45 10             	mov    0x10(%ebp),%eax
  801173:	8d 50 ff             	lea    -0x1(%eax),%edx
  801176:	89 55 10             	mov    %edx,0x10(%ebp)
  801179:	85 c0                	test   %eax,%eax
  80117b:	75 c9                	jne    801146 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80117d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801182:	c9                   	leave  
  801183:	c3                   	ret    

00801184 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801184:	55                   	push   %ebp
  801185:	89 e5                	mov    %esp,%ebp
  801187:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80118a:	8b 55 08             	mov    0x8(%ebp),%edx
  80118d:	8b 45 10             	mov    0x10(%ebp),%eax
  801190:	01 d0                	add    %edx,%eax
  801192:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801195:	eb 15                	jmp    8011ac <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	0f b6 d0             	movzbl %al,%edx
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	0f b6 c0             	movzbl %al,%eax
  8011a5:	39 c2                	cmp    %eax,%edx
  8011a7:	74 0d                	je     8011b6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8011a9:	ff 45 08             	incl   0x8(%ebp)
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011b2:	72 e3                	jb     801197 <memfind+0x13>
  8011b4:	eb 01                	jmp    8011b7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011b6:	90                   	nop
	return (void *) s;
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ba:	c9                   	leave  
  8011bb:	c3                   	ret    

008011bc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011bc:	55                   	push   %ebp
  8011bd:	89 e5                	mov    %esp,%ebp
  8011bf:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011d0:	eb 03                	jmp    8011d5 <strtol+0x19>
		s++;
  8011d2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	8a 00                	mov    (%eax),%al
  8011da:	3c 20                	cmp    $0x20,%al
  8011dc:	74 f4                	je     8011d2 <strtol+0x16>
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	3c 09                	cmp    $0x9,%al
  8011e5:	74 eb                	je     8011d2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 00                	mov    (%eax),%al
  8011ec:	3c 2b                	cmp    $0x2b,%al
  8011ee:	75 05                	jne    8011f5 <strtol+0x39>
		s++;
  8011f0:	ff 45 08             	incl   0x8(%ebp)
  8011f3:	eb 13                	jmp    801208 <strtol+0x4c>
	else if (*s == '-')
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	3c 2d                	cmp    $0x2d,%al
  8011fc:	75 0a                	jne    801208 <strtol+0x4c>
		s++, neg = 1;
  8011fe:	ff 45 08             	incl   0x8(%ebp)
  801201:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801208:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80120c:	74 06                	je     801214 <strtol+0x58>
  80120e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801212:	75 20                	jne    801234 <strtol+0x78>
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
  801217:	8a 00                	mov    (%eax),%al
  801219:	3c 30                	cmp    $0x30,%al
  80121b:	75 17                	jne    801234 <strtol+0x78>
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	40                   	inc    %eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	3c 78                	cmp    $0x78,%al
  801225:	75 0d                	jne    801234 <strtol+0x78>
		s += 2, base = 16;
  801227:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80122b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801232:	eb 28                	jmp    80125c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801234:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801238:	75 15                	jne    80124f <strtol+0x93>
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	8a 00                	mov    (%eax),%al
  80123f:	3c 30                	cmp    $0x30,%al
  801241:	75 0c                	jne    80124f <strtol+0x93>
		s++, base = 8;
  801243:	ff 45 08             	incl   0x8(%ebp)
  801246:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80124d:	eb 0d                	jmp    80125c <strtol+0xa0>
	else if (base == 0)
  80124f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801253:	75 07                	jne    80125c <strtol+0xa0>
		base = 10;
  801255:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80125c:	8b 45 08             	mov    0x8(%ebp),%eax
  80125f:	8a 00                	mov    (%eax),%al
  801261:	3c 2f                	cmp    $0x2f,%al
  801263:	7e 19                	jle    80127e <strtol+0xc2>
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	8a 00                	mov    (%eax),%al
  80126a:	3c 39                	cmp    $0x39,%al
  80126c:	7f 10                	jg     80127e <strtol+0xc2>
			dig = *s - '0';
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	8a 00                	mov    (%eax),%al
  801273:	0f be c0             	movsbl %al,%eax
  801276:	83 e8 30             	sub    $0x30,%eax
  801279:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80127c:	eb 42                	jmp    8012c0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	3c 60                	cmp    $0x60,%al
  801285:	7e 19                	jle    8012a0 <strtol+0xe4>
  801287:	8b 45 08             	mov    0x8(%ebp),%eax
  80128a:	8a 00                	mov    (%eax),%al
  80128c:	3c 7a                	cmp    $0x7a,%al
  80128e:	7f 10                	jg     8012a0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
  801293:	8a 00                	mov    (%eax),%al
  801295:	0f be c0             	movsbl %al,%eax
  801298:	83 e8 57             	sub    $0x57,%eax
  80129b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80129e:	eb 20                	jmp    8012c0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	3c 40                	cmp    $0x40,%al
  8012a7:	7e 39                	jle    8012e2 <strtol+0x126>
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	8a 00                	mov    (%eax),%al
  8012ae:	3c 5a                	cmp    $0x5a,%al
  8012b0:	7f 30                	jg     8012e2 <strtol+0x126>
			dig = *s - 'A' + 10;
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	0f be c0             	movsbl %al,%eax
  8012ba:	83 e8 37             	sub    $0x37,%eax
  8012bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012c6:	7d 19                	jge    8012e1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012c8:	ff 45 08             	incl   0x8(%ebp)
  8012cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ce:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012d2:	89 c2                	mov    %eax,%edx
  8012d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012d7:	01 d0                	add    %edx,%eax
  8012d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012dc:	e9 7b ff ff ff       	jmp    80125c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012e1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e6:	74 08                	je     8012f0 <strtol+0x134>
		*endptr = (char *) s;
  8012e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8012ee:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012f4:	74 07                	je     8012fd <strtol+0x141>
  8012f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f9:	f7 d8                	neg    %eax
  8012fb:	eb 03                	jmp    801300 <strtol+0x144>
  8012fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <ltostr>:

void
ltostr(long value, char *str)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
  801305:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801308:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80130f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801316:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80131a:	79 13                	jns    80132f <ltostr+0x2d>
	{
		neg = 1;
  80131c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801323:	8b 45 0c             	mov    0xc(%ebp),%eax
  801326:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801329:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80132c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
  801332:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801337:	99                   	cltd   
  801338:	f7 f9                	idiv   %ecx
  80133a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80133d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801340:	8d 50 01             	lea    0x1(%eax),%edx
  801343:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801346:	89 c2                	mov    %eax,%edx
  801348:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134b:	01 d0                	add    %edx,%eax
  80134d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801350:	83 c2 30             	add    $0x30,%edx
  801353:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801355:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801358:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80135d:	f7 e9                	imul   %ecx
  80135f:	c1 fa 02             	sar    $0x2,%edx
  801362:	89 c8                	mov    %ecx,%eax
  801364:	c1 f8 1f             	sar    $0x1f,%eax
  801367:	29 c2                	sub    %eax,%edx
  801369:	89 d0                	mov    %edx,%eax
  80136b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80136e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801371:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801376:	f7 e9                	imul   %ecx
  801378:	c1 fa 02             	sar    $0x2,%edx
  80137b:	89 c8                	mov    %ecx,%eax
  80137d:	c1 f8 1f             	sar    $0x1f,%eax
  801380:	29 c2                	sub    %eax,%edx
  801382:	89 d0                	mov    %edx,%eax
  801384:	c1 e0 02             	shl    $0x2,%eax
  801387:	01 d0                	add    %edx,%eax
  801389:	01 c0                	add    %eax,%eax
  80138b:	29 c1                	sub    %eax,%ecx
  80138d:	89 ca                	mov    %ecx,%edx
  80138f:	85 d2                	test   %edx,%edx
  801391:	75 9c                	jne    80132f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801393:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80139a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80139d:	48                   	dec    %eax
  80139e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013a5:	74 3d                	je     8013e4 <ltostr+0xe2>
		start = 1 ;
  8013a7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8013ae:	eb 34                	jmp    8013e4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8013b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b6:	01 d0                	add    %edx,%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c3:	01 c2                	add    %eax,%edx
  8013c5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cb:	01 c8                	add    %ecx,%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d7:	01 c2                	add    %eax,%edx
  8013d9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013dc:	88 02                	mov    %al,(%edx)
		start++ ;
  8013de:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013e1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013e7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013ea:	7c c4                	jl     8013b0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f2:	01 d0                	add    %edx,%eax
  8013f4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013f7:	90                   	nop
  8013f8:	c9                   	leave  
  8013f9:	c3                   	ret    

008013fa <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013fa:	55                   	push   %ebp
  8013fb:	89 e5                	mov    %esp,%ebp
  8013fd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801400:	ff 75 08             	pushl  0x8(%ebp)
  801403:	e8 54 fa ff ff       	call   800e5c <strlen>
  801408:	83 c4 04             	add    $0x4,%esp
  80140b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80140e:	ff 75 0c             	pushl  0xc(%ebp)
  801411:	e8 46 fa ff ff       	call   800e5c <strlen>
  801416:	83 c4 04             	add    $0x4,%esp
  801419:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80141c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801423:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80142a:	eb 17                	jmp    801443 <strcconcat+0x49>
		final[s] = str1[s] ;
  80142c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142f:	8b 45 10             	mov    0x10(%ebp),%eax
  801432:	01 c2                	add    %eax,%edx
  801434:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	01 c8                	add    %ecx,%eax
  80143c:	8a 00                	mov    (%eax),%al
  80143e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801440:	ff 45 fc             	incl   -0x4(%ebp)
  801443:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801446:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801449:	7c e1                	jl     80142c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80144b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801452:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801459:	eb 1f                	jmp    80147a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80145b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80145e:	8d 50 01             	lea    0x1(%eax),%edx
  801461:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801464:	89 c2                	mov    %eax,%edx
  801466:	8b 45 10             	mov    0x10(%ebp),%eax
  801469:	01 c2                	add    %eax,%edx
  80146b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80146e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801471:	01 c8                	add    %ecx,%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801477:	ff 45 f8             	incl   -0x8(%ebp)
  80147a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801480:	7c d9                	jl     80145b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801482:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801485:	8b 45 10             	mov    0x10(%ebp),%eax
  801488:	01 d0                	add    %edx,%eax
  80148a:	c6 00 00             	movb   $0x0,(%eax)
}
  80148d:	90                   	nop
  80148e:	c9                   	leave  
  80148f:	c3                   	ret    

00801490 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801493:	8b 45 14             	mov    0x14(%ebp),%eax
  801496:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80149c:	8b 45 14             	mov    0x14(%ebp),%eax
  80149f:	8b 00                	mov    (%eax),%eax
  8014a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ab:	01 d0                	add    %edx,%eax
  8014ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014b3:	eb 0c                	jmp    8014c1 <strsplit+0x31>
			*string++ = 0;
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b8:	8d 50 01             	lea    0x1(%eax),%edx
  8014bb:	89 55 08             	mov    %edx,0x8(%ebp)
  8014be:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	84 c0                	test   %al,%al
  8014c8:	74 18                	je     8014e2 <strsplit+0x52>
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8a 00                	mov    (%eax),%al
  8014cf:	0f be c0             	movsbl %al,%eax
  8014d2:	50                   	push   %eax
  8014d3:	ff 75 0c             	pushl  0xc(%ebp)
  8014d6:	e8 13 fb ff ff       	call   800fee <strchr>
  8014db:	83 c4 08             	add    $0x8,%esp
  8014de:	85 c0                	test   %eax,%eax
  8014e0:	75 d3                	jne    8014b5 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	84 c0                	test   %al,%al
  8014e9:	74 5a                	je     801545 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8014eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ee:	8b 00                	mov    (%eax),%eax
  8014f0:	83 f8 0f             	cmp    $0xf,%eax
  8014f3:	75 07                	jne    8014fc <strsplit+0x6c>
		{
			return 0;
  8014f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8014fa:	eb 66                	jmp    801562 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ff:	8b 00                	mov    (%eax),%eax
  801501:	8d 48 01             	lea    0x1(%eax),%ecx
  801504:	8b 55 14             	mov    0x14(%ebp),%edx
  801507:	89 0a                	mov    %ecx,(%edx)
  801509:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801510:	8b 45 10             	mov    0x10(%ebp),%eax
  801513:	01 c2                	add    %eax,%edx
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80151a:	eb 03                	jmp    80151f <strsplit+0x8f>
			string++;
  80151c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	8a 00                	mov    (%eax),%al
  801524:	84 c0                	test   %al,%al
  801526:	74 8b                	je     8014b3 <strsplit+0x23>
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	8a 00                	mov    (%eax),%al
  80152d:	0f be c0             	movsbl %al,%eax
  801530:	50                   	push   %eax
  801531:	ff 75 0c             	pushl  0xc(%ebp)
  801534:	e8 b5 fa ff ff       	call   800fee <strchr>
  801539:	83 c4 08             	add    $0x8,%esp
  80153c:	85 c0                	test   %eax,%eax
  80153e:	74 dc                	je     80151c <strsplit+0x8c>
			string++;
	}
  801540:	e9 6e ff ff ff       	jmp    8014b3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801545:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801546:	8b 45 14             	mov    0x14(%ebp),%eax
  801549:	8b 00                	mov    (%eax),%eax
  80154b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	01 d0                	add    %edx,%eax
  801557:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80155d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
  801567:	83 ec 18             	sub    $0x18,%esp
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801570:	83 ec 04             	sub    $0x4,%esp
  801573:	68 f0 27 80 00       	push   $0x8027f0
  801578:	6a 17                	push   $0x17
  80157a:	68 0f 28 80 00       	push   $0x80280f
  80157f:	e8 a2 ef ff ff       	call   800526 <_panic>

00801584 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
  801587:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  80158a:	83 ec 04             	sub    $0x4,%esp
  80158d:	68 1b 28 80 00       	push   $0x80281b
  801592:	6a 2f                	push   $0x2f
  801594:	68 0f 28 80 00       	push   $0x80280f
  801599:	e8 88 ef ff ff       	call   800526 <_panic>

0080159e <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
  8015a1:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8015a4:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8015ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8015ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015b1:	01 d0                	add    %edx,%eax
  8015b3:	48                   	dec    %eax
  8015b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8015b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015ba:	ba 00 00 00 00       	mov    $0x0,%edx
  8015bf:	f7 75 ec             	divl   -0x14(%ebp)
  8015c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8015c5:	29 d0                	sub    %edx,%eax
  8015c7:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	c1 e8 0c             	shr    $0xc,%eax
  8015d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8015d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8015da:	e9 c8 00 00 00       	jmp    8016a7 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8015df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015e6:	eb 27                	jmp    80160f <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8015e8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ee:	01 c2                	add    %eax,%edx
  8015f0:	89 d0                	mov    %edx,%eax
  8015f2:	01 c0                	add    %eax,%eax
  8015f4:	01 d0                	add    %edx,%eax
  8015f6:	c1 e0 02             	shl    $0x2,%eax
  8015f9:	05 48 30 80 00       	add    $0x803048,%eax
  8015fe:	8b 00                	mov    (%eax),%eax
  801600:	85 c0                	test   %eax,%eax
  801602:	74 08                	je     80160c <malloc+0x6e>
            	i += j;
  801604:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801607:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  80160a:	eb 0b                	jmp    801617 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80160c:	ff 45 f0             	incl   -0x10(%ebp)
  80160f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801612:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801615:	72 d1                	jb     8015e8 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801617:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80161a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80161d:	0f 85 81 00 00 00    	jne    8016a4 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801623:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801626:	05 00 00 08 00       	add    $0x80000,%eax
  80162b:	c1 e0 0c             	shl    $0xc,%eax
  80162e:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801631:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801638:	eb 1f                	jmp    801659 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  80163a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80163d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801640:	01 c2                	add    %eax,%edx
  801642:	89 d0                	mov    %edx,%eax
  801644:	01 c0                	add    %eax,%eax
  801646:	01 d0                	add    %edx,%eax
  801648:	c1 e0 02             	shl    $0x2,%eax
  80164b:	05 48 30 80 00       	add    $0x803048,%eax
  801650:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801656:	ff 45 f0             	incl   -0x10(%ebp)
  801659:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80165c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80165f:	72 d9                	jb     80163a <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801661:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801664:	89 d0                	mov    %edx,%eax
  801666:	01 c0                	add    %eax,%eax
  801668:	01 d0                	add    %edx,%eax
  80166a:	c1 e0 02             	shl    $0x2,%eax
  80166d:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801673:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801676:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801678:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80167b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80167e:	89 c8                	mov    %ecx,%eax
  801680:	01 c0                	add    %eax,%eax
  801682:	01 c8                	add    %ecx,%eax
  801684:	c1 e0 02             	shl    $0x2,%eax
  801687:	05 44 30 80 00       	add    $0x803044,%eax
  80168c:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80168e:	83 ec 08             	sub    $0x8,%esp
  801691:	ff 75 08             	pushl  0x8(%ebp)
  801694:	ff 75 e0             	pushl  -0x20(%ebp)
  801697:	e8 2b 03 00 00       	call   8019c7 <sys_allocateMem>
  80169c:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  80169f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016a2:	eb 19                	jmp    8016bd <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8016a4:	ff 45 f4             	incl   -0xc(%ebp)
  8016a7:	a1 04 30 80 00       	mov    0x803004,%eax
  8016ac:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8016af:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016b2:	0f 83 27 ff ff ff    	jae    8015df <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8016b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
  8016c2:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8016c5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016c9:	0f 84 e5 00 00 00    	je     8017b4 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8016d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016d8:	05 00 00 00 80       	add    $0x80000000,%eax
  8016dd:	c1 e8 0c             	shr    $0xc,%eax
  8016e0:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8016e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8016e6:	89 d0                	mov    %edx,%eax
  8016e8:	01 c0                	add    %eax,%eax
  8016ea:	01 d0                	add    %edx,%eax
  8016ec:	c1 e0 02             	shl    $0x2,%eax
  8016ef:	05 40 30 80 00       	add    $0x803040,%eax
  8016f4:	8b 00                	mov    (%eax),%eax
  8016f6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016f9:	0f 85 b8 00 00 00    	jne    8017b7 <free+0xf8>
  8016ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801702:	89 d0                	mov    %edx,%eax
  801704:	01 c0                	add    %eax,%eax
  801706:	01 d0                	add    %edx,%eax
  801708:	c1 e0 02             	shl    $0x2,%eax
  80170b:	05 48 30 80 00       	add    $0x803048,%eax
  801710:	8b 00                	mov    (%eax),%eax
  801712:	85 c0                	test   %eax,%eax
  801714:	0f 84 9d 00 00 00    	je     8017b7 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  80171a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80171d:	89 d0                	mov    %edx,%eax
  80171f:	01 c0                	add    %eax,%eax
  801721:	01 d0                	add    %edx,%eax
  801723:	c1 e0 02             	shl    $0x2,%eax
  801726:	05 44 30 80 00       	add    $0x803044,%eax
  80172b:	8b 00                	mov    (%eax),%eax
  80172d:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801730:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801733:	c1 e0 0c             	shl    $0xc,%eax
  801736:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801739:	83 ec 08             	sub    $0x8,%esp
  80173c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80173f:	ff 75 f0             	pushl  -0x10(%ebp)
  801742:	e8 64 02 00 00       	call   8019ab <sys_freeMem>
  801747:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  80174a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801751:	eb 57                	jmp    8017aa <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801753:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801756:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801759:	01 c2                	add    %eax,%edx
  80175b:	89 d0                	mov    %edx,%eax
  80175d:	01 c0                	add    %eax,%eax
  80175f:	01 d0                	add    %edx,%eax
  801761:	c1 e0 02             	shl    $0x2,%eax
  801764:	05 48 30 80 00       	add    $0x803048,%eax
  801769:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80176f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801772:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801775:	01 c2                	add    %eax,%edx
  801777:	89 d0                	mov    %edx,%eax
  801779:	01 c0                	add    %eax,%eax
  80177b:	01 d0                	add    %edx,%eax
  80177d:	c1 e0 02             	shl    $0x2,%eax
  801780:	05 40 30 80 00       	add    $0x803040,%eax
  801785:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  80178b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80178e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801791:	01 c2                	add    %eax,%edx
  801793:	89 d0                	mov    %edx,%eax
  801795:	01 c0                	add    %eax,%eax
  801797:	01 d0                	add    %edx,%eax
  801799:	c1 e0 02             	shl    $0x2,%eax
  80179c:	05 44 30 80 00       	add    $0x803044,%eax
  8017a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8017a7:	ff 45 f4             	incl   -0xc(%ebp)
  8017aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ad:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8017b0:	7c a1                	jl     801753 <free+0x94>
  8017b2:	eb 04                	jmp    8017b8 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8017b4:	90                   	nop
  8017b5:	eb 01                	jmp    8017b8 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8017b7:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
  8017bd:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8017c0:	83 ec 04             	sub    $0x4,%esp
  8017c3:	68 38 28 80 00       	push   $0x802838
  8017c8:	68 ae 00 00 00       	push   $0xae
  8017cd:	68 0f 28 80 00       	push   $0x80280f
  8017d2:	e8 4f ed ff ff       	call   800526 <_panic>

008017d7 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8017dd:	83 ec 04             	sub    $0x4,%esp
  8017e0:	68 58 28 80 00       	push   $0x802858
  8017e5:	68 ca 00 00 00       	push   $0xca
  8017ea:	68 0f 28 80 00       	push   $0x80280f
  8017ef:	e8 32 ed ff ff       	call   800526 <_panic>

008017f4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
  8017f7:	57                   	push   %edi
  8017f8:	56                   	push   %esi
  8017f9:	53                   	push   %ebx
  8017fa:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	8b 55 0c             	mov    0xc(%ebp),%edx
  801803:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801806:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801809:	8b 7d 18             	mov    0x18(%ebp),%edi
  80180c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80180f:	cd 30                	int    $0x30
  801811:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801814:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801817:	83 c4 10             	add    $0x10,%esp
  80181a:	5b                   	pop    %ebx
  80181b:	5e                   	pop    %esi
  80181c:	5f                   	pop    %edi
  80181d:	5d                   	pop    %ebp
  80181e:	c3                   	ret    

0080181f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
  801822:	83 ec 04             	sub    $0x4,%esp
  801825:	8b 45 10             	mov    0x10(%ebp),%eax
  801828:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80182b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	52                   	push   %edx
  801837:	ff 75 0c             	pushl  0xc(%ebp)
  80183a:	50                   	push   %eax
  80183b:	6a 00                	push   $0x0
  80183d:	e8 b2 ff ff ff       	call   8017f4 <syscall>
  801842:	83 c4 18             	add    $0x18,%esp
}
  801845:	90                   	nop
  801846:	c9                   	leave  
  801847:	c3                   	ret    

00801848 <sys_cgetc>:

int
sys_cgetc(void)
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 01                	push   $0x1
  801857:	e8 98 ff ff ff       	call   8017f4 <syscall>
  80185c:	83 c4 18             	add    $0x18,%esp
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801864:	8b 45 08             	mov    0x8(%ebp),%eax
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	50                   	push   %eax
  801870:	6a 05                	push   $0x5
  801872:	e8 7d ff ff ff       	call   8017f4 <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 02                	push   $0x2
  80188b:	e8 64 ff ff ff       	call   8017f4 <syscall>
  801890:	83 c4 18             	add    $0x18,%esp
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 03                	push   $0x3
  8018a4:	e8 4b ff ff ff       	call   8017f4 <syscall>
  8018a9:	83 c4 18             	add    $0x18,%esp
}
  8018ac:	c9                   	leave  
  8018ad:	c3                   	ret    

008018ae <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018ae:	55                   	push   %ebp
  8018af:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 04                	push   $0x4
  8018bd:	e8 32 ff ff ff       	call   8017f4 <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_env_exit>:


void sys_env_exit(void)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 06                	push   $0x6
  8018d6:	e8 19 ff ff ff       	call   8017f4 <syscall>
  8018db:	83 c4 18             	add    $0x18,%esp
}
  8018de:	90                   	nop
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	52                   	push   %edx
  8018f1:	50                   	push   %eax
  8018f2:	6a 07                	push   $0x7
  8018f4:	e8 fb fe ff ff       	call   8017f4 <syscall>
  8018f9:	83 c4 18             	add    $0x18,%esp
}
  8018fc:	c9                   	leave  
  8018fd:	c3                   	ret    

008018fe <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018fe:	55                   	push   %ebp
  8018ff:	89 e5                	mov    %esp,%ebp
  801901:	56                   	push   %esi
  801902:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801903:	8b 75 18             	mov    0x18(%ebp),%esi
  801906:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801909:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80190c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190f:	8b 45 08             	mov    0x8(%ebp),%eax
  801912:	56                   	push   %esi
  801913:	53                   	push   %ebx
  801914:	51                   	push   %ecx
  801915:	52                   	push   %edx
  801916:	50                   	push   %eax
  801917:	6a 08                	push   $0x8
  801919:	e8 d6 fe ff ff       	call   8017f4 <syscall>
  80191e:	83 c4 18             	add    $0x18,%esp
}
  801921:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801924:	5b                   	pop    %ebx
  801925:	5e                   	pop    %esi
  801926:	5d                   	pop    %ebp
  801927:	c3                   	ret    

00801928 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80192b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	52                   	push   %edx
  801938:	50                   	push   %eax
  801939:	6a 09                	push   $0x9
  80193b:	e8 b4 fe ff ff       	call   8017f4 <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	ff 75 0c             	pushl  0xc(%ebp)
  801951:	ff 75 08             	pushl  0x8(%ebp)
  801954:	6a 0a                	push   $0xa
  801956:	e8 99 fe ff ff       	call   8017f4 <syscall>
  80195b:	83 c4 18             	add    $0x18,%esp
}
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 00                	push   $0x0
  80196d:	6a 0b                	push   $0xb
  80196f:	e8 80 fe ff ff       	call   8017f4 <syscall>
  801974:	83 c4 18             	add    $0x18,%esp
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 0c                	push   $0xc
  801988:	e8 67 fe ff ff       	call   8017f4 <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
}
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 0d                	push   $0xd
  8019a1:	e8 4e fe ff ff       	call   8017f4 <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
}
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	ff 75 0c             	pushl  0xc(%ebp)
  8019b7:	ff 75 08             	pushl  0x8(%ebp)
  8019ba:	6a 11                	push   $0x11
  8019bc:	e8 33 fe ff ff       	call   8017f4 <syscall>
  8019c1:	83 c4 18             	add    $0x18,%esp
	return;
  8019c4:	90                   	nop
}
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	ff 75 0c             	pushl  0xc(%ebp)
  8019d3:	ff 75 08             	pushl  0x8(%ebp)
  8019d6:	6a 12                	push   $0x12
  8019d8:	e8 17 fe ff ff       	call   8017f4 <syscall>
  8019dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e0:	90                   	nop
}
  8019e1:	c9                   	leave  
  8019e2:	c3                   	ret    

008019e3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 0e                	push   $0xe
  8019f2:	e8 fd fd ff ff       	call   8017f4 <syscall>
  8019f7:	83 c4 18             	add    $0x18,%esp
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	ff 75 08             	pushl  0x8(%ebp)
  801a0a:	6a 0f                	push   $0xf
  801a0c:	e8 e3 fd ff ff       	call   8017f4 <syscall>
  801a11:	83 c4 18             	add    $0x18,%esp
}
  801a14:	c9                   	leave  
  801a15:	c3                   	ret    

00801a16 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 10                	push   $0x10
  801a25:	e8 ca fd ff ff       	call   8017f4 <syscall>
  801a2a:	83 c4 18             	add    $0x18,%esp
}
  801a2d:	90                   	nop
  801a2e:	c9                   	leave  
  801a2f:	c3                   	ret    

00801a30 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a30:	55                   	push   %ebp
  801a31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 14                	push   $0x14
  801a3f:	e8 b0 fd ff ff       	call   8017f4 <syscall>
  801a44:	83 c4 18             	add    $0x18,%esp
}
  801a47:	90                   	nop
  801a48:	c9                   	leave  
  801a49:	c3                   	ret    

00801a4a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a4a:	55                   	push   %ebp
  801a4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 15                	push   $0x15
  801a59:	e8 96 fd ff ff       	call   8017f4 <syscall>
  801a5e:	83 c4 18             	add    $0x18,%esp
}
  801a61:	90                   	nop
  801a62:	c9                   	leave  
  801a63:	c3                   	ret    

00801a64 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a64:	55                   	push   %ebp
  801a65:	89 e5                	mov    %esp,%ebp
  801a67:	83 ec 04             	sub    $0x4,%esp
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a70:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	50                   	push   %eax
  801a7d:	6a 16                	push   $0x16
  801a7f:	e8 70 fd ff ff       	call   8017f4 <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
}
  801a87:	90                   	nop
  801a88:	c9                   	leave  
  801a89:	c3                   	ret    

00801a8a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a8a:	55                   	push   %ebp
  801a8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 17                	push   $0x17
  801a99:	e8 56 fd ff ff       	call   8017f4 <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	90                   	nop
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	ff 75 0c             	pushl  0xc(%ebp)
  801ab3:	50                   	push   %eax
  801ab4:	6a 18                	push   $0x18
  801ab6:	e8 39 fd ff ff       	call   8017f4 <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
}
  801abe:	c9                   	leave  
  801abf:	c3                   	ret    

00801ac0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ac0:	55                   	push   %ebp
  801ac1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ac3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	52                   	push   %edx
  801ad0:	50                   	push   %eax
  801ad1:	6a 1b                	push   $0x1b
  801ad3:	e8 1c fd ff ff       	call   8017f4 <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
}
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ae0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	52                   	push   %edx
  801aed:	50                   	push   %eax
  801aee:	6a 19                	push   $0x19
  801af0:	e8 ff fc ff ff       	call   8017f4 <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	90                   	nop
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801afe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	6a 00                	push   $0x0
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	52                   	push   %edx
  801b0b:	50                   	push   %eax
  801b0c:	6a 1a                	push   $0x1a
  801b0e:	e8 e1 fc ff ff       	call   8017f4 <syscall>
  801b13:	83 c4 18             	add    $0x18,%esp
}
  801b16:	90                   	nop
  801b17:	c9                   	leave  
  801b18:	c3                   	ret    

00801b19 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b19:	55                   	push   %ebp
  801b1a:	89 e5                	mov    %esp,%ebp
  801b1c:	83 ec 04             	sub    $0x4,%esp
  801b1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801b22:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b25:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b28:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2f:	6a 00                	push   $0x0
  801b31:	51                   	push   %ecx
  801b32:	52                   	push   %edx
  801b33:	ff 75 0c             	pushl  0xc(%ebp)
  801b36:	50                   	push   %eax
  801b37:	6a 1c                	push   $0x1c
  801b39:	e8 b6 fc ff ff       	call   8017f4 <syscall>
  801b3e:	83 c4 18             	add    $0x18,%esp
}
  801b41:	c9                   	leave  
  801b42:	c3                   	ret    

00801b43 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b43:	55                   	push   %ebp
  801b44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b49:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	52                   	push   %edx
  801b53:	50                   	push   %eax
  801b54:	6a 1d                	push   $0x1d
  801b56:	e8 99 fc ff ff       	call   8017f4 <syscall>
  801b5b:	83 c4 18             	add    $0x18,%esp
}
  801b5e:	c9                   	leave  
  801b5f:	c3                   	ret    

00801b60 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b63:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b69:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	51                   	push   %ecx
  801b71:	52                   	push   %edx
  801b72:	50                   	push   %eax
  801b73:	6a 1e                	push   $0x1e
  801b75:	e8 7a fc ff ff       	call   8017f4 <syscall>
  801b7a:	83 c4 18             	add    $0x18,%esp
}
  801b7d:	c9                   	leave  
  801b7e:	c3                   	ret    

00801b7f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b85:	8b 45 08             	mov    0x8(%ebp),%eax
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	52                   	push   %edx
  801b8f:	50                   	push   %eax
  801b90:	6a 1f                	push   $0x1f
  801b92:	e8 5d fc ff ff       	call   8017f4 <syscall>
  801b97:	83 c4 18             	add    $0x18,%esp
}
  801b9a:	c9                   	leave  
  801b9b:	c3                   	ret    

00801b9c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 20                	push   $0x20
  801bab:	e8 44 fc ff ff       	call   8017f4 <syscall>
  801bb0:	83 c4 18             	add    $0x18,%esp
}
  801bb3:	c9                   	leave  
  801bb4:	c3                   	ret    

00801bb5 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801bb5:	55                   	push   %ebp
  801bb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	ff 75 10             	pushl  0x10(%ebp)
  801bc2:	ff 75 0c             	pushl  0xc(%ebp)
  801bc5:	50                   	push   %eax
  801bc6:	6a 21                	push   $0x21
  801bc8:	e8 27 fc ff ff       	call   8017f4 <syscall>
  801bcd:	83 c4 18             	add    $0x18,%esp
}
  801bd0:	c9                   	leave  
  801bd1:	c3                   	ret    

00801bd2 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801bd2:	55                   	push   %ebp
  801bd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	50                   	push   %eax
  801be1:	6a 22                	push   $0x22
  801be3:	e8 0c fc ff ff       	call   8017f4 <syscall>
  801be8:	83 c4 18             	add    $0x18,%esp
}
  801beb:	90                   	nop
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	50                   	push   %eax
  801bfd:	6a 23                	push   $0x23
  801bff:	e8 f0 fb ff ff       	call   8017f4 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
}
  801c07:	90                   	nop
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c10:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c13:	8d 50 04             	lea    0x4(%eax),%edx
  801c16:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	52                   	push   %edx
  801c20:	50                   	push   %eax
  801c21:	6a 24                	push   $0x24
  801c23:	e8 cc fb ff ff       	call   8017f4 <syscall>
  801c28:	83 c4 18             	add    $0x18,%esp
	return result;
  801c2b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c31:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c34:	89 01                	mov    %eax,(%ecx)
  801c36:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c39:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3c:	c9                   	leave  
  801c3d:	c2 04 00             	ret    $0x4

00801c40 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	ff 75 10             	pushl  0x10(%ebp)
  801c4a:	ff 75 0c             	pushl  0xc(%ebp)
  801c4d:	ff 75 08             	pushl  0x8(%ebp)
  801c50:	6a 13                	push   $0x13
  801c52:	e8 9d fb ff ff       	call   8017f4 <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
	return ;
  801c5a:	90                   	nop
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_rcr2>:
uint32 sys_rcr2()
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 25                	push   $0x25
  801c6c:	e8 83 fb ff ff       	call   8017f4 <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
  801c79:	83 ec 04             	sub    $0x4,%esp
  801c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c82:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	50                   	push   %eax
  801c8f:	6a 26                	push   $0x26
  801c91:	e8 5e fb ff ff       	call   8017f4 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
	return ;
  801c99:	90                   	nop
}
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <rsttst>:
void rsttst()
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 28                	push   $0x28
  801cab:	e8 44 fb ff ff       	call   8017f4 <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb3:	90                   	nop
}
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
  801cb9:	83 ec 04             	sub    $0x4,%esp
  801cbc:	8b 45 14             	mov    0x14(%ebp),%eax
  801cbf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801cc2:	8b 55 18             	mov    0x18(%ebp),%edx
  801cc5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cc9:	52                   	push   %edx
  801cca:	50                   	push   %eax
  801ccb:	ff 75 10             	pushl  0x10(%ebp)
  801cce:	ff 75 0c             	pushl  0xc(%ebp)
  801cd1:	ff 75 08             	pushl  0x8(%ebp)
  801cd4:	6a 27                	push   $0x27
  801cd6:	e8 19 fb ff ff       	call   8017f4 <syscall>
  801cdb:	83 c4 18             	add    $0x18,%esp
	return ;
  801cde:	90                   	nop
}
  801cdf:	c9                   	leave  
  801ce0:	c3                   	ret    

00801ce1 <chktst>:
void chktst(uint32 n)
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	ff 75 08             	pushl  0x8(%ebp)
  801cef:	6a 29                	push   $0x29
  801cf1:	e8 fe fa ff ff       	call   8017f4 <syscall>
  801cf6:	83 c4 18             	add    $0x18,%esp
	return ;
  801cf9:	90                   	nop
}
  801cfa:	c9                   	leave  
  801cfb:	c3                   	ret    

00801cfc <inctst>:

void inctst()
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 2a                	push   $0x2a
  801d0b:	e8 e4 fa ff ff       	call   8017f4 <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
	return ;
  801d13:	90                   	nop
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <gettst>:
uint32 gettst()
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	6a 2b                	push   $0x2b
  801d25:	e8 ca fa ff ff       	call   8017f4 <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
}
  801d2d:	c9                   	leave  
  801d2e:	c3                   	ret    

00801d2f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d2f:	55                   	push   %ebp
  801d30:	89 e5                	mov    %esp,%ebp
  801d32:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 2c                	push   $0x2c
  801d41:	e8 ae fa ff ff       	call   8017f4 <syscall>
  801d46:	83 c4 18             	add    $0x18,%esp
  801d49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d4c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d50:	75 07                	jne    801d59 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d52:	b8 01 00 00 00       	mov    $0x1,%eax
  801d57:	eb 05                	jmp    801d5e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d59:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
  801d63:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 2c                	push   $0x2c
  801d72:	e8 7d fa ff ff       	call   8017f4 <syscall>
  801d77:	83 c4 18             	add    $0x18,%esp
  801d7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d7d:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d81:	75 07                	jne    801d8a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d83:	b8 01 00 00 00       	mov    $0x1,%eax
  801d88:	eb 05                	jmp    801d8f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d8f:	c9                   	leave  
  801d90:	c3                   	ret    

00801d91 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d91:	55                   	push   %ebp
  801d92:	89 e5                	mov    %esp,%ebp
  801d94:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 2c                	push   $0x2c
  801da3:	e8 4c fa ff ff       	call   8017f4 <syscall>
  801da8:	83 c4 18             	add    $0x18,%esp
  801dab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801dae:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801db2:	75 07                	jne    801dbb <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801db4:	b8 01 00 00 00       	mov    $0x1,%eax
  801db9:	eb 05                	jmp    801dc0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801dbb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
  801dc5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 2c                	push   $0x2c
  801dd4:	e8 1b fa ff ff       	call   8017f4 <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
  801ddc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ddf:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801de3:	75 07                	jne    801dec <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801de5:	b8 01 00 00 00       	mov    $0x1,%eax
  801dea:	eb 05                	jmp    801df1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801dec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801df1:	c9                   	leave  
  801df2:	c3                   	ret    

00801df3 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801df3:	55                   	push   %ebp
  801df4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	ff 75 08             	pushl  0x8(%ebp)
  801e01:	6a 2d                	push   $0x2d
  801e03:	e8 ec f9 ff ff       	call   8017f4 <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
	return ;
  801e0b:	90                   	nop
}
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    
  801e0e:	66 90                	xchg   %ax,%ax

00801e10 <__udivdi3>:
  801e10:	55                   	push   %ebp
  801e11:	57                   	push   %edi
  801e12:	56                   	push   %esi
  801e13:	53                   	push   %ebx
  801e14:	83 ec 1c             	sub    $0x1c,%esp
  801e17:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e1b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e1f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e23:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e27:	89 ca                	mov    %ecx,%edx
  801e29:	89 f8                	mov    %edi,%eax
  801e2b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e2f:	85 f6                	test   %esi,%esi
  801e31:	75 2d                	jne    801e60 <__udivdi3+0x50>
  801e33:	39 cf                	cmp    %ecx,%edi
  801e35:	77 65                	ja     801e9c <__udivdi3+0x8c>
  801e37:	89 fd                	mov    %edi,%ebp
  801e39:	85 ff                	test   %edi,%edi
  801e3b:	75 0b                	jne    801e48 <__udivdi3+0x38>
  801e3d:	b8 01 00 00 00       	mov    $0x1,%eax
  801e42:	31 d2                	xor    %edx,%edx
  801e44:	f7 f7                	div    %edi
  801e46:	89 c5                	mov    %eax,%ebp
  801e48:	31 d2                	xor    %edx,%edx
  801e4a:	89 c8                	mov    %ecx,%eax
  801e4c:	f7 f5                	div    %ebp
  801e4e:	89 c1                	mov    %eax,%ecx
  801e50:	89 d8                	mov    %ebx,%eax
  801e52:	f7 f5                	div    %ebp
  801e54:	89 cf                	mov    %ecx,%edi
  801e56:	89 fa                	mov    %edi,%edx
  801e58:	83 c4 1c             	add    $0x1c,%esp
  801e5b:	5b                   	pop    %ebx
  801e5c:	5e                   	pop    %esi
  801e5d:	5f                   	pop    %edi
  801e5e:	5d                   	pop    %ebp
  801e5f:	c3                   	ret    
  801e60:	39 ce                	cmp    %ecx,%esi
  801e62:	77 28                	ja     801e8c <__udivdi3+0x7c>
  801e64:	0f bd fe             	bsr    %esi,%edi
  801e67:	83 f7 1f             	xor    $0x1f,%edi
  801e6a:	75 40                	jne    801eac <__udivdi3+0x9c>
  801e6c:	39 ce                	cmp    %ecx,%esi
  801e6e:	72 0a                	jb     801e7a <__udivdi3+0x6a>
  801e70:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e74:	0f 87 9e 00 00 00    	ja     801f18 <__udivdi3+0x108>
  801e7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e7f:	89 fa                	mov    %edi,%edx
  801e81:	83 c4 1c             	add    $0x1c,%esp
  801e84:	5b                   	pop    %ebx
  801e85:	5e                   	pop    %esi
  801e86:	5f                   	pop    %edi
  801e87:	5d                   	pop    %ebp
  801e88:	c3                   	ret    
  801e89:	8d 76 00             	lea    0x0(%esi),%esi
  801e8c:	31 ff                	xor    %edi,%edi
  801e8e:	31 c0                	xor    %eax,%eax
  801e90:	89 fa                	mov    %edi,%edx
  801e92:	83 c4 1c             	add    $0x1c,%esp
  801e95:	5b                   	pop    %ebx
  801e96:	5e                   	pop    %esi
  801e97:	5f                   	pop    %edi
  801e98:	5d                   	pop    %ebp
  801e99:	c3                   	ret    
  801e9a:	66 90                	xchg   %ax,%ax
  801e9c:	89 d8                	mov    %ebx,%eax
  801e9e:	f7 f7                	div    %edi
  801ea0:	31 ff                	xor    %edi,%edi
  801ea2:	89 fa                	mov    %edi,%edx
  801ea4:	83 c4 1c             	add    $0x1c,%esp
  801ea7:	5b                   	pop    %ebx
  801ea8:	5e                   	pop    %esi
  801ea9:	5f                   	pop    %edi
  801eaa:	5d                   	pop    %ebp
  801eab:	c3                   	ret    
  801eac:	bd 20 00 00 00       	mov    $0x20,%ebp
  801eb1:	89 eb                	mov    %ebp,%ebx
  801eb3:	29 fb                	sub    %edi,%ebx
  801eb5:	89 f9                	mov    %edi,%ecx
  801eb7:	d3 e6                	shl    %cl,%esi
  801eb9:	89 c5                	mov    %eax,%ebp
  801ebb:	88 d9                	mov    %bl,%cl
  801ebd:	d3 ed                	shr    %cl,%ebp
  801ebf:	89 e9                	mov    %ebp,%ecx
  801ec1:	09 f1                	or     %esi,%ecx
  801ec3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ec7:	89 f9                	mov    %edi,%ecx
  801ec9:	d3 e0                	shl    %cl,%eax
  801ecb:	89 c5                	mov    %eax,%ebp
  801ecd:	89 d6                	mov    %edx,%esi
  801ecf:	88 d9                	mov    %bl,%cl
  801ed1:	d3 ee                	shr    %cl,%esi
  801ed3:	89 f9                	mov    %edi,%ecx
  801ed5:	d3 e2                	shl    %cl,%edx
  801ed7:	8b 44 24 08          	mov    0x8(%esp),%eax
  801edb:	88 d9                	mov    %bl,%cl
  801edd:	d3 e8                	shr    %cl,%eax
  801edf:	09 c2                	or     %eax,%edx
  801ee1:	89 d0                	mov    %edx,%eax
  801ee3:	89 f2                	mov    %esi,%edx
  801ee5:	f7 74 24 0c          	divl   0xc(%esp)
  801ee9:	89 d6                	mov    %edx,%esi
  801eeb:	89 c3                	mov    %eax,%ebx
  801eed:	f7 e5                	mul    %ebp
  801eef:	39 d6                	cmp    %edx,%esi
  801ef1:	72 19                	jb     801f0c <__udivdi3+0xfc>
  801ef3:	74 0b                	je     801f00 <__udivdi3+0xf0>
  801ef5:	89 d8                	mov    %ebx,%eax
  801ef7:	31 ff                	xor    %edi,%edi
  801ef9:	e9 58 ff ff ff       	jmp    801e56 <__udivdi3+0x46>
  801efe:	66 90                	xchg   %ax,%ax
  801f00:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f04:	89 f9                	mov    %edi,%ecx
  801f06:	d3 e2                	shl    %cl,%edx
  801f08:	39 c2                	cmp    %eax,%edx
  801f0a:	73 e9                	jae    801ef5 <__udivdi3+0xe5>
  801f0c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f0f:	31 ff                	xor    %edi,%edi
  801f11:	e9 40 ff ff ff       	jmp    801e56 <__udivdi3+0x46>
  801f16:	66 90                	xchg   %ax,%ax
  801f18:	31 c0                	xor    %eax,%eax
  801f1a:	e9 37 ff ff ff       	jmp    801e56 <__udivdi3+0x46>
  801f1f:	90                   	nop

00801f20 <__umoddi3>:
  801f20:	55                   	push   %ebp
  801f21:	57                   	push   %edi
  801f22:	56                   	push   %esi
  801f23:	53                   	push   %ebx
  801f24:	83 ec 1c             	sub    $0x1c,%esp
  801f27:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f2b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f2f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f33:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f3b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f3f:	89 f3                	mov    %esi,%ebx
  801f41:	89 fa                	mov    %edi,%edx
  801f43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f47:	89 34 24             	mov    %esi,(%esp)
  801f4a:	85 c0                	test   %eax,%eax
  801f4c:	75 1a                	jne    801f68 <__umoddi3+0x48>
  801f4e:	39 f7                	cmp    %esi,%edi
  801f50:	0f 86 a2 00 00 00    	jbe    801ff8 <__umoddi3+0xd8>
  801f56:	89 c8                	mov    %ecx,%eax
  801f58:	89 f2                	mov    %esi,%edx
  801f5a:	f7 f7                	div    %edi
  801f5c:	89 d0                	mov    %edx,%eax
  801f5e:	31 d2                	xor    %edx,%edx
  801f60:	83 c4 1c             	add    $0x1c,%esp
  801f63:	5b                   	pop    %ebx
  801f64:	5e                   	pop    %esi
  801f65:	5f                   	pop    %edi
  801f66:	5d                   	pop    %ebp
  801f67:	c3                   	ret    
  801f68:	39 f0                	cmp    %esi,%eax
  801f6a:	0f 87 ac 00 00 00    	ja     80201c <__umoddi3+0xfc>
  801f70:	0f bd e8             	bsr    %eax,%ebp
  801f73:	83 f5 1f             	xor    $0x1f,%ebp
  801f76:	0f 84 ac 00 00 00    	je     802028 <__umoddi3+0x108>
  801f7c:	bf 20 00 00 00       	mov    $0x20,%edi
  801f81:	29 ef                	sub    %ebp,%edi
  801f83:	89 fe                	mov    %edi,%esi
  801f85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f89:	89 e9                	mov    %ebp,%ecx
  801f8b:	d3 e0                	shl    %cl,%eax
  801f8d:	89 d7                	mov    %edx,%edi
  801f8f:	89 f1                	mov    %esi,%ecx
  801f91:	d3 ef                	shr    %cl,%edi
  801f93:	09 c7                	or     %eax,%edi
  801f95:	89 e9                	mov    %ebp,%ecx
  801f97:	d3 e2                	shl    %cl,%edx
  801f99:	89 14 24             	mov    %edx,(%esp)
  801f9c:	89 d8                	mov    %ebx,%eax
  801f9e:	d3 e0                	shl    %cl,%eax
  801fa0:	89 c2                	mov    %eax,%edx
  801fa2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fa6:	d3 e0                	shl    %cl,%eax
  801fa8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fac:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fb0:	89 f1                	mov    %esi,%ecx
  801fb2:	d3 e8                	shr    %cl,%eax
  801fb4:	09 d0                	or     %edx,%eax
  801fb6:	d3 eb                	shr    %cl,%ebx
  801fb8:	89 da                	mov    %ebx,%edx
  801fba:	f7 f7                	div    %edi
  801fbc:	89 d3                	mov    %edx,%ebx
  801fbe:	f7 24 24             	mull   (%esp)
  801fc1:	89 c6                	mov    %eax,%esi
  801fc3:	89 d1                	mov    %edx,%ecx
  801fc5:	39 d3                	cmp    %edx,%ebx
  801fc7:	0f 82 87 00 00 00    	jb     802054 <__umoddi3+0x134>
  801fcd:	0f 84 91 00 00 00    	je     802064 <__umoddi3+0x144>
  801fd3:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fd7:	29 f2                	sub    %esi,%edx
  801fd9:	19 cb                	sbb    %ecx,%ebx
  801fdb:	89 d8                	mov    %ebx,%eax
  801fdd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fe1:	d3 e0                	shl    %cl,%eax
  801fe3:	89 e9                	mov    %ebp,%ecx
  801fe5:	d3 ea                	shr    %cl,%edx
  801fe7:	09 d0                	or     %edx,%eax
  801fe9:	89 e9                	mov    %ebp,%ecx
  801feb:	d3 eb                	shr    %cl,%ebx
  801fed:	89 da                	mov    %ebx,%edx
  801fef:	83 c4 1c             	add    $0x1c,%esp
  801ff2:	5b                   	pop    %ebx
  801ff3:	5e                   	pop    %esi
  801ff4:	5f                   	pop    %edi
  801ff5:	5d                   	pop    %ebp
  801ff6:	c3                   	ret    
  801ff7:	90                   	nop
  801ff8:	89 fd                	mov    %edi,%ebp
  801ffa:	85 ff                	test   %edi,%edi
  801ffc:	75 0b                	jne    802009 <__umoddi3+0xe9>
  801ffe:	b8 01 00 00 00       	mov    $0x1,%eax
  802003:	31 d2                	xor    %edx,%edx
  802005:	f7 f7                	div    %edi
  802007:	89 c5                	mov    %eax,%ebp
  802009:	89 f0                	mov    %esi,%eax
  80200b:	31 d2                	xor    %edx,%edx
  80200d:	f7 f5                	div    %ebp
  80200f:	89 c8                	mov    %ecx,%eax
  802011:	f7 f5                	div    %ebp
  802013:	89 d0                	mov    %edx,%eax
  802015:	e9 44 ff ff ff       	jmp    801f5e <__umoddi3+0x3e>
  80201a:	66 90                	xchg   %ax,%ax
  80201c:	89 c8                	mov    %ecx,%eax
  80201e:	89 f2                	mov    %esi,%edx
  802020:	83 c4 1c             	add    $0x1c,%esp
  802023:	5b                   	pop    %ebx
  802024:	5e                   	pop    %esi
  802025:	5f                   	pop    %edi
  802026:	5d                   	pop    %ebp
  802027:	c3                   	ret    
  802028:	3b 04 24             	cmp    (%esp),%eax
  80202b:	72 06                	jb     802033 <__umoddi3+0x113>
  80202d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802031:	77 0f                	ja     802042 <__umoddi3+0x122>
  802033:	89 f2                	mov    %esi,%edx
  802035:	29 f9                	sub    %edi,%ecx
  802037:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80203b:	89 14 24             	mov    %edx,(%esp)
  80203e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802042:	8b 44 24 04          	mov    0x4(%esp),%eax
  802046:	8b 14 24             	mov    (%esp),%edx
  802049:	83 c4 1c             	add    $0x1c,%esp
  80204c:	5b                   	pop    %ebx
  80204d:	5e                   	pop    %esi
  80204e:	5f                   	pop    %edi
  80204f:	5d                   	pop    %ebp
  802050:	c3                   	ret    
  802051:	8d 76 00             	lea    0x0(%esi),%esi
  802054:	2b 04 24             	sub    (%esp),%eax
  802057:	19 fa                	sbb    %edi,%edx
  802059:	89 d1                	mov    %edx,%ecx
  80205b:	89 c6                	mov    %eax,%esi
  80205d:	e9 71 ff ff ff       	jmp    801fd3 <__umoddi3+0xb3>
  802062:	66 90                	xchg   %ax,%ax
  802064:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802068:	72 ea                	jb     802054 <__umoddi3+0x134>
  80206a:	89 d9                	mov    %ebx,%ecx
  80206c:	e9 62 ff ff ff       	jmp    801fd3 <__umoddi3+0xb3>
