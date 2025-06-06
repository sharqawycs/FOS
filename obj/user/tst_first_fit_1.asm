
obj/user/tst_first_fit_1:     file format elf32-i386


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
  800031:	e8 b4 0b 00 00       	call   800bea <libmain>
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
  800045:	e8 6f 25 00 00       	call   8025b9 <sys_set_uheap_strategy>
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
  80009b:	68 40 28 80 00       	push   $0x802840
  8000a0:	6a 15                	push   $0x15
  8000a2:	68 5c 28 80 00       	push   $0x80285c
  8000a7:	e8 40 0c 00 00       	call   800cec <_panic>
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
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cb:	e8 56 20 00 00       	call   802126 <sys_calculate_free_frames>
  8000d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d3:	e8 d1 20 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8000d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  8000db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000de:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e1:	83 ec 0c             	sub    $0xc,%esp
  8000e4:	50                   	push   %eax
  8000e5:	e8 7a 1c 00 00       	call   801d64 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f0:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f3:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000f8:	74 14                	je     80010e <_main+0xd6>
  8000fa:	83 ec 04             	sub    $0x4,%esp
  8000fd:	68 74 28 80 00       	push   $0x802874
  800102:	6a 23                	push   $0x23
  800104:	68 5c 28 80 00       	push   $0x80285c
  800109:	e8 de 0b 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80010e:	e8 96 20 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800113:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800116:	3d 00 01 00 00       	cmp    $0x100,%eax
  80011b:	74 14                	je     800131 <_main+0xf9>
  80011d:	83 ec 04             	sub    $0x4,%esp
  800120:	68 a4 28 80 00       	push   $0x8028a4
  800125:	6a 25                	push   $0x25
  800127:	68 5c 28 80 00       	push   $0x80285c
  80012c:	e8 bb 0b 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800131:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800134:	e8 ed 1f 00 00       	call   802126 <sys_calculate_free_frames>
  800139:	29 c3                	sub    %eax,%ebx
  80013b:	89 d8                	mov    %ebx,%eax
  80013d:	83 f8 01             	cmp    $0x1,%eax
  800140:	74 14                	je     800156 <_main+0x11e>
  800142:	83 ec 04             	sub    $0x4,%esp
  800145:	68 c1 28 80 00       	push   $0x8028c1
  80014a:	6a 26                	push   $0x26
  80014c:	68 5c 28 80 00       	push   $0x80285c
  800151:	e8 96 0b 00 00       	call   800cec <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800156:	e8 cb 1f 00 00       	call   802126 <sys_calculate_free_frames>
  80015b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80015e:	e8 46 20 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800163:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800166:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800169:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80016c:	83 ec 0c             	sub    $0xc,%esp
  80016f:	50                   	push   %eax
  800170:	e8 ef 1b 00 00       	call   801d64 <malloc>
  800175:	83 c4 10             	add    $0x10,%esp
  800178:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80017b:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80017e:	89 c2                	mov    %eax,%edx
  800180:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800183:	05 00 00 00 80       	add    $0x80000000,%eax
  800188:	39 c2                	cmp    %eax,%edx
  80018a:	74 14                	je     8001a0 <_main+0x168>
  80018c:	83 ec 04             	sub    $0x4,%esp
  80018f:	68 74 28 80 00       	push   $0x802874
  800194:	6a 2c                	push   $0x2c
  800196:	68 5c 28 80 00       	push   $0x80285c
  80019b:	e8 4c 0b 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8001a0:	e8 04 20 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8001a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001a8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001ad:	74 14                	je     8001c3 <_main+0x18b>
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	68 a4 28 80 00       	push   $0x8028a4
  8001b7:	6a 2e                	push   $0x2e
  8001b9:	68 5c 28 80 00       	push   $0x80285c
  8001be:	e8 29 0b 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8001c3:	e8 5e 1f 00 00       	call   802126 <sys_calculate_free_frames>
  8001c8:	89 c2                	mov    %eax,%edx
  8001ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001cd:	39 c2                	cmp    %eax,%edx
  8001cf:	74 14                	je     8001e5 <_main+0x1ad>
  8001d1:	83 ec 04             	sub    $0x4,%esp
  8001d4:	68 c1 28 80 00       	push   $0x8028c1
  8001d9:	6a 2f                	push   $0x2f
  8001db:	68 5c 28 80 00       	push   $0x80285c
  8001e0:	e8 07 0b 00 00       	call   800cec <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001e5:	e8 3c 1f 00 00       	call   802126 <sys_calculate_free_frames>
  8001ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001ed:	e8 b7 1f 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8001f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001f8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001fb:	83 ec 0c             	sub    $0xc,%esp
  8001fe:	50                   	push   %eax
  8001ff:	e8 60 1b 00 00       	call   801d64 <malloc>
  800204:	83 c4 10             	add    $0x10,%esp
  800207:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  80020a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80020d:	89 c2                	mov    %eax,%edx
  80020f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800212:	01 c0                	add    %eax,%eax
  800214:	05 00 00 00 80       	add    $0x80000000,%eax
  800219:	39 c2                	cmp    %eax,%edx
  80021b:	74 14                	je     800231 <_main+0x1f9>
  80021d:	83 ec 04             	sub    $0x4,%esp
  800220:	68 74 28 80 00       	push   $0x802874
  800225:	6a 35                	push   $0x35
  800227:	68 5c 28 80 00       	push   $0x80285c
  80022c:	e8 bb 0a 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800231:	e8 73 1f 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800236:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800239:	3d 00 01 00 00       	cmp    $0x100,%eax
  80023e:	74 14                	je     800254 <_main+0x21c>
  800240:	83 ec 04             	sub    $0x4,%esp
  800243:	68 a4 28 80 00       	push   $0x8028a4
  800248:	6a 37                	push   $0x37
  80024a:	68 5c 28 80 00       	push   $0x80285c
  80024f:	e8 98 0a 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800254:	e8 cd 1e 00 00       	call   802126 <sys_calculate_free_frames>
  800259:	89 c2                	mov    %eax,%edx
  80025b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025e:	39 c2                	cmp    %eax,%edx
  800260:	74 14                	je     800276 <_main+0x23e>
  800262:	83 ec 04             	sub    $0x4,%esp
  800265:	68 c1 28 80 00       	push   $0x8028c1
  80026a:	6a 38                	push   $0x38
  80026c:	68 5c 28 80 00       	push   $0x80285c
  800271:	e8 76 0a 00 00       	call   800cec <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800276:	e8 ab 1e 00 00       	call   802126 <sys_calculate_free_frames>
  80027b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80027e:	e8 26 1f 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800283:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800286:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800289:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	50                   	push   %eax
  800290:	e8 cf 1a 00 00       	call   801d64 <malloc>
  800295:	83 c4 10             	add    $0x10,%esp
  800298:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  80029b:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80029e:	89 c1                	mov    %eax,%ecx
  8002a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a3:	89 c2                	mov    %eax,%edx
  8002a5:	01 d2                	add    %edx,%edx
  8002a7:	01 d0                	add    %edx,%eax
  8002a9:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ae:	39 c1                	cmp    %eax,%ecx
  8002b0:	74 14                	je     8002c6 <_main+0x28e>
  8002b2:	83 ec 04             	sub    $0x4,%esp
  8002b5:	68 74 28 80 00       	push   $0x802874
  8002ba:	6a 3e                	push   $0x3e
  8002bc:	68 5c 28 80 00       	push   $0x80285c
  8002c1:	e8 26 0a 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002c6:	e8 de 1e 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8002cb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002ce:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002d3:	74 14                	je     8002e9 <_main+0x2b1>
  8002d5:	83 ec 04             	sub    $0x4,%esp
  8002d8:	68 a4 28 80 00       	push   $0x8028a4
  8002dd:	6a 40                	push   $0x40
  8002df:	68 5c 28 80 00       	push   $0x80285c
  8002e4:	e8 03 0a 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002e9:	e8 38 1e 00 00       	call   802126 <sys_calculate_free_frames>
  8002ee:	89 c2                	mov    %eax,%edx
  8002f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002f3:	39 c2                	cmp    %eax,%edx
  8002f5:	74 14                	je     80030b <_main+0x2d3>
  8002f7:	83 ec 04             	sub    $0x4,%esp
  8002fa:	68 c1 28 80 00       	push   $0x8028c1
  8002ff:	6a 41                	push   $0x41
  800301:	68 5c 28 80 00       	push   $0x80285c
  800306:	e8 e1 09 00 00       	call   800cec <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  80030b:	e8 16 1e 00 00       	call   802126 <sys_calculate_free_frames>
  800310:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800313:	e8 91 1e 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800318:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  80031b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80031e:	01 c0                	add    %eax,%eax
  800320:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	50                   	push   %eax
  800327:	e8 38 1a 00 00       	call   801d64 <malloc>
  80032c:	83 c4 10             	add    $0x10,%esp
  80032f:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800332:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800335:	89 c2                	mov    %eax,%edx
  800337:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80033a:	c1 e0 02             	shl    $0x2,%eax
  80033d:	05 00 00 00 80       	add    $0x80000000,%eax
  800342:	39 c2                	cmp    %eax,%edx
  800344:	74 14                	je     80035a <_main+0x322>
  800346:	83 ec 04             	sub    $0x4,%esp
  800349:	68 74 28 80 00       	push   $0x802874
  80034e:	6a 47                	push   $0x47
  800350:	68 5c 28 80 00       	push   $0x80285c
  800355:	e8 92 09 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80035a:	e8 4a 1e 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80035f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800362:	3d 00 02 00 00       	cmp    $0x200,%eax
  800367:	74 14                	je     80037d <_main+0x345>
  800369:	83 ec 04             	sub    $0x4,%esp
  80036c:	68 a4 28 80 00       	push   $0x8028a4
  800371:	6a 49                	push   $0x49
  800373:	68 5c 28 80 00       	push   $0x80285c
  800378:	e8 6f 09 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80037d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800380:	e8 a1 1d 00 00       	call   802126 <sys_calculate_free_frames>
  800385:	29 c3                	sub    %eax,%ebx
  800387:	89 d8                	mov    %ebx,%eax
  800389:	83 f8 01             	cmp    $0x1,%eax
  80038c:	74 14                	je     8003a2 <_main+0x36a>
  80038e:	83 ec 04             	sub    $0x4,%esp
  800391:	68 c1 28 80 00       	push   $0x8028c1
  800396:	6a 4a                	push   $0x4a
  800398:	68 5c 28 80 00       	push   $0x80285c
  80039d:	e8 4a 09 00 00       	call   800cec <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8003a2:	e8 7f 1d 00 00       	call   802126 <sys_calculate_free_frames>
  8003a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003aa:	e8 fa 1d 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8003af:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  8003b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003b5:	01 c0                	add    %eax,%eax
  8003b7:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003ba:	83 ec 0c             	sub    $0xc,%esp
  8003bd:	50                   	push   %eax
  8003be:	e8 a1 19 00 00       	call   801d64 <malloc>
  8003c3:	83 c4 10             	add    $0x10,%esp
  8003c6:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  8003c9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003cc:	89 c1                	mov    %eax,%ecx
  8003ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003d1:	89 d0                	mov    %edx,%eax
  8003d3:	01 c0                	add    %eax,%eax
  8003d5:	01 d0                	add    %edx,%eax
  8003d7:	01 c0                	add    %eax,%eax
  8003d9:	05 00 00 00 80       	add    $0x80000000,%eax
  8003de:	39 c1                	cmp    %eax,%ecx
  8003e0:	74 14                	je     8003f6 <_main+0x3be>
  8003e2:	83 ec 04             	sub    $0x4,%esp
  8003e5:	68 74 28 80 00       	push   $0x802874
  8003ea:	6a 50                	push   $0x50
  8003ec:	68 5c 28 80 00       	push   $0x80285c
  8003f1:	e8 f6 08 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8003f6:	e8 ae 1d 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8003fb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003fe:	3d 00 02 00 00       	cmp    $0x200,%eax
  800403:	74 14                	je     800419 <_main+0x3e1>
  800405:	83 ec 04             	sub    $0x4,%esp
  800408:	68 a4 28 80 00       	push   $0x8028a4
  80040d:	6a 52                	push   $0x52
  80040f:	68 5c 28 80 00       	push   $0x80285c
  800414:	e8 d3 08 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800419:	e8 08 1d 00 00       	call   802126 <sys_calculate_free_frames>
  80041e:	89 c2                	mov    %eax,%edx
  800420:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800423:	39 c2                	cmp    %eax,%edx
  800425:	74 14                	je     80043b <_main+0x403>
  800427:	83 ec 04             	sub    $0x4,%esp
  80042a:	68 c1 28 80 00       	push   $0x8028c1
  80042f:	6a 53                	push   $0x53
  800431:	68 5c 28 80 00       	push   $0x80285c
  800436:	e8 b1 08 00 00       	call   800cec <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80043b:	e8 e6 1c 00 00       	call   802126 <sys_calculate_free_frames>
  800440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800443:	e8 61 1d 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800448:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  80044b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80044e:	89 c2                	mov    %eax,%edx
  800450:	01 d2                	add    %edx,%edx
  800452:	01 d0                	add    %edx,%eax
  800454:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800457:	83 ec 0c             	sub    $0xc,%esp
  80045a:	50                   	push   %eax
  80045b:	e8 04 19 00 00       	call   801d64 <malloc>
  800460:	83 c4 10             	add    $0x10,%esp
  800463:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800466:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800469:	89 c2                	mov    %eax,%edx
  80046b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046e:	c1 e0 03             	shl    $0x3,%eax
  800471:	05 00 00 00 80       	add    $0x80000000,%eax
  800476:	39 c2                	cmp    %eax,%edx
  800478:	74 14                	je     80048e <_main+0x456>
  80047a:	83 ec 04             	sub    $0x4,%esp
  80047d:	68 74 28 80 00       	push   $0x802874
  800482:	6a 59                	push   $0x59
  800484:	68 5c 28 80 00       	push   $0x80285c
  800489:	e8 5e 08 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  80048e:	e8 16 1d 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800493:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800496:	3d 00 03 00 00       	cmp    $0x300,%eax
  80049b:	74 14                	je     8004b1 <_main+0x479>
  80049d:	83 ec 04             	sub    $0x4,%esp
  8004a0:	68 a4 28 80 00       	push   $0x8028a4
  8004a5:	6a 5b                	push   $0x5b
  8004a7:	68 5c 28 80 00       	push   $0x80285c
  8004ac:	e8 3b 08 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004b1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004b4:	e8 6d 1c 00 00       	call   802126 <sys_calculate_free_frames>
  8004b9:	29 c3                	sub    %eax,%ebx
  8004bb:	89 d8                	mov    %ebx,%eax
  8004bd:	83 f8 01             	cmp    $0x1,%eax
  8004c0:	74 14                	je     8004d6 <_main+0x49e>
  8004c2:	83 ec 04             	sub    $0x4,%esp
  8004c5:	68 c1 28 80 00       	push   $0x8028c1
  8004ca:	6a 5c                	push   $0x5c
  8004cc:	68 5c 28 80 00       	push   $0x80285c
  8004d1:	e8 16 08 00 00       	call   800cec <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004d6:	e8 4b 1c 00 00       	call   802126 <sys_calculate_free_frames>
  8004db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004de:	e8 c6 1c 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8004e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  8004e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004e9:	89 c2                	mov    %eax,%edx
  8004eb:	01 d2                	add    %edx,%edx
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004f2:	83 ec 0c             	sub    $0xc,%esp
  8004f5:	50                   	push   %eax
  8004f6:	e8 69 18 00 00       	call   801d64 <malloc>
  8004fb:	83 c4 10             	add    $0x10,%esp
  8004fe:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  800501:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800504:	89 c1                	mov    %eax,%ecx
  800506:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800509:	89 d0                	mov    %edx,%eax
  80050b:	c1 e0 02             	shl    $0x2,%eax
  80050e:	01 d0                	add    %edx,%eax
  800510:	01 c0                	add    %eax,%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	05 00 00 00 80       	add    $0x80000000,%eax
  800519:	39 c1                	cmp    %eax,%ecx
  80051b:	74 14                	je     800531 <_main+0x4f9>
  80051d:	83 ec 04             	sub    $0x4,%esp
  800520:	68 74 28 80 00       	push   $0x802874
  800525:	6a 62                	push   $0x62
  800527:	68 5c 28 80 00       	push   $0x80285c
  80052c:	e8 bb 07 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  800531:	e8 73 1c 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800536:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800539:	3d 00 03 00 00       	cmp    $0x300,%eax
  80053e:	74 14                	je     800554 <_main+0x51c>
  800540:	83 ec 04             	sub    $0x4,%esp
  800543:	68 a4 28 80 00       	push   $0x8028a4
  800548:	6a 64                	push   $0x64
  80054a:	68 5c 28 80 00       	push   $0x80285c
  80054f:	e8 98 07 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800554:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800557:	e8 ca 1b 00 00       	call   802126 <sys_calculate_free_frames>
  80055c:	29 c3                	sub    %eax,%ebx
  80055e:	89 d8                	mov    %ebx,%eax
  800560:	83 f8 01             	cmp    $0x1,%eax
  800563:	74 14                	je     800579 <_main+0x541>
  800565:	83 ec 04             	sub    $0x4,%esp
  800568:	68 c1 28 80 00       	push   $0x8028c1
  80056d:	6a 65                	push   $0x65
  80056f:	68 5c 28 80 00       	push   $0x80285c
  800574:	e8 73 07 00 00       	call   800cec <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800579:	e8 a8 1b 00 00       	call   802126 <sys_calculate_free_frames>
  80057e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800581:	e8 23 1c 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800586:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800589:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80058c:	83 ec 0c             	sub    $0xc,%esp
  80058f:	50                   	push   %eax
  800590:	e8 f0 18 00 00       	call   801e85 <free>
  800595:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800598:	e8 0c 1c 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80059d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a0:	29 c2                	sub    %eax,%edx
  8005a2:	89 d0                	mov    %edx,%eax
  8005a4:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005a9:	74 14                	je     8005bf <_main+0x587>
  8005ab:	83 ec 04             	sub    $0x4,%esp
  8005ae:	68 d4 28 80 00       	push   $0x8028d4
  8005b3:	6a 6f                	push   $0x6f
  8005b5:	68 5c 28 80 00       	push   $0x80285c
  8005ba:	e8 2d 07 00 00       	call   800cec <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005bf:	e8 62 1b 00 00       	call   802126 <sys_calculate_free_frames>
  8005c4:	89 c2                	mov    %eax,%edx
  8005c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005c9:	39 c2                	cmp    %eax,%edx
  8005cb:	74 14                	je     8005e1 <_main+0x5a9>
  8005cd:	83 ec 04             	sub    $0x4,%esp
  8005d0:	68 eb 28 80 00       	push   $0x8028eb
  8005d5:	6a 70                	push   $0x70
  8005d7:	68 5c 28 80 00       	push   $0x80285c
  8005dc:	e8 0b 07 00 00       	call   800cec <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005e1:	e8 40 1b 00 00       	call   802126 <sys_calculate_free_frames>
  8005e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005e9:	e8 bb 1b 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8005ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  8005f1:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8005f4:	83 ec 0c             	sub    $0xc,%esp
  8005f7:	50                   	push   %eax
  8005f8:	e8 88 18 00 00       	call   801e85 <free>
  8005fd:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  800600:	e8 a4 1b 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800605:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800608:	29 c2                	sub    %eax,%edx
  80060a:	89 d0                	mov    %edx,%eax
  80060c:	3d 00 02 00 00       	cmp    $0x200,%eax
  800611:	74 14                	je     800627 <_main+0x5ef>
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 d4 28 80 00       	push   $0x8028d4
  80061b:	6a 77                	push   $0x77
  80061d:	68 5c 28 80 00       	push   $0x80285c
  800622:	e8 c5 06 00 00       	call   800cec <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800627:	e8 fa 1a 00 00       	call   802126 <sys_calculate_free_frames>
  80062c:	89 c2                	mov    %eax,%edx
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	39 c2                	cmp    %eax,%edx
  800633:	74 14                	je     800649 <_main+0x611>
  800635:	83 ec 04             	sub    $0x4,%esp
  800638:	68 eb 28 80 00       	push   $0x8028eb
  80063d:	6a 78                	push   $0x78
  80063f:	68 5c 28 80 00       	push   $0x80285c
  800644:	e8 a3 06 00 00       	call   800cec <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800649:	e8 d8 1a 00 00       	call   802126 <sys_calculate_free_frames>
  80064e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800651:	e8 53 1b 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800656:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  800659:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80065c:	83 ec 0c             	sub    $0xc,%esp
  80065f:	50                   	push   %eax
  800660:	e8 20 18 00 00       	call   801e85 <free>
  800665:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800668:	e8 3c 1b 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80066d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800670:	29 c2                	sub    %eax,%edx
  800672:	89 d0                	mov    %edx,%eax
  800674:	3d 00 03 00 00       	cmp    $0x300,%eax
  800679:	74 14                	je     80068f <_main+0x657>
  80067b:	83 ec 04             	sub    $0x4,%esp
  80067e:	68 d4 28 80 00       	push   $0x8028d4
  800683:	6a 7f                	push   $0x7f
  800685:	68 5c 28 80 00       	push   $0x80285c
  80068a:	e8 5d 06 00 00       	call   800cec <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80068f:	e8 92 1a 00 00       	call   802126 <sys_calculate_free_frames>
  800694:	89 c2                	mov    %eax,%edx
  800696:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800699:	39 c2                	cmp    %eax,%edx
  80069b:	74 17                	je     8006b4 <_main+0x67c>
  80069d:	83 ec 04             	sub    $0x4,%esp
  8006a0:	68 eb 28 80 00       	push   $0x8028eb
  8006a5:	68 80 00 00 00       	push   $0x80
  8006aa:	68 5c 28 80 00       	push   $0x80285c
  8006af:	e8 38 06 00 00       	call   800cec <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006b4:	e8 6d 1a 00 00       	call   802126 <sys_calculate_free_frames>
  8006b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006bc:	e8 e8 1a 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8006c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006c4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006c7:	89 d0                	mov    %edx,%eax
  8006c9:	c1 e0 09             	shl    $0x9,%eax
  8006cc:	29 d0                	sub    %edx,%eax
  8006ce:	83 ec 0c             	sub    $0xc,%esp
  8006d1:	50                   	push   %eax
  8006d2:	e8 8d 16 00 00       	call   801d64 <malloc>
  8006d7:	83 c4 10             	add    $0x10,%esp
  8006da:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006dd:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006e0:	89 c2                	mov    %eax,%edx
  8006e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006e5:	05 00 00 00 80       	add    $0x80000000,%eax
  8006ea:	39 c2                	cmp    %eax,%edx
  8006ec:	74 17                	je     800705 <_main+0x6cd>
  8006ee:	83 ec 04             	sub    $0x4,%esp
  8006f1:	68 74 28 80 00       	push   $0x802874
  8006f6:	68 89 00 00 00       	push   $0x89
  8006fb:	68 5c 28 80 00       	push   $0x80285c
  800700:	e8 e7 05 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800705:	e8 9f 1a 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80070a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80070d:	3d 80 00 00 00       	cmp    $0x80,%eax
  800712:	74 17                	je     80072b <_main+0x6f3>
  800714:	83 ec 04             	sub    $0x4,%esp
  800717:	68 a4 28 80 00       	push   $0x8028a4
  80071c:	68 8b 00 00 00       	push   $0x8b
  800721:	68 5c 28 80 00       	push   $0x80285c
  800726:	e8 c1 05 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80072b:	e8 f6 19 00 00       	call   802126 <sys_calculate_free_frames>
  800730:	89 c2                	mov    %eax,%edx
  800732:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800735:	39 c2                	cmp    %eax,%edx
  800737:	74 17                	je     800750 <_main+0x718>
  800739:	83 ec 04             	sub    $0x4,%esp
  80073c:	68 c1 28 80 00       	push   $0x8028c1
  800741:	68 8c 00 00 00       	push   $0x8c
  800746:	68 5c 28 80 00       	push   $0x80285c
  80074b:	e8 9c 05 00 00       	call   800cec <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800750:	e8 d1 19 00 00       	call   802126 <sys_calculate_free_frames>
  800755:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800758:	e8 4c 1a 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80075d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800760:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800763:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800766:	83 ec 0c             	sub    $0xc,%esp
  800769:	50                   	push   %eax
  80076a:	e8 f5 15 00 00       	call   801d64 <malloc>
  80076f:	83 c4 10             	add    $0x10,%esp
  800772:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800775:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800778:	89 c2                	mov    %eax,%edx
  80077a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077d:	c1 e0 02             	shl    $0x2,%eax
  800780:	05 00 00 00 80       	add    $0x80000000,%eax
  800785:	39 c2                	cmp    %eax,%edx
  800787:	74 17                	je     8007a0 <_main+0x768>
  800789:	83 ec 04             	sub    $0x4,%esp
  80078c:	68 74 28 80 00       	push   $0x802874
  800791:	68 92 00 00 00       	push   $0x92
  800796:	68 5c 28 80 00       	push   $0x80285c
  80079b:	e8 4c 05 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007a0:	e8 04 1a 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8007a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007a8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007ad:	74 17                	je     8007c6 <_main+0x78e>
  8007af:	83 ec 04             	sub    $0x4,%esp
  8007b2:	68 a4 28 80 00       	push   $0x8028a4
  8007b7:	68 94 00 00 00       	push   $0x94
  8007bc:	68 5c 28 80 00       	push   $0x80285c
  8007c1:	e8 26 05 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007c6:	e8 5b 19 00 00       	call   802126 <sys_calculate_free_frames>
  8007cb:	89 c2                	mov    %eax,%edx
  8007cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007d0:	39 c2                	cmp    %eax,%edx
  8007d2:	74 17                	je     8007eb <_main+0x7b3>
  8007d4:	83 ec 04             	sub    $0x4,%esp
  8007d7:	68 c1 28 80 00       	push   $0x8028c1
  8007dc:	68 95 00 00 00       	push   $0x95
  8007e1:	68 5c 28 80 00       	push   $0x80285c
  8007e6:	e8 01 05 00 00       	call   800cec <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007eb:	e8 36 19 00 00       	call   802126 <sys_calculate_free_frames>
  8007f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8007f3:	e8 b1 19 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8007f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  8007fb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007fe:	89 d0                	mov    %edx,%eax
  800800:	c1 e0 08             	shl    $0x8,%eax
  800803:	29 d0                	sub    %edx,%eax
  800805:	83 ec 0c             	sub    $0xc,%esp
  800808:	50                   	push   %eax
  800809:	e8 56 15 00 00       	call   801d64 <malloc>
  80080e:	83 c4 10             	add    $0x10,%esp
  800811:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800814:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800817:	89 c2                	mov    %eax,%edx
  800819:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081c:	c1 e0 09             	shl    $0x9,%eax
  80081f:	89 c1                	mov    %eax,%ecx
  800821:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800824:	01 c8                	add    %ecx,%eax
  800826:	05 00 00 00 80       	add    $0x80000000,%eax
  80082b:	39 c2                	cmp    %eax,%edx
  80082d:	74 17                	je     800846 <_main+0x80e>
  80082f:	83 ec 04             	sub    $0x4,%esp
  800832:	68 74 28 80 00       	push   $0x802874
  800837:	68 9b 00 00 00       	push   $0x9b
  80083c:	68 5c 28 80 00       	push   $0x80285c
  800841:	e8 a6 04 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800846:	e8 5e 19 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80084b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80084e:	83 f8 40             	cmp    $0x40,%eax
  800851:	74 17                	je     80086a <_main+0x832>
  800853:	83 ec 04             	sub    $0x4,%esp
  800856:	68 a4 28 80 00       	push   $0x8028a4
  80085b:	68 9d 00 00 00       	push   $0x9d
  800860:	68 5c 28 80 00       	push   $0x80285c
  800865:	e8 82 04 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80086a:	e8 b7 18 00 00       	call   802126 <sys_calculate_free_frames>
  80086f:	89 c2                	mov    %eax,%edx
  800871:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800874:	39 c2                	cmp    %eax,%edx
  800876:	74 17                	je     80088f <_main+0x857>
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	68 c1 28 80 00       	push   $0x8028c1
  800880:	68 9e 00 00 00       	push   $0x9e
  800885:	68 5c 28 80 00       	push   $0x80285c
  80088a:	e8 5d 04 00 00       	call   800cec <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80088f:	e8 92 18 00 00       	call   802126 <sys_calculate_free_frames>
  800894:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800897:	e8 0d 19 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80089c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  80089f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a2:	01 c0                	add    %eax,%eax
  8008a4:	83 ec 0c             	sub    $0xc,%esp
  8008a7:	50                   	push   %eax
  8008a8:	e8 b7 14 00 00       	call   801d64 <malloc>
  8008ad:	83 c4 10             	add    $0x10,%esp
  8008b0:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008b3:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008b6:	89 c2                	mov    %eax,%edx
  8008b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008bb:	c1 e0 03             	shl    $0x3,%eax
  8008be:	05 00 00 00 80       	add    $0x80000000,%eax
  8008c3:	39 c2                	cmp    %eax,%edx
  8008c5:	74 17                	je     8008de <_main+0x8a6>
  8008c7:	83 ec 04             	sub    $0x4,%esp
  8008ca:	68 74 28 80 00       	push   $0x802874
  8008cf:	68 a4 00 00 00       	push   $0xa4
  8008d4:	68 5c 28 80 00       	push   $0x80285c
  8008d9:	e8 0e 04 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008de:	e8 c6 18 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8008e3:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e6:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008eb:	74 17                	je     800904 <_main+0x8cc>
  8008ed:	83 ec 04             	sub    $0x4,%esp
  8008f0:	68 a4 28 80 00       	push   $0x8028a4
  8008f5:	68 a6 00 00 00       	push   $0xa6
  8008fa:	68 5c 28 80 00       	push   $0x80285c
  8008ff:	e8 e8 03 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800904:	e8 1d 18 00 00       	call   802126 <sys_calculate_free_frames>
  800909:	89 c2                	mov    %eax,%edx
  80090b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80090e:	39 c2                	cmp    %eax,%edx
  800910:	74 17                	je     800929 <_main+0x8f1>
  800912:	83 ec 04             	sub    $0x4,%esp
  800915:	68 c1 28 80 00       	push   $0x8028c1
  80091a:	68 a7 00 00 00       	push   $0xa7
  80091f:	68 5c 28 80 00       	push   $0x80285c
  800924:	e8 c3 03 00 00       	call   800cec <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800929:	e8 f8 17 00 00       	call   802126 <sys_calculate_free_frames>
  80092e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800931:	e8 73 18 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800936:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  800939:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80093c:	c1 e0 02             	shl    $0x2,%eax
  80093f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800942:	83 ec 0c             	sub    $0xc,%esp
  800945:	50                   	push   %eax
  800946:	e8 19 14 00 00       	call   801d64 <malloc>
  80094b:	83 c4 10             	add    $0x10,%esp
  80094e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  800951:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800954:	89 c1                	mov    %eax,%ecx
  800956:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800959:	89 d0                	mov    %edx,%eax
  80095b:	01 c0                	add    %eax,%eax
  80095d:	01 d0                	add    %edx,%eax
  80095f:	01 c0                	add    %eax,%eax
  800961:	01 d0                	add    %edx,%eax
  800963:	01 c0                	add    %eax,%eax
  800965:	05 00 00 00 80       	add    $0x80000000,%eax
  80096a:	39 c1                	cmp    %eax,%ecx
  80096c:	74 17                	je     800985 <_main+0x94d>
  80096e:	83 ec 04             	sub    $0x4,%esp
  800971:	68 74 28 80 00       	push   $0x802874
  800976:	68 ad 00 00 00       	push   $0xad
  80097b:	68 5c 28 80 00       	push   $0x80285c
  800980:	e8 67 03 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800985:	e8 1f 18 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  80098a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80098d:	3d 00 04 00 00       	cmp    $0x400,%eax
  800992:	74 17                	je     8009ab <_main+0x973>
  800994:	83 ec 04             	sub    $0x4,%esp
  800997:	68 a4 28 80 00       	push   $0x8028a4
  80099c:	68 af 00 00 00       	push   $0xaf
  8009a1:	68 5c 28 80 00       	push   $0x80285c
  8009a6:	e8 41 03 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8009ab:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8009ae:	e8 73 17 00 00       	call   802126 <sys_calculate_free_frames>
  8009b3:	29 c3                	sub    %eax,%ebx
  8009b5:	89 d8                	mov    %ebx,%eax
  8009b7:	83 f8 01             	cmp    $0x1,%eax
  8009ba:	74 17                	je     8009d3 <_main+0x99b>
  8009bc:	83 ec 04             	sub    $0x4,%esp
  8009bf:	68 c1 28 80 00       	push   $0x8028c1
  8009c4:	68 b0 00 00 00       	push   $0xb0
  8009c9:	68 5c 28 80 00       	push   $0x80285c
  8009ce:	e8 19 03 00 00       	call   800cec <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009d3:	e8 4e 17 00 00       	call   802126 <sys_calculate_free_frames>
  8009d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009db:	e8 c9 17 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8009e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8009e3:	8b 45 98             	mov    -0x68(%ebp),%eax
  8009e6:	83 ec 0c             	sub    $0xc,%esp
  8009e9:	50                   	push   %eax
  8009ea:	e8 96 14 00 00       	call   801e85 <free>
  8009ef:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8009f2:	e8 b2 17 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  8009f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009fa:	29 c2                	sub    %eax,%edx
  8009fc:	89 d0                	mov    %edx,%eax
  8009fe:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a03:	74 17                	je     800a1c <_main+0x9e4>
  800a05:	83 ec 04             	sub    $0x4,%esp
  800a08:	68 d4 28 80 00       	push   $0x8028d4
  800a0d:	68 ba 00 00 00       	push   $0xba
  800a12:	68 5c 28 80 00       	push   $0x80285c
  800a17:	e8 d0 02 00 00       	call   800cec <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a1c:	e8 05 17 00 00       	call   802126 <sys_calculate_free_frames>
  800a21:	89 c2                	mov    %eax,%edx
  800a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a26:	39 c2                	cmp    %eax,%edx
  800a28:	74 17                	je     800a41 <_main+0xa09>
  800a2a:	83 ec 04             	sub    $0x4,%esp
  800a2d:	68 eb 28 80 00       	push   $0x8028eb
  800a32:	68 bb 00 00 00       	push   $0xbb
  800a37:	68 5c 28 80 00       	push   $0x80285c
  800a3c:	e8 ab 02 00 00       	call   800cec <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a41:	e8 e0 16 00 00       	call   802126 <sys_calculate_free_frames>
  800a46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a49:	e8 5b 17 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800a4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[9]);
  800a51:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800a54:	83 ec 0c             	sub    $0xc,%esp
  800a57:	50                   	push   %eax
  800a58:	e8 28 14 00 00       	call   801e85 <free>
  800a5d:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a60:	e8 44 17 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800a65:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a68:	29 c2                	sub    %eax,%edx
  800a6a:	89 d0                	mov    %edx,%eax
  800a6c:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a71:	74 17                	je     800a8a <_main+0xa52>
  800a73:	83 ec 04             	sub    $0x4,%esp
  800a76:	68 d4 28 80 00       	push   $0x8028d4
  800a7b:	68 c2 00 00 00       	push   $0xc2
  800a80:	68 5c 28 80 00       	push   $0x80285c
  800a85:	e8 62 02 00 00       	call   800cec <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a8a:	e8 97 16 00 00       	call   802126 <sys_calculate_free_frames>
  800a8f:	89 c2                	mov    %eax,%edx
  800a91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a94:	39 c2                	cmp    %eax,%edx
  800a96:	74 17                	je     800aaf <_main+0xa77>
  800a98:	83 ec 04             	sub    $0x4,%esp
  800a9b:	68 eb 28 80 00       	push   $0x8028eb
  800aa0:	68 c3 00 00 00       	push   $0xc3
  800aa5:	68 5c 28 80 00       	push   $0x80285c
  800aaa:	e8 3d 02 00 00       	call   800cec <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800aaf:	e8 72 16 00 00       	call   802126 <sys_calculate_free_frames>
  800ab4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab7:	e8 ed 16 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800abc:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800abf:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800ac2:	83 ec 0c             	sub    $0xc,%esp
  800ac5:	50                   	push   %eax
  800ac6:	e8 ba 13 00 00       	call   801e85 <free>
  800acb:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800ace:	e8 d6 16 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800ad3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ad6:	29 c2                	sub    %eax,%edx
  800ad8:	89 d0                	mov    %edx,%eax
  800ada:	3d 00 01 00 00       	cmp    $0x100,%eax
  800adf:	74 17                	je     800af8 <_main+0xac0>
  800ae1:	83 ec 04             	sub    $0x4,%esp
  800ae4:	68 d4 28 80 00       	push   $0x8028d4
  800ae9:	68 ca 00 00 00       	push   $0xca
  800aee:	68 5c 28 80 00       	push   $0x80285c
  800af3:	e8 f4 01 00 00       	call   800cec <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800af8:	e8 29 16 00 00       	call   802126 <sys_calculate_free_frames>
  800afd:	89 c2                	mov    %eax,%edx
  800aff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b02:	39 c2                	cmp    %eax,%edx
  800b04:	74 17                	je     800b1d <_main+0xae5>
  800b06:	83 ec 04             	sub    $0x4,%esp
  800b09:	68 eb 28 80 00       	push   $0x8028eb
  800b0e:	68 cb 00 00 00       	push   $0xcb
  800b13:	68 5c 28 80 00       	push   $0x80285c
  800b18:	e8 cf 01 00 00       	call   800cec <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 4 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b1d:	e8 04 16 00 00       	call   802126 <sys_calculate_free_frames>
  800b22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b25:	e8 7f 16 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800b2a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[13] = malloc(4*Mega + 256*kilo - kilo);
  800b2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b30:	c1 e0 06             	shl    $0x6,%eax
  800b33:	89 c2                	mov    %eax,%edx
  800b35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b38:	01 d0                	add    %edx,%eax
  800b3a:	c1 e0 02             	shl    $0x2,%eax
  800b3d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800b40:	83 ec 0c             	sub    $0xc,%esp
  800b43:	50                   	push   %eax
  800b44:	e8 1b 12 00 00       	call   801d64 <malloc>
  800b49:	83 c4 10             	add    $0x10,%esp
  800b4c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800b52:	89 c1                	mov    %eax,%ecx
  800b54:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b57:	89 d0                	mov    %edx,%eax
  800b59:	01 c0                	add    %eax,%eax
  800b5b:	01 d0                	add    %edx,%eax
  800b5d:	c1 e0 08             	shl    $0x8,%eax
  800b60:	89 c2                	mov    %eax,%edx
  800b62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b65:	01 d0                	add    %edx,%eax
  800b67:	05 00 00 00 80       	add    $0x80000000,%eax
  800b6c:	39 c1                	cmp    %eax,%ecx
  800b6e:	74 17                	je     800b87 <_main+0xb4f>
  800b70:	83 ec 04             	sub    $0x4,%esp
  800b73:	68 74 28 80 00       	push   $0x802874
  800b78:	68 d5 00 00 00       	push   $0xd5
  800b7d:	68 5c 28 80 00       	push   $0x80285c
  800b82:	e8 65 01 00 00       	call   800cec <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024+64) panic("Wrong page file allocation: ");
  800b87:	e8 1d 16 00 00       	call   8021a9 <sys_pf_calculate_allocated_pages>
  800b8c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800b8f:	3d 40 04 00 00       	cmp    $0x440,%eax
  800b94:	74 17                	je     800bad <_main+0xb75>
  800b96:	83 ec 04             	sub    $0x4,%esp
  800b99:	68 a4 28 80 00       	push   $0x8028a4
  800b9e:	68 d7 00 00 00       	push   $0xd7
  800ba3:	68 5c 28 80 00       	push   $0x80285c
  800ba8:	e8 3f 01 00 00       	call   800cec <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800bad:	e8 74 15 00 00       	call   802126 <sys_calculate_free_frames>
  800bb2:	89 c2                	mov    %eax,%edx
  800bb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800bb7:	39 c2                	cmp    %eax,%edx
  800bb9:	74 17                	je     800bd2 <_main+0xb9a>
  800bbb:	83 ec 04             	sub    $0x4,%esp
  800bbe:	68 c1 28 80 00       	push   $0x8028c1
  800bc3:	68 d8 00 00 00       	push   $0xd8
  800bc8:	68 5c 28 80 00       	push   $0x80285c
  800bcd:	e8 1a 01 00 00       	call   800cec <_panic>
	}
	cprintf("Congratulations!! test FIRST FIT allocation (1) completed successfully.\n");
  800bd2:	83 ec 0c             	sub    $0xc,%esp
  800bd5:	68 f8 28 80 00       	push   $0x8028f8
  800bda:	e8 c1 03 00 00       	call   800fa0 <cprintf>
  800bdf:	83 c4 10             	add    $0x10,%esp

	return;
  800be2:	90                   	nop
}
  800be3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800be6:	5b                   	pop    %ebx
  800be7:	5f                   	pop    %edi
  800be8:	5d                   	pop    %ebp
  800be9:	c3                   	ret    

00800bea <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800bf0:	e8 66 14 00 00       	call   80205b <sys_getenvindex>
  800bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800bf8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bfb:	89 d0                	mov    %edx,%eax
  800bfd:	01 c0                	add    %eax,%eax
  800bff:	01 d0                	add    %edx,%eax
  800c01:	c1 e0 02             	shl    $0x2,%eax
  800c04:	01 d0                	add    %edx,%eax
  800c06:	c1 e0 06             	shl    $0x6,%eax
  800c09:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800c0e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800c13:	a1 20 30 80 00       	mov    0x803020,%eax
  800c18:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800c1e:	84 c0                	test   %al,%al
  800c20:	74 0f                	je     800c31 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800c22:	a1 20 30 80 00       	mov    0x803020,%eax
  800c27:	05 f4 02 00 00       	add    $0x2f4,%eax
  800c2c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800c31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c35:	7e 0a                	jle    800c41 <libmain+0x57>
		binaryname = argv[0];
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	8b 00                	mov    (%eax),%eax
  800c3c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800c41:	83 ec 08             	sub    $0x8,%esp
  800c44:	ff 75 0c             	pushl  0xc(%ebp)
  800c47:	ff 75 08             	pushl  0x8(%ebp)
  800c4a:	e8 e9 f3 ff ff       	call   800038 <_main>
  800c4f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800c52:	e8 9f 15 00 00       	call   8021f6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c57:	83 ec 0c             	sub    $0xc,%esp
  800c5a:	68 5c 29 80 00       	push   $0x80295c
  800c5f:	e8 3c 03 00 00       	call   800fa0 <cprintf>
  800c64:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800c67:	a1 20 30 80 00       	mov    0x803020,%eax
  800c6c:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800c72:	a1 20 30 80 00       	mov    0x803020,%eax
  800c77:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800c7d:	83 ec 04             	sub    $0x4,%esp
  800c80:	52                   	push   %edx
  800c81:	50                   	push   %eax
  800c82:	68 84 29 80 00       	push   $0x802984
  800c87:	e8 14 03 00 00       	call   800fa0 <cprintf>
  800c8c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c8f:	a1 20 30 80 00       	mov    0x803020,%eax
  800c94:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800c9a:	83 ec 08             	sub    $0x8,%esp
  800c9d:	50                   	push   %eax
  800c9e:	68 a9 29 80 00       	push   $0x8029a9
  800ca3:	e8 f8 02 00 00       	call   800fa0 <cprintf>
  800ca8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800cab:	83 ec 0c             	sub    $0xc,%esp
  800cae:	68 5c 29 80 00       	push   $0x80295c
  800cb3:	e8 e8 02 00 00       	call   800fa0 <cprintf>
  800cb8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800cbb:	e8 50 15 00 00       	call   802210 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800cc0:	e8 19 00 00 00       	call   800cde <exit>
}
  800cc5:	90                   	nop
  800cc6:	c9                   	leave  
  800cc7:	c3                   	ret    

00800cc8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
  800ccb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800cce:	83 ec 0c             	sub    $0xc,%esp
  800cd1:	6a 00                	push   $0x0
  800cd3:	e8 4f 13 00 00       	call   802027 <sys_env_destroy>
  800cd8:	83 c4 10             	add    $0x10,%esp
}
  800cdb:	90                   	nop
  800cdc:	c9                   	leave  
  800cdd:	c3                   	ret    

00800cde <exit>:

void
exit(void)
{
  800cde:	55                   	push   %ebp
  800cdf:	89 e5                	mov    %esp,%ebp
  800ce1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800ce4:	e8 a4 13 00 00       	call   80208d <sys_env_exit>
}
  800ce9:	90                   	nop
  800cea:	c9                   	leave  
  800ceb:	c3                   	ret    

00800cec <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800cec:	55                   	push   %ebp
  800ced:	89 e5                	mov    %esp,%ebp
  800cef:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800cf2:	8d 45 10             	lea    0x10(%ebp),%eax
  800cf5:	83 c0 04             	add    $0x4,%eax
  800cf8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800cfb:	a1 30 30 80 00       	mov    0x803030,%eax
  800d00:	85 c0                	test   %eax,%eax
  800d02:	74 16                	je     800d1a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800d04:	a1 30 30 80 00       	mov    0x803030,%eax
  800d09:	83 ec 08             	sub    $0x8,%esp
  800d0c:	50                   	push   %eax
  800d0d:	68 c0 29 80 00       	push   $0x8029c0
  800d12:	e8 89 02 00 00       	call   800fa0 <cprintf>
  800d17:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800d1a:	a1 00 30 80 00       	mov    0x803000,%eax
  800d1f:	ff 75 0c             	pushl  0xc(%ebp)
  800d22:	ff 75 08             	pushl  0x8(%ebp)
  800d25:	50                   	push   %eax
  800d26:	68 c5 29 80 00       	push   $0x8029c5
  800d2b:	e8 70 02 00 00       	call   800fa0 <cprintf>
  800d30:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800d33:	8b 45 10             	mov    0x10(%ebp),%eax
  800d36:	83 ec 08             	sub    $0x8,%esp
  800d39:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3c:	50                   	push   %eax
  800d3d:	e8 f3 01 00 00       	call   800f35 <vcprintf>
  800d42:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	6a 00                	push   $0x0
  800d4a:	68 e1 29 80 00       	push   $0x8029e1
  800d4f:	e8 e1 01 00 00       	call   800f35 <vcprintf>
  800d54:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d57:	e8 82 ff ff ff       	call   800cde <exit>

	// should not return here
	while (1) ;
  800d5c:	eb fe                	jmp    800d5c <_panic+0x70>

00800d5e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d5e:	55                   	push   %ebp
  800d5f:	89 e5                	mov    %esp,%ebp
  800d61:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d64:	a1 20 30 80 00       	mov    0x803020,%eax
  800d69:	8b 50 74             	mov    0x74(%eax),%edx
  800d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6f:	39 c2                	cmp    %eax,%edx
  800d71:	74 14                	je     800d87 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d73:	83 ec 04             	sub    $0x4,%esp
  800d76:	68 e4 29 80 00       	push   $0x8029e4
  800d7b:	6a 26                	push   $0x26
  800d7d:	68 30 2a 80 00       	push   $0x802a30
  800d82:	e8 65 ff ff ff       	call   800cec <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d8e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d95:	e9 c2 00 00 00       	jmp    800e5c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800d9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800da4:	8b 45 08             	mov    0x8(%ebp),%eax
  800da7:	01 d0                	add    %edx,%eax
  800da9:	8b 00                	mov    (%eax),%eax
  800dab:	85 c0                	test   %eax,%eax
  800dad:	75 08                	jne    800db7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800daf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800db2:	e9 a2 00 00 00       	jmp    800e59 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800db7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dbe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800dc5:	eb 69                	jmp    800e30 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800dc7:	a1 20 30 80 00       	mov    0x803020,%eax
  800dcc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800dd2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800dd5:	89 d0                	mov    %edx,%eax
  800dd7:	01 c0                	add    %eax,%eax
  800dd9:	01 d0                	add    %edx,%eax
  800ddb:	c1 e0 02             	shl    $0x2,%eax
  800dde:	01 c8                	add    %ecx,%eax
  800de0:	8a 40 04             	mov    0x4(%eax),%al
  800de3:	84 c0                	test   %al,%al
  800de5:	75 46                	jne    800e2d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800de7:	a1 20 30 80 00       	mov    0x803020,%eax
  800dec:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800df2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800df5:	89 d0                	mov    %edx,%eax
  800df7:	01 c0                	add    %eax,%eax
  800df9:	01 d0                	add    %edx,%eax
  800dfb:	c1 e0 02             	shl    $0x2,%eax
  800dfe:	01 c8                	add    %ecx,%eax
  800e00:	8b 00                	mov    (%eax),%eax
  800e02:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800e05:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800e08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e0d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800e0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e12:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	01 c8                	add    %ecx,%eax
  800e1e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e20:	39 c2                	cmp    %eax,%edx
  800e22:	75 09                	jne    800e2d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800e24:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800e2b:	eb 12                	jmp    800e3f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e2d:	ff 45 e8             	incl   -0x18(%ebp)
  800e30:	a1 20 30 80 00       	mov    0x803020,%eax
  800e35:	8b 50 74             	mov    0x74(%eax),%edx
  800e38:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800e3b:	39 c2                	cmp    %eax,%edx
  800e3d:	77 88                	ja     800dc7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800e3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800e43:	75 14                	jne    800e59 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800e45:	83 ec 04             	sub    $0x4,%esp
  800e48:	68 3c 2a 80 00       	push   $0x802a3c
  800e4d:	6a 3a                	push   $0x3a
  800e4f:	68 30 2a 80 00       	push   $0x802a30
  800e54:	e8 93 fe ff ff       	call   800cec <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e59:	ff 45 f0             	incl   -0x10(%ebp)
  800e5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e5f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e62:	0f 8c 32 ff ff ff    	jl     800d9a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e68:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e6f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e76:	eb 26                	jmp    800e9e <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800e78:	a1 20 30 80 00       	mov    0x803020,%eax
  800e7d:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800e83:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e86:	89 d0                	mov    %edx,%eax
  800e88:	01 c0                	add    %eax,%eax
  800e8a:	01 d0                	add    %edx,%eax
  800e8c:	c1 e0 02             	shl    $0x2,%eax
  800e8f:	01 c8                	add    %ecx,%eax
  800e91:	8a 40 04             	mov    0x4(%eax),%al
  800e94:	3c 01                	cmp    $0x1,%al
  800e96:	75 03                	jne    800e9b <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800e98:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e9b:	ff 45 e0             	incl   -0x20(%ebp)
  800e9e:	a1 20 30 80 00       	mov    0x803020,%eax
  800ea3:	8b 50 74             	mov    0x74(%eax),%edx
  800ea6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ea9:	39 c2                	cmp    %eax,%edx
  800eab:	77 cb                	ja     800e78 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ead:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eb0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800eb3:	74 14                	je     800ec9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800eb5:	83 ec 04             	sub    $0x4,%esp
  800eb8:	68 90 2a 80 00       	push   $0x802a90
  800ebd:	6a 44                	push   $0x44
  800ebf:	68 30 2a 80 00       	push   $0x802a30
  800ec4:	e8 23 fe ff ff       	call   800cec <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ec9:	90                   	nop
  800eca:	c9                   	leave  
  800ecb:	c3                   	ret    

00800ecc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ecc:	55                   	push   %ebp
  800ecd:	89 e5                	mov    %esp,%ebp
  800ecf:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed5:	8b 00                	mov    (%eax),%eax
  800ed7:	8d 48 01             	lea    0x1(%eax),%ecx
  800eda:	8b 55 0c             	mov    0xc(%ebp),%edx
  800edd:	89 0a                	mov    %ecx,(%edx)
  800edf:	8b 55 08             	mov    0x8(%ebp),%edx
  800ee2:	88 d1                	mov    %dl,%cl
  800ee4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eee:	8b 00                	mov    (%eax),%eax
  800ef0:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ef5:	75 2c                	jne    800f23 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ef7:	a0 24 30 80 00       	mov    0x803024,%al
  800efc:	0f b6 c0             	movzbl %al,%eax
  800eff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f02:	8b 12                	mov    (%edx),%edx
  800f04:	89 d1                	mov    %edx,%ecx
  800f06:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f09:	83 c2 08             	add    $0x8,%edx
  800f0c:	83 ec 04             	sub    $0x4,%esp
  800f0f:	50                   	push   %eax
  800f10:	51                   	push   %ecx
  800f11:	52                   	push   %edx
  800f12:	e8 ce 10 00 00       	call   801fe5 <sys_cputs>
  800f17:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800f23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f26:	8b 40 04             	mov    0x4(%eax),%eax
  800f29:	8d 50 01             	lea    0x1(%eax),%edx
  800f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800f32:	90                   	nop
  800f33:	c9                   	leave  
  800f34:	c3                   	ret    

00800f35 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800f35:	55                   	push   %ebp
  800f36:	89 e5                	mov    %esp,%ebp
  800f38:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f3e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f45:	00 00 00 
	b.cnt = 0;
  800f48:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f4f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f52:	ff 75 0c             	pushl  0xc(%ebp)
  800f55:	ff 75 08             	pushl  0x8(%ebp)
  800f58:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f5e:	50                   	push   %eax
  800f5f:	68 cc 0e 80 00       	push   $0x800ecc
  800f64:	e8 11 02 00 00       	call   80117a <vprintfmt>
  800f69:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f6c:	a0 24 30 80 00       	mov    0x803024,%al
  800f71:	0f b6 c0             	movzbl %al,%eax
  800f74:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800f7a:	83 ec 04             	sub    $0x4,%esp
  800f7d:	50                   	push   %eax
  800f7e:	52                   	push   %edx
  800f7f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f85:	83 c0 08             	add    $0x8,%eax
  800f88:	50                   	push   %eax
  800f89:	e8 57 10 00 00       	call   801fe5 <sys_cputs>
  800f8e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f91:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800f98:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f9e:	c9                   	leave  
  800f9f:	c3                   	ret    

00800fa0 <cprintf>:

int cprintf(const char *fmt, ...) {
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
  800fa3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800fa6:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800fad:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	83 ec 08             	sub    $0x8,%esp
  800fb9:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbc:	50                   	push   %eax
  800fbd:	e8 73 ff ff ff       	call   800f35 <vcprintf>
  800fc2:	83 c4 10             	add    $0x10,%esp
  800fc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800fc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fcb:	c9                   	leave  
  800fcc:	c3                   	ret    

00800fcd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800fcd:	55                   	push   %ebp
  800fce:	89 e5                	mov    %esp,%ebp
  800fd0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800fd3:	e8 1e 12 00 00       	call   8021f6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800fd8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fdb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	83 ec 08             	sub    $0x8,%esp
  800fe4:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe7:	50                   	push   %eax
  800fe8:	e8 48 ff ff ff       	call   800f35 <vcprintf>
  800fed:	83 c4 10             	add    $0x10,%esp
  800ff0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ff3:	e8 18 12 00 00       	call   802210 <sys_enable_interrupt>
	return cnt;
  800ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffb:	c9                   	leave  
  800ffc:	c3                   	ret    

00800ffd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ffd:	55                   	push   %ebp
  800ffe:	89 e5                	mov    %esp,%ebp
  801000:	53                   	push   %ebx
  801001:	83 ec 14             	sub    $0x14,%esp
  801004:	8b 45 10             	mov    0x10(%ebp),%eax
  801007:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80100a:	8b 45 14             	mov    0x14(%ebp),%eax
  80100d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801010:	8b 45 18             	mov    0x18(%ebp),%eax
  801013:	ba 00 00 00 00       	mov    $0x0,%edx
  801018:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80101b:	77 55                	ja     801072 <printnum+0x75>
  80101d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801020:	72 05                	jb     801027 <printnum+0x2a>
  801022:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801025:	77 4b                	ja     801072 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801027:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80102a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80102d:	8b 45 18             	mov    0x18(%ebp),%eax
  801030:	ba 00 00 00 00       	mov    $0x0,%edx
  801035:	52                   	push   %edx
  801036:	50                   	push   %eax
  801037:	ff 75 f4             	pushl  -0xc(%ebp)
  80103a:	ff 75 f0             	pushl  -0x10(%ebp)
  80103d:	e8 92 15 00 00       	call   8025d4 <__udivdi3>
  801042:	83 c4 10             	add    $0x10,%esp
  801045:	83 ec 04             	sub    $0x4,%esp
  801048:	ff 75 20             	pushl  0x20(%ebp)
  80104b:	53                   	push   %ebx
  80104c:	ff 75 18             	pushl  0x18(%ebp)
  80104f:	52                   	push   %edx
  801050:	50                   	push   %eax
  801051:	ff 75 0c             	pushl  0xc(%ebp)
  801054:	ff 75 08             	pushl  0x8(%ebp)
  801057:	e8 a1 ff ff ff       	call   800ffd <printnum>
  80105c:	83 c4 20             	add    $0x20,%esp
  80105f:	eb 1a                	jmp    80107b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801061:	83 ec 08             	sub    $0x8,%esp
  801064:	ff 75 0c             	pushl  0xc(%ebp)
  801067:	ff 75 20             	pushl  0x20(%ebp)
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	ff d0                	call   *%eax
  80106f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801072:	ff 4d 1c             	decl   0x1c(%ebp)
  801075:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801079:	7f e6                	jg     801061 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80107b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80107e:	bb 00 00 00 00       	mov    $0x0,%ebx
  801083:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801086:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801089:	53                   	push   %ebx
  80108a:	51                   	push   %ecx
  80108b:	52                   	push   %edx
  80108c:	50                   	push   %eax
  80108d:	e8 52 16 00 00       	call   8026e4 <__umoddi3>
  801092:	83 c4 10             	add    $0x10,%esp
  801095:	05 f4 2c 80 00       	add    $0x802cf4,%eax
  80109a:	8a 00                	mov    (%eax),%al
  80109c:	0f be c0             	movsbl %al,%eax
  80109f:	83 ec 08             	sub    $0x8,%esp
  8010a2:	ff 75 0c             	pushl  0xc(%ebp)
  8010a5:	50                   	push   %eax
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	ff d0                	call   *%eax
  8010ab:	83 c4 10             	add    $0x10,%esp
}
  8010ae:	90                   	nop
  8010af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8010b2:	c9                   	leave  
  8010b3:	c3                   	ret    

008010b4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010b7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010bb:	7e 1c                	jle    8010d9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	8b 00                	mov    (%eax),%eax
  8010c2:	8d 50 08             	lea    0x8(%eax),%edx
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	89 10                	mov    %edx,(%eax)
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8b 00                	mov    (%eax),%eax
  8010cf:	83 e8 08             	sub    $0x8,%eax
  8010d2:	8b 50 04             	mov    0x4(%eax),%edx
  8010d5:	8b 00                	mov    (%eax),%eax
  8010d7:	eb 40                	jmp    801119 <getuint+0x65>
	else if (lflag)
  8010d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010dd:	74 1e                	je     8010fd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	8b 00                	mov    (%eax),%eax
  8010e4:	8d 50 04             	lea    0x4(%eax),%edx
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	89 10                	mov    %edx,(%eax)
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8b 00                	mov    (%eax),%eax
  8010f1:	83 e8 04             	sub    $0x4,%eax
  8010f4:	8b 00                	mov    (%eax),%eax
  8010f6:	ba 00 00 00 00       	mov    $0x0,%edx
  8010fb:	eb 1c                	jmp    801119 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	8b 00                	mov    (%eax),%eax
  801102:	8d 50 04             	lea    0x4(%eax),%edx
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	89 10                	mov    %edx,(%eax)
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	8b 00                	mov    (%eax),%eax
  80110f:	83 e8 04             	sub    $0x4,%eax
  801112:	8b 00                	mov    (%eax),%eax
  801114:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801119:	5d                   	pop    %ebp
  80111a:	c3                   	ret    

0080111b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80111b:	55                   	push   %ebp
  80111c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80111e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801122:	7e 1c                	jle    801140 <getint+0x25>
		return va_arg(*ap, long long);
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	8b 00                	mov    (%eax),%eax
  801129:	8d 50 08             	lea    0x8(%eax),%edx
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	89 10                	mov    %edx,(%eax)
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	8b 00                	mov    (%eax),%eax
  801136:	83 e8 08             	sub    $0x8,%eax
  801139:	8b 50 04             	mov    0x4(%eax),%edx
  80113c:	8b 00                	mov    (%eax),%eax
  80113e:	eb 38                	jmp    801178 <getint+0x5d>
	else if (lflag)
  801140:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801144:	74 1a                	je     801160 <getint+0x45>
		return va_arg(*ap, long);
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	8b 00                	mov    (%eax),%eax
  80114b:	8d 50 04             	lea    0x4(%eax),%edx
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	89 10                	mov    %edx,(%eax)
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	8b 00                	mov    (%eax),%eax
  801158:	83 e8 04             	sub    $0x4,%eax
  80115b:	8b 00                	mov    (%eax),%eax
  80115d:	99                   	cltd   
  80115e:	eb 18                	jmp    801178 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801160:	8b 45 08             	mov    0x8(%ebp),%eax
  801163:	8b 00                	mov    (%eax),%eax
  801165:	8d 50 04             	lea    0x4(%eax),%edx
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	89 10                	mov    %edx,(%eax)
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	8b 00                	mov    (%eax),%eax
  801172:	83 e8 04             	sub    $0x4,%eax
  801175:	8b 00                	mov    (%eax),%eax
  801177:	99                   	cltd   
}
  801178:	5d                   	pop    %ebp
  801179:	c3                   	ret    

0080117a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
  80117d:	56                   	push   %esi
  80117e:	53                   	push   %ebx
  80117f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801182:	eb 17                	jmp    80119b <vprintfmt+0x21>
			if (ch == '\0')
  801184:	85 db                	test   %ebx,%ebx
  801186:	0f 84 af 03 00 00    	je     80153b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80118c:	83 ec 08             	sub    $0x8,%esp
  80118f:	ff 75 0c             	pushl  0xc(%ebp)
  801192:	53                   	push   %ebx
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	ff d0                	call   *%eax
  801198:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80119b:	8b 45 10             	mov    0x10(%ebp),%eax
  80119e:	8d 50 01             	lea    0x1(%eax),%edx
  8011a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8011a4:	8a 00                	mov    (%eax),%al
  8011a6:	0f b6 d8             	movzbl %al,%ebx
  8011a9:	83 fb 25             	cmp    $0x25,%ebx
  8011ac:	75 d6                	jne    801184 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8011ae:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8011b2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8011b9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8011c0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8011c7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8011ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d1:	8d 50 01             	lea    0x1(%eax),%edx
  8011d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8011d7:	8a 00                	mov    (%eax),%al
  8011d9:	0f b6 d8             	movzbl %al,%ebx
  8011dc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8011df:	83 f8 55             	cmp    $0x55,%eax
  8011e2:	0f 87 2b 03 00 00    	ja     801513 <vprintfmt+0x399>
  8011e8:	8b 04 85 18 2d 80 00 	mov    0x802d18(,%eax,4),%eax
  8011ef:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8011f1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8011f5:	eb d7                	jmp    8011ce <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8011f7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8011fb:	eb d1                	jmp    8011ce <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011fd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801204:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801207:	89 d0                	mov    %edx,%eax
  801209:	c1 e0 02             	shl    $0x2,%eax
  80120c:	01 d0                	add    %edx,%eax
  80120e:	01 c0                	add    %eax,%eax
  801210:	01 d8                	add    %ebx,%eax
  801212:	83 e8 30             	sub    $0x30,%eax
  801215:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801218:	8b 45 10             	mov    0x10(%ebp),%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801220:	83 fb 2f             	cmp    $0x2f,%ebx
  801223:	7e 3e                	jle    801263 <vprintfmt+0xe9>
  801225:	83 fb 39             	cmp    $0x39,%ebx
  801228:	7f 39                	jg     801263 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80122a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80122d:	eb d5                	jmp    801204 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80122f:	8b 45 14             	mov    0x14(%ebp),%eax
  801232:	83 c0 04             	add    $0x4,%eax
  801235:	89 45 14             	mov    %eax,0x14(%ebp)
  801238:	8b 45 14             	mov    0x14(%ebp),%eax
  80123b:	83 e8 04             	sub    $0x4,%eax
  80123e:	8b 00                	mov    (%eax),%eax
  801240:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801243:	eb 1f                	jmp    801264 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801245:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801249:	79 83                	jns    8011ce <vprintfmt+0x54>
				width = 0;
  80124b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801252:	e9 77 ff ff ff       	jmp    8011ce <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801257:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80125e:	e9 6b ff ff ff       	jmp    8011ce <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801263:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801264:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801268:	0f 89 60 ff ff ff    	jns    8011ce <vprintfmt+0x54>
				width = precision, precision = -1;
  80126e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801271:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801274:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80127b:	e9 4e ff ff ff       	jmp    8011ce <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801280:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801283:	e9 46 ff ff ff       	jmp    8011ce <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801288:	8b 45 14             	mov    0x14(%ebp),%eax
  80128b:	83 c0 04             	add    $0x4,%eax
  80128e:	89 45 14             	mov    %eax,0x14(%ebp)
  801291:	8b 45 14             	mov    0x14(%ebp),%eax
  801294:	83 e8 04             	sub    $0x4,%eax
  801297:	8b 00                	mov    (%eax),%eax
  801299:	83 ec 08             	sub    $0x8,%esp
  80129c:	ff 75 0c             	pushl  0xc(%ebp)
  80129f:	50                   	push   %eax
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	ff d0                	call   *%eax
  8012a5:	83 c4 10             	add    $0x10,%esp
			break;
  8012a8:	e9 89 02 00 00       	jmp    801536 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8012ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b0:	83 c0 04             	add    $0x4,%eax
  8012b3:	89 45 14             	mov    %eax,0x14(%ebp)
  8012b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b9:	83 e8 04             	sub    $0x4,%eax
  8012bc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8012be:	85 db                	test   %ebx,%ebx
  8012c0:	79 02                	jns    8012c4 <vprintfmt+0x14a>
				err = -err;
  8012c2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8012c4:	83 fb 64             	cmp    $0x64,%ebx
  8012c7:	7f 0b                	jg     8012d4 <vprintfmt+0x15a>
  8012c9:	8b 34 9d 60 2b 80 00 	mov    0x802b60(,%ebx,4),%esi
  8012d0:	85 f6                	test   %esi,%esi
  8012d2:	75 19                	jne    8012ed <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8012d4:	53                   	push   %ebx
  8012d5:	68 05 2d 80 00       	push   $0x802d05
  8012da:	ff 75 0c             	pushl  0xc(%ebp)
  8012dd:	ff 75 08             	pushl  0x8(%ebp)
  8012e0:	e8 5e 02 00 00       	call   801543 <printfmt>
  8012e5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8012e8:	e9 49 02 00 00       	jmp    801536 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8012ed:	56                   	push   %esi
  8012ee:	68 0e 2d 80 00       	push   $0x802d0e
  8012f3:	ff 75 0c             	pushl  0xc(%ebp)
  8012f6:	ff 75 08             	pushl  0x8(%ebp)
  8012f9:	e8 45 02 00 00       	call   801543 <printfmt>
  8012fe:	83 c4 10             	add    $0x10,%esp
			break;
  801301:	e9 30 02 00 00       	jmp    801536 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801306:	8b 45 14             	mov    0x14(%ebp),%eax
  801309:	83 c0 04             	add    $0x4,%eax
  80130c:	89 45 14             	mov    %eax,0x14(%ebp)
  80130f:	8b 45 14             	mov    0x14(%ebp),%eax
  801312:	83 e8 04             	sub    $0x4,%eax
  801315:	8b 30                	mov    (%eax),%esi
  801317:	85 f6                	test   %esi,%esi
  801319:	75 05                	jne    801320 <vprintfmt+0x1a6>
				p = "(null)";
  80131b:	be 11 2d 80 00       	mov    $0x802d11,%esi
			if (width > 0 && padc != '-')
  801320:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801324:	7e 6d                	jle    801393 <vprintfmt+0x219>
  801326:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80132a:	74 67                	je     801393 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80132c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80132f:	83 ec 08             	sub    $0x8,%esp
  801332:	50                   	push   %eax
  801333:	56                   	push   %esi
  801334:	e8 0c 03 00 00       	call   801645 <strnlen>
  801339:	83 c4 10             	add    $0x10,%esp
  80133c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80133f:	eb 16                	jmp    801357 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801341:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801345:	83 ec 08             	sub    $0x8,%esp
  801348:	ff 75 0c             	pushl  0xc(%ebp)
  80134b:	50                   	push   %eax
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	ff d0                	call   *%eax
  801351:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801354:	ff 4d e4             	decl   -0x1c(%ebp)
  801357:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80135b:	7f e4                	jg     801341 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80135d:	eb 34                	jmp    801393 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80135f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801363:	74 1c                	je     801381 <vprintfmt+0x207>
  801365:	83 fb 1f             	cmp    $0x1f,%ebx
  801368:	7e 05                	jle    80136f <vprintfmt+0x1f5>
  80136a:	83 fb 7e             	cmp    $0x7e,%ebx
  80136d:	7e 12                	jle    801381 <vprintfmt+0x207>
					putch('?', putdat);
  80136f:	83 ec 08             	sub    $0x8,%esp
  801372:	ff 75 0c             	pushl  0xc(%ebp)
  801375:	6a 3f                	push   $0x3f
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	ff d0                	call   *%eax
  80137c:	83 c4 10             	add    $0x10,%esp
  80137f:	eb 0f                	jmp    801390 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801381:	83 ec 08             	sub    $0x8,%esp
  801384:	ff 75 0c             	pushl  0xc(%ebp)
  801387:	53                   	push   %ebx
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	ff d0                	call   *%eax
  80138d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801390:	ff 4d e4             	decl   -0x1c(%ebp)
  801393:	89 f0                	mov    %esi,%eax
  801395:	8d 70 01             	lea    0x1(%eax),%esi
  801398:	8a 00                	mov    (%eax),%al
  80139a:	0f be d8             	movsbl %al,%ebx
  80139d:	85 db                	test   %ebx,%ebx
  80139f:	74 24                	je     8013c5 <vprintfmt+0x24b>
  8013a1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013a5:	78 b8                	js     80135f <vprintfmt+0x1e5>
  8013a7:	ff 4d e0             	decl   -0x20(%ebp)
  8013aa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013ae:	79 af                	jns    80135f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013b0:	eb 13                	jmp    8013c5 <vprintfmt+0x24b>
				putch(' ', putdat);
  8013b2:	83 ec 08             	sub    $0x8,%esp
  8013b5:	ff 75 0c             	pushl  0xc(%ebp)
  8013b8:	6a 20                	push   $0x20
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	ff d0                	call   *%eax
  8013bf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013c2:	ff 4d e4             	decl   -0x1c(%ebp)
  8013c5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8013c9:	7f e7                	jg     8013b2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8013cb:	e9 66 01 00 00       	jmp    801536 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8013d0:	83 ec 08             	sub    $0x8,%esp
  8013d3:	ff 75 e8             	pushl  -0x18(%ebp)
  8013d6:	8d 45 14             	lea    0x14(%ebp),%eax
  8013d9:	50                   	push   %eax
  8013da:	e8 3c fd ff ff       	call   80111b <getint>
  8013df:	83 c4 10             	add    $0x10,%esp
  8013e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8013e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013ee:	85 d2                	test   %edx,%edx
  8013f0:	79 23                	jns    801415 <vprintfmt+0x29b>
				putch('-', putdat);
  8013f2:	83 ec 08             	sub    $0x8,%esp
  8013f5:	ff 75 0c             	pushl  0xc(%ebp)
  8013f8:	6a 2d                	push   $0x2d
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	ff d0                	call   *%eax
  8013ff:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801402:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801405:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801408:	f7 d8                	neg    %eax
  80140a:	83 d2 00             	adc    $0x0,%edx
  80140d:	f7 da                	neg    %edx
  80140f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801412:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801415:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80141c:	e9 bc 00 00 00       	jmp    8014dd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801421:	83 ec 08             	sub    $0x8,%esp
  801424:	ff 75 e8             	pushl  -0x18(%ebp)
  801427:	8d 45 14             	lea    0x14(%ebp),%eax
  80142a:	50                   	push   %eax
  80142b:	e8 84 fc ff ff       	call   8010b4 <getuint>
  801430:	83 c4 10             	add    $0x10,%esp
  801433:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801436:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801439:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801440:	e9 98 00 00 00       	jmp    8014dd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801445:	83 ec 08             	sub    $0x8,%esp
  801448:	ff 75 0c             	pushl  0xc(%ebp)
  80144b:	6a 58                	push   $0x58
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	ff d0                	call   *%eax
  801452:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801455:	83 ec 08             	sub    $0x8,%esp
  801458:	ff 75 0c             	pushl  0xc(%ebp)
  80145b:	6a 58                	push   $0x58
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	ff d0                	call   *%eax
  801462:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801465:	83 ec 08             	sub    $0x8,%esp
  801468:	ff 75 0c             	pushl  0xc(%ebp)
  80146b:	6a 58                	push   $0x58
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	ff d0                	call   *%eax
  801472:	83 c4 10             	add    $0x10,%esp
			break;
  801475:	e9 bc 00 00 00       	jmp    801536 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80147a:	83 ec 08             	sub    $0x8,%esp
  80147d:	ff 75 0c             	pushl  0xc(%ebp)
  801480:	6a 30                	push   $0x30
  801482:	8b 45 08             	mov    0x8(%ebp),%eax
  801485:	ff d0                	call   *%eax
  801487:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80148a:	83 ec 08             	sub    $0x8,%esp
  80148d:	ff 75 0c             	pushl  0xc(%ebp)
  801490:	6a 78                	push   $0x78
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	ff d0                	call   *%eax
  801497:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80149a:	8b 45 14             	mov    0x14(%ebp),%eax
  80149d:	83 c0 04             	add    $0x4,%eax
  8014a0:	89 45 14             	mov    %eax,0x14(%ebp)
  8014a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a6:	83 e8 04             	sub    $0x4,%eax
  8014a9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8014ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8014b5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8014bc:	eb 1f                	jmp    8014dd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8014be:	83 ec 08             	sub    $0x8,%esp
  8014c1:	ff 75 e8             	pushl  -0x18(%ebp)
  8014c4:	8d 45 14             	lea    0x14(%ebp),%eax
  8014c7:	50                   	push   %eax
  8014c8:	e8 e7 fb ff ff       	call   8010b4 <getuint>
  8014cd:	83 c4 10             	add    $0x10,%esp
  8014d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8014d6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8014dd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8014e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014e4:	83 ec 04             	sub    $0x4,%esp
  8014e7:	52                   	push   %edx
  8014e8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8014eb:	50                   	push   %eax
  8014ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8014ef:	ff 75 f0             	pushl  -0x10(%ebp)
  8014f2:	ff 75 0c             	pushl  0xc(%ebp)
  8014f5:	ff 75 08             	pushl  0x8(%ebp)
  8014f8:	e8 00 fb ff ff       	call   800ffd <printnum>
  8014fd:	83 c4 20             	add    $0x20,%esp
			break;
  801500:	eb 34                	jmp    801536 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801502:	83 ec 08             	sub    $0x8,%esp
  801505:	ff 75 0c             	pushl  0xc(%ebp)
  801508:	53                   	push   %ebx
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	ff d0                	call   *%eax
  80150e:	83 c4 10             	add    $0x10,%esp
			break;
  801511:	eb 23                	jmp    801536 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801513:	83 ec 08             	sub    $0x8,%esp
  801516:	ff 75 0c             	pushl  0xc(%ebp)
  801519:	6a 25                	push   $0x25
  80151b:	8b 45 08             	mov    0x8(%ebp),%eax
  80151e:	ff d0                	call   *%eax
  801520:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801523:	ff 4d 10             	decl   0x10(%ebp)
  801526:	eb 03                	jmp    80152b <vprintfmt+0x3b1>
  801528:	ff 4d 10             	decl   0x10(%ebp)
  80152b:	8b 45 10             	mov    0x10(%ebp),%eax
  80152e:	48                   	dec    %eax
  80152f:	8a 00                	mov    (%eax),%al
  801531:	3c 25                	cmp    $0x25,%al
  801533:	75 f3                	jne    801528 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801535:	90                   	nop
		}
	}
  801536:	e9 47 fc ff ff       	jmp    801182 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80153b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80153c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80153f:	5b                   	pop    %ebx
  801540:	5e                   	pop    %esi
  801541:	5d                   	pop    %ebp
  801542:	c3                   	ret    

00801543 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801543:	55                   	push   %ebp
  801544:	89 e5                	mov    %esp,%ebp
  801546:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801549:	8d 45 10             	lea    0x10(%ebp),%eax
  80154c:	83 c0 04             	add    $0x4,%eax
  80154f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	ff 75 f4             	pushl  -0xc(%ebp)
  801558:	50                   	push   %eax
  801559:	ff 75 0c             	pushl  0xc(%ebp)
  80155c:	ff 75 08             	pushl  0x8(%ebp)
  80155f:	e8 16 fc ff ff       	call   80117a <vprintfmt>
  801564:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801567:	90                   	nop
  801568:	c9                   	leave  
  801569:	c3                   	ret    

0080156a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80156a:	55                   	push   %ebp
  80156b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80156d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801570:	8b 40 08             	mov    0x8(%eax),%eax
  801573:	8d 50 01             	lea    0x1(%eax),%edx
  801576:	8b 45 0c             	mov    0xc(%ebp),%eax
  801579:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80157c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157f:	8b 10                	mov    (%eax),%edx
  801581:	8b 45 0c             	mov    0xc(%ebp),%eax
  801584:	8b 40 04             	mov    0x4(%eax),%eax
  801587:	39 c2                	cmp    %eax,%edx
  801589:	73 12                	jae    80159d <sprintputch+0x33>
		*b->buf++ = ch;
  80158b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158e:	8b 00                	mov    (%eax),%eax
  801590:	8d 48 01             	lea    0x1(%eax),%ecx
  801593:	8b 55 0c             	mov    0xc(%ebp),%edx
  801596:	89 0a                	mov    %ecx,(%edx)
  801598:	8b 55 08             	mov    0x8(%ebp),%edx
  80159b:	88 10                	mov    %dl,(%eax)
}
  80159d:	90                   	nop
  80159e:	5d                   	pop    %ebp
  80159f:	c3                   	ret    

008015a0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8015a0:	55                   	push   %ebp
  8015a1:	89 e5                	mov    %esp,%ebp
  8015a3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8015a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b5:	01 d0                	add    %edx,%eax
  8015b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8015c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015c5:	74 06                	je     8015cd <vsnprintf+0x2d>
  8015c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015cb:	7f 07                	jg     8015d4 <vsnprintf+0x34>
		return -E_INVAL;
  8015cd:	b8 03 00 00 00       	mov    $0x3,%eax
  8015d2:	eb 20                	jmp    8015f4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8015d4:	ff 75 14             	pushl  0x14(%ebp)
  8015d7:	ff 75 10             	pushl  0x10(%ebp)
  8015da:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8015dd:	50                   	push   %eax
  8015de:	68 6a 15 80 00       	push   $0x80156a
  8015e3:	e8 92 fb ff ff       	call   80117a <vprintfmt>
  8015e8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8015eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015ee:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8015f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
  8015f9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8015fc:	8d 45 10             	lea    0x10(%ebp),%eax
  8015ff:	83 c0 04             	add    $0x4,%eax
  801602:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801605:	8b 45 10             	mov    0x10(%ebp),%eax
  801608:	ff 75 f4             	pushl  -0xc(%ebp)
  80160b:	50                   	push   %eax
  80160c:	ff 75 0c             	pushl  0xc(%ebp)
  80160f:	ff 75 08             	pushl  0x8(%ebp)
  801612:	e8 89 ff ff ff       	call   8015a0 <vsnprintf>
  801617:	83 c4 10             	add    $0x10,%esp
  80161a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80161d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
  801625:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801628:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80162f:	eb 06                	jmp    801637 <strlen+0x15>
		n++;
  801631:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801634:	ff 45 08             	incl   0x8(%ebp)
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	8a 00                	mov    (%eax),%al
  80163c:	84 c0                	test   %al,%al
  80163e:	75 f1                	jne    801631 <strlen+0xf>
		n++;
	return n;
  801640:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
  801648:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80164b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801652:	eb 09                	jmp    80165d <strnlen+0x18>
		n++;
  801654:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801657:	ff 45 08             	incl   0x8(%ebp)
  80165a:	ff 4d 0c             	decl   0xc(%ebp)
  80165d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801661:	74 09                	je     80166c <strnlen+0x27>
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	84 c0                	test   %al,%al
  80166a:	75 e8                	jne    801654 <strnlen+0xf>
		n++;
	return n;
  80166c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80166f:	c9                   	leave  
  801670:	c3                   	ret    

00801671 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801671:	55                   	push   %ebp
  801672:	89 e5                	mov    %esp,%ebp
  801674:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80167d:	90                   	nop
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8d 50 01             	lea    0x1(%eax),%edx
  801684:	89 55 08             	mov    %edx,0x8(%ebp)
  801687:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80168d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801690:	8a 12                	mov    (%edx),%dl
  801692:	88 10                	mov    %dl,(%eax)
  801694:	8a 00                	mov    (%eax),%al
  801696:	84 c0                	test   %al,%al
  801698:	75 e4                	jne    80167e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80169a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80169d:	c9                   	leave  
  80169e:	c3                   	ret    

0080169f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
  8016a2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016b2:	eb 1f                	jmp    8016d3 <strncpy+0x34>
		*dst++ = *src;
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8d 50 01             	lea    0x1(%eax),%edx
  8016ba:	89 55 08             	mov    %edx,0x8(%ebp)
  8016bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c0:	8a 12                	mov    (%edx),%dl
  8016c2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8016c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	84 c0                	test   %al,%al
  8016cb:	74 03                	je     8016d0 <strncpy+0x31>
			src++;
  8016cd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016d0:	ff 45 fc             	incl   -0x4(%ebp)
  8016d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016d6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016d9:	72 d9                	jb     8016b4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8016db:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016de:	c9                   	leave  
  8016df:	c3                   	ret    

008016e0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8016ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016f0:	74 30                	je     801722 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8016f2:	eb 16                	jmp    80170a <strlcpy+0x2a>
			*dst++ = *src++;
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	8d 50 01             	lea    0x1(%eax),%edx
  8016fa:	89 55 08             	mov    %edx,0x8(%ebp)
  8016fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801700:	8d 4a 01             	lea    0x1(%edx),%ecx
  801703:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801706:	8a 12                	mov    (%edx),%dl
  801708:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80170a:	ff 4d 10             	decl   0x10(%ebp)
  80170d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801711:	74 09                	je     80171c <strlcpy+0x3c>
  801713:	8b 45 0c             	mov    0xc(%ebp),%eax
  801716:	8a 00                	mov    (%eax),%al
  801718:	84 c0                	test   %al,%al
  80171a:	75 d8                	jne    8016f4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801722:	8b 55 08             	mov    0x8(%ebp),%edx
  801725:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801728:	29 c2                	sub    %eax,%edx
  80172a:	89 d0                	mov    %edx,%eax
}
  80172c:	c9                   	leave  
  80172d:	c3                   	ret    

0080172e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80172e:	55                   	push   %ebp
  80172f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801731:	eb 06                	jmp    801739 <strcmp+0xb>
		p++, q++;
  801733:	ff 45 08             	incl   0x8(%ebp)
  801736:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	84 c0                	test   %al,%al
  801740:	74 0e                	je     801750 <strcmp+0x22>
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	8a 10                	mov    (%eax),%dl
  801747:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174a:	8a 00                	mov    (%eax),%al
  80174c:	38 c2                	cmp    %al,%dl
  80174e:	74 e3                	je     801733 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	8a 00                	mov    (%eax),%al
  801755:	0f b6 d0             	movzbl %al,%edx
  801758:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	0f b6 c0             	movzbl %al,%eax
  801760:	29 c2                	sub    %eax,%edx
  801762:	89 d0                	mov    %edx,%eax
}
  801764:	5d                   	pop    %ebp
  801765:	c3                   	ret    

00801766 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801769:	eb 09                	jmp    801774 <strncmp+0xe>
		n--, p++, q++;
  80176b:	ff 4d 10             	decl   0x10(%ebp)
  80176e:	ff 45 08             	incl   0x8(%ebp)
  801771:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801774:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801778:	74 17                	je     801791 <strncmp+0x2b>
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	84 c0                	test   %al,%al
  801781:	74 0e                	je     801791 <strncmp+0x2b>
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 10                	mov    (%eax),%dl
  801788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178b:	8a 00                	mov    (%eax),%al
  80178d:	38 c2                	cmp    %al,%dl
  80178f:	74 da                	je     80176b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801791:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801795:	75 07                	jne    80179e <strncmp+0x38>
		return 0;
  801797:	b8 00 00 00 00       	mov    $0x0,%eax
  80179c:	eb 14                	jmp    8017b2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80179e:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a1:	8a 00                	mov    (%eax),%al
  8017a3:	0f b6 d0             	movzbl %al,%edx
  8017a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a9:	8a 00                	mov    (%eax),%al
  8017ab:	0f b6 c0             	movzbl %al,%eax
  8017ae:	29 c2                	sub    %eax,%edx
  8017b0:	89 d0                	mov    %edx,%eax
}
  8017b2:	5d                   	pop    %ebp
  8017b3:	c3                   	ret    

008017b4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 04             	sub    $0x4,%esp
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017c0:	eb 12                	jmp    8017d4 <strchr+0x20>
		if (*s == c)
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017ca:	75 05                	jne    8017d1 <strchr+0x1d>
			return (char *) s;
  8017cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cf:	eb 11                	jmp    8017e2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017d1:	ff 45 08             	incl   0x8(%ebp)
  8017d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d7:	8a 00                	mov    (%eax),%al
  8017d9:	84 c0                	test   %al,%al
  8017db:	75 e5                	jne    8017c2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8017dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 04             	sub    $0x4,%esp
  8017ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017f0:	eb 0d                	jmp    8017ff <strfind+0x1b>
		if (*s == c)
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	8a 00                	mov    (%eax),%al
  8017f7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017fa:	74 0e                	je     80180a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8017fc:	ff 45 08             	incl   0x8(%ebp)
  8017ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801802:	8a 00                	mov    (%eax),%al
  801804:	84 c0                	test   %al,%al
  801806:	75 ea                	jne    8017f2 <strfind+0xe>
  801808:	eb 01                	jmp    80180b <strfind+0x27>
		if (*s == c)
			break;
  80180a:	90                   	nop
	return (char *) s;
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
  801813:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80181c:	8b 45 10             	mov    0x10(%ebp),%eax
  80181f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801822:	eb 0e                	jmp    801832 <memset+0x22>
		*p++ = c;
  801824:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801827:	8d 50 01             	lea    0x1(%eax),%edx
  80182a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80182d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801830:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801832:	ff 4d f8             	decl   -0x8(%ebp)
  801835:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801839:	79 e9                	jns    801824 <memset+0x14>
		*p++ = c;

	return v;
  80183b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801840:	55                   	push   %ebp
  801841:	89 e5                	mov    %esp,%ebp
  801843:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801846:	8b 45 0c             	mov    0xc(%ebp),%eax
  801849:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80184c:	8b 45 08             	mov    0x8(%ebp),%eax
  80184f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801852:	eb 16                	jmp    80186a <memcpy+0x2a>
		*d++ = *s++;
  801854:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801857:	8d 50 01             	lea    0x1(%eax),%edx
  80185a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80185d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801860:	8d 4a 01             	lea    0x1(%edx),%ecx
  801863:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801866:	8a 12                	mov    (%edx),%dl
  801868:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80186a:	8b 45 10             	mov    0x10(%ebp),%eax
  80186d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801870:	89 55 10             	mov    %edx,0x10(%ebp)
  801873:	85 c0                	test   %eax,%eax
  801875:	75 dd                	jne    801854 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801877:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
  80187f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801882:	8b 45 0c             	mov    0xc(%ebp),%eax
  801885:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801888:	8b 45 08             	mov    0x8(%ebp),%eax
  80188b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80188e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801891:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801894:	73 50                	jae    8018e6 <memmove+0x6a>
  801896:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801899:	8b 45 10             	mov    0x10(%ebp),%eax
  80189c:	01 d0                	add    %edx,%eax
  80189e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018a1:	76 43                	jbe    8018e6 <memmove+0x6a>
		s += n;
  8018a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8018a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ac:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018af:	eb 10                	jmp    8018c1 <memmove+0x45>
			*--d = *--s;
  8018b1:	ff 4d f8             	decl   -0x8(%ebp)
  8018b4:	ff 4d fc             	decl   -0x4(%ebp)
  8018b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ba:	8a 10                	mov    (%eax),%dl
  8018bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018bf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8018c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8018ca:	85 c0                	test   %eax,%eax
  8018cc:	75 e3                	jne    8018b1 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8018ce:	eb 23                	jmp    8018f3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8018d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d3:	8d 50 01             	lea    0x1(%eax),%edx
  8018d6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018dc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018df:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8018e2:	8a 12                	mov    (%edx),%dl
  8018e4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8018e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018ec:	89 55 10             	mov    %edx,0x10(%ebp)
  8018ef:	85 c0                	test   %eax,%eax
  8018f1:	75 dd                	jne    8018d0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8018f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018f6:	c9                   	leave  
  8018f7:	c3                   	ret    

008018f8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8018f8:	55                   	push   %ebp
  8018f9:	89 e5                	mov    %esp,%ebp
  8018fb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801901:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801904:	8b 45 0c             	mov    0xc(%ebp),%eax
  801907:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80190a:	eb 2a                	jmp    801936 <memcmp+0x3e>
		if (*s1 != *s2)
  80190c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80190f:	8a 10                	mov    (%eax),%dl
  801911:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801914:	8a 00                	mov    (%eax),%al
  801916:	38 c2                	cmp    %al,%dl
  801918:	74 16                	je     801930 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80191a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80191d:	8a 00                	mov    (%eax),%al
  80191f:	0f b6 d0             	movzbl %al,%edx
  801922:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801925:	8a 00                	mov    (%eax),%al
  801927:	0f b6 c0             	movzbl %al,%eax
  80192a:	29 c2                	sub    %eax,%edx
  80192c:	89 d0                	mov    %edx,%eax
  80192e:	eb 18                	jmp    801948 <memcmp+0x50>
		s1++, s2++;
  801930:	ff 45 fc             	incl   -0x4(%ebp)
  801933:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801936:	8b 45 10             	mov    0x10(%ebp),%eax
  801939:	8d 50 ff             	lea    -0x1(%eax),%edx
  80193c:	89 55 10             	mov    %edx,0x10(%ebp)
  80193f:	85 c0                	test   %eax,%eax
  801941:	75 c9                	jne    80190c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801943:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
  80194d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801950:	8b 55 08             	mov    0x8(%ebp),%edx
  801953:	8b 45 10             	mov    0x10(%ebp),%eax
  801956:	01 d0                	add    %edx,%eax
  801958:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80195b:	eb 15                	jmp    801972 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80195d:	8b 45 08             	mov    0x8(%ebp),%eax
  801960:	8a 00                	mov    (%eax),%al
  801962:	0f b6 d0             	movzbl %al,%edx
  801965:	8b 45 0c             	mov    0xc(%ebp),%eax
  801968:	0f b6 c0             	movzbl %al,%eax
  80196b:	39 c2                	cmp    %eax,%edx
  80196d:	74 0d                	je     80197c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80196f:	ff 45 08             	incl   0x8(%ebp)
  801972:	8b 45 08             	mov    0x8(%ebp),%eax
  801975:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801978:	72 e3                	jb     80195d <memfind+0x13>
  80197a:	eb 01                	jmp    80197d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80197c:	90                   	nop
	return (void *) s;
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801980:	c9                   	leave  
  801981:	c3                   	ret    

00801982 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801982:	55                   	push   %ebp
  801983:	89 e5                	mov    %esp,%ebp
  801985:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801988:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80198f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801996:	eb 03                	jmp    80199b <strtol+0x19>
		s++;
  801998:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	8a 00                	mov    (%eax),%al
  8019a0:	3c 20                	cmp    $0x20,%al
  8019a2:	74 f4                	je     801998 <strtol+0x16>
  8019a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a7:	8a 00                	mov    (%eax),%al
  8019a9:	3c 09                	cmp    $0x9,%al
  8019ab:	74 eb                	je     801998 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	8a 00                	mov    (%eax),%al
  8019b2:	3c 2b                	cmp    $0x2b,%al
  8019b4:	75 05                	jne    8019bb <strtol+0x39>
		s++;
  8019b6:	ff 45 08             	incl   0x8(%ebp)
  8019b9:	eb 13                	jmp    8019ce <strtol+0x4c>
	else if (*s == '-')
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	8a 00                	mov    (%eax),%al
  8019c0:	3c 2d                	cmp    $0x2d,%al
  8019c2:	75 0a                	jne    8019ce <strtol+0x4c>
		s++, neg = 1;
  8019c4:	ff 45 08             	incl   0x8(%ebp)
  8019c7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8019ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019d2:	74 06                	je     8019da <strtol+0x58>
  8019d4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8019d8:	75 20                	jne    8019fa <strtol+0x78>
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	8a 00                	mov    (%eax),%al
  8019df:	3c 30                	cmp    $0x30,%al
  8019e1:	75 17                	jne    8019fa <strtol+0x78>
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	40                   	inc    %eax
  8019e7:	8a 00                	mov    (%eax),%al
  8019e9:	3c 78                	cmp    $0x78,%al
  8019eb:	75 0d                	jne    8019fa <strtol+0x78>
		s += 2, base = 16;
  8019ed:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8019f1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8019f8:	eb 28                	jmp    801a22 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8019fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019fe:	75 15                	jne    801a15 <strtol+0x93>
  801a00:	8b 45 08             	mov    0x8(%ebp),%eax
  801a03:	8a 00                	mov    (%eax),%al
  801a05:	3c 30                	cmp    $0x30,%al
  801a07:	75 0c                	jne    801a15 <strtol+0x93>
		s++, base = 8;
  801a09:	ff 45 08             	incl   0x8(%ebp)
  801a0c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801a13:	eb 0d                	jmp    801a22 <strtol+0xa0>
	else if (base == 0)
  801a15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a19:	75 07                	jne    801a22 <strtol+0xa0>
		base = 10;
  801a1b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801a22:	8b 45 08             	mov    0x8(%ebp),%eax
  801a25:	8a 00                	mov    (%eax),%al
  801a27:	3c 2f                	cmp    $0x2f,%al
  801a29:	7e 19                	jle    801a44 <strtol+0xc2>
  801a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2e:	8a 00                	mov    (%eax),%al
  801a30:	3c 39                	cmp    $0x39,%al
  801a32:	7f 10                	jg     801a44 <strtol+0xc2>
			dig = *s - '0';
  801a34:	8b 45 08             	mov    0x8(%ebp),%eax
  801a37:	8a 00                	mov    (%eax),%al
  801a39:	0f be c0             	movsbl %al,%eax
  801a3c:	83 e8 30             	sub    $0x30,%eax
  801a3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a42:	eb 42                	jmp    801a86 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a44:	8b 45 08             	mov    0x8(%ebp),%eax
  801a47:	8a 00                	mov    (%eax),%al
  801a49:	3c 60                	cmp    $0x60,%al
  801a4b:	7e 19                	jle    801a66 <strtol+0xe4>
  801a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a50:	8a 00                	mov    (%eax),%al
  801a52:	3c 7a                	cmp    $0x7a,%al
  801a54:	7f 10                	jg     801a66 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a56:	8b 45 08             	mov    0x8(%ebp),%eax
  801a59:	8a 00                	mov    (%eax),%al
  801a5b:	0f be c0             	movsbl %al,%eax
  801a5e:	83 e8 57             	sub    $0x57,%eax
  801a61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a64:	eb 20                	jmp    801a86 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a66:	8b 45 08             	mov    0x8(%ebp),%eax
  801a69:	8a 00                	mov    (%eax),%al
  801a6b:	3c 40                	cmp    $0x40,%al
  801a6d:	7e 39                	jle    801aa8 <strtol+0x126>
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	8a 00                	mov    (%eax),%al
  801a74:	3c 5a                	cmp    $0x5a,%al
  801a76:	7f 30                	jg     801aa8 <strtol+0x126>
			dig = *s - 'A' + 10;
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	8a 00                	mov    (%eax),%al
  801a7d:	0f be c0             	movsbl %al,%eax
  801a80:	83 e8 37             	sub    $0x37,%eax
  801a83:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a89:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a8c:	7d 19                	jge    801aa7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a8e:	ff 45 08             	incl   0x8(%ebp)
  801a91:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a94:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a98:	89 c2                	mov    %eax,%edx
  801a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a9d:	01 d0                	add    %edx,%eax
  801a9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801aa2:	e9 7b ff ff ff       	jmp    801a22 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801aa7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801aa8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801aac:	74 08                	je     801ab6 <strtol+0x134>
		*endptr = (char *) s;
  801aae:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab1:	8b 55 08             	mov    0x8(%ebp),%edx
  801ab4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801ab6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801aba:	74 07                	je     801ac3 <strtol+0x141>
  801abc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801abf:	f7 d8                	neg    %eax
  801ac1:	eb 03                	jmp    801ac6 <strtol+0x144>
  801ac3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <ltostr>:

void
ltostr(long value, char *str)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
  801acb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801ace:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801ad5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801adc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ae0:	79 13                	jns    801af5 <ltostr+0x2d>
	{
		neg = 1;
  801ae2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aec:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801aef:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801af2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801af5:	8b 45 08             	mov    0x8(%ebp),%eax
  801af8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801afd:	99                   	cltd   
  801afe:	f7 f9                	idiv   %ecx
  801b00:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801b03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b06:	8d 50 01             	lea    0x1(%eax),%edx
  801b09:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b0c:	89 c2                	mov    %eax,%edx
  801b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b11:	01 d0                	add    %edx,%eax
  801b13:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b16:	83 c2 30             	add    $0x30,%edx
  801b19:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801b1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b1e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b23:	f7 e9                	imul   %ecx
  801b25:	c1 fa 02             	sar    $0x2,%edx
  801b28:	89 c8                	mov    %ecx,%eax
  801b2a:	c1 f8 1f             	sar    $0x1f,%eax
  801b2d:	29 c2                	sub    %eax,%edx
  801b2f:	89 d0                	mov    %edx,%eax
  801b31:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801b34:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b37:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b3c:	f7 e9                	imul   %ecx
  801b3e:	c1 fa 02             	sar    $0x2,%edx
  801b41:	89 c8                	mov    %ecx,%eax
  801b43:	c1 f8 1f             	sar    $0x1f,%eax
  801b46:	29 c2                	sub    %eax,%edx
  801b48:	89 d0                	mov    %edx,%eax
  801b4a:	c1 e0 02             	shl    $0x2,%eax
  801b4d:	01 d0                	add    %edx,%eax
  801b4f:	01 c0                	add    %eax,%eax
  801b51:	29 c1                	sub    %eax,%ecx
  801b53:	89 ca                	mov    %ecx,%edx
  801b55:	85 d2                	test   %edx,%edx
  801b57:	75 9c                	jne    801af5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b59:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b63:	48                   	dec    %eax
  801b64:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b67:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b6b:	74 3d                	je     801baa <ltostr+0xe2>
		start = 1 ;
  801b6d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b74:	eb 34                	jmp    801baa <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801b76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b79:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b7c:	01 d0                	add    %edx,%eax
  801b7e:	8a 00                	mov    (%eax),%al
  801b80:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b83:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b86:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b89:	01 c2                	add    %eax,%edx
  801b8b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b91:	01 c8                	add    %ecx,%eax
  801b93:	8a 00                	mov    (%eax),%al
  801b95:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b97:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b9d:	01 c2                	add    %eax,%edx
  801b9f:	8a 45 eb             	mov    -0x15(%ebp),%al
  801ba2:	88 02                	mov    %al,(%edx)
		start++ ;
  801ba4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801ba7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bb0:	7c c4                	jl     801b76 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801bb2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bb8:	01 d0                	add    %edx,%eax
  801bba:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801bbd:	90                   	nop
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
  801bc3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801bc6:	ff 75 08             	pushl  0x8(%ebp)
  801bc9:	e8 54 fa ff ff       	call   801622 <strlen>
  801bce:	83 c4 04             	add    $0x4,%esp
  801bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801bd4:	ff 75 0c             	pushl  0xc(%ebp)
  801bd7:	e8 46 fa ff ff       	call   801622 <strlen>
  801bdc:	83 c4 04             	add    $0x4,%esp
  801bdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801be2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801be9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bf0:	eb 17                	jmp    801c09 <strcconcat+0x49>
		final[s] = str1[s] ;
  801bf2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bf5:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf8:	01 c2                	add    %eax,%edx
  801bfa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  801c00:	01 c8                	add    %ecx,%eax
  801c02:	8a 00                	mov    (%eax),%al
  801c04:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801c06:	ff 45 fc             	incl   -0x4(%ebp)
  801c09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c0c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c0f:	7c e1                	jl     801bf2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801c11:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801c18:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801c1f:	eb 1f                	jmp    801c40 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801c21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c24:	8d 50 01             	lea    0x1(%eax),%edx
  801c27:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801c2a:	89 c2                	mov    %eax,%edx
  801c2c:	8b 45 10             	mov    0x10(%ebp),%eax
  801c2f:	01 c2                	add    %eax,%edx
  801c31:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801c34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c37:	01 c8                	add    %ecx,%eax
  801c39:	8a 00                	mov    (%eax),%al
  801c3b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c3d:	ff 45 f8             	incl   -0x8(%ebp)
  801c40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c43:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c46:	7c d9                	jl     801c21 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c48:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c4b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c4e:	01 d0                	add    %edx,%eax
  801c50:	c6 00 00             	movb   $0x0,(%eax)
}
  801c53:	90                   	nop
  801c54:	c9                   	leave  
  801c55:	c3                   	ret    

00801c56 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c56:	55                   	push   %ebp
  801c57:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c59:	8b 45 14             	mov    0x14(%ebp),%eax
  801c5c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c62:	8b 45 14             	mov    0x14(%ebp),%eax
  801c65:	8b 00                	mov    (%eax),%eax
  801c67:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c6e:	8b 45 10             	mov    0x10(%ebp),%eax
  801c71:	01 d0                	add    %edx,%eax
  801c73:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c79:	eb 0c                	jmp    801c87 <strsplit+0x31>
			*string++ = 0;
  801c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7e:	8d 50 01             	lea    0x1(%eax),%edx
  801c81:	89 55 08             	mov    %edx,0x8(%ebp)
  801c84:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c87:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8a:	8a 00                	mov    (%eax),%al
  801c8c:	84 c0                	test   %al,%al
  801c8e:	74 18                	je     801ca8 <strsplit+0x52>
  801c90:	8b 45 08             	mov    0x8(%ebp),%eax
  801c93:	8a 00                	mov    (%eax),%al
  801c95:	0f be c0             	movsbl %al,%eax
  801c98:	50                   	push   %eax
  801c99:	ff 75 0c             	pushl  0xc(%ebp)
  801c9c:	e8 13 fb ff ff       	call   8017b4 <strchr>
  801ca1:	83 c4 08             	add    $0x8,%esp
  801ca4:	85 c0                	test   %eax,%eax
  801ca6:	75 d3                	jne    801c7b <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cab:	8a 00                	mov    (%eax),%al
  801cad:	84 c0                	test   %al,%al
  801caf:	74 5a                	je     801d0b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801cb1:	8b 45 14             	mov    0x14(%ebp),%eax
  801cb4:	8b 00                	mov    (%eax),%eax
  801cb6:	83 f8 0f             	cmp    $0xf,%eax
  801cb9:	75 07                	jne    801cc2 <strsplit+0x6c>
		{
			return 0;
  801cbb:	b8 00 00 00 00       	mov    $0x0,%eax
  801cc0:	eb 66                	jmp    801d28 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801cc2:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc5:	8b 00                	mov    (%eax),%eax
  801cc7:	8d 48 01             	lea    0x1(%eax),%ecx
  801cca:	8b 55 14             	mov    0x14(%ebp),%edx
  801ccd:	89 0a                	mov    %ecx,(%edx)
  801ccf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cd6:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd9:	01 c2                	add    %eax,%edx
  801cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cde:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ce0:	eb 03                	jmp    801ce5 <strsplit+0x8f>
			string++;
  801ce2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce8:	8a 00                	mov    (%eax),%al
  801cea:	84 c0                	test   %al,%al
  801cec:	74 8b                	je     801c79 <strsplit+0x23>
  801cee:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf1:	8a 00                	mov    (%eax),%al
  801cf3:	0f be c0             	movsbl %al,%eax
  801cf6:	50                   	push   %eax
  801cf7:	ff 75 0c             	pushl  0xc(%ebp)
  801cfa:	e8 b5 fa ff ff       	call   8017b4 <strchr>
  801cff:	83 c4 08             	add    $0x8,%esp
  801d02:	85 c0                	test   %eax,%eax
  801d04:	74 dc                	je     801ce2 <strsplit+0x8c>
			string++;
	}
  801d06:	e9 6e ff ff ff       	jmp    801c79 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801d0b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801d0c:	8b 45 14             	mov    0x14(%ebp),%eax
  801d0f:	8b 00                	mov    (%eax),%eax
  801d11:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d18:	8b 45 10             	mov    0x10(%ebp),%eax
  801d1b:	01 d0                	add    %edx,%eax
  801d1d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801d23:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d28:	c9                   	leave  
  801d29:	c3                   	ret    

00801d2a <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d2a:	55                   	push   %ebp
  801d2b:	89 e5                	mov    %esp,%ebp
  801d2d:	83 ec 18             	sub    $0x18,%esp
  801d30:	8b 45 10             	mov    0x10(%ebp),%eax
  801d33:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801d36:	83 ec 04             	sub    $0x4,%esp
  801d39:	68 70 2e 80 00       	push   $0x802e70
  801d3e:	6a 17                	push   $0x17
  801d40:	68 8f 2e 80 00       	push   $0x802e8f
  801d45:	e8 a2 ef ff ff       	call   800cec <_panic>

00801d4a <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
  801d4d:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801d50:	83 ec 04             	sub    $0x4,%esp
  801d53:	68 9b 2e 80 00       	push   $0x802e9b
  801d58:	6a 2f                	push   $0x2f
  801d5a:	68 8f 2e 80 00       	push   $0x802e8f
  801d5f:	e8 88 ef ff ff       	call   800cec <_panic>

00801d64 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801d64:	55                   	push   %ebp
  801d65:	89 e5                	mov    %esp,%ebp
  801d67:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801d6a:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801d71:	8b 55 08             	mov    0x8(%ebp),%edx
  801d74:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d77:	01 d0                	add    %edx,%eax
  801d79:	48                   	dec    %eax
  801d7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801d7d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d80:	ba 00 00 00 00       	mov    $0x0,%edx
  801d85:	f7 75 ec             	divl   -0x14(%ebp)
  801d88:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d8b:	29 d0                	sub    %edx,%eax
  801d8d:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801d90:	8b 45 08             	mov    0x8(%ebp),%eax
  801d93:	c1 e8 0c             	shr    $0xc,%eax
  801d96:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801d99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801da0:	e9 c8 00 00 00       	jmp    801e6d <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801da5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801dac:	eb 27                	jmp    801dd5 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801dae:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801db4:	01 c2                	add    %eax,%edx
  801db6:	89 d0                	mov    %edx,%eax
  801db8:	01 c0                	add    %eax,%eax
  801dba:	01 d0                	add    %edx,%eax
  801dbc:	c1 e0 02             	shl    $0x2,%eax
  801dbf:	05 48 30 80 00       	add    $0x803048,%eax
  801dc4:	8b 00                	mov    (%eax),%eax
  801dc6:	85 c0                	test   %eax,%eax
  801dc8:	74 08                	je     801dd2 <malloc+0x6e>
            	i += j;
  801dca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dcd:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801dd0:	eb 0b                	jmp    801ddd <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801dd2:	ff 45 f0             	incl   -0x10(%ebp)
  801dd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dd8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ddb:	72 d1                	jb     801dae <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801de0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801de3:	0f 85 81 00 00 00    	jne    801e6a <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dec:	05 00 00 08 00       	add    $0x80000,%eax
  801df1:	c1 e0 0c             	shl    $0xc,%eax
  801df4:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801df7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801dfe:	eb 1f                	jmp    801e1f <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801e00:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e06:	01 c2                	add    %eax,%edx
  801e08:	89 d0                	mov    %edx,%eax
  801e0a:	01 c0                	add    %eax,%eax
  801e0c:	01 d0                	add    %edx,%eax
  801e0e:	c1 e0 02             	shl    $0x2,%eax
  801e11:	05 48 30 80 00       	add    $0x803048,%eax
  801e16:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801e1c:	ff 45 f0             	incl   -0x10(%ebp)
  801e1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e22:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e25:	72 d9                	jb     801e00 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801e27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e2a:	89 d0                	mov    %edx,%eax
  801e2c:	01 c0                	add    %eax,%eax
  801e2e:	01 d0                	add    %edx,%eax
  801e30:	c1 e0 02             	shl    $0x2,%eax
  801e33:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801e39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e3c:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801e3e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801e41:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801e44:	89 c8                	mov    %ecx,%eax
  801e46:	01 c0                	add    %eax,%eax
  801e48:	01 c8                	add    %ecx,%eax
  801e4a:	c1 e0 02             	shl    $0x2,%eax
  801e4d:	05 44 30 80 00       	add    $0x803044,%eax
  801e52:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801e54:	83 ec 08             	sub    $0x8,%esp
  801e57:	ff 75 08             	pushl  0x8(%ebp)
  801e5a:	ff 75 e0             	pushl  -0x20(%ebp)
  801e5d:	e8 2b 03 00 00       	call   80218d <sys_allocateMem>
  801e62:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801e65:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e68:	eb 19                	jmp    801e83 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801e6a:	ff 45 f4             	incl   -0xc(%ebp)
  801e6d:	a1 04 30 80 00       	mov    0x803004,%eax
  801e72:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801e75:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801e78:	0f 83 27 ff ff ff    	jae    801da5 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801e7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e83:	c9                   	leave  
  801e84:	c3                   	ret    

00801e85 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801e85:	55                   	push   %ebp
  801e86:	89 e5                	mov    %esp,%ebp
  801e88:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801e8b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e8f:	0f 84 e5 00 00 00    	je     801f7a <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801e95:	8b 45 08             	mov    0x8(%ebp),%eax
  801e98:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801e9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e9e:	05 00 00 00 80       	add    $0x80000000,%eax
  801ea3:	c1 e8 0c             	shr    $0xc,%eax
  801ea6:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801ea9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801eac:	89 d0                	mov    %edx,%eax
  801eae:	01 c0                	add    %eax,%eax
  801eb0:	01 d0                	add    %edx,%eax
  801eb2:	c1 e0 02             	shl    $0x2,%eax
  801eb5:	05 40 30 80 00       	add    $0x803040,%eax
  801eba:	8b 00                	mov    (%eax),%eax
  801ebc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ebf:	0f 85 b8 00 00 00    	jne    801f7d <free+0xf8>
  801ec5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ec8:	89 d0                	mov    %edx,%eax
  801eca:	01 c0                	add    %eax,%eax
  801ecc:	01 d0                	add    %edx,%eax
  801ece:	c1 e0 02             	shl    $0x2,%eax
  801ed1:	05 48 30 80 00       	add    $0x803048,%eax
  801ed6:	8b 00                	mov    (%eax),%eax
  801ed8:	85 c0                	test   %eax,%eax
  801eda:	0f 84 9d 00 00 00    	je     801f7d <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801ee0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ee3:	89 d0                	mov    %edx,%eax
  801ee5:	01 c0                	add    %eax,%eax
  801ee7:	01 d0                	add    %edx,%eax
  801ee9:	c1 e0 02             	shl    $0x2,%eax
  801eec:	05 44 30 80 00       	add    $0x803044,%eax
  801ef1:	8b 00                	mov    (%eax),%eax
  801ef3:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801ef6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ef9:	c1 e0 0c             	shl    $0xc,%eax
  801efc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801eff:	83 ec 08             	sub    $0x8,%esp
  801f02:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f05:	ff 75 f0             	pushl  -0x10(%ebp)
  801f08:	e8 64 02 00 00       	call   802171 <sys_freeMem>
  801f0d:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801f10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801f17:	eb 57                	jmp    801f70 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801f19:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f1f:	01 c2                	add    %eax,%edx
  801f21:	89 d0                	mov    %edx,%eax
  801f23:	01 c0                	add    %eax,%eax
  801f25:	01 d0                	add    %edx,%eax
  801f27:	c1 e0 02             	shl    $0x2,%eax
  801f2a:	05 48 30 80 00       	add    $0x803048,%eax
  801f2f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801f35:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f3b:	01 c2                	add    %eax,%edx
  801f3d:	89 d0                	mov    %edx,%eax
  801f3f:	01 c0                	add    %eax,%eax
  801f41:	01 d0                	add    %edx,%eax
  801f43:	c1 e0 02             	shl    $0x2,%eax
  801f46:	05 40 30 80 00       	add    $0x803040,%eax
  801f4b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801f51:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f57:	01 c2                	add    %eax,%edx
  801f59:	89 d0                	mov    %edx,%eax
  801f5b:	01 c0                	add    %eax,%eax
  801f5d:	01 d0                	add    %edx,%eax
  801f5f:	c1 e0 02             	shl    $0x2,%eax
  801f62:	05 44 30 80 00       	add    $0x803044,%eax
  801f67:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801f6d:	ff 45 f4             	incl   -0xc(%ebp)
  801f70:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f73:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801f76:	7c a1                	jl     801f19 <free+0x94>
  801f78:	eb 04                	jmp    801f7e <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801f7a:	90                   	nop
  801f7b:	eb 01                	jmp    801f7e <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801f7d:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801f7e:	c9                   	leave  
  801f7f:	c3                   	ret    

00801f80 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801f80:	55                   	push   %ebp
  801f81:	89 e5                	mov    %esp,%ebp
  801f83:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801f86:	83 ec 04             	sub    $0x4,%esp
  801f89:	68 b8 2e 80 00       	push   $0x802eb8
  801f8e:	68 ae 00 00 00       	push   $0xae
  801f93:	68 8f 2e 80 00       	push   $0x802e8f
  801f98:	e8 4f ed ff ff       	call   800cec <_panic>

00801f9d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
  801fa0:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801fa3:	83 ec 04             	sub    $0x4,%esp
  801fa6:	68 d8 2e 80 00       	push   $0x802ed8
  801fab:	68 ca 00 00 00       	push   $0xca
  801fb0:	68 8f 2e 80 00       	push   $0x802e8f
  801fb5:	e8 32 ed ff ff       	call   800cec <_panic>

00801fba <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801fba:	55                   	push   %ebp
  801fbb:	89 e5                	mov    %esp,%ebp
  801fbd:	57                   	push   %edi
  801fbe:	56                   	push   %esi
  801fbf:	53                   	push   %ebx
  801fc0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fcc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801fcf:	8b 7d 18             	mov    0x18(%ebp),%edi
  801fd2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801fd5:	cd 30                	int    $0x30
  801fd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801fda:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801fdd:	83 c4 10             	add    $0x10,%esp
  801fe0:	5b                   	pop    %ebx
  801fe1:	5e                   	pop    %esi
  801fe2:	5f                   	pop    %edi
  801fe3:	5d                   	pop    %ebp
  801fe4:	c3                   	ret    

00801fe5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801fe5:	55                   	push   %ebp
  801fe6:	89 e5                	mov    %esp,%ebp
  801fe8:	83 ec 04             	sub    $0x4,%esp
  801feb:	8b 45 10             	mov    0x10(%ebp),%eax
  801fee:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ff1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	52                   	push   %edx
  801ffd:	ff 75 0c             	pushl  0xc(%ebp)
  802000:	50                   	push   %eax
  802001:	6a 00                	push   $0x0
  802003:	e8 b2 ff ff ff       	call   801fba <syscall>
  802008:	83 c4 18             	add    $0x18,%esp
}
  80200b:	90                   	nop
  80200c:	c9                   	leave  
  80200d:	c3                   	ret    

0080200e <sys_cgetc>:

int
sys_cgetc(void)
{
  80200e:	55                   	push   %ebp
  80200f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 01                	push   $0x1
  80201d:	e8 98 ff ff ff       	call   801fba <syscall>
  802022:	83 c4 18             	add    $0x18,%esp
}
  802025:	c9                   	leave  
  802026:	c3                   	ret    

00802027 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802027:	55                   	push   %ebp
  802028:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80202a:	8b 45 08             	mov    0x8(%ebp),%eax
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	50                   	push   %eax
  802036:	6a 05                	push   $0x5
  802038:	e8 7d ff ff ff       	call   801fba <syscall>
  80203d:	83 c4 18             	add    $0x18,%esp
}
  802040:	c9                   	leave  
  802041:	c3                   	ret    

00802042 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802042:	55                   	push   %ebp
  802043:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 02                	push   $0x2
  802051:	e8 64 ff ff ff       	call   801fba <syscall>
  802056:	83 c4 18             	add    $0x18,%esp
}
  802059:	c9                   	leave  
  80205a:	c3                   	ret    

0080205b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 03                	push   $0x3
  80206a:	e8 4b ff ff ff       	call   801fba <syscall>
  80206f:	83 c4 18             	add    $0x18,%esp
}
  802072:	c9                   	leave  
  802073:	c3                   	ret    

00802074 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802074:	55                   	push   %ebp
  802075:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 04                	push   $0x4
  802083:	e8 32 ff ff ff       	call   801fba <syscall>
  802088:	83 c4 18             	add    $0x18,%esp
}
  80208b:	c9                   	leave  
  80208c:	c3                   	ret    

0080208d <sys_env_exit>:


void sys_env_exit(void)
{
  80208d:	55                   	push   %ebp
  80208e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 00                	push   $0x0
  80209a:	6a 06                	push   $0x6
  80209c:	e8 19 ff ff ff       	call   801fba <syscall>
  8020a1:	83 c4 18             	add    $0x18,%esp
}
  8020a4:	90                   	nop
  8020a5:	c9                   	leave  
  8020a6:	c3                   	ret    

008020a7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8020aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	52                   	push   %edx
  8020b7:	50                   	push   %eax
  8020b8:	6a 07                	push   $0x7
  8020ba:	e8 fb fe ff ff       	call   801fba <syscall>
  8020bf:	83 c4 18             	add    $0x18,%esp
}
  8020c2:	c9                   	leave  
  8020c3:	c3                   	ret    

008020c4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8020c4:	55                   	push   %ebp
  8020c5:	89 e5                	mov    %esp,%ebp
  8020c7:	56                   	push   %esi
  8020c8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8020c9:	8b 75 18             	mov    0x18(%ebp),%esi
  8020cc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d8:	56                   	push   %esi
  8020d9:	53                   	push   %ebx
  8020da:	51                   	push   %ecx
  8020db:	52                   	push   %edx
  8020dc:	50                   	push   %eax
  8020dd:	6a 08                	push   $0x8
  8020df:	e8 d6 fe ff ff       	call   801fba <syscall>
  8020e4:	83 c4 18             	add    $0x18,%esp
}
  8020e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8020ea:	5b                   	pop    %ebx
  8020eb:	5e                   	pop    %esi
  8020ec:	5d                   	pop    %ebp
  8020ed:	c3                   	ret    

008020ee <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8020ee:	55                   	push   %ebp
  8020ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8020f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	52                   	push   %edx
  8020fe:	50                   	push   %eax
  8020ff:	6a 09                	push   $0x9
  802101:	e8 b4 fe ff ff       	call   801fba <syscall>
  802106:	83 c4 18             	add    $0x18,%esp
}
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	ff 75 0c             	pushl  0xc(%ebp)
  802117:	ff 75 08             	pushl  0x8(%ebp)
  80211a:	6a 0a                	push   $0xa
  80211c:	e8 99 fe ff ff       	call   801fba <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
}
  802124:	c9                   	leave  
  802125:	c3                   	ret    

00802126 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 0b                	push   $0xb
  802135:	e8 80 fe ff ff       	call   801fba <syscall>
  80213a:	83 c4 18             	add    $0x18,%esp
}
  80213d:	c9                   	leave  
  80213e:	c3                   	ret    

0080213f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 0c                	push   $0xc
  80214e:	e8 67 fe ff ff       	call   801fba <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
}
  802156:	c9                   	leave  
  802157:	c3                   	ret    

00802158 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802158:	55                   	push   %ebp
  802159:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 0d                	push   $0xd
  802167:	e8 4e fe ff ff       	call   801fba <syscall>
  80216c:	83 c4 18             	add    $0x18,%esp
}
  80216f:	c9                   	leave  
  802170:	c3                   	ret    

00802171 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802171:	55                   	push   %ebp
  802172:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	ff 75 0c             	pushl  0xc(%ebp)
  80217d:	ff 75 08             	pushl  0x8(%ebp)
  802180:	6a 11                	push   $0x11
  802182:	e8 33 fe ff ff       	call   801fba <syscall>
  802187:	83 c4 18             	add    $0x18,%esp
	return;
  80218a:	90                   	nop
}
  80218b:	c9                   	leave  
  80218c:	c3                   	ret    

0080218d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80218d:	55                   	push   %ebp
  80218e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802190:	6a 00                	push   $0x0
  802192:	6a 00                	push   $0x0
  802194:	6a 00                	push   $0x0
  802196:	ff 75 0c             	pushl  0xc(%ebp)
  802199:	ff 75 08             	pushl  0x8(%ebp)
  80219c:	6a 12                	push   $0x12
  80219e:	e8 17 fe ff ff       	call   801fba <syscall>
  8021a3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021a6:	90                   	nop
}
  8021a7:	c9                   	leave  
  8021a8:	c3                   	ret    

008021a9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8021a9:	55                   	push   %ebp
  8021aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 0e                	push   $0xe
  8021b8:	e8 fd fd ff ff       	call   801fba <syscall>
  8021bd:	83 c4 18             	add    $0x18,%esp
}
  8021c0:	c9                   	leave  
  8021c1:	c3                   	ret    

008021c2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8021c2:	55                   	push   %ebp
  8021c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	ff 75 08             	pushl  0x8(%ebp)
  8021d0:	6a 0f                	push   $0xf
  8021d2:	e8 e3 fd ff ff       	call   801fba <syscall>
  8021d7:	83 c4 18             	add    $0x18,%esp
}
  8021da:	c9                   	leave  
  8021db:	c3                   	ret    

008021dc <sys_scarce_memory>:

void sys_scarce_memory()
{
  8021dc:	55                   	push   %ebp
  8021dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 10                	push   $0x10
  8021eb:	e8 ca fd ff ff       	call   801fba <syscall>
  8021f0:	83 c4 18             	add    $0x18,%esp
}
  8021f3:	90                   	nop
  8021f4:	c9                   	leave  
  8021f5:	c3                   	ret    

008021f6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8021f6:	55                   	push   %ebp
  8021f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 14                	push   $0x14
  802205:	e8 b0 fd ff ff       	call   801fba <syscall>
  80220a:	83 c4 18             	add    $0x18,%esp
}
  80220d:	90                   	nop
  80220e:	c9                   	leave  
  80220f:	c3                   	ret    

00802210 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802210:	55                   	push   %ebp
  802211:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 15                	push   $0x15
  80221f:	e8 96 fd ff ff       	call   801fba <syscall>
  802224:	83 c4 18             	add    $0x18,%esp
}
  802227:	90                   	nop
  802228:	c9                   	leave  
  802229:	c3                   	ret    

0080222a <sys_cputc>:


void
sys_cputc(const char c)
{
  80222a:	55                   	push   %ebp
  80222b:	89 e5                	mov    %esp,%ebp
  80222d:	83 ec 04             	sub    $0x4,%esp
  802230:	8b 45 08             	mov    0x8(%ebp),%eax
  802233:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802236:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	50                   	push   %eax
  802243:	6a 16                	push   $0x16
  802245:	e8 70 fd ff ff       	call   801fba <syscall>
  80224a:	83 c4 18             	add    $0x18,%esp
}
  80224d:	90                   	nop
  80224e:	c9                   	leave  
  80224f:	c3                   	ret    

00802250 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802250:	55                   	push   %ebp
  802251:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802253:	6a 00                	push   $0x0
  802255:	6a 00                	push   $0x0
  802257:	6a 00                	push   $0x0
  802259:	6a 00                	push   $0x0
  80225b:	6a 00                	push   $0x0
  80225d:	6a 17                	push   $0x17
  80225f:	e8 56 fd ff ff       	call   801fba <syscall>
  802264:	83 c4 18             	add    $0x18,%esp
}
  802267:	90                   	nop
  802268:	c9                   	leave  
  802269:	c3                   	ret    

0080226a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80226a:	55                   	push   %ebp
  80226b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80226d:	8b 45 08             	mov    0x8(%ebp),%eax
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	ff 75 0c             	pushl  0xc(%ebp)
  802279:	50                   	push   %eax
  80227a:	6a 18                	push   $0x18
  80227c:	e8 39 fd ff ff       	call   801fba <syscall>
  802281:	83 c4 18             	add    $0x18,%esp
}
  802284:	c9                   	leave  
  802285:	c3                   	ret    

00802286 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802286:	55                   	push   %ebp
  802287:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802289:	8b 55 0c             	mov    0xc(%ebp),%edx
  80228c:	8b 45 08             	mov    0x8(%ebp),%eax
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 00                	push   $0x0
  802295:	52                   	push   %edx
  802296:	50                   	push   %eax
  802297:	6a 1b                	push   $0x1b
  802299:	e8 1c fd ff ff       	call   801fba <syscall>
  80229e:	83 c4 18             	add    $0x18,%esp
}
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	52                   	push   %edx
  8022b3:	50                   	push   %eax
  8022b4:	6a 19                	push   $0x19
  8022b6:	e8 ff fc ff ff       	call   801fba <syscall>
  8022bb:	83 c4 18             	add    $0x18,%esp
}
  8022be:	90                   	nop
  8022bf:	c9                   	leave  
  8022c0:	c3                   	ret    

008022c1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022c1:	55                   	push   %ebp
  8022c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 00                	push   $0x0
  8022d0:	52                   	push   %edx
  8022d1:	50                   	push   %eax
  8022d2:	6a 1a                	push   $0x1a
  8022d4:	e8 e1 fc ff ff       	call   801fba <syscall>
  8022d9:	83 c4 18             	add    $0x18,%esp
}
  8022dc:	90                   	nop
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
  8022e2:	83 ec 04             	sub    $0x4,%esp
  8022e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8022e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8022eb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8022ee:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8022f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f5:	6a 00                	push   $0x0
  8022f7:	51                   	push   %ecx
  8022f8:	52                   	push   %edx
  8022f9:	ff 75 0c             	pushl  0xc(%ebp)
  8022fc:	50                   	push   %eax
  8022fd:	6a 1c                	push   $0x1c
  8022ff:	e8 b6 fc ff ff       	call   801fba <syscall>
  802304:	83 c4 18             	add    $0x18,%esp
}
  802307:	c9                   	leave  
  802308:	c3                   	ret    

00802309 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802309:	55                   	push   %ebp
  80230a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80230c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80230f:	8b 45 08             	mov    0x8(%ebp),%eax
  802312:	6a 00                	push   $0x0
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	52                   	push   %edx
  802319:	50                   	push   %eax
  80231a:	6a 1d                	push   $0x1d
  80231c:	e8 99 fc ff ff       	call   801fba <syscall>
  802321:	83 c4 18             	add    $0x18,%esp
}
  802324:	c9                   	leave  
  802325:	c3                   	ret    

00802326 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802326:	55                   	push   %ebp
  802327:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802329:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80232c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80232f:	8b 45 08             	mov    0x8(%ebp),%eax
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	51                   	push   %ecx
  802337:	52                   	push   %edx
  802338:	50                   	push   %eax
  802339:	6a 1e                	push   $0x1e
  80233b:	e8 7a fc ff ff       	call   801fba <syscall>
  802340:	83 c4 18             	add    $0x18,%esp
}
  802343:	c9                   	leave  
  802344:	c3                   	ret    

00802345 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802345:	55                   	push   %ebp
  802346:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802348:	8b 55 0c             	mov    0xc(%ebp),%edx
  80234b:	8b 45 08             	mov    0x8(%ebp),%eax
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 00                	push   $0x0
  802354:	52                   	push   %edx
  802355:	50                   	push   %eax
  802356:	6a 1f                	push   $0x1f
  802358:	e8 5d fc ff ff       	call   801fba <syscall>
  80235d:	83 c4 18             	add    $0x18,%esp
}
  802360:	c9                   	leave  
  802361:	c3                   	ret    

00802362 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802362:	55                   	push   %ebp
  802363:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	6a 20                	push   $0x20
  802371:	e8 44 fc ff ff       	call   801fba <syscall>
  802376:	83 c4 18             	add    $0x18,%esp
}
  802379:	c9                   	leave  
  80237a:	c3                   	ret    

0080237b <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  80237b:	55                   	push   %ebp
  80237c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80237e:	8b 45 08             	mov    0x8(%ebp),%eax
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	ff 75 10             	pushl  0x10(%ebp)
  802388:	ff 75 0c             	pushl  0xc(%ebp)
  80238b:	50                   	push   %eax
  80238c:	6a 21                	push   $0x21
  80238e:	e8 27 fc ff ff       	call   801fba <syscall>
  802393:	83 c4 18             	add    $0x18,%esp
}
  802396:	c9                   	leave  
  802397:	c3                   	ret    

00802398 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802398:	55                   	push   %ebp
  802399:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80239b:	8b 45 08             	mov    0x8(%ebp),%eax
  80239e:	6a 00                	push   $0x0
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 00                	push   $0x0
  8023a4:	6a 00                	push   $0x0
  8023a6:	50                   	push   %eax
  8023a7:	6a 22                	push   $0x22
  8023a9:	e8 0c fc ff ff       	call   801fba <syscall>
  8023ae:	83 c4 18             	add    $0x18,%esp
}
  8023b1:	90                   	nop
  8023b2:	c9                   	leave  
  8023b3:	c3                   	ret    

008023b4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8023b4:	55                   	push   %ebp
  8023b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8023b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	50                   	push   %eax
  8023c3:	6a 23                	push   $0x23
  8023c5:	e8 f0 fb ff ff       	call   801fba <syscall>
  8023ca:	83 c4 18             	add    $0x18,%esp
}
  8023cd:	90                   	nop
  8023ce:	c9                   	leave  
  8023cf:	c3                   	ret    

008023d0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8023d0:	55                   	push   %ebp
  8023d1:	89 e5                	mov    %esp,%ebp
  8023d3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8023d6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8023d9:	8d 50 04             	lea    0x4(%eax),%edx
  8023dc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 00                	push   $0x0
  8023e5:	52                   	push   %edx
  8023e6:	50                   	push   %eax
  8023e7:	6a 24                	push   $0x24
  8023e9:	e8 cc fb ff ff       	call   801fba <syscall>
  8023ee:	83 c4 18             	add    $0x18,%esp
	return result;
  8023f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8023fa:	89 01                	mov    %eax,(%ecx)
  8023fc:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8023ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802402:	c9                   	leave  
  802403:	c2 04 00             	ret    $0x4

00802406 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802406:	55                   	push   %ebp
  802407:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802409:	6a 00                	push   $0x0
  80240b:	6a 00                	push   $0x0
  80240d:	ff 75 10             	pushl  0x10(%ebp)
  802410:	ff 75 0c             	pushl  0xc(%ebp)
  802413:	ff 75 08             	pushl  0x8(%ebp)
  802416:	6a 13                	push   $0x13
  802418:	e8 9d fb ff ff       	call   801fba <syscall>
  80241d:	83 c4 18             	add    $0x18,%esp
	return ;
  802420:	90                   	nop
}
  802421:	c9                   	leave  
  802422:	c3                   	ret    

00802423 <sys_rcr2>:
uint32 sys_rcr2()
{
  802423:	55                   	push   %ebp
  802424:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802426:	6a 00                	push   $0x0
  802428:	6a 00                	push   $0x0
  80242a:	6a 00                	push   $0x0
  80242c:	6a 00                	push   $0x0
  80242e:	6a 00                	push   $0x0
  802430:	6a 25                	push   $0x25
  802432:	e8 83 fb ff ff       	call   801fba <syscall>
  802437:	83 c4 18             	add    $0x18,%esp
}
  80243a:	c9                   	leave  
  80243b:	c3                   	ret    

0080243c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80243c:	55                   	push   %ebp
  80243d:	89 e5                	mov    %esp,%ebp
  80243f:	83 ec 04             	sub    $0x4,%esp
  802442:	8b 45 08             	mov    0x8(%ebp),%eax
  802445:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802448:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80244c:	6a 00                	push   $0x0
  80244e:	6a 00                	push   $0x0
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	50                   	push   %eax
  802455:	6a 26                	push   $0x26
  802457:	e8 5e fb ff ff       	call   801fba <syscall>
  80245c:	83 c4 18             	add    $0x18,%esp
	return ;
  80245f:	90                   	nop
}
  802460:	c9                   	leave  
  802461:	c3                   	ret    

00802462 <rsttst>:
void rsttst()
{
  802462:	55                   	push   %ebp
  802463:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802465:	6a 00                	push   $0x0
  802467:	6a 00                	push   $0x0
  802469:	6a 00                	push   $0x0
  80246b:	6a 00                	push   $0x0
  80246d:	6a 00                	push   $0x0
  80246f:	6a 28                	push   $0x28
  802471:	e8 44 fb ff ff       	call   801fba <syscall>
  802476:	83 c4 18             	add    $0x18,%esp
	return ;
  802479:	90                   	nop
}
  80247a:	c9                   	leave  
  80247b:	c3                   	ret    

0080247c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80247c:	55                   	push   %ebp
  80247d:	89 e5                	mov    %esp,%ebp
  80247f:	83 ec 04             	sub    $0x4,%esp
  802482:	8b 45 14             	mov    0x14(%ebp),%eax
  802485:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802488:	8b 55 18             	mov    0x18(%ebp),%edx
  80248b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80248f:	52                   	push   %edx
  802490:	50                   	push   %eax
  802491:	ff 75 10             	pushl  0x10(%ebp)
  802494:	ff 75 0c             	pushl  0xc(%ebp)
  802497:	ff 75 08             	pushl  0x8(%ebp)
  80249a:	6a 27                	push   $0x27
  80249c:	e8 19 fb ff ff       	call   801fba <syscall>
  8024a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8024a4:	90                   	nop
}
  8024a5:	c9                   	leave  
  8024a6:	c3                   	ret    

008024a7 <chktst>:
void chktst(uint32 n)
{
  8024a7:	55                   	push   %ebp
  8024a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8024aa:	6a 00                	push   $0x0
  8024ac:	6a 00                	push   $0x0
  8024ae:	6a 00                	push   $0x0
  8024b0:	6a 00                	push   $0x0
  8024b2:	ff 75 08             	pushl  0x8(%ebp)
  8024b5:	6a 29                	push   $0x29
  8024b7:	e8 fe fa ff ff       	call   801fba <syscall>
  8024bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8024bf:	90                   	nop
}
  8024c0:	c9                   	leave  
  8024c1:	c3                   	ret    

008024c2 <inctst>:

void inctst()
{
  8024c2:	55                   	push   %ebp
  8024c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8024c5:	6a 00                	push   $0x0
  8024c7:	6a 00                	push   $0x0
  8024c9:	6a 00                	push   $0x0
  8024cb:	6a 00                	push   $0x0
  8024cd:	6a 00                	push   $0x0
  8024cf:	6a 2a                	push   $0x2a
  8024d1:	e8 e4 fa ff ff       	call   801fba <syscall>
  8024d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8024d9:	90                   	nop
}
  8024da:	c9                   	leave  
  8024db:	c3                   	ret    

008024dc <gettst>:
uint32 gettst()
{
  8024dc:	55                   	push   %ebp
  8024dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8024df:	6a 00                	push   $0x0
  8024e1:	6a 00                	push   $0x0
  8024e3:	6a 00                	push   $0x0
  8024e5:	6a 00                	push   $0x0
  8024e7:	6a 00                	push   $0x0
  8024e9:	6a 2b                	push   $0x2b
  8024eb:	e8 ca fa ff ff       	call   801fba <syscall>
  8024f0:	83 c4 18             	add    $0x18,%esp
}
  8024f3:	c9                   	leave  
  8024f4:	c3                   	ret    

008024f5 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8024f5:	55                   	push   %ebp
  8024f6:	89 e5                	mov    %esp,%ebp
  8024f8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024fb:	6a 00                	push   $0x0
  8024fd:	6a 00                	push   $0x0
  8024ff:	6a 00                	push   $0x0
  802501:	6a 00                	push   $0x0
  802503:	6a 00                	push   $0x0
  802505:	6a 2c                	push   $0x2c
  802507:	e8 ae fa ff ff       	call   801fba <syscall>
  80250c:	83 c4 18             	add    $0x18,%esp
  80250f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802512:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802516:	75 07                	jne    80251f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802518:	b8 01 00 00 00       	mov    $0x1,%eax
  80251d:	eb 05                	jmp    802524 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80251f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802524:	c9                   	leave  
  802525:	c3                   	ret    

00802526 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802526:	55                   	push   %ebp
  802527:	89 e5                	mov    %esp,%ebp
  802529:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80252c:	6a 00                	push   $0x0
  80252e:	6a 00                	push   $0x0
  802530:	6a 00                	push   $0x0
  802532:	6a 00                	push   $0x0
  802534:	6a 00                	push   $0x0
  802536:	6a 2c                	push   $0x2c
  802538:	e8 7d fa ff ff       	call   801fba <syscall>
  80253d:	83 c4 18             	add    $0x18,%esp
  802540:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802543:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802547:	75 07                	jne    802550 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802549:	b8 01 00 00 00       	mov    $0x1,%eax
  80254e:	eb 05                	jmp    802555 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802550:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802555:	c9                   	leave  
  802556:	c3                   	ret    

00802557 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802557:	55                   	push   %ebp
  802558:	89 e5                	mov    %esp,%ebp
  80255a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80255d:	6a 00                	push   $0x0
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 00                	push   $0x0
  802565:	6a 00                	push   $0x0
  802567:	6a 2c                	push   $0x2c
  802569:	e8 4c fa ff ff       	call   801fba <syscall>
  80256e:	83 c4 18             	add    $0x18,%esp
  802571:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802574:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802578:	75 07                	jne    802581 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80257a:	b8 01 00 00 00       	mov    $0x1,%eax
  80257f:	eb 05                	jmp    802586 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802581:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802586:	c9                   	leave  
  802587:	c3                   	ret    

00802588 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802588:	55                   	push   %ebp
  802589:	89 e5                	mov    %esp,%ebp
  80258b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80258e:	6a 00                	push   $0x0
  802590:	6a 00                	push   $0x0
  802592:	6a 00                	push   $0x0
  802594:	6a 00                	push   $0x0
  802596:	6a 00                	push   $0x0
  802598:	6a 2c                	push   $0x2c
  80259a:	e8 1b fa ff ff       	call   801fba <syscall>
  80259f:	83 c4 18             	add    $0x18,%esp
  8025a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8025a5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8025a9:	75 07                	jne    8025b2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8025ab:	b8 01 00 00 00       	mov    $0x1,%eax
  8025b0:	eb 05                	jmp    8025b7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8025b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025b7:	c9                   	leave  
  8025b8:	c3                   	ret    

008025b9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8025b9:	55                   	push   %ebp
  8025ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8025bc:	6a 00                	push   $0x0
  8025be:	6a 00                	push   $0x0
  8025c0:	6a 00                	push   $0x0
  8025c2:	6a 00                	push   $0x0
  8025c4:	ff 75 08             	pushl  0x8(%ebp)
  8025c7:	6a 2d                	push   $0x2d
  8025c9:	e8 ec f9 ff ff       	call   801fba <syscall>
  8025ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8025d1:	90                   	nop
}
  8025d2:	c9                   	leave  
  8025d3:	c3                   	ret    

008025d4 <__udivdi3>:
  8025d4:	55                   	push   %ebp
  8025d5:	57                   	push   %edi
  8025d6:	56                   	push   %esi
  8025d7:	53                   	push   %ebx
  8025d8:	83 ec 1c             	sub    $0x1c,%esp
  8025db:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025df:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025eb:	89 ca                	mov    %ecx,%edx
  8025ed:	89 f8                	mov    %edi,%eax
  8025ef:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025f3:	85 f6                	test   %esi,%esi
  8025f5:	75 2d                	jne    802624 <__udivdi3+0x50>
  8025f7:	39 cf                	cmp    %ecx,%edi
  8025f9:	77 65                	ja     802660 <__udivdi3+0x8c>
  8025fb:	89 fd                	mov    %edi,%ebp
  8025fd:	85 ff                	test   %edi,%edi
  8025ff:	75 0b                	jne    80260c <__udivdi3+0x38>
  802601:	b8 01 00 00 00       	mov    $0x1,%eax
  802606:	31 d2                	xor    %edx,%edx
  802608:	f7 f7                	div    %edi
  80260a:	89 c5                	mov    %eax,%ebp
  80260c:	31 d2                	xor    %edx,%edx
  80260e:	89 c8                	mov    %ecx,%eax
  802610:	f7 f5                	div    %ebp
  802612:	89 c1                	mov    %eax,%ecx
  802614:	89 d8                	mov    %ebx,%eax
  802616:	f7 f5                	div    %ebp
  802618:	89 cf                	mov    %ecx,%edi
  80261a:	89 fa                	mov    %edi,%edx
  80261c:	83 c4 1c             	add    $0x1c,%esp
  80261f:	5b                   	pop    %ebx
  802620:	5e                   	pop    %esi
  802621:	5f                   	pop    %edi
  802622:	5d                   	pop    %ebp
  802623:	c3                   	ret    
  802624:	39 ce                	cmp    %ecx,%esi
  802626:	77 28                	ja     802650 <__udivdi3+0x7c>
  802628:	0f bd fe             	bsr    %esi,%edi
  80262b:	83 f7 1f             	xor    $0x1f,%edi
  80262e:	75 40                	jne    802670 <__udivdi3+0x9c>
  802630:	39 ce                	cmp    %ecx,%esi
  802632:	72 0a                	jb     80263e <__udivdi3+0x6a>
  802634:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802638:	0f 87 9e 00 00 00    	ja     8026dc <__udivdi3+0x108>
  80263e:	b8 01 00 00 00       	mov    $0x1,%eax
  802643:	89 fa                	mov    %edi,%edx
  802645:	83 c4 1c             	add    $0x1c,%esp
  802648:	5b                   	pop    %ebx
  802649:	5e                   	pop    %esi
  80264a:	5f                   	pop    %edi
  80264b:	5d                   	pop    %ebp
  80264c:	c3                   	ret    
  80264d:	8d 76 00             	lea    0x0(%esi),%esi
  802650:	31 ff                	xor    %edi,%edi
  802652:	31 c0                	xor    %eax,%eax
  802654:	89 fa                	mov    %edi,%edx
  802656:	83 c4 1c             	add    $0x1c,%esp
  802659:	5b                   	pop    %ebx
  80265a:	5e                   	pop    %esi
  80265b:	5f                   	pop    %edi
  80265c:	5d                   	pop    %ebp
  80265d:	c3                   	ret    
  80265e:	66 90                	xchg   %ax,%ax
  802660:	89 d8                	mov    %ebx,%eax
  802662:	f7 f7                	div    %edi
  802664:	31 ff                	xor    %edi,%edi
  802666:	89 fa                	mov    %edi,%edx
  802668:	83 c4 1c             	add    $0x1c,%esp
  80266b:	5b                   	pop    %ebx
  80266c:	5e                   	pop    %esi
  80266d:	5f                   	pop    %edi
  80266e:	5d                   	pop    %ebp
  80266f:	c3                   	ret    
  802670:	bd 20 00 00 00       	mov    $0x20,%ebp
  802675:	89 eb                	mov    %ebp,%ebx
  802677:	29 fb                	sub    %edi,%ebx
  802679:	89 f9                	mov    %edi,%ecx
  80267b:	d3 e6                	shl    %cl,%esi
  80267d:	89 c5                	mov    %eax,%ebp
  80267f:	88 d9                	mov    %bl,%cl
  802681:	d3 ed                	shr    %cl,%ebp
  802683:	89 e9                	mov    %ebp,%ecx
  802685:	09 f1                	or     %esi,%ecx
  802687:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80268b:	89 f9                	mov    %edi,%ecx
  80268d:	d3 e0                	shl    %cl,%eax
  80268f:	89 c5                	mov    %eax,%ebp
  802691:	89 d6                	mov    %edx,%esi
  802693:	88 d9                	mov    %bl,%cl
  802695:	d3 ee                	shr    %cl,%esi
  802697:	89 f9                	mov    %edi,%ecx
  802699:	d3 e2                	shl    %cl,%edx
  80269b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80269f:	88 d9                	mov    %bl,%cl
  8026a1:	d3 e8                	shr    %cl,%eax
  8026a3:	09 c2                	or     %eax,%edx
  8026a5:	89 d0                	mov    %edx,%eax
  8026a7:	89 f2                	mov    %esi,%edx
  8026a9:	f7 74 24 0c          	divl   0xc(%esp)
  8026ad:	89 d6                	mov    %edx,%esi
  8026af:	89 c3                	mov    %eax,%ebx
  8026b1:	f7 e5                	mul    %ebp
  8026b3:	39 d6                	cmp    %edx,%esi
  8026b5:	72 19                	jb     8026d0 <__udivdi3+0xfc>
  8026b7:	74 0b                	je     8026c4 <__udivdi3+0xf0>
  8026b9:	89 d8                	mov    %ebx,%eax
  8026bb:	31 ff                	xor    %edi,%edi
  8026bd:	e9 58 ff ff ff       	jmp    80261a <__udivdi3+0x46>
  8026c2:	66 90                	xchg   %ax,%ax
  8026c4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026c8:	89 f9                	mov    %edi,%ecx
  8026ca:	d3 e2                	shl    %cl,%edx
  8026cc:	39 c2                	cmp    %eax,%edx
  8026ce:	73 e9                	jae    8026b9 <__udivdi3+0xe5>
  8026d0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026d3:	31 ff                	xor    %edi,%edi
  8026d5:	e9 40 ff ff ff       	jmp    80261a <__udivdi3+0x46>
  8026da:	66 90                	xchg   %ax,%ax
  8026dc:	31 c0                	xor    %eax,%eax
  8026de:	e9 37 ff ff ff       	jmp    80261a <__udivdi3+0x46>
  8026e3:	90                   	nop

008026e4 <__umoddi3>:
  8026e4:	55                   	push   %ebp
  8026e5:	57                   	push   %edi
  8026e6:	56                   	push   %esi
  8026e7:	53                   	push   %ebx
  8026e8:	83 ec 1c             	sub    $0x1c,%esp
  8026eb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026ef:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026f7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026ff:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802703:	89 f3                	mov    %esi,%ebx
  802705:	89 fa                	mov    %edi,%edx
  802707:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80270b:	89 34 24             	mov    %esi,(%esp)
  80270e:	85 c0                	test   %eax,%eax
  802710:	75 1a                	jne    80272c <__umoddi3+0x48>
  802712:	39 f7                	cmp    %esi,%edi
  802714:	0f 86 a2 00 00 00    	jbe    8027bc <__umoddi3+0xd8>
  80271a:	89 c8                	mov    %ecx,%eax
  80271c:	89 f2                	mov    %esi,%edx
  80271e:	f7 f7                	div    %edi
  802720:	89 d0                	mov    %edx,%eax
  802722:	31 d2                	xor    %edx,%edx
  802724:	83 c4 1c             	add    $0x1c,%esp
  802727:	5b                   	pop    %ebx
  802728:	5e                   	pop    %esi
  802729:	5f                   	pop    %edi
  80272a:	5d                   	pop    %ebp
  80272b:	c3                   	ret    
  80272c:	39 f0                	cmp    %esi,%eax
  80272e:	0f 87 ac 00 00 00    	ja     8027e0 <__umoddi3+0xfc>
  802734:	0f bd e8             	bsr    %eax,%ebp
  802737:	83 f5 1f             	xor    $0x1f,%ebp
  80273a:	0f 84 ac 00 00 00    	je     8027ec <__umoddi3+0x108>
  802740:	bf 20 00 00 00       	mov    $0x20,%edi
  802745:	29 ef                	sub    %ebp,%edi
  802747:	89 fe                	mov    %edi,%esi
  802749:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80274d:	89 e9                	mov    %ebp,%ecx
  80274f:	d3 e0                	shl    %cl,%eax
  802751:	89 d7                	mov    %edx,%edi
  802753:	89 f1                	mov    %esi,%ecx
  802755:	d3 ef                	shr    %cl,%edi
  802757:	09 c7                	or     %eax,%edi
  802759:	89 e9                	mov    %ebp,%ecx
  80275b:	d3 e2                	shl    %cl,%edx
  80275d:	89 14 24             	mov    %edx,(%esp)
  802760:	89 d8                	mov    %ebx,%eax
  802762:	d3 e0                	shl    %cl,%eax
  802764:	89 c2                	mov    %eax,%edx
  802766:	8b 44 24 08          	mov    0x8(%esp),%eax
  80276a:	d3 e0                	shl    %cl,%eax
  80276c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802770:	8b 44 24 08          	mov    0x8(%esp),%eax
  802774:	89 f1                	mov    %esi,%ecx
  802776:	d3 e8                	shr    %cl,%eax
  802778:	09 d0                	or     %edx,%eax
  80277a:	d3 eb                	shr    %cl,%ebx
  80277c:	89 da                	mov    %ebx,%edx
  80277e:	f7 f7                	div    %edi
  802780:	89 d3                	mov    %edx,%ebx
  802782:	f7 24 24             	mull   (%esp)
  802785:	89 c6                	mov    %eax,%esi
  802787:	89 d1                	mov    %edx,%ecx
  802789:	39 d3                	cmp    %edx,%ebx
  80278b:	0f 82 87 00 00 00    	jb     802818 <__umoddi3+0x134>
  802791:	0f 84 91 00 00 00    	je     802828 <__umoddi3+0x144>
  802797:	8b 54 24 04          	mov    0x4(%esp),%edx
  80279b:	29 f2                	sub    %esi,%edx
  80279d:	19 cb                	sbb    %ecx,%ebx
  80279f:	89 d8                	mov    %ebx,%eax
  8027a1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8027a5:	d3 e0                	shl    %cl,%eax
  8027a7:	89 e9                	mov    %ebp,%ecx
  8027a9:	d3 ea                	shr    %cl,%edx
  8027ab:	09 d0                	or     %edx,%eax
  8027ad:	89 e9                	mov    %ebp,%ecx
  8027af:	d3 eb                	shr    %cl,%ebx
  8027b1:	89 da                	mov    %ebx,%edx
  8027b3:	83 c4 1c             	add    $0x1c,%esp
  8027b6:	5b                   	pop    %ebx
  8027b7:	5e                   	pop    %esi
  8027b8:	5f                   	pop    %edi
  8027b9:	5d                   	pop    %ebp
  8027ba:	c3                   	ret    
  8027bb:	90                   	nop
  8027bc:	89 fd                	mov    %edi,%ebp
  8027be:	85 ff                	test   %edi,%edi
  8027c0:	75 0b                	jne    8027cd <__umoddi3+0xe9>
  8027c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8027c7:	31 d2                	xor    %edx,%edx
  8027c9:	f7 f7                	div    %edi
  8027cb:	89 c5                	mov    %eax,%ebp
  8027cd:	89 f0                	mov    %esi,%eax
  8027cf:	31 d2                	xor    %edx,%edx
  8027d1:	f7 f5                	div    %ebp
  8027d3:	89 c8                	mov    %ecx,%eax
  8027d5:	f7 f5                	div    %ebp
  8027d7:	89 d0                	mov    %edx,%eax
  8027d9:	e9 44 ff ff ff       	jmp    802722 <__umoddi3+0x3e>
  8027de:	66 90                	xchg   %ax,%ax
  8027e0:	89 c8                	mov    %ecx,%eax
  8027e2:	89 f2                	mov    %esi,%edx
  8027e4:	83 c4 1c             	add    $0x1c,%esp
  8027e7:	5b                   	pop    %ebx
  8027e8:	5e                   	pop    %esi
  8027e9:	5f                   	pop    %edi
  8027ea:	5d                   	pop    %ebp
  8027eb:	c3                   	ret    
  8027ec:	3b 04 24             	cmp    (%esp),%eax
  8027ef:	72 06                	jb     8027f7 <__umoddi3+0x113>
  8027f1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027f5:	77 0f                	ja     802806 <__umoddi3+0x122>
  8027f7:	89 f2                	mov    %esi,%edx
  8027f9:	29 f9                	sub    %edi,%ecx
  8027fb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027ff:	89 14 24             	mov    %edx,(%esp)
  802802:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802806:	8b 44 24 04          	mov    0x4(%esp),%eax
  80280a:	8b 14 24             	mov    (%esp),%edx
  80280d:	83 c4 1c             	add    $0x1c,%esp
  802810:	5b                   	pop    %ebx
  802811:	5e                   	pop    %esi
  802812:	5f                   	pop    %edi
  802813:	5d                   	pop    %ebp
  802814:	c3                   	ret    
  802815:	8d 76 00             	lea    0x0(%esi),%esi
  802818:	2b 04 24             	sub    (%esp),%eax
  80281b:	19 fa                	sbb    %edi,%edx
  80281d:	89 d1                	mov    %edx,%ecx
  80281f:	89 c6                	mov    %eax,%esi
  802821:	e9 71 ff ff ff       	jmp    802797 <__umoddi3+0xb3>
  802826:	66 90                	xchg   %ax,%ax
  802828:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80282c:	72 ea                	jb     802818 <__umoddi3+0x134>
  80282e:	89 d9                	mov    %ebx,%ecx
  802830:	e9 62 ff ff ff       	jmp    802797 <__umoddi3+0xb3>
