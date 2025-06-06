
obj/user/tst_realloc_3:     file format elf32-i386


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
  800031:	e8 29 06 00 00       	call   80065f <libmain>
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
  80003d:	83 ec 40             	sub    $0x40,%esp
	int Mega = 1024*1024;
  800040:	c7 45 f0 00 00 10 00 	movl   $0x100000,-0x10(%ebp)
	int kilo = 1024;
  800047:	c7 45 ec 00 04 00 00 	movl   $0x400,-0x14(%ebp)
	void* ptr_allocations[5] = {0};
  80004e:	8d 55 c4             	lea    -0x3c(%ebp),%edx
  800051:	b9 05 00 00 00       	mov    $0x5,%ecx
  800056:	b8 00 00 00 00       	mov    $0x0,%eax
  80005b:	89 d7                	mov    %edx,%edi
  80005d:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	cprintf("realloc: current evaluation = 00%");
  80005f:	83 ec 0c             	sub    $0xc,%esp
  800062:	68 c0 22 80 00       	push   $0x8022c0
  800067:	e8 a9 09 00 00       	call   800a15 <cprintf>
  80006c:	83 c4 10             	add    $0x10,%esp
	//[1] Allocate all
	{
		//Allocate 100 KB
		freeFrames = sys_calculate_free_frames() ;
  80006f:	e8 27 1b 00 00       	call   801b9b <sys_calculate_free_frames>
  800074:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800077:	e8 a2 1b 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  80007c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = malloc(100*kilo - kilo);
  80007f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800082:	89 d0                	mov    %edx,%eax
  800084:	01 c0                	add    %eax,%eax
  800086:	01 d0                	add    %edx,%eax
  800088:	89 c2                	mov    %eax,%edx
  80008a:	c1 e2 05             	shl    $0x5,%edx
  80008d:	01 d0                	add    %edx,%eax
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	50                   	push   %eax
  800093:	e8 41 17 00 00       	call   8017d9 <malloc>
  800098:	83 c4 10             	add    $0x10,%esp
  80009b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((uint32) ptr_allocations[0] !=  (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  80009e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8000a1:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000a6:	74 14                	je     8000bc <_main+0x84>
  8000a8:	83 ec 04             	sub    $0x4,%esp
  8000ab:	68 e4 22 80 00       	push   $0x8022e4
  8000b0:	6a 11                	push   $0x11
  8000b2:	68 14 23 80 00       	push   $0x802314
  8000b7:	e8 a5 06 00 00       	call   800761 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8000bc:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  8000bf:	e8 d7 1a 00 00       	call   801b9b <sys_calculate_free_frames>
  8000c4:	29 c3                	sub    %eax,%ebx
  8000c6:	89 d8                	mov    %ebx,%eax
  8000c8:	83 f8 01             	cmp    $0x1,%eax
  8000cb:	74 14                	je     8000e1 <_main+0xa9>
  8000cd:	83 ec 04             	sub    $0x4,%esp
  8000d0:	68 2c 23 80 00       	push   $0x80232c
  8000d5:	6a 13                	push   $0x13
  8000d7:	68 14 23 80 00       	push   $0x802314
  8000dc:	e8 80 06 00 00       	call   800761 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 25) panic("Extra or less pages are allocated in PageFile");
  8000e1:	e8 38 1b 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  8000e6:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8000e9:	83 f8 19             	cmp    $0x19,%eax
  8000ec:	74 14                	je     800102 <_main+0xca>
  8000ee:	83 ec 04             	sub    $0x4,%esp
  8000f1:	68 98 23 80 00       	push   $0x802398
  8000f6:	6a 14                	push   $0x14
  8000f8:	68 14 23 80 00       	push   $0x802314
  8000fd:	e8 5f 06 00 00       	call   800761 <_panic>

		//Allocate 20 KB
		freeFrames = sys_calculate_free_frames() ;
  800102:	e8 94 1a 00 00       	call   801b9b <sys_calculate_free_frames>
  800107:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80010a:	e8 0f 1b 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  80010f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[1] = malloc(20*kilo-kilo);
  800112:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800115:	89 d0                	mov    %edx,%eax
  800117:	c1 e0 03             	shl    $0x3,%eax
  80011a:	01 d0                	add    %edx,%eax
  80011c:	01 c0                	add    %eax,%eax
  80011e:	01 d0                	add    %edx,%eax
  800120:	83 ec 0c             	sub    $0xc,%esp
  800123:	50                   	push   %eax
  800124:	e8 b0 16 00 00       	call   8017d9 <malloc>
  800129:	83 c4 10             	add    $0x10,%esp
  80012c:	89 45 c8             	mov    %eax,-0x38(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 100 * kilo)) panic("Wrong start address for the allocated space... ");
  80012f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800132:	89 c1                	mov    %eax,%ecx
  800134:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800137:	89 d0                	mov    %edx,%eax
  800139:	c1 e0 02             	shl    $0x2,%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800145:	01 d0                	add    %edx,%eax
  800147:	c1 e0 02             	shl    $0x2,%eax
  80014a:	05 00 00 00 80       	add    $0x80000000,%eax
  80014f:	39 c1                	cmp    %eax,%ecx
  800151:	74 14                	je     800167 <_main+0x12f>
  800153:	83 ec 04             	sub    $0x4,%esp
  800156:	68 e4 22 80 00       	push   $0x8022e4
  80015b:	6a 1a                	push   $0x1a
  80015d:	68 14 23 80 00       	push   $0x802314
  800162:	e8 fa 05 00 00       	call   800761 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800167:	e8 2f 1a 00 00       	call   801b9b <sys_calculate_free_frames>
  80016c:	89 c2                	mov    %eax,%edx
  80016e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800171:	39 c2                	cmp    %eax,%edx
  800173:	74 14                	je     800189 <_main+0x151>
  800175:	83 ec 04             	sub    $0x4,%esp
  800178:	68 2c 23 80 00       	push   $0x80232c
  80017d:	6a 1c                	push   $0x1c
  80017f:	68 14 23 80 00       	push   $0x802314
  800184:	e8 d8 05 00 00       	call   800761 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 5) panic("Extra or less pages are allocated in PageFile");
  800189:	e8 90 1a 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  80018e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800191:	83 f8 05             	cmp    $0x5,%eax
  800194:	74 14                	je     8001aa <_main+0x172>
  800196:	83 ec 04             	sub    $0x4,%esp
  800199:	68 98 23 80 00       	push   $0x802398
  80019e:	6a 1d                	push   $0x1d
  8001a0:	68 14 23 80 00       	push   $0x802314
  8001a5:	e8 b7 05 00 00       	call   800761 <_panic>

		//Allocate 30 KB
		freeFrames = sys_calculate_free_frames() ;
  8001aa:	e8 ec 19 00 00       	call   801b9b <sys_calculate_free_frames>
  8001af:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8001b2:	e8 67 1a 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  8001b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[2] = malloc(30 * kilo -kilo);
  8001ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001bd:	89 d0                	mov    %edx,%eax
  8001bf:	01 c0                	add    %eax,%eax
  8001c1:	01 d0                	add    %edx,%eax
  8001c3:	01 c0                	add    %eax,%eax
  8001c5:	01 d0                	add    %edx,%eax
  8001c7:	c1 e0 02             	shl    $0x2,%eax
  8001ca:	01 d0                	add    %edx,%eax
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	50                   	push   %eax
  8001d0:	e8 04 16 00 00       	call   8017d9 <malloc>
  8001d5:	83 c4 10             	add    $0x10,%esp
  8001d8:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 120 * kilo)) panic("Wrong start address for the allocated space... ");
  8001db:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001de:	89 c1                	mov    %eax,%ecx
  8001e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001e3:	89 d0                	mov    %edx,%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	01 d0                	add    %edx,%eax
  8001e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001f0:	01 d0                	add    %edx,%eax
  8001f2:	c1 e0 03             	shl    $0x3,%eax
  8001f5:	05 00 00 00 80       	add    $0x80000000,%eax
  8001fa:	39 c1                	cmp    %eax,%ecx
  8001fc:	74 14                	je     800212 <_main+0x1da>
  8001fe:	83 ec 04             	sub    $0x4,%esp
  800201:	68 e4 22 80 00       	push   $0x8022e4
  800206:	6a 23                	push   $0x23
  800208:	68 14 23 80 00       	push   $0x802314
  80020d:	e8 4f 05 00 00       	call   800761 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800212:	e8 84 19 00 00       	call   801b9b <sys_calculate_free_frames>
  800217:	89 c2                	mov    %eax,%edx
  800219:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80021c:	39 c2                	cmp    %eax,%edx
  80021e:	74 14                	je     800234 <_main+0x1fc>
  800220:	83 ec 04             	sub    $0x4,%esp
  800223:	68 2c 23 80 00       	push   $0x80232c
  800228:	6a 25                	push   $0x25
  80022a:	68 14 23 80 00       	push   $0x802314
  80022f:	e8 2d 05 00 00       	call   800761 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 8) panic("Extra or less pages are allocated in PageFile");
  800234:	e8 e5 19 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  800239:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80023c:	83 f8 08             	cmp    $0x8,%eax
  80023f:	74 14                	je     800255 <_main+0x21d>
  800241:	83 ec 04             	sub    $0x4,%esp
  800244:	68 98 23 80 00       	push   $0x802398
  800249:	6a 26                	push   $0x26
  80024b:	68 14 23 80 00       	push   $0x802314
  800250:	e8 0c 05 00 00       	call   800761 <_panic>

		//Allocate 40 KB
		freeFrames = sys_calculate_free_frames() ;
  800255:	e8 41 19 00 00       	call   801b9b <sys_calculate_free_frames>
  80025a:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80025d:	e8 bc 19 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  800262:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[3] = malloc(40 * kilo -kilo);
  800265:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800268:	89 d0                	mov    %edx,%eax
  80026a:	c1 e0 03             	shl    $0x3,%eax
  80026d:	01 d0                	add    %edx,%eax
  80026f:	01 c0                	add    %eax,%eax
  800271:	01 d0                	add    %edx,%eax
  800273:	01 c0                	add    %eax,%eax
  800275:	01 d0                	add    %edx,%eax
  800277:	83 ec 0c             	sub    $0xc,%esp
  80027a:	50                   	push   %eax
  80027b:	e8 59 15 00 00       	call   8017d9 <malloc>
  800280:	83 c4 10             	add    $0x10,%esp
  800283:	89 45 d0             	mov    %eax,-0x30(%ebp)
		if ((uint32) ptr_allocations[3] !=  (USER_HEAP_START + 152 * kilo)) panic("Wrong start address for the allocated space... ");
  800286:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800289:	89 c1                	mov    %eax,%ecx
  80028b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80028e:	89 d0                	mov    %edx,%eax
  800290:	c1 e0 03             	shl    $0x3,%eax
  800293:	01 d0                	add    %edx,%eax
  800295:	01 c0                	add    %eax,%eax
  800297:	01 d0                	add    %edx,%eax
  800299:	c1 e0 03             	shl    $0x3,%eax
  80029c:	05 00 00 00 80       	add    $0x80000000,%eax
  8002a1:	39 c1                	cmp    %eax,%ecx
  8002a3:	74 14                	je     8002b9 <_main+0x281>
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	68 e4 22 80 00       	push   $0x8022e4
  8002ad:	6a 2c                	push   $0x2c
  8002af:	68 14 23 80 00       	push   $0x802314
  8002b4:	e8 a8 04 00 00       	call   800761 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8002b9:	e8 dd 18 00 00       	call   801b9b <sys_calculate_free_frames>
  8002be:	89 c2                	mov    %eax,%edx
  8002c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002c3:	39 c2                	cmp    %eax,%edx
  8002c5:	74 14                	je     8002db <_main+0x2a3>
  8002c7:	83 ec 04             	sub    $0x4,%esp
  8002ca:	68 2c 23 80 00       	push   $0x80232c
  8002cf:	6a 2e                	push   $0x2e
  8002d1:	68 14 23 80 00       	push   $0x802314
  8002d6:	e8 86 04 00 00       	call   800761 <_panic>
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 10) panic("Extra or less pages are allocated in PageFile");
  8002db:	e8 3e 19 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  8002e0:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8002e3:	83 f8 0a             	cmp    $0xa,%eax
  8002e6:	74 14                	je     8002fc <_main+0x2c4>
  8002e8:	83 ec 04             	sub    $0x4,%esp
  8002eb:	68 98 23 80 00       	push   $0x802398
  8002f0:	6a 2f                	push   $0x2f
  8002f2:	68 14 23 80 00       	push   $0x802314
  8002f7:	e8 65 04 00 00       	call   800761 <_panic>


	}


	int cnt = 0;
  8002fc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	//[2] Test Re-allocation
	{
		/*Reallocate the first array (100 KB) to the last hole*/

		//Fill the first array with data
		int *intArr = (int*) ptr_allocations[0];
  800303:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800306:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;
  800309:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80030c:	89 d0                	mov    %edx,%eax
  80030e:	c1 e0 02             	shl    $0x2,%eax
  800311:	01 d0                	add    %edx,%eax
  800313:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80031a:	01 d0                	add    %edx,%eax
  80031c:	c1 e0 02             	shl    $0x2,%eax
  80031f:	c1 e8 02             	shr    $0x2,%eax
  800322:	48                   	dec    %eax
  800323:	89 45 d8             	mov    %eax,-0x28(%ebp)

		int i = 0;
  800326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for (i=0; i < lastIndexOfInt1 ; i++)
  80032d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800334:	eb 17                	jmp    80034d <_main+0x315>
		{
			intArr[i] = i ;
  800336:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800339:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800340:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800343:	01 c2                	add    %eax,%edx
  800345:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800348:	89 02                	mov    %eax,(%edx)
		//Fill the first array with data
		int *intArr = (int*) ptr_allocations[0];
		int lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;

		int i = 0;
		for (i=0; i < lastIndexOfInt1 ; i++)
  80034a:	ff 45 f4             	incl   -0xc(%ebp)
  80034d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800350:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800353:	7c e1                	jl     800336 <_main+0x2fe>
		{
			intArr[i] = i ;
		}

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
  800355:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800358:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;
  80035b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80035e:	89 d0                	mov    %edx,%eax
  800360:	c1 e0 02             	shl    $0x2,%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	c1 e0 02             	shl    $0x2,%eax
  800368:	c1 e8 02             	shr    $0x2,%eax
  80036b:	48                   	dec    %eax
  80036c:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  80036f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800376:	eb 17                	jmp    80038f <_main+0x357>
		{
			intArr[i] = i ;
  800378:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80037b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800382:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800385:	01 c2                	add    %eax,%edx
  800387:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80038a:	89 02                	mov    %eax,(%edx)

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  80038c:	ff 45 f4             	incl   -0xc(%ebp)
  80038f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800392:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800395:	7c e1                	jl     800378 <_main+0x340>
		{
			intArr[i] = i ;
		}

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
  800397:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80039a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;
  80039d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003a0:	89 d0                	mov    %edx,%eax
  8003a2:	01 c0                	add    %eax,%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ad:	01 d0                	add    %edx,%eax
  8003af:	01 c0                	add    %eax,%eax
  8003b1:	c1 e8 02             	shr    $0x2,%eax
  8003b4:	48                   	dec    %eax
  8003b5:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8003b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8003bf:	eb 17                	jmp    8003d8 <_main+0x3a0>
		{
			intArr[i] = i ;
  8003c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003ce:	01 c2                	add    %eax,%edx
  8003d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003d3:	89 02                	mov    %eax,(%edx)

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  8003d5:	ff 45 f4             	incl   -0xc(%ebp)
  8003d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003db:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8003de:	7c e1                	jl     8003c1 <_main+0x389>
		{
			intArr[i] = i ;
		}

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
  8003e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;
  8003e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003e9:	89 d0                	mov    %edx,%eax
  8003eb:	c1 e0 02             	shl    $0x2,%eax
  8003ee:	01 d0                	add    %edx,%eax
  8003f0:	c1 e0 03             	shl    $0x3,%eax
  8003f3:	c1 e8 02             	shr    $0x2,%eax
  8003f6:	48                   	dec    %eax
  8003f7:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8003fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800401:	eb 17                	jmp    80041a <_main+0x3e2>
		{
			intArr[i] = i ;
  800403:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800406:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800410:	01 c2                	add    %eax,%edx
  800412:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800415:	89 02                	mov    %eax,(%edx)

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  800417:	ff 45 f4             	incl   -0xc(%ebp)
  80041a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80041d:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800420:	7c e1                	jl     800403 <_main+0x3cb>
			intArr[i] = i ;
		}


		//Reallocate the first array to 200 KB [should be moved to after the fourth one]
		freeFrames = sys_calculate_free_frames() ;
  800422:	e8 74 17 00 00       	call   801b9b <sys_calculate_free_frames>
  800427:	89 45 e8             	mov    %eax,-0x18(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80042a:	e8 ef 17 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  80042f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		ptr_allocations[0] = realloc(ptr_allocations[0], 200 * kilo - kilo);
  800432:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800435:	89 d0                	mov    %edx,%eax
  800437:	01 c0                	add    %eax,%eax
  800439:	01 d0                	add    %edx,%eax
  80043b:	89 c1                	mov    %eax,%ecx
  80043d:	c1 e1 05             	shl    $0x5,%ecx
  800440:	01 c8                	add    %ecx,%eax
  800442:	01 c0                	add    %eax,%eax
  800444:	01 d0                	add    %edx,%eax
  800446:	89 c2                	mov    %eax,%edx
  800448:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80044b:	83 ec 08             	sub    $0x8,%esp
  80044e:	52                   	push   %edx
  80044f:	50                   	push   %eax
  800450:	e8 bd 15 00 00       	call   801a12 <realloc>
  800455:	83 c4 10             	add    $0x10,%esp
  800458:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		//[1] test return address & re-allocated space
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START + 192 * kilo)) panic("Wrong start address for the re-allocated space... ");
  80045b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80045e:	89 c1                	mov    %eax,%ecx
  800460:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800463:	89 d0                	mov    %edx,%eax
  800465:	01 c0                	add    %eax,%eax
  800467:	01 d0                	add    %edx,%eax
  800469:	c1 e0 06             	shl    $0x6,%eax
  80046c:	05 00 00 00 80       	add    $0x80000000,%eax
  800471:	39 c1                	cmp    %eax,%ecx
  800473:	74 14                	je     800489 <_main+0x451>
  800475:	83 ec 04             	sub    $0x4,%esp
  800478:	68 c8 23 80 00       	push   $0x8023c8
  80047d:	6a 6b                	push   $0x6b
  80047f:	68 14 23 80 00       	push   $0x802314
  800484:	e8 d8 02 00 00       	call   800761 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong re-allocation");
		//if((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong re-allocation: either extra pages are re-allocated in memory or pages not allocated correctly on PageFile");
		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 25) panic("Extra or less pages are re-allocated in PageFile");
  800489:	e8 90 17 00 00       	call   801c1e <sys_pf_calculate_allocated_pages>
  80048e:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800491:	83 f8 19             	cmp    $0x19,%eax
  800494:	74 14                	je     8004aa <_main+0x472>
  800496:	83 ec 04             	sub    $0x4,%esp
  800499:	68 fc 23 80 00       	push   $0x8023fc
  80049e:	6a 6e                	push   $0x6e
  8004a0:	68 14 23 80 00       	push   $0x802314
  8004a5:	e8 b7 02 00 00       	call   800761 <_panic>


		vcprintf("\b\b\b50%", NULL);
  8004aa:	83 ec 08             	sub    $0x8,%esp
  8004ad:	6a 00                	push   $0x0
  8004af:	68 2d 24 80 00       	push   $0x80242d
  8004b4:	e8 f1 04 00 00       	call   8009aa <vcprintf>
  8004b9:	83 c4 10             	add    $0x10,%esp

		//Fill the first array with data
		intArr = (int*) ptr_allocations[0];
  8004bc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8004bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;
  8004c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8004c5:	89 d0                	mov    %edx,%eax
  8004c7:	c1 e0 02             	shl    $0x2,%eax
  8004ca:	01 d0                	add    %edx,%eax
  8004cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d3:	01 d0                	add    %edx,%eax
  8004d5:	c1 e0 02             	shl    $0x2,%eax
  8004d8:	c1 e8 02             	shr    $0x2,%eax
  8004db:	48                   	dec    %eax
  8004dc:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8004df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e6:	eb 2d                	jmp    800515 <_main+0x4dd>
		{
			if(intArr[i] != i)
  8004e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f5:	01 d0                	add    %edx,%eax
  8004f7:	8b 00                	mov    (%eax),%eax
  8004f9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004fc:	74 14                	je     800512 <_main+0x4da>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  8004fe:	83 ec 04             	sub    $0x4,%esp
  800501:	68 34 24 80 00       	push   $0x802434
  800506:	6a 7a                	push   $0x7a
  800508:	68 14 23 80 00       	push   $0x802314
  80050d:	e8 4f 02 00 00       	call   800761 <_panic>

		//Fill the first array with data
		intArr = (int*) ptr_allocations[0];
		lastIndexOfInt1 = (100*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  800512:	ff 45 f4             	incl   -0xc(%ebp)
  800515:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800518:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  80051b:	7c cb                	jl     8004e8 <_main+0x4b0>
			if(intArr[i] != i)
				panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
  80051d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800520:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;
  800523:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800526:	89 d0                	mov    %edx,%eax
  800528:	c1 e0 02             	shl    $0x2,%eax
  80052b:	01 d0                	add    %edx,%eax
  80052d:	c1 e0 02             	shl    $0x2,%eax
  800530:	c1 e8 02             	shr    $0x2,%eax
  800533:	48                   	dec    %eax
  800534:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  800537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80053e:	eb 30                	jmp    800570 <_main+0x538>
		{
			if(intArr[i] != i)
  800540:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800543:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054d:	01 d0                	add    %edx,%eax
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800554:	74 17                	je     80056d <_main+0x535>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800556:	83 ec 04             	sub    $0x4,%esp
  800559:	68 34 24 80 00       	push   $0x802434
  80055e:	68 84 00 00 00       	push   $0x84
  800563:	68 14 23 80 00       	push   $0x802314
  800568:	e8 f4 01 00 00       	call   800761 <_panic>

		//Fill the second array with data
		intArr = (int*) ptr_allocations[1];
		lastIndexOfInt1 = (20*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  80056d:	ff 45 f4             	incl   -0xc(%ebp)
  800570:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800573:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800576:	7c c8                	jl     800540 <_main+0x508>
			if(intArr[i] != i)
				panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
  800578:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80057b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;
  80057e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800581:	89 d0                	mov    %edx,%eax
  800583:	01 c0                	add    %eax,%eax
  800585:	01 d0                	add    %edx,%eax
  800587:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80058e:	01 d0                	add    %edx,%eax
  800590:	01 c0                	add    %eax,%eax
  800592:	c1 e8 02             	shr    $0x2,%eax
  800595:	48                   	dec    %eax
  800596:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  800599:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005a0:	eb 30                	jmp    8005d2 <_main+0x59a>
		{
			if(intArr[i] != i)
  8005a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005b6:	74 17                	je     8005cf <_main+0x597>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  8005b8:	83 ec 04             	sub    $0x4,%esp
  8005bb:	68 34 24 80 00       	push   $0x802434
  8005c0:	68 8e 00 00 00       	push   $0x8e
  8005c5:	68 14 23 80 00       	push   $0x802314
  8005ca:	e8 92 01 00 00       	call   800761 <_panic>

		//Fill the third array with data
		intArr = (int*) ptr_allocations[2];
		lastIndexOfInt1 = (30*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  8005cf:	ff 45 f4             	incl   -0xc(%ebp)
  8005d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005d5:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8005d8:	7c c8                	jl     8005a2 <_main+0x56a>
			if(intArr[i] != i)
				panic("Wrong re-allocation: stored values are wrongly changed!");
		}

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
  8005da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8005dd:	89 45 dc             	mov    %eax,-0x24(%ebp)
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;
  8005e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8005e3:	89 d0                	mov    %edx,%eax
  8005e5:	c1 e0 02             	shl    $0x2,%eax
  8005e8:	01 d0                	add    %edx,%eax
  8005ea:	c1 e0 03             	shl    $0x3,%eax
  8005ed:	c1 e8 02             	shr    $0x2,%eax
  8005f0:	48                   	dec    %eax
  8005f1:	89 45 d8             	mov    %eax,-0x28(%ebp)

		for (i=0; i < lastIndexOfInt1 ; i++)
  8005f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005fb:	eb 30                	jmp    80062d <_main+0x5f5>
		{
			if(intArr[i] != i)
  8005fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800600:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800607:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80060a:	01 d0                	add    %edx,%eax
  80060c:	8b 00                	mov    (%eax),%eax
  80060e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800611:	74 17                	je     80062a <_main+0x5f2>
				panic("Wrong re-allocation: stored values are wrongly changed!");
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 34 24 80 00       	push   $0x802434
  80061b:	68 98 00 00 00       	push   $0x98
  800620:	68 14 23 80 00       	push   $0x802314
  800625:	e8 37 01 00 00       	call   800761 <_panic>

		//Fill the fourth array with data
		intArr = (int*) ptr_allocations[3];
		lastIndexOfInt1 = (40*kilo)/sizeof(int) - 1;

		for (i=0; i < lastIndexOfInt1 ; i++)
  80062a:	ff 45 f4             	incl   -0xc(%ebp)
  80062d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800630:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800633:	7c c8                	jl     8005fd <_main+0x5c5>
				panic("Wrong re-allocation: stored values are wrongly changed!");

		}


		vcprintf("\b\b\b100%\n", NULL);
  800635:	83 ec 08             	sub    $0x8,%esp
  800638:	6a 00                	push   $0x0
  80063a:	68 6c 24 80 00       	push   $0x80246c
  80063f:	e8 66 03 00 00       	call   8009aa <vcprintf>
  800644:	83 c4 10             	add    $0x10,%esp
	}



	cprintf("Congratulations!! test realloc [3] completed successfully.\n");
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	68 78 24 80 00       	push   $0x802478
  80064f:	e8 c1 03 00 00       	call   800a15 <cprintf>
  800654:	83 c4 10             	add    $0x10,%esp

	return;
  800657:	90                   	nop
}
  800658:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80065b:	5b                   	pop    %ebx
  80065c:	5f                   	pop    %edi
  80065d:	5d                   	pop    %ebp
  80065e:	c3                   	ret    

0080065f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80065f:	55                   	push   %ebp
  800660:	89 e5                	mov    %esp,%ebp
  800662:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800665:	e8 66 14 00 00       	call   801ad0 <sys_getenvindex>
  80066a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80066d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800670:	89 d0                	mov    %edx,%eax
  800672:	01 c0                	add    %eax,%eax
  800674:	01 d0                	add    %edx,%eax
  800676:	c1 e0 02             	shl    $0x2,%eax
  800679:	01 d0                	add    %edx,%eax
  80067b:	c1 e0 06             	shl    $0x6,%eax
  80067e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800683:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800688:	a1 20 30 80 00       	mov    0x803020,%eax
  80068d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800693:	84 c0                	test   %al,%al
  800695:	74 0f                	je     8006a6 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800697:	a1 20 30 80 00       	mov    0x803020,%eax
  80069c:	05 f4 02 00 00       	add    $0x2f4,%eax
  8006a1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006aa:	7e 0a                	jle    8006b6 <libmain+0x57>
		binaryname = argv[0];
  8006ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006af:	8b 00                	mov    (%eax),%eax
  8006b1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006b6:	83 ec 08             	sub    $0x8,%esp
  8006b9:	ff 75 0c             	pushl  0xc(%ebp)
  8006bc:	ff 75 08             	pushl  0x8(%ebp)
  8006bf:	e8 74 f9 ff ff       	call   800038 <_main>
  8006c4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006c7:	e8 9f 15 00 00       	call   801c6b <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006cc:	83 ec 0c             	sub    $0xc,%esp
  8006cf:	68 cc 24 80 00       	push   $0x8024cc
  8006d4:	e8 3c 03 00 00       	call   800a15 <cprintf>
  8006d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e1:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ec:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006f2:	83 ec 04             	sub    $0x4,%esp
  8006f5:	52                   	push   %edx
  8006f6:	50                   	push   %eax
  8006f7:	68 f4 24 80 00       	push   $0x8024f4
  8006fc:	e8 14 03 00 00       	call   800a15 <cprintf>
  800701:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800704:	a1 20 30 80 00       	mov    0x803020,%eax
  800709:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  80070f:	83 ec 08             	sub    $0x8,%esp
  800712:	50                   	push   %eax
  800713:	68 19 25 80 00       	push   $0x802519
  800718:	e8 f8 02 00 00       	call   800a15 <cprintf>
  80071d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800720:	83 ec 0c             	sub    $0xc,%esp
  800723:	68 cc 24 80 00       	push   $0x8024cc
  800728:	e8 e8 02 00 00       	call   800a15 <cprintf>
  80072d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800730:	e8 50 15 00 00       	call   801c85 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800735:	e8 19 00 00 00       	call   800753 <exit>
}
  80073a:	90                   	nop
  80073b:	c9                   	leave  
  80073c:	c3                   	ret    

0080073d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80073d:	55                   	push   %ebp
  80073e:	89 e5                	mov    %esp,%ebp
  800740:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800743:	83 ec 0c             	sub    $0xc,%esp
  800746:	6a 00                	push   $0x0
  800748:	e8 4f 13 00 00       	call   801a9c <sys_env_destroy>
  80074d:	83 c4 10             	add    $0x10,%esp
}
  800750:	90                   	nop
  800751:	c9                   	leave  
  800752:	c3                   	ret    

00800753 <exit>:

void
exit(void)
{
  800753:	55                   	push   %ebp
  800754:	89 e5                	mov    %esp,%ebp
  800756:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800759:	e8 a4 13 00 00       	call   801b02 <sys_env_exit>
}
  80075e:	90                   	nop
  80075f:	c9                   	leave  
  800760:	c3                   	ret    

00800761 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800761:	55                   	push   %ebp
  800762:	89 e5                	mov    %esp,%ebp
  800764:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800767:	8d 45 10             	lea    0x10(%ebp),%eax
  80076a:	83 c0 04             	add    $0x4,%eax
  80076d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800770:	a1 30 30 80 00       	mov    0x803030,%eax
  800775:	85 c0                	test   %eax,%eax
  800777:	74 16                	je     80078f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800779:	a1 30 30 80 00       	mov    0x803030,%eax
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	50                   	push   %eax
  800782:	68 30 25 80 00       	push   $0x802530
  800787:	e8 89 02 00 00       	call   800a15 <cprintf>
  80078c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80078f:	a1 00 30 80 00       	mov    0x803000,%eax
  800794:	ff 75 0c             	pushl  0xc(%ebp)
  800797:	ff 75 08             	pushl  0x8(%ebp)
  80079a:	50                   	push   %eax
  80079b:	68 35 25 80 00       	push   $0x802535
  8007a0:	e8 70 02 00 00       	call   800a15 <cprintf>
  8007a5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b1:	50                   	push   %eax
  8007b2:	e8 f3 01 00 00       	call   8009aa <vcprintf>
  8007b7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007ba:	83 ec 08             	sub    $0x8,%esp
  8007bd:	6a 00                	push   $0x0
  8007bf:	68 51 25 80 00       	push   $0x802551
  8007c4:	e8 e1 01 00 00       	call   8009aa <vcprintf>
  8007c9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007cc:	e8 82 ff ff ff       	call   800753 <exit>

	// should not return here
	while (1) ;
  8007d1:	eb fe                	jmp    8007d1 <_panic+0x70>

008007d3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007d3:	55                   	push   %ebp
  8007d4:	89 e5                	mov    %esp,%ebp
  8007d6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007de:	8b 50 74             	mov    0x74(%eax),%edx
  8007e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e4:	39 c2                	cmp    %eax,%edx
  8007e6:	74 14                	je     8007fc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007e8:	83 ec 04             	sub    $0x4,%esp
  8007eb:	68 54 25 80 00       	push   $0x802554
  8007f0:	6a 26                	push   $0x26
  8007f2:	68 a0 25 80 00       	push   $0x8025a0
  8007f7:	e8 65 ff ff ff       	call   800761 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800803:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80080a:	e9 c2 00 00 00       	jmp    8008d1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80080f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800812:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	01 d0                	add    %edx,%eax
  80081e:	8b 00                	mov    (%eax),%eax
  800820:	85 c0                	test   %eax,%eax
  800822:	75 08                	jne    80082c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800824:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800827:	e9 a2 00 00 00       	jmp    8008ce <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80082c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800833:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80083a:	eb 69                	jmp    8008a5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80083c:	a1 20 30 80 00       	mov    0x803020,%eax
  800841:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800847:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80084a:	89 d0                	mov    %edx,%eax
  80084c:	01 c0                	add    %eax,%eax
  80084e:	01 d0                	add    %edx,%eax
  800850:	c1 e0 02             	shl    $0x2,%eax
  800853:	01 c8                	add    %ecx,%eax
  800855:	8a 40 04             	mov    0x4(%eax),%al
  800858:	84 c0                	test   %al,%al
  80085a:	75 46                	jne    8008a2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80085c:	a1 20 30 80 00       	mov    0x803020,%eax
  800861:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800867:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80086a:	89 d0                	mov    %edx,%eax
  80086c:	01 c0                	add    %eax,%eax
  80086e:	01 d0                	add    %edx,%eax
  800870:	c1 e0 02             	shl    $0x2,%eax
  800873:	01 c8                	add    %ecx,%eax
  800875:	8b 00                	mov    (%eax),%eax
  800877:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80087a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80087d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800882:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800884:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800887:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80088e:	8b 45 08             	mov    0x8(%ebp),%eax
  800891:	01 c8                	add    %ecx,%eax
  800893:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800895:	39 c2                	cmp    %eax,%edx
  800897:	75 09                	jne    8008a2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800899:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008a0:	eb 12                	jmp    8008b4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a2:	ff 45 e8             	incl   -0x18(%ebp)
  8008a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8008aa:	8b 50 74             	mov    0x74(%eax),%edx
  8008ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008b0:	39 c2                	cmp    %eax,%edx
  8008b2:	77 88                	ja     80083c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008b8:	75 14                	jne    8008ce <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008ba:	83 ec 04             	sub    $0x4,%esp
  8008bd:	68 ac 25 80 00       	push   $0x8025ac
  8008c2:	6a 3a                	push   $0x3a
  8008c4:	68 a0 25 80 00       	push   $0x8025a0
  8008c9:	e8 93 fe ff ff       	call   800761 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008ce:	ff 45 f0             	incl   -0x10(%ebp)
  8008d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008d7:	0f 8c 32 ff ff ff    	jl     80080f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008eb:	eb 26                	jmp    800913 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8008f2:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008fb:	89 d0                	mov    %edx,%eax
  8008fd:	01 c0                	add    %eax,%eax
  8008ff:	01 d0                	add    %edx,%eax
  800901:	c1 e0 02             	shl    $0x2,%eax
  800904:	01 c8                	add    %ecx,%eax
  800906:	8a 40 04             	mov    0x4(%eax),%al
  800909:	3c 01                	cmp    $0x1,%al
  80090b:	75 03                	jne    800910 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80090d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800910:	ff 45 e0             	incl   -0x20(%ebp)
  800913:	a1 20 30 80 00       	mov    0x803020,%eax
  800918:	8b 50 74             	mov    0x74(%eax),%edx
  80091b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091e:	39 c2                	cmp    %eax,%edx
  800920:	77 cb                	ja     8008ed <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800922:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800925:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800928:	74 14                	je     80093e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80092a:	83 ec 04             	sub    $0x4,%esp
  80092d:	68 00 26 80 00       	push   $0x802600
  800932:	6a 44                	push   $0x44
  800934:	68 a0 25 80 00       	push   $0x8025a0
  800939:	e8 23 fe ff ff       	call   800761 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80093e:	90                   	nop
  80093f:	c9                   	leave  
  800940:	c3                   	ret    

00800941 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800941:	55                   	push   %ebp
  800942:	89 e5                	mov    %esp,%ebp
  800944:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800947:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094a:	8b 00                	mov    (%eax),%eax
  80094c:	8d 48 01             	lea    0x1(%eax),%ecx
  80094f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800952:	89 0a                	mov    %ecx,(%edx)
  800954:	8b 55 08             	mov    0x8(%ebp),%edx
  800957:	88 d1                	mov    %dl,%cl
  800959:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	8b 00                	mov    (%eax),%eax
  800965:	3d ff 00 00 00       	cmp    $0xff,%eax
  80096a:	75 2c                	jne    800998 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80096c:	a0 24 30 80 00       	mov    0x803024,%al
  800971:	0f b6 c0             	movzbl %al,%eax
  800974:	8b 55 0c             	mov    0xc(%ebp),%edx
  800977:	8b 12                	mov    (%edx),%edx
  800979:	89 d1                	mov    %edx,%ecx
  80097b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80097e:	83 c2 08             	add    $0x8,%edx
  800981:	83 ec 04             	sub    $0x4,%esp
  800984:	50                   	push   %eax
  800985:	51                   	push   %ecx
  800986:	52                   	push   %edx
  800987:	e8 ce 10 00 00       	call   801a5a <sys_cputs>
  80098c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80098f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800992:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800998:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099b:	8b 40 04             	mov    0x4(%eax),%eax
  80099e:	8d 50 01             	lea    0x1(%eax),%edx
  8009a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009a7:	90                   	nop
  8009a8:	c9                   	leave  
  8009a9:	c3                   	ret    

008009aa <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009aa:	55                   	push   %ebp
  8009ab:	89 e5                	mov    %esp,%ebp
  8009ad:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009b3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009ba:	00 00 00 
	b.cnt = 0;
  8009bd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009c4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009c7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ca:	ff 75 08             	pushl  0x8(%ebp)
  8009cd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009d3:	50                   	push   %eax
  8009d4:	68 41 09 80 00       	push   $0x800941
  8009d9:	e8 11 02 00 00       	call   800bef <vprintfmt>
  8009de:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009e1:	a0 24 30 80 00       	mov    0x803024,%al
  8009e6:	0f b6 c0             	movzbl %al,%eax
  8009e9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ef:	83 ec 04             	sub    $0x4,%esp
  8009f2:	50                   	push   %eax
  8009f3:	52                   	push   %edx
  8009f4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009fa:	83 c0 08             	add    $0x8,%eax
  8009fd:	50                   	push   %eax
  8009fe:	e8 57 10 00 00       	call   801a5a <sys_cputs>
  800a03:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a06:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800a0d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a13:	c9                   	leave  
  800a14:	c3                   	ret    

00800a15 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a15:	55                   	push   %ebp
  800a16:	89 e5                	mov    %esp,%ebp
  800a18:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a1b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800a22:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a25:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	83 ec 08             	sub    $0x8,%esp
  800a2e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a31:	50                   	push   %eax
  800a32:	e8 73 ff ff ff       	call   8009aa <vcprintf>
  800a37:	83 c4 10             	add    $0x10,%esp
  800a3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a40:	c9                   	leave  
  800a41:	c3                   	ret    

00800a42 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a42:	55                   	push   %ebp
  800a43:	89 e5                	mov    %esp,%ebp
  800a45:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a48:	e8 1e 12 00 00       	call   801c6b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a4d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a50:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a53:	8b 45 08             	mov    0x8(%ebp),%eax
  800a56:	83 ec 08             	sub    $0x8,%esp
  800a59:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5c:	50                   	push   %eax
  800a5d:	e8 48 ff ff ff       	call   8009aa <vcprintf>
  800a62:	83 c4 10             	add    $0x10,%esp
  800a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a68:	e8 18 12 00 00       	call   801c85 <sys_enable_interrupt>
	return cnt;
  800a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a70:	c9                   	leave  
  800a71:	c3                   	ret    

00800a72 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a72:	55                   	push   %ebp
  800a73:	89 e5                	mov    %esp,%ebp
  800a75:	53                   	push   %ebx
  800a76:	83 ec 14             	sub    $0x14,%esp
  800a79:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a82:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a85:	8b 45 18             	mov    0x18(%ebp),%eax
  800a88:	ba 00 00 00 00       	mov    $0x0,%edx
  800a8d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a90:	77 55                	ja     800ae7 <printnum+0x75>
  800a92:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a95:	72 05                	jb     800a9c <printnum+0x2a>
  800a97:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a9a:	77 4b                	ja     800ae7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a9c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a9f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aa2:	8b 45 18             	mov    0x18(%ebp),%eax
  800aa5:	ba 00 00 00 00       	mov    $0x0,%edx
  800aaa:	52                   	push   %edx
  800aab:	50                   	push   %eax
  800aac:	ff 75 f4             	pushl  -0xc(%ebp)
  800aaf:	ff 75 f0             	pushl  -0x10(%ebp)
  800ab2:	e8 95 15 00 00       	call   80204c <__udivdi3>
  800ab7:	83 c4 10             	add    $0x10,%esp
  800aba:	83 ec 04             	sub    $0x4,%esp
  800abd:	ff 75 20             	pushl  0x20(%ebp)
  800ac0:	53                   	push   %ebx
  800ac1:	ff 75 18             	pushl  0x18(%ebp)
  800ac4:	52                   	push   %edx
  800ac5:	50                   	push   %eax
  800ac6:	ff 75 0c             	pushl  0xc(%ebp)
  800ac9:	ff 75 08             	pushl  0x8(%ebp)
  800acc:	e8 a1 ff ff ff       	call   800a72 <printnum>
  800ad1:	83 c4 20             	add    $0x20,%esp
  800ad4:	eb 1a                	jmp    800af0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	ff 75 20             	pushl  0x20(%ebp)
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	ff d0                	call   *%eax
  800ae4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ae7:	ff 4d 1c             	decl   0x1c(%ebp)
  800aea:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aee:	7f e6                	jg     800ad6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800af0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800af3:	bb 00 00 00 00       	mov    $0x0,%ebx
  800af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800afe:	53                   	push   %ebx
  800aff:	51                   	push   %ecx
  800b00:	52                   	push   %edx
  800b01:	50                   	push   %eax
  800b02:	e8 55 16 00 00       	call   80215c <__umoddi3>
  800b07:	83 c4 10             	add    $0x10,%esp
  800b0a:	05 74 28 80 00       	add    $0x802874,%eax
  800b0f:	8a 00                	mov    (%eax),%al
  800b11:	0f be c0             	movsbl %al,%eax
  800b14:	83 ec 08             	sub    $0x8,%esp
  800b17:	ff 75 0c             	pushl  0xc(%ebp)
  800b1a:	50                   	push   %eax
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	ff d0                	call   *%eax
  800b20:	83 c4 10             	add    $0x10,%esp
}
  800b23:	90                   	nop
  800b24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b27:	c9                   	leave  
  800b28:	c3                   	ret    

00800b29 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b29:	55                   	push   %ebp
  800b2a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b2c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b30:	7e 1c                	jle    800b4e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	8d 50 08             	lea    0x8(%eax),%edx
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	89 10                	mov    %edx,(%eax)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	83 e8 08             	sub    $0x8,%eax
  800b47:	8b 50 04             	mov    0x4(%eax),%edx
  800b4a:	8b 00                	mov    (%eax),%eax
  800b4c:	eb 40                	jmp    800b8e <getuint+0x65>
	else if (lflag)
  800b4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b52:	74 1e                	je     800b72 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	8b 00                	mov    (%eax),%eax
  800b59:	8d 50 04             	lea    0x4(%eax),%edx
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	89 10                	mov    %edx,(%eax)
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	8b 00                	mov    (%eax),%eax
  800b66:	83 e8 04             	sub    $0x4,%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b70:	eb 1c                	jmp    800b8e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	8b 00                	mov    (%eax),%eax
  800b77:	8d 50 04             	lea    0x4(%eax),%edx
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	89 10                	mov    %edx,(%eax)
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	83 e8 04             	sub    $0x4,%eax
  800b87:	8b 00                	mov    (%eax),%eax
  800b89:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b8e:	5d                   	pop    %ebp
  800b8f:	c3                   	ret    

00800b90 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b90:	55                   	push   %ebp
  800b91:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b93:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b97:	7e 1c                	jle    800bb5 <getint+0x25>
		return va_arg(*ap, long long);
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	8b 00                	mov    (%eax),%eax
  800b9e:	8d 50 08             	lea    0x8(%eax),%edx
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	89 10                	mov    %edx,(%eax)
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	8b 00                	mov    (%eax),%eax
  800bab:	83 e8 08             	sub    $0x8,%eax
  800bae:	8b 50 04             	mov    0x4(%eax),%edx
  800bb1:	8b 00                	mov    (%eax),%eax
  800bb3:	eb 38                	jmp    800bed <getint+0x5d>
	else if (lflag)
  800bb5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bb9:	74 1a                	je     800bd5 <getint+0x45>
		return va_arg(*ap, long);
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	8b 00                	mov    (%eax),%eax
  800bc0:	8d 50 04             	lea    0x4(%eax),%edx
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	89 10                	mov    %edx,(%eax)
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8b 00                	mov    (%eax),%eax
  800bcd:	83 e8 04             	sub    $0x4,%eax
  800bd0:	8b 00                	mov    (%eax),%eax
  800bd2:	99                   	cltd   
  800bd3:	eb 18                	jmp    800bed <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	8d 50 04             	lea    0x4(%eax),%edx
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	89 10                	mov    %edx,(%eax)
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	8b 00                	mov    (%eax),%eax
  800be7:	83 e8 04             	sub    $0x4,%eax
  800bea:	8b 00                	mov    (%eax),%eax
  800bec:	99                   	cltd   
}
  800bed:	5d                   	pop    %ebp
  800bee:	c3                   	ret    

00800bef <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bef:	55                   	push   %ebp
  800bf0:	89 e5                	mov    %esp,%ebp
  800bf2:	56                   	push   %esi
  800bf3:	53                   	push   %ebx
  800bf4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bf7:	eb 17                	jmp    800c10 <vprintfmt+0x21>
			if (ch == '\0')
  800bf9:	85 db                	test   %ebx,%ebx
  800bfb:	0f 84 af 03 00 00    	je     800fb0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c01:	83 ec 08             	sub    $0x8,%esp
  800c04:	ff 75 0c             	pushl  0xc(%ebp)
  800c07:	53                   	push   %ebx
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	ff d0                	call   *%eax
  800c0d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c10:	8b 45 10             	mov    0x10(%ebp),%eax
  800c13:	8d 50 01             	lea    0x1(%eax),%edx
  800c16:	89 55 10             	mov    %edx,0x10(%ebp)
  800c19:	8a 00                	mov    (%eax),%al
  800c1b:	0f b6 d8             	movzbl %al,%ebx
  800c1e:	83 fb 25             	cmp    $0x25,%ebx
  800c21:	75 d6                	jne    800bf9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c23:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c27:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c2e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c35:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c3c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c43:	8b 45 10             	mov    0x10(%ebp),%eax
  800c46:	8d 50 01             	lea    0x1(%eax),%edx
  800c49:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4c:	8a 00                	mov    (%eax),%al
  800c4e:	0f b6 d8             	movzbl %al,%ebx
  800c51:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c54:	83 f8 55             	cmp    $0x55,%eax
  800c57:	0f 87 2b 03 00 00    	ja     800f88 <vprintfmt+0x399>
  800c5d:	8b 04 85 98 28 80 00 	mov    0x802898(,%eax,4),%eax
  800c64:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c66:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c6a:	eb d7                	jmp    800c43 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c6c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c70:	eb d1                	jmp    800c43 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c72:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c79:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c7c:	89 d0                	mov    %edx,%eax
  800c7e:	c1 e0 02             	shl    $0x2,%eax
  800c81:	01 d0                	add    %edx,%eax
  800c83:	01 c0                	add    %eax,%eax
  800c85:	01 d8                	add    %ebx,%eax
  800c87:	83 e8 30             	sub    $0x30,%eax
  800c8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c95:	83 fb 2f             	cmp    $0x2f,%ebx
  800c98:	7e 3e                	jle    800cd8 <vprintfmt+0xe9>
  800c9a:	83 fb 39             	cmp    $0x39,%ebx
  800c9d:	7f 39                	jg     800cd8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c9f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ca2:	eb d5                	jmp    800c79 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ca4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca7:	83 c0 04             	add    $0x4,%eax
  800caa:	89 45 14             	mov    %eax,0x14(%ebp)
  800cad:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb0:	83 e8 04             	sub    $0x4,%eax
  800cb3:	8b 00                	mov    (%eax),%eax
  800cb5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cb8:	eb 1f                	jmp    800cd9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cbe:	79 83                	jns    800c43 <vprintfmt+0x54>
				width = 0;
  800cc0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cc7:	e9 77 ff ff ff       	jmp    800c43 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ccc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cd3:	e9 6b ff ff ff       	jmp    800c43 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cd8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cd9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cdd:	0f 89 60 ff ff ff    	jns    800c43 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ce3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ce6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ce9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cf0:	e9 4e ff ff ff       	jmp    800c43 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cf5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cf8:	e9 46 ff ff ff       	jmp    800c43 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cfd:	8b 45 14             	mov    0x14(%ebp),%eax
  800d00:	83 c0 04             	add    $0x4,%eax
  800d03:	89 45 14             	mov    %eax,0x14(%ebp)
  800d06:	8b 45 14             	mov    0x14(%ebp),%eax
  800d09:	83 e8 04             	sub    $0x4,%eax
  800d0c:	8b 00                	mov    (%eax),%eax
  800d0e:	83 ec 08             	sub    $0x8,%esp
  800d11:	ff 75 0c             	pushl  0xc(%ebp)
  800d14:	50                   	push   %eax
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	ff d0                	call   *%eax
  800d1a:	83 c4 10             	add    $0x10,%esp
			break;
  800d1d:	e9 89 02 00 00       	jmp    800fab <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d22:	8b 45 14             	mov    0x14(%ebp),%eax
  800d25:	83 c0 04             	add    $0x4,%eax
  800d28:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2e:	83 e8 04             	sub    $0x4,%eax
  800d31:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d33:	85 db                	test   %ebx,%ebx
  800d35:	79 02                	jns    800d39 <vprintfmt+0x14a>
				err = -err;
  800d37:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d39:	83 fb 64             	cmp    $0x64,%ebx
  800d3c:	7f 0b                	jg     800d49 <vprintfmt+0x15a>
  800d3e:	8b 34 9d e0 26 80 00 	mov    0x8026e0(,%ebx,4),%esi
  800d45:	85 f6                	test   %esi,%esi
  800d47:	75 19                	jne    800d62 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d49:	53                   	push   %ebx
  800d4a:	68 85 28 80 00       	push   $0x802885
  800d4f:	ff 75 0c             	pushl  0xc(%ebp)
  800d52:	ff 75 08             	pushl  0x8(%ebp)
  800d55:	e8 5e 02 00 00       	call   800fb8 <printfmt>
  800d5a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d5d:	e9 49 02 00 00       	jmp    800fab <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d62:	56                   	push   %esi
  800d63:	68 8e 28 80 00       	push   $0x80288e
  800d68:	ff 75 0c             	pushl  0xc(%ebp)
  800d6b:	ff 75 08             	pushl  0x8(%ebp)
  800d6e:	e8 45 02 00 00       	call   800fb8 <printfmt>
  800d73:	83 c4 10             	add    $0x10,%esp
			break;
  800d76:	e9 30 02 00 00       	jmp    800fab <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d7b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7e:	83 c0 04             	add    $0x4,%eax
  800d81:	89 45 14             	mov    %eax,0x14(%ebp)
  800d84:	8b 45 14             	mov    0x14(%ebp),%eax
  800d87:	83 e8 04             	sub    $0x4,%eax
  800d8a:	8b 30                	mov    (%eax),%esi
  800d8c:	85 f6                	test   %esi,%esi
  800d8e:	75 05                	jne    800d95 <vprintfmt+0x1a6>
				p = "(null)";
  800d90:	be 91 28 80 00       	mov    $0x802891,%esi
			if (width > 0 && padc != '-')
  800d95:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d99:	7e 6d                	jle    800e08 <vprintfmt+0x219>
  800d9b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d9f:	74 67                	je     800e08 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800da1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800da4:	83 ec 08             	sub    $0x8,%esp
  800da7:	50                   	push   %eax
  800da8:	56                   	push   %esi
  800da9:	e8 0c 03 00 00       	call   8010ba <strnlen>
  800dae:	83 c4 10             	add    $0x10,%esp
  800db1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800db4:	eb 16                	jmp    800dcc <vprintfmt+0x1dd>
					putch(padc, putdat);
  800db6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dba:	83 ec 08             	sub    $0x8,%esp
  800dbd:	ff 75 0c             	pushl  0xc(%ebp)
  800dc0:	50                   	push   %eax
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	ff d0                	call   *%eax
  800dc6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dc9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dcc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd0:	7f e4                	jg     800db6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dd2:	eb 34                	jmp    800e08 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dd4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dd8:	74 1c                	je     800df6 <vprintfmt+0x207>
  800dda:	83 fb 1f             	cmp    $0x1f,%ebx
  800ddd:	7e 05                	jle    800de4 <vprintfmt+0x1f5>
  800ddf:	83 fb 7e             	cmp    $0x7e,%ebx
  800de2:	7e 12                	jle    800df6 <vprintfmt+0x207>
					putch('?', putdat);
  800de4:	83 ec 08             	sub    $0x8,%esp
  800de7:	ff 75 0c             	pushl  0xc(%ebp)
  800dea:	6a 3f                	push   $0x3f
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	ff d0                	call   *%eax
  800df1:	83 c4 10             	add    $0x10,%esp
  800df4:	eb 0f                	jmp    800e05 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800df6:	83 ec 08             	sub    $0x8,%esp
  800df9:	ff 75 0c             	pushl  0xc(%ebp)
  800dfc:	53                   	push   %ebx
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	ff d0                	call   *%eax
  800e02:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e05:	ff 4d e4             	decl   -0x1c(%ebp)
  800e08:	89 f0                	mov    %esi,%eax
  800e0a:	8d 70 01             	lea    0x1(%eax),%esi
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	0f be d8             	movsbl %al,%ebx
  800e12:	85 db                	test   %ebx,%ebx
  800e14:	74 24                	je     800e3a <vprintfmt+0x24b>
  800e16:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e1a:	78 b8                	js     800dd4 <vprintfmt+0x1e5>
  800e1c:	ff 4d e0             	decl   -0x20(%ebp)
  800e1f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e23:	79 af                	jns    800dd4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e25:	eb 13                	jmp    800e3a <vprintfmt+0x24b>
				putch(' ', putdat);
  800e27:	83 ec 08             	sub    $0x8,%esp
  800e2a:	ff 75 0c             	pushl  0xc(%ebp)
  800e2d:	6a 20                	push   $0x20
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	ff d0                	call   *%eax
  800e34:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e37:	ff 4d e4             	decl   -0x1c(%ebp)
  800e3a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e3e:	7f e7                	jg     800e27 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e40:	e9 66 01 00 00       	jmp    800fab <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 e8             	pushl  -0x18(%ebp)
  800e4b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e4e:	50                   	push   %eax
  800e4f:	e8 3c fd ff ff       	call   800b90 <getint>
  800e54:	83 c4 10             	add    $0x10,%esp
  800e57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e63:	85 d2                	test   %edx,%edx
  800e65:	79 23                	jns    800e8a <vprintfmt+0x29b>
				putch('-', putdat);
  800e67:	83 ec 08             	sub    $0x8,%esp
  800e6a:	ff 75 0c             	pushl  0xc(%ebp)
  800e6d:	6a 2d                	push   $0x2d
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	ff d0                	call   *%eax
  800e74:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7d:	f7 d8                	neg    %eax
  800e7f:	83 d2 00             	adc    $0x0,%edx
  800e82:	f7 da                	neg    %edx
  800e84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e87:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e8a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e91:	e9 bc 00 00 00       	jmp    800f52 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e96:	83 ec 08             	sub    $0x8,%esp
  800e99:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9c:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9f:	50                   	push   %eax
  800ea0:	e8 84 fc ff ff       	call   800b29 <getuint>
  800ea5:	83 c4 10             	add    $0x10,%esp
  800ea8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800eae:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800eb5:	e9 98 00 00 00       	jmp    800f52 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800eba:	83 ec 08             	sub    $0x8,%esp
  800ebd:	ff 75 0c             	pushl  0xc(%ebp)
  800ec0:	6a 58                	push   $0x58
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	ff d0                	call   *%eax
  800ec7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eca:	83 ec 08             	sub    $0x8,%esp
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	6a 58                	push   $0x58
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	ff d0                	call   *%eax
  800ed7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eda:	83 ec 08             	sub    $0x8,%esp
  800edd:	ff 75 0c             	pushl  0xc(%ebp)
  800ee0:	6a 58                	push   $0x58
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	ff d0                	call   *%eax
  800ee7:	83 c4 10             	add    $0x10,%esp
			break;
  800eea:	e9 bc 00 00 00       	jmp    800fab <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eef:	83 ec 08             	sub    $0x8,%esp
  800ef2:	ff 75 0c             	pushl  0xc(%ebp)
  800ef5:	6a 30                	push   $0x30
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	ff d0                	call   *%eax
  800efc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eff:	83 ec 08             	sub    $0x8,%esp
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	6a 78                	push   $0x78
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	ff d0                	call   *%eax
  800f0c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f12:	83 c0 04             	add    $0x4,%eax
  800f15:	89 45 14             	mov    %eax,0x14(%ebp)
  800f18:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1b:	83 e8 04             	sub    $0x4,%eax
  800f1e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f2a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f31:	eb 1f                	jmp    800f52 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f33:	83 ec 08             	sub    $0x8,%esp
  800f36:	ff 75 e8             	pushl  -0x18(%ebp)
  800f39:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3c:	50                   	push   %eax
  800f3d:	e8 e7 fb ff ff       	call   800b29 <getuint>
  800f42:	83 c4 10             	add    $0x10,%esp
  800f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f4b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f52:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f56:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f59:	83 ec 04             	sub    $0x4,%esp
  800f5c:	52                   	push   %edx
  800f5d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f60:	50                   	push   %eax
  800f61:	ff 75 f4             	pushl  -0xc(%ebp)
  800f64:	ff 75 f0             	pushl  -0x10(%ebp)
  800f67:	ff 75 0c             	pushl  0xc(%ebp)
  800f6a:	ff 75 08             	pushl  0x8(%ebp)
  800f6d:	e8 00 fb ff ff       	call   800a72 <printnum>
  800f72:	83 c4 20             	add    $0x20,%esp
			break;
  800f75:	eb 34                	jmp    800fab <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f77:	83 ec 08             	sub    $0x8,%esp
  800f7a:	ff 75 0c             	pushl  0xc(%ebp)
  800f7d:	53                   	push   %ebx
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	ff d0                	call   *%eax
  800f83:	83 c4 10             	add    $0x10,%esp
			break;
  800f86:	eb 23                	jmp    800fab <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f88:	83 ec 08             	sub    $0x8,%esp
  800f8b:	ff 75 0c             	pushl  0xc(%ebp)
  800f8e:	6a 25                	push   $0x25
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	ff d0                	call   *%eax
  800f95:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f98:	ff 4d 10             	decl   0x10(%ebp)
  800f9b:	eb 03                	jmp    800fa0 <vprintfmt+0x3b1>
  800f9d:	ff 4d 10             	decl   0x10(%ebp)
  800fa0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa3:	48                   	dec    %eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	3c 25                	cmp    $0x25,%al
  800fa8:	75 f3                	jne    800f9d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800faa:	90                   	nop
		}
	}
  800fab:	e9 47 fc ff ff       	jmp    800bf7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fb0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fb1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fb4:	5b                   	pop    %ebx
  800fb5:	5e                   	pop    %esi
  800fb6:	5d                   	pop    %ebp
  800fb7:	c3                   	ret    

00800fb8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fb8:	55                   	push   %ebp
  800fb9:	89 e5                	mov    %esp,%ebp
  800fbb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fbe:	8d 45 10             	lea    0x10(%ebp),%eax
  800fc1:	83 c0 04             	add    $0x4,%eax
  800fc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fca:	ff 75 f4             	pushl  -0xc(%ebp)
  800fcd:	50                   	push   %eax
  800fce:	ff 75 0c             	pushl  0xc(%ebp)
  800fd1:	ff 75 08             	pushl  0x8(%ebp)
  800fd4:	e8 16 fc ff ff       	call   800bef <vprintfmt>
  800fd9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fdc:	90                   	nop
  800fdd:	c9                   	leave  
  800fde:	c3                   	ret    

00800fdf <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fe2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe5:	8b 40 08             	mov    0x8(%eax),%eax
  800fe8:	8d 50 01             	lea    0x1(%eax),%edx
  800feb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fee:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff4:	8b 10                	mov    (%eax),%edx
  800ff6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff9:	8b 40 04             	mov    0x4(%eax),%eax
  800ffc:	39 c2                	cmp    %eax,%edx
  800ffe:	73 12                	jae    801012 <sprintputch+0x33>
		*b->buf++ = ch;
  801000:	8b 45 0c             	mov    0xc(%ebp),%eax
  801003:	8b 00                	mov    (%eax),%eax
  801005:	8d 48 01             	lea    0x1(%eax),%ecx
  801008:	8b 55 0c             	mov    0xc(%ebp),%edx
  80100b:	89 0a                	mov    %ecx,(%edx)
  80100d:	8b 55 08             	mov    0x8(%ebp),%edx
  801010:	88 10                	mov    %dl,(%eax)
}
  801012:	90                   	nop
  801013:	5d                   	pop    %ebp
  801014:	c3                   	ret    

00801015 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801015:	55                   	push   %ebp
  801016:	89 e5                	mov    %esp,%ebp
  801018:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801021:	8b 45 0c             	mov    0xc(%ebp),%eax
  801024:	8d 50 ff             	lea    -0x1(%eax),%edx
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	01 d0                	add    %edx,%eax
  80102c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80102f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801036:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80103a:	74 06                	je     801042 <vsnprintf+0x2d>
  80103c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801040:	7f 07                	jg     801049 <vsnprintf+0x34>
		return -E_INVAL;
  801042:	b8 03 00 00 00       	mov    $0x3,%eax
  801047:	eb 20                	jmp    801069 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801049:	ff 75 14             	pushl  0x14(%ebp)
  80104c:	ff 75 10             	pushl  0x10(%ebp)
  80104f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801052:	50                   	push   %eax
  801053:	68 df 0f 80 00       	push   $0x800fdf
  801058:	e8 92 fb ff ff       	call   800bef <vprintfmt>
  80105d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801060:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801063:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801066:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801069:	c9                   	leave  
  80106a:	c3                   	ret    

0080106b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80106b:	55                   	push   %ebp
  80106c:	89 e5                	mov    %esp,%ebp
  80106e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801071:	8d 45 10             	lea    0x10(%ebp),%eax
  801074:	83 c0 04             	add    $0x4,%eax
  801077:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80107a:	8b 45 10             	mov    0x10(%ebp),%eax
  80107d:	ff 75 f4             	pushl  -0xc(%ebp)
  801080:	50                   	push   %eax
  801081:	ff 75 0c             	pushl  0xc(%ebp)
  801084:	ff 75 08             	pushl  0x8(%ebp)
  801087:	e8 89 ff ff ff       	call   801015 <vsnprintf>
  80108c:	83 c4 10             	add    $0x10,%esp
  80108f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801092:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
  80109a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80109d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010a4:	eb 06                	jmp    8010ac <strlen+0x15>
		n++;
  8010a6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8010a9:	ff 45 08             	incl   0x8(%ebp)
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	84 c0                	test   %al,%al
  8010b3:	75 f1                	jne    8010a6 <strlen+0xf>
		n++;
	return n;
  8010b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
  8010bd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010c7:	eb 09                	jmp    8010d2 <strnlen+0x18>
		n++;
  8010c9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010cc:	ff 45 08             	incl   0x8(%ebp)
  8010cf:	ff 4d 0c             	decl   0xc(%ebp)
  8010d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010d6:	74 09                	je     8010e1 <strnlen+0x27>
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	84 c0                	test   %al,%al
  8010df:	75 e8                	jne    8010c9 <strnlen+0xf>
		n++;
	return n;
  8010e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010e4:	c9                   	leave  
  8010e5:	c3                   	ret    

008010e6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010e6:	55                   	push   %ebp
  8010e7:	89 e5                	mov    %esp,%ebp
  8010e9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010f2:	90                   	nop
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	8d 50 01             	lea    0x1(%eax),%edx
  8010f9:	89 55 08             	mov    %edx,0x8(%ebp)
  8010fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  801102:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801105:	8a 12                	mov    (%edx),%dl
  801107:	88 10                	mov    %dl,(%eax)
  801109:	8a 00                	mov    (%eax),%al
  80110b:	84 c0                	test   %al,%al
  80110d:	75 e4                	jne    8010f3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80110f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801112:	c9                   	leave  
  801113:	c3                   	ret    

00801114 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801114:	55                   	push   %ebp
  801115:	89 e5                	mov    %esp,%ebp
  801117:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80111a:	8b 45 08             	mov    0x8(%ebp),%eax
  80111d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801127:	eb 1f                	jmp    801148 <strncpy+0x34>
		*dst++ = *src;
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	8d 50 01             	lea    0x1(%eax),%edx
  80112f:	89 55 08             	mov    %edx,0x8(%ebp)
  801132:	8b 55 0c             	mov    0xc(%ebp),%edx
  801135:	8a 12                	mov    (%edx),%dl
  801137:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	84 c0                	test   %al,%al
  801140:	74 03                	je     801145 <strncpy+0x31>
			src++;
  801142:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801145:	ff 45 fc             	incl   -0x4(%ebp)
  801148:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80114e:	72 d9                	jb     801129 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801150:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801153:	c9                   	leave  
  801154:	c3                   	ret    

00801155 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801155:	55                   	push   %ebp
  801156:	89 e5                	mov    %esp,%ebp
  801158:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801161:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801165:	74 30                	je     801197 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801167:	eb 16                	jmp    80117f <strlcpy+0x2a>
			*dst++ = *src++;
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	8d 50 01             	lea    0x1(%eax),%edx
  80116f:	89 55 08             	mov    %edx,0x8(%ebp)
  801172:	8b 55 0c             	mov    0xc(%ebp),%edx
  801175:	8d 4a 01             	lea    0x1(%edx),%ecx
  801178:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80117b:	8a 12                	mov    (%edx),%dl
  80117d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80117f:	ff 4d 10             	decl   0x10(%ebp)
  801182:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801186:	74 09                	je     801191 <strlcpy+0x3c>
  801188:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	84 c0                	test   %al,%al
  80118f:	75 d8                	jne    801169 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801197:	8b 55 08             	mov    0x8(%ebp),%edx
  80119a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119d:	29 c2                	sub    %eax,%edx
  80119f:	89 d0                	mov    %edx,%eax
}
  8011a1:	c9                   	leave  
  8011a2:	c3                   	ret    

008011a3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8011a3:	55                   	push   %ebp
  8011a4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8011a6:	eb 06                	jmp    8011ae <strcmp+0xb>
		p++, q++;
  8011a8:	ff 45 08             	incl   0x8(%ebp)
  8011ab:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8a 00                	mov    (%eax),%al
  8011b3:	84 c0                	test   %al,%al
  8011b5:	74 0e                	je     8011c5 <strcmp+0x22>
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 10                	mov    (%eax),%dl
  8011bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	38 c2                	cmp    %al,%dl
  8011c3:	74 e3                	je     8011a8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	8a 00                	mov    (%eax),%al
  8011ca:	0f b6 d0             	movzbl %al,%edx
  8011cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	0f b6 c0             	movzbl %al,%eax
  8011d5:	29 c2                	sub    %eax,%edx
  8011d7:	89 d0                	mov    %edx,%eax
}
  8011d9:	5d                   	pop    %ebp
  8011da:	c3                   	ret    

008011db <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8011db:	55                   	push   %ebp
  8011dc:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8011de:	eb 09                	jmp    8011e9 <strncmp+0xe>
		n--, p++, q++;
  8011e0:	ff 4d 10             	decl   0x10(%ebp)
  8011e3:	ff 45 08             	incl   0x8(%ebp)
  8011e6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ed:	74 17                	je     801206 <strncmp+0x2b>
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	84 c0                	test   %al,%al
  8011f6:	74 0e                	je     801206 <strncmp+0x2b>
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 10                	mov    (%eax),%dl
  8011fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801200:	8a 00                	mov    (%eax),%al
  801202:	38 c2                	cmp    %al,%dl
  801204:	74 da                	je     8011e0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801206:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80120a:	75 07                	jne    801213 <strncmp+0x38>
		return 0;
  80120c:	b8 00 00 00 00       	mov    $0x0,%eax
  801211:	eb 14                	jmp    801227 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	0f b6 d0             	movzbl %al,%edx
  80121b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	0f b6 c0             	movzbl %al,%eax
  801223:	29 c2                	sub    %eax,%edx
  801225:	89 d0                	mov    %edx,%eax
}
  801227:	5d                   	pop    %ebp
  801228:	c3                   	ret    

00801229 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
  80122c:	83 ec 04             	sub    $0x4,%esp
  80122f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801232:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801235:	eb 12                	jmp    801249 <strchr+0x20>
		if (*s == c)
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8a 00                	mov    (%eax),%al
  80123c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80123f:	75 05                	jne    801246 <strchr+0x1d>
			return (char *) s;
  801241:	8b 45 08             	mov    0x8(%ebp),%eax
  801244:	eb 11                	jmp    801257 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801246:	ff 45 08             	incl   0x8(%ebp)
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	8a 00                	mov    (%eax),%al
  80124e:	84 c0                	test   %al,%al
  801250:	75 e5                	jne    801237 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801252:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 04             	sub    $0x4,%esp
  80125f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801262:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801265:	eb 0d                	jmp    801274 <strfind+0x1b>
		if (*s == c)
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	8a 00                	mov    (%eax),%al
  80126c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80126f:	74 0e                	je     80127f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801271:	ff 45 08             	incl   0x8(%ebp)
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	84 c0                	test   %al,%al
  80127b:	75 ea                	jne    801267 <strfind+0xe>
  80127d:	eb 01                	jmp    801280 <strfind+0x27>
		if (*s == c)
			break;
  80127f:	90                   	nop
	return (char *) s;
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801283:	c9                   	leave  
  801284:	c3                   	ret    

00801285 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801285:	55                   	push   %ebp
  801286:	89 e5                	mov    %esp,%ebp
  801288:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
  80128e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801291:	8b 45 10             	mov    0x10(%ebp),%eax
  801294:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801297:	eb 0e                	jmp    8012a7 <memset+0x22>
		*p++ = c;
  801299:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80129c:	8d 50 01             	lea    0x1(%eax),%edx
  80129f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8012a7:	ff 4d f8             	decl   -0x8(%ebp)
  8012aa:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8012ae:	79 e9                	jns    801299 <memset+0x14>
		*p++ = c;

	return v;
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012b3:	c9                   	leave  
  8012b4:	c3                   	ret    

008012b5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
  8012b8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012be:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8012c7:	eb 16                	jmp    8012df <memcpy+0x2a>
		*d++ = *s++;
  8012c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cc:	8d 50 01             	lea    0x1(%eax),%edx
  8012cf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012d8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012db:	8a 12                	mov    (%edx),%dl
  8012dd:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8012df:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e5:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e8:	85 c0                	test   %eax,%eax
  8012ea:	75 dd                	jne    8012c9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
  8012f4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8012f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801303:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801306:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801309:	73 50                	jae    80135b <memmove+0x6a>
  80130b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80130e:	8b 45 10             	mov    0x10(%ebp),%eax
  801311:	01 d0                	add    %edx,%eax
  801313:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801316:	76 43                	jbe    80135b <memmove+0x6a>
		s += n;
  801318:	8b 45 10             	mov    0x10(%ebp),%eax
  80131b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80131e:	8b 45 10             	mov    0x10(%ebp),%eax
  801321:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801324:	eb 10                	jmp    801336 <memmove+0x45>
			*--d = *--s;
  801326:	ff 4d f8             	decl   -0x8(%ebp)
  801329:	ff 4d fc             	decl   -0x4(%ebp)
  80132c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132f:	8a 10                	mov    (%eax),%dl
  801331:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801334:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801336:	8b 45 10             	mov    0x10(%ebp),%eax
  801339:	8d 50 ff             	lea    -0x1(%eax),%edx
  80133c:	89 55 10             	mov    %edx,0x10(%ebp)
  80133f:	85 c0                	test   %eax,%eax
  801341:	75 e3                	jne    801326 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801343:	eb 23                	jmp    801368 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801345:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801348:	8d 50 01             	lea    0x1(%eax),%edx
  80134b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80134e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801351:	8d 4a 01             	lea    0x1(%edx),%ecx
  801354:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801357:	8a 12                	mov    (%edx),%dl
  801359:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80135b:	8b 45 10             	mov    0x10(%ebp),%eax
  80135e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801361:	89 55 10             	mov    %edx,0x10(%ebp)
  801364:	85 c0                	test   %eax,%eax
  801366:	75 dd                	jne    801345 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80136b:	c9                   	leave  
  80136c:	c3                   	ret    

0080136d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80136d:	55                   	push   %ebp
  80136e:	89 e5                	mov    %esp,%ebp
  801370:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80137f:	eb 2a                	jmp    8013ab <memcmp+0x3e>
		if (*s1 != *s2)
  801381:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801384:	8a 10                	mov    (%eax),%dl
  801386:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	38 c2                	cmp    %al,%dl
  80138d:	74 16                	je     8013a5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80138f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	0f b6 d0             	movzbl %al,%edx
  801397:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	0f b6 c0             	movzbl %al,%eax
  80139f:	29 c2                	sub    %eax,%edx
  8013a1:	89 d0                	mov    %edx,%eax
  8013a3:	eb 18                	jmp    8013bd <memcmp+0x50>
		s1++, s2++;
  8013a5:	ff 45 fc             	incl   -0x4(%ebp)
  8013a8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8013ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ae:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8013b4:	85 c0                	test   %eax,%eax
  8013b6:	75 c9                	jne    801381 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8013b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013bd:	c9                   	leave  
  8013be:	c3                   	ret    

008013bf <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8013bf:	55                   	push   %ebp
  8013c0:	89 e5                	mov    %esp,%ebp
  8013c2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8013c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8013c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013cb:	01 d0                	add    %edx,%eax
  8013cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8013d0:	eb 15                	jmp    8013e7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8013d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	0f b6 d0             	movzbl %al,%edx
  8013da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dd:	0f b6 c0             	movzbl %al,%eax
  8013e0:	39 c2                	cmp    %eax,%edx
  8013e2:	74 0d                	je     8013f1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013e4:	ff 45 08             	incl   0x8(%ebp)
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013ed:	72 e3                	jb     8013d2 <memfind+0x13>
  8013ef:	eb 01                	jmp    8013f2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013f1:	90                   	nop
	return (void *) s;
  8013f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013f5:	c9                   	leave  
  8013f6:	c3                   	ret    

008013f7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
  8013fa:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801404:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80140b:	eb 03                	jmp    801410 <strtol+0x19>
		s++;
  80140d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801410:	8b 45 08             	mov    0x8(%ebp),%eax
  801413:	8a 00                	mov    (%eax),%al
  801415:	3c 20                	cmp    $0x20,%al
  801417:	74 f4                	je     80140d <strtol+0x16>
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	8a 00                	mov    (%eax),%al
  80141e:	3c 09                	cmp    $0x9,%al
  801420:	74 eb                	je     80140d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	3c 2b                	cmp    $0x2b,%al
  801429:	75 05                	jne    801430 <strtol+0x39>
		s++;
  80142b:	ff 45 08             	incl   0x8(%ebp)
  80142e:	eb 13                	jmp    801443 <strtol+0x4c>
	else if (*s == '-')
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	8a 00                	mov    (%eax),%al
  801435:	3c 2d                	cmp    $0x2d,%al
  801437:	75 0a                	jne    801443 <strtol+0x4c>
		s++, neg = 1;
  801439:	ff 45 08             	incl   0x8(%ebp)
  80143c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801443:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801447:	74 06                	je     80144f <strtol+0x58>
  801449:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80144d:	75 20                	jne    80146f <strtol+0x78>
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	3c 30                	cmp    $0x30,%al
  801456:	75 17                	jne    80146f <strtol+0x78>
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	40                   	inc    %eax
  80145c:	8a 00                	mov    (%eax),%al
  80145e:	3c 78                	cmp    $0x78,%al
  801460:	75 0d                	jne    80146f <strtol+0x78>
		s += 2, base = 16;
  801462:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801466:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80146d:	eb 28                	jmp    801497 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80146f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801473:	75 15                	jne    80148a <strtol+0x93>
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	8a 00                	mov    (%eax),%al
  80147a:	3c 30                	cmp    $0x30,%al
  80147c:	75 0c                	jne    80148a <strtol+0x93>
		s++, base = 8;
  80147e:	ff 45 08             	incl   0x8(%ebp)
  801481:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801488:	eb 0d                	jmp    801497 <strtol+0xa0>
	else if (base == 0)
  80148a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80148e:	75 07                	jne    801497 <strtol+0xa0>
		base = 10;
  801490:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	8a 00                	mov    (%eax),%al
  80149c:	3c 2f                	cmp    $0x2f,%al
  80149e:	7e 19                	jle    8014b9 <strtol+0xc2>
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	8a 00                	mov    (%eax),%al
  8014a5:	3c 39                	cmp    $0x39,%al
  8014a7:	7f 10                	jg     8014b9 <strtol+0xc2>
			dig = *s - '0';
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	8a 00                	mov    (%eax),%al
  8014ae:	0f be c0             	movsbl %al,%eax
  8014b1:	83 e8 30             	sub    $0x30,%eax
  8014b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014b7:	eb 42                	jmp    8014fb <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	3c 60                	cmp    $0x60,%al
  8014c0:	7e 19                	jle    8014db <strtol+0xe4>
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	3c 7a                	cmp    $0x7a,%al
  8014c9:	7f 10                	jg     8014db <strtol+0xe4>
			dig = *s - 'a' + 10;
  8014cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	0f be c0             	movsbl %al,%eax
  8014d3:	83 e8 57             	sub    $0x57,%eax
  8014d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014d9:	eb 20                	jmp    8014fb <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8014db:	8b 45 08             	mov    0x8(%ebp),%eax
  8014de:	8a 00                	mov    (%eax),%al
  8014e0:	3c 40                	cmp    $0x40,%al
  8014e2:	7e 39                	jle    80151d <strtol+0x126>
  8014e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e7:	8a 00                	mov    (%eax),%al
  8014e9:	3c 5a                	cmp    $0x5a,%al
  8014eb:	7f 30                	jg     80151d <strtol+0x126>
			dig = *s - 'A' + 10;
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	8a 00                	mov    (%eax),%al
  8014f2:	0f be c0             	movsbl %al,%eax
  8014f5:	83 e8 37             	sub    $0x37,%eax
  8014f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014fe:	3b 45 10             	cmp    0x10(%ebp),%eax
  801501:	7d 19                	jge    80151c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801503:	ff 45 08             	incl   0x8(%ebp)
  801506:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801509:	0f af 45 10          	imul   0x10(%ebp),%eax
  80150d:	89 c2                	mov    %eax,%edx
  80150f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801512:	01 d0                	add    %edx,%eax
  801514:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801517:	e9 7b ff ff ff       	jmp    801497 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80151c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80151d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801521:	74 08                	je     80152b <strtol+0x134>
		*endptr = (char *) s;
  801523:	8b 45 0c             	mov    0xc(%ebp),%eax
  801526:	8b 55 08             	mov    0x8(%ebp),%edx
  801529:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80152b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80152f:	74 07                	je     801538 <strtol+0x141>
  801531:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801534:	f7 d8                	neg    %eax
  801536:	eb 03                	jmp    80153b <strtol+0x144>
  801538:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <ltostr>:

void
ltostr(long value, char *str)
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
  801540:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801543:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80154a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801551:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801555:	79 13                	jns    80156a <ltostr+0x2d>
	{
		neg = 1;
  801557:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80155e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801561:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801564:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801567:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801572:	99                   	cltd   
  801573:	f7 f9                	idiv   %ecx
  801575:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801578:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157b:	8d 50 01             	lea    0x1(%eax),%edx
  80157e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801581:	89 c2                	mov    %eax,%edx
  801583:	8b 45 0c             	mov    0xc(%ebp),%eax
  801586:	01 d0                	add    %edx,%eax
  801588:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80158b:	83 c2 30             	add    $0x30,%edx
  80158e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801590:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801593:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801598:	f7 e9                	imul   %ecx
  80159a:	c1 fa 02             	sar    $0x2,%edx
  80159d:	89 c8                	mov    %ecx,%eax
  80159f:	c1 f8 1f             	sar    $0x1f,%eax
  8015a2:	29 c2                	sub    %eax,%edx
  8015a4:	89 d0                	mov    %edx,%eax
  8015a6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8015a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015ac:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015b1:	f7 e9                	imul   %ecx
  8015b3:	c1 fa 02             	sar    $0x2,%edx
  8015b6:	89 c8                	mov    %ecx,%eax
  8015b8:	c1 f8 1f             	sar    $0x1f,%eax
  8015bb:	29 c2                	sub    %eax,%edx
  8015bd:	89 d0                	mov    %edx,%eax
  8015bf:	c1 e0 02             	shl    $0x2,%eax
  8015c2:	01 d0                	add    %edx,%eax
  8015c4:	01 c0                	add    %eax,%eax
  8015c6:	29 c1                	sub    %eax,%ecx
  8015c8:	89 ca                	mov    %ecx,%edx
  8015ca:	85 d2                	test   %edx,%edx
  8015cc:	75 9c                	jne    80156a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8015ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8015d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d8:	48                   	dec    %eax
  8015d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8015dc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015e0:	74 3d                	je     80161f <ltostr+0xe2>
		start = 1 ;
  8015e2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015e9:	eb 34                	jmp    80161f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f1:	01 d0                	add    %edx,%eax
  8015f3:	8a 00                	mov    (%eax),%al
  8015f5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fe:	01 c2                	add    %eax,%edx
  801600:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801603:	8b 45 0c             	mov    0xc(%ebp),%eax
  801606:	01 c8                	add    %ecx,%eax
  801608:	8a 00                	mov    (%eax),%al
  80160a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80160c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80160f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801612:	01 c2                	add    %eax,%edx
  801614:	8a 45 eb             	mov    -0x15(%ebp),%al
  801617:	88 02                	mov    %al,(%edx)
		start++ ;
  801619:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80161c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80161f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801622:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801625:	7c c4                	jl     8015eb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801627:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80162a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162d:	01 d0                	add    %edx,%eax
  80162f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801632:	90                   	nop
  801633:	c9                   	leave  
  801634:	c3                   	ret    

00801635 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801635:	55                   	push   %ebp
  801636:	89 e5                	mov    %esp,%ebp
  801638:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80163b:	ff 75 08             	pushl  0x8(%ebp)
  80163e:	e8 54 fa ff ff       	call   801097 <strlen>
  801643:	83 c4 04             	add    $0x4,%esp
  801646:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801649:	ff 75 0c             	pushl  0xc(%ebp)
  80164c:	e8 46 fa ff ff       	call   801097 <strlen>
  801651:	83 c4 04             	add    $0x4,%esp
  801654:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801657:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80165e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801665:	eb 17                	jmp    80167e <strcconcat+0x49>
		final[s] = str1[s] ;
  801667:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166a:	8b 45 10             	mov    0x10(%ebp),%eax
  80166d:	01 c2                	add    %eax,%edx
  80166f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	01 c8                	add    %ecx,%eax
  801677:	8a 00                	mov    (%eax),%al
  801679:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80167b:	ff 45 fc             	incl   -0x4(%ebp)
  80167e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801681:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801684:	7c e1                	jl     801667 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801686:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80168d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801694:	eb 1f                	jmp    8016b5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801696:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801699:	8d 50 01             	lea    0x1(%eax),%edx
  80169c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80169f:	89 c2                	mov    %eax,%edx
  8016a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a4:	01 c2                	add    %eax,%edx
  8016a6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8016a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ac:	01 c8                	add    %ecx,%eax
  8016ae:	8a 00                	mov    (%eax),%al
  8016b0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8016b2:	ff 45 f8             	incl   -0x8(%ebp)
  8016b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016bb:	7c d9                	jl     801696 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8016bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c3:	01 d0                	add    %edx,%eax
  8016c5:	c6 00 00             	movb   $0x0,(%eax)
}
  8016c8:	90                   	nop
  8016c9:	c9                   	leave  
  8016ca:	c3                   	ret    

008016cb <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8016cb:	55                   	push   %ebp
  8016cc:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8016ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8016d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016da:	8b 00                	mov    (%eax),%eax
  8016dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e6:	01 d0                	add    %edx,%eax
  8016e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016ee:	eb 0c                	jmp    8016fc <strsplit+0x31>
			*string++ = 0;
  8016f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f3:	8d 50 01             	lea    0x1(%eax),%edx
  8016f6:	89 55 08             	mov    %edx,0x8(%ebp)
  8016f9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	8a 00                	mov    (%eax),%al
  801701:	84 c0                	test   %al,%al
  801703:	74 18                	je     80171d <strsplit+0x52>
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	8a 00                	mov    (%eax),%al
  80170a:	0f be c0             	movsbl %al,%eax
  80170d:	50                   	push   %eax
  80170e:	ff 75 0c             	pushl  0xc(%ebp)
  801711:	e8 13 fb ff ff       	call   801229 <strchr>
  801716:	83 c4 08             	add    $0x8,%esp
  801719:	85 c0                	test   %eax,%eax
  80171b:	75 d3                	jne    8016f0 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  80171d:	8b 45 08             	mov    0x8(%ebp),%eax
  801720:	8a 00                	mov    (%eax),%al
  801722:	84 c0                	test   %al,%al
  801724:	74 5a                	je     801780 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801726:	8b 45 14             	mov    0x14(%ebp),%eax
  801729:	8b 00                	mov    (%eax),%eax
  80172b:	83 f8 0f             	cmp    $0xf,%eax
  80172e:	75 07                	jne    801737 <strsplit+0x6c>
		{
			return 0;
  801730:	b8 00 00 00 00       	mov    $0x0,%eax
  801735:	eb 66                	jmp    80179d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801737:	8b 45 14             	mov    0x14(%ebp),%eax
  80173a:	8b 00                	mov    (%eax),%eax
  80173c:	8d 48 01             	lea    0x1(%eax),%ecx
  80173f:	8b 55 14             	mov    0x14(%ebp),%edx
  801742:	89 0a                	mov    %ecx,(%edx)
  801744:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80174b:	8b 45 10             	mov    0x10(%ebp),%eax
  80174e:	01 c2                	add    %eax,%edx
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801755:	eb 03                	jmp    80175a <strsplit+0x8f>
			string++;
  801757:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80175a:	8b 45 08             	mov    0x8(%ebp),%eax
  80175d:	8a 00                	mov    (%eax),%al
  80175f:	84 c0                	test   %al,%al
  801761:	74 8b                	je     8016ee <strsplit+0x23>
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	8a 00                	mov    (%eax),%al
  801768:	0f be c0             	movsbl %al,%eax
  80176b:	50                   	push   %eax
  80176c:	ff 75 0c             	pushl  0xc(%ebp)
  80176f:	e8 b5 fa ff ff       	call   801229 <strchr>
  801774:	83 c4 08             	add    $0x8,%esp
  801777:	85 c0                	test   %eax,%eax
  801779:	74 dc                	je     801757 <strsplit+0x8c>
			string++;
	}
  80177b:	e9 6e ff ff ff       	jmp    8016ee <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801780:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801781:	8b 45 14             	mov    0x14(%ebp),%eax
  801784:	8b 00                	mov    (%eax),%eax
  801786:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80178d:	8b 45 10             	mov    0x10(%ebp),%eax
  801790:	01 d0                	add    %edx,%eax
  801792:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801798:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80179d:	c9                   	leave  
  80179e:	c3                   	ret    

0080179f <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80179f:	55                   	push   %ebp
  8017a0:	89 e5                	mov    %esp,%ebp
  8017a2:	83 ec 18             	sub    $0x18,%esp
  8017a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a8:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  8017ab:	83 ec 04             	sub    $0x4,%esp
  8017ae:	68 f0 29 80 00       	push   $0x8029f0
  8017b3:	6a 17                	push   $0x17
  8017b5:	68 0f 2a 80 00       	push   $0x802a0f
  8017ba:	e8 a2 ef ff ff       	call   800761 <_panic>

008017bf <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
  8017c2:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  8017c5:	83 ec 04             	sub    $0x4,%esp
  8017c8:	68 1b 2a 80 00       	push   $0x802a1b
  8017cd:	6a 2f                	push   $0x2f
  8017cf:	68 0f 2a 80 00       	push   $0x802a0f
  8017d4:	e8 88 ef ff ff       	call   800761 <_panic>

008017d9 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
  8017dc:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8017df:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8017e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8017e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017ec:	01 d0                	add    %edx,%eax
  8017ee:	48                   	dec    %eax
  8017ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8017f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017f5:	ba 00 00 00 00       	mov    $0x0,%edx
  8017fa:	f7 75 ec             	divl   -0x14(%ebp)
  8017fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801800:	29 d0                	sub    %edx,%eax
  801802:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801805:	8b 45 08             	mov    0x8(%ebp),%eax
  801808:	c1 e8 0c             	shr    $0xc,%eax
  80180b:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80180e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801815:	e9 c8 00 00 00       	jmp    8018e2 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  80181a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801821:	eb 27                	jmp    80184a <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801823:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801826:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801829:	01 c2                	add    %eax,%edx
  80182b:	89 d0                	mov    %edx,%eax
  80182d:	01 c0                	add    %eax,%eax
  80182f:	01 d0                	add    %edx,%eax
  801831:	c1 e0 02             	shl    $0x2,%eax
  801834:	05 48 30 80 00       	add    $0x803048,%eax
  801839:	8b 00                	mov    (%eax),%eax
  80183b:	85 c0                	test   %eax,%eax
  80183d:	74 08                	je     801847 <malloc+0x6e>
            	i += j;
  80183f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801842:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801845:	eb 0b                	jmp    801852 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801847:	ff 45 f0             	incl   -0x10(%ebp)
  80184a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80184d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801850:	72 d1                	jb     801823 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801852:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801855:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801858:	0f 85 81 00 00 00    	jne    8018df <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80185e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801861:	05 00 00 08 00       	add    $0x80000,%eax
  801866:	c1 e0 0c             	shl    $0xc,%eax
  801869:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80186c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801873:	eb 1f                	jmp    801894 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801875:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801878:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80187b:	01 c2                	add    %eax,%edx
  80187d:	89 d0                	mov    %edx,%eax
  80187f:	01 c0                	add    %eax,%eax
  801881:	01 d0                	add    %edx,%eax
  801883:	c1 e0 02             	shl    $0x2,%eax
  801886:	05 48 30 80 00       	add    $0x803048,%eax
  80188b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801891:	ff 45 f0             	incl   -0x10(%ebp)
  801894:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801897:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80189a:	72 d9                	jb     801875 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80189c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80189f:	89 d0                	mov    %edx,%eax
  8018a1:	01 c0                	add    %eax,%eax
  8018a3:	01 d0                	add    %edx,%eax
  8018a5:	c1 e0 02             	shl    $0x2,%eax
  8018a8:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  8018ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018b1:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  8018b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8018b6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  8018b9:	89 c8                	mov    %ecx,%eax
  8018bb:	01 c0                	add    %eax,%eax
  8018bd:	01 c8                	add    %ecx,%eax
  8018bf:	c1 e0 02             	shl    $0x2,%eax
  8018c2:	05 44 30 80 00       	add    $0x803044,%eax
  8018c7:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  8018c9:	83 ec 08             	sub    $0x8,%esp
  8018cc:	ff 75 08             	pushl  0x8(%ebp)
  8018cf:	ff 75 e0             	pushl  -0x20(%ebp)
  8018d2:	e8 2b 03 00 00       	call   801c02 <sys_allocateMem>
  8018d7:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8018da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018dd:	eb 19                	jmp    8018f8 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8018df:	ff 45 f4             	incl   -0xc(%ebp)
  8018e2:	a1 04 30 80 00       	mov    0x803004,%eax
  8018e7:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8018ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018ed:	0f 83 27 ff ff ff    	jae    80181a <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8018f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f8:	c9                   	leave  
  8018f9:	c3                   	ret    

008018fa <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8018fa:	55                   	push   %ebp
  8018fb:	89 e5                	mov    %esp,%ebp
  8018fd:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801900:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801904:	0f 84 e5 00 00 00    	je     8019ef <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801910:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801913:	05 00 00 00 80       	add    $0x80000000,%eax
  801918:	c1 e8 0c             	shr    $0xc,%eax
  80191b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  80191e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801921:	89 d0                	mov    %edx,%eax
  801923:	01 c0                	add    %eax,%eax
  801925:	01 d0                	add    %edx,%eax
  801927:	c1 e0 02             	shl    $0x2,%eax
  80192a:	05 40 30 80 00       	add    $0x803040,%eax
  80192f:	8b 00                	mov    (%eax),%eax
  801931:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801934:	0f 85 b8 00 00 00    	jne    8019f2 <free+0xf8>
  80193a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80193d:	89 d0                	mov    %edx,%eax
  80193f:	01 c0                	add    %eax,%eax
  801941:	01 d0                	add    %edx,%eax
  801943:	c1 e0 02             	shl    $0x2,%eax
  801946:	05 48 30 80 00       	add    $0x803048,%eax
  80194b:	8b 00                	mov    (%eax),%eax
  80194d:	85 c0                	test   %eax,%eax
  80194f:	0f 84 9d 00 00 00    	je     8019f2 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801955:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801958:	89 d0                	mov    %edx,%eax
  80195a:	01 c0                	add    %eax,%eax
  80195c:	01 d0                	add    %edx,%eax
  80195e:	c1 e0 02             	shl    $0x2,%eax
  801961:	05 44 30 80 00       	add    $0x803044,%eax
  801966:	8b 00                	mov    (%eax),%eax
  801968:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80196b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80196e:	c1 e0 0c             	shl    $0xc,%eax
  801971:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801974:	83 ec 08             	sub    $0x8,%esp
  801977:	ff 75 e4             	pushl  -0x1c(%ebp)
  80197a:	ff 75 f0             	pushl  -0x10(%ebp)
  80197d:	e8 64 02 00 00       	call   801be6 <sys_freeMem>
  801982:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801985:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80198c:	eb 57                	jmp    8019e5 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80198e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801991:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801994:	01 c2                	add    %eax,%edx
  801996:	89 d0                	mov    %edx,%eax
  801998:	01 c0                	add    %eax,%eax
  80199a:	01 d0                	add    %edx,%eax
  80199c:	c1 e0 02             	shl    $0x2,%eax
  80199f:	05 48 30 80 00       	add    $0x803048,%eax
  8019a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  8019aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b0:	01 c2                	add    %eax,%edx
  8019b2:	89 d0                	mov    %edx,%eax
  8019b4:	01 c0                	add    %eax,%eax
  8019b6:	01 d0                	add    %edx,%eax
  8019b8:	c1 e0 02             	shl    $0x2,%eax
  8019bb:	05 40 30 80 00       	add    $0x803040,%eax
  8019c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  8019c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019cc:	01 c2                	add    %eax,%edx
  8019ce:	89 d0                	mov    %edx,%eax
  8019d0:	01 c0                	add    %eax,%eax
  8019d2:	01 d0                	add    %edx,%eax
  8019d4:	c1 e0 02             	shl    $0x2,%eax
  8019d7:	05 44 30 80 00       	add    $0x803044,%eax
  8019dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8019e2:	ff 45 f4             	incl   -0xc(%ebp)
  8019e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019e8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8019eb:	7c a1                	jl     80198e <free+0x94>
  8019ed:	eb 04                	jmp    8019f3 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8019ef:	90                   	nop
  8019f0:	eb 01                	jmp    8019f3 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8019f2:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
  8019f8:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8019fb:	83 ec 04             	sub    $0x4,%esp
  8019fe:	68 38 2a 80 00       	push   $0x802a38
  801a03:	68 ae 00 00 00       	push   $0xae
  801a08:	68 0f 2a 80 00       	push   $0x802a0f
  801a0d:	e8 4f ed ff ff       	call   800761 <_panic>

00801a12 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
  801a15:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801a18:	83 ec 04             	sub    $0x4,%esp
  801a1b:	68 58 2a 80 00       	push   $0x802a58
  801a20:	68 ca 00 00 00       	push   $0xca
  801a25:	68 0f 2a 80 00       	push   $0x802a0f
  801a2a:	e8 32 ed ff ff       	call   800761 <_panic>

00801a2f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a2f:	55                   	push   %ebp
  801a30:	89 e5                	mov    %esp,%ebp
  801a32:	57                   	push   %edi
  801a33:	56                   	push   %esi
  801a34:	53                   	push   %ebx
  801a35:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a38:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a41:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a44:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a47:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a4a:	cd 30                	int    $0x30
  801a4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a52:	83 c4 10             	add    $0x10,%esp
  801a55:	5b                   	pop    %ebx
  801a56:	5e                   	pop    %esi
  801a57:	5f                   	pop    %edi
  801a58:	5d                   	pop    %ebp
  801a59:	c3                   	ret    

00801a5a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
  801a5d:	83 ec 04             	sub    $0x4,%esp
  801a60:	8b 45 10             	mov    0x10(%ebp),%eax
  801a63:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a66:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	52                   	push   %edx
  801a72:	ff 75 0c             	pushl  0xc(%ebp)
  801a75:	50                   	push   %eax
  801a76:	6a 00                	push   $0x0
  801a78:	e8 b2 ff ff ff       	call   801a2f <syscall>
  801a7d:	83 c4 18             	add    $0x18,%esp
}
  801a80:	90                   	nop
  801a81:	c9                   	leave  
  801a82:	c3                   	ret    

00801a83 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a83:	55                   	push   %ebp
  801a84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 01                	push   $0x1
  801a92:	e8 98 ff ff ff       	call   801a2f <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	50                   	push   %eax
  801aab:	6a 05                	push   $0x5
  801aad:	e8 7d ff ff ff       	call   801a2f <syscall>
  801ab2:	83 c4 18             	add    $0x18,%esp
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 02                	push   $0x2
  801ac6:	e8 64 ff ff ff       	call   801a2f <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 03                	push   $0x3
  801adf:	e8 4b ff ff ff       	call   801a2f <syscall>
  801ae4:	83 c4 18             	add    $0x18,%esp
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 04                	push   $0x4
  801af8:	e8 32 ff ff ff       	call   801a2f <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	c9                   	leave  
  801b01:	c3                   	ret    

00801b02 <sys_env_exit>:


void sys_env_exit(void)
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 06                	push   $0x6
  801b11:	e8 19 ff ff ff       	call   801a2f <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	90                   	nop
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b22:	8b 45 08             	mov    0x8(%ebp),%eax
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	52                   	push   %edx
  801b2c:	50                   	push   %eax
  801b2d:	6a 07                	push   $0x7
  801b2f:	e8 fb fe ff ff       	call   801a2f <syscall>
  801b34:	83 c4 18             	add    $0x18,%esp
}
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
  801b3c:	56                   	push   %esi
  801b3d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b3e:	8b 75 18             	mov    0x18(%ebp),%esi
  801b41:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b44:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4d:	56                   	push   %esi
  801b4e:	53                   	push   %ebx
  801b4f:	51                   	push   %ecx
  801b50:	52                   	push   %edx
  801b51:	50                   	push   %eax
  801b52:	6a 08                	push   $0x8
  801b54:	e8 d6 fe ff ff       	call   801a2f <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
}
  801b5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b5f:	5b                   	pop    %ebx
  801b60:	5e                   	pop    %esi
  801b61:	5d                   	pop    %ebp
  801b62:	c3                   	ret    

00801b63 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b69:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	52                   	push   %edx
  801b73:	50                   	push   %eax
  801b74:	6a 09                	push   $0x9
  801b76:	e8 b4 fe ff ff       	call   801a2f <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
}
  801b7e:	c9                   	leave  
  801b7f:	c3                   	ret    

00801b80 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b80:	55                   	push   %ebp
  801b81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	ff 75 0c             	pushl  0xc(%ebp)
  801b8c:	ff 75 08             	pushl  0x8(%ebp)
  801b8f:	6a 0a                	push   $0xa
  801b91:	e8 99 fe ff ff       	call   801a2f <syscall>
  801b96:	83 c4 18             	add    $0x18,%esp
}
  801b99:	c9                   	leave  
  801b9a:	c3                   	ret    

00801b9b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b9b:	55                   	push   %ebp
  801b9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 0b                	push   $0xb
  801baa:	e8 80 fe ff ff       	call   801a2f <syscall>
  801baf:	83 c4 18             	add    $0x18,%esp
}
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 0c                	push   $0xc
  801bc3:	e8 67 fe ff ff       	call   801a2f <syscall>
  801bc8:	83 c4 18             	add    $0x18,%esp
}
  801bcb:	c9                   	leave  
  801bcc:	c3                   	ret    

00801bcd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801bcd:	55                   	push   %ebp
  801bce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 0d                	push   $0xd
  801bdc:	e8 4e fe ff ff       	call   801a2f <syscall>
  801be1:	83 c4 18             	add    $0x18,%esp
}
  801be4:	c9                   	leave  
  801be5:	c3                   	ret    

00801be6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801be6:	55                   	push   %ebp
  801be7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	ff 75 0c             	pushl  0xc(%ebp)
  801bf2:	ff 75 08             	pushl  0x8(%ebp)
  801bf5:	6a 11                	push   $0x11
  801bf7:	e8 33 fe ff ff       	call   801a2f <syscall>
  801bfc:	83 c4 18             	add    $0x18,%esp
	return;
  801bff:	90                   	nop
}
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	ff 75 0c             	pushl  0xc(%ebp)
  801c0e:	ff 75 08             	pushl  0x8(%ebp)
  801c11:	6a 12                	push   $0x12
  801c13:	e8 17 fe ff ff       	call   801a2f <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1b:	90                   	nop
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 0e                	push   $0xe
  801c2d:	e8 fd fd ff ff       	call   801a2f <syscall>
  801c32:	83 c4 18             	add    $0x18,%esp
}
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	ff 75 08             	pushl  0x8(%ebp)
  801c45:	6a 0f                	push   $0xf
  801c47:	e8 e3 fd ff ff       	call   801a2f <syscall>
  801c4c:	83 c4 18             	add    $0x18,%esp
}
  801c4f:	c9                   	leave  
  801c50:	c3                   	ret    

00801c51 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c51:	55                   	push   %ebp
  801c52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 10                	push   $0x10
  801c60:	e8 ca fd ff ff       	call   801a2f <syscall>
  801c65:	83 c4 18             	add    $0x18,%esp
}
  801c68:	90                   	nop
  801c69:	c9                   	leave  
  801c6a:	c3                   	ret    

00801c6b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c6b:	55                   	push   %ebp
  801c6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 14                	push   $0x14
  801c7a:	e8 b0 fd ff ff       	call   801a2f <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
}
  801c82:	90                   	nop
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 00                	push   $0x0
  801c92:	6a 15                	push   $0x15
  801c94:	e8 96 fd ff ff       	call   801a2f <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
}
  801c9c:	90                   	nop
  801c9d:	c9                   	leave  
  801c9e:	c3                   	ret    

00801c9f <sys_cputc>:


void
sys_cputc(const char c)
{
  801c9f:	55                   	push   %ebp
  801ca0:	89 e5                	mov    %esp,%ebp
  801ca2:	83 ec 04             	sub    $0x4,%esp
  801ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	50                   	push   %eax
  801cb8:	6a 16                	push   $0x16
  801cba:	e8 70 fd ff ff       	call   801a2f <syscall>
  801cbf:	83 c4 18             	add    $0x18,%esp
}
  801cc2:	90                   	nop
  801cc3:	c9                   	leave  
  801cc4:	c3                   	ret    

00801cc5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cc5:	55                   	push   %ebp
  801cc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 17                	push   $0x17
  801cd4:	e8 56 fd ff ff       	call   801a2f <syscall>
  801cd9:	83 c4 18             	add    $0x18,%esp
}
  801cdc:	90                   	nop
  801cdd:	c9                   	leave  
  801cde:	c3                   	ret    

00801cdf <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	ff 75 0c             	pushl  0xc(%ebp)
  801cee:	50                   	push   %eax
  801cef:	6a 18                	push   $0x18
  801cf1:	e8 39 fd ff ff       	call   801a2f <syscall>
  801cf6:	83 c4 18             	add    $0x18,%esp
}
  801cf9:	c9                   	leave  
  801cfa:	c3                   	ret    

00801cfb <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cfe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d01:	8b 45 08             	mov    0x8(%ebp),%eax
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	52                   	push   %edx
  801d0b:	50                   	push   %eax
  801d0c:	6a 1b                	push   $0x1b
  801d0e:	e8 1c fd ff ff       	call   801a2f <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
}
  801d16:	c9                   	leave  
  801d17:	c3                   	ret    

00801d18 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d18:	55                   	push   %ebp
  801d19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d21:	6a 00                	push   $0x0
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	52                   	push   %edx
  801d28:	50                   	push   %eax
  801d29:	6a 19                	push   $0x19
  801d2b:	e8 ff fc ff ff       	call   801a2f <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
}
  801d33:	90                   	nop
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	52                   	push   %edx
  801d46:	50                   	push   %eax
  801d47:	6a 1a                	push   $0x1a
  801d49:	e8 e1 fc ff ff       	call   801a2f <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
}
  801d51:	90                   	nop
  801d52:	c9                   	leave  
  801d53:	c3                   	ret    

00801d54 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
  801d57:	83 ec 04             	sub    $0x4,%esp
  801d5a:	8b 45 10             	mov    0x10(%ebp),%eax
  801d5d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d60:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d63:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d67:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6a:	6a 00                	push   $0x0
  801d6c:	51                   	push   %ecx
  801d6d:	52                   	push   %edx
  801d6e:	ff 75 0c             	pushl  0xc(%ebp)
  801d71:	50                   	push   %eax
  801d72:	6a 1c                	push   $0x1c
  801d74:	e8 b6 fc ff ff       	call   801a2f <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
}
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d84:	8b 45 08             	mov    0x8(%ebp),%eax
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 00                	push   $0x0
  801d8d:	52                   	push   %edx
  801d8e:	50                   	push   %eax
  801d8f:	6a 1d                	push   $0x1d
  801d91:	e8 99 fc ff ff       	call   801a2f <syscall>
  801d96:	83 c4 18             	add    $0x18,%esp
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d9e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801da1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da4:	8b 45 08             	mov    0x8(%ebp),%eax
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	51                   	push   %ecx
  801dac:	52                   	push   %edx
  801dad:	50                   	push   %eax
  801dae:	6a 1e                	push   $0x1e
  801db0:	e8 7a fc ff ff       	call   801a2f <syscall>
  801db5:	83 c4 18             	add    $0x18,%esp
}
  801db8:	c9                   	leave  
  801db9:	c3                   	ret    

00801dba <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dba:	55                   	push   %ebp
  801dbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	52                   	push   %edx
  801dca:	50                   	push   %eax
  801dcb:	6a 1f                	push   $0x1f
  801dcd:	e8 5d fc ff ff       	call   801a2f <syscall>
  801dd2:	83 c4 18             	add    $0x18,%esp
}
  801dd5:	c9                   	leave  
  801dd6:	c3                   	ret    

00801dd7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801dd7:	55                   	push   %ebp
  801dd8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 20                	push   $0x20
  801de6:	e8 44 fc ff ff       	call   801a2f <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801df3:	8b 45 08             	mov    0x8(%ebp),%eax
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	ff 75 10             	pushl  0x10(%ebp)
  801dfd:	ff 75 0c             	pushl  0xc(%ebp)
  801e00:	50                   	push   %eax
  801e01:	6a 21                	push   $0x21
  801e03:	e8 27 fc ff ff       	call   801a2f <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	c9                   	leave  
  801e0c:	c3                   	ret    

00801e0d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	50                   	push   %eax
  801e1c:	6a 22                	push   $0x22
  801e1e:	e8 0c fc ff ff       	call   801a2f <syscall>
  801e23:	83 c4 18             	add    $0x18,%esp
}
  801e26:	90                   	nop
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	50                   	push   %eax
  801e38:	6a 23                	push   $0x23
  801e3a:	e8 f0 fb ff ff       	call   801a2f <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	90                   	nop
  801e43:	c9                   	leave  
  801e44:	c3                   	ret    

00801e45 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e45:	55                   	push   %ebp
  801e46:	89 e5                	mov    %esp,%ebp
  801e48:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e4b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e4e:	8d 50 04             	lea    0x4(%eax),%edx
  801e51:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	52                   	push   %edx
  801e5b:	50                   	push   %eax
  801e5c:	6a 24                	push   $0x24
  801e5e:	e8 cc fb ff ff       	call   801a2f <syscall>
  801e63:	83 c4 18             	add    $0x18,%esp
	return result;
  801e66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e6f:	89 01                	mov    %eax,(%ecx)
  801e71:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e74:	8b 45 08             	mov    0x8(%ebp),%eax
  801e77:	c9                   	leave  
  801e78:	c2 04 00             	ret    $0x4

00801e7b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	ff 75 10             	pushl  0x10(%ebp)
  801e85:	ff 75 0c             	pushl  0xc(%ebp)
  801e88:	ff 75 08             	pushl  0x8(%ebp)
  801e8b:	6a 13                	push   $0x13
  801e8d:	e8 9d fb ff ff       	call   801a2f <syscall>
  801e92:	83 c4 18             	add    $0x18,%esp
	return ;
  801e95:	90                   	nop
}
  801e96:	c9                   	leave  
  801e97:	c3                   	ret    

00801e98 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e98:	55                   	push   %ebp
  801e99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 25                	push   $0x25
  801ea7:	e8 83 fb ff ff       	call   801a2f <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
  801eb4:	83 ec 04             	sub    $0x4,%esp
  801eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ebd:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	50                   	push   %eax
  801eca:	6a 26                	push   $0x26
  801ecc:	e8 5e fb ff ff       	call   801a2f <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed4:	90                   	nop
}
  801ed5:	c9                   	leave  
  801ed6:	c3                   	ret    

00801ed7 <rsttst>:
void rsttst()
{
  801ed7:	55                   	push   %ebp
  801ed8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 28                	push   $0x28
  801ee6:	e8 44 fb ff ff       	call   801a2f <syscall>
  801eeb:	83 c4 18             	add    $0x18,%esp
	return ;
  801eee:	90                   	nop
}
  801eef:	c9                   	leave  
  801ef0:	c3                   	ret    

00801ef1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
  801ef4:	83 ec 04             	sub    $0x4,%esp
  801ef7:	8b 45 14             	mov    0x14(%ebp),%eax
  801efa:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801efd:	8b 55 18             	mov    0x18(%ebp),%edx
  801f00:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f04:	52                   	push   %edx
  801f05:	50                   	push   %eax
  801f06:	ff 75 10             	pushl  0x10(%ebp)
  801f09:	ff 75 0c             	pushl  0xc(%ebp)
  801f0c:	ff 75 08             	pushl  0x8(%ebp)
  801f0f:	6a 27                	push   $0x27
  801f11:	e8 19 fb ff ff       	call   801a2f <syscall>
  801f16:	83 c4 18             	add    $0x18,%esp
	return ;
  801f19:	90                   	nop
}
  801f1a:	c9                   	leave  
  801f1b:	c3                   	ret    

00801f1c <chktst>:
void chktst(uint32 n)
{
  801f1c:	55                   	push   %ebp
  801f1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	ff 75 08             	pushl  0x8(%ebp)
  801f2a:	6a 29                	push   $0x29
  801f2c:	e8 fe fa ff ff       	call   801a2f <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
	return ;
  801f34:	90                   	nop
}
  801f35:	c9                   	leave  
  801f36:	c3                   	ret    

00801f37 <inctst>:

void inctst()
{
  801f37:	55                   	push   %ebp
  801f38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	6a 2a                	push   $0x2a
  801f46:	e8 e4 fa ff ff       	call   801a2f <syscall>
  801f4b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4e:	90                   	nop
}
  801f4f:	c9                   	leave  
  801f50:	c3                   	ret    

00801f51 <gettst>:
uint32 gettst()
{
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 2b                	push   $0x2b
  801f60:	e8 ca fa ff ff       	call   801a2f <syscall>
  801f65:	83 c4 18             	add    $0x18,%esp
}
  801f68:	c9                   	leave  
  801f69:	c3                   	ret    

00801f6a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f6a:	55                   	push   %ebp
  801f6b:	89 e5                	mov    %esp,%ebp
  801f6d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 2c                	push   $0x2c
  801f7c:	e8 ae fa ff ff       	call   801a2f <syscall>
  801f81:	83 c4 18             	add    $0x18,%esp
  801f84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f87:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f8b:	75 07                	jne    801f94 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f8d:	b8 01 00 00 00       	mov    $0x1,%eax
  801f92:	eb 05                	jmp    801f99 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
  801f9e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fa1:	6a 00                	push   $0x0
  801fa3:	6a 00                	push   $0x0
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 2c                	push   $0x2c
  801fad:	e8 7d fa ff ff       	call   801a2f <syscall>
  801fb2:	83 c4 18             	add    $0x18,%esp
  801fb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fb8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fbc:	75 07                	jne    801fc5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801fc3:	eb 05                	jmp    801fca <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fc5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fca:	c9                   	leave  
  801fcb:	c3                   	ret    

00801fcc <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fcc:	55                   	push   %ebp
  801fcd:	89 e5                	mov    %esp,%ebp
  801fcf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 2c                	push   $0x2c
  801fde:	e8 4c fa ff ff       	call   801a2f <syscall>
  801fe3:	83 c4 18             	add    $0x18,%esp
  801fe6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fe9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fed:	75 07                	jne    801ff6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fef:	b8 01 00 00 00       	mov    $0x1,%eax
  801ff4:	eb 05                	jmp    801ffb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ff6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ffb:	c9                   	leave  
  801ffc:	c3                   	ret    

00801ffd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ffd:	55                   	push   %ebp
  801ffe:	89 e5                	mov    %esp,%ebp
  802000:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 2c                	push   $0x2c
  80200f:	e8 1b fa ff ff       	call   801a2f <syscall>
  802014:	83 c4 18             	add    $0x18,%esp
  802017:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80201a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80201e:	75 07                	jne    802027 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802020:	b8 01 00 00 00       	mov    $0x1,%eax
  802025:	eb 05                	jmp    80202c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802027:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80202c:	c9                   	leave  
  80202d:	c3                   	ret    

0080202e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80202e:	55                   	push   %ebp
  80202f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	ff 75 08             	pushl  0x8(%ebp)
  80203c:	6a 2d                	push   $0x2d
  80203e:	e8 ec f9 ff ff       	call   801a2f <syscall>
  802043:	83 c4 18             	add    $0x18,%esp
	return ;
  802046:	90                   	nop
}
  802047:	c9                   	leave  
  802048:	c3                   	ret    
  802049:	66 90                	xchg   %ax,%ax
  80204b:	90                   	nop

0080204c <__udivdi3>:
  80204c:	55                   	push   %ebp
  80204d:	57                   	push   %edi
  80204e:	56                   	push   %esi
  80204f:	53                   	push   %ebx
  802050:	83 ec 1c             	sub    $0x1c,%esp
  802053:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802057:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80205b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80205f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802063:	89 ca                	mov    %ecx,%edx
  802065:	89 f8                	mov    %edi,%eax
  802067:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80206b:	85 f6                	test   %esi,%esi
  80206d:	75 2d                	jne    80209c <__udivdi3+0x50>
  80206f:	39 cf                	cmp    %ecx,%edi
  802071:	77 65                	ja     8020d8 <__udivdi3+0x8c>
  802073:	89 fd                	mov    %edi,%ebp
  802075:	85 ff                	test   %edi,%edi
  802077:	75 0b                	jne    802084 <__udivdi3+0x38>
  802079:	b8 01 00 00 00       	mov    $0x1,%eax
  80207e:	31 d2                	xor    %edx,%edx
  802080:	f7 f7                	div    %edi
  802082:	89 c5                	mov    %eax,%ebp
  802084:	31 d2                	xor    %edx,%edx
  802086:	89 c8                	mov    %ecx,%eax
  802088:	f7 f5                	div    %ebp
  80208a:	89 c1                	mov    %eax,%ecx
  80208c:	89 d8                	mov    %ebx,%eax
  80208e:	f7 f5                	div    %ebp
  802090:	89 cf                	mov    %ecx,%edi
  802092:	89 fa                	mov    %edi,%edx
  802094:	83 c4 1c             	add    $0x1c,%esp
  802097:	5b                   	pop    %ebx
  802098:	5e                   	pop    %esi
  802099:	5f                   	pop    %edi
  80209a:	5d                   	pop    %ebp
  80209b:	c3                   	ret    
  80209c:	39 ce                	cmp    %ecx,%esi
  80209e:	77 28                	ja     8020c8 <__udivdi3+0x7c>
  8020a0:	0f bd fe             	bsr    %esi,%edi
  8020a3:	83 f7 1f             	xor    $0x1f,%edi
  8020a6:	75 40                	jne    8020e8 <__udivdi3+0x9c>
  8020a8:	39 ce                	cmp    %ecx,%esi
  8020aa:	72 0a                	jb     8020b6 <__udivdi3+0x6a>
  8020ac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020b0:	0f 87 9e 00 00 00    	ja     802154 <__udivdi3+0x108>
  8020b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020bb:	89 fa                	mov    %edi,%edx
  8020bd:	83 c4 1c             	add    $0x1c,%esp
  8020c0:	5b                   	pop    %ebx
  8020c1:	5e                   	pop    %esi
  8020c2:	5f                   	pop    %edi
  8020c3:	5d                   	pop    %ebp
  8020c4:	c3                   	ret    
  8020c5:	8d 76 00             	lea    0x0(%esi),%esi
  8020c8:	31 ff                	xor    %edi,%edi
  8020ca:	31 c0                	xor    %eax,%eax
  8020cc:	89 fa                	mov    %edi,%edx
  8020ce:	83 c4 1c             	add    $0x1c,%esp
  8020d1:	5b                   	pop    %ebx
  8020d2:	5e                   	pop    %esi
  8020d3:	5f                   	pop    %edi
  8020d4:	5d                   	pop    %ebp
  8020d5:	c3                   	ret    
  8020d6:	66 90                	xchg   %ax,%ax
  8020d8:	89 d8                	mov    %ebx,%eax
  8020da:	f7 f7                	div    %edi
  8020dc:	31 ff                	xor    %edi,%edi
  8020de:	89 fa                	mov    %edi,%edx
  8020e0:	83 c4 1c             	add    $0x1c,%esp
  8020e3:	5b                   	pop    %ebx
  8020e4:	5e                   	pop    %esi
  8020e5:	5f                   	pop    %edi
  8020e6:	5d                   	pop    %ebp
  8020e7:	c3                   	ret    
  8020e8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020ed:	89 eb                	mov    %ebp,%ebx
  8020ef:	29 fb                	sub    %edi,%ebx
  8020f1:	89 f9                	mov    %edi,%ecx
  8020f3:	d3 e6                	shl    %cl,%esi
  8020f5:	89 c5                	mov    %eax,%ebp
  8020f7:	88 d9                	mov    %bl,%cl
  8020f9:	d3 ed                	shr    %cl,%ebp
  8020fb:	89 e9                	mov    %ebp,%ecx
  8020fd:	09 f1                	or     %esi,%ecx
  8020ff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802103:	89 f9                	mov    %edi,%ecx
  802105:	d3 e0                	shl    %cl,%eax
  802107:	89 c5                	mov    %eax,%ebp
  802109:	89 d6                	mov    %edx,%esi
  80210b:	88 d9                	mov    %bl,%cl
  80210d:	d3 ee                	shr    %cl,%esi
  80210f:	89 f9                	mov    %edi,%ecx
  802111:	d3 e2                	shl    %cl,%edx
  802113:	8b 44 24 08          	mov    0x8(%esp),%eax
  802117:	88 d9                	mov    %bl,%cl
  802119:	d3 e8                	shr    %cl,%eax
  80211b:	09 c2                	or     %eax,%edx
  80211d:	89 d0                	mov    %edx,%eax
  80211f:	89 f2                	mov    %esi,%edx
  802121:	f7 74 24 0c          	divl   0xc(%esp)
  802125:	89 d6                	mov    %edx,%esi
  802127:	89 c3                	mov    %eax,%ebx
  802129:	f7 e5                	mul    %ebp
  80212b:	39 d6                	cmp    %edx,%esi
  80212d:	72 19                	jb     802148 <__udivdi3+0xfc>
  80212f:	74 0b                	je     80213c <__udivdi3+0xf0>
  802131:	89 d8                	mov    %ebx,%eax
  802133:	31 ff                	xor    %edi,%edi
  802135:	e9 58 ff ff ff       	jmp    802092 <__udivdi3+0x46>
  80213a:	66 90                	xchg   %ax,%ax
  80213c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802140:	89 f9                	mov    %edi,%ecx
  802142:	d3 e2                	shl    %cl,%edx
  802144:	39 c2                	cmp    %eax,%edx
  802146:	73 e9                	jae    802131 <__udivdi3+0xe5>
  802148:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80214b:	31 ff                	xor    %edi,%edi
  80214d:	e9 40 ff ff ff       	jmp    802092 <__udivdi3+0x46>
  802152:	66 90                	xchg   %ax,%ax
  802154:	31 c0                	xor    %eax,%eax
  802156:	e9 37 ff ff ff       	jmp    802092 <__udivdi3+0x46>
  80215b:	90                   	nop

0080215c <__umoddi3>:
  80215c:	55                   	push   %ebp
  80215d:	57                   	push   %edi
  80215e:	56                   	push   %esi
  80215f:	53                   	push   %ebx
  802160:	83 ec 1c             	sub    $0x1c,%esp
  802163:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802167:	8b 74 24 34          	mov    0x34(%esp),%esi
  80216b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80216f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802173:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802177:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80217b:	89 f3                	mov    %esi,%ebx
  80217d:	89 fa                	mov    %edi,%edx
  80217f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802183:	89 34 24             	mov    %esi,(%esp)
  802186:	85 c0                	test   %eax,%eax
  802188:	75 1a                	jne    8021a4 <__umoddi3+0x48>
  80218a:	39 f7                	cmp    %esi,%edi
  80218c:	0f 86 a2 00 00 00    	jbe    802234 <__umoddi3+0xd8>
  802192:	89 c8                	mov    %ecx,%eax
  802194:	89 f2                	mov    %esi,%edx
  802196:	f7 f7                	div    %edi
  802198:	89 d0                	mov    %edx,%eax
  80219a:	31 d2                	xor    %edx,%edx
  80219c:	83 c4 1c             	add    $0x1c,%esp
  80219f:	5b                   	pop    %ebx
  8021a0:	5e                   	pop    %esi
  8021a1:	5f                   	pop    %edi
  8021a2:	5d                   	pop    %ebp
  8021a3:	c3                   	ret    
  8021a4:	39 f0                	cmp    %esi,%eax
  8021a6:	0f 87 ac 00 00 00    	ja     802258 <__umoddi3+0xfc>
  8021ac:	0f bd e8             	bsr    %eax,%ebp
  8021af:	83 f5 1f             	xor    $0x1f,%ebp
  8021b2:	0f 84 ac 00 00 00    	je     802264 <__umoddi3+0x108>
  8021b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8021bd:	29 ef                	sub    %ebp,%edi
  8021bf:	89 fe                	mov    %edi,%esi
  8021c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021c5:	89 e9                	mov    %ebp,%ecx
  8021c7:	d3 e0                	shl    %cl,%eax
  8021c9:	89 d7                	mov    %edx,%edi
  8021cb:	89 f1                	mov    %esi,%ecx
  8021cd:	d3 ef                	shr    %cl,%edi
  8021cf:	09 c7                	or     %eax,%edi
  8021d1:	89 e9                	mov    %ebp,%ecx
  8021d3:	d3 e2                	shl    %cl,%edx
  8021d5:	89 14 24             	mov    %edx,(%esp)
  8021d8:	89 d8                	mov    %ebx,%eax
  8021da:	d3 e0                	shl    %cl,%eax
  8021dc:	89 c2                	mov    %eax,%edx
  8021de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e2:	d3 e0                	shl    %cl,%eax
  8021e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ec:	89 f1                	mov    %esi,%ecx
  8021ee:	d3 e8                	shr    %cl,%eax
  8021f0:	09 d0                	or     %edx,%eax
  8021f2:	d3 eb                	shr    %cl,%ebx
  8021f4:	89 da                	mov    %ebx,%edx
  8021f6:	f7 f7                	div    %edi
  8021f8:	89 d3                	mov    %edx,%ebx
  8021fa:	f7 24 24             	mull   (%esp)
  8021fd:	89 c6                	mov    %eax,%esi
  8021ff:	89 d1                	mov    %edx,%ecx
  802201:	39 d3                	cmp    %edx,%ebx
  802203:	0f 82 87 00 00 00    	jb     802290 <__umoddi3+0x134>
  802209:	0f 84 91 00 00 00    	je     8022a0 <__umoddi3+0x144>
  80220f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802213:	29 f2                	sub    %esi,%edx
  802215:	19 cb                	sbb    %ecx,%ebx
  802217:	89 d8                	mov    %ebx,%eax
  802219:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80221d:	d3 e0                	shl    %cl,%eax
  80221f:	89 e9                	mov    %ebp,%ecx
  802221:	d3 ea                	shr    %cl,%edx
  802223:	09 d0                	or     %edx,%eax
  802225:	89 e9                	mov    %ebp,%ecx
  802227:	d3 eb                	shr    %cl,%ebx
  802229:	89 da                	mov    %ebx,%edx
  80222b:	83 c4 1c             	add    $0x1c,%esp
  80222e:	5b                   	pop    %ebx
  80222f:	5e                   	pop    %esi
  802230:	5f                   	pop    %edi
  802231:	5d                   	pop    %ebp
  802232:	c3                   	ret    
  802233:	90                   	nop
  802234:	89 fd                	mov    %edi,%ebp
  802236:	85 ff                	test   %edi,%edi
  802238:	75 0b                	jne    802245 <__umoddi3+0xe9>
  80223a:	b8 01 00 00 00       	mov    $0x1,%eax
  80223f:	31 d2                	xor    %edx,%edx
  802241:	f7 f7                	div    %edi
  802243:	89 c5                	mov    %eax,%ebp
  802245:	89 f0                	mov    %esi,%eax
  802247:	31 d2                	xor    %edx,%edx
  802249:	f7 f5                	div    %ebp
  80224b:	89 c8                	mov    %ecx,%eax
  80224d:	f7 f5                	div    %ebp
  80224f:	89 d0                	mov    %edx,%eax
  802251:	e9 44 ff ff ff       	jmp    80219a <__umoddi3+0x3e>
  802256:	66 90                	xchg   %ax,%ax
  802258:	89 c8                	mov    %ecx,%eax
  80225a:	89 f2                	mov    %esi,%edx
  80225c:	83 c4 1c             	add    $0x1c,%esp
  80225f:	5b                   	pop    %ebx
  802260:	5e                   	pop    %esi
  802261:	5f                   	pop    %edi
  802262:	5d                   	pop    %ebp
  802263:	c3                   	ret    
  802264:	3b 04 24             	cmp    (%esp),%eax
  802267:	72 06                	jb     80226f <__umoddi3+0x113>
  802269:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80226d:	77 0f                	ja     80227e <__umoddi3+0x122>
  80226f:	89 f2                	mov    %esi,%edx
  802271:	29 f9                	sub    %edi,%ecx
  802273:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802277:	89 14 24             	mov    %edx,(%esp)
  80227a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80227e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802282:	8b 14 24             	mov    (%esp),%edx
  802285:	83 c4 1c             	add    $0x1c,%esp
  802288:	5b                   	pop    %ebx
  802289:	5e                   	pop    %esi
  80228a:	5f                   	pop    %edi
  80228b:	5d                   	pop    %ebp
  80228c:	c3                   	ret    
  80228d:	8d 76 00             	lea    0x0(%esi),%esi
  802290:	2b 04 24             	sub    (%esp),%eax
  802293:	19 fa                	sbb    %edi,%edx
  802295:	89 d1                	mov    %edx,%ecx
  802297:	89 c6                	mov    %eax,%esi
  802299:	e9 71 ff ff ff       	jmp    80220f <__umoddi3+0xb3>
  80229e:	66 90                	xchg   %ax,%ax
  8022a0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022a4:	72 ea                	jb     802290 <__umoddi3+0x134>
  8022a6:	89 d9                	mov    %ebx,%ecx
  8022a8:	e9 62 ff ff ff       	jmp    80220f <__umoddi3+0xb3>
