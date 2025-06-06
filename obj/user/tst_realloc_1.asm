
obj/user/tst_realloc_1:     file format elf32-i386


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
  800031:	e8 38 11 00 00       	call   80116e <libmain>
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
  800040:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)
	int kilo = 1024;
  800047:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	void* ptr_allocations[20] = {0};
  80004e:	8d 55 80             	lea    -0x80(%ebp),%edx
  800051:	b9 14 00 00 00       	mov    $0x14,%ecx
  800056:	b8 00 00 00 00       	mov    $0x0,%eax
  80005b:	89 d7                	mov    %edx,%edi
  80005d:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  80005f:	83 ec 0c             	sub    $0xc,%esp
  800062:	68 c0 2d 80 00       	push   $0x802dc0
  800067:	e8 b8 14 00 00       	call   801524 <cprintf>
  80006c:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80006f:	e8 36 26 00 00       	call   8026aa <sys_calculate_free_frames>
  800074:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800077:	e8 b1 26 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80007c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  80007f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800082:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800085:	83 ec 0c             	sub    $0xc,%esp
  800088:	50                   	push   %eax
  800089:	e8 5a 22 00 00       	call   8022e8 <malloc>
  80008e:	83 c4 10             	add    $0x10,%esp
  800091:	89 45 80             	mov    %eax,-0x80(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  800094:	8b 45 80             	mov    -0x80(%ebp),%eax
  800097:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80009c:	74 14                	je     8000b2 <_main+0x7a>
  80009e:	83 ec 04             	sub    $0x4,%esp
  8000a1:	68 e4 2d 80 00       	push   $0x802de4
  8000a6:	6a 11                	push   $0x11
  8000a8:	68 14 2e 80 00       	push   $0x802e14
  8000ad:	e8 be 11 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000b2:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000b5:	e8 f0 25 00 00       	call   8026aa <sys_calculate_free_frames>
  8000ba:	29 c3                	sub    %eax,%ebx
  8000bc:	89 d8                	mov    %ebx,%eax
  8000be:	83 f8 01             	cmp    $0x1,%eax
  8000c1:	74 14                	je     8000d7 <_main+0x9f>
  8000c3:	83 ec 04             	sub    $0x4,%esp
  8000c6:	68 2c 2e 80 00       	push   $0x802e2c
  8000cb:	6a 13                	push   $0x13
  8000cd:	68 14 2e 80 00       	push   $0x802e14
  8000d2:	e8 99 11 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256)panic("Extra or less pages are allocated in PageFile");
  8000d7:	e8 51 26 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8000dc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8000df:	3d 00 01 00 00       	cmp    $0x100,%eax
  8000e4:	74 14                	je     8000fa <_main+0xc2>
  8000e6:	83 ec 04             	sub    $0x4,%esp
  8000e9:	68 98 2e 80 00       	push   $0x802e98
  8000ee:	6a 14                	push   $0x14
  8000f0:	68 14 2e 80 00       	push   $0x802e14
  8000f5:	e8 76 11 00 00       	call   801270 <_panic>
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000fa:	e8 ab 25 00 00       	call   8026aa <sys_calculate_free_frames>
  8000ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800102:	e8 26 26 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800107:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  80010a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80010d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800110:	83 ec 0c             	sub    $0xc,%esp
  800113:	50                   	push   %eax
  800114:	e8 cf 21 00 00       	call   8022e8 <malloc>
  800119:	83 c4 10             	add    $0x10,%esp
  80011c:	89 45 84             	mov    %eax,-0x7c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80011f:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800122:	89 c2                	mov    %eax,%edx
  800124:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800127:	05 00 00 00 80       	add    $0x80000000,%eax
  80012c:	39 c2                	cmp    %eax,%edx
  80012e:	74 14                	je     800144 <_main+0x10c>
  800130:	83 ec 04             	sub    $0x4,%esp
  800133:	68 e4 2d 80 00       	push   $0x802de4
  800138:	6a 19                	push   $0x19
  80013a:	68 14 2e 80 00       	push   $0x802e14
  80013f:	e8 2c 11 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800144:	e8 61 25 00 00       	call   8026aa <sys_calculate_free_frames>
  800149:	89 c2                	mov    %eax,%edx
  80014b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80014e:	39 c2                	cmp    %eax,%edx
  800150:	74 14                	je     800166 <_main+0x12e>
  800152:	83 ec 04             	sub    $0x4,%esp
  800155:	68 2c 2e 80 00       	push   $0x802e2c
  80015a:	6a 1b                	push   $0x1b
  80015c:	68 14 2e 80 00       	push   $0x802e14
  800161:	e8 0a 11 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  800166:	e8 c2 25 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80016b:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80016e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 98 2e 80 00       	push   $0x802e98
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 14 2e 80 00       	push   $0x802e14
  800184:	e8 e7 10 00 00       	call   801270 <_panic>
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800189:	e8 1c 25 00 00       	call   8026aa <sys_calculate_free_frames>
  80018e:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800191:	e8 97 25 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800196:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800199:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80019c:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	50                   	push   %eax
  8001a3:	e8 40 21 00 00       	call   8022e8 <malloc>
  8001a8:	83 c4 10             	add    $0x10,%esp
  8001ab:	89 45 88             	mov    %eax,-0x78(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  8001ae:	8b 45 88             	mov    -0x78(%ebp),%eax
  8001b1:	89 c2                	mov    %eax,%edx
  8001b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001b6:	01 c0                	add    %eax,%eax
  8001b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8001bd:	39 c2                	cmp    %eax,%edx
  8001bf:	74 14                	je     8001d5 <_main+0x19d>
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 e4 2d 80 00       	push   $0x802de4
  8001c9:	6a 21                	push   $0x21
  8001cb:	68 14 2e 80 00       	push   $0x802e14
  8001d0:	e8 9b 10 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001d5:	e8 d0 24 00 00       	call   8026aa <sys_calculate_free_frames>
  8001da:	89 c2                	mov    %eax,%edx
  8001dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001df:	39 c2                	cmp    %eax,%edx
  8001e1:	74 14                	je     8001f7 <_main+0x1bf>
  8001e3:	83 ec 04             	sub    $0x4,%esp
  8001e6:	68 2c 2e 80 00       	push   $0x802e2c
  8001eb:	6a 23                	push   $0x23
  8001ed:	68 14 2e 80 00       	push   $0x802e14
  8001f2:	e8 79 10 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  8001f7:	e8 31 25 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8001fc:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8001ff:	3d 00 01 00 00       	cmp    $0x100,%eax
  800204:	74 14                	je     80021a <_main+0x1e2>
  800206:	83 ec 04             	sub    $0x4,%esp
  800209:	68 98 2e 80 00       	push   $0x802e98
  80020e:	6a 24                	push   $0x24
  800210:	68 14 2e 80 00       	push   $0x802e14
  800215:	e8 56 10 00 00       	call   801270 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80021a:	e8 8b 24 00 00       	call   8026aa <sys_calculate_free_frames>
  80021f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800222:	e8 06 25 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80022a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80022d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	50                   	push   %eax
  800234:	e8 af 20 00 00       	call   8022e8 <malloc>
  800239:	83 c4 10             	add    $0x10,%esp
  80023c:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  80023f:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800242:	89 c1                	mov    %eax,%ecx
  800244:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800247:	89 c2                	mov    %eax,%edx
  800249:	01 d2                	add    %edx,%edx
  80024b:	01 d0                	add    %edx,%eax
  80024d:	05 00 00 00 80       	add    $0x80000000,%eax
  800252:	39 c1                	cmp    %eax,%ecx
  800254:	74 14                	je     80026a <_main+0x232>
  800256:	83 ec 04             	sub    $0x4,%esp
  800259:	68 e4 2d 80 00       	push   $0x802de4
  80025e:	6a 2a                	push   $0x2a
  800260:	68 14 2e 80 00       	push   $0x802e14
  800265:	e8 06 10 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80026a:	e8 3b 24 00 00       	call   8026aa <sys_calculate_free_frames>
  80026f:	89 c2                	mov    %eax,%edx
  800271:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800274:	39 c2                	cmp    %eax,%edx
  800276:	74 14                	je     80028c <_main+0x254>
  800278:	83 ec 04             	sub    $0x4,%esp
  80027b:	68 2c 2e 80 00       	push   $0x802e2c
  800280:	6a 2c                	push   $0x2c
  800282:	68 14 2e 80 00       	push   $0x802e14
  800287:	e8 e4 0f 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are allocated in PageFile");
  80028c:	e8 9c 24 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800291:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800294:	3d 00 01 00 00       	cmp    $0x100,%eax
  800299:	74 14                	je     8002af <_main+0x277>
  80029b:	83 ec 04             	sub    $0x4,%esp
  80029e:	68 98 2e 80 00       	push   $0x802e98
  8002a3:	6a 2d                	push   $0x2d
  8002a5:	68 14 2e 80 00       	push   $0x802e14
  8002aa:	e8 c1 0f 00 00       	call   801270 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8002af:	e8 f6 23 00 00       	call   8026aa <sys_calculate_free_frames>
  8002b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002b7:	e8 71 24 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8002bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  8002bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002c2:	01 c0                	add    %eax,%eax
  8002c4:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	50                   	push   %eax
  8002cb:	e8 18 20 00 00       	call   8022e8 <malloc>
  8002d0:	83 c4 10             	add    $0x10,%esp
  8002d3:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  8002d6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8002d9:	89 c2                	mov    %eax,%edx
  8002db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002de:	c1 e0 02             	shl    $0x2,%eax
  8002e1:	05 00 00 00 80       	add    $0x80000000,%eax
  8002e6:	39 c2                	cmp    %eax,%edx
  8002e8:	74 14                	je     8002fe <_main+0x2c6>
  8002ea:	83 ec 04             	sub    $0x4,%esp
  8002ed:	68 e4 2d 80 00       	push   $0x802de4
  8002f2:	6a 33                	push   $0x33
  8002f4:	68 14 2e 80 00       	push   $0x802e14
  8002f9:	e8 72 0f 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002fe:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800301:	e8 a4 23 00 00       	call   8026aa <sys_calculate_free_frames>
  800306:	29 c3                	sub    %eax,%ebx
  800308:	89 d8                	mov    %ebx,%eax
  80030a:	83 f8 01             	cmp    $0x1,%eax
  80030d:	74 14                	je     800323 <_main+0x2eb>
  80030f:	83 ec 04             	sub    $0x4,%esp
  800312:	68 2c 2e 80 00       	push   $0x802e2c
  800317:	6a 35                	push   $0x35
  800319:	68 14 2e 80 00       	push   $0x802e14
  80031e:	e8 4d 0f 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800323:	e8 05 24 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800328:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80032b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800330:	74 14                	je     800346 <_main+0x30e>
  800332:	83 ec 04             	sub    $0x4,%esp
  800335:	68 98 2e 80 00       	push   $0x802e98
  80033a:	6a 36                	push   $0x36
  80033c:	68 14 2e 80 00       	push   $0x802e14
  800341:	e8 2a 0f 00 00       	call   801270 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800346:	e8 5f 23 00 00       	call   8026aa <sys_calculate_free_frames>
  80034b:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80034e:	e8 da 23 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800353:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  800356:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800359:	01 c0                	add    %eax,%eax
  80035b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  80035e:	83 ec 0c             	sub    $0xc,%esp
  800361:	50                   	push   %eax
  800362:	e8 81 1f 00 00       	call   8022e8 <malloc>
  800367:	83 c4 10             	add    $0x10,%esp
  80036a:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[5] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  80036d:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800370:	89 c1                	mov    %eax,%ecx
  800372:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800375:	89 d0                	mov    %edx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	05 00 00 00 80       	add    $0x80000000,%eax
  800382:	39 c1                	cmp    %eax,%ecx
  800384:	74 14                	je     80039a <_main+0x362>
  800386:	83 ec 04             	sub    $0x4,%esp
  800389:	68 e4 2d 80 00       	push   $0x802de4
  80038e:	6a 3c                	push   $0x3c
  800390:	68 14 2e 80 00       	push   $0x802e14
  800395:	e8 d6 0e 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80039a:	e8 0b 23 00 00       	call   8026aa <sys_calculate_free_frames>
  80039f:	89 c2                	mov    %eax,%edx
  8003a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003a4:	39 c2                	cmp    %eax,%edx
  8003a6:	74 14                	je     8003bc <_main+0x384>
  8003a8:	83 ec 04             	sub    $0x4,%esp
  8003ab:	68 2c 2e 80 00       	push   $0x802e2c
  8003b0:	6a 3e                	push   $0x3e
  8003b2:	68 14 2e 80 00       	push   $0x802e14
  8003b7:	e8 b4 0e 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8003bc:	e8 6c 23 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8003c1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8003c4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003c9:	74 14                	je     8003df <_main+0x3a7>
  8003cb:	83 ec 04             	sub    $0x4,%esp
  8003ce:	68 98 2e 80 00       	push   $0x802e98
  8003d3:	6a 3f                	push   $0x3f
  8003d5:	68 14 2e 80 00       	push   $0x802e14
  8003da:	e8 91 0e 00 00       	call   801270 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8003df:	e8 c6 22 00 00       	call   8026aa <sys_calculate_free_frames>
  8003e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003e7:	e8 41 23 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8003ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8003ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f2:	89 c2                	mov    %eax,%edx
  8003f4:	01 d2                	add    %edx,%edx
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	2b 45 ec             	sub    -0x14(%ebp),%eax
  8003fb:	83 ec 0c             	sub    $0xc,%esp
  8003fe:	50                   	push   %eax
  8003ff:	e8 e4 1e 00 00       	call   8022e8 <malloc>
  800404:	83 c4 10             	add    $0x10,%esp
  800407:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[6] !=  (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  80040a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80040d:	89 c2                	mov    %eax,%edx
  80040f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800412:	c1 e0 03             	shl    $0x3,%eax
  800415:	05 00 00 00 80       	add    $0x80000000,%eax
  80041a:	39 c2                	cmp    %eax,%edx
  80041c:	74 14                	je     800432 <_main+0x3fa>
  80041e:	83 ec 04             	sub    $0x4,%esp
  800421:	68 e4 2d 80 00       	push   $0x802de4
  800426:	6a 45                	push   $0x45
  800428:	68 14 2e 80 00       	push   $0x802e14
  80042d:	e8 3e 0e 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800432:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800435:	e8 70 22 00 00       	call   8026aa <sys_calculate_free_frames>
  80043a:	29 c3                	sub    %eax,%ebx
  80043c:	89 d8                	mov    %ebx,%eax
  80043e:	83 f8 01             	cmp    $0x1,%eax
  800441:	74 14                	je     800457 <_main+0x41f>
  800443:	83 ec 04             	sub    $0x4,%esp
  800446:	68 2c 2e 80 00       	push   $0x802e2c
  80044b:	6a 47                	push   $0x47
  80044d:	68 14 2e 80 00       	push   $0x802e14
  800452:	e8 19 0e 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  800457:	e8 d1 22 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80045c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80045f:	3d 00 03 00 00       	cmp    $0x300,%eax
  800464:	74 14                	je     80047a <_main+0x442>
  800466:	83 ec 04             	sub    $0x4,%esp
  800469:	68 98 2e 80 00       	push   $0x802e98
  80046e:	6a 48                	push   $0x48
  800470:	68 14 2e 80 00       	push   $0x802e14
  800475:	e8 f6 0d 00 00       	call   801270 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80047a:	e8 2b 22 00 00       	call   8026aa <sys_calculate_free_frames>
  80047f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800482:	e8 a6 22 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800487:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  80048a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80048d:	89 c2                	mov    %eax,%edx
  80048f:	01 d2                	add    %edx,%edx
  800491:	01 d0                	add    %edx,%eax
  800493:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800496:	83 ec 0c             	sub    $0xc,%esp
  800499:	50                   	push   %eax
  80049a:	e8 49 1e 00 00       	call   8022e8 <malloc>
  80049f:	83 c4 10             	add    $0x10,%esp
  8004a2:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[7] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8004a5:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004a8:	89 c1                	mov    %eax,%ecx
  8004aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004ad:	89 d0                	mov    %edx,%eax
  8004af:	c1 e0 02             	shl    $0x2,%eax
  8004b2:	01 d0                	add    %edx,%eax
  8004b4:	01 c0                	add    %eax,%eax
  8004b6:	01 d0                	add    %edx,%eax
  8004b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8004bd:	39 c1                	cmp    %eax,%ecx
  8004bf:	74 14                	je     8004d5 <_main+0x49d>
  8004c1:	83 ec 04             	sub    $0x4,%esp
  8004c4:	68 e4 2d 80 00       	push   $0x802de4
  8004c9:	6a 4e                	push   $0x4e
  8004cb:	68 14 2e 80 00       	push   $0x802e14
  8004d0:	e8 9b 0d 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8004d5:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8004d8:	e8 cd 21 00 00       	call   8026aa <sys_calculate_free_frames>
  8004dd:	29 c3                	sub    %eax,%ebx
  8004df:	89 d8                	mov    %ebx,%eax
  8004e1:	83 f8 01             	cmp    $0x1,%eax
  8004e4:	74 14                	je     8004fa <_main+0x4c2>
  8004e6:	83 ec 04             	sub    $0x4,%esp
  8004e9:	68 2c 2e 80 00       	push   $0x802e2c
  8004ee:	6a 50                	push   $0x50
  8004f0:	68 14 2e 80 00       	push   $0x802e14
  8004f5:	e8 76 0d 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are allocated in PageFile");
  8004fa:	e8 2e 22 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8004ff:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800502:	3d 00 03 00 00       	cmp    $0x300,%eax
  800507:	74 14                	je     80051d <_main+0x4e5>
  800509:	83 ec 04             	sub    $0x4,%esp
  80050c:	68 98 2e 80 00       	push   $0x802e98
  800511:	6a 51                	push   $0x51
  800513:	68 14 2e 80 00       	push   $0x802e14
  800518:	e8 53 0d 00 00       	call   801270 <_panic>


		//NEW
		//Filling the remaining size of user heap
		freeFrames = sys_calculate_free_frames() ;
  80051d:	e8 88 21 00 00       	call   8026aa <sys_calculate_free_frames>
  800522:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800525:	e8 03 22 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80052a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		uint32 remainingSpaceInUHeap = (USER_HEAP_MAX - USER_HEAP_START) - 14 * Mega;
  80052d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800530:	89 d0                	mov    %edx,%eax
  800532:	01 c0                	add    %eax,%eax
  800534:	01 d0                	add    %edx,%eax
  800536:	01 c0                	add    %eax,%eax
  800538:	01 d0                	add    %edx,%eax
  80053a:	01 c0                	add    %eax,%eax
  80053c:	f7 d8                	neg    %eax
  80053e:	05 00 00 00 20       	add    $0x20000000,%eax
  800543:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(remainingSpaceInUHeap - kilo);
  800546:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800549:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80054c:	29 c2                	sub    %eax,%edx
  80054e:	89 d0                	mov    %edx,%eax
  800550:	83 ec 0c             	sub    $0xc,%esp
  800553:	50                   	push   %eax
  800554:	e8 8f 1d 00 00       	call   8022e8 <malloc>
  800559:	83 c4 10             	add    $0x10,%esp
  80055c:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  80055f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800562:	89 c1                	mov    %eax,%ecx
  800564:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800567:	89 d0                	mov    %edx,%eax
  800569:	01 c0                	add    %eax,%eax
  80056b:	01 d0                	add    %edx,%eax
  80056d:	01 c0                	add    %eax,%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	01 c0                	add    %eax,%eax
  800573:	05 00 00 00 80       	add    $0x80000000,%eax
  800578:	39 c1                	cmp    %eax,%ecx
  80057a:	74 14                	je     800590 <_main+0x558>
  80057c:	83 ec 04             	sub    $0x4,%esp
  80057f:	68 e4 2d 80 00       	push   $0x802de4
  800584:	6a 5a                	push   $0x5a
  800586:	68 14 2e 80 00       	push   $0x802e14
  80058b:	e8 e0 0c 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 124) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800590:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800593:	e8 12 21 00 00       	call   8026aa <sys_calculate_free_frames>
  800598:	29 c3                	sub    %eax,%ebx
  80059a:	89 d8                	mov    %ebx,%eax
  80059c:	83 f8 7c             	cmp    $0x7c,%eax
  80059f:	74 14                	je     8005b5 <_main+0x57d>
  8005a1:	83 ec 04             	sub    $0x4,%esp
  8005a4:	68 2c 2e 80 00       	push   $0x802e2c
  8005a9:	6a 5c                	push   $0x5c
  8005ab:	68 14 2e 80 00       	push   $0x802e14
  8005b0:	e8 bb 0c 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 127488) panic("Extra or less pages are allocated in PageFile");
  8005b5:	e8 73 21 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8005ba:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8005bd:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  8005c2:	74 14                	je     8005d8 <_main+0x5a0>
  8005c4:	83 ec 04             	sub    $0x4,%esp
  8005c7:	68 98 2e 80 00       	push   $0x802e98
  8005cc:	6a 5d                	push   $0x5d
  8005ce:	68 14 2e 80 00       	push   $0x802e14
  8005d3:	e8 98 0c 00 00       	call   801270 <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005d8:	e8 cd 20 00 00       	call   8026aa <sys_calculate_free_frames>
  8005dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005e0:	e8 48 21 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8005e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[1]);
  8005e8:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8005eb:	83 ec 0c             	sub    $0xc,%esp
  8005ee:	50                   	push   %eax
  8005ef:	e8 15 1e 00 00       	call   802409 <free>
  8005f4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 256) panic("Wrong free: Extra or less pages are removed from PageFile");
  8005f7:	e8 31 21 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8005fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8005ff:	29 c2                	sub    %eax,%edx
  800601:	89 d0                	mov    %edx,%eax
  800603:	3d 00 01 00 00       	cmp    $0x100,%eax
  800608:	74 14                	je     80061e <_main+0x5e6>
  80060a:	83 ec 04             	sub    $0x4,%esp
  80060d:	68 c8 2e 80 00       	push   $0x802ec8
  800612:	6a 68                	push   $0x68
  800614:	68 14 2e 80 00       	push   $0x802e14
  800619:	e8 52 0c 00 00       	call   801270 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80061e:	e8 87 20 00 00       	call   8026aa <sys_calculate_free_frames>
  800623:	89 c2                	mov    %eax,%edx
  800625:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800628:	39 c2                	cmp    %eax,%edx
  80062a:	74 14                	je     800640 <_main+0x608>
  80062c:	83 ec 04             	sub    $0x4,%esp
  80062f:	68 04 2f 80 00       	push   $0x802f04
  800634:	6a 69                	push   $0x69
  800636:	68 14 2e 80 00       	push   $0x802e14
  80063b:	e8 30 0c 00 00       	call   801270 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800640:	e8 65 20 00 00       	call   8026aa <sys_calculate_free_frames>
  800645:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800648:	e8 e0 20 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80064d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[4]);
  800650:	8b 45 90             	mov    -0x70(%ebp),%eax
  800653:	83 ec 0c             	sub    $0xc,%esp
  800656:	50                   	push   %eax
  800657:	e8 ad 1d 00 00       	call   802409 <free>
  80065c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  80065f:	e8 c9 20 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800664:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800667:	29 c2                	sub    %eax,%edx
  800669:	89 d0                	mov    %edx,%eax
  80066b:	3d 00 02 00 00       	cmp    $0x200,%eax
  800670:	74 14                	je     800686 <_main+0x64e>
  800672:	83 ec 04             	sub    $0x4,%esp
  800675:	68 c8 2e 80 00       	push   $0x802ec8
  80067a:	6a 70                	push   $0x70
  80067c:	68 14 2e 80 00       	push   $0x802e14
  800681:	e8 ea 0b 00 00       	call   801270 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800686:	e8 1f 20 00 00       	call   8026aa <sys_calculate_free_frames>
  80068b:	89 c2                	mov    %eax,%edx
  80068d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800690:	39 c2                	cmp    %eax,%edx
  800692:	74 14                	je     8006a8 <_main+0x670>
  800694:	83 ec 04             	sub    $0x4,%esp
  800697:	68 04 2f 80 00       	push   $0x802f04
  80069c:	6a 71                	push   $0x71
  80069e:	68 14 2e 80 00       	push   $0x802e14
  8006a3:	e8 c8 0b 00 00       	call   801270 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8006a8:	e8 fd 1f 00 00       	call   8026aa <sys_calculate_free_frames>
  8006ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006b0:	e8 78 20 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8006b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[6]);
  8006b8:	8b 45 98             	mov    -0x68(%ebp),%eax
  8006bb:	83 ec 0c             	sub    $0xc,%esp
  8006be:	50                   	push   %eax
  8006bf:	e8 45 1d 00 00       	call   802409 <free>
  8006c4:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 768) panic("Wrong free: Extra or less pages are removed from PageFile");
  8006c7:	e8 61 20 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  8006cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006cf:	29 c2                	sub    %eax,%edx
  8006d1:	89 d0                	mov    %edx,%eax
  8006d3:	3d 00 03 00 00       	cmp    $0x300,%eax
  8006d8:	74 14                	je     8006ee <_main+0x6b6>
  8006da:	83 ec 04             	sub    $0x4,%esp
  8006dd:	68 c8 2e 80 00       	push   $0x802ec8
  8006e2:	6a 78                	push   $0x78
  8006e4:	68 14 2e 80 00       	push   $0x802e14
  8006e9:	e8 82 0b 00 00       	call   801270 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8006ee:	e8 b7 1f 00 00       	call   8026aa <sys_calculate_free_frames>
  8006f3:	89 c2                	mov    %eax,%edx
  8006f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006f8:	39 c2                	cmp    %eax,%edx
  8006fa:	74 14                	je     800710 <_main+0x6d8>
  8006fc:	83 ec 04             	sub    $0x4,%esp
  8006ff:	68 04 2f 80 00       	push   $0x802f04
  800704:	6a 79                	push   $0x79
  800706:	68 14 2e 80 00       	push   $0x802e14
  80070b:	e8 60 0b 00 00       	call   801270 <_panic>

		//NEW
		//free the latest Hole (the big one)
		freeFrames = sys_calculate_free_frames() ;
  800710:	e8 95 1f 00 00       	call   8026aa <sys_calculate_free_frames>
  800715:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800718:	e8 10 20 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80071d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[8]);
  800720:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800723:	83 ec 0c             	sub    $0xc,%esp
  800726:	50                   	push   %eax
  800727:	e8 dd 1c 00 00       	call   802409 <free>
  80072c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 127488) panic("Wrong free: Extra or less pages are removed from PageFile");
  80072f:	e8 f9 1f 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800734:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800737:	29 c2                	sub    %eax,%edx
  800739:	89 d0                	mov    %edx,%eax
  80073b:	3d 00 f2 01 00       	cmp    $0x1f200,%eax
  800740:	74 17                	je     800759 <_main+0x721>
  800742:	83 ec 04             	sub    $0x4,%esp
  800745:	68 c8 2e 80 00       	push   $0x802ec8
  80074a:	68 81 00 00 00       	push   $0x81
  80074f:	68 14 2e 80 00       	push   $0x802e14
  800754:	e8 17 0b 00 00       	call   801270 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800759:	e8 4c 1f 00 00       	call   8026aa <sys_calculate_free_frames>
  80075e:	89 c2                	mov    %eax,%edx
  800760:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800763:	39 c2                	cmp    %eax,%edx
  800765:	74 17                	je     80077e <_main+0x746>
  800767:	83 ec 04             	sub    $0x4,%esp
  80076a:	68 04 2f 80 00       	push   $0x802f04
  80076f:	68 82 00 00 00       	push   $0x82
  800774:	68 14 2e 80 00       	push   $0x802e14
  800779:	e8 f2 0a 00 00       	call   801270 <_panic>
	}
	int cnt = 0;
  80077e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	//[3] Test Re-allocation
	{
		/*CASE1: Re-allocate that's fit in the same location*/

		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800785:	e8 20 1f 00 00       	call   8026aa <sys_calculate_free_frames>
  80078a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80078d:	e8 9b 1f 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800792:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = malloc(512*kilo - kilo);
  800795:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800798:	89 d0                	mov    %edx,%eax
  80079a:	c1 e0 09             	shl    $0x9,%eax
  80079d:	29 d0                	sub    %edx,%eax
  80079f:	83 ec 0c             	sub    $0xc,%esp
  8007a2:	50                   	push   %eax
  8007a3:	e8 40 1b 00 00       	call   8022e8 <malloc>
  8007a8:	83 c4 10             	add    $0x10,%esp
  8007ab:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[9] !=  (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8007ae:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8007b1:	89 c2                	mov    %eax,%edx
  8007b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b6:	05 00 00 00 80       	add    $0x80000000,%eax
  8007bb:	39 c2                	cmp    %eax,%edx
  8007bd:	74 17                	je     8007d6 <_main+0x79e>
  8007bf:	83 ec 04             	sub    $0x4,%esp
  8007c2:	68 e4 2d 80 00       	push   $0x802de4
  8007c7:	68 8e 00 00 00       	push   $0x8e
  8007cc:	68 14 2e 80 00       	push   $0x802e14
  8007d1:	e8 9a 0a 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8007d6:	e8 cf 1e 00 00       	call   8026aa <sys_calculate_free_frames>
  8007db:	89 c2                	mov    %eax,%edx
  8007dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007e0:	39 c2                	cmp    %eax,%edx
  8007e2:	74 17                	je     8007fb <_main+0x7c3>
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	68 2c 2e 80 00       	push   $0x802e2c
  8007ec:	68 90 00 00 00       	push   $0x90
  8007f1:	68 14 2e 80 00       	push   $0x802e14
  8007f6:	e8 75 0a 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 128) panic("Extra or less pages are allocated in PageFile");
  8007fb:	e8 2d 1f 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800800:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800803:	3d 80 00 00 00       	cmp    $0x80,%eax
  800808:	74 17                	je     800821 <_main+0x7e9>
  80080a:	83 ec 04             	sub    $0x4,%esp
  80080d:	68 98 2e 80 00       	push   $0x802e98
  800812:	68 91 00 00 00       	push   $0x91
  800817:	68 14 2e 80 00       	push   $0x802e14
  80081c:	e8 4f 0a 00 00       	call   801270 <_panic>

		//Fill it with data
		int *intArr = (int*) ptr_allocations[9];
  800821:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800824:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int lastIndexOfInt1 = ((512)*kilo)/sizeof(int) - 1;
  800827:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80082a:	c1 e0 09             	shl    $0x9,%eax
  80082d:	c1 e8 02             	shr    $0x2,%eax
  800830:	48                   	dec    %eax
  800831:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		int i = 0;
  800834:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)



		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  80083b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800842:	eb 17                	jmp    80085b <_main+0x823>
		{
			intArr[i] = i ;
  800844:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800847:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80084e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800851:	01 c2                	add    %eax,%edx
  800853:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800856:	89 02                	mov    %eax,(%edx)



		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800858:	ff 45 f4             	incl   -0xc(%ebp)
  80085b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  80085f:	7e e3                	jle    800844 <_main+0x80c>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800861:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800864:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800867:	eb 17                	jmp    800880 <_main+0x848>
		{
			intArr[i] = i ;
  800869:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80086c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800873:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800876:	01 c2                	add    %eax,%edx
  800878:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80087b:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  80087d:	ff 4d f4             	decl   -0xc(%ebp)
  800880:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800883:	83 e8 64             	sub    $0x64,%eax
  800886:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800889:	7c de                	jl     800869 <_main+0x831>
		{
			intArr[i] = i ;
		}

		//Reallocate it [expanded in the same place]
		freeFrames = sys_calculate_free_frames() ;
  80088b:	e8 1a 1e 00 00       	call   8026aa <sys_calculate_free_frames>
  800890:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800893:	e8 95 1e 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800898:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = realloc(ptr_allocations[9], 512*kilo + 256*kilo - kilo);
  80089b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80089e:	89 d0                	mov    %edx,%eax
  8008a0:	01 c0                	add    %eax,%eax
  8008a2:	01 d0                	add    %edx,%eax
  8008a4:	c1 e0 08             	shl    $0x8,%eax
  8008a7:	29 d0                	sub    %edx,%eax
  8008a9:	89 c2                	mov    %eax,%edx
  8008ab:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8008ae:	83 ec 08             	sub    $0x8,%esp
  8008b1:	52                   	push   %edx
  8008b2:	50                   	push   %eax
  8008b3:	e8 69 1c 00 00       	call   802521 <realloc>
  8008b8:	83 c4 10             	add    $0x10,%esp
  8008bb:	89 45 a4             	mov    %eax,-0x5c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the re-allocated space... ");
  8008be:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8008c1:	89 c2                	mov    %eax,%edx
  8008c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c6:	05 00 00 00 80       	add    $0x80000000,%eax
  8008cb:	39 c2                	cmp    %eax,%edx
  8008cd:	74 17                	je     8008e6 <_main+0x8ae>
  8008cf:	83 ec 04             	sub    $0x4,%esp
  8008d2:	68 50 2f 80 00       	push   $0x802f50
  8008d7:	68 ae 00 00 00       	push   $0xae
  8008dc:	68 14 2e 80 00       	push   $0x802e14
  8008e1:	e8 8a 09 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong re-allocation");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
  8008e6:	e8 bf 1d 00 00       	call   8026aa <sys_calculate_free_frames>
  8008eb:	89 c2                	mov    %eax,%edx
  8008ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008f0:	39 c2                	cmp    %eax,%edx
  8008f2:	74 17                	je     80090b <_main+0x8d3>
  8008f4:	83 ec 04             	sub    $0x4,%esp
  8008f7:	68 84 2f 80 00       	push   $0x802f84
  8008fc:	68 b0 00 00 00       	push   $0xb0
  800901:	68 14 2e 80 00       	push   $0x802e14
  800906:	e8 65 09 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 64) panic("Extra or less pages are re-allocated in PageFile");
  80090b:	e8 1d 1e 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800910:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800913:	83 f8 40             	cmp    $0x40,%eax
  800916:	74 17                	je     80092f <_main+0x8f7>
  800918:	83 ec 04             	sub    $0x4,%esp
  80091b:	68 f4 2f 80 00       	push   $0x802ff4
  800920:	68 b1 00 00 00       	push   $0xb1
  800925:	68 14 2e 80 00       	push   $0x802e14
  80092a:	e8 41 09 00 00       	call   801270 <_panic>


		//[2] test memory access
		int lastIndexOfInt2 = ((512+256)*kilo)/sizeof(int) - 1;
  80092f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800932:	89 d0                	mov    %edx,%eax
  800934:	01 c0                	add    %eax,%eax
  800936:	01 d0                	add    %edx,%eax
  800938:	c1 e0 08             	shl    $0x8,%eax
  80093b:	c1 e8 02             	shr    $0x2,%eax
  80093e:	48                   	dec    %eax
  80093f:	89 45 d0             	mov    %eax,-0x30(%ebp)

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800942:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800945:	40                   	inc    %eax
  800946:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800949:	eb 17                	jmp    800962 <_main+0x92a>
		{
			intArr[i] = i;
  80094b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80094e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800955:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800958:	01 c2                	add    %eax,%edx
  80095a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80095d:	89 02                	mov    %eax,(%edx)
		//[2] test memory access
		int lastIndexOfInt2 = ((512+256)*kilo)/sizeof(int) - 1;

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  80095f:	ff 45 f4             	incl   -0xc(%ebp)
  800962:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800965:	83 c0 65             	add    $0x65,%eax
  800968:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80096b:	7f de                	jg     80094b <_main+0x913>
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  80096d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800970:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800973:	eb 17                	jmp    80098c <_main+0x954>
		{
			intArr[i] = i;
  800975:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800978:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80097f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800982:	01 c2                	add    %eax,%edx
  800984:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800987:	89 02                	mov    %eax,(%edx)
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800989:	ff 4d f4             	decl   -0xc(%ebp)
  80098c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80098f:	83 e8 64             	sub    $0x64,%eax
  800992:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800995:	7c de                	jl     800975 <_main+0x93d>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800997:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80099e:	eb 30                	jmp    8009d0 <_main+0x998>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8009ad:	01 d0                	add    %edx,%eax
  8009af:	8b 00                	mov    (%eax),%eax
  8009b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8009b4:	74 17                	je     8009cd <_main+0x995>
  8009b6:	83 ec 04             	sub    $0x4,%esp
  8009b9:	68 28 30 80 00       	push   $0x803028
  8009be:	68 c6 00 00 00       	push   $0xc6
  8009c3:	68 14 2e 80 00       	push   $0x802e14
  8009c8:	e8 a3 08 00 00       	call   801270 <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  8009cd:	ff 45 f4             	incl   -0xc(%ebp)
  8009d0:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  8009d4:	7e ca                	jle    8009a0 <_main+0x968>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  8009d6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8009dc:	eb 30                	jmp    800a0e <_main+0x9d6>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8009de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009e8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8009eb:	01 d0                	add    %edx,%eax
  8009ed:	8b 00                	mov    (%eax),%eax
  8009ef:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8009f2:	74 17                	je     800a0b <_main+0x9d3>
  8009f4:	83 ec 04             	sub    $0x4,%esp
  8009f7:	68 28 30 80 00       	push   $0x803028
  8009fc:	68 cc 00 00 00       	push   $0xcc
  800a01:	68 14 2e 80 00       	push   $0x802e14
  800a06:	e8 65 08 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800a0b:	ff 4d f4             	decl   -0xc(%ebp)
  800a0e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a11:	83 e8 64             	sub    $0x64,%eax
  800a14:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a17:	7c c5                	jl     8009de <_main+0x9a6>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800a19:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a1c:	40                   	inc    %eax
  800a1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a20:	eb 30                	jmp    800a52 <_main+0xa1a>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a25:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a2c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800a2f:	01 d0                	add    %edx,%eax
  800a31:	8b 00                	mov    (%eax),%eax
  800a33:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a36:	74 17                	je     800a4f <_main+0xa17>
  800a38:	83 ec 04             	sub    $0x4,%esp
  800a3b:	68 28 30 80 00       	push   $0x803028
  800a40:	68 d2 00 00 00       	push   $0xd2
  800a45:	68 14 2e 80 00       	push   $0x802e14
  800a4a:	e8 21 08 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800a4f:	ff 45 f4             	incl   -0xc(%ebp)
  800a52:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a55:	83 c0 65             	add    $0x65,%eax
  800a58:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a5b:	7f c5                	jg     800a22 <_main+0x9ea>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800a5d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a63:	eb 30                	jmp    800a95 <_main+0xa5d>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800a72:	01 d0                	add    %edx,%eax
  800a74:	8b 00                	mov    (%eax),%eax
  800a76:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a79:	74 17                	je     800a92 <_main+0xa5a>
  800a7b:	83 ec 04             	sub    $0x4,%esp
  800a7e:	68 28 30 80 00       	push   $0x803028
  800a83:	68 d8 00 00 00       	push   $0xd8
  800a88:	68 14 2e 80 00       	push   $0x802e14
  800a8d:	e8 de 07 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800a92:	ff 4d f4             	decl   -0xc(%ebp)
  800a95:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a98:	83 e8 64             	sub    $0x64,%eax
  800a9b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800a9e:	7c c5                	jl     800a65 <_main+0xa2d>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800aa0:	e8 05 1c 00 00       	call   8026aa <sys_calculate_free_frames>
  800aa5:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800aa8:	e8 80 1c 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800aad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[9]);
  800ab0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800ab3:	83 ec 0c             	sub    $0xc,%esp
  800ab6:	50                   	push   %eax
  800ab7:	e8 4d 19 00 00       	call   802409 <free>
  800abc:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 192) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 192) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800abf:	e8 69 1c 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800ac4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ac7:	29 c2                	sub    %eax,%edx
  800ac9:	89 d0                	mov    %edx,%eax
  800acb:	3d c0 00 00 00       	cmp    $0xc0,%eax
  800ad0:	74 17                	je     800ae9 <_main+0xab1>
  800ad2:	83 ec 04             	sub    $0x4,%esp
  800ad5:	68 60 30 80 00       	push   $0x803060
  800ada:	68 e0 00 00 00       	push   $0xe0
  800adf:	68 14 2e 80 00       	push   $0x802e14
  800ae4:	e8 87 07 00 00       	call   801270 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ae9:	e8 bc 1b 00 00       	call   8026aa <sys_calculate_free_frames>
  800aee:	89 c2                	mov    %eax,%edx
  800af0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800af3:	29 c2                	sub    %eax,%edx
  800af5:	89 d0                	mov    %edx,%eax
  800af7:	83 f8 05             	cmp    $0x5,%eax
  800afa:	74 17                	je     800b13 <_main+0xadb>
  800afc:	83 ec 04             	sub    $0x4,%esp
  800aff:	68 04 2f 80 00       	push   $0x802f04
  800b04:	68 e1 00 00 00       	push   $0xe1
  800b09:	68 14 2e 80 00       	push   $0x802e14
  800b0e:	e8 5d 07 00 00       	call   801270 <_panic>

		vcprintf("\b\b\b40%", NULL);
  800b13:	83 ec 08             	sub    $0x8,%esp
  800b16:	6a 00                	push   $0x0
  800b18:	68 b4 30 80 00       	push   $0x8030b4
  800b1d:	e8 97 09 00 00       	call   8014b9 <vcprintf>
  800b22:	83 c4 10             	add    $0x10,%esp

		/*CASE2: Re-allocate that's not fit in the same location*/

		//Allocate 1.5 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800b25:	e8 80 1b 00 00       	call   8026aa <sys_calculate_free_frames>
  800b2a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b2d:	e8 fb 1b 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800b32:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = malloc(1*Mega + 512*kilo - kilo);
  800b35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b38:	c1 e0 09             	shl    $0x9,%eax
  800b3b:	89 c2                	mov    %eax,%edx
  800b3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b40:	01 d0                	add    %edx,%eax
  800b42:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800b45:	83 ec 0c             	sub    $0xc,%esp
  800b48:	50                   	push   %eax
  800b49:	e8 9a 17 00 00       	call   8022e8 <malloc>
  800b4e:	83 c4 10             	add    $0x10,%esp
  800b51:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[9] !=  (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800b54:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800b57:	89 c2                	mov    %eax,%edx
  800b59:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5c:	c1 e0 02             	shl    $0x2,%eax
  800b5f:	05 00 00 00 80       	add    $0x80000000,%eax
  800b64:	39 c2                	cmp    %eax,%edx
  800b66:	74 17                	je     800b7f <_main+0xb47>
  800b68:	83 ec 04             	sub    $0x4,%esp
  800b6b:	68 e4 2d 80 00       	push   $0x802de4
  800b70:	68 eb 00 00 00       	push   $0xeb
  800b75:	68 14 2e 80 00       	push   $0x802e14
  800b7a:	e8 f1 06 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 384) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800b7f:	e8 26 1b 00 00       	call   8026aa <sys_calculate_free_frames>
  800b84:	89 c2                	mov    %eax,%edx
  800b86:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b89:	39 c2                	cmp    %eax,%edx
  800b8b:	74 17                	je     800ba4 <_main+0xb6c>
  800b8d:	83 ec 04             	sub    $0x4,%esp
  800b90:	68 2c 2e 80 00       	push   $0x802e2c
  800b95:	68 ed 00 00 00       	push   $0xed
  800b9a:	68 14 2e 80 00       	push   $0x802e14
  800b9f:	e8 cc 06 00 00       	call   801270 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 384) panic("Extra or less pages are allocated in PageFile");
  800ba4:	e8 84 1b 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800ba9:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800bac:	3d 80 01 00 00       	cmp    $0x180,%eax
  800bb1:	74 17                	je     800bca <_main+0xb92>
  800bb3:	83 ec 04             	sub    $0x4,%esp
  800bb6:	68 98 2e 80 00       	push   $0x802e98
  800bbb:	68 ee 00 00 00       	push   $0xee
  800bc0:	68 14 2e 80 00       	push   $0x802e14
  800bc5:	e8 a6 06 00 00       	call   801270 <_panic>

		//Fill it with data
		intArr = (int*) ptr_allocations[9];
  800bca:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800bcd:	89 45 d8             	mov    %eax,-0x28(%ebp)
		lastIndexOfInt1 = (1*Mega + 512*kilo)/sizeof(int) - 1;
  800bd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bd3:	c1 e0 09             	shl    $0x9,%eax
  800bd6:	89 c2                	mov    %eax,%edx
  800bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bdb:	01 d0                	add    %edx,%eax
  800bdd:	c1 e8 02             	shr    $0x2,%eax
  800be0:	48                   	dec    %eax
  800be1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		i = 0;
  800be4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800beb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800bf2:	eb 17                	jmp    800c0b <_main+0xbd3>
		{
			intArr[i] = i ;
  800bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bf7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800bfe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c01:	01 c2                	add    %eax,%edx
  800c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c06:	89 02                	mov    %eax,(%edx)
		lastIndexOfInt1 = (1*Mega + 512*kilo)/sizeof(int) - 1;
		i = 0;

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800c08:	ff 45 f4             	incl   -0xc(%ebp)
  800c0b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800c0f:	7e e3                	jle    800bf4 <_main+0xbbc>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800c11:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800c17:	eb 17                	jmp    800c30 <_main+0xbf8>
		{
			intArr[i] = i ;
  800c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c1c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c23:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c26:	01 c2                	add    %eax,%edx
  800c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800c2b:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800c2d:	ff 4d f4             	decl   -0xc(%ebp)
  800c30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800c33:	83 e8 64             	sub    $0x64,%eax
  800c36:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800c39:	7c de                	jl     800c19 <_main+0xbe1>
		{
			intArr[i] = i ;
		}

		//Reallocate it to 2.5 MB [should be moved to next hole]
		freeFrames = sys_calculate_free_frames() ;
  800c3b:	e8 6a 1a 00 00       	call   8026aa <sys_calculate_free_frames>
  800c40:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c43:	e8 e5 1a 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800c48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[9] = realloc(ptr_allocations[9], 1*Mega + 512*kilo + 1*Mega - kilo);
  800c4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c4e:	c1 e0 09             	shl    $0x9,%eax
  800c51:	89 c2                	mov    %eax,%edx
  800c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c56:	01 c2                	add    %eax,%edx
  800c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5b:	01 d0                	add    %edx,%eax
  800c5d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800c60:	89 c2                	mov    %eax,%edx
  800c62:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	52                   	push   %edx
  800c69:	50                   	push   %eax
  800c6a:	e8 b2 18 00 00       	call   802521 <realloc>
  800c6f:	83 c4 10             	add    $0x10,%esp
  800c72:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the re-allocated space... ");
  800c75:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800c78:	89 c2                	mov    %eax,%edx
  800c7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7d:	c1 e0 03             	shl    $0x3,%eax
  800c80:	05 00 00 00 80       	add    $0x80000000,%eax
  800c85:	39 c2                	cmp    %eax,%edx
  800c87:	74 17                	je     800ca0 <_main+0xc68>
  800c89:	83 ec 04             	sub    $0x4,%esp
  800c8c:	68 50 2f 80 00       	push   $0x802f50
  800c91:	68 07 01 00 00       	push   $0x107
  800c96:	68 14 2e 80 00       	push   $0x802e14
  800c9b:	e8 d0 05 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong re-allocation");

		//if((sys_calculate_free_frames() - freeFrames) != 3) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 256) panic("Extra or less pages are re-allocated in PageFile");
  800ca0:	e8 88 1a 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800ca5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800ca8:	3d 00 01 00 00       	cmp    $0x100,%eax
  800cad:	74 17                	je     800cc6 <_main+0xc8e>
  800caf:	83 ec 04             	sub    $0x4,%esp
  800cb2:	68 f4 2f 80 00       	push   $0x802ff4
  800cb7:	68 0b 01 00 00       	push   $0x10b
  800cbc:	68 14 2e 80 00       	push   $0x802e14
  800cc1:	e8 aa 05 00 00       	call   801270 <_panic>

		//[2] test memory access
		lastIndexOfInt2 = (2*Mega + 512*kilo)/sizeof(int) - 1;
  800cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc9:	c1 e0 08             	shl    $0x8,%eax
  800ccc:	89 c2                	mov    %eax,%edx
  800cce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd1:	01 d0                	add    %edx,%eax
  800cd3:	01 c0                	add    %eax,%eax
  800cd5:	c1 e8 02             	shr    $0x2,%eax
  800cd8:	48                   	dec    %eax
  800cd9:	89 45 d0             	mov    %eax,-0x30(%ebp)
		intArr = (int*) ptr_allocations[9];
  800cdc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800cdf:	89 45 d8             	mov    %eax,-0x28(%ebp)



		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800ce2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ce5:	40                   	inc    %eax
  800ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ce9:	eb 17                	jmp    800d02 <_main+0xcca>
		{
			intArr[i] = i;
  800ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cf5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800cf8:	01 c2                	add    %eax,%edx
  800cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cfd:	89 02                	mov    %eax,(%edx)



		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800cff:	ff 45 f4             	incl   -0xc(%ebp)
  800d02:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d05:	83 c0 65             	add    $0x65,%eax
  800d08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d0b:	7f de                	jg     800ceb <_main+0xcb3>
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800d0d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d13:	eb 17                	jmp    800d2c <_main+0xcf4>
		{
			intArr[i] = i;
  800d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d18:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d1f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d22:	01 c2                	add    %eax,%edx
  800d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d27:	89 02                	mov    %eax,(%edx)
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
		{
			intArr[i] = i;
		}
		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800d29:	ff 4d f4             	decl   -0xc(%ebp)
  800d2c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d2f:	83 e8 64             	sub    $0x64,%eax
  800d32:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d35:	7c de                	jl     800d15 <_main+0xcdd>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800d37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800d3e:	eb 30                	jmp    800d70 <_main+0xd38>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d4d:	01 d0                	add    %edx,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d54:	74 17                	je     800d6d <_main+0xd35>
  800d56:	83 ec 04             	sub    $0x4,%esp
  800d59:	68 28 30 80 00       	push   $0x803028
  800d5e:	68 22 01 00 00       	push   $0x122
  800d63:	68 14 2e 80 00       	push   $0x802e14
  800d68:	e8 03 05 00 00       	call   801270 <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800d6d:	ff 45 f4             	incl   -0xc(%ebp)
  800d70:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800d74:	7e ca                	jle    800d40 <_main+0xd08>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800d76:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d7c:	eb 30                	jmp    800dae <_main+0xd76>
		{
			if (intArr[i] != i)
  800d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d81:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d88:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d8b:	01 d0                	add    %edx,%eax
  800d8d:	8b 00                	mov    (%eax),%eax
  800d8f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800d92:	74 17                	je     800dab <_main+0xd73>
			{
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800d94:	83 ec 04             	sub    $0x4,%esp
  800d97:	68 28 30 80 00       	push   $0x803028
  800d9c:	68 2a 01 00 00       	push   $0x12a
  800da1:	68 14 2e 80 00       	push   $0x802e14
  800da6:	e8 c5 04 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  800dab:	ff 4d f4             	decl   -0xc(%ebp)
  800dae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800db1:	83 e8 64             	sub    $0x64,%eax
  800db4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800db7:	7c c5                	jl     800d7e <_main+0xd46>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800db9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800dbc:	40                   	inc    %eax
  800dbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dc0:	eb 30                	jmp    800df2 <_main+0xdba>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dc5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800dcc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800dcf:	01 d0                	add    %edx,%eax
  800dd1:	8b 00                	mov    (%eax),%eax
  800dd3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800dd6:	74 17                	je     800def <_main+0xdb7>
  800dd8:	83 ec 04             	sub    $0x4,%esp
  800ddb:	68 28 30 80 00       	push   $0x803028
  800de0:	68 31 01 00 00       	push   $0x131
  800de5:	68 14 2e 80 00       	push   $0x802e14
  800dea:	e8 81 04 00 00       	call   801270 <_panic>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800def:	ff 45 f4             	incl   -0xc(%ebp)
  800df2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800df5:	83 c0 65             	add    $0x65,%eax
  800df8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800dfb:	7f c5                	jg     800dc2 <_main+0xd8a>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800dfd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e00:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e03:	eb 30                	jmp    800e35 <_main+0xdfd>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800e0f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800e12:	01 d0                	add    %edx,%eax
  800e14:	8b 00                	mov    (%eax),%eax
  800e16:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e19:	74 17                	je     800e32 <_main+0xdfa>
  800e1b:	83 ec 04             	sub    $0x4,%esp
  800e1e:	68 28 30 80 00       	push   $0x803028
  800e23:	68 37 01 00 00       	push   $0x137
  800e28:	68 14 2e 80 00       	push   $0x802e14
  800e2d:	e8 3e 04 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800e32:	ff 4d f4             	decl   -0xc(%ebp)
  800e35:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e38:	83 e8 64             	sub    $0x64,%eax
  800e3b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800e3e:	7c c5                	jl     800e05 <_main+0xdcd>
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}


		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  800e40:	e8 65 18 00 00       	call   8026aa <sys_calculate_free_frames>
  800e45:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e48:	e8 e0 18 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800e4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[9]);
  800e50:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800e53:	83 ec 0c             	sub    $0xc,%esp
  800e56:	50                   	push   %eax
  800e57:	e8 ad 15 00 00       	call   802409 <free>
  800e5c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 640) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 640) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  800e5f:	e8 c9 18 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800e64:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800e67:	29 c2                	sub    %eax,%edx
  800e69:	89 d0                	mov    %edx,%eax
  800e6b:	3d 80 02 00 00       	cmp    $0x280,%eax
  800e70:	74 17                	je     800e89 <_main+0xe51>
  800e72:	83 ec 04             	sub    $0x4,%esp
  800e75:	68 60 30 80 00       	push   $0x803060
  800e7a:	68 40 01 00 00       	push   $0x140
  800e7f:	68 14 2e 80 00       	push   $0x802e14
  800e84:	e8 e7 03 00 00       	call   801270 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 1) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b70%", NULL);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	6a 00                	push   $0x0
  800e8e:	68 bb 30 80 00       	push   $0x8030bb
  800e93:	e8 21 06 00 00       	call   8014b9 <vcprintf>
  800e98:	83 c4 10             	add    $0x10,%esp

		/*CASE3: Re-allocate that's not fit in the same location*/

		//Fill it with data
		intArr = (int*) ptr_allocations[0];
  800e9b:	8b 45 80             	mov    -0x80(%ebp),%eax
  800e9e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		lastIndexOfInt1 = (1*Mega)/sizeof(int) - 1;
  800ea1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea4:	c1 e8 02             	shr    $0x2,%eax
  800ea7:	48                   	dec    %eax
  800ea8:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		i = 0;
  800eab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800eb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800eb9:	eb 17                	jmp    800ed2 <_main+0xe9a>
		{
			intArr[i] = i ;
  800ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ebe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ec5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800ec8:	01 c2                	add    %eax,%edx
  800eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ecd:	89 02                	mov    %eax,(%edx)

		i = 0;

		//NEW
		//filling the first 100 elements
		for (i=0; i < 100 ; i++)
  800ecf:	ff 45 f4             	incl   -0xc(%ebp)
  800ed2:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  800ed6:	7e e3                	jle    800ebb <_main+0xe83>
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800ed8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800edb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ede:	eb 17                	jmp    800ef7 <_main+0xebf>
		{
			intArr[i] = i ;
  800ee0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ee3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800eea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800eed:	01 c2                	add    %eax,%edx
  800eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ef2:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i ;
		}

		//filling the last 100 elements
		for (i=lastIndexOfInt1; i > lastIndexOfInt1 - 100 ; i--)
  800ef4:	ff 4d f4             	decl   -0xc(%ebp)
  800ef7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800efa:	83 e8 64             	sub    $0x64,%eax
  800efd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f00:	7c de                	jl     800ee0 <_main+0xea8>
			intArr[i] = i ;
		}


		//Reallocate it to 4 MB [should be moved to last hole]
		freeFrames = sys_calculate_free_frames() ;
  800f02:	e8 a3 17 00 00       	call   8026aa <sys_calculate_free_frames>
  800f07:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f0a:	e8 1e 18 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800f0f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 1*Mega + 3*Mega - kilo);
  800f12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f15:	c1 e0 02             	shl    $0x2,%eax
  800f18:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800f1b:	89 c2                	mov    %eax,%edx
  800f1d:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f20:	83 ec 08             	sub    $0x8,%esp
  800f23:	52                   	push   %edx
  800f24:	50                   	push   %eax
  800f25:	e8 f7 15 00 00       	call   802521 <realloc>
  800f2a:	83 c4 10             	add    $0x10,%esp
  800f2d:	89 45 80             	mov    %eax,-0x80(%ebp)
		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the re-allocated space... ");
  800f30:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f33:	89 c1                	mov    %eax,%ecx
  800f35:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f38:	89 d0                	mov    %edx,%eax
  800f3a:	01 c0                	add    %eax,%eax
  800f3c:	01 d0                	add    %edx,%eax
  800f3e:	01 c0                	add    %eax,%eax
  800f40:	01 d0                	add    %edx,%eax
  800f42:	01 c0                	add    %eax,%eax
  800f44:	05 00 00 00 80       	add    $0x80000000,%eax
  800f49:	39 c1                	cmp    %eax,%ecx
  800f4b:	74 17                	je     800f64 <_main+0xf2c>
  800f4d:	83 ec 04             	sub    $0x4,%esp
  800f50:	68 50 2f 80 00       	push   $0x802f50
  800f55:	68 60 01 00 00       	push   $0x160
  800f5a:	68 14 2e 80 00       	push   $0x802e14
  800f5f:	e8 0c 03 00 00       	call   801270 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong re-allocation");
		//if((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768) panic("Extra or less pages are re-allocated in PageFile");
  800f64:	e8 c4 17 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  800f69:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800f6c:	3d 00 03 00 00       	cmp    $0x300,%eax
  800f71:	74 17                	je     800f8a <_main+0xf52>
  800f73:	83 ec 04             	sub    $0x4,%esp
  800f76:	68 f4 2f 80 00       	push   $0x802ff4
  800f7b:	68 63 01 00 00       	push   $0x163
  800f80:	68 14 2e 80 00       	push   $0x802e14
  800f85:	e8 e6 02 00 00       	call   801270 <_panic>

		//[2] test memory access
		lastIndexOfInt2 = (4*Mega)/sizeof(int) - 1;
  800f8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f8d:	c1 e0 02             	shl    $0x2,%eax
  800f90:	c1 e8 02             	shr    $0x2,%eax
  800f93:	48                   	dec    %eax
  800f94:	89 45 d0             	mov    %eax,-0x30(%ebp)
		intArr = (int*) ptr_allocations[0];
  800f97:	8b 45 80             	mov    -0x80(%ebp),%eax
  800f9a:	89 45 d8             	mov    %eax,-0x28(%ebp)

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800f9d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800fa0:	40                   	inc    %eax
  800fa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa4:	eb 17                	jmp    800fbd <_main+0xf85>
		{
			intArr[i] = i;
  800fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fa9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800fb3:	01 c2                	add    %eax,%edx
  800fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb8:	89 02                	mov    %eax,(%edx)
		lastIndexOfInt2 = (4*Mega)/sizeof(int) - 1;
		intArr = (int*) ptr_allocations[0];

		//NEW
		//filling the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  800fba:	ff 45 f4             	incl   -0xc(%ebp)
  800fbd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800fc0:	83 c0 65             	add    $0x65,%eax
  800fc3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fc6:	7f de                	jg     800fa6 <_main+0xf6e>
		{
			intArr[i] = i;
		}

		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800fc8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fce:	eb 17                	jmp    800fe7 <_main+0xfaf>
		{
			intArr[i] = i;
  800fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fda:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800fdd:	01 c2                	add    %eax,%edx
  800fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe2:	89 02                	mov    %eax,(%edx)
		{
			intArr[i] = i;
		}

		//filling the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  800fe4:	ff 4d f4             	decl   -0xc(%ebp)
  800fe7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fea:	83 e8 64             	sub    $0x64,%eax
  800fed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ff0:	7c de                	jl     800fd0 <_main+0xf98>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  800ff2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800ff9:	eb 30                	jmp    80102b <_main+0xff3>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  800ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801005:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801008:	01 d0                	add    %edx,%eax
  80100a:	8b 00                	mov    (%eax),%eax
  80100c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80100f:	74 17                	je     801028 <_main+0xff0>
  801011:	83 ec 04             	sub    $0x4,%esp
  801014:	68 28 30 80 00       	push   $0x803028
  801019:	68 79 01 00 00       	push   $0x179
  80101e:	68 14 2e 80 00       	push   $0x802e14
  801023:	e8 48 02 00 00       	call   801270 <_panic>
		{
			intArr[i] = i;
		}

		//checking the first 100 elements of the old range
		for(i = 0; i < 100; i++)
  801028:	ff 45 f4             	incl   -0xc(%ebp)
  80102b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  80102f:	7e ca                	jle    800ffb <_main+0xfc3>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801031:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801034:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801037:	eb 30                	jmp    801069 <_main+0x1031>
		{
			if (intArr[i] != i)
  801039:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80103c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801043:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801046:	01 d0                	add    %edx,%eax
  801048:	8b 00                	mov    (%eax),%eax
  80104a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80104d:	74 17                	je     801066 <_main+0x102e>
			{
				panic("Wrong re-allocation: stored values are wrongly changed!");
  80104f:	83 ec 04             	sub    $0x4,%esp
  801052:	68 28 30 80 00       	push   $0x803028
  801057:	68 81 01 00 00       	push   $0x181
  80105c:	68 14 2e 80 00       	push   $0x802e14
  801061:	e8 0a 02 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the old range
		for(i = lastIndexOfInt1; i > lastIndexOfInt1 - 100; i--)
  801066:	ff 4d f4             	decl   -0xc(%ebp)
  801069:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80106c:	83 e8 64             	sub    $0x64,%eax
  80106f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801072:	7c c5                	jl     801039 <_main+0x1001>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  801074:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801077:	40                   	inc    %eax
  801078:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80107b:	eb 30                	jmp    8010ad <_main+0x1075>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  80107d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801080:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801087:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80108a:	01 d0                	add    %edx,%eax
  80108c:	8b 00                	mov    (%eax),%eax
  80108e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801091:	74 17                	je     8010aa <_main+0x1072>
  801093:	83 ec 04             	sub    $0x4,%esp
  801096:	68 28 30 80 00       	push   $0x803028
  80109b:	68 88 01 00 00       	push   $0x188
  8010a0:	68 14 2e 80 00       	push   $0x802e14
  8010a5:	e8 c6 01 00 00       	call   801270 <_panic>
				panic("Wrong re-allocation: stored values are wrongly changed!");
			}
		}

		//checking the first 100 elements of the new range
		for(i = lastIndexOfInt1 + 1; i < lastIndexOfInt1 + 101; i++)
  8010aa:	ff 45 f4             	incl   -0xc(%ebp)
  8010ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8010b0:	83 c0 65             	add    $0x65,%eax
  8010b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010b6:	7f c5                	jg     80107d <_main+0x1045>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  8010b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8010bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010be:	eb 30                	jmp    8010f0 <_main+0x10b8>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
  8010c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ca:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8010cd:	01 d0                	add    %edx,%eax
  8010cf:	8b 00                	mov    (%eax),%eax
  8010d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010d4:	74 17                	je     8010ed <_main+0x10b5>
  8010d6:	83 ec 04             	sub    $0x4,%esp
  8010d9:	68 28 30 80 00       	push   $0x803028
  8010de:	68 8e 01 00 00       	push   $0x18e
  8010e3:	68 14 2e 80 00       	push   $0x802e14
  8010e8:	e8 83 01 00 00       	call   801270 <_panic>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//checking the last 100 elements of the new range
		for(i = lastIndexOfInt2; i > lastIndexOfInt2 - 100; i--)
  8010ed:	ff 4d f4             	decl   -0xc(%ebp)
  8010f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8010f3:	83 e8 64             	sub    $0x64,%eax
  8010f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010f9:	7c c5                	jl     8010c0 <_main+0x1088>
		{
			if (intArr[i] != i) panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//[3] test freeing it after expansion
		freeFrames = sys_calculate_free_frames() ;
  8010fb:	e8 aa 15 00 00       	call   8026aa <sys_calculate_free_frames>
  801100:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801103:	e8 25 16 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  801108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		free(ptr_allocations[0]);
  80110b:	8b 45 80             	mov    -0x80(%ebp),%eax
  80110e:	83 ec 0c             	sub    $0xc,%esp
  801111:	50                   	push   %eax
  801112:	e8 f2 12 00 00       	call   802409 <free>
  801117:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 1024+1) panic("Wrong free of the re-allocated space");
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1024) panic("Wrong free of the re-allocated space: Extra or less pages are removed from PageFile");
  80111a:	e8 0e 16 00 00       	call   80272d <sys_pf_calculate_allocated_pages>
  80111f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801122:	29 c2                	sub    %eax,%edx
  801124:	89 d0                	mov    %edx,%eax
  801126:	3d 00 04 00 00       	cmp    $0x400,%eax
  80112b:	74 17                	je     801144 <_main+0x110c>
  80112d:	83 ec 04             	sub    $0x4,%esp
  801130:	68 60 30 80 00       	push   $0x803060
  801135:	68 96 01 00 00       	push   $0x196
  80113a:	68 14 2e 80 00       	push   $0x802e14
  80113f:	e8 2c 01 00 00       	call   801270 <_panic>
		//if ((sys_calculate_free_frames() - freeFrames) != 4 + 2) panic("Wrong free of the re-allocated space: WS pages in memory and/or page tables are not freed correctly");

		vcprintf("\b\b\b100%\n", NULL);
  801144:	83 ec 08             	sub    $0x8,%esp
  801147:	6a 00                	push   $0x0
  801149:	68 c2 30 80 00       	push   $0x8030c2
  80114e:	e8 66 03 00 00       	call   8014b9 <vcprintf>
  801153:	83 c4 10             	add    $0x10,%esp
	}

	cprintf("Congratulations!! test realloc [1] completed successfully.\n");
  801156:	83 ec 0c             	sub    $0xc,%esp
  801159:	68 cc 30 80 00       	push   $0x8030cc
  80115e:	e8 c1 03 00 00       	call   801524 <cprintf>
  801163:	83 c4 10             	add    $0x10,%esp

	return;
  801166:	90                   	nop
}
  801167:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80116a:	5b                   	pop    %ebx
  80116b:	5f                   	pop    %edi
  80116c:	5d                   	pop    %ebp
  80116d:	c3                   	ret    

0080116e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
  801171:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801174:	e8 66 14 00 00       	call   8025df <sys_getenvindex>
  801179:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80117c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80117f:	89 d0                	mov    %edx,%eax
  801181:	01 c0                	add    %eax,%eax
  801183:	01 d0                	add    %edx,%eax
  801185:	c1 e0 02             	shl    $0x2,%eax
  801188:	01 d0                	add    %edx,%eax
  80118a:	c1 e0 06             	shl    $0x6,%eax
  80118d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  801192:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801197:	a1 20 40 80 00       	mov    0x804020,%eax
  80119c:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  8011a2:	84 c0                	test   %al,%al
  8011a4:	74 0f                	je     8011b5 <libmain+0x47>
		binaryname = myEnv->prog_name;
  8011a6:	a1 20 40 80 00       	mov    0x804020,%eax
  8011ab:	05 f4 02 00 00       	add    $0x2f4,%eax
  8011b0:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8011b5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b9:	7e 0a                	jle    8011c5 <libmain+0x57>
		binaryname = argv[0];
  8011bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011be:	8b 00                	mov    (%eax),%eax
  8011c0:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8011c5:	83 ec 08             	sub    $0x8,%esp
  8011c8:	ff 75 0c             	pushl  0xc(%ebp)
  8011cb:	ff 75 08             	pushl  0x8(%ebp)
  8011ce:	e8 65 ee ff ff       	call   800038 <_main>
  8011d3:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8011d6:	e8 9f 15 00 00       	call   80277a <sys_disable_interrupt>
	cprintf("**************************************\n");
  8011db:	83 ec 0c             	sub    $0xc,%esp
  8011de:	68 20 31 80 00       	push   $0x803120
  8011e3:	e8 3c 03 00 00       	call   801524 <cprintf>
  8011e8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8011eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8011f0:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8011f6:	a1 20 40 80 00       	mov    0x804020,%eax
  8011fb:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  801201:	83 ec 04             	sub    $0x4,%esp
  801204:	52                   	push   %edx
  801205:	50                   	push   %eax
  801206:	68 48 31 80 00       	push   $0x803148
  80120b:	e8 14 03 00 00       	call   801524 <cprintf>
  801210:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801213:	a1 20 40 80 00       	mov    0x804020,%eax
  801218:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80121e:	83 ec 08             	sub    $0x8,%esp
  801221:	50                   	push   %eax
  801222:	68 6d 31 80 00       	push   $0x80316d
  801227:	e8 f8 02 00 00       	call   801524 <cprintf>
  80122c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80122f:	83 ec 0c             	sub    $0xc,%esp
  801232:	68 20 31 80 00       	push   $0x803120
  801237:	e8 e8 02 00 00       	call   801524 <cprintf>
  80123c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80123f:	e8 50 15 00 00       	call   802794 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801244:	e8 19 00 00 00       	call   801262 <exit>
}
  801249:	90                   	nop
  80124a:	c9                   	leave  
  80124b:	c3                   	ret    

0080124c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80124c:	55                   	push   %ebp
  80124d:	89 e5                	mov    %esp,%ebp
  80124f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801252:	83 ec 0c             	sub    $0xc,%esp
  801255:	6a 00                	push   $0x0
  801257:	e8 4f 13 00 00       	call   8025ab <sys_env_destroy>
  80125c:	83 c4 10             	add    $0x10,%esp
}
  80125f:	90                   	nop
  801260:	c9                   	leave  
  801261:	c3                   	ret    

00801262 <exit>:

void
exit(void)
{
  801262:	55                   	push   %ebp
  801263:	89 e5                	mov    %esp,%ebp
  801265:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801268:	e8 a4 13 00 00       	call   802611 <sys_env_exit>
}
  80126d:	90                   	nop
  80126e:	c9                   	leave  
  80126f:	c3                   	ret    

00801270 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801270:	55                   	push   %ebp
  801271:	89 e5                	mov    %esp,%ebp
  801273:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801276:	8d 45 10             	lea    0x10(%ebp),%eax
  801279:	83 c0 04             	add    $0x4,%eax
  80127c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80127f:	a1 30 40 80 00       	mov    0x804030,%eax
  801284:	85 c0                	test   %eax,%eax
  801286:	74 16                	je     80129e <_panic+0x2e>
		cprintf("%s: ", argv0);
  801288:	a1 30 40 80 00       	mov    0x804030,%eax
  80128d:	83 ec 08             	sub    $0x8,%esp
  801290:	50                   	push   %eax
  801291:	68 84 31 80 00       	push   $0x803184
  801296:	e8 89 02 00 00       	call   801524 <cprintf>
  80129b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80129e:	a1 00 40 80 00       	mov    0x804000,%eax
  8012a3:	ff 75 0c             	pushl  0xc(%ebp)
  8012a6:	ff 75 08             	pushl  0x8(%ebp)
  8012a9:	50                   	push   %eax
  8012aa:	68 89 31 80 00       	push   $0x803189
  8012af:	e8 70 02 00 00       	call   801524 <cprintf>
  8012b4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8012b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ba:	83 ec 08             	sub    $0x8,%esp
  8012bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8012c0:	50                   	push   %eax
  8012c1:	e8 f3 01 00 00       	call   8014b9 <vcprintf>
  8012c6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8012c9:	83 ec 08             	sub    $0x8,%esp
  8012cc:	6a 00                	push   $0x0
  8012ce:	68 a5 31 80 00       	push   $0x8031a5
  8012d3:	e8 e1 01 00 00       	call   8014b9 <vcprintf>
  8012d8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8012db:	e8 82 ff ff ff       	call   801262 <exit>

	// should not return here
	while (1) ;
  8012e0:	eb fe                	jmp    8012e0 <_panic+0x70>

008012e2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
  8012e5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8012e8:	a1 20 40 80 00       	mov    0x804020,%eax
  8012ed:	8b 50 74             	mov    0x74(%eax),%edx
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	39 c2                	cmp    %eax,%edx
  8012f5:	74 14                	je     80130b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8012f7:	83 ec 04             	sub    $0x4,%esp
  8012fa:	68 a8 31 80 00       	push   $0x8031a8
  8012ff:	6a 26                	push   $0x26
  801301:	68 f4 31 80 00       	push   $0x8031f4
  801306:	e8 65 ff ff ff       	call   801270 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80130b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801312:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801319:	e9 c2 00 00 00       	jmp    8013e0 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80131e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801321:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
  80132b:	01 d0                	add    %edx,%eax
  80132d:	8b 00                	mov    (%eax),%eax
  80132f:	85 c0                	test   %eax,%eax
  801331:	75 08                	jne    80133b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801333:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801336:	e9 a2 00 00 00       	jmp    8013dd <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80133b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801342:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801349:	eb 69                	jmp    8013b4 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80134b:	a1 20 40 80 00       	mov    0x804020,%eax
  801350:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801356:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801359:	89 d0                	mov    %edx,%eax
  80135b:	01 c0                	add    %eax,%eax
  80135d:	01 d0                	add    %edx,%eax
  80135f:	c1 e0 02             	shl    $0x2,%eax
  801362:	01 c8                	add    %ecx,%eax
  801364:	8a 40 04             	mov    0x4(%eax),%al
  801367:	84 c0                	test   %al,%al
  801369:	75 46                	jne    8013b1 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80136b:	a1 20 40 80 00       	mov    0x804020,%eax
  801370:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801376:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801379:	89 d0                	mov    %edx,%eax
  80137b:	01 c0                	add    %eax,%eax
  80137d:	01 d0                	add    %edx,%eax
  80137f:	c1 e0 02             	shl    $0x2,%eax
  801382:	01 c8                	add    %ecx,%eax
  801384:	8b 00                	mov    (%eax),%eax
  801386:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801389:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80138c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801391:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801396:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	01 c8                	add    %ecx,%eax
  8013a2:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8013a4:	39 c2                	cmp    %eax,%edx
  8013a6:	75 09                	jne    8013b1 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8013a8:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8013af:	eb 12                	jmp    8013c3 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8013b1:	ff 45 e8             	incl   -0x18(%ebp)
  8013b4:	a1 20 40 80 00       	mov    0x804020,%eax
  8013b9:	8b 50 74             	mov    0x74(%eax),%edx
  8013bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013bf:	39 c2                	cmp    %eax,%edx
  8013c1:	77 88                	ja     80134b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8013c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013c7:	75 14                	jne    8013dd <CheckWSWithoutLastIndex+0xfb>
			panic(
  8013c9:	83 ec 04             	sub    $0x4,%esp
  8013cc:	68 00 32 80 00       	push   $0x803200
  8013d1:	6a 3a                	push   $0x3a
  8013d3:	68 f4 31 80 00       	push   $0x8031f4
  8013d8:	e8 93 fe ff ff       	call   801270 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8013dd:	ff 45 f0             	incl   -0x10(%ebp)
  8013e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8013e6:	0f 8c 32 ff ff ff    	jl     80131e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8013ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8013f3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8013fa:	eb 26                	jmp    801422 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8013fc:	a1 20 40 80 00       	mov    0x804020,%eax
  801401:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801407:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80140a:	89 d0                	mov    %edx,%eax
  80140c:	01 c0                	add    %eax,%eax
  80140e:	01 d0                	add    %edx,%eax
  801410:	c1 e0 02             	shl    $0x2,%eax
  801413:	01 c8                	add    %ecx,%eax
  801415:	8a 40 04             	mov    0x4(%eax),%al
  801418:	3c 01                	cmp    $0x1,%al
  80141a:	75 03                	jne    80141f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80141c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80141f:	ff 45 e0             	incl   -0x20(%ebp)
  801422:	a1 20 40 80 00       	mov    0x804020,%eax
  801427:	8b 50 74             	mov    0x74(%eax),%edx
  80142a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80142d:	39 c2                	cmp    %eax,%edx
  80142f:	77 cb                	ja     8013fc <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801431:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801434:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801437:	74 14                	je     80144d <CheckWSWithoutLastIndex+0x16b>
		panic(
  801439:	83 ec 04             	sub    $0x4,%esp
  80143c:	68 54 32 80 00       	push   $0x803254
  801441:	6a 44                	push   $0x44
  801443:	68 f4 31 80 00       	push   $0x8031f4
  801448:	e8 23 fe ff ff       	call   801270 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80144d:	90                   	nop
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
  801453:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801456:	8b 45 0c             	mov    0xc(%ebp),%eax
  801459:	8b 00                	mov    (%eax),%eax
  80145b:	8d 48 01             	lea    0x1(%eax),%ecx
  80145e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801461:	89 0a                	mov    %ecx,(%edx)
  801463:	8b 55 08             	mov    0x8(%ebp),%edx
  801466:	88 d1                	mov    %dl,%cl
  801468:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80146f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801472:	8b 00                	mov    (%eax),%eax
  801474:	3d ff 00 00 00       	cmp    $0xff,%eax
  801479:	75 2c                	jne    8014a7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80147b:	a0 24 40 80 00       	mov    0x804024,%al
  801480:	0f b6 c0             	movzbl %al,%eax
  801483:	8b 55 0c             	mov    0xc(%ebp),%edx
  801486:	8b 12                	mov    (%edx),%edx
  801488:	89 d1                	mov    %edx,%ecx
  80148a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80148d:	83 c2 08             	add    $0x8,%edx
  801490:	83 ec 04             	sub    $0x4,%esp
  801493:	50                   	push   %eax
  801494:	51                   	push   %ecx
  801495:	52                   	push   %edx
  801496:	e8 ce 10 00 00       	call   802569 <sys_cputs>
  80149b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80149e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8014a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014aa:	8b 40 04             	mov    0x4(%eax),%eax
  8014ad:	8d 50 01             	lea    0x1(%eax),%edx
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8014b6:	90                   	nop
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
  8014bc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8014c2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8014c9:	00 00 00 
	b.cnt = 0;
  8014cc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8014d3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8014d6:	ff 75 0c             	pushl  0xc(%ebp)
  8014d9:	ff 75 08             	pushl  0x8(%ebp)
  8014dc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8014e2:	50                   	push   %eax
  8014e3:	68 50 14 80 00       	push   $0x801450
  8014e8:	e8 11 02 00 00       	call   8016fe <vprintfmt>
  8014ed:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8014f0:	a0 24 40 80 00       	mov    0x804024,%al
  8014f5:	0f b6 c0             	movzbl %al,%eax
  8014f8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8014fe:	83 ec 04             	sub    $0x4,%esp
  801501:	50                   	push   %eax
  801502:	52                   	push   %edx
  801503:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801509:	83 c0 08             	add    $0x8,%eax
  80150c:	50                   	push   %eax
  80150d:	e8 57 10 00 00       	call   802569 <sys_cputs>
  801512:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801515:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  80151c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <cprintf>:

int cprintf(const char *fmt, ...) {
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
  801527:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80152a:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801531:	8d 45 0c             	lea    0xc(%ebp),%eax
  801534:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801537:	8b 45 08             	mov    0x8(%ebp),%eax
  80153a:	83 ec 08             	sub    $0x8,%esp
  80153d:	ff 75 f4             	pushl  -0xc(%ebp)
  801540:	50                   	push   %eax
  801541:	e8 73 ff ff ff       	call   8014b9 <vcprintf>
  801546:	83 c4 10             	add    $0x10,%esp
  801549:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80154c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80154f:	c9                   	leave  
  801550:	c3                   	ret    

00801551 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
  801554:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801557:	e8 1e 12 00 00       	call   80277a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80155c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80155f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	83 ec 08             	sub    $0x8,%esp
  801568:	ff 75 f4             	pushl  -0xc(%ebp)
  80156b:	50                   	push   %eax
  80156c:	e8 48 ff ff ff       	call   8014b9 <vcprintf>
  801571:	83 c4 10             	add    $0x10,%esp
  801574:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801577:	e8 18 12 00 00       	call   802794 <sys_enable_interrupt>
	return cnt;
  80157c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	53                   	push   %ebx
  801585:	83 ec 14             	sub    $0x14,%esp
  801588:	8b 45 10             	mov    0x10(%ebp),%eax
  80158b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80158e:	8b 45 14             	mov    0x14(%ebp),%eax
  801591:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801594:	8b 45 18             	mov    0x18(%ebp),%eax
  801597:	ba 00 00 00 00       	mov    $0x0,%edx
  80159c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80159f:	77 55                	ja     8015f6 <printnum+0x75>
  8015a1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8015a4:	72 05                	jb     8015ab <printnum+0x2a>
  8015a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015a9:	77 4b                	ja     8015f6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8015ab:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8015ae:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8015b1:	8b 45 18             	mov    0x18(%ebp),%eax
  8015b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8015b9:	52                   	push   %edx
  8015ba:	50                   	push   %eax
  8015bb:	ff 75 f4             	pushl  -0xc(%ebp)
  8015be:	ff 75 f0             	pushl  -0x10(%ebp)
  8015c1:	e8 92 15 00 00       	call   802b58 <__udivdi3>
  8015c6:	83 c4 10             	add    $0x10,%esp
  8015c9:	83 ec 04             	sub    $0x4,%esp
  8015cc:	ff 75 20             	pushl  0x20(%ebp)
  8015cf:	53                   	push   %ebx
  8015d0:	ff 75 18             	pushl  0x18(%ebp)
  8015d3:	52                   	push   %edx
  8015d4:	50                   	push   %eax
  8015d5:	ff 75 0c             	pushl  0xc(%ebp)
  8015d8:	ff 75 08             	pushl  0x8(%ebp)
  8015db:	e8 a1 ff ff ff       	call   801581 <printnum>
  8015e0:	83 c4 20             	add    $0x20,%esp
  8015e3:	eb 1a                	jmp    8015ff <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8015e5:	83 ec 08             	sub    $0x8,%esp
  8015e8:	ff 75 0c             	pushl  0xc(%ebp)
  8015eb:	ff 75 20             	pushl  0x20(%ebp)
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	ff d0                	call   *%eax
  8015f3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8015f6:	ff 4d 1c             	decl   0x1c(%ebp)
  8015f9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8015fd:	7f e6                	jg     8015e5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8015ff:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801602:	bb 00 00 00 00       	mov    $0x0,%ebx
  801607:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80160a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80160d:	53                   	push   %ebx
  80160e:	51                   	push   %ecx
  80160f:	52                   	push   %edx
  801610:	50                   	push   %eax
  801611:	e8 52 16 00 00       	call   802c68 <__umoddi3>
  801616:	83 c4 10             	add    $0x10,%esp
  801619:	05 b4 34 80 00       	add    $0x8034b4,%eax
  80161e:	8a 00                	mov    (%eax),%al
  801620:	0f be c0             	movsbl %al,%eax
  801623:	83 ec 08             	sub    $0x8,%esp
  801626:	ff 75 0c             	pushl  0xc(%ebp)
  801629:	50                   	push   %eax
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	ff d0                	call   *%eax
  80162f:	83 c4 10             	add    $0x10,%esp
}
  801632:	90                   	nop
  801633:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80163b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80163f:	7e 1c                	jle    80165d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8b 00                	mov    (%eax),%eax
  801646:	8d 50 08             	lea    0x8(%eax),%edx
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
  80164c:	89 10                	mov    %edx,(%eax)
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8b 00                	mov    (%eax),%eax
  801653:	83 e8 08             	sub    $0x8,%eax
  801656:	8b 50 04             	mov    0x4(%eax),%edx
  801659:	8b 00                	mov    (%eax),%eax
  80165b:	eb 40                	jmp    80169d <getuint+0x65>
	else if (lflag)
  80165d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801661:	74 1e                	je     801681 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8b 00                	mov    (%eax),%eax
  801668:	8d 50 04             	lea    0x4(%eax),%edx
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	89 10                	mov    %edx,(%eax)
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8b 00                	mov    (%eax),%eax
  801675:	83 e8 04             	sub    $0x4,%eax
  801678:	8b 00                	mov    (%eax),%eax
  80167a:	ba 00 00 00 00       	mov    $0x0,%edx
  80167f:	eb 1c                	jmp    80169d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801681:	8b 45 08             	mov    0x8(%ebp),%eax
  801684:	8b 00                	mov    (%eax),%eax
  801686:	8d 50 04             	lea    0x4(%eax),%edx
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	89 10                	mov    %edx,(%eax)
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8b 00                	mov    (%eax),%eax
  801693:	83 e8 04             	sub    $0x4,%eax
  801696:	8b 00                	mov    (%eax),%eax
  801698:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80169d:	5d                   	pop    %ebp
  80169e:	c3                   	ret    

0080169f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8016a2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8016a6:	7e 1c                	jle    8016c4 <getint+0x25>
		return va_arg(*ap, long long);
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8b 00                	mov    (%eax),%eax
  8016ad:	8d 50 08             	lea    0x8(%eax),%edx
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	89 10                	mov    %edx,(%eax)
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8b 00                	mov    (%eax),%eax
  8016ba:	83 e8 08             	sub    $0x8,%eax
  8016bd:	8b 50 04             	mov    0x4(%eax),%edx
  8016c0:	8b 00                	mov    (%eax),%eax
  8016c2:	eb 38                	jmp    8016fc <getint+0x5d>
	else if (lflag)
  8016c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016c8:	74 1a                	je     8016e4 <getint+0x45>
		return va_arg(*ap, long);
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	8b 00                	mov    (%eax),%eax
  8016cf:	8d 50 04             	lea    0x4(%eax),%edx
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d5:	89 10                	mov    %edx,(%eax)
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8b 00                	mov    (%eax),%eax
  8016dc:	83 e8 04             	sub    $0x4,%eax
  8016df:	8b 00                	mov    (%eax),%eax
  8016e1:	99                   	cltd   
  8016e2:	eb 18                	jmp    8016fc <getint+0x5d>
	else
		return va_arg(*ap, int);
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	8b 00                	mov    (%eax),%eax
  8016e9:	8d 50 04             	lea    0x4(%eax),%edx
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	89 10                	mov    %edx,(%eax)
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8b 00                	mov    (%eax),%eax
  8016f6:	83 e8 04             	sub    $0x4,%eax
  8016f9:	8b 00                	mov    (%eax),%eax
  8016fb:	99                   	cltd   
}
  8016fc:	5d                   	pop    %ebp
  8016fd:	c3                   	ret    

008016fe <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
  801701:	56                   	push   %esi
  801702:	53                   	push   %ebx
  801703:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801706:	eb 17                	jmp    80171f <vprintfmt+0x21>
			if (ch == '\0')
  801708:	85 db                	test   %ebx,%ebx
  80170a:	0f 84 af 03 00 00    	je     801abf <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801710:	83 ec 08             	sub    $0x8,%esp
  801713:	ff 75 0c             	pushl  0xc(%ebp)
  801716:	53                   	push   %ebx
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	ff d0                	call   *%eax
  80171c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80171f:	8b 45 10             	mov    0x10(%ebp),%eax
  801722:	8d 50 01             	lea    0x1(%eax),%edx
  801725:	89 55 10             	mov    %edx,0x10(%ebp)
  801728:	8a 00                	mov    (%eax),%al
  80172a:	0f b6 d8             	movzbl %al,%ebx
  80172d:	83 fb 25             	cmp    $0x25,%ebx
  801730:	75 d6                	jne    801708 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801732:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801736:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80173d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801744:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80174b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801752:	8b 45 10             	mov    0x10(%ebp),%eax
  801755:	8d 50 01             	lea    0x1(%eax),%edx
  801758:	89 55 10             	mov    %edx,0x10(%ebp)
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	0f b6 d8             	movzbl %al,%ebx
  801760:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801763:	83 f8 55             	cmp    $0x55,%eax
  801766:	0f 87 2b 03 00 00    	ja     801a97 <vprintfmt+0x399>
  80176c:	8b 04 85 d8 34 80 00 	mov    0x8034d8(,%eax,4),%eax
  801773:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801775:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801779:	eb d7                	jmp    801752 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80177b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80177f:	eb d1                	jmp    801752 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801781:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801788:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80178b:	89 d0                	mov    %edx,%eax
  80178d:	c1 e0 02             	shl    $0x2,%eax
  801790:	01 d0                	add    %edx,%eax
  801792:	01 c0                	add    %eax,%eax
  801794:	01 d8                	add    %ebx,%eax
  801796:	83 e8 30             	sub    $0x30,%eax
  801799:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80179c:	8b 45 10             	mov    0x10(%ebp),%eax
  80179f:	8a 00                	mov    (%eax),%al
  8017a1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8017a4:	83 fb 2f             	cmp    $0x2f,%ebx
  8017a7:	7e 3e                	jle    8017e7 <vprintfmt+0xe9>
  8017a9:	83 fb 39             	cmp    $0x39,%ebx
  8017ac:	7f 39                	jg     8017e7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8017ae:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8017b1:	eb d5                	jmp    801788 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8017b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8017b6:	83 c0 04             	add    $0x4,%eax
  8017b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8017bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8017bf:	83 e8 04             	sub    $0x4,%eax
  8017c2:	8b 00                	mov    (%eax),%eax
  8017c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8017c7:	eb 1f                	jmp    8017e8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8017c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8017cd:	79 83                	jns    801752 <vprintfmt+0x54>
				width = 0;
  8017cf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8017d6:	e9 77 ff ff ff       	jmp    801752 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8017db:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8017e2:	e9 6b ff ff ff       	jmp    801752 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8017e7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8017e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8017ec:	0f 89 60 ff ff ff    	jns    801752 <vprintfmt+0x54>
				width = precision, precision = -1;
  8017f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8017f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8017f8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8017ff:	e9 4e ff ff ff       	jmp    801752 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801804:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801807:	e9 46 ff ff ff       	jmp    801752 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80180c:	8b 45 14             	mov    0x14(%ebp),%eax
  80180f:	83 c0 04             	add    $0x4,%eax
  801812:	89 45 14             	mov    %eax,0x14(%ebp)
  801815:	8b 45 14             	mov    0x14(%ebp),%eax
  801818:	83 e8 04             	sub    $0x4,%eax
  80181b:	8b 00                	mov    (%eax),%eax
  80181d:	83 ec 08             	sub    $0x8,%esp
  801820:	ff 75 0c             	pushl  0xc(%ebp)
  801823:	50                   	push   %eax
  801824:	8b 45 08             	mov    0x8(%ebp),%eax
  801827:	ff d0                	call   *%eax
  801829:	83 c4 10             	add    $0x10,%esp
			break;
  80182c:	e9 89 02 00 00       	jmp    801aba <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801831:	8b 45 14             	mov    0x14(%ebp),%eax
  801834:	83 c0 04             	add    $0x4,%eax
  801837:	89 45 14             	mov    %eax,0x14(%ebp)
  80183a:	8b 45 14             	mov    0x14(%ebp),%eax
  80183d:	83 e8 04             	sub    $0x4,%eax
  801840:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801842:	85 db                	test   %ebx,%ebx
  801844:	79 02                	jns    801848 <vprintfmt+0x14a>
				err = -err;
  801846:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801848:	83 fb 64             	cmp    $0x64,%ebx
  80184b:	7f 0b                	jg     801858 <vprintfmt+0x15a>
  80184d:	8b 34 9d 20 33 80 00 	mov    0x803320(,%ebx,4),%esi
  801854:	85 f6                	test   %esi,%esi
  801856:	75 19                	jne    801871 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801858:	53                   	push   %ebx
  801859:	68 c5 34 80 00       	push   $0x8034c5
  80185e:	ff 75 0c             	pushl  0xc(%ebp)
  801861:	ff 75 08             	pushl  0x8(%ebp)
  801864:	e8 5e 02 00 00       	call   801ac7 <printfmt>
  801869:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80186c:	e9 49 02 00 00       	jmp    801aba <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801871:	56                   	push   %esi
  801872:	68 ce 34 80 00       	push   $0x8034ce
  801877:	ff 75 0c             	pushl  0xc(%ebp)
  80187a:	ff 75 08             	pushl  0x8(%ebp)
  80187d:	e8 45 02 00 00       	call   801ac7 <printfmt>
  801882:	83 c4 10             	add    $0x10,%esp
			break;
  801885:	e9 30 02 00 00       	jmp    801aba <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80188a:	8b 45 14             	mov    0x14(%ebp),%eax
  80188d:	83 c0 04             	add    $0x4,%eax
  801890:	89 45 14             	mov    %eax,0x14(%ebp)
  801893:	8b 45 14             	mov    0x14(%ebp),%eax
  801896:	83 e8 04             	sub    $0x4,%eax
  801899:	8b 30                	mov    (%eax),%esi
  80189b:	85 f6                	test   %esi,%esi
  80189d:	75 05                	jne    8018a4 <vprintfmt+0x1a6>
				p = "(null)";
  80189f:	be d1 34 80 00       	mov    $0x8034d1,%esi
			if (width > 0 && padc != '-')
  8018a4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8018a8:	7e 6d                	jle    801917 <vprintfmt+0x219>
  8018aa:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8018ae:	74 67                	je     801917 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8018b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018b3:	83 ec 08             	sub    $0x8,%esp
  8018b6:	50                   	push   %eax
  8018b7:	56                   	push   %esi
  8018b8:	e8 0c 03 00 00       	call   801bc9 <strnlen>
  8018bd:	83 c4 10             	add    $0x10,%esp
  8018c0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8018c3:	eb 16                	jmp    8018db <vprintfmt+0x1dd>
					putch(padc, putdat);
  8018c5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8018c9:	83 ec 08             	sub    $0x8,%esp
  8018cc:	ff 75 0c             	pushl  0xc(%ebp)
  8018cf:	50                   	push   %eax
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	ff d0                	call   *%eax
  8018d5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8018d8:	ff 4d e4             	decl   -0x1c(%ebp)
  8018db:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8018df:	7f e4                	jg     8018c5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8018e1:	eb 34                	jmp    801917 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8018e3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8018e7:	74 1c                	je     801905 <vprintfmt+0x207>
  8018e9:	83 fb 1f             	cmp    $0x1f,%ebx
  8018ec:	7e 05                	jle    8018f3 <vprintfmt+0x1f5>
  8018ee:	83 fb 7e             	cmp    $0x7e,%ebx
  8018f1:	7e 12                	jle    801905 <vprintfmt+0x207>
					putch('?', putdat);
  8018f3:	83 ec 08             	sub    $0x8,%esp
  8018f6:	ff 75 0c             	pushl  0xc(%ebp)
  8018f9:	6a 3f                	push   $0x3f
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	ff d0                	call   *%eax
  801900:	83 c4 10             	add    $0x10,%esp
  801903:	eb 0f                	jmp    801914 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801905:	83 ec 08             	sub    $0x8,%esp
  801908:	ff 75 0c             	pushl  0xc(%ebp)
  80190b:	53                   	push   %ebx
  80190c:	8b 45 08             	mov    0x8(%ebp),%eax
  80190f:	ff d0                	call   *%eax
  801911:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801914:	ff 4d e4             	decl   -0x1c(%ebp)
  801917:	89 f0                	mov    %esi,%eax
  801919:	8d 70 01             	lea    0x1(%eax),%esi
  80191c:	8a 00                	mov    (%eax),%al
  80191e:	0f be d8             	movsbl %al,%ebx
  801921:	85 db                	test   %ebx,%ebx
  801923:	74 24                	je     801949 <vprintfmt+0x24b>
  801925:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801929:	78 b8                	js     8018e3 <vprintfmt+0x1e5>
  80192b:	ff 4d e0             	decl   -0x20(%ebp)
  80192e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801932:	79 af                	jns    8018e3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801934:	eb 13                	jmp    801949 <vprintfmt+0x24b>
				putch(' ', putdat);
  801936:	83 ec 08             	sub    $0x8,%esp
  801939:	ff 75 0c             	pushl  0xc(%ebp)
  80193c:	6a 20                	push   $0x20
  80193e:	8b 45 08             	mov    0x8(%ebp),%eax
  801941:	ff d0                	call   *%eax
  801943:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801946:	ff 4d e4             	decl   -0x1c(%ebp)
  801949:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80194d:	7f e7                	jg     801936 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80194f:	e9 66 01 00 00       	jmp    801aba <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801954:	83 ec 08             	sub    $0x8,%esp
  801957:	ff 75 e8             	pushl  -0x18(%ebp)
  80195a:	8d 45 14             	lea    0x14(%ebp),%eax
  80195d:	50                   	push   %eax
  80195e:	e8 3c fd ff ff       	call   80169f <getint>
  801963:	83 c4 10             	add    $0x10,%esp
  801966:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801969:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80196c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80196f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801972:	85 d2                	test   %edx,%edx
  801974:	79 23                	jns    801999 <vprintfmt+0x29b>
				putch('-', putdat);
  801976:	83 ec 08             	sub    $0x8,%esp
  801979:	ff 75 0c             	pushl  0xc(%ebp)
  80197c:	6a 2d                	push   $0x2d
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	ff d0                	call   *%eax
  801983:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801986:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801989:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80198c:	f7 d8                	neg    %eax
  80198e:	83 d2 00             	adc    $0x0,%edx
  801991:	f7 da                	neg    %edx
  801993:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801996:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801999:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8019a0:	e9 bc 00 00 00       	jmp    801a61 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8019a5:	83 ec 08             	sub    $0x8,%esp
  8019a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8019ab:	8d 45 14             	lea    0x14(%ebp),%eax
  8019ae:	50                   	push   %eax
  8019af:	e8 84 fc ff ff       	call   801638 <getuint>
  8019b4:	83 c4 10             	add    $0x10,%esp
  8019b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8019ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8019bd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8019c4:	e9 98 00 00 00       	jmp    801a61 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8019c9:	83 ec 08             	sub    $0x8,%esp
  8019cc:	ff 75 0c             	pushl  0xc(%ebp)
  8019cf:	6a 58                	push   $0x58
  8019d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d4:	ff d0                	call   *%eax
  8019d6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8019d9:	83 ec 08             	sub    $0x8,%esp
  8019dc:	ff 75 0c             	pushl  0xc(%ebp)
  8019df:	6a 58                	push   $0x58
  8019e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e4:	ff d0                	call   *%eax
  8019e6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8019e9:	83 ec 08             	sub    $0x8,%esp
  8019ec:	ff 75 0c             	pushl  0xc(%ebp)
  8019ef:	6a 58                	push   $0x58
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	ff d0                	call   *%eax
  8019f6:	83 c4 10             	add    $0x10,%esp
			break;
  8019f9:	e9 bc 00 00 00       	jmp    801aba <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8019fe:	83 ec 08             	sub    $0x8,%esp
  801a01:	ff 75 0c             	pushl  0xc(%ebp)
  801a04:	6a 30                	push   $0x30
  801a06:	8b 45 08             	mov    0x8(%ebp),%eax
  801a09:	ff d0                	call   *%eax
  801a0b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801a0e:	83 ec 08             	sub    $0x8,%esp
  801a11:	ff 75 0c             	pushl  0xc(%ebp)
  801a14:	6a 78                	push   $0x78
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	ff d0                	call   *%eax
  801a1b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801a1e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a21:	83 c0 04             	add    $0x4,%eax
  801a24:	89 45 14             	mov    %eax,0x14(%ebp)
  801a27:	8b 45 14             	mov    0x14(%ebp),%eax
  801a2a:	83 e8 04             	sub    $0x4,%eax
  801a2d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801a2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801a39:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801a40:	eb 1f                	jmp    801a61 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801a42:	83 ec 08             	sub    $0x8,%esp
  801a45:	ff 75 e8             	pushl  -0x18(%ebp)
  801a48:	8d 45 14             	lea    0x14(%ebp),%eax
  801a4b:	50                   	push   %eax
  801a4c:	e8 e7 fb ff ff       	call   801638 <getuint>
  801a51:	83 c4 10             	add    $0x10,%esp
  801a54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a57:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801a5a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801a61:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801a65:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a68:	83 ec 04             	sub    $0x4,%esp
  801a6b:	52                   	push   %edx
  801a6c:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a6f:	50                   	push   %eax
  801a70:	ff 75 f4             	pushl  -0xc(%ebp)
  801a73:	ff 75 f0             	pushl  -0x10(%ebp)
  801a76:	ff 75 0c             	pushl  0xc(%ebp)
  801a79:	ff 75 08             	pushl  0x8(%ebp)
  801a7c:	e8 00 fb ff ff       	call   801581 <printnum>
  801a81:	83 c4 20             	add    $0x20,%esp
			break;
  801a84:	eb 34                	jmp    801aba <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801a86:	83 ec 08             	sub    $0x8,%esp
  801a89:	ff 75 0c             	pushl  0xc(%ebp)
  801a8c:	53                   	push   %ebx
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	ff d0                	call   *%eax
  801a92:	83 c4 10             	add    $0x10,%esp
			break;
  801a95:	eb 23                	jmp    801aba <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801a97:	83 ec 08             	sub    $0x8,%esp
  801a9a:	ff 75 0c             	pushl  0xc(%ebp)
  801a9d:	6a 25                	push   $0x25
  801a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa2:	ff d0                	call   *%eax
  801aa4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801aa7:	ff 4d 10             	decl   0x10(%ebp)
  801aaa:	eb 03                	jmp    801aaf <vprintfmt+0x3b1>
  801aac:	ff 4d 10             	decl   0x10(%ebp)
  801aaf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab2:	48                   	dec    %eax
  801ab3:	8a 00                	mov    (%eax),%al
  801ab5:	3c 25                	cmp    $0x25,%al
  801ab7:	75 f3                	jne    801aac <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801ab9:	90                   	nop
		}
	}
  801aba:	e9 47 fc ff ff       	jmp    801706 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801abf:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801ac0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ac3:	5b                   	pop    %ebx
  801ac4:	5e                   	pop    %esi
  801ac5:	5d                   	pop    %ebp
  801ac6:	c3                   	ret    

00801ac7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
  801aca:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801acd:	8d 45 10             	lea    0x10(%ebp),%eax
  801ad0:	83 c0 04             	add    $0x4,%eax
  801ad3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801ad6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad9:	ff 75 f4             	pushl  -0xc(%ebp)
  801adc:	50                   	push   %eax
  801add:	ff 75 0c             	pushl  0xc(%ebp)
  801ae0:	ff 75 08             	pushl  0x8(%ebp)
  801ae3:	e8 16 fc ff ff       	call   8016fe <vprintfmt>
  801ae8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801aeb:	90                   	nop
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801af1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af4:	8b 40 08             	mov    0x8(%eax),%eax
  801af7:	8d 50 01             	lea    0x1(%eax),%edx
  801afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801afd:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801b00:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b03:	8b 10                	mov    (%eax),%edx
  801b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b08:	8b 40 04             	mov    0x4(%eax),%eax
  801b0b:	39 c2                	cmp    %eax,%edx
  801b0d:	73 12                	jae    801b21 <sprintputch+0x33>
		*b->buf++ = ch;
  801b0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b12:	8b 00                	mov    (%eax),%eax
  801b14:	8d 48 01             	lea    0x1(%eax),%ecx
  801b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1a:	89 0a                	mov    %ecx,(%edx)
  801b1c:	8b 55 08             	mov    0x8(%ebp),%edx
  801b1f:	88 10                	mov    %dl,(%eax)
}
  801b21:	90                   	nop
  801b22:	5d                   	pop    %ebp
  801b23:	c3                   	ret    

00801b24 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
  801b27:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b30:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b33:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	01 d0                	add    %edx,%eax
  801b3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801b45:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b49:	74 06                	je     801b51 <vsnprintf+0x2d>
  801b4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b4f:	7f 07                	jg     801b58 <vsnprintf+0x34>
		return -E_INVAL;
  801b51:	b8 03 00 00 00       	mov    $0x3,%eax
  801b56:	eb 20                	jmp    801b78 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801b58:	ff 75 14             	pushl  0x14(%ebp)
  801b5b:	ff 75 10             	pushl  0x10(%ebp)
  801b5e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801b61:	50                   	push   %eax
  801b62:	68 ee 1a 80 00       	push   $0x801aee
  801b67:	e8 92 fb ff ff       	call   8016fe <vprintfmt>
  801b6c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801b6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b72:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801b78:	c9                   	leave  
  801b79:	c3                   	ret    

00801b7a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801b7a:	55                   	push   %ebp
  801b7b:	89 e5                	mov    %esp,%ebp
  801b7d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801b80:	8d 45 10             	lea    0x10(%ebp),%eax
  801b83:	83 c0 04             	add    $0x4,%eax
  801b86:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801b89:	8b 45 10             	mov    0x10(%ebp),%eax
  801b8c:	ff 75 f4             	pushl  -0xc(%ebp)
  801b8f:	50                   	push   %eax
  801b90:	ff 75 0c             	pushl  0xc(%ebp)
  801b93:	ff 75 08             	pushl  0x8(%ebp)
  801b96:	e8 89 ff ff ff       	call   801b24 <vsnprintf>
  801b9b:	83 c4 10             	add    $0x10,%esp
  801b9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801ba1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
  801ba9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801bac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bb3:	eb 06                	jmp    801bbb <strlen+0x15>
		n++;
  801bb5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801bb8:	ff 45 08             	incl   0x8(%ebp)
  801bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbe:	8a 00                	mov    (%eax),%al
  801bc0:	84 c0                	test   %al,%al
  801bc2:	75 f1                	jne    801bb5 <strlen+0xf>
		n++;
	return n;
  801bc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
  801bcc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801bcf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bd6:	eb 09                	jmp    801be1 <strnlen+0x18>
		n++;
  801bd8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801bdb:	ff 45 08             	incl   0x8(%ebp)
  801bde:	ff 4d 0c             	decl   0xc(%ebp)
  801be1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801be5:	74 09                	je     801bf0 <strnlen+0x27>
  801be7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bea:	8a 00                	mov    (%eax),%al
  801bec:	84 c0                	test   %al,%al
  801bee:	75 e8                	jne    801bd8 <strnlen+0xf>
		n++;
	return n;
  801bf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801bf3:	c9                   	leave  
  801bf4:	c3                   	ret    

00801bf5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
  801bf8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801c01:	90                   	nop
  801c02:	8b 45 08             	mov    0x8(%ebp),%eax
  801c05:	8d 50 01             	lea    0x1(%eax),%edx
  801c08:	89 55 08             	mov    %edx,0x8(%ebp)
  801c0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c0e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801c11:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801c14:	8a 12                	mov    (%edx),%dl
  801c16:	88 10                	mov    %dl,(%eax)
  801c18:	8a 00                	mov    (%eax),%al
  801c1a:	84 c0                	test   %al,%al
  801c1c:	75 e4                	jne    801c02 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801c1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c21:	c9                   	leave  
  801c22:	c3                   	ret    

00801c23 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801c23:	55                   	push   %ebp
  801c24:	89 e5                	mov    %esp,%ebp
  801c26:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801c29:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801c2f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c36:	eb 1f                	jmp    801c57 <strncpy+0x34>
		*dst++ = *src;
  801c38:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3b:	8d 50 01             	lea    0x1(%eax),%edx
  801c3e:	89 55 08             	mov    %edx,0x8(%ebp)
  801c41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c44:	8a 12                	mov    (%edx),%dl
  801c46:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c4b:	8a 00                	mov    (%eax),%al
  801c4d:	84 c0                	test   %al,%al
  801c4f:	74 03                	je     801c54 <strncpy+0x31>
			src++;
  801c51:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801c54:	ff 45 fc             	incl   -0x4(%ebp)
  801c57:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c5a:	3b 45 10             	cmp    0x10(%ebp),%eax
  801c5d:	72 d9                	jb     801c38 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801c5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c62:	c9                   	leave  
  801c63:	c3                   	ret    

00801c64 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801c64:	55                   	push   %ebp
  801c65:	89 e5                	mov    %esp,%ebp
  801c67:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801c70:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c74:	74 30                	je     801ca6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801c76:	eb 16                	jmp    801c8e <strlcpy+0x2a>
			*dst++ = *src++;
  801c78:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7b:	8d 50 01             	lea    0x1(%eax),%edx
  801c7e:	89 55 08             	mov    %edx,0x8(%ebp)
  801c81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c84:	8d 4a 01             	lea    0x1(%edx),%ecx
  801c87:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801c8a:	8a 12                	mov    (%edx),%dl
  801c8c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801c8e:	ff 4d 10             	decl   0x10(%ebp)
  801c91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c95:	74 09                	je     801ca0 <strlcpy+0x3c>
  801c97:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c9a:	8a 00                	mov    (%eax),%al
  801c9c:	84 c0                	test   %al,%al
  801c9e:	75 d8                	jne    801c78 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801ca6:	8b 55 08             	mov    0x8(%ebp),%edx
  801ca9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cac:	29 c2                	sub    %eax,%edx
  801cae:	89 d0                	mov    %edx,%eax
}
  801cb0:	c9                   	leave  
  801cb1:	c3                   	ret    

00801cb2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801cb2:	55                   	push   %ebp
  801cb3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801cb5:	eb 06                	jmp    801cbd <strcmp+0xb>
		p++, q++;
  801cb7:	ff 45 08             	incl   0x8(%ebp)
  801cba:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc0:	8a 00                	mov    (%eax),%al
  801cc2:	84 c0                	test   %al,%al
  801cc4:	74 0e                	je     801cd4 <strcmp+0x22>
  801cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc9:	8a 10                	mov    (%eax),%dl
  801ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cce:	8a 00                	mov    (%eax),%al
  801cd0:	38 c2                	cmp    %al,%dl
  801cd2:	74 e3                	je     801cb7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd7:	8a 00                	mov    (%eax),%al
  801cd9:	0f b6 d0             	movzbl %al,%edx
  801cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cdf:	8a 00                	mov    (%eax),%al
  801ce1:	0f b6 c0             	movzbl %al,%eax
  801ce4:	29 c2                	sub    %eax,%edx
  801ce6:	89 d0                	mov    %edx,%eax
}
  801ce8:	5d                   	pop    %ebp
  801ce9:	c3                   	ret    

00801cea <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801ced:	eb 09                	jmp    801cf8 <strncmp+0xe>
		n--, p++, q++;
  801cef:	ff 4d 10             	decl   0x10(%ebp)
  801cf2:	ff 45 08             	incl   0x8(%ebp)
  801cf5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801cf8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801cfc:	74 17                	je     801d15 <strncmp+0x2b>
  801cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801d01:	8a 00                	mov    (%eax),%al
  801d03:	84 c0                	test   %al,%al
  801d05:	74 0e                	je     801d15 <strncmp+0x2b>
  801d07:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0a:	8a 10                	mov    (%eax),%dl
  801d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d0f:	8a 00                	mov    (%eax),%al
  801d11:	38 c2                	cmp    %al,%dl
  801d13:	74 da                	je     801cef <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801d15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801d19:	75 07                	jne    801d22 <strncmp+0x38>
		return 0;
  801d1b:	b8 00 00 00 00       	mov    $0x0,%eax
  801d20:	eb 14                	jmp    801d36 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801d22:	8b 45 08             	mov    0x8(%ebp),%eax
  801d25:	8a 00                	mov    (%eax),%al
  801d27:	0f b6 d0             	movzbl %al,%edx
  801d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d2d:	8a 00                	mov    (%eax),%al
  801d2f:	0f b6 c0             	movzbl %al,%eax
  801d32:	29 c2                	sub    %eax,%edx
  801d34:	89 d0                	mov    %edx,%eax
}
  801d36:	5d                   	pop    %ebp
  801d37:	c3                   	ret    

00801d38 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
  801d3b:	83 ec 04             	sub    $0x4,%esp
  801d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d41:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801d44:	eb 12                	jmp    801d58 <strchr+0x20>
		if (*s == c)
  801d46:	8b 45 08             	mov    0x8(%ebp),%eax
  801d49:	8a 00                	mov    (%eax),%al
  801d4b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801d4e:	75 05                	jne    801d55 <strchr+0x1d>
			return (char *) s;
  801d50:	8b 45 08             	mov    0x8(%ebp),%eax
  801d53:	eb 11                	jmp    801d66 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801d55:	ff 45 08             	incl   0x8(%ebp)
  801d58:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5b:	8a 00                	mov    (%eax),%al
  801d5d:	84 c0                	test   %al,%al
  801d5f:	75 e5                	jne    801d46 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801d61:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d66:	c9                   	leave  
  801d67:	c3                   	ret    

00801d68 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801d68:	55                   	push   %ebp
  801d69:	89 e5                	mov    %esp,%ebp
  801d6b:	83 ec 04             	sub    $0x4,%esp
  801d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d71:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801d74:	eb 0d                	jmp    801d83 <strfind+0x1b>
		if (*s == c)
  801d76:	8b 45 08             	mov    0x8(%ebp),%eax
  801d79:	8a 00                	mov    (%eax),%al
  801d7b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801d7e:	74 0e                	je     801d8e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801d80:	ff 45 08             	incl   0x8(%ebp)
  801d83:	8b 45 08             	mov    0x8(%ebp),%eax
  801d86:	8a 00                	mov    (%eax),%al
  801d88:	84 c0                	test   %al,%al
  801d8a:	75 ea                	jne    801d76 <strfind+0xe>
  801d8c:	eb 01                	jmp    801d8f <strfind+0x27>
		if (*s == c)
			break;
  801d8e:	90                   	nop
	return (char *) s;
  801d8f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
  801d97:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801da0:	8b 45 10             	mov    0x10(%ebp),%eax
  801da3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801da6:	eb 0e                	jmp    801db6 <memset+0x22>
		*p++ = c;
  801da8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801dab:	8d 50 01             	lea    0x1(%eax),%edx
  801dae:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801db1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801db6:	ff 4d f8             	decl   -0x8(%ebp)
  801db9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801dbd:	79 e9                	jns    801da8 <memset+0x14>
		*p++ = c;

	return v;
  801dbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801dc2:	c9                   	leave  
  801dc3:	c3                   	ret    

00801dc4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801dc4:	55                   	push   %ebp
  801dc5:	89 e5                	mov    %esp,%ebp
  801dc7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801dca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801dd6:	eb 16                	jmp    801dee <memcpy+0x2a>
		*d++ = *s++;
  801dd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ddb:	8d 50 01             	lea    0x1(%eax),%edx
  801dde:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801de1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801de4:	8d 4a 01             	lea    0x1(%edx),%ecx
  801de7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801dea:	8a 12                	mov    (%edx),%dl
  801dec:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801dee:	8b 45 10             	mov    0x10(%ebp),%eax
  801df1:	8d 50 ff             	lea    -0x1(%eax),%edx
  801df4:	89 55 10             	mov    %edx,0x10(%ebp)
  801df7:	85 c0                	test   %eax,%eax
  801df9:	75 dd                	jne    801dd8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801dfb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801dfe:	c9                   	leave  
  801dff:	c3                   	ret    

00801e00 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801e00:	55                   	push   %ebp
  801e01:	89 e5                	mov    %esp,%ebp
  801e03:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801e12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e15:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801e18:	73 50                	jae    801e6a <memmove+0x6a>
  801e1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e1d:	8b 45 10             	mov    0x10(%ebp),%eax
  801e20:	01 d0                	add    %edx,%eax
  801e22:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801e25:	76 43                	jbe    801e6a <memmove+0x6a>
		s += n;
  801e27:	8b 45 10             	mov    0x10(%ebp),%eax
  801e2a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801e2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801e30:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801e33:	eb 10                	jmp    801e45 <memmove+0x45>
			*--d = *--s;
  801e35:	ff 4d f8             	decl   -0x8(%ebp)
  801e38:	ff 4d fc             	decl   -0x4(%ebp)
  801e3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e3e:	8a 10                	mov    (%eax),%dl
  801e40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e43:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801e45:	8b 45 10             	mov    0x10(%ebp),%eax
  801e48:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e4b:	89 55 10             	mov    %edx,0x10(%ebp)
  801e4e:	85 c0                	test   %eax,%eax
  801e50:	75 e3                	jne    801e35 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801e52:	eb 23                	jmp    801e77 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801e54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e57:	8d 50 01             	lea    0x1(%eax),%edx
  801e5a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801e5d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e60:	8d 4a 01             	lea    0x1(%edx),%ecx
  801e63:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801e66:	8a 12                	mov    (%edx),%dl
  801e68:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801e6a:	8b 45 10             	mov    0x10(%ebp),%eax
  801e6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e70:	89 55 10             	mov    %edx,0x10(%ebp)
  801e73:	85 c0                	test   %eax,%eax
  801e75:	75 dd                	jne    801e54 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801e77:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801e7a:	c9                   	leave  
  801e7b:	c3                   	ret    

00801e7c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801e7c:	55                   	push   %ebp
  801e7d:	89 e5                	mov    %esp,%ebp
  801e7f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801e82:	8b 45 08             	mov    0x8(%ebp),%eax
  801e85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e8b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801e8e:	eb 2a                	jmp    801eba <memcmp+0x3e>
		if (*s1 != *s2)
  801e90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e93:	8a 10                	mov    (%eax),%dl
  801e95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e98:	8a 00                	mov    (%eax),%al
  801e9a:	38 c2                	cmp    %al,%dl
  801e9c:	74 16                	je     801eb4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801e9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ea1:	8a 00                	mov    (%eax),%al
  801ea3:	0f b6 d0             	movzbl %al,%edx
  801ea6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ea9:	8a 00                	mov    (%eax),%al
  801eab:	0f b6 c0             	movzbl %al,%eax
  801eae:	29 c2                	sub    %eax,%edx
  801eb0:	89 d0                	mov    %edx,%eax
  801eb2:	eb 18                	jmp    801ecc <memcmp+0x50>
		s1++, s2++;
  801eb4:	ff 45 fc             	incl   -0x4(%ebp)
  801eb7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801eba:	8b 45 10             	mov    0x10(%ebp),%eax
  801ebd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ec0:	89 55 10             	mov    %edx,0x10(%ebp)
  801ec3:	85 c0                	test   %eax,%eax
  801ec5:	75 c9                	jne    801e90 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801ec7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ecc:	c9                   	leave  
  801ecd:	c3                   	ret    

00801ece <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801ece:	55                   	push   %ebp
  801ecf:	89 e5                	mov    %esp,%ebp
  801ed1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801ed4:	8b 55 08             	mov    0x8(%ebp),%edx
  801ed7:	8b 45 10             	mov    0x10(%ebp),%eax
  801eda:	01 d0                	add    %edx,%eax
  801edc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801edf:	eb 15                	jmp    801ef6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee4:	8a 00                	mov    (%eax),%al
  801ee6:	0f b6 d0             	movzbl %al,%edx
  801ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801eec:	0f b6 c0             	movzbl %al,%eax
  801eef:	39 c2                	cmp    %eax,%edx
  801ef1:	74 0d                	je     801f00 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801ef3:	ff 45 08             	incl   0x8(%ebp)
  801ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801efc:	72 e3                	jb     801ee1 <memfind+0x13>
  801efe:	eb 01                	jmp    801f01 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801f00:	90                   	nop
	return (void *) s;
  801f01:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801f04:	c9                   	leave  
  801f05:	c3                   	ret    

00801f06 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801f06:	55                   	push   %ebp
  801f07:	89 e5                	mov    %esp,%ebp
  801f09:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801f0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801f13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801f1a:	eb 03                	jmp    801f1f <strtol+0x19>
		s++;
  801f1c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f22:	8a 00                	mov    (%eax),%al
  801f24:	3c 20                	cmp    $0x20,%al
  801f26:	74 f4                	je     801f1c <strtol+0x16>
  801f28:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2b:	8a 00                	mov    (%eax),%al
  801f2d:	3c 09                	cmp    $0x9,%al
  801f2f:	74 eb                	je     801f1c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801f31:	8b 45 08             	mov    0x8(%ebp),%eax
  801f34:	8a 00                	mov    (%eax),%al
  801f36:	3c 2b                	cmp    $0x2b,%al
  801f38:	75 05                	jne    801f3f <strtol+0x39>
		s++;
  801f3a:	ff 45 08             	incl   0x8(%ebp)
  801f3d:	eb 13                	jmp    801f52 <strtol+0x4c>
	else if (*s == '-')
  801f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f42:	8a 00                	mov    (%eax),%al
  801f44:	3c 2d                	cmp    $0x2d,%al
  801f46:	75 0a                	jne    801f52 <strtol+0x4c>
		s++, neg = 1;
  801f48:	ff 45 08             	incl   0x8(%ebp)
  801f4b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801f52:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f56:	74 06                	je     801f5e <strtol+0x58>
  801f58:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801f5c:	75 20                	jne    801f7e <strtol+0x78>
  801f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f61:	8a 00                	mov    (%eax),%al
  801f63:	3c 30                	cmp    $0x30,%al
  801f65:	75 17                	jne    801f7e <strtol+0x78>
  801f67:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6a:	40                   	inc    %eax
  801f6b:	8a 00                	mov    (%eax),%al
  801f6d:	3c 78                	cmp    $0x78,%al
  801f6f:	75 0d                	jne    801f7e <strtol+0x78>
		s += 2, base = 16;
  801f71:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801f75:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801f7c:	eb 28                	jmp    801fa6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801f7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f82:	75 15                	jne    801f99 <strtol+0x93>
  801f84:	8b 45 08             	mov    0x8(%ebp),%eax
  801f87:	8a 00                	mov    (%eax),%al
  801f89:	3c 30                	cmp    $0x30,%al
  801f8b:	75 0c                	jne    801f99 <strtol+0x93>
		s++, base = 8;
  801f8d:	ff 45 08             	incl   0x8(%ebp)
  801f90:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801f97:	eb 0d                	jmp    801fa6 <strtol+0xa0>
	else if (base == 0)
  801f99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f9d:	75 07                	jne    801fa6 <strtol+0xa0>
		base = 10;
  801f9f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa9:	8a 00                	mov    (%eax),%al
  801fab:	3c 2f                	cmp    $0x2f,%al
  801fad:	7e 19                	jle    801fc8 <strtol+0xc2>
  801faf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb2:	8a 00                	mov    (%eax),%al
  801fb4:	3c 39                	cmp    $0x39,%al
  801fb6:	7f 10                	jg     801fc8 <strtol+0xc2>
			dig = *s - '0';
  801fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbb:	8a 00                	mov    (%eax),%al
  801fbd:	0f be c0             	movsbl %al,%eax
  801fc0:	83 e8 30             	sub    $0x30,%eax
  801fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801fc6:	eb 42                	jmp    80200a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcb:	8a 00                	mov    (%eax),%al
  801fcd:	3c 60                	cmp    $0x60,%al
  801fcf:	7e 19                	jle    801fea <strtol+0xe4>
  801fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd4:	8a 00                	mov    (%eax),%al
  801fd6:	3c 7a                	cmp    $0x7a,%al
  801fd8:	7f 10                	jg     801fea <strtol+0xe4>
			dig = *s - 'a' + 10;
  801fda:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdd:	8a 00                	mov    (%eax),%al
  801fdf:	0f be c0             	movsbl %al,%eax
  801fe2:	83 e8 57             	sub    $0x57,%eax
  801fe5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801fe8:	eb 20                	jmp    80200a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801fea:	8b 45 08             	mov    0x8(%ebp),%eax
  801fed:	8a 00                	mov    (%eax),%al
  801fef:	3c 40                	cmp    $0x40,%al
  801ff1:	7e 39                	jle    80202c <strtol+0x126>
  801ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff6:	8a 00                	mov    (%eax),%al
  801ff8:	3c 5a                	cmp    $0x5a,%al
  801ffa:	7f 30                	jg     80202c <strtol+0x126>
			dig = *s - 'A' + 10;
  801ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fff:	8a 00                	mov    (%eax),%al
  802001:	0f be c0             	movsbl %al,%eax
  802004:	83 e8 37             	sub    $0x37,%eax
  802007:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80200a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80200d:	3b 45 10             	cmp    0x10(%ebp),%eax
  802010:	7d 19                	jge    80202b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802012:	ff 45 08             	incl   0x8(%ebp)
  802015:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802018:	0f af 45 10          	imul   0x10(%ebp),%eax
  80201c:	89 c2                	mov    %eax,%edx
  80201e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802021:	01 d0                	add    %edx,%eax
  802023:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802026:	e9 7b ff ff ff       	jmp    801fa6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80202b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80202c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802030:	74 08                	je     80203a <strtol+0x134>
		*endptr = (char *) s;
  802032:	8b 45 0c             	mov    0xc(%ebp),%eax
  802035:	8b 55 08             	mov    0x8(%ebp),%edx
  802038:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80203a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80203e:	74 07                	je     802047 <strtol+0x141>
  802040:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802043:	f7 d8                	neg    %eax
  802045:	eb 03                	jmp    80204a <strtol+0x144>
  802047:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80204a:	c9                   	leave  
  80204b:	c3                   	ret    

0080204c <ltostr>:

void
ltostr(long value, char *str)
{
  80204c:	55                   	push   %ebp
  80204d:	89 e5                	mov    %esp,%ebp
  80204f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802052:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802059:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802060:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802064:	79 13                	jns    802079 <ltostr+0x2d>
	{
		neg = 1;
  802066:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80206d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802070:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802073:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802076:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802079:	8b 45 08             	mov    0x8(%ebp),%eax
  80207c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802081:	99                   	cltd   
  802082:	f7 f9                	idiv   %ecx
  802084:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802087:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80208a:	8d 50 01             	lea    0x1(%eax),%edx
  80208d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802090:	89 c2                	mov    %eax,%edx
  802092:	8b 45 0c             	mov    0xc(%ebp),%eax
  802095:	01 d0                	add    %edx,%eax
  802097:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80209a:	83 c2 30             	add    $0x30,%edx
  80209d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80209f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020a2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8020a7:	f7 e9                	imul   %ecx
  8020a9:	c1 fa 02             	sar    $0x2,%edx
  8020ac:	89 c8                	mov    %ecx,%eax
  8020ae:	c1 f8 1f             	sar    $0x1f,%eax
  8020b1:	29 c2                	sub    %eax,%edx
  8020b3:	89 d0                	mov    %edx,%eax
  8020b5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8020b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020bb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8020c0:	f7 e9                	imul   %ecx
  8020c2:	c1 fa 02             	sar    $0x2,%edx
  8020c5:	89 c8                	mov    %ecx,%eax
  8020c7:	c1 f8 1f             	sar    $0x1f,%eax
  8020ca:	29 c2                	sub    %eax,%edx
  8020cc:	89 d0                	mov    %edx,%eax
  8020ce:	c1 e0 02             	shl    $0x2,%eax
  8020d1:	01 d0                	add    %edx,%eax
  8020d3:	01 c0                	add    %eax,%eax
  8020d5:	29 c1                	sub    %eax,%ecx
  8020d7:	89 ca                	mov    %ecx,%edx
  8020d9:	85 d2                	test   %edx,%edx
  8020db:	75 9c                	jne    802079 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8020dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8020e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020e7:	48                   	dec    %eax
  8020e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8020eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8020ef:	74 3d                	je     80212e <ltostr+0xe2>
		start = 1 ;
  8020f1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8020f8:	eb 34                	jmp    80212e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8020fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8020fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  802100:	01 d0                	add    %edx,%eax
  802102:	8a 00                	mov    (%eax),%al
  802104:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802107:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80210a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80210d:	01 c2                	add    %eax,%edx
  80210f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802112:	8b 45 0c             	mov    0xc(%ebp),%eax
  802115:	01 c8                	add    %ecx,%eax
  802117:	8a 00                	mov    (%eax),%al
  802119:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80211b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80211e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802121:	01 c2                	add    %eax,%edx
  802123:	8a 45 eb             	mov    -0x15(%ebp),%al
  802126:	88 02                	mov    %al,(%edx)
		start++ ;
  802128:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80212b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80212e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802131:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802134:	7c c4                	jl     8020fa <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802136:	8b 55 f8             	mov    -0x8(%ebp),%edx
  802139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80213c:	01 d0                	add    %edx,%eax
  80213e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802141:	90                   	nop
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
  802147:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80214a:	ff 75 08             	pushl  0x8(%ebp)
  80214d:	e8 54 fa ff ff       	call   801ba6 <strlen>
  802152:	83 c4 04             	add    $0x4,%esp
  802155:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802158:	ff 75 0c             	pushl  0xc(%ebp)
  80215b:	e8 46 fa ff ff       	call   801ba6 <strlen>
  802160:	83 c4 04             	add    $0x4,%esp
  802163:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802166:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80216d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802174:	eb 17                	jmp    80218d <strcconcat+0x49>
		final[s] = str1[s] ;
  802176:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802179:	8b 45 10             	mov    0x10(%ebp),%eax
  80217c:	01 c2                	add    %eax,%edx
  80217e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802181:	8b 45 08             	mov    0x8(%ebp),%eax
  802184:	01 c8                	add    %ecx,%eax
  802186:	8a 00                	mov    (%eax),%al
  802188:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80218a:	ff 45 fc             	incl   -0x4(%ebp)
  80218d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802190:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802193:	7c e1                	jl     802176 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802195:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80219c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8021a3:	eb 1f                	jmp    8021c4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8021a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021a8:	8d 50 01             	lea    0x1(%eax),%edx
  8021ab:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8021ae:	89 c2                	mov    %eax,%edx
  8021b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8021b3:	01 c2                	add    %eax,%edx
  8021b5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8021b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021bb:	01 c8                	add    %ecx,%eax
  8021bd:	8a 00                	mov    (%eax),%al
  8021bf:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8021c1:	ff 45 f8             	incl   -0x8(%ebp)
  8021c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021c7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8021ca:	7c d9                	jl     8021a5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8021cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8021d2:	01 d0                	add    %edx,%eax
  8021d4:	c6 00 00             	movb   $0x0,(%eax)
}
  8021d7:	90                   	nop
  8021d8:	c9                   	leave  
  8021d9:	c3                   	ret    

008021da <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8021da:	55                   	push   %ebp
  8021db:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8021dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8021e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8021e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8021e9:	8b 00                	mov    (%eax),%eax
  8021eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8021f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8021f5:	01 d0                	add    %edx,%eax
  8021f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8021fd:	eb 0c                	jmp    80220b <strsplit+0x31>
			*string++ = 0;
  8021ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802202:	8d 50 01             	lea    0x1(%eax),%edx
  802205:	89 55 08             	mov    %edx,0x8(%ebp)
  802208:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80220b:	8b 45 08             	mov    0x8(%ebp),%eax
  80220e:	8a 00                	mov    (%eax),%al
  802210:	84 c0                	test   %al,%al
  802212:	74 18                	je     80222c <strsplit+0x52>
  802214:	8b 45 08             	mov    0x8(%ebp),%eax
  802217:	8a 00                	mov    (%eax),%al
  802219:	0f be c0             	movsbl %al,%eax
  80221c:	50                   	push   %eax
  80221d:	ff 75 0c             	pushl  0xc(%ebp)
  802220:	e8 13 fb ff ff       	call   801d38 <strchr>
  802225:	83 c4 08             	add    $0x8,%esp
  802228:	85 c0                	test   %eax,%eax
  80222a:	75 d3                	jne    8021ff <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80222c:	8b 45 08             	mov    0x8(%ebp),%eax
  80222f:	8a 00                	mov    (%eax),%al
  802231:	84 c0                	test   %al,%al
  802233:	74 5a                	je     80228f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  802235:	8b 45 14             	mov    0x14(%ebp),%eax
  802238:	8b 00                	mov    (%eax),%eax
  80223a:	83 f8 0f             	cmp    $0xf,%eax
  80223d:	75 07                	jne    802246 <strsplit+0x6c>
		{
			return 0;
  80223f:	b8 00 00 00 00       	mov    $0x0,%eax
  802244:	eb 66                	jmp    8022ac <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802246:	8b 45 14             	mov    0x14(%ebp),%eax
  802249:	8b 00                	mov    (%eax),%eax
  80224b:	8d 48 01             	lea    0x1(%eax),%ecx
  80224e:	8b 55 14             	mov    0x14(%ebp),%edx
  802251:	89 0a                	mov    %ecx,(%edx)
  802253:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80225a:	8b 45 10             	mov    0x10(%ebp),%eax
  80225d:	01 c2                	add    %eax,%edx
  80225f:	8b 45 08             	mov    0x8(%ebp),%eax
  802262:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802264:	eb 03                	jmp    802269 <strsplit+0x8f>
			string++;
  802266:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802269:	8b 45 08             	mov    0x8(%ebp),%eax
  80226c:	8a 00                	mov    (%eax),%al
  80226e:	84 c0                	test   %al,%al
  802270:	74 8b                	je     8021fd <strsplit+0x23>
  802272:	8b 45 08             	mov    0x8(%ebp),%eax
  802275:	8a 00                	mov    (%eax),%al
  802277:	0f be c0             	movsbl %al,%eax
  80227a:	50                   	push   %eax
  80227b:	ff 75 0c             	pushl  0xc(%ebp)
  80227e:	e8 b5 fa ff ff       	call   801d38 <strchr>
  802283:	83 c4 08             	add    $0x8,%esp
  802286:	85 c0                	test   %eax,%eax
  802288:	74 dc                	je     802266 <strsplit+0x8c>
			string++;
	}
  80228a:	e9 6e ff ff ff       	jmp    8021fd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80228f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  802290:	8b 45 14             	mov    0x14(%ebp),%eax
  802293:	8b 00                	mov    (%eax),%eax
  802295:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80229c:	8b 45 10             	mov    0x10(%ebp),%eax
  80229f:	01 d0                	add    %edx,%eax
  8022a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8022a7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8022ac:	c9                   	leave  
  8022ad:	c3                   	ret    

008022ae <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8022ae:	55                   	push   %ebp
  8022af:	89 e5                	mov    %esp,%ebp
  8022b1:	83 ec 18             	sub    $0x18,%esp
  8022b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8022b7:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8022ba:	83 ec 04             	sub    $0x4,%esp
  8022bd:	68 30 36 80 00       	push   $0x803630
  8022c2:	6a 17                	push   $0x17
  8022c4:	68 4f 36 80 00       	push   $0x80364f
  8022c9:	e8 a2 ef ff ff       	call   801270 <_panic>

008022ce <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8022ce:	55                   	push   %ebp
  8022cf:	89 e5                	mov    %esp,%ebp
  8022d1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8022d4:	83 ec 04             	sub    $0x4,%esp
  8022d7:	68 5b 36 80 00       	push   $0x80365b
  8022dc:	6a 2f                	push   $0x2f
  8022de:	68 4f 36 80 00       	push   $0x80364f
  8022e3:	e8 88 ef ff ff       	call   801270 <_panic>

008022e8 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8022e8:	55                   	push   %ebp
  8022e9:	89 e5                	mov    %esp,%ebp
  8022eb:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8022ee:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8022f5:	8b 55 08             	mov    0x8(%ebp),%edx
  8022f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8022fb:	01 d0                	add    %edx,%eax
  8022fd:	48                   	dec    %eax
  8022fe:	89 45 e8             	mov    %eax,-0x18(%ebp)
  802301:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802304:	ba 00 00 00 00       	mov    $0x0,%edx
  802309:	f7 75 ec             	divl   -0x14(%ebp)
  80230c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80230f:	29 d0                	sub    %edx,%eax
  802311:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  802314:	8b 45 08             	mov    0x8(%ebp),%eax
  802317:	c1 e8 0c             	shr    $0xc,%eax
  80231a:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80231d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  802324:	e9 c8 00 00 00       	jmp    8023f1 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  802329:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802330:	eb 27                	jmp    802359 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  802332:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802335:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802338:	01 c2                	add    %eax,%edx
  80233a:	89 d0                	mov    %edx,%eax
  80233c:	01 c0                	add    %eax,%eax
  80233e:	01 d0                	add    %edx,%eax
  802340:	c1 e0 02             	shl    $0x2,%eax
  802343:	05 48 40 80 00       	add    $0x804048,%eax
  802348:	8b 00                	mov    (%eax),%eax
  80234a:	85 c0                	test   %eax,%eax
  80234c:	74 08                	je     802356 <malloc+0x6e>
            	i += j;
  80234e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802351:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  802354:	eb 0b                	jmp    802361 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  802356:	ff 45 f0             	incl   -0x10(%ebp)
  802359:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80235c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80235f:	72 d1                	jb     802332 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  802361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802364:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  802367:	0f 85 81 00 00 00    	jne    8023ee <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80236d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802370:	05 00 00 08 00       	add    $0x80000,%eax
  802375:	c1 e0 0c             	shl    $0xc,%eax
  802378:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80237b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802382:	eb 1f                	jmp    8023a3 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  802384:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802387:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80238a:	01 c2                	add    %eax,%edx
  80238c:	89 d0                	mov    %edx,%eax
  80238e:	01 c0                	add    %eax,%eax
  802390:	01 d0                	add    %edx,%eax
  802392:	c1 e0 02             	shl    $0x2,%eax
  802395:	05 48 40 80 00       	add    $0x804048,%eax
  80239a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  8023a0:	ff 45 f0             	incl   -0x10(%ebp)
  8023a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8023a6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8023a9:	72 d9                	jb     802384 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  8023ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023ae:	89 d0                	mov    %edx,%eax
  8023b0:	01 c0                	add    %eax,%eax
  8023b2:	01 d0                	add    %edx,%eax
  8023b4:	c1 e0 02             	shl    $0x2,%eax
  8023b7:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  8023bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8023c0:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8023c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8023c5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8023c8:	89 c8                	mov    %ecx,%eax
  8023ca:	01 c0                	add    %eax,%eax
  8023cc:	01 c8                	add    %ecx,%eax
  8023ce:	c1 e0 02             	shl    $0x2,%eax
  8023d1:	05 44 40 80 00       	add    $0x804044,%eax
  8023d6:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8023d8:	83 ec 08             	sub    $0x8,%esp
  8023db:	ff 75 08             	pushl  0x8(%ebp)
  8023de:	ff 75 e0             	pushl  -0x20(%ebp)
  8023e1:	e8 2b 03 00 00       	call   802711 <sys_allocateMem>
  8023e6:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8023e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8023ec:	eb 19                	jmp    802407 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8023ee:	ff 45 f4             	incl   -0xc(%ebp)
  8023f1:	a1 04 40 80 00       	mov    0x804004,%eax
  8023f6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8023f9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8023fc:	0f 83 27 ff ff ff    	jae    802329 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  802402:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802407:	c9                   	leave  
  802408:	c3                   	ret    

00802409 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  802409:	55                   	push   %ebp
  80240a:	89 e5                	mov    %esp,%ebp
  80240c:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  80240f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802413:	0f 84 e5 00 00 00    	je     8024fe <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  802419:	8b 45 08             	mov    0x8(%ebp),%eax
  80241c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  80241f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802422:	05 00 00 00 80       	add    $0x80000000,%eax
  802427:	c1 e8 0c             	shr    $0xc,%eax
  80242a:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80242d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802430:	89 d0                	mov    %edx,%eax
  802432:	01 c0                	add    %eax,%eax
  802434:	01 d0                	add    %edx,%eax
  802436:	c1 e0 02             	shl    $0x2,%eax
  802439:	05 40 40 80 00       	add    $0x804040,%eax
  80243e:	8b 00                	mov    (%eax),%eax
  802440:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802443:	0f 85 b8 00 00 00    	jne    802501 <free+0xf8>
  802449:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80244c:	89 d0                	mov    %edx,%eax
  80244e:	01 c0                	add    %eax,%eax
  802450:	01 d0                	add    %edx,%eax
  802452:	c1 e0 02             	shl    $0x2,%eax
  802455:	05 48 40 80 00       	add    $0x804048,%eax
  80245a:	8b 00                	mov    (%eax),%eax
  80245c:	85 c0                	test   %eax,%eax
  80245e:	0f 84 9d 00 00 00    	je     802501 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  802464:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802467:	89 d0                	mov    %edx,%eax
  802469:	01 c0                	add    %eax,%eax
  80246b:	01 d0                	add    %edx,%eax
  80246d:	c1 e0 02             	shl    $0x2,%eax
  802470:	05 44 40 80 00       	add    $0x804044,%eax
  802475:	8b 00                	mov    (%eax),%eax
  802477:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80247a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80247d:	c1 e0 0c             	shl    $0xc,%eax
  802480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  802483:	83 ec 08             	sub    $0x8,%esp
  802486:	ff 75 e4             	pushl  -0x1c(%ebp)
  802489:	ff 75 f0             	pushl  -0x10(%ebp)
  80248c:	e8 64 02 00 00       	call   8026f5 <sys_freeMem>
  802491:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  802494:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80249b:	eb 57                	jmp    8024f4 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80249d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8024a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024a3:	01 c2                	add    %eax,%edx
  8024a5:	89 d0                	mov    %edx,%eax
  8024a7:	01 c0                	add    %eax,%eax
  8024a9:	01 d0                	add    %edx,%eax
  8024ab:	c1 e0 02             	shl    $0x2,%eax
  8024ae:	05 48 40 80 00       	add    $0x804048,%eax
  8024b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8024b9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8024bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024bf:	01 c2                	add    %eax,%edx
  8024c1:	89 d0                	mov    %edx,%eax
  8024c3:	01 c0                	add    %eax,%eax
  8024c5:	01 d0                	add    %edx,%eax
  8024c7:	c1 e0 02             	shl    $0x2,%eax
  8024ca:	05 40 40 80 00       	add    $0x804040,%eax
  8024cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8024d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8024d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024db:	01 c2                	add    %eax,%edx
  8024dd:	89 d0                	mov    %edx,%eax
  8024df:	01 c0                	add    %eax,%eax
  8024e1:	01 d0                	add    %edx,%eax
  8024e3:	c1 e0 02             	shl    $0x2,%eax
  8024e6:	05 44 40 80 00       	add    $0x804044,%eax
  8024eb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8024f1:	ff 45 f4             	incl   -0xc(%ebp)
  8024f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8024f7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8024fa:	7c a1                	jl     80249d <free+0x94>
  8024fc:	eb 04                	jmp    802502 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8024fe:	90                   	nop
  8024ff:	eb 01                	jmp    802502 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  802501:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  802502:	c9                   	leave  
  802503:	c3                   	ret    

00802504 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  802504:	55                   	push   %ebp
  802505:	89 e5                	mov    %esp,%ebp
  802507:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  80250a:	83 ec 04             	sub    $0x4,%esp
  80250d:	68 78 36 80 00       	push   $0x803678
  802512:	68 ae 00 00 00       	push   $0xae
  802517:	68 4f 36 80 00       	push   $0x80364f
  80251c:	e8 4f ed ff ff       	call   801270 <_panic>

00802521 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  802521:	55                   	push   %ebp
  802522:	89 e5                	mov    %esp,%ebp
  802524:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  802527:	83 ec 04             	sub    $0x4,%esp
  80252a:	68 98 36 80 00       	push   $0x803698
  80252f:	68 ca 00 00 00       	push   $0xca
  802534:	68 4f 36 80 00       	push   $0x80364f
  802539:	e8 32 ed ff ff       	call   801270 <_panic>

0080253e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80253e:	55                   	push   %ebp
  80253f:	89 e5                	mov    %esp,%ebp
  802541:	57                   	push   %edi
  802542:	56                   	push   %esi
  802543:	53                   	push   %ebx
  802544:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802547:	8b 45 08             	mov    0x8(%ebp),%eax
  80254a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80254d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802550:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802553:	8b 7d 18             	mov    0x18(%ebp),%edi
  802556:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802559:	cd 30                	int    $0x30
  80255b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80255e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802561:	83 c4 10             	add    $0x10,%esp
  802564:	5b                   	pop    %ebx
  802565:	5e                   	pop    %esi
  802566:	5f                   	pop    %edi
  802567:	5d                   	pop    %ebp
  802568:	c3                   	ret    

00802569 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802569:	55                   	push   %ebp
  80256a:	89 e5                	mov    %esp,%ebp
  80256c:	83 ec 04             	sub    $0x4,%esp
  80256f:	8b 45 10             	mov    0x10(%ebp),%eax
  802572:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802575:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802579:	8b 45 08             	mov    0x8(%ebp),%eax
  80257c:	6a 00                	push   $0x0
  80257e:	6a 00                	push   $0x0
  802580:	52                   	push   %edx
  802581:	ff 75 0c             	pushl  0xc(%ebp)
  802584:	50                   	push   %eax
  802585:	6a 00                	push   $0x0
  802587:	e8 b2 ff ff ff       	call   80253e <syscall>
  80258c:	83 c4 18             	add    $0x18,%esp
}
  80258f:	90                   	nop
  802590:	c9                   	leave  
  802591:	c3                   	ret    

00802592 <sys_cgetc>:

int
sys_cgetc(void)
{
  802592:	55                   	push   %ebp
  802593:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802595:	6a 00                	push   $0x0
  802597:	6a 00                	push   $0x0
  802599:	6a 00                	push   $0x0
  80259b:	6a 00                	push   $0x0
  80259d:	6a 00                	push   $0x0
  80259f:	6a 01                	push   $0x1
  8025a1:	e8 98 ff ff ff       	call   80253e <syscall>
  8025a6:	83 c4 18             	add    $0x18,%esp
}
  8025a9:	c9                   	leave  
  8025aa:	c3                   	ret    

008025ab <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8025ab:	55                   	push   %ebp
  8025ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8025ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b1:	6a 00                	push   $0x0
  8025b3:	6a 00                	push   $0x0
  8025b5:	6a 00                	push   $0x0
  8025b7:	6a 00                	push   $0x0
  8025b9:	50                   	push   %eax
  8025ba:	6a 05                	push   $0x5
  8025bc:	e8 7d ff ff ff       	call   80253e <syscall>
  8025c1:	83 c4 18             	add    $0x18,%esp
}
  8025c4:	c9                   	leave  
  8025c5:	c3                   	ret    

008025c6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8025c6:	55                   	push   %ebp
  8025c7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8025c9:	6a 00                	push   $0x0
  8025cb:	6a 00                	push   $0x0
  8025cd:	6a 00                	push   $0x0
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 02                	push   $0x2
  8025d5:	e8 64 ff ff ff       	call   80253e <syscall>
  8025da:	83 c4 18             	add    $0x18,%esp
}
  8025dd:	c9                   	leave  
  8025de:	c3                   	ret    

008025df <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8025df:	55                   	push   %ebp
  8025e0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8025e2:	6a 00                	push   $0x0
  8025e4:	6a 00                	push   $0x0
  8025e6:	6a 00                	push   $0x0
  8025e8:	6a 00                	push   $0x0
  8025ea:	6a 00                	push   $0x0
  8025ec:	6a 03                	push   $0x3
  8025ee:	e8 4b ff ff ff       	call   80253e <syscall>
  8025f3:	83 c4 18             	add    $0x18,%esp
}
  8025f6:	c9                   	leave  
  8025f7:	c3                   	ret    

008025f8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8025f8:	55                   	push   %ebp
  8025f9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8025fb:	6a 00                	push   $0x0
  8025fd:	6a 00                	push   $0x0
  8025ff:	6a 00                	push   $0x0
  802601:	6a 00                	push   $0x0
  802603:	6a 00                	push   $0x0
  802605:	6a 04                	push   $0x4
  802607:	e8 32 ff ff ff       	call   80253e <syscall>
  80260c:	83 c4 18             	add    $0x18,%esp
}
  80260f:	c9                   	leave  
  802610:	c3                   	ret    

00802611 <sys_env_exit>:


void sys_env_exit(void)
{
  802611:	55                   	push   %ebp
  802612:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802614:	6a 00                	push   $0x0
  802616:	6a 00                	push   $0x0
  802618:	6a 00                	push   $0x0
  80261a:	6a 00                	push   $0x0
  80261c:	6a 00                	push   $0x0
  80261e:	6a 06                	push   $0x6
  802620:	e8 19 ff ff ff       	call   80253e <syscall>
  802625:	83 c4 18             	add    $0x18,%esp
}
  802628:	90                   	nop
  802629:	c9                   	leave  
  80262a:	c3                   	ret    

0080262b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80262b:	55                   	push   %ebp
  80262c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80262e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802631:	8b 45 08             	mov    0x8(%ebp),%eax
  802634:	6a 00                	push   $0x0
  802636:	6a 00                	push   $0x0
  802638:	6a 00                	push   $0x0
  80263a:	52                   	push   %edx
  80263b:	50                   	push   %eax
  80263c:	6a 07                	push   $0x7
  80263e:	e8 fb fe ff ff       	call   80253e <syscall>
  802643:	83 c4 18             	add    $0x18,%esp
}
  802646:	c9                   	leave  
  802647:	c3                   	ret    

00802648 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802648:	55                   	push   %ebp
  802649:	89 e5                	mov    %esp,%ebp
  80264b:	56                   	push   %esi
  80264c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80264d:	8b 75 18             	mov    0x18(%ebp),%esi
  802650:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802653:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802656:	8b 55 0c             	mov    0xc(%ebp),%edx
  802659:	8b 45 08             	mov    0x8(%ebp),%eax
  80265c:	56                   	push   %esi
  80265d:	53                   	push   %ebx
  80265e:	51                   	push   %ecx
  80265f:	52                   	push   %edx
  802660:	50                   	push   %eax
  802661:	6a 08                	push   $0x8
  802663:	e8 d6 fe ff ff       	call   80253e <syscall>
  802668:	83 c4 18             	add    $0x18,%esp
}
  80266b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80266e:	5b                   	pop    %ebx
  80266f:	5e                   	pop    %esi
  802670:	5d                   	pop    %ebp
  802671:	c3                   	ret    

00802672 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802672:	55                   	push   %ebp
  802673:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802675:	8b 55 0c             	mov    0xc(%ebp),%edx
  802678:	8b 45 08             	mov    0x8(%ebp),%eax
  80267b:	6a 00                	push   $0x0
  80267d:	6a 00                	push   $0x0
  80267f:	6a 00                	push   $0x0
  802681:	52                   	push   %edx
  802682:	50                   	push   %eax
  802683:	6a 09                	push   $0x9
  802685:	e8 b4 fe ff ff       	call   80253e <syscall>
  80268a:	83 c4 18             	add    $0x18,%esp
}
  80268d:	c9                   	leave  
  80268e:	c3                   	ret    

0080268f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80268f:	55                   	push   %ebp
  802690:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802692:	6a 00                	push   $0x0
  802694:	6a 00                	push   $0x0
  802696:	6a 00                	push   $0x0
  802698:	ff 75 0c             	pushl  0xc(%ebp)
  80269b:	ff 75 08             	pushl  0x8(%ebp)
  80269e:	6a 0a                	push   $0xa
  8026a0:	e8 99 fe ff ff       	call   80253e <syscall>
  8026a5:	83 c4 18             	add    $0x18,%esp
}
  8026a8:	c9                   	leave  
  8026a9:	c3                   	ret    

008026aa <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8026aa:	55                   	push   %ebp
  8026ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8026ad:	6a 00                	push   $0x0
  8026af:	6a 00                	push   $0x0
  8026b1:	6a 00                	push   $0x0
  8026b3:	6a 00                	push   $0x0
  8026b5:	6a 00                	push   $0x0
  8026b7:	6a 0b                	push   $0xb
  8026b9:	e8 80 fe ff ff       	call   80253e <syscall>
  8026be:	83 c4 18             	add    $0x18,%esp
}
  8026c1:	c9                   	leave  
  8026c2:	c3                   	ret    

008026c3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8026c3:	55                   	push   %ebp
  8026c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8026c6:	6a 00                	push   $0x0
  8026c8:	6a 00                	push   $0x0
  8026ca:	6a 00                	push   $0x0
  8026cc:	6a 00                	push   $0x0
  8026ce:	6a 00                	push   $0x0
  8026d0:	6a 0c                	push   $0xc
  8026d2:	e8 67 fe ff ff       	call   80253e <syscall>
  8026d7:	83 c4 18             	add    $0x18,%esp
}
  8026da:	c9                   	leave  
  8026db:	c3                   	ret    

008026dc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8026dc:	55                   	push   %ebp
  8026dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8026df:	6a 00                	push   $0x0
  8026e1:	6a 00                	push   $0x0
  8026e3:	6a 00                	push   $0x0
  8026e5:	6a 00                	push   $0x0
  8026e7:	6a 00                	push   $0x0
  8026e9:	6a 0d                	push   $0xd
  8026eb:	e8 4e fe ff ff       	call   80253e <syscall>
  8026f0:	83 c4 18             	add    $0x18,%esp
}
  8026f3:	c9                   	leave  
  8026f4:	c3                   	ret    

008026f5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8026f5:	55                   	push   %ebp
  8026f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8026f8:	6a 00                	push   $0x0
  8026fa:	6a 00                	push   $0x0
  8026fc:	6a 00                	push   $0x0
  8026fe:	ff 75 0c             	pushl  0xc(%ebp)
  802701:	ff 75 08             	pushl  0x8(%ebp)
  802704:	6a 11                	push   $0x11
  802706:	e8 33 fe ff ff       	call   80253e <syscall>
  80270b:	83 c4 18             	add    $0x18,%esp
	return;
  80270e:	90                   	nop
}
  80270f:	c9                   	leave  
  802710:	c3                   	ret    

00802711 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802711:	55                   	push   %ebp
  802712:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802714:	6a 00                	push   $0x0
  802716:	6a 00                	push   $0x0
  802718:	6a 00                	push   $0x0
  80271a:	ff 75 0c             	pushl  0xc(%ebp)
  80271d:	ff 75 08             	pushl  0x8(%ebp)
  802720:	6a 12                	push   $0x12
  802722:	e8 17 fe ff ff       	call   80253e <syscall>
  802727:	83 c4 18             	add    $0x18,%esp
	return ;
  80272a:	90                   	nop
}
  80272b:	c9                   	leave  
  80272c:	c3                   	ret    

0080272d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80272d:	55                   	push   %ebp
  80272e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802730:	6a 00                	push   $0x0
  802732:	6a 00                	push   $0x0
  802734:	6a 00                	push   $0x0
  802736:	6a 00                	push   $0x0
  802738:	6a 00                	push   $0x0
  80273a:	6a 0e                	push   $0xe
  80273c:	e8 fd fd ff ff       	call   80253e <syscall>
  802741:	83 c4 18             	add    $0x18,%esp
}
  802744:	c9                   	leave  
  802745:	c3                   	ret    

00802746 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802746:	55                   	push   %ebp
  802747:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802749:	6a 00                	push   $0x0
  80274b:	6a 00                	push   $0x0
  80274d:	6a 00                	push   $0x0
  80274f:	6a 00                	push   $0x0
  802751:	ff 75 08             	pushl  0x8(%ebp)
  802754:	6a 0f                	push   $0xf
  802756:	e8 e3 fd ff ff       	call   80253e <syscall>
  80275b:	83 c4 18             	add    $0x18,%esp
}
  80275e:	c9                   	leave  
  80275f:	c3                   	ret    

00802760 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802760:	55                   	push   %ebp
  802761:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802763:	6a 00                	push   $0x0
  802765:	6a 00                	push   $0x0
  802767:	6a 00                	push   $0x0
  802769:	6a 00                	push   $0x0
  80276b:	6a 00                	push   $0x0
  80276d:	6a 10                	push   $0x10
  80276f:	e8 ca fd ff ff       	call   80253e <syscall>
  802774:	83 c4 18             	add    $0x18,%esp
}
  802777:	90                   	nop
  802778:	c9                   	leave  
  802779:	c3                   	ret    

0080277a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80277a:	55                   	push   %ebp
  80277b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80277d:	6a 00                	push   $0x0
  80277f:	6a 00                	push   $0x0
  802781:	6a 00                	push   $0x0
  802783:	6a 00                	push   $0x0
  802785:	6a 00                	push   $0x0
  802787:	6a 14                	push   $0x14
  802789:	e8 b0 fd ff ff       	call   80253e <syscall>
  80278e:	83 c4 18             	add    $0x18,%esp
}
  802791:	90                   	nop
  802792:	c9                   	leave  
  802793:	c3                   	ret    

00802794 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802794:	55                   	push   %ebp
  802795:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802797:	6a 00                	push   $0x0
  802799:	6a 00                	push   $0x0
  80279b:	6a 00                	push   $0x0
  80279d:	6a 00                	push   $0x0
  80279f:	6a 00                	push   $0x0
  8027a1:	6a 15                	push   $0x15
  8027a3:	e8 96 fd ff ff       	call   80253e <syscall>
  8027a8:	83 c4 18             	add    $0x18,%esp
}
  8027ab:	90                   	nop
  8027ac:	c9                   	leave  
  8027ad:	c3                   	ret    

008027ae <sys_cputc>:


void
sys_cputc(const char c)
{
  8027ae:	55                   	push   %ebp
  8027af:	89 e5                	mov    %esp,%ebp
  8027b1:	83 ec 04             	sub    $0x4,%esp
  8027b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8027b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8027ba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8027be:	6a 00                	push   $0x0
  8027c0:	6a 00                	push   $0x0
  8027c2:	6a 00                	push   $0x0
  8027c4:	6a 00                	push   $0x0
  8027c6:	50                   	push   %eax
  8027c7:	6a 16                	push   $0x16
  8027c9:	e8 70 fd ff ff       	call   80253e <syscall>
  8027ce:	83 c4 18             	add    $0x18,%esp
}
  8027d1:	90                   	nop
  8027d2:	c9                   	leave  
  8027d3:	c3                   	ret    

008027d4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8027d4:	55                   	push   %ebp
  8027d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8027d7:	6a 00                	push   $0x0
  8027d9:	6a 00                	push   $0x0
  8027db:	6a 00                	push   $0x0
  8027dd:	6a 00                	push   $0x0
  8027df:	6a 00                	push   $0x0
  8027e1:	6a 17                	push   $0x17
  8027e3:	e8 56 fd ff ff       	call   80253e <syscall>
  8027e8:	83 c4 18             	add    $0x18,%esp
}
  8027eb:	90                   	nop
  8027ec:	c9                   	leave  
  8027ed:	c3                   	ret    

008027ee <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8027ee:	55                   	push   %ebp
  8027ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8027f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8027f4:	6a 00                	push   $0x0
  8027f6:	6a 00                	push   $0x0
  8027f8:	6a 00                	push   $0x0
  8027fa:	ff 75 0c             	pushl  0xc(%ebp)
  8027fd:	50                   	push   %eax
  8027fe:	6a 18                	push   $0x18
  802800:	e8 39 fd ff ff       	call   80253e <syscall>
  802805:	83 c4 18             	add    $0x18,%esp
}
  802808:	c9                   	leave  
  802809:	c3                   	ret    

0080280a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80280a:	55                   	push   %ebp
  80280b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80280d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802810:	8b 45 08             	mov    0x8(%ebp),%eax
  802813:	6a 00                	push   $0x0
  802815:	6a 00                	push   $0x0
  802817:	6a 00                	push   $0x0
  802819:	52                   	push   %edx
  80281a:	50                   	push   %eax
  80281b:	6a 1b                	push   $0x1b
  80281d:	e8 1c fd ff ff       	call   80253e <syscall>
  802822:	83 c4 18             	add    $0x18,%esp
}
  802825:	c9                   	leave  
  802826:	c3                   	ret    

00802827 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802827:	55                   	push   %ebp
  802828:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80282a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80282d:	8b 45 08             	mov    0x8(%ebp),%eax
  802830:	6a 00                	push   $0x0
  802832:	6a 00                	push   $0x0
  802834:	6a 00                	push   $0x0
  802836:	52                   	push   %edx
  802837:	50                   	push   %eax
  802838:	6a 19                	push   $0x19
  80283a:	e8 ff fc ff ff       	call   80253e <syscall>
  80283f:	83 c4 18             	add    $0x18,%esp
}
  802842:	90                   	nop
  802843:	c9                   	leave  
  802844:	c3                   	ret    

00802845 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802845:	55                   	push   %ebp
  802846:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802848:	8b 55 0c             	mov    0xc(%ebp),%edx
  80284b:	8b 45 08             	mov    0x8(%ebp),%eax
  80284e:	6a 00                	push   $0x0
  802850:	6a 00                	push   $0x0
  802852:	6a 00                	push   $0x0
  802854:	52                   	push   %edx
  802855:	50                   	push   %eax
  802856:	6a 1a                	push   $0x1a
  802858:	e8 e1 fc ff ff       	call   80253e <syscall>
  80285d:	83 c4 18             	add    $0x18,%esp
}
  802860:	90                   	nop
  802861:	c9                   	leave  
  802862:	c3                   	ret    

00802863 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802863:	55                   	push   %ebp
  802864:	89 e5                	mov    %esp,%ebp
  802866:	83 ec 04             	sub    $0x4,%esp
  802869:	8b 45 10             	mov    0x10(%ebp),%eax
  80286c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80286f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802872:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802876:	8b 45 08             	mov    0x8(%ebp),%eax
  802879:	6a 00                	push   $0x0
  80287b:	51                   	push   %ecx
  80287c:	52                   	push   %edx
  80287d:	ff 75 0c             	pushl  0xc(%ebp)
  802880:	50                   	push   %eax
  802881:	6a 1c                	push   $0x1c
  802883:	e8 b6 fc ff ff       	call   80253e <syscall>
  802888:	83 c4 18             	add    $0x18,%esp
}
  80288b:	c9                   	leave  
  80288c:	c3                   	ret    

0080288d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80288d:	55                   	push   %ebp
  80288e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802890:	8b 55 0c             	mov    0xc(%ebp),%edx
  802893:	8b 45 08             	mov    0x8(%ebp),%eax
  802896:	6a 00                	push   $0x0
  802898:	6a 00                	push   $0x0
  80289a:	6a 00                	push   $0x0
  80289c:	52                   	push   %edx
  80289d:	50                   	push   %eax
  80289e:	6a 1d                	push   $0x1d
  8028a0:	e8 99 fc ff ff       	call   80253e <syscall>
  8028a5:	83 c4 18             	add    $0x18,%esp
}
  8028a8:	c9                   	leave  
  8028a9:	c3                   	ret    

008028aa <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8028aa:	55                   	push   %ebp
  8028ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8028ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8028b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8028b6:	6a 00                	push   $0x0
  8028b8:	6a 00                	push   $0x0
  8028ba:	51                   	push   %ecx
  8028bb:	52                   	push   %edx
  8028bc:	50                   	push   %eax
  8028bd:	6a 1e                	push   $0x1e
  8028bf:	e8 7a fc ff ff       	call   80253e <syscall>
  8028c4:	83 c4 18             	add    $0x18,%esp
}
  8028c7:	c9                   	leave  
  8028c8:	c3                   	ret    

008028c9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8028c9:	55                   	push   %ebp
  8028ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8028cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8028d2:	6a 00                	push   $0x0
  8028d4:	6a 00                	push   $0x0
  8028d6:	6a 00                	push   $0x0
  8028d8:	52                   	push   %edx
  8028d9:	50                   	push   %eax
  8028da:	6a 1f                	push   $0x1f
  8028dc:	e8 5d fc ff ff       	call   80253e <syscall>
  8028e1:	83 c4 18             	add    $0x18,%esp
}
  8028e4:	c9                   	leave  
  8028e5:	c3                   	ret    

008028e6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8028e6:	55                   	push   %ebp
  8028e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8028e9:	6a 00                	push   $0x0
  8028eb:	6a 00                	push   $0x0
  8028ed:	6a 00                	push   $0x0
  8028ef:	6a 00                	push   $0x0
  8028f1:	6a 00                	push   $0x0
  8028f3:	6a 20                	push   $0x20
  8028f5:	e8 44 fc ff ff       	call   80253e <syscall>
  8028fa:	83 c4 18             	add    $0x18,%esp
}
  8028fd:	c9                   	leave  
  8028fe:	c3                   	ret    

008028ff <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8028ff:	55                   	push   %ebp
  802900:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802902:	8b 45 08             	mov    0x8(%ebp),%eax
  802905:	6a 00                	push   $0x0
  802907:	6a 00                	push   $0x0
  802909:	ff 75 10             	pushl  0x10(%ebp)
  80290c:	ff 75 0c             	pushl  0xc(%ebp)
  80290f:	50                   	push   %eax
  802910:	6a 21                	push   $0x21
  802912:	e8 27 fc ff ff       	call   80253e <syscall>
  802917:	83 c4 18             	add    $0x18,%esp
}
  80291a:	c9                   	leave  
  80291b:	c3                   	ret    

0080291c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80291c:	55                   	push   %ebp
  80291d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80291f:	8b 45 08             	mov    0x8(%ebp),%eax
  802922:	6a 00                	push   $0x0
  802924:	6a 00                	push   $0x0
  802926:	6a 00                	push   $0x0
  802928:	6a 00                	push   $0x0
  80292a:	50                   	push   %eax
  80292b:	6a 22                	push   $0x22
  80292d:	e8 0c fc ff ff       	call   80253e <syscall>
  802932:	83 c4 18             	add    $0x18,%esp
}
  802935:	90                   	nop
  802936:	c9                   	leave  
  802937:	c3                   	ret    

00802938 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802938:	55                   	push   %ebp
  802939:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80293b:	8b 45 08             	mov    0x8(%ebp),%eax
  80293e:	6a 00                	push   $0x0
  802940:	6a 00                	push   $0x0
  802942:	6a 00                	push   $0x0
  802944:	6a 00                	push   $0x0
  802946:	50                   	push   %eax
  802947:	6a 23                	push   $0x23
  802949:	e8 f0 fb ff ff       	call   80253e <syscall>
  80294e:	83 c4 18             	add    $0x18,%esp
}
  802951:	90                   	nop
  802952:	c9                   	leave  
  802953:	c3                   	ret    

00802954 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802954:	55                   	push   %ebp
  802955:	89 e5                	mov    %esp,%ebp
  802957:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80295a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80295d:	8d 50 04             	lea    0x4(%eax),%edx
  802960:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802963:	6a 00                	push   $0x0
  802965:	6a 00                	push   $0x0
  802967:	6a 00                	push   $0x0
  802969:	52                   	push   %edx
  80296a:	50                   	push   %eax
  80296b:	6a 24                	push   $0x24
  80296d:	e8 cc fb ff ff       	call   80253e <syscall>
  802972:	83 c4 18             	add    $0x18,%esp
	return result;
  802975:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802978:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80297b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80297e:	89 01                	mov    %eax,(%ecx)
  802980:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802983:	8b 45 08             	mov    0x8(%ebp),%eax
  802986:	c9                   	leave  
  802987:	c2 04 00             	ret    $0x4

0080298a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80298a:	55                   	push   %ebp
  80298b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80298d:	6a 00                	push   $0x0
  80298f:	6a 00                	push   $0x0
  802991:	ff 75 10             	pushl  0x10(%ebp)
  802994:	ff 75 0c             	pushl  0xc(%ebp)
  802997:	ff 75 08             	pushl  0x8(%ebp)
  80299a:	6a 13                	push   $0x13
  80299c:	e8 9d fb ff ff       	call   80253e <syscall>
  8029a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8029a4:	90                   	nop
}
  8029a5:	c9                   	leave  
  8029a6:	c3                   	ret    

008029a7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8029a7:	55                   	push   %ebp
  8029a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8029aa:	6a 00                	push   $0x0
  8029ac:	6a 00                	push   $0x0
  8029ae:	6a 00                	push   $0x0
  8029b0:	6a 00                	push   $0x0
  8029b2:	6a 00                	push   $0x0
  8029b4:	6a 25                	push   $0x25
  8029b6:	e8 83 fb ff ff       	call   80253e <syscall>
  8029bb:	83 c4 18             	add    $0x18,%esp
}
  8029be:	c9                   	leave  
  8029bf:	c3                   	ret    

008029c0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8029c0:	55                   	push   %ebp
  8029c1:	89 e5                	mov    %esp,%ebp
  8029c3:	83 ec 04             	sub    $0x4,%esp
  8029c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8029c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8029cc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8029d0:	6a 00                	push   $0x0
  8029d2:	6a 00                	push   $0x0
  8029d4:	6a 00                	push   $0x0
  8029d6:	6a 00                	push   $0x0
  8029d8:	50                   	push   %eax
  8029d9:	6a 26                	push   $0x26
  8029db:	e8 5e fb ff ff       	call   80253e <syscall>
  8029e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8029e3:	90                   	nop
}
  8029e4:	c9                   	leave  
  8029e5:	c3                   	ret    

008029e6 <rsttst>:
void rsttst()
{
  8029e6:	55                   	push   %ebp
  8029e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8029e9:	6a 00                	push   $0x0
  8029eb:	6a 00                	push   $0x0
  8029ed:	6a 00                	push   $0x0
  8029ef:	6a 00                	push   $0x0
  8029f1:	6a 00                	push   $0x0
  8029f3:	6a 28                	push   $0x28
  8029f5:	e8 44 fb ff ff       	call   80253e <syscall>
  8029fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8029fd:	90                   	nop
}
  8029fe:	c9                   	leave  
  8029ff:	c3                   	ret    

00802a00 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802a00:	55                   	push   %ebp
  802a01:	89 e5                	mov    %esp,%ebp
  802a03:	83 ec 04             	sub    $0x4,%esp
  802a06:	8b 45 14             	mov    0x14(%ebp),%eax
  802a09:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802a0c:	8b 55 18             	mov    0x18(%ebp),%edx
  802a0f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802a13:	52                   	push   %edx
  802a14:	50                   	push   %eax
  802a15:	ff 75 10             	pushl  0x10(%ebp)
  802a18:	ff 75 0c             	pushl  0xc(%ebp)
  802a1b:	ff 75 08             	pushl  0x8(%ebp)
  802a1e:	6a 27                	push   $0x27
  802a20:	e8 19 fb ff ff       	call   80253e <syscall>
  802a25:	83 c4 18             	add    $0x18,%esp
	return ;
  802a28:	90                   	nop
}
  802a29:	c9                   	leave  
  802a2a:	c3                   	ret    

00802a2b <chktst>:
void chktst(uint32 n)
{
  802a2b:	55                   	push   %ebp
  802a2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802a2e:	6a 00                	push   $0x0
  802a30:	6a 00                	push   $0x0
  802a32:	6a 00                	push   $0x0
  802a34:	6a 00                	push   $0x0
  802a36:	ff 75 08             	pushl  0x8(%ebp)
  802a39:	6a 29                	push   $0x29
  802a3b:	e8 fe fa ff ff       	call   80253e <syscall>
  802a40:	83 c4 18             	add    $0x18,%esp
	return ;
  802a43:	90                   	nop
}
  802a44:	c9                   	leave  
  802a45:	c3                   	ret    

00802a46 <inctst>:

void inctst()
{
  802a46:	55                   	push   %ebp
  802a47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802a49:	6a 00                	push   $0x0
  802a4b:	6a 00                	push   $0x0
  802a4d:	6a 00                	push   $0x0
  802a4f:	6a 00                	push   $0x0
  802a51:	6a 00                	push   $0x0
  802a53:	6a 2a                	push   $0x2a
  802a55:	e8 e4 fa ff ff       	call   80253e <syscall>
  802a5a:	83 c4 18             	add    $0x18,%esp
	return ;
  802a5d:	90                   	nop
}
  802a5e:	c9                   	leave  
  802a5f:	c3                   	ret    

00802a60 <gettst>:
uint32 gettst()
{
  802a60:	55                   	push   %ebp
  802a61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802a63:	6a 00                	push   $0x0
  802a65:	6a 00                	push   $0x0
  802a67:	6a 00                	push   $0x0
  802a69:	6a 00                	push   $0x0
  802a6b:	6a 00                	push   $0x0
  802a6d:	6a 2b                	push   $0x2b
  802a6f:	e8 ca fa ff ff       	call   80253e <syscall>
  802a74:	83 c4 18             	add    $0x18,%esp
}
  802a77:	c9                   	leave  
  802a78:	c3                   	ret    

00802a79 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802a79:	55                   	push   %ebp
  802a7a:	89 e5                	mov    %esp,%ebp
  802a7c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802a7f:	6a 00                	push   $0x0
  802a81:	6a 00                	push   $0x0
  802a83:	6a 00                	push   $0x0
  802a85:	6a 00                	push   $0x0
  802a87:	6a 00                	push   $0x0
  802a89:	6a 2c                	push   $0x2c
  802a8b:	e8 ae fa ff ff       	call   80253e <syscall>
  802a90:	83 c4 18             	add    $0x18,%esp
  802a93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802a96:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802a9a:	75 07                	jne    802aa3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802a9c:	b8 01 00 00 00       	mov    $0x1,%eax
  802aa1:	eb 05                	jmp    802aa8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802aa3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802aa8:	c9                   	leave  
  802aa9:	c3                   	ret    

00802aaa <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802aaa:	55                   	push   %ebp
  802aab:	89 e5                	mov    %esp,%ebp
  802aad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802ab0:	6a 00                	push   $0x0
  802ab2:	6a 00                	push   $0x0
  802ab4:	6a 00                	push   $0x0
  802ab6:	6a 00                	push   $0x0
  802ab8:	6a 00                	push   $0x0
  802aba:	6a 2c                	push   $0x2c
  802abc:	e8 7d fa ff ff       	call   80253e <syscall>
  802ac1:	83 c4 18             	add    $0x18,%esp
  802ac4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802ac7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802acb:	75 07                	jne    802ad4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802acd:	b8 01 00 00 00       	mov    $0x1,%eax
  802ad2:	eb 05                	jmp    802ad9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802ad4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802ad9:	c9                   	leave  
  802ada:	c3                   	ret    

00802adb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802adb:	55                   	push   %ebp
  802adc:	89 e5                	mov    %esp,%ebp
  802ade:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802ae1:	6a 00                	push   $0x0
  802ae3:	6a 00                	push   $0x0
  802ae5:	6a 00                	push   $0x0
  802ae7:	6a 00                	push   $0x0
  802ae9:	6a 00                	push   $0x0
  802aeb:	6a 2c                	push   $0x2c
  802aed:	e8 4c fa ff ff       	call   80253e <syscall>
  802af2:	83 c4 18             	add    $0x18,%esp
  802af5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802af8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802afc:	75 07                	jne    802b05 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802afe:	b8 01 00 00 00       	mov    $0x1,%eax
  802b03:	eb 05                	jmp    802b0a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802b05:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b0a:	c9                   	leave  
  802b0b:	c3                   	ret    

00802b0c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802b0c:	55                   	push   %ebp
  802b0d:	89 e5                	mov    %esp,%ebp
  802b0f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b12:	6a 00                	push   $0x0
  802b14:	6a 00                	push   $0x0
  802b16:	6a 00                	push   $0x0
  802b18:	6a 00                	push   $0x0
  802b1a:	6a 00                	push   $0x0
  802b1c:	6a 2c                	push   $0x2c
  802b1e:	e8 1b fa ff ff       	call   80253e <syscall>
  802b23:	83 c4 18             	add    $0x18,%esp
  802b26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802b29:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802b2d:	75 07                	jne    802b36 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802b2f:	b8 01 00 00 00       	mov    $0x1,%eax
  802b34:	eb 05                	jmp    802b3b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802b36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b3b:	c9                   	leave  
  802b3c:	c3                   	ret    

00802b3d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802b3d:	55                   	push   %ebp
  802b3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802b40:	6a 00                	push   $0x0
  802b42:	6a 00                	push   $0x0
  802b44:	6a 00                	push   $0x0
  802b46:	6a 00                	push   $0x0
  802b48:	ff 75 08             	pushl  0x8(%ebp)
  802b4b:	6a 2d                	push   $0x2d
  802b4d:	e8 ec f9 ff ff       	call   80253e <syscall>
  802b52:	83 c4 18             	add    $0x18,%esp
	return ;
  802b55:	90                   	nop
}
  802b56:	c9                   	leave  
  802b57:	c3                   	ret    

00802b58 <__udivdi3>:
  802b58:	55                   	push   %ebp
  802b59:	57                   	push   %edi
  802b5a:	56                   	push   %esi
  802b5b:	53                   	push   %ebx
  802b5c:	83 ec 1c             	sub    $0x1c,%esp
  802b5f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802b63:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802b67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802b6b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802b6f:	89 ca                	mov    %ecx,%edx
  802b71:	89 f8                	mov    %edi,%eax
  802b73:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802b77:	85 f6                	test   %esi,%esi
  802b79:	75 2d                	jne    802ba8 <__udivdi3+0x50>
  802b7b:	39 cf                	cmp    %ecx,%edi
  802b7d:	77 65                	ja     802be4 <__udivdi3+0x8c>
  802b7f:	89 fd                	mov    %edi,%ebp
  802b81:	85 ff                	test   %edi,%edi
  802b83:	75 0b                	jne    802b90 <__udivdi3+0x38>
  802b85:	b8 01 00 00 00       	mov    $0x1,%eax
  802b8a:	31 d2                	xor    %edx,%edx
  802b8c:	f7 f7                	div    %edi
  802b8e:	89 c5                	mov    %eax,%ebp
  802b90:	31 d2                	xor    %edx,%edx
  802b92:	89 c8                	mov    %ecx,%eax
  802b94:	f7 f5                	div    %ebp
  802b96:	89 c1                	mov    %eax,%ecx
  802b98:	89 d8                	mov    %ebx,%eax
  802b9a:	f7 f5                	div    %ebp
  802b9c:	89 cf                	mov    %ecx,%edi
  802b9e:	89 fa                	mov    %edi,%edx
  802ba0:	83 c4 1c             	add    $0x1c,%esp
  802ba3:	5b                   	pop    %ebx
  802ba4:	5e                   	pop    %esi
  802ba5:	5f                   	pop    %edi
  802ba6:	5d                   	pop    %ebp
  802ba7:	c3                   	ret    
  802ba8:	39 ce                	cmp    %ecx,%esi
  802baa:	77 28                	ja     802bd4 <__udivdi3+0x7c>
  802bac:	0f bd fe             	bsr    %esi,%edi
  802baf:	83 f7 1f             	xor    $0x1f,%edi
  802bb2:	75 40                	jne    802bf4 <__udivdi3+0x9c>
  802bb4:	39 ce                	cmp    %ecx,%esi
  802bb6:	72 0a                	jb     802bc2 <__udivdi3+0x6a>
  802bb8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802bbc:	0f 87 9e 00 00 00    	ja     802c60 <__udivdi3+0x108>
  802bc2:	b8 01 00 00 00       	mov    $0x1,%eax
  802bc7:	89 fa                	mov    %edi,%edx
  802bc9:	83 c4 1c             	add    $0x1c,%esp
  802bcc:	5b                   	pop    %ebx
  802bcd:	5e                   	pop    %esi
  802bce:	5f                   	pop    %edi
  802bcf:	5d                   	pop    %ebp
  802bd0:	c3                   	ret    
  802bd1:	8d 76 00             	lea    0x0(%esi),%esi
  802bd4:	31 ff                	xor    %edi,%edi
  802bd6:	31 c0                	xor    %eax,%eax
  802bd8:	89 fa                	mov    %edi,%edx
  802bda:	83 c4 1c             	add    $0x1c,%esp
  802bdd:	5b                   	pop    %ebx
  802bde:	5e                   	pop    %esi
  802bdf:	5f                   	pop    %edi
  802be0:	5d                   	pop    %ebp
  802be1:	c3                   	ret    
  802be2:	66 90                	xchg   %ax,%ax
  802be4:	89 d8                	mov    %ebx,%eax
  802be6:	f7 f7                	div    %edi
  802be8:	31 ff                	xor    %edi,%edi
  802bea:	89 fa                	mov    %edi,%edx
  802bec:	83 c4 1c             	add    $0x1c,%esp
  802bef:	5b                   	pop    %ebx
  802bf0:	5e                   	pop    %esi
  802bf1:	5f                   	pop    %edi
  802bf2:	5d                   	pop    %ebp
  802bf3:	c3                   	ret    
  802bf4:	bd 20 00 00 00       	mov    $0x20,%ebp
  802bf9:	89 eb                	mov    %ebp,%ebx
  802bfb:	29 fb                	sub    %edi,%ebx
  802bfd:	89 f9                	mov    %edi,%ecx
  802bff:	d3 e6                	shl    %cl,%esi
  802c01:	89 c5                	mov    %eax,%ebp
  802c03:	88 d9                	mov    %bl,%cl
  802c05:	d3 ed                	shr    %cl,%ebp
  802c07:	89 e9                	mov    %ebp,%ecx
  802c09:	09 f1                	or     %esi,%ecx
  802c0b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802c0f:	89 f9                	mov    %edi,%ecx
  802c11:	d3 e0                	shl    %cl,%eax
  802c13:	89 c5                	mov    %eax,%ebp
  802c15:	89 d6                	mov    %edx,%esi
  802c17:	88 d9                	mov    %bl,%cl
  802c19:	d3 ee                	shr    %cl,%esi
  802c1b:	89 f9                	mov    %edi,%ecx
  802c1d:	d3 e2                	shl    %cl,%edx
  802c1f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802c23:	88 d9                	mov    %bl,%cl
  802c25:	d3 e8                	shr    %cl,%eax
  802c27:	09 c2                	or     %eax,%edx
  802c29:	89 d0                	mov    %edx,%eax
  802c2b:	89 f2                	mov    %esi,%edx
  802c2d:	f7 74 24 0c          	divl   0xc(%esp)
  802c31:	89 d6                	mov    %edx,%esi
  802c33:	89 c3                	mov    %eax,%ebx
  802c35:	f7 e5                	mul    %ebp
  802c37:	39 d6                	cmp    %edx,%esi
  802c39:	72 19                	jb     802c54 <__udivdi3+0xfc>
  802c3b:	74 0b                	je     802c48 <__udivdi3+0xf0>
  802c3d:	89 d8                	mov    %ebx,%eax
  802c3f:	31 ff                	xor    %edi,%edi
  802c41:	e9 58 ff ff ff       	jmp    802b9e <__udivdi3+0x46>
  802c46:	66 90                	xchg   %ax,%ax
  802c48:	8b 54 24 08          	mov    0x8(%esp),%edx
  802c4c:	89 f9                	mov    %edi,%ecx
  802c4e:	d3 e2                	shl    %cl,%edx
  802c50:	39 c2                	cmp    %eax,%edx
  802c52:	73 e9                	jae    802c3d <__udivdi3+0xe5>
  802c54:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802c57:	31 ff                	xor    %edi,%edi
  802c59:	e9 40 ff ff ff       	jmp    802b9e <__udivdi3+0x46>
  802c5e:	66 90                	xchg   %ax,%ax
  802c60:	31 c0                	xor    %eax,%eax
  802c62:	e9 37 ff ff ff       	jmp    802b9e <__udivdi3+0x46>
  802c67:	90                   	nop

00802c68 <__umoddi3>:
  802c68:	55                   	push   %ebp
  802c69:	57                   	push   %edi
  802c6a:	56                   	push   %esi
  802c6b:	53                   	push   %ebx
  802c6c:	83 ec 1c             	sub    $0x1c,%esp
  802c6f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802c73:	8b 74 24 34          	mov    0x34(%esp),%esi
  802c77:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802c7b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802c7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802c83:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802c87:	89 f3                	mov    %esi,%ebx
  802c89:	89 fa                	mov    %edi,%edx
  802c8b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802c8f:	89 34 24             	mov    %esi,(%esp)
  802c92:	85 c0                	test   %eax,%eax
  802c94:	75 1a                	jne    802cb0 <__umoddi3+0x48>
  802c96:	39 f7                	cmp    %esi,%edi
  802c98:	0f 86 a2 00 00 00    	jbe    802d40 <__umoddi3+0xd8>
  802c9e:	89 c8                	mov    %ecx,%eax
  802ca0:	89 f2                	mov    %esi,%edx
  802ca2:	f7 f7                	div    %edi
  802ca4:	89 d0                	mov    %edx,%eax
  802ca6:	31 d2                	xor    %edx,%edx
  802ca8:	83 c4 1c             	add    $0x1c,%esp
  802cab:	5b                   	pop    %ebx
  802cac:	5e                   	pop    %esi
  802cad:	5f                   	pop    %edi
  802cae:	5d                   	pop    %ebp
  802caf:	c3                   	ret    
  802cb0:	39 f0                	cmp    %esi,%eax
  802cb2:	0f 87 ac 00 00 00    	ja     802d64 <__umoddi3+0xfc>
  802cb8:	0f bd e8             	bsr    %eax,%ebp
  802cbb:	83 f5 1f             	xor    $0x1f,%ebp
  802cbe:	0f 84 ac 00 00 00    	je     802d70 <__umoddi3+0x108>
  802cc4:	bf 20 00 00 00       	mov    $0x20,%edi
  802cc9:	29 ef                	sub    %ebp,%edi
  802ccb:	89 fe                	mov    %edi,%esi
  802ccd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802cd1:	89 e9                	mov    %ebp,%ecx
  802cd3:	d3 e0                	shl    %cl,%eax
  802cd5:	89 d7                	mov    %edx,%edi
  802cd7:	89 f1                	mov    %esi,%ecx
  802cd9:	d3 ef                	shr    %cl,%edi
  802cdb:	09 c7                	or     %eax,%edi
  802cdd:	89 e9                	mov    %ebp,%ecx
  802cdf:	d3 e2                	shl    %cl,%edx
  802ce1:	89 14 24             	mov    %edx,(%esp)
  802ce4:	89 d8                	mov    %ebx,%eax
  802ce6:	d3 e0                	shl    %cl,%eax
  802ce8:	89 c2                	mov    %eax,%edx
  802cea:	8b 44 24 08          	mov    0x8(%esp),%eax
  802cee:	d3 e0                	shl    %cl,%eax
  802cf0:	89 44 24 04          	mov    %eax,0x4(%esp)
  802cf4:	8b 44 24 08          	mov    0x8(%esp),%eax
  802cf8:	89 f1                	mov    %esi,%ecx
  802cfa:	d3 e8                	shr    %cl,%eax
  802cfc:	09 d0                	or     %edx,%eax
  802cfe:	d3 eb                	shr    %cl,%ebx
  802d00:	89 da                	mov    %ebx,%edx
  802d02:	f7 f7                	div    %edi
  802d04:	89 d3                	mov    %edx,%ebx
  802d06:	f7 24 24             	mull   (%esp)
  802d09:	89 c6                	mov    %eax,%esi
  802d0b:	89 d1                	mov    %edx,%ecx
  802d0d:	39 d3                	cmp    %edx,%ebx
  802d0f:	0f 82 87 00 00 00    	jb     802d9c <__umoddi3+0x134>
  802d15:	0f 84 91 00 00 00    	je     802dac <__umoddi3+0x144>
  802d1b:	8b 54 24 04          	mov    0x4(%esp),%edx
  802d1f:	29 f2                	sub    %esi,%edx
  802d21:	19 cb                	sbb    %ecx,%ebx
  802d23:	89 d8                	mov    %ebx,%eax
  802d25:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802d29:	d3 e0                	shl    %cl,%eax
  802d2b:	89 e9                	mov    %ebp,%ecx
  802d2d:	d3 ea                	shr    %cl,%edx
  802d2f:	09 d0                	or     %edx,%eax
  802d31:	89 e9                	mov    %ebp,%ecx
  802d33:	d3 eb                	shr    %cl,%ebx
  802d35:	89 da                	mov    %ebx,%edx
  802d37:	83 c4 1c             	add    $0x1c,%esp
  802d3a:	5b                   	pop    %ebx
  802d3b:	5e                   	pop    %esi
  802d3c:	5f                   	pop    %edi
  802d3d:	5d                   	pop    %ebp
  802d3e:	c3                   	ret    
  802d3f:	90                   	nop
  802d40:	89 fd                	mov    %edi,%ebp
  802d42:	85 ff                	test   %edi,%edi
  802d44:	75 0b                	jne    802d51 <__umoddi3+0xe9>
  802d46:	b8 01 00 00 00       	mov    $0x1,%eax
  802d4b:	31 d2                	xor    %edx,%edx
  802d4d:	f7 f7                	div    %edi
  802d4f:	89 c5                	mov    %eax,%ebp
  802d51:	89 f0                	mov    %esi,%eax
  802d53:	31 d2                	xor    %edx,%edx
  802d55:	f7 f5                	div    %ebp
  802d57:	89 c8                	mov    %ecx,%eax
  802d59:	f7 f5                	div    %ebp
  802d5b:	89 d0                	mov    %edx,%eax
  802d5d:	e9 44 ff ff ff       	jmp    802ca6 <__umoddi3+0x3e>
  802d62:	66 90                	xchg   %ax,%ax
  802d64:	89 c8                	mov    %ecx,%eax
  802d66:	89 f2                	mov    %esi,%edx
  802d68:	83 c4 1c             	add    $0x1c,%esp
  802d6b:	5b                   	pop    %ebx
  802d6c:	5e                   	pop    %esi
  802d6d:	5f                   	pop    %edi
  802d6e:	5d                   	pop    %ebp
  802d6f:	c3                   	ret    
  802d70:	3b 04 24             	cmp    (%esp),%eax
  802d73:	72 06                	jb     802d7b <__umoddi3+0x113>
  802d75:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802d79:	77 0f                	ja     802d8a <__umoddi3+0x122>
  802d7b:	89 f2                	mov    %esi,%edx
  802d7d:	29 f9                	sub    %edi,%ecx
  802d7f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802d83:	89 14 24             	mov    %edx,(%esp)
  802d86:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802d8a:	8b 44 24 04          	mov    0x4(%esp),%eax
  802d8e:	8b 14 24             	mov    (%esp),%edx
  802d91:	83 c4 1c             	add    $0x1c,%esp
  802d94:	5b                   	pop    %ebx
  802d95:	5e                   	pop    %esi
  802d96:	5f                   	pop    %edi
  802d97:	5d                   	pop    %ebp
  802d98:	c3                   	ret    
  802d99:	8d 76 00             	lea    0x0(%esi),%esi
  802d9c:	2b 04 24             	sub    (%esp),%eax
  802d9f:	19 fa                	sbb    %edi,%edx
  802da1:	89 d1                	mov    %edx,%ecx
  802da3:	89 c6                	mov    %eax,%esi
  802da5:	e9 71 ff ff ff       	jmp    802d1b <__umoddi3+0xb3>
  802daa:	66 90                	xchg   %ax,%ax
  802dac:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802db0:	72 ea                	jb     802d9c <__umoddi3+0x134>
  802db2:	89 d9                	mov    %ebx,%ecx
  802db4:	e9 62 ff ff ff       	jmp    802d1b <__umoddi3+0xb3>
