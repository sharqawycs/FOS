
obj/user/tst_best_fit_1:     file format elf32-i386


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
  800031:	e8 c2 0a 00 00       	call   800af8 <libmain>
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
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 7d 24 00 00       	call   8024c7 <sys_set_uheap_strategy>
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
  80009b:	68 60 27 80 00       	push   $0x802760
  8000a0:	6a 15                	push   $0x15
  8000a2:	68 7c 27 80 00       	push   $0x80277c
  8000a7:	e8 4e 0b 00 00       	call   800bfa <_panic>
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
		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cb:	e8 64 1f 00 00       	call   802034 <sys_calculate_free_frames>
  8000d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d3:	e8 df 1f 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8000d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(3*Mega-kilo);
  8000db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000de:	89 c2                	mov    %eax,%edx
  8000e0:	01 d2                	add    %edx,%edx
  8000e2:	01 d0                	add    %edx,%eax
  8000e4:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e7:	83 ec 0c             	sub    $0xc,%esp
  8000ea:	50                   	push   %eax
  8000eb:	e8 82 1b 00 00       	call   801c72 <malloc>
  8000f0:	83 c4 10             	add    $0x10,%esp
  8000f3:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f6:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f9:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 94 27 80 00       	push   $0x802794
  800108:	6a 23                	push   $0x23
  80010a:	68 7c 27 80 00       	push   $0x80277c
  80010f:	e8 e6 0a 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  800114:	e8 9e 1f 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800119:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80011c:	3d 00 03 00 00       	cmp    $0x300,%eax
  800121:	74 14                	je     800137 <_main+0xff>
  800123:	83 ec 04             	sub    $0x4,%esp
  800126:	68 c4 27 80 00       	push   $0x8027c4
  80012b:	6a 25                	push   $0x25
  80012d:	68 7c 27 80 00       	push   $0x80277c
  800132:	e8 c3 0a 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800137:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80013a:	e8 f5 1e 00 00       	call   802034 <sys_calculate_free_frames>
  80013f:	29 c3                	sub    %eax,%ebx
  800141:	89 d8                	mov    %ebx,%eax
  800143:	83 f8 01             	cmp    $0x1,%eax
  800146:	74 14                	je     80015c <_main+0x124>
  800148:	83 ec 04             	sub    $0x4,%esp
  80014b:	68 e1 27 80 00       	push   $0x8027e1
  800150:	6a 26                	push   $0x26
  800152:	68 7c 27 80 00       	push   $0x80277c
  800157:	e8 9e 0a 00 00       	call   800bfa <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80015c:	e8 d3 1e 00 00       	call   802034 <sys_calculate_free_frames>
  800161:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800164:	e8 4e 1f 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800169:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  80016c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016f:	89 c2                	mov    %eax,%edx
  800171:	01 d2                	add    %edx,%edx
  800173:	01 d0                	add    %edx,%eax
  800175:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800178:	83 ec 0c             	sub    $0xc,%esp
  80017b:	50                   	push   %eax
  80017c:	e8 f1 1a 00 00       	call   801c72 <malloc>
  800181:	83 c4 10             	add    $0x10,%esp
  800184:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  800187:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018a:	89 c1                	mov    %eax,%ecx
  80018c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80018f:	89 c2                	mov    %eax,%edx
  800191:	01 d2                	add    %edx,%edx
  800193:	01 d0                	add    %edx,%eax
  800195:	05 00 00 00 80       	add    $0x80000000,%eax
  80019a:	39 c1                	cmp    %eax,%ecx
  80019c:	74 14                	je     8001b2 <_main+0x17a>
  80019e:	83 ec 04             	sub    $0x4,%esp
  8001a1:	68 94 27 80 00       	push   $0x802794
  8001a6:	6a 2c                	push   $0x2c
  8001a8:	68 7c 27 80 00       	push   $0x80277c
  8001ad:	e8 48 0a 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  8001b2:	e8 00 1f 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8001b7:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001ba:	3d 00 03 00 00       	cmp    $0x300,%eax
  8001bf:	74 14                	je     8001d5 <_main+0x19d>
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 c4 27 80 00       	push   $0x8027c4
  8001c9:	6a 2e                	push   $0x2e
  8001cb:	68 7c 27 80 00       	push   $0x80277c
  8001d0:	e8 25 0a 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001d5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001d8:	e8 57 1e 00 00       	call   802034 <sys_calculate_free_frames>
  8001dd:	29 c3                	sub    %eax,%ebx
  8001df:	89 d8                	mov    %ebx,%eax
  8001e1:	83 f8 01             	cmp    $0x1,%eax
  8001e4:	74 14                	je     8001fa <_main+0x1c2>
  8001e6:	83 ec 04             	sub    $0x4,%esp
  8001e9:	68 e1 27 80 00       	push   $0x8027e1
  8001ee:	6a 2f                	push   $0x2f
  8001f0:	68 7c 27 80 00       	push   $0x80277c
  8001f5:	e8 00 0a 00 00       	call   800bfa <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8001fa:	e8 35 1e 00 00       	call   802034 <sys_calculate_free_frames>
  8001ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800202:	e8 b0 1e 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800207:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*Mega-kilo);
  80020a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80020d:	01 c0                	add    %eax,%eax
  80020f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800212:	83 ec 0c             	sub    $0xc,%esp
  800215:	50                   	push   %eax
  800216:	e8 57 1a 00 00       	call   801c72 <malloc>
  80021b:	83 c4 10             	add    $0x10,%esp
  80021e:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  800221:	8b 45 98             	mov    -0x68(%ebp),%eax
  800224:	89 c1                	mov    %eax,%ecx
  800226:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800229:	89 d0                	mov    %edx,%eax
  80022b:	01 c0                	add    %eax,%eax
  80022d:	01 d0                	add    %edx,%eax
  80022f:	01 c0                	add    %eax,%eax
  800231:	05 00 00 00 80       	add    $0x80000000,%eax
  800236:	39 c1                	cmp    %eax,%ecx
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 94 27 80 00       	push   $0x802794
  800242:	6a 35                	push   $0x35
  800244:	68 7c 27 80 00       	push   $0x80277c
  800249:	e8 ac 09 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  80024e:	e8 64 1e 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800253:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800256:	3d 00 02 00 00       	cmp    $0x200,%eax
  80025b:	74 14                	je     800271 <_main+0x239>
  80025d:	83 ec 04             	sub    $0x4,%esp
  800260:	68 c4 27 80 00       	push   $0x8027c4
  800265:	6a 37                	push   $0x37
  800267:	68 7c 27 80 00       	push   $0x80277c
  80026c:	e8 89 09 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800271:	e8 be 1d 00 00       	call   802034 <sys_calculate_free_frames>
  800276:	89 c2                	mov    %eax,%edx
  800278:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80027b:	39 c2                	cmp    %eax,%edx
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 e1 27 80 00       	push   $0x8027e1
  800287:	6a 38                	push   $0x38
  800289:	68 7c 27 80 00       	push   $0x80277c
  80028e:	e8 67 09 00 00       	call   800bfa <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800293:	e8 9c 1d 00 00       	call   802034 <sys_calculate_free_frames>
  800298:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80029b:	e8 17 1e 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8002a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*Mega-kilo);
  8002a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a6:	01 c0                	add    %eax,%eax
  8002a8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8002ab:	83 ec 0c             	sub    $0xc,%esp
  8002ae:	50                   	push   %eax
  8002af:	e8 be 19 00 00       	call   801c72 <malloc>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8002ba:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002bd:	89 c2                	mov    %eax,%edx
  8002bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c2:	c1 e0 03             	shl    $0x3,%eax
  8002c5:	05 00 00 00 80       	add    $0x80000000,%eax
  8002ca:	39 c2                	cmp    %eax,%edx
  8002cc:	74 14                	je     8002e2 <_main+0x2aa>
  8002ce:	83 ec 04             	sub    $0x4,%esp
  8002d1:	68 94 27 80 00       	push   $0x802794
  8002d6:	6a 3e                	push   $0x3e
  8002d8:	68 7c 27 80 00       	push   $0x80277c
  8002dd:	e8 18 09 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  8002e2:	e8 d0 1d 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8002e7:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002ea:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002ef:	74 14                	je     800305 <_main+0x2cd>
  8002f1:	83 ec 04             	sub    $0x4,%esp
  8002f4:	68 c4 27 80 00       	push   $0x8027c4
  8002f9:	6a 40                	push   $0x40
  8002fb:	68 7c 27 80 00       	push   $0x80277c
  800300:	e8 f5 08 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800305:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800308:	e8 27 1d 00 00       	call   802034 <sys_calculate_free_frames>
  80030d:	29 c3                	sub    %eax,%ebx
  80030f:	89 d8                	mov    %ebx,%eax
  800311:	83 f8 01             	cmp    $0x1,%eax
  800314:	74 14                	je     80032a <_main+0x2f2>
  800316:	83 ec 04             	sub    $0x4,%esp
  800319:	68 e1 27 80 00       	push   $0x8027e1
  80031e:	6a 41                	push   $0x41
  800320:	68 7c 27 80 00       	push   $0x80277c
  800325:	e8 d0 08 00 00       	call   800bfa <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80032a:	e8 05 1d 00 00       	call   802034 <sys_calculate_free_frames>
  80032f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800332:	e8 80 1d 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800337:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(1*Mega-kilo);
  80033a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80033d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800340:	83 ec 0c             	sub    $0xc,%esp
  800343:	50                   	push   %eax
  800344:	e8 29 19 00 00       	call   801c72 <malloc>
  800349:	83 c4 10             	add    $0x10,%esp
  80034c:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 10*Mega) ) panic("Wrong start address for the allocated space... ");
  80034f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800352:	89 c1                	mov    %eax,%ecx
  800354:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800357:	89 d0                	mov    %edx,%eax
  800359:	c1 e0 02             	shl    $0x2,%eax
  80035c:	01 d0                	add    %edx,%eax
  80035e:	01 c0                	add    %eax,%eax
  800360:	05 00 00 00 80       	add    $0x80000000,%eax
  800365:	39 c1                	cmp    %eax,%ecx
  800367:	74 14                	je     80037d <_main+0x345>
  800369:	83 ec 04             	sub    $0x4,%esp
  80036c:	68 94 27 80 00       	push   $0x802794
  800371:	6a 47                	push   $0x47
  800373:	68 7c 27 80 00       	push   $0x80277c
  800378:	e8 7d 08 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80037d:	e8 35 1d 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800382:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800385:	3d 00 01 00 00       	cmp    $0x100,%eax
  80038a:	74 14                	je     8003a0 <_main+0x368>
  80038c:	83 ec 04             	sub    $0x4,%esp
  80038f:	68 c4 27 80 00       	push   $0x8027c4
  800394:	6a 49                	push   $0x49
  800396:	68 7c 27 80 00       	push   $0x80277c
  80039b:	e8 5a 08 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8003a0:	e8 8f 1c 00 00       	call   802034 <sys_calculate_free_frames>
  8003a5:	89 c2                	mov    %eax,%edx
  8003a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003aa:	39 c2                	cmp    %eax,%edx
  8003ac:	74 14                	je     8003c2 <_main+0x38a>
  8003ae:	83 ec 04             	sub    $0x4,%esp
  8003b1:	68 e1 27 80 00       	push   $0x8027e1
  8003b6:	6a 4a                	push   $0x4a
  8003b8:	68 7c 27 80 00       	push   $0x80277c
  8003bd:	e8 38 08 00 00       	call   800bfa <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8003c2:	e8 6d 1c 00 00       	call   802034 <sys_calculate_free_frames>
  8003c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003ca:	e8 e8 1c 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8003cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(1*Mega-kilo);
  8003d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d5:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003d8:	83 ec 0c             	sub    $0xc,%esp
  8003db:	50                   	push   %eax
  8003dc:	e8 91 18 00 00       	call   801c72 <malloc>
  8003e1:	83 c4 10             	add    $0x10,%esp
  8003e4:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 11*Mega) ) panic("Wrong start address for the allocated space... ");
  8003e7:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003ea:	89 c1                	mov    %eax,%ecx
  8003ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003ef:	89 d0                	mov    %edx,%eax
  8003f1:	c1 e0 02             	shl    $0x2,%eax
  8003f4:	01 d0                	add    %edx,%eax
  8003f6:	01 c0                	add    %eax,%eax
  8003f8:	01 d0                	add    %edx,%eax
  8003fa:	05 00 00 00 80       	add    $0x80000000,%eax
  8003ff:	39 c1                	cmp    %eax,%ecx
  800401:	74 14                	je     800417 <_main+0x3df>
  800403:	83 ec 04             	sub    $0x4,%esp
  800406:	68 94 27 80 00       	push   $0x802794
  80040b:	6a 50                	push   $0x50
  80040d:	68 7c 27 80 00       	push   $0x80277c
  800412:	e8 e3 07 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800417:	e8 9b 1c 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  80041c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80041f:	3d 00 01 00 00       	cmp    $0x100,%eax
  800424:	74 14                	je     80043a <_main+0x402>
  800426:	83 ec 04             	sub    $0x4,%esp
  800429:	68 c4 27 80 00       	push   $0x8027c4
  80042e:	6a 52                	push   $0x52
  800430:	68 7c 27 80 00       	push   $0x80277c
  800435:	e8 c0 07 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80043a:	e8 f5 1b 00 00       	call   802034 <sys_calculate_free_frames>
  80043f:	89 c2                	mov    %eax,%edx
  800441:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800444:	39 c2                	cmp    %eax,%edx
  800446:	74 14                	je     80045c <_main+0x424>
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 e1 27 80 00       	push   $0x8027e1
  800450:	6a 53                	push   $0x53
  800452:	68 7c 27 80 00       	push   $0x80277c
  800457:	e8 9e 07 00 00       	call   800bfa <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 d3 1b 00 00       	call   802034 <sys_calculate_free_frames>
  800461:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800464:	e8 4e 1c 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800469:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(1*Mega-kilo);
  80046c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800472:	83 ec 0c             	sub    $0xc,%esp
  800475:	50                   	push   %eax
  800476:	e8 f7 17 00 00       	call   801c72 <malloc>
  80047b:	83 c4 10             	add    $0x10,%esp
  80047e:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 12*Mega) ) panic("Wrong start address for the allocated space... ");
  800481:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800484:	89 c1                	mov    %eax,%ecx
  800486:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800489:	89 d0                	mov    %edx,%eax
  80048b:	01 c0                	add    %eax,%eax
  80048d:	01 d0                	add    %edx,%eax
  80048f:	c1 e0 02             	shl    $0x2,%eax
  800492:	05 00 00 00 80       	add    $0x80000000,%eax
  800497:	39 c1                	cmp    %eax,%ecx
  800499:	74 14                	je     8004af <_main+0x477>
  80049b:	83 ec 04             	sub    $0x4,%esp
  80049e:	68 94 27 80 00       	push   $0x802794
  8004a3:	6a 59                	push   $0x59
  8004a5:	68 7c 27 80 00       	push   $0x80277c
  8004aa:	e8 4b 07 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8004af:	e8 03 1c 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8004b4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004b7:	3d 00 01 00 00       	cmp    $0x100,%eax
  8004bc:	74 14                	je     8004d2 <_main+0x49a>
  8004be:	83 ec 04             	sub    $0x4,%esp
  8004c1:	68 c4 27 80 00       	push   $0x8027c4
  8004c6:	6a 5b                	push   $0x5b
  8004c8:	68 7c 27 80 00       	push   $0x80277c
  8004cd:	e8 28 07 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004d2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004d5:	e8 5a 1b 00 00       	call   802034 <sys_calculate_free_frames>
  8004da:	29 c3                	sub    %eax,%ebx
  8004dc:	89 d8                	mov    %ebx,%eax
  8004de:	83 f8 01             	cmp    $0x1,%eax
  8004e1:	74 14                	je     8004f7 <_main+0x4bf>
  8004e3:	83 ec 04             	sub    $0x4,%esp
  8004e6:	68 e1 27 80 00       	push   $0x8027e1
  8004eb:	6a 5c                	push   $0x5c
  8004ed:	68 7c 27 80 00       	push   $0x80277c
  8004f2:	e8 03 07 00 00       	call   800bfa <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8004f7:	e8 38 1b 00 00       	call   802034 <sys_calculate_free_frames>
  8004fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004ff:	e8 b3 1b 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800504:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(1*Mega-kilo);
  800507:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80050a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80050d:	83 ec 0c             	sub    $0xc,%esp
  800510:	50                   	push   %eax
  800511:	e8 5c 17 00 00       	call   801c72 <malloc>
  800516:	83 c4 10             	add    $0x10,%esp
  800519:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 13*Mega)) panic("Wrong start address for the allocated space... ");
  80051c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80051f:	89 c1                	mov    %eax,%ecx
  800521:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800524:	89 d0                	mov    %edx,%eax
  800526:	01 c0                	add    %eax,%eax
  800528:	01 d0                	add    %edx,%eax
  80052a:	c1 e0 02             	shl    $0x2,%eax
  80052d:	01 d0                	add    %edx,%eax
  80052f:	05 00 00 00 80       	add    $0x80000000,%eax
  800534:	39 c1                	cmp    %eax,%ecx
  800536:	74 14                	je     80054c <_main+0x514>
  800538:	83 ec 04             	sub    $0x4,%esp
  80053b:	68 94 27 80 00       	push   $0x802794
  800540:	6a 62                	push   $0x62
  800542:	68 7c 27 80 00       	push   $0x80277c
  800547:	e8 ae 06 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80054c:	e8 66 1b 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800551:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800554:	3d 00 01 00 00       	cmp    $0x100,%eax
  800559:	74 14                	je     80056f <_main+0x537>
  80055b:	83 ec 04             	sub    $0x4,%esp
  80055e:	68 c4 27 80 00       	push   $0x8027c4
  800563:	6a 64                	push   $0x64
  800565:	68 7c 27 80 00       	push   $0x80277c
  80056a:	e8 8b 06 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80056f:	e8 c0 1a 00 00       	call   802034 <sys_calculate_free_frames>
  800574:	89 c2                	mov    %eax,%edx
  800576:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800579:	39 c2                	cmp    %eax,%edx
  80057b:	74 14                	je     800591 <_main+0x559>
  80057d:	83 ec 04             	sub    $0x4,%esp
  800580:	68 e1 27 80 00       	push   $0x8027e1
  800585:	6a 65                	push   $0x65
  800587:	68 7c 27 80 00       	push   $0x80277c
  80058c:	e8 69 06 00 00       	call   800bfa <_panic>
	}

	//[2] Free some to create holes
	{
		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800591:	e8 9e 1a 00 00       	call   802034 <sys_calculate_free_frames>
  800596:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800599:	e8 19 1b 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  80059e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005a1:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005a4:	83 ec 0c             	sub    $0xc,%esp
  8005a7:	50                   	push   %eax
  8005a8:	e8 e6 17 00 00       	call   801d93 <free>
  8005ad:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  3*256) panic("Wrong page file free: ");
  8005b0:	e8 02 1b 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8005b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b8:	29 c2                	sub    %eax,%edx
  8005ba:	89 d0                	mov    %edx,%eax
  8005bc:	3d 00 03 00 00       	cmp    $0x300,%eax
  8005c1:	74 14                	je     8005d7 <_main+0x59f>
  8005c3:	83 ec 04             	sub    $0x4,%esp
  8005c6:	68 f4 27 80 00       	push   $0x8027f4
  8005cb:	6a 6f                	push   $0x6f
  8005cd:	68 7c 27 80 00       	push   $0x80277c
  8005d2:	e8 23 06 00 00       	call   800bfa <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005d7:	e8 58 1a 00 00       	call   802034 <sys_calculate_free_frames>
  8005dc:	89 c2                	mov    %eax,%edx
  8005de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005e1:	39 c2                	cmp    %eax,%edx
  8005e3:	74 14                	je     8005f9 <_main+0x5c1>
  8005e5:	83 ec 04             	sub    $0x4,%esp
  8005e8:	68 0b 28 80 00       	push   $0x80280b
  8005ed:	6a 70                	push   $0x70
  8005ef:	68 7c 27 80 00       	push   $0x80277c
  8005f4:	e8 01 06 00 00       	call   800bfa <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005f9:	e8 36 1a 00 00       	call   802034 <sys_calculate_free_frames>
  8005fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800601:	e8 b1 1a 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800606:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800609:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80060c:	83 ec 0c             	sub    $0xc,%esp
  80060f:	50                   	push   %eax
  800610:	e8 7e 17 00 00       	call   801d93 <free>
  800615:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  2*256) panic("Wrong page file free: ");
  800618:	e8 9a 1a 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  80061d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800620:	29 c2                	sub    %eax,%edx
  800622:	89 d0                	mov    %edx,%eax
  800624:	3d 00 02 00 00       	cmp    $0x200,%eax
  800629:	74 14                	je     80063f <_main+0x607>
  80062b:	83 ec 04             	sub    $0x4,%esp
  80062e:	68 f4 27 80 00       	push   $0x8027f4
  800633:	6a 77                	push   $0x77
  800635:	68 7c 27 80 00       	push   $0x80277c
  80063a:	e8 bb 05 00 00       	call   800bfa <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80063f:	e8 f0 19 00 00       	call   802034 <sys_calculate_free_frames>
  800644:	89 c2                	mov    %eax,%edx
  800646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800649:	39 c2                	cmp    %eax,%edx
  80064b:	74 14                	je     800661 <_main+0x629>
  80064d:	83 ec 04             	sub    $0x4,%esp
  800650:	68 0b 28 80 00       	push   $0x80280b
  800655:	6a 78                	push   $0x78
  800657:	68 7c 27 80 00       	push   $0x80277c
  80065c:	e8 99 05 00 00       	call   800bfa <_panic>

		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800661:	e8 ce 19 00 00       	call   802034 <sys_calculate_free_frames>
  800666:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800669:	e8 49 1a 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  80066e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  800671:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800674:	83 ec 0c             	sub    $0xc,%esp
  800677:	50                   	push   %eax
  800678:	e8 16 17 00 00       	call   801d93 <free>
  80067d:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800680:	e8 32 1a 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800685:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800688:	29 c2                	sub    %eax,%edx
  80068a:	89 d0                	mov    %edx,%eax
  80068c:	3d 00 01 00 00       	cmp    $0x100,%eax
  800691:	74 14                	je     8006a7 <_main+0x66f>
  800693:	83 ec 04             	sub    $0x4,%esp
  800696:	68 f4 27 80 00       	push   $0x8027f4
  80069b:	6a 7f                	push   $0x7f
  80069d:	68 7c 27 80 00       	push   $0x80277c
  8006a2:	e8 53 05 00 00       	call   800bfa <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8006a7:	e8 88 19 00 00       	call   802034 <sys_calculate_free_frames>
  8006ac:	89 c2                	mov    %eax,%edx
  8006ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b1:	39 c2                	cmp    %eax,%edx
  8006b3:	74 17                	je     8006cc <_main+0x694>
  8006b5:	83 ec 04             	sub    $0x4,%esp
  8006b8:	68 0b 28 80 00       	push   $0x80280b
  8006bd:	68 80 00 00 00       	push   $0x80
  8006c2:	68 7c 27 80 00       	push   $0x80277c
  8006c7:	e8 2e 05 00 00       	call   800bfa <_panic>
	}

	//[3] Allocate again [test best fit]
	{
		//Allocate 512 KB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  8006cc:	e8 63 19 00 00       	call   802034 <sys_calculate_free_frames>
  8006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006d4:	e8 de 19 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8006d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo);
  8006dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006df:	c1 e0 09             	shl    $0x9,%eax
  8006e2:	83 ec 0c             	sub    $0xc,%esp
  8006e5:	50                   	push   %eax
  8006e6:	e8 87 15 00 00       	call   801c72 <malloc>
  8006eb:	83 c4 10             	add    $0x10,%esp
  8006ee:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8006f1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006f4:	89 c1                	mov    %eax,%ecx
  8006f6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006f9:	89 d0                	mov    %edx,%eax
  8006fb:	c1 e0 02             	shl    $0x2,%eax
  8006fe:	01 d0                	add    %edx,%eax
  800700:	01 c0                	add    %eax,%eax
  800702:	01 d0                	add    %edx,%eax
  800704:	05 00 00 00 80       	add    $0x80000000,%eax
  800709:	39 c1                	cmp    %eax,%ecx
  80070b:	74 17                	je     800724 <_main+0x6ec>
  80070d:	83 ec 04             	sub    $0x4,%esp
  800710:	68 94 27 80 00       	push   $0x802794
  800715:	68 89 00 00 00       	push   $0x89
  80071a:	68 7c 27 80 00       	push   $0x80277c
  80071f:	e8 d6 04 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800724:	e8 8e 19 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800729:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80072c:	3d 80 00 00 00       	cmp    $0x80,%eax
  800731:	74 17                	je     80074a <_main+0x712>
  800733:	83 ec 04             	sub    $0x4,%esp
  800736:	68 c4 27 80 00       	push   $0x8027c4
  80073b:	68 8b 00 00 00       	push   $0x8b
  800740:	68 7c 27 80 00       	push   $0x80277c
  800745:	e8 b0 04 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80074a:	e8 e5 18 00 00       	call   802034 <sys_calculate_free_frames>
  80074f:	89 c2                	mov    %eax,%edx
  800751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800754:	39 c2                	cmp    %eax,%edx
  800756:	74 17                	je     80076f <_main+0x737>
  800758:	83 ec 04             	sub    $0x4,%esp
  80075b:	68 e1 27 80 00       	push   $0x8027e1
  800760:	68 8c 00 00 00       	push   $0x8c
  800765:	68 7c 27 80 00       	push   $0x80277c
  80076a:	e8 8b 04 00 00       	call   800bfa <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  80076f:	e8 c0 18 00 00       	call   802034 <sys_calculate_free_frames>
  800774:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800777:	e8 3b 19 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  80077c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  80077f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800782:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800785:	83 ec 0c             	sub    $0xc,%esp
  800788:	50                   	push   %eax
  800789:	e8 e4 14 00 00       	call   801c72 <malloc>
  80078e:	83 c4 10             	add    $0x10,%esp
  800791:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800794:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800797:	89 c2                	mov    %eax,%edx
  800799:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80079c:	c1 e0 03             	shl    $0x3,%eax
  80079f:	05 00 00 00 80       	add    $0x80000000,%eax
  8007a4:	39 c2                	cmp    %eax,%edx
  8007a6:	74 17                	je     8007bf <_main+0x787>
  8007a8:	83 ec 04             	sub    $0x4,%esp
  8007ab:	68 94 27 80 00       	push   $0x802794
  8007b0:	68 92 00 00 00       	push   $0x92
  8007b5:	68 7c 27 80 00       	push   $0x80277c
  8007ba:	e8 3b 04 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007bf:	e8 f3 18 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8007c4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007c7:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007cc:	74 17                	je     8007e5 <_main+0x7ad>
  8007ce:	83 ec 04             	sub    $0x4,%esp
  8007d1:	68 c4 27 80 00       	push   $0x8027c4
  8007d6:	68 94 00 00 00       	push   $0x94
  8007db:	68 7c 27 80 00       	push   $0x80277c
  8007e0:	e8 15 04 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007e5:	e8 4a 18 00 00       	call   802034 <sys_calculate_free_frames>
  8007ea:	89 c2                	mov    %eax,%edx
  8007ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007ef:	39 c2                	cmp    %eax,%edx
  8007f1:	74 17                	je     80080a <_main+0x7d2>
  8007f3:	83 ec 04             	sub    $0x4,%esp
  8007f6:	68 e1 27 80 00       	push   $0x8027e1
  8007fb:	68 95 00 00 00       	push   $0x95
  800800:	68 7c 27 80 00       	push   $0x80277c
  800805:	e8 f0 03 00 00       	call   800bfa <_panic>

		//Allocate 256 KB - should be placed in remaining of 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80080a:	e8 25 18 00 00       	call   802034 <sys_calculate_free_frames>
  80080f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800812:	e8 a0 18 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800817:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  80081a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081d:	89 d0                	mov    %edx,%eax
  80081f:	c1 e0 08             	shl    $0x8,%eax
  800822:	29 d0                	sub    %edx,%eax
  800824:	83 ec 0c             	sub    $0xc,%esp
  800827:	50                   	push   %eax
  800828:	e8 45 14 00 00       	call   801c72 <malloc>
  80082d:	83 c4 10             	add    $0x10,%esp
  800830:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 11*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800833:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800836:	89 c1                	mov    %eax,%ecx
  800838:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80083b:	89 d0                	mov    %edx,%eax
  80083d:	c1 e0 02             	shl    $0x2,%eax
  800840:	01 d0                	add    %edx,%eax
  800842:	01 c0                	add    %eax,%eax
  800844:	01 d0                	add    %edx,%eax
  800846:	89 c2                	mov    %eax,%edx
  800848:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80084b:	c1 e0 09             	shl    $0x9,%eax
  80084e:	01 d0                	add    %edx,%eax
  800850:	05 00 00 00 80       	add    $0x80000000,%eax
  800855:	39 c1                	cmp    %eax,%ecx
  800857:	74 17                	je     800870 <_main+0x838>
  800859:	83 ec 04             	sub    $0x4,%esp
  80085c:	68 94 27 80 00       	push   $0x802794
  800861:	68 9b 00 00 00       	push   $0x9b
  800866:	68 7c 27 80 00       	push   $0x80277c
  80086b:	e8 8a 03 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800870:	e8 42 18 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800875:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800878:	83 f8 40             	cmp    $0x40,%eax
  80087b:	74 17                	je     800894 <_main+0x85c>
  80087d:	83 ec 04             	sub    $0x4,%esp
  800880:	68 c4 27 80 00       	push   $0x8027c4
  800885:	68 9d 00 00 00       	push   $0x9d
  80088a:	68 7c 27 80 00       	push   $0x80277c
  80088f:	e8 66 03 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800894:	e8 9b 17 00 00       	call   802034 <sys_calculate_free_frames>
  800899:	89 c2                	mov    %eax,%edx
  80089b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80089e:	39 c2                	cmp    %eax,%edx
  8008a0:	74 17                	je     8008b9 <_main+0x881>
  8008a2:	83 ec 04             	sub    $0x4,%esp
  8008a5:	68 e1 27 80 00       	push   $0x8027e1
  8008aa:	68 9e 00 00 00       	push   $0x9e
  8008af:	68 7c 27 80 00       	push   $0x80277c
  8008b4:	e8 41 03 00 00       	call   800bfa <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  8008b9:	e8 76 17 00 00       	call   802034 <sys_calculate_free_frames>
  8008be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c1:	e8 f1 17 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8008c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  8008c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008cc:	c1 e0 02             	shl    $0x2,%eax
  8008cf:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8008d2:	83 ec 0c             	sub    $0xc,%esp
  8008d5:	50                   	push   %eax
  8008d6:	e8 97 13 00 00       	call   801c72 <malloc>
  8008db:	83 c4 10             	add    $0x10,%esp
  8008de:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  8008e1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008e4:	89 c1                	mov    %eax,%ecx
  8008e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8008e9:	89 d0                	mov    %edx,%eax
  8008eb:	01 c0                	add    %eax,%eax
  8008ed:	01 d0                	add    %edx,%eax
  8008ef:	01 c0                	add    %eax,%eax
  8008f1:	01 d0                	add    %edx,%eax
  8008f3:	01 c0                	add    %eax,%eax
  8008f5:	05 00 00 00 80       	add    $0x80000000,%eax
  8008fa:	39 c1                	cmp    %eax,%ecx
  8008fc:	74 17                	je     800915 <_main+0x8dd>
  8008fe:	83 ec 04             	sub    $0x4,%esp
  800901:	68 94 27 80 00       	push   $0x802794
  800906:	68 a4 00 00 00       	push   $0xa4
  80090b:	68 7c 27 80 00       	push   $0x80277c
  800910:	e8 e5 02 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800915:	e8 9d 17 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  80091a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80091d:	3d 00 04 00 00       	cmp    $0x400,%eax
  800922:	74 17                	je     80093b <_main+0x903>
  800924:	83 ec 04             	sub    $0x4,%esp
  800927:	68 c4 27 80 00       	push   $0x8027c4
  80092c:	68 a6 00 00 00       	push   $0xa6
  800931:	68 7c 27 80 00       	push   $0x80277c
  800936:	e8 bf 02 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80093b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80093e:	e8 f1 16 00 00       	call   802034 <sys_calculate_free_frames>
  800943:	29 c3                	sub    %eax,%ebx
  800945:	89 d8                	mov    %ebx,%eax
  800947:	83 f8 01             	cmp    $0x1,%eax
  80094a:	74 17                	je     800963 <_main+0x92b>
  80094c:	83 ec 04             	sub    $0x4,%esp
  80094f:	68 e1 27 80 00       	push   $0x8027e1
  800954:	68 a7 00 00 00       	push   $0xa7
  800959:	68 7c 27 80 00       	push   $0x80277c
  80095e:	e8 97 02 00 00       	call   800bfa <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1M Hole appended to already existing 1M hole in the middle
		freeFrames = sys_calculate_free_frames() ;
  800963:	e8 cc 16 00 00       	call   802034 <sys_calculate_free_frames>
  800968:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80096b:	e8 47 17 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800970:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  800973:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800976:	83 ec 0c             	sub    $0xc,%esp
  800979:	50                   	push   %eax
  80097a:	e8 14 14 00 00       	call   801d93 <free>
  80097f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800982:	e8 30 17 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800987:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80098a:	29 c2                	sub    %eax,%edx
  80098c:	89 d0                	mov    %edx,%eax
  80098e:	3d 00 01 00 00       	cmp    $0x100,%eax
  800993:	74 17                	je     8009ac <_main+0x974>
  800995:	83 ec 04             	sub    $0x4,%esp
  800998:	68 f4 27 80 00       	push   $0x8027f4
  80099d:	68 b1 00 00 00       	push   $0xb1
  8009a2:	68 7c 27 80 00       	push   $0x80277c
  8009a7:	e8 4e 02 00 00       	call   800bfa <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8009ac:	e8 83 16 00 00       	call   802034 <sys_calculate_free_frames>
  8009b1:	89 c2                	mov    %eax,%edx
  8009b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009b6:	39 c2                	cmp    %eax,%edx
  8009b8:	74 17                	je     8009d1 <_main+0x999>
  8009ba:	83 ec 04             	sub    $0x4,%esp
  8009bd:	68 0b 28 80 00       	push   $0x80280b
  8009c2:	68 b2 00 00 00       	push   $0xb2
  8009c7:	68 7c 27 80 00       	push   $0x80277c
  8009cc:	e8 29 02 00 00       	call   800bfa <_panic>

		//another 512 KB Hole appended to the hole
		freeFrames = sys_calculate_free_frames() ;
  8009d1:	e8 5e 16 00 00       	call   802034 <sys_calculate_free_frames>
  8009d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009d9:	e8 d9 16 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8009de:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[8]);
  8009e1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8009e4:	83 ec 0c             	sub    $0xc,%esp
  8009e7:	50                   	push   %eax
  8009e8:	e8 a6 13 00 00       	call   801d93 <free>
  8009ed:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  128) panic("Wrong page file free: ");
  8009f0:	e8 c2 16 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  8009f5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f8:	29 c2                	sub    %eax,%edx
  8009fa:	89 d0                	mov    %edx,%eax
  8009fc:	3d 80 00 00 00       	cmp    $0x80,%eax
  800a01:	74 17                	je     800a1a <_main+0x9e2>
  800a03:	83 ec 04             	sub    $0x4,%esp
  800a06:	68 f4 27 80 00       	push   $0x8027f4
  800a0b:	68 b9 00 00 00       	push   $0xb9
  800a10:	68 7c 27 80 00       	push   $0x80277c
  800a15:	e8 e0 01 00 00       	call   800bfa <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a1a:	e8 15 16 00 00       	call   802034 <sys_calculate_free_frames>
  800a1f:	89 c2                	mov    %eax,%edx
  800a21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a24:	39 c2                	cmp    %eax,%edx
  800a26:	74 17                	je     800a3f <_main+0xa07>
  800a28:	83 ec 04             	sub    $0x4,%esp
  800a2b:	68 0b 28 80 00       	push   $0x80280b
  800a30:	68 ba 00 00 00       	push   $0xba
  800a35:	68 7c 27 80 00       	push   $0x80277c
  800a3a:	e8 bb 01 00 00       	call   800bfa <_panic>
	}

	//[5] Allocate again [test best fit]
	{
		//Allocate 2 MB - should be placed in the contiguous hole (2 MB + 512 KB)
		freeFrames = sys_calculate_free_frames();
  800a3f:	e8 f0 15 00 00       	call   802034 <sys_calculate_free_frames>
  800a44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a47:	e8 6b 16 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800a4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(2*Mega - kilo);
  800a4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a52:	01 c0                	add    %eax,%eax
  800a54:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800a57:	83 ec 0c             	sub    $0xc,%esp
  800a5a:	50                   	push   %eax
  800a5b:	e8 12 12 00 00       	call   801c72 <malloc>
  800a60:	83 c4 10             	add    $0x10,%esp
  800a63:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 9*Mega)) panic("Wrong start address for the allocated space... ");
  800a66:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800a69:	89 c1                	mov    %eax,%ecx
  800a6b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a6e:	89 d0                	mov    %edx,%eax
  800a70:	c1 e0 03             	shl    $0x3,%eax
  800a73:	01 d0                	add    %edx,%eax
  800a75:	05 00 00 00 80       	add    $0x80000000,%eax
  800a7a:	39 c1                	cmp    %eax,%ecx
  800a7c:	74 17                	je     800a95 <_main+0xa5d>
  800a7e:	83 ec 04             	sub    $0x4,%esp
  800a81:	68 94 27 80 00       	push   $0x802794
  800a86:	68 c3 00 00 00       	push   $0xc3
  800a8b:	68 7c 27 80 00       	push   $0x80277c
  800a90:	e8 65 01 00 00       	call   800bfa <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800a95:	e8 1d 16 00 00       	call   8020b7 <sys_pf_calculate_allocated_pages>
  800a9a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a9d:	3d 00 02 00 00       	cmp    $0x200,%eax
  800aa2:	74 17                	je     800abb <_main+0xa83>
  800aa4:	83 ec 04             	sub    $0x4,%esp
  800aa7:	68 c4 27 80 00       	push   $0x8027c4
  800aac:	68 c5 00 00 00       	push   $0xc5
  800ab1:	68 7c 27 80 00       	push   $0x80277c
  800ab6:	e8 3f 01 00 00       	call   800bfa <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800abb:	e8 74 15 00 00       	call   802034 <sys_calculate_free_frames>
  800ac0:	89 c2                	mov    %eax,%edx
  800ac2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ac5:	39 c2                	cmp    %eax,%edx
  800ac7:	74 17                	je     800ae0 <_main+0xaa8>
  800ac9:	83 ec 04             	sub    $0x4,%esp
  800acc:	68 e1 27 80 00       	push   $0x8027e1
  800ad1:	68 c6 00 00 00       	push   $0xc6
  800ad6:	68 7c 27 80 00       	push   $0x80277c
  800adb:	e8 1a 01 00 00       	call   800bfa <_panic>
	}
	cprintf("Congratulations!! test BEST FIT allocation (1) completed successfully.\n");
  800ae0:	83 ec 0c             	sub    $0xc,%esp
  800ae3:	68 18 28 80 00       	push   $0x802818
  800ae8:	e8 c1 03 00 00       	call   800eae <cprintf>
  800aed:	83 c4 10             	add    $0x10,%esp

	return;
  800af0:	90                   	nop
}
  800af1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800af4:	5b                   	pop    %ebx
  800af5:	5f                   	pop    %edi
  800af6:	5d                   	pop    %ebp
  800af7:	c3                   	ret    

00800af8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800af8:	55                   	push   %ebp
  800af9:	89 e5                	mov    %esp,%ebp
  800afb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800afe:	e8 66 14 00 00       	call   801f69 <sys_getenvindex>
  800b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b09:	89 d0                	mov    %edx,%eax
  800b0b:	01 c0                	add    %eax,%eax
  800b0d:	01 d0                	add    %edx,%eax
  800b0f:	c1 e0 02             	shl    $0x2,%eax
  800b12:	01 d0                	add    %edx,%eax
  800b14:	c1 e0 06             	shl    $0x6,%eax
  800b17:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800b1c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b21:	a1 20 30 80 00       	mov    0x803020,%eax
  800b26:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800b2c:	84 c0                	test   %al,%al
  800b2e:	74 0f                	je     800b3f <libmain+0x47>
		binaryname = myEnv->prog_name;
  800b30:	a1 20 30 80 00       	mov    0x803020,%eax
  800b35:	05 f4 02 00 00       	add    $0x2f4,%eax
  800b3a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800b3f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b43:	7e 0a                	jle    800b4f <libmain+0x57>
		binaryname = argv[0];
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	8b 00                	mov    (%eax),%eax
  800b4a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800b4f:	83 ec 08             	sub    $0x8,%esp
  800b52:	ff 75 0c             	pushl  0xc(%ebp)
  800b55:	ff 75 08             	pushl  0x8(%ebp)
  800b58:	e8 db f4 ff ff       	call   800038 <_main>
  800b5d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800b60:	e8 9f 15 00 00       	call   802104 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800b65:	83 ec 0c             	sub    $0xc,%esp
  800b68:	68 78 28 80 00       	push   $0x802878
  800b6d:	e8 3c 03 00 00       	call   800eae <cprintf>
  800b72:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b75:	a1 20 30 80 00       	mov    0x803020,%eax
  800b7a:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800b80:	a1 20 30 80 00       	mov    0x803020,%eax
  800b85:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800b8b:	83 ec 04             	sub    $0x4,%esp
  800b8e:	52                   	push   %edx
  800b8f:	50                   	push   %eax
  800b90:	68 a0 28 80 00       	push   $0x8028a0
  800b95:	e8 14 03 00 00       	call   800eae <cprintf>
  800b9a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800b9d:	a1 20 30 80 00       	mov    0x803020,%eax
  800ba2:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800ba8:	83 ec 08             	sub    $0x8,%esp
  800bab:	50                   	push   %eax
  800bac:	68 c5 28 80 00       	push   $0x8028c5
  800bb1:	e8 f8 02 00 00       	call   800eae <cprintf>
  800bb6:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800bb9:	83 ec 0c             	sub    $0xc,%esp
  800bbc:	68 78 28 80 00       	push   $0x802878
  800bc1:	e8 e8 02 00 00       	call   800eae <cprintf>
  800bc6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800bc9:	e8 50 15 00 00       	call   80211e <sys_enable_interrupt>

	// exit gracefully
	exit();
  800bce:	e8 19 00 00 00       	call   800bec <exit>
}
  800bd3:	90                   	nop
  800bd4:	c9                   	leave  
  800bd5:	c3                   	ret    

00800bd6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800bd6:	55                   	push   %ebp
  800bd7:	89 e5                	mov    %esp,%ebp
  800bd9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800bdc:	83 ec 0c             	sub    $0xc,%esp
  800bdf:	6a 00                	push   $0x0
  800be1:	e8 4f 13 00 00       	call   801f35 <sys_env_destroy>
  800be6:	83 c4 10             	add    $0x10,%esp
}
  800be9:	90                   	nop
  800bea:	c9                   	leave  
  800beb:	c3                   	ret    

00800bec <exit>:

void
exit(void)
{
  800bec:	55                   	push   %ebp
  800bed:	89 e5                	mov    %esp,%ebp
  800bef:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800bf2:	e8 a4 13 00 00       	call   801f9b <sys_env_exit>
}
  800bf7:	90                   	nop
  800bf8:	c9                   	leave  
  800bf9:	c3                   	ret    

00800bfa <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
  800bfd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c00:	8d 45 10             	lea    0x10(%ebp),%eax
  800c03:	83 c0 04             	add    $0x4,%eax
  800c06:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c09:	a1 30 30 80 00       	mov    0x803030,%eax
  800c0e:	85 c0                	test   %eax,%eax
  800c10:	74 16                	je     800c28 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c12:	a1 30 30 80 00       	mov    0x803030,%eax
  800c17:	83 ec 08             	sub    $0x8,%esp
  800c1a:	50                   	push   %eax
  800c1b:	68 dc 28 80 00       	push   $0x8028dc
  800c20:	e8 89 02 00 00       	call   800eae <cprintf>
  800c25:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c28:	a1 00 30 80 00       	mov    0x803000,%eax
  800c2d:	ff 75 0c             	pushl  0xc(%ebp)
  800c30:	ff 75 08             	pushl  0x8(%ebp)
  800c33:	50                   	push   %eax
  800c34:	68 e1 28 80 00       	push   $0x8028e1
  800c39:	e8 70 02 00 00       	call   800eae <cprintf>
  800c3e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800c41:	8b 45 10             	mov    0x10(%ebp),%eax
  800c44:	83 ec 08             	sub    $0x8,%esp
  800c47:	ff 75 f4             	pushl  -0xc(%ebp)
  800c4a:	50                   	push   %eax
  800c4b:	e8 f3 01 00 00       	call   800e43 <vcprintf>
  800c50:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800c53:	83 ec 08             	sub    $0x8,%esp
  800c56:	6a 00                	push   $0x0
  800c58:	68 fd 28 80 00       	push   $0x8028fd
  800c5d:	e8 e1 01 00 00       	call   800e43 <vcprintf>
  800c62:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800c65:	e8 82 ff ff ff       	call   800bec <exit>

	// should not return here
	while (1) ;
  800c6a:	eb fe                	jmp    800c6a <_panic+0x70>

00800c6c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800c6c:	55                   	push   %ebp
  800c6d:	89 e5                	mov    %esp,%ebp
  800c6f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800c72:	a1 20 30 80 00       	mov    0x803020,%eax
  800c77:	8b 50 74             	mov    0x74(%eax),%edx
  800c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7d:	39 c2                	cmp    %eax,%edx
  800c7f:	74 14                	je     800c95 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800c81:	83 ec 04             	sub    $0x4,%esp
  800c84:	68 00 29 80 00       	push   $0x802900
  800c89:	6a 26                	push   $0x26
  800c8b:	68 4c 29 80 00       	push   $0x80294c
  800c90:	e8 65 ff ff ff       	call   800bfa <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800c95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800c9c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ca3:	e9 c2 00 00 00       	jmp    800d6a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800ca8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	01 d0                	add    %edx,%eax
  800cb7:	8b 00                	mov    (%eax),%eax
  800cb9:	85 c0                	test   %eax,%eax
  800cbb:	75 08                	jne    800cc5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800cbd:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800cc0:	e9 a2 00 00 00       	jmp    800d67 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800cc5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ccc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800cd3:	eb 69                	jmp    800d3e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800cd5:	a1 20 30 80 00       	mov    0x803020,%eax
  800cda:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ce0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ce3:	89 d0                	mov    %edx,%eax
  800ce5:	01 c0                	add    %eax,%eax
  800ce7:	01 d0                	add    %edx,%eax
  800ce9:	c1 e0 02             	shl    $0x2,%eax
  800cec:	01 c8                	add    %ecx,%eax
  800cee:	8a 40 04             	mov    0x4(%eax),%al
  800cf1:	84 c0                	test   %al,%al
  800cf3:	75 46                	jne    800d3b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800cf5:	a1 20 30 80 00       	mov    0x803020,%eax
  800cfa:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d00:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d03:	89 d0                	mov    %edx,%eax
  800d05:	01 c0                	add    %eax,%eax
  800d07:	01 d0                	add    %edx,%eax
  800d09:	c1 e0 02             	shl    $0x2,%eax
  800d0c:	01 c8                	add    %ecx,%eax
  800d0e:	8b 00                	mov    (%eax),%eax
  800d10:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d13:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d16:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d1b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d20:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	01 c8                	add    %ecx,%eax
  800d2c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d2e:	39 c2                	cmp    %eax,%edx
  800d30:	75 09                	jne    800d3b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800d32:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800d39:	eb 12                	jmp    800d4d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d3b:	ff 45 e8             	incl   -0x18(%ebp)
  800d3e:	a1 20 30 80 00       	mov    0x803020,%eax
  800d43:	8b 50 74             	mov    0x74(%eax),%edx
  800d46:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800d49:	39 c2                	cmp    %eax,%edx
  800d4b:	77 88                	ja     800cd5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800d4d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d51:	75 14                	jne    800d67 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800d53:	83 ec 04             	sub    $0x4,%esp
  800d56:	68 58 29 80 00       	push   $0x802958
  800d5b:	6a 3a                	push   $0x3a
  800d5d:	68 4c 29 80 00       	push   $0x80294c
  800d62:	e8 93 fe ff ff       	call   800bfa <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800d67:	ff 45 f0             	incl   -0x10(%ebp)
  800d6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d6d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800d70:	0f 8c 32 ff ff ff    	jl     800ca8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800d76:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d7d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800d84:	eb 26                	jmp    800dac <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800d86:	a1 20 30 80 00       	mov    0x803020,%eax
  800d8b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d91:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d94:	89 d0                	mov    %edx,%eax
  800d96:	01 c0                	add    %eax,%eax
  800d98:	01 d0                	add    %edx,%eax
  800d9a:	c1 e0 02             	shl    $0x2,%eax
  800d9d:	01 c8                	add    %ecx,%eax
  800d9f:	8a 40 04             	mov    0x4(%eax),%al
  800da2:	3c 01                	cmp    $0x1,%al
  800da4:	75 03                	jne    800da9 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800da6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800da9:	ff 45 e0             	incl   -0x20(%ebp)
  800dac:	a1 20 30 80 00       	mov    0x803020,%eax
  800db1:	8b 50 74             	mov    0x74(%eax),%edx
  800db4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800db7:	39 c2                	cmp    %eax,%edx
  800db9:	77 cb                	ja     800d86 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800dbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dbe:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800dc1:	74 14                	je     800dd7 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800dc3:	83 ec 04             	sub    $0x4,%esp
  800dc6:	68 ac 29 80 00       	push   $0x8029ac
  800dcb:	6a 44                	push   $0x44
  800dcd:	68 4c 29 80 00       	push   $0x80294c
  800dd2:	e8 23 fe ff ff       	call   800bfa <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800dd7:	90                   	nop
  800dd8:	c9                   	leave  
  800dd9:	c3                   	ret    

00800dda <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800dda:	55                   	push   %ebp
  800ddb:	89 e5                	mov    %esp,%ebp
  800ddd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800de0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de3:	8b 00                	mov    (%eax),%eax
  800de5:	8d 48 01             	lea    0x1(%eax),%ecx
  800de8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800deb:	89 0a                	mov    %ecx,(%edx)
  800ded:	8b 55 08             	mov    0x8(%ebp),%edx
  800df0:	88 d1                	mov    %dl,%cl
  800df2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800df9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfc:	8b 00                	mov    (%eax),%eax
  800dfe:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e03:	75 2c                	jne    800e31 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e05:	a0 24 30 80 00       	mov    0x803024,%al
  800e0a:	0f b6 c0             	movzbl %al,%eax
  800e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e10:	8b 12                	mov    (%edx),%edx
  800e12:	89 d1                	mov    %edx,%ecx
  800e14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e17:	83 c2 08             	add    $0x8,%edx
  800e1a:	83 ec 04             	sub    $0x4,%esp
  800e1d:	50                   	push   %eax
  800e1e:	51                   	push   %ecx
  800e1f:	52                   	push   %edx
  800e20:	e8 ce 10 00 00       	call   801ef3 <sys_cputs>
  800e25:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	8b 40 04             	mov    0x4(%eax),%eax
  800e37:	8d 50 01             	lea    0x1(%eax),%edx
  800e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800e40:	90                   	nop
  800e41:	c9                   	leave  
  800e42:	c3                   	ret    

00800e43 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800e43:	55                   	push   %ebp
  800e44:	89 e5                	mov    %esp,%ebp
  800e46:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800e4c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800e53:	00 00 00 
	b.cnt = 0;
  800e56:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800e5d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800e60:	ff 75 0c             	pushl  0xc(%ebp)
  800e63:	ff 75 08             	pushl  0x8(%ebp)
  800e66:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e6c:	50                   	push   %eax
  800e6d:	68 da 0d 80 00       	push   $0x800dda
  800e72:	e8 11 02 00 00       	call   801088 <vprintfmt>
  800e77:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800e7a:	a0 24 30 80 00       	mov    0x803024,%al
  800e7f:	0f b6 c0             	movzbl %al,%eax
  800e82:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800e88:	83 ec 04             	sub    $0x4,%esp
  800e8b:	50                   	push   %eax
  800e8c:	52                   	push   %edx
  800e8d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e93:	83 c0 08             	add    $0x8,%eax
  800e96:	50                   	push   %eax
  800e97:	e8 57 10 00 00       	call   801ef3 <sys_cputs>
  800e9c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800e9f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800ea6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800eac:	c9                   	leave  
  800ead:	c3                   	ret    

00800eae <cprintf>:

int cprintf(const char *fmt, ...) {
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
  800eb1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800eb4:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ebb:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ebe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	83 ec 08             	sub    $0x8,%esp
  800ec7:	ff 75 f4             	pushl  -0xc(%ebp)
  800eca:	50                   	push   %eax
  800ecb:	e8 73 ff ff ff       	call   800e43 <vcprintf>
  800ed0:	83 c4 10             	add    $0x10,%esp
  800ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ed6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ed9:	c9                   	leave  
  800eda:	c3                   	ret    

00800edb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800edb:	55                   	push   %ebp
  800edc:	89 e5                	mov    %esp,%ebp
  800ede:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ee1:	e8 1e 12 00 00       	call   802104 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ee6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ee9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	83 ec 08             	sub    $0x8,%esp
  800ef2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ef5:	50                   	push   %eax
  800ef6:	e8 48 ff ff ff       	call   800e43 <vcprintf>
  800efb:	83 c4 10             	add    $0x10,%esp
  800efe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f01:	e8 18 12 00 00       	call   80211e <sys_enable_interrupt>
	return cnt;
  800f06:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f09:	c9                   	leave  
  800f0a:	c3                   	ret    

00800f0b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f0b:	55                   	push   %ebp
  800f0c:	89 e5                	mov    %esp,%ebp
  800f0e:	53                   	push   %ebx
  800f0f:	83 ec 14             	sub    $0x14,%esp
  800f12:	8b 45 10             	mov    0x10(%ebp),%eax
  800f15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f18:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f1e:	8b 45 18             	mov    0x18(%ebp),%eax
  800f21:	ba 00 00 00 00       	mov    $0x0,%edx
  800f26:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f29:	77 55                	ja     800f80 <printnum+0x75>
  800f2b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f2e:	72 05                	jb     800f35 <printnum+0x2a>
  800f30:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f33:	77 4b                	ja     800f80 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800f35:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800f38:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800f3b:	8b 45 18             	mov    0x18(%ebp),%eax
  800f3e:	ba 00 00 00 00       	mov    $0x0,%edx
  800f43:	52                   	push   %edx
  800f44:	50                   	push   %eax
  800f45:	ff 75 f4             	pushl  -0xc(%ebp)
  800f48:	ff 75 f0             	pushl  -0x10(%ebp)
  800f4b:	e8 94 15 00 00       	call   8024e4 <__udivdi3>
  800f50:	83 c4 10             	add    $0x10,%esp
  800f53:	83 ec 04             	sub    $0x4,%esp
  800f56:	ff 75 20             	pushl  0x20(%ebp)
  800f59:	53                   	push   %ebx
  800f5a:	ff 75 18             	pushl  0x18(%ebp)
  800f5d:	52                   	push   %edx
  800f5e:	50                   	push   %eax
  800f5f:	ff 75 0c             	pushl  0xc(%ebp)
  800f62:	ff 75 08             	pushl  0x8(%ebp)
  800f65:	e8 a1 ff ff ff       	call   800f0b <printnum>
  800f6a:	83 c4 20             	add    $0x20,%esp
  800f6d:	eb 1a                	jmp    800f89 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800f6f:	83 ec 08             	sub    $0x8,%esp
  800f72:	ff 75 0c             	pushl  0xc(%ebp)
  800f75:	ff 75 20             	pushl  0x20(%ebp)
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	ff d0                	call   *%eax
  800f7d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800f80:	ff 4d 1c             	decl   0x1c(%ebp)
  800f83:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800f87:	7f e6                	jg     800f6f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800f89:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800f8c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f97:	53                   	push   %ebx
  800f98:	51                   	push   %ecx
  800f99:	52                   	push   %edx
  800f9a:	50                   	push   %eax
  800f9b:	e8 54 16 00 00       	call   8025f4 <__umoddi3>
  800fa0:	83 c4 10             	add    $0x10,%esp
  800fa3:	05 14 2c 80 00       	add    $0x802c14,%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f be c0             	movsbl %al,%eax
  800fad:	83 ec 08             	sub    $0x8,%esp
  800fb0:	ff 75 0c             	pushl  0xc(%ebp)
  800fb3:	50                   	push   %eax
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	ff d0                	call   *%eax
  800fb9:	83 c4 10             	add    $0x10,%esp
}
  800fbc:	90                   	nop
  800fbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800fc0:	c9                   	leave  
  800fc1:	c3                   	ret    

00800fc2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800fc2:	55                   	push   %ebp
  800fc3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800fc5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800fc9:	7e 1c                	jle    800fe7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	8b 00                	mov    (%eax),%eax
  800fd0:	8d 50 08             	lea    0x8(%eax),%edx
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	89 10                	mov    %edx,(%eax)
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	8b 00                	mov    (%eax),%eax
  800fdd:	83 e8 08             	sub    $0x8,%eax
  800fe0:	8b 50 04             	mov    0x4(%eax),%edx
  800fe3:	8b 00                	mov    (%eax),%eax
  800fe5:	eb 40                	jmp    801027 <getuint+0x65>
	else if (lflag)
  800fe7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800feb:	74 1e                	je     80100b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8b 00                	mov    (%eax),%eax
  800ff2:	8d 50 04             	lea    0x4(%eax),%edx
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	89 10                	mov    %edx,(%eax)
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8b 00                	mov    (%eax),%eax
  800fff:	83 e8 04             	sub    $0x4,%eax
  801002:	8b 00                	mov    (%eax),%eax
  801004:	ba 00 00 00 00       	mov    $0x0,%edx
  801009:	eb 1c                	jmp    801027 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	8b 00                	mov    (%eax),%eax
  801010:	8d 50 04             	lea    0x4(%eax),%edx
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	89 10                	mov    %edx,(%eax)
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8b 00                	mov    (%eax),%eax
  80101d:	83 e8 04             	sub    $0x4,%eax
  801020:	8b 00                	mov    (%eax),%eax
  801022:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801027:	5d                   	pop    %ebp
  801028:	c3                   	ret    

00801029 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80102c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801030:	7e 1c                	jle    80104e <getint+0x25>
		return va_arg(*ap, long long);
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	8b 00                	mov    (%eax),%eax
  801037:	8d 50 08             	lea    0x8(%eax),%edx
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	89 10                	mov    %edx,(%eax)
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	8b 00                	mov    (%eax),%eax
  801044:	83 e8 08             	sub    $0x8,%eax
  801047:	8b 50 04             	mov    0x4(%eax),%edx
  80104a:	8b 00                	mov    (%eax),%eax
  80104c:	eb 38                	jmp    801086 <getint+0x5d>
	else if (lflag)
  80104e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801052:	74 1a                	je     80106e <getint+0x45>
		return va_arg(*ap, long);
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	8b 00                	mov    (%eax),%eax
  801059:	8d 50 04             	lea    0x4(%eax),%edx
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	89 10                	mov    %edx,(%eax)
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	8b 00                	mov    (%eax),%eax
  801066:	83 e8 04             	sub    $0x4,%eax
  801069:	8b 00                	mov    (%eax),%eax
  80106b:	99                   	cltd   
  80106c:	eb 18                	jmp    801086 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	8b 00                	mov    (%eax),%eax
  801073:	8d 50 04             	lea    0x4(%eax),%edx
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	89 10                	mov    %edx,(%eax)
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8b 00                	mov    (%eax),%eax
  801080:	83 e8 04             	sub    $0x4,%eax
  801083:	8b 00                	mov    (%eax),%eax
  801085:	99                   	cltd   
}
  801086:	5d                   	pop    %ebp
  801087:	c3                   	ret    

00801088 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801088:	55                   	push   %ebp
  801089:	89 e5                	mov    %esp,%ebp
  80108b:	56                   	push   %esi
  80108c:	53                   	push   %ebx
  80108d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801090:	eb 17                	jmp    8010a9 <vprintfmt+0x21>
			if (ch == '\0')
  801092:	85 db                	test   %ebx,%ebx
  801094:	0f 84 af 03 00 00    	je     801449 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80109a:	83 ec 08             	sub    $0x8,%esp
  80109d:	ff 75 0c             	pushl  0xc(%ebp)
  8010a0:	53                   	push   %ebx
  8010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a4:	ff d0                	call   *%eax
  8010a6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ac:	8d 50 01             	lea    0x1(%eax),%edx
  8010af:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b2:	8a 00                	mov    (%eax),%al
  8010b4:	0f b6 d8             	movzbl %al,%ebx
  8010b7:	83 fb 25             	cmp    $0x25,%ebx
  8010ba:	75 d6                	jne    801092 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8010bc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8010c0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8010c7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8010ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8010d5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8010dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010df:	8d 50 01             	lea    0x1(%eax),%edx
  8010e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	0f b6 d8             	movzbl %al,%ebx
  8010ea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8010ed:	83 f8 55             	cmp    $0x55,%eax
  8010f0:	0f 87 2b 03 00 00    	ja     801421 <vprintfmt+0x399>
  8010f6:	8b 04 85 38 2c 80 00 	mov    0x802c38(,%eax,4),%eax
  8010fd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8010ff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801103:	eb d7                	jmp    8010dc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801105:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801109:	eb d1                	jmp    8010dc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80110b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801112:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801115:	89 d0                	mov    %edx,%eax
  801117:	c1 e0 02             	shl    $0x2,%eax
  80111a:	01 d0                	add    %edx,%eax
  80111c:	01 c0                	add    %eax,%eax
  80111e:	01 d8                	add    %ebx,%eax
  801120:	83 e8 30             	sub    $0x30,%eax
  801123:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801126:	8b 45 10             	mov    0x10(%ebp),%eax
  801129:	8a 00                	mov    (%eax),%al
  80112b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80112e:	83 fb 2f             	cmp    $0x2f,%ebx
  801131:	7e 3e                	jle    801171 <vprintfmt+0xe9>
  801133:	83 fb 39             	cmp    $0x39,%ebx
  801136:	7f 39                	jg     801171 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801138:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80113b:	eb d5                	jmp    801112 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80113d:	8b 45 14             	mov    0x14(%ebp),%eax
  801140:	83 c0 04             	add    $0x4,%eax
  801143:	89 45 14             	mov    %eax,0x14(%ebp)
  801146:	8b 45 14             	mov    0x14(%ebp),%eax
  801149:	83 e8 04             	sub    $0x4,%eax
  80114c:	8b 00                	mov    (%eax),%eax
  80114e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801151:	eb 1f                	jmp    801172 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801153:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801157:	79 83                	jns    8010dc <vprintfmt+0x54>
				width = 0;
  801159:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801160:	e9 77 ff ff ff       	jmp    8010dc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801165:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80116c:	e9 6b ff ff ff       	jmp    8010dc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801171:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801172:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801176:	0f 89 60 ff ff ff    	jns    8010dc <vprintfmt+0x54>
				width = precision, precision = -1;
  80117c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80117f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801182:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801189:	e9 4e ff ff ff       	jmp    8010dc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80118e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801191:	e9 46 ff ff ff       	jmp    8010dc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801196:	8b 45 14             	mov    0x14(%ebp),%eax
  801199:	83 c0 04             	add    $0x4,%eax
  80119c:	89 45 14             	mov    %eax,0x14(%ebp)
  80119f:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a2:	83 e8 04             	sub    $0x4,%eax
  8011a5:	8b 00                	mov    (%eax),%eax
  8011a7:	83 ec 08             	sub    $0x8,%esp
  8011aa:	ff 75 0c             	pushl  0xc(%ebp)
  8011ad:	50                   	push   %eax
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	ff d0                	call   *%eax
  8011b3:	83 c4 10             	add    $0x10,%esp
			break;
  8011b6:	e9 89 02 00 00       	jmp    801444 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8011bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011be:	83 c0 04             	add    $0x4,%eax
  8011c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8011c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c7:	83 e8 04             	sub    $0x4,%eax
  8011ca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8011cc:	85 db                	test   %ebx,%ebx
  8011ce:	79 02                	jns    8011d2 <vprintfmt+0x14a>
				err = -err;
  8011d0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8011d2:	83 fb 64             	cmp    $0x64,%ebx
  8011d5:	7f 0b                	jg     8011e2 <vprintfmt+0x15a>
  8011d7:	8b 34 9d 80 2a 80 00 	mov    0x802a80(,%ebx,4),%esi
  8011de:	85 f6                	test   %esi,%esi
  8011e0:	75 19                	jne    8011fb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8011e2:	53                   	push   %ebx
  8011e3:	68 25 2c 80 00       	push   $0x802c25
  8011e8:	ff 75 0c             	pushl  0xc(%ebp)
  8011eb:	ff 75 08             	pushl  0x8(%ebp)
  8011ee:	e8 5e 02 00 00       	call   801451 <printfmt>
  8011f3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8011f6:	e9 49 02 00 00       	jmp    801444 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8011fb:	56                   	push   %esi
  8011fc:	68 2e 2c 80 00       	push   $0x802c2e
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	ff 75 08             	pushl  0x8(%ebp)
  801207:	e8 45 02 00 00       	call   801451 <printfmt>
  80120c:	83 c4 10             	add    $0x10,%esp
			break;
  80120f:	e9 30 02 00 00       	jmp    801444 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801214:	8b 45 14             	mov    0x14(%ebp),%eax
  801217:	83 c0 04             	add    $0x4,%eax
  80121a:	89 45 14             	mov    %eax,0x14(%ebp)
  80121d:	8b 45 14             	mov    0x14(%ebp),%eax
  801220:	83 e8 04             	sub    $0x4,%eax
  801223:	8b 30                	mov    (%eax),%esi
  801225:	85 f6                	test   %esi,%esi
  801227:	75 05                	jne    80122e <vprintfmt+0x1a6>
				p = "(null)";
  801229:	be 31 2c 80 00       	mov    $0x802c31,%esi
			if (width > 0 && padc != '-')
  80122e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801232:	7e 6d                	jle    8012a1 <vprintfmt+0x219>
  801234:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801238:	74 67                	je     8012a1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80123a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80123d:	83 ec 08             	sub    $0x8,%esp
  801240:	50                   	push   %eax
  801241:	56                   	push   %esi
  801242:	e8 0c 03 00 00       	call   801553 <strnlen>
  801247:	83 c4 10             	add    $0x10,%esp
  80124a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80124d:	eb 16                	jmp    801265 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80124f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801253:	83 ec 08             	sub    $0x8,%esp
  801256:	ff 75 0c             	pushl  0xc(%ebp)
  801259:	50                   	push   %eax
  80125a:	8b 45 08             	mov    0x8(%ebp),%eax
  80125d:	ff d0                	call   *%eax
  80125f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801262:	ff 4d e4             	decl   -0x1c(%ebp)
  801265:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801269:	7f e4                	jg     80124f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80126b:	eb 34                	jmp    8012a1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80126d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801271:	74 1c                	je     80128f <vprintfmt+0x207>
  801273:	83 fb 1f             	cmp    $0x1f,%ebx
  801276:	7e 05                	jle    80127d <vprintfmt+0x1f5>
  801278:	83 fb 7e             	cmp    $0x7e,%ebx
  80127b:	7e 12                	jle    80128f <vprintfmt+0x207>
					putch('?', putdat);
  80127d:	83 ec 08             	sub    $0x8,%esp
  801280:	ff 75 0c             	pushl  0xc(%ebp)
  801283:	6a 3f                	push   $0x3f
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
  801288:	ff d0                	call   *%eax
  80128a:	83 c4 10             	add    $0x10,%esp
  80128d:	eb 0f                	jmp    80129e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80128f:	83 ec 08             	sub    $0x8,%esp
  801292:	ff 75 0c             	pushl  0xc(%ebp)
  801295:	53                   	push   %ebx
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	ff d0                	call   *%eax
  80129b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80129e:	ff 4d e4             	decl   -0x1c(%ebp)
  8012a1:	89 f0                	mov    %esi,%eax
  8012a3:	8d 70 01             	lea    0x1(%eax),%esi
  8012a6:	8a 00                	mov    (%eax),%al
  8012a8:	0f be d8             	movsbl %al,%ebx
  8012ab:	85 db                	test   %ebx,%ebx
  8012ad:	74 24                	je     8012d3 <vprintfmt+0x24b>
  8012af:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012b3:	78 b8                	js     80126d <vprintfmt+0x1e5>
  8012b5:	ff 4d e0             	decl   -0x20(%ebp)
  8012b8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012bc:	79 af                	jns    80126d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012be:	eb 13                	jmp    8012d3 <vprintfmt+0x24b>
				putch(' ', putdat);
  8012c0:	83 ec 08             	sub    $0x8,%esp
  8012c3:	ff 75 0c             	pushl  0xc(%ebp)
  8012c6:	6a 20                	push   $0x20
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	ff d0                	call   *%eax
  8012cd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012d0:	ff 4d e4             	decl   -0x1c(%ebp)
  8012d3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012d7:	7f e7                	jg     8012c0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8012d9:	e9 66 01 00 00       	jmp    801444 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8012de:	83 ec 08             	sub    $0x8,%esp
  8012e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8012e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8012e7:	50                   	push   %eax
  8012e8:	e8 3c fd ff ff       	call   801029 <getint>
  8012ed:	83 c4 10             	add    $0x10,%esp
  8012f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8012f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012fc:	85 d2                	test   %edx,%edx
  8012fe:	79 23                	jns    801323 <vprintfmt+0x29b>
				putch('-', putdat);
  801300:	83 ec 08             	sub    $0x8,%esp
  801303:	ff 75 0c             	pushl  0xc(%ebp)
  801306:	6a 2d                	push   $0x2d
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	ff d0                	call   *%eax
  80130d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801310:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801313:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801316:	f7 d8                	neg    %eax
  801318:	83 d2 00             	adc    $0x0,%edx
  80131b:	f7 da                	neg    %edx
  80131d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801320:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801323:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80132a:	e9 bc 00 00 00       	jmp    8013eb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80132f:	83 ec 08             	sub    $0x8,%esp
  801332:	ff 75 e8             	pushl  -0x18(%ebp)
  801335:	8d 45 14             	lea    0x14(%ebp),%eax
  801338:	50                   	push   %eax
  801339:	e8 84 fc ff ff       	call   800fc2 <getuint>
  80133e:	83 c4 10             	add    $0x10,%esp
  801341:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801344:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801347:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80134e:	e9 98 00 00 00       	jmp    8013eb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801353:	83 ec 08             	sub    $0x8,%esp
  801356:	ff 75 0c             	pushl  0xc(%ebp)
  801359:	6a 58                	push   $0x58
  80135b:	8b 45 08             	mov    0x8(%ebp),%eax
  80135e:	ff d0                	call   *%eax
  801360:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801363:	83 ec 08             	sub    $0x8,%esp
  801366:	ff 75 0c             	pushl  0xc(%ebp)
  801369:	6a 58                	push   $0x58
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	ff d0                	call   *%eax
  801370:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801373:	83 ec 08             	sub    $0x8,%esp
  801376:	ff 75 0c             	pushl  0xc(%ebp)
  801379:	6a 58                	push   $0x58
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	ff d0                	call   *%eax
  801380:	83 c4 10             	add    $0x10,%esp
			break;
  801383:	e9 bc 00 00 00       	jmp    801444 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801388:	83 ec 08             	sub    $0x8,%esp
  80138b:	ff 75 0c             	pushl  0xc(%ebp)
  80138e:	6a 30                	push   $0x30
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	ff d0                	call   *%eax
  801395:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801398:	83 ec 08             	sub    $0x8,%esp
  80139b:	ff 75 0c             	pushl  0xc(%ebp)
  80139e:	6a 78                	push   $0x78
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	ff d0                	call   *%eax
  8013a5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8013a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ab:	83 c0 04             	add    $0x4,%eax
  8013ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8013b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b4:	83 e8 04             	sub    $0x4,%eax
  8013b7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8013b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8013c3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8013ca:	eb 1f                	jmp    8013eb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8013cc:	83 ec 08             	sub    $0x8,%esp
  8013cf:	ff 75 e8             	pushl  -0x18(%ebp)
  8013d2:	8d 45 14             	lea    0x14(%ebp),%eax
  8013d5:	50                   	push   %eax
  8013d6:	e8 e7 fb ff ff       	call   800fc2 <getuint>
  8013db:	83 c4 10             	add    $0x10,%esp
  8013de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8013e4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8013eb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8013ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013f2:	83 ec 04             	sub    $0x4,%esp
  8013f5:	52                   	push   %edx
  8013f6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8013f9:	50                   	push   %eax
  8013fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8013fd:	ff 75 f0             	pushl  -0x10(%ebp)
  801400:	ff 75 0c             	pushl  0xc(%ebp)
  801403:	ff 75 08             	pushl  0x8(%ebp)
  801406:	e8 00 fb ff ff       	call   800f0b <printnum>
  80140b:	83 c4 20             	add    $0x20,%esp
			break;
  80140e:	eb 34                	jmp    801444 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801410:	83 ec 08             	sub    $0x8,%esp
  801413:	ff 75 0c             	pushl  0xc(%ebp)
  801416:	53                   	push   %ebx
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	ff d0                	call   *%eax
  80141c:	83 c4 10             	add    $0x10,%esp
			break;
  80141f:	eb 23                	jmp    801444 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801421:	83 ec 08             	sub    $0x8,%esp
  801424:	ff 75 0c             	pushl  0xc(%ebp)
  801427:	6a 25                	push   $0x25
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	ff d0                	call   *%eax
  80142e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801431:	ff 4d 10             	decl   0x10(%ebp)
  801434:	eb 03                	jmp    801439 <vprintfmt+0x3b1>
  801436:	ff 4d 10             	decl   0x10(%ebp)
  801439:	8b 45 10             	mov    0x10(%ebp),%eax
  80143c:	48                   	dec    %eax
  80143d:	8a 00                	mov    (%eax),%al
  80143f:	3c 25                	cmp    $0x25,%al
  801441:	75 f3                	jne    801436 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801443:	90                   	nop
		}
	}
  801444:	e9 47 fc ff ff       	jmp    801090 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801449:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80144a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80144d:	5b                   	pop    %ebx
  80144e:	5e                   	pop    %esi
  80144f:	5d                   	pop    %ebp
  801450:	c3                   	ret    

00801451 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
  801454:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801457:	8d 45 10             	lea    0x10(%ebp),%eax
  80145a:	83 c0 04             	add    $0x4,%eax
  80145d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801460:	8b 45 10             	mov    0x10(%ebp),%eax
  801463:	ff 75 f4             	pushl  -0xc(%ebp)
  801466:	50                   	push   %eax
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	ff 75 08             	pushl  0x8(%ebp)
  80146d:	e8 16 fc ff ff       	call   801088 <vprintfmt>
  801472:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801475:	90                   	nop
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80147b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147e:	8b 40 08             	mov    0x8(%eax),%eax
  801481:	8d 50 01             	lea    0x1(%eax),%edx
  801484:	8b 45 0c             	mov    0xc(%ebp),%eax
  801487:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80148a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148d:	8b 10                	mov    (%eax),%edx
  80148f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801492:	8b 40 04             	mov    0x4(%eax),%eax
  801495:	39 c2                	cmp    %eax,%edx
  801497:	73 12                	jae    8014ab <sprintputch+0x33>
		*b->buf++ = ch;
  801499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149c:	8b 00                	mov    (%eax),%eax
  80149e:	8d 48 01             	lea    0x1(%eax),%ecx
  8014a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a4:	89 0a                	mov    %ecx,(%edx)
  8014a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a9:	88 10                	mov    %dl,(%eax)
}
  8014ab:	90                   	nop
  8014ac:	5d                   	pop    %ebp
  8014ad:	c3                   	ret    

008014ae <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
  8014b1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	01 d0                	add    %edx,%eax
  8014c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8014cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014d3:	74 06                	je     8014db <vsnprintf+0x2d>
  8014d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014d9:	7f 07                	jg     8014e2 <vsnprintf+0x34>
		return -E_INVAL;
  8014db:	b8 03 00 00 00       	mov    $0x3,%eax
  8014e0:	eb 20                	jmp    801502 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8014e2:	ff 75 14             	pushl  0x14(%ebp)
  8014e5:	ff 75 10             	pushl  0x10(%ebp)
  8014e8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8014eb:	50                   	push   %eax
  8014ec:	68 78 14 80 00       	push   $0x801478
  8014f1:	e8 92 fb ff ff       	call   801088 <vprintfmt>
  8014f6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8014f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014fc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8014ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
  801507:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80150a:	8d 45 10             	lea    0x10(%ebp),%eax
  80150d:	83 c0 04             	add    $0x4,%eax
  801510:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801513:	8b 45 10             	mov    0x10(%ebp),%eax
  801516:	ff 75 f4             	pushl  -0xc(%ebp)
  801519:	50                   	push   %eax
  80151a:	ff 75 0c             	pushl  0xc(%ebp)
  80151d:	ff 75 08             	pushl  0x8(%ebp)
  801520:	e8 89 ff ff ff       	call   8014ae <vsnprintf>
  801525:	83 c4 10             	add    $0x10,%esp
  801528:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80152b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
  801533:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801536:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80153d:	eb 06                	jmp    801545 <strlen+0x15>
		n++;
  80153f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801542:	ff 45 08             	incl   0x8(%ebp)
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	8a 00                	mov    (%eax),%al
  80154a:	84 c0                	test   %al,%al
  80154c:	75 f1                	jne    80153f <strlen+0xf>
		n++;
	return n;
  80154e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
  801556:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801559:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801560:	eb 09                	jmp    80156b <strnlen+0x18>
		n++;
  801562:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801565:	ff 45 08             	incl   0x8(%ebp)
  801568:	ff 4d 0c             	decl   0xc(%ebp)
  80156b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80156f:	74 09                	je     80157a <strnlen+0x27>
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	8a 00                	mov    (%eax),%al
  801576:	84 c0                	test   %al,%al
  801578:	75 e8                	jne    801562 <strnlen+0xf>
		n++;
	return n;
  80157a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
  801582:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
  801588:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80158b:	90                   	nop
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8d 50 01             	lea    0x1(%eax),%edx
  801592:	89 55 08             	mov    %edx,0x8(%ebp)
  801595:	8b 55 0c             	mov    0xc(%ebp),%edx
  801598:	8d 4a 01             	lea    0x1(%edx),%ecx
  80159b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80159e:	8a 12                	mov    (%edx),%dl
  8015a0:	88 10                	mov    %dl,(%eax)
  8015a2:	8a 00                	mov    (%eax),%al
  8015a4:	84 c0                	test   %al,%al
  8015a6:	75 e4                	jne    80158c <strcpy+0xd>
		/* do nothing */;
	return ret;
  8015a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
  8015b0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8015b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8015b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c0:	eb 1f                	jmp    8015e1 <strncpy+0x34>
		*dst++ = *src;
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	8d 50 01             	lea    0x1(%eax),%edx
  8015c8:	89 55 08             	mov    %edx,0x8(%ebp)
  8015cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ce:	8a 12                	mov    (%edx),%dl
  8015d0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8015d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	84 c0                	test   %al,%al
  8015d9:	74 03                	je     8015de <strncpy+0x31>
			src++;
  8015db:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8015de:	ff 45 fc             	incl   -0x4(%ebp)
  8015e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015e7:	72 d9                	jb     8015c2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8015e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
  8015f1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8015fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fe:	74 30                	je     801630 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801600:	eb 16                	jmp    801618 <strlcpy+0x2a>
			*dst++ = *src++;
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	8d 50 01             	lea    0x1(%eax),%edx
  801608:	89 55 08             	mov    %edx,0x8(%ebp)
  80160b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801611:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801614:	8a 12                	mov    (%edx),%dl
  801616:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801618:	ff 4d 10             	decl   0x10(%ebp)
  80161b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80161f:	74 09                	je     80162a <strlcpy+0x3c>
  801621:	8b 45 0c             	mov    0xc(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	84 c0                	test   %al,%al
  801628:	75 d8                	jne    801602 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801630:	8b 55 08             	mov    0x8(%ebp),%edx
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801636:	29 c2                	sub    %eax,%edx
  801638:	89 d0                	mov    %edx,%eax
}
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80163f:	eb 06                	jmp    801647 <strcmp+0xb>
		p++, q++;
  801641:	ff 45 08             	incl   0x8(%ebp)
  801644:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	8a 00                	mov    (%eax),%al
  80164c:	84 c0                	test   %al,%al
  80164e:	74 0e                	je     80165e <strcmp+0x22>
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	8a 10                	mov    (%eax),%dl
  801655:	8b 45 0c             	mov    0xc(%ebp),%eax
  801658:	8a 00                	mov    (%eax),%al
  80165a:	38 c2                	cmp    %al,%dl
  80165c:	74 e3                	je     801641 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	8a 00                	mov    (%eax),%al
  801663:	0f b6 d0             	movzbl %al,%edx
  801666:	8b 45 0c             	mov    0xc(%ebp),%eax
  801669:	8a 00                	mov    (%eax),%al
  80166b:	0f b6 c0             	movzbl %al,%eax
  80166e:	29 c2                	sub    %eax,%edx
  801670:	89 d0                	mov    %edx,%eax
}
  801672:	5d                   	pop    %ebp
  801673:	c3                   	ret    

00801674 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801677:	eb 09                	jmp    801682 <strncmp+0xe>
		n--, p++, q++;
  801679:	ff 4d 10             	decl   0x10(%ebp)
  80167c:	ff 45 08             	incl   0x8(%ebp)
  80167f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801682:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801686:	74 17                	je     80169f <strncmp+0x2b>
  801688:	8b 45 08             	mov    0x8(%ebp),%eax
  80168b:	8a 00                	mov    (%eax),%al
  80168d:	84 c0                	test   %al,%al
  80168f:	74 0e                	je     80169f <strncmp+0x2b>
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	8a 10                	mov    (%eax),%dl
  801696:	8b 45 0c             	mov    0xc(%ebp),%eax
  801699:	8a 00                	mov    (%eax),%al
  80169b:	38 c2                	cmp    %al,%dl
  80169d:	74 da                	je     801679 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80169f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a3:	75 07                	jne    8016ac <strncmp+0x38>
		return 0;
  8016a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8016aa:	eb 14                	jmp    8016c0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	0f b6 d0             	movzbl %al,%edx
  8016b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	0f b6 c0             	movzbl %al,%eax
  8016bc:	29 c2                	sub    %eax,%edx
  8016be:	89 d0                	mov    %edx,%eax
}
  8016c0:	5d                   	pop    %ebp
  8016c1:	c3                   	ret    

008016c2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8016c2:	55                   	push   %ebp
  8016c3:	89 e5                	mov    %esp,%ebp
  8016c5:	83 ec 04             	sub    $0x4,%esp
  8016c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016ce:	eb 12                	jmp    8016e2 <strchr+0x20>
		if (*s == c)
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	8a 00                	mov    (%eax),%al
  8016d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8016d8:	75 05                	jne    8016df <strchr+0x1d>
			return (char *) s;
  8016da:	8b 45 08             	mov    0x8(%ebp),%eax
  8016dd:	eb 11                	jmp    8016f0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8016df:	ff 45 08             	incl   0x8(%ebp)
  8016e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e5:	8a 00                	mov    (%eax),%al
  8016e7:	84 c0                	test   %al,%al
  8016e9:	75 e5                	jne    8016d0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8016eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016f0:	c9                   	leave  
  8016f1:	c3                   	ret    

008016f2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
  8016f5:	83 ec 04             	sub    $0x4,%esp
  8016f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016fe:	eb 0d                	jmp    80170d <strfind+0x1b>
		if (*s == c)
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801708:	74 0e                	je     801718 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80170a:	ff 45 08             	incl   0x8(%ebp)
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	8a 00                	mov    (%eax),%al
  801712:	84 c0                	test   %al,%al
  801714:	75 ea                	jne    801700 <strfind+0xe>
  801716:	eb 01                	jmp    801719 <strfind+0x27>
		if (*s == c)
			break;
  801718:	90                   	nop
	return (char *) s;
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
  801721:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80172a:	8b 45 10             	mov    0x10(%ebp),%eax
  80172d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801730:	eb 0e                	jmp    801740 <memset+0x22>
		*p++ = c;
  801732:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801735:	8d 50 01             	lea    0x1(%eax),%edx
  801738:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80173b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801740:	ff 4d f8             	decl   -0x8(%ebp)
  801743:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801747:	79 e9                	jns    801732 <memset+0x14>
		*p++ = c;

	return v;
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
  801751:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801754:	8b 45 0c             	mov    0xc(%ebp),%eax
  801757:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80175a:	8b 45 08             	mov    0x8(%ebp),%eax
  80175d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801760:	eb 16                	jmp    801778 <memcpy+0x2a>
		*d++ = *s++;
  801762:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801765:	8d 50 01             	lea    0x1(%eax),%edx
  801768:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80176b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80176e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801771:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801774:	8a 12                	mov    (%edx),%dl
  801776:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801778:	8b 45 10             	mov    0x10(%ebp),%eax
  80177b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80177e:	89 55 10             	mov    %edx,0x10(%ebp)
  801781:	85 c0                	test   %eax,%eax
  801783:	75 dd                	jne    801762 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801785:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
  80178d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801790:	8b 45 0c             	mov    0xc(%ebp),%eax
  801793:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80179c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80179f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017a2:	73 50                	jae    8017f4 <memmove+0x6a>
  8017a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017aa:	01 d0                	add    %edx,%eax
  8017ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017af:	76 43                	jbe    8017f4 <memmove+0x6a>
		s += n;
  8017b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8017b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ba:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8017bd:	eb 10                	jmp    8017cf <memmove+0x45>
			*--d = *--s;
  8017bf:	ff 4d f8             	decl   -0x8(%ebp)
  8017c2:	ff 4d fc             	decl   -0x4(%ebp)
  8017c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017c8:	8a 10                	mov    (%eax),%dl
  8017ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017cd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8017cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8017d8:	85 c0                	test   %eax,%eax
  8017da:	75 e3                	jne    8017bf <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8017dc:	eb 23                	jmp    801801 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8017de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e1:	8d 50 01             	lea    0x1(%eax),%edx
  8017e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017ea:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017ed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017f0:	8a 12                	mov    (%edx),%dl
  8017f2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8017f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8017fd:	85 c0                	test   %eax,%eax
  8017ff:	75 dd                	jne    8017de <memmove+0x54>
			*d++ = *s++;

	return dst;
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801804:	c9                   	leave  
  801805:	c3                   	ret    

00801806 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
  801809:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801812:	8b 45 0c             	mov    0xc(%ebp),%eax
  801815:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801818:	eb 2a                	jmp    801844 <memcmp+0x3e>
		if (*s1 != *s2)
  80181a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80181d:	8a 10                	mov    (%eax),%dl
  80181f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	38 c2                	cmp    %al,%dl
  801826:	74 16                	je     80183e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801828:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80182b:	8a 00                	mov    (%eax),%al
  80182d:	0f b6 d0             	movzbl %al,%edx
  801830:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801833:	8a 00                	mov    (%eax),%al
  801835:	0f b6 c0             	movzbl %al,%eax
  801838:	29 c2                	sub    %eax,%edx
  80183a:	89 d0                	mov    %edx,%eax
  80183c:	eb 18                	jmp    801856 <memcmp+0x50>
		s1++, s2++;
  80183e:	ff 45 fc             	incl   -0x4(%ebp)
  801841:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801844:	8b 45 10             	mov    0x10(%ebp),%eax
  801847:	8d 50 ff             	lea    -0x1(%eax),%edx
  80184a:	89 55 10             	mov    %edx,0x10(%ebp)
  80184d:	85 c0                	test   %eax,%eax
  80184f:	75 c9                	jne    80181a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801851:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
  80185b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80185e:	8b 55 08             	mov    0x8(%ebp),%edx
  801861:	8b 45 10             	mov    0x10(%ebp),%eax
  801864:	01 d0                	add    %edx,%eax
  801866:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801869:	eb 15                	jmp    801880 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	8a 00                	mov    (%eax),%al
  801870:	0f b6 d0             	movzbl %al,%edx
  801873:	8b 45 0c             	mov    0xc(%ebp),%eax
  801876:	0f b6 c0             	movzbl %al,%eax
  801879:	39 c2                	cmp    %eax,%edx
  80187b:	74 0d                	je     80188a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80187d:	ff 45 08             	incl   0x8(%ebp)
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801886:	72 e3                	jb     80186b <memfind+0x13>
  801888:	eb 01                	jmp    80188b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80188a:	90                   	nop
	return (void *) s;
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
  801893:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801896:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80189d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018a4:	eb 03                	jmp    8018a9 <strtol+0x19>
		s++;
  8018a6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	8a 00                	mov    (%eax),%al
  8018ae:	3c 20                	cmp    $0x20,%al
  8018b0:	74 f4                	je     8018a6 <strtol+0x16>
  8018b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b5:	8a 00                	mov    (%eax),%al
  8018b7:	3c 09                	cmp    $0x9,%al
  8018b9:	74 eb                	je     8018a6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	8a 00                	mov    (%eax),%al
  8018c0:	3c 2b                	cmp    $0x2b,%al
  8018c2:	75 05                	jne    8018c9 <strtol+0x39>
		s++;
  8018c4:	ff 45 08             	incl   0x8(%ebp)
  8018c7:	eb 13                	jmp    8018dc <strtol+0x4c>
	else if (*s == '-')
  8018c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cc:	8a 00                	mov    (%eax),%al
  8018ce:	3c 2d                	cmp    $0x2d,%al
  8018d0:	75 0a                	jne    8018dc <strtol+0x4c>
		s++, neg = 1;
  8018d2:	ff 45 08             	incl   0x8(%ebp)
  8018d5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8018dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018e0:	74 06                	je     8018e8 <strtol+0x58>
  8018e2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8018e6:	75 20                	jne    801908 <strtol+0x78>
  8018e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018eb:	8a 00                	mov    (%eax),%al
  8018ed:	3c 30                	cmp    $0x30,%al
  8018ef:	75 17                	jne    801908 <strtol+0x78>
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	40                   	inc    %eax
  8018f5:	8a 00                	mov    (%eax),%al
  8018f7:	3c 78                	cmp    $0x78,%al
  8018f9:	75 0d                	jne    801908 <strtol+0x78>
		s += 2, base = 16;
  8018fb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8018ff:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801906:	eb 28                	jmp    801930 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801908:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80190c:	75 15                	jne    801923 <strtol+0x93>
  80190e:	8b 45 08             	mov    0x8(%ebp),%eax
  801911:	8a 00                	mov    (%eax),%al
  801913:	3c 30                	cmp    $0x30,%al
  801915:	75 0c                	jne    801923 <strtol+0x93>
		s++, base = 8;
  801917:	ff 45 08             	incl   0x8(%ebp)
  80191a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801921:	eb 0d                	jmp    801930 <strtol+0xa0>
	else if (base == 0)
  801923:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801927:	75 07                	jne    801930 <strtol+0xa0>
		base = 10;
  801929:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801930:	8b 45 08             	mov    0x8(%ebp),%eax
  801933:	8a 00                	mov    (%eax),%al
  801935:	3c 2f                	cmp    $0x2f,%al
  801937:	7e 19                	jle    801952 <strtol+0xc2>
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	8a 00                	mov    (%eax),%al
  80193e:	3c 39                	cmp    $0x39,%al
  801940:	7f 10                	jg     801952 <strtol+0xc2>
			dig = *s - '0';
  801942:	8b 45 08             	mov    0x8(%ebp),%eax
  801945:	8a 00                	mov    (%eax),%al
  801947:	0f be c0             	movsbl %al,%eax
  80194a:	83 e8 30             	sub    $0x30,%eax
  80194d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801950:	eb 42                	jmp    801994 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801952:	8b 45 08             	mov    0x8(%ebp),%eax
  801955:	8a 00                	mov    (%eax),%al
  801957:	3c 60                	cmp    $0x60,%al
  801959:	7e 19                	jle    801974 <strtol+0xe4>
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	8a 00                	mov    (%eax),%al
  801960:	3c 7a                	cmp    $0x7a,%al
  801962:	7f 10                	jg     801974 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	8a 00                	mov    (%eax),%al
  801969:	0f be c0             	movsbl %al,%eax
  80196c:	83 e8 57             	sub    $0x57,%eax
  80196f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801972:	eb 20                	jmp    801994 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	8a 00                	mov    (%eax),%al
  801979:	3c 40                	cmp    $0x40,%al
  80197b:	7e 39                	jle    8019b6 <strtol+0x126>
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	8a 00                	mov    (%eax),%al
  801982:	3c 5a                	cmp    $0x5a,%al
  801984:	7f 30                	jg     8019b6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801986:	8b 45 08             	mov    0x8(%ebp),%eax
  801989:	8a 00                	mov    (%eax),%al
  80198b:	0f be c0             	movsbl %al,%eax
  80198e:	83 e8 37             	sub    $0x37,%eax
  801991:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801994:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801997:	3b 45 10             	cmp    0x10(%ebp),%eax
  80199a:	7d 19                	jge    8019b5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80199c:	ff 45 08             	incl   0x8(%ebp)
  80199f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8019a6:	89 c2                	mov    %eax,%edx
  8019a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019ab:	01 d0                	add    %edx,%eax
  8019ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8019b0:	e9 7b ff ff ff       	jmp    801930 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8019b5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8019b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019ba:	74 08                	je     8019c4 <strtol+0x134>
		*endptr = (char *) s;
  8019bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8019c2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8019c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019c8:	74 07                	je     8019d1 <strtol+0x141>
  8019ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019cd:	f7 d8                	neg    %eax
  8019cf:	eb 03                	jmp    8019d4 <strtol+0x144>
  8019d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <ltostr>:

void
ltostr(long value, char *str)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
  8019d9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8019dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8019e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8019ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019ee:	79 13                	jns    801a03 <ltostr+0x2d>
	{
		neg = 1;
  8019f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8019f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8019fd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a00:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a0b:	99                   	cltd   
  801a0c:	f7 f9                	idiv   %ecx
  801a0e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a11:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a14:	8d 50 01             	lea    0x1(%eax),%edx
  801a17:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a1a:	89 c2                	mov    %eax,%edx
  801a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1f:	01 d0                	add    %edx,%eax
  801a21:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a24:	83 c2 30             	add    $0x30,%edx
  801a27:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a2c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a31:	f7 e9                	imul   %ecx
  801a33:	c1 fa 02             	sar    $0x2,%edx
  801a36:	89 c8                	mov    %ecx,%eax
  801a38:	c1 f8 1f             	sar    $0x1f,%eax
  801a3b:	29 c2                	sub    %eax,%edx
  801a3d:	89 d0                	mov    %edx,%eax
  801a3f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801a42:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a45:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a4a:	f7 e9                	imul   %ecx
  801a4c:	c1 fa 02             	sar    $0x2,%edx
  801a4f:	89 c8                	mov    %ecx,%eax
  801a51:	c1 f8 1f             	sar    $0x1f,%eax
  801a54:	29 c2                	sub    %eax,%edx
  801a56:	89 d0                	mov    %edx,%eax
  801a58:	c1 e0 02             	shl    $0x2,%eax
  801a5b:	01 d0                	add    %edx,%eax
  801a5d:	01 c0                	add    %eax,%eax
  801a5f:	29 c1                	sub    %eax,%ecx
  801a61:	89 ca                	mov    %ecx,%edx
  801a63:	85 d2                	test   %edx,%edx
  801a65:	75 9c                	jne    801a03 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801a67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801a6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a71:	48                   	dec    %eax
  801a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a75:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a79:	74 3d                	je     801ab8 <ltostr+0xe2>
		start = 1 ;
  801a7b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a82:	eb 34                	jmp    801ab8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801a84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a8a:	01 d0                	add    %edx,%eax
  801a8c:	8a 00                	mov    (%eax),%al
  801a8e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a94:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a97:	01 c2                	add    %eax,%edx
  801a99:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a9f:	01 c8                	add    %ecx,%eax
  801aa1:	8a 00                	mov    (%eax),%al
  801aa3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801aa5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aab:	01 c2                	add    %eax,%edx
  801aad:	8a 45 eb             	mov    -0x15(%ebp),%al
  801ab0:	88 02                	mov    %al,(%edx)
		start++ ;
  801ab2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801ab5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801abb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801abe:	7c c4                	jl     801a84 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801ac0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac6:	01 d0                	add    %edx,%eax
  801ac8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801acb:	90                   	nop
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
  801ad1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801ad4:	ff 75 08             	pushl  0x8(%ebp)
  801ad7:	e8 54 fa ff ff       	call   801530 <strlen>
  801adc:	83 c4 04             	add    $0x4,%esp
  801adf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801ae2:	ff 75 0c             	pushl  0xc(%ebp)
  801ae5:	e8 46 fa ff ff       	call   801530 <strlen>
  801aea:	83 c4 04             	add    $0x4,%esp
  801aed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801af0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801af7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801afe:	eb 17                	jmp    801b17 <strcconcat+0x49>
		final[s] = str1[s] ;
  801b00:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b03:	8b 45 10             	mov    0x10(%ebp),%eax
  801b06:	01 c2                	add    %eax,%edx
  801b08:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	01 c8                	add    %ecx,%eax
  801b10:	8a 00                	mov    (%eax),%al
  801b12:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b14:	ff 45 fc             	incl   -0x4(%ebp)
  801b17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b1a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b1d:	7c e1                	jl     801b00 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b1f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b26:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801b2d:	eb 1f                	jmp    801b4e <strcconcat+0x80>
		final[s++] = str2[i] ;
  801b2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b32:	8d 50 01             	lea    0x1(%eax),%edx
  801b35:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801b38:	89 c2                	mov    %eax,%edx
  801b3a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b3d:	01 c2                	add    %eax,%edx
  801b3f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801b42:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b45:	01 c8                	add    %ecx,%eax
  801b47:	8a 00                	mov    (%eax),%al
  801b49:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801b4b:	ff 45 f8             	incl   -0x8(%ebp)
  801b4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b51:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b54:	7c d9                	jl     801b2f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801b56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b59:	8b 45 10             	mov    0x10(%ebp),%eax
  801b5c:	01 d0                	add    %edx,%eax
  801b5e:	c6 00 00             	movb   $0x0,(%eax)
}
  801b61:	90                   	nop
  801b62:	c9                   	leave  
  801b63:	c3                   	ret    

00801b64 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801b64:	55                   	push   %ebp
  801b65:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801b67:	8b 45 14             	mov    0x14(%ebp),%eax
  801b6a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801b70:	8b 45 14             	mov    0x14(%ebp),%eax
  801b73:	8b 00                	mov    (%eax),%eax
  801b75:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b7c:	8b 45 10             	mov    0x10(%ebp),%eax
  801b7f:	01 d0                	add    %edx,%eax
  801b81:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b87:	eb 0c                	jmp    801b95 <strsplit+0x31>
			*string++ = 0;
  801b89:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8c:	8d 50 01             	lea    0x1(%eax),%edx
  801b8f:	89 55 08             	mov    %edx,0x8(%ebp)
  801b92:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b95:	8b 45 08             	mov    0x8(%ebp),%eax
  801b98:	8a 00                	mov    (%eax),%al
  801b9a:	84 c0                	test   %al,%al
  801b9c:	74 18                	je     801bb6 <strsplit+0x52>
  801b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba1:	8a 00                	mov    (%eax),%al
  801ba3:	0f be c0             	movsbl %al,%eax
  801ba6:	50                   	push   %eax
  801ba7:	ff 75 0c             	pushl  0xc(%ebp)
  801baa:	e8 13 fb ff ff       	call   8016c2 <strchr>
  801baf:	83 c4 08             	add    $0x8,%esp
  801bb2:	85 c0                	test   %eax,%eax
  801bb4:	75 d3                	jne    801b89 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb9:	8a 00                	mov    (%eax),%al
  801bbb:	84 c0                	test   %al,%al
  801bbd:	74 5a                	je     801c19 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801bbf:	8b 45 14             	mov    0x14(%ebp),%eax
  801bc2:	8b 00                	mov    (%eax),%eax
  801bc4:	83 f8 0f             	cmp    $0xf,%eax
  801bc7:	75 07                	jne    801bd0 <strsplit+0x6c>
		{
			return 0;
  801bc9:	b8 00 00 00 00       	mov    $0x0,%eax
  801bce:	eb 66                	jmp    801c36 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801bd0:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd3:	8b 00                	mov    (%eax),%eax
  801bd5:	8d 48 01             	lea    0x1(%eax),%ecx
  801bd8:	8b 55 14             	mov    0x14(%ebp),%edx
  801bdb:	89 0a                	mov    %ecx,(%edx)
  801bdd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801be4:	8b 45 10             	mov    0x10(%ebp),%eax
  801be7:	01 c2                	add    %eax,%edx
  801be9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bec:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801bee:	eb 03                	jmp    801bf3 <strsplit+0x8f>
			string++;
  801bf0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	8a 00                	mov    (%eax),%al
  801bf8:	84 c0                	test   %al,%al
  801bfa:	74 8b                	je     801b87 <strsplit+0x23>
  801bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bff:	8a 00                	mov    (%eax),%al
  801c01:	0f be c0             	movsbl %al,%eax
  801c04:	50                   	push   %eax
  801c05:	ff 75 0c             	pushl  0xc(%ebp)
  801c08:	e8 b5 fa ff ff       	call   8016c2 <strchr>
  801c0d:	83 c4 08             	add    $0x8,%esp
  801c10:	85 c0                	test   %eax,%eax
  801c12:	74 dc                	je     801bf0 <strsplit+0x8c>
			string++;
	}
  801c14:	e9 6e ff ff ff       	jmp    801b87 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c19:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c1a:	8b 45 14             	mov    0x14(%ebp),%eax
  801c1d:	8b 00                	mov    (%eax),%eax
  801c1f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c26:	8b 45 10             	mov    0x10(%ebp),%eax
  801c29:	01 d0                	add    %edx,%eax
  801c2b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801c31:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c36:	c9                   	leave  
  801c37:	c3                   	ret    

00801c38 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c38:	55                   	push   %ebp
  801c39:	89 e5                	mov    %esp,%ebp
  801c3b:	83 ec 18             	sub    $0x18,%esp
  801c3e:	8b 45 10             	mov    0x10(%ebp),%eax
  801c41:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801c44:	83 ec 04             	sub    $0x4,%esp
  801c47:	68 90 2d 80 00       	push   $0x802d90
  801c4c:	6a 17                	push   $0x17
  801c4e:	68 af 2d 80 00       	push   $0x802daf
  801c53:	e8 a2 ef ff ff       	call   800bfa <_panic>

00801c58 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
  801c5b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801c5e:	83 ec 04             	sub    $0x4,%esp
  801c61:	68 bb 2d 80 00       	push   $0x802dbb
  801c66:	6a 2f                	push   $0x2f
  801c68:	68 af 2d 80 00       	push   $0x802daf
  801c6d:	e8 88 ef ff ff       	call   800bfa <_panic>

00801c72 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
  801c75:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801c78:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801c7f:	8b 55 08             	mov    0x8(%ebp),%edx
  801c82:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c85:	01 d0                	add    %edx,%eax
  801c87:	48                   	dec    %eax
  801c88:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c8e:	ba 00 00 00 00       	mov    $0x0,%edx
  801c93:	f7 75 ec             	divl   -0x14(%ebp)
  801c96:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c99:	29 d0                	sub    %edx,%eax
  801c9b:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca1:	c1 e8 0c             	shr    $0xc,%eax
  801ca4:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801ca7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801cae:	e9 c8 00 00 00       	jmp    801d7b <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801cb3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801cba:	eb 27                	jmp    801ce3 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801cbc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cc2:	01 c2                	add    %eax,%edx
  801cc4:	89 d0                	mov    %edx,%eax
  801cc6:	01 c0                	add    %eax,%eax
  801cc8:	01 d0                	add    %edx,%eax
  801cca:	c1 e0 02             	shl    $0x2,%eax
  801ccd:	05 48 30 80 00       	add    $0x803048,%eax
  801cd2:	8b 00                	mov    (%eax),%eax
  801cd4:	85 c0                	test   %eax,%eax
  801cd6:	74 08                	je     801ce0 <malloc+0x6e>
            	i += j;
  801cd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cdb:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801cde:	eb 0b                	jmp    801ceb <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801ce0:	ff 45 f0             	incl   -0x10(%ebp)
  801ce3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ce6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ce9:	72 d1                	jb     801cbc <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801ceb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cee:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cf1:	0f 85 81 00 00 00    	jne    801d78 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801cf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cfa:	05 00 00 08 00       	add    $0x80000,%eax
  801cff:	c1 e0 0c             	shl    $0xc,%eax
  801d02:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801d05:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d0c:	eb 1f                	jmp    801d2d <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801d0e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d14:	01 c2                	add    %eax,%edx
  801d16:	89 d0                	mov    %edx,%eax
  801d18:	01 c0                	add    %eax,%eax
  801d1a:	01 d0                	add    %edx,%eax
  801d1c:	c1 e0 02             	shl    $0x2,%eax
  801d1f:	05 48 30 80 00       	add    $0x803048,%eax
  801d24:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801d2a:	ff 45 f0             	incl   -0x10(%ebp)
  801d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d30:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d33:	72 d9                	jb     801d0e <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801d35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d38:	89 d0                	mov    %edx,%eax
  801d3a:	01 c0                	add    %eax,%eax
  801d3c:	01 d0                	add    %edx,%eax
  801d3e:	c1 e0 02             	shl    $0x2,%eax
  801d41:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801d47:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d4a:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801d4c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801d4f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801d52:	89 c8                	mov    %ecx,%eax
  801d54:	01 c0                	add    %eax,%eax
  801d56:	01 c8                	add    %ecx,%eax
  801d58:	c1 e0 02             	shl    $0x2,%eax
  801d5b:	05 44 30 80 00       	add    $0x803044,%eax
  801d60:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801d62:	83 ec 08             	sub    $0x8,%esp
  801d65:	ff 75 08             	pushl  0x8(%ebp)
  801d68:	ff 75 e0             	pushl  -0x20(%ebp)
  801d6b:	e8 2b 03 00 00       	call   80209b <sys_allocateMem>
  801d70:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801d73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d76:	eb 19                	jmp    801d91 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801d78:	ff 45 f4             	incl   -0xc(%ebp)
  801d7b:	a1 04 30 80 00       	mov    0x803004,%eax
  801d80:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801d83:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801d86:	0f 83 27 ff ff ff    	jae    801cb3 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801d8c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d91:	c9                   	leave  
  801d92:	c3                   	ret    

00801d93 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
  801d96:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801d99:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801d9d:	0f 84 e5 00 00 00    	je     801e88 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801da3:	8b 45 08             	mov    0x8(%ebp),%eax
  801da6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801da9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dac:	05 00 00 00 80       	add    $0x80000000,%eax
  801db1:	c1 e8 0c             	shr    $0xc,%eax
  801db4:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801db7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801dba:	89 d0                	mov    %edx,%eax
  801dbc:	01 c0                	add    %eax,%eax
  801dbe:	01 d0                	add    %edx,%eax
  801dc0:	c1 e0 02             	shl    $0x2,%eax
  801dc3:	05 40 30 80 00       	add    $0x803040,%eax
  801dc8:	8b 00                	mov    (%eax),%eax
  801dca:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dcd:	0f 85 b8 00 00 00    	jne    801e8b <free+0xf8>
  801dd3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801dd6:	89 d0                	mov    %edx,%eax
  801dd8:	01 c0                	add    %eax,%eax
  801dda:	01 d0                	add    %edx,%eax
  801ddc:	c1 e0 02             	shl    $0x2,%eax
  801ddf:	05 48 30 80 00       	add    $0x803048,%eax
  801de4:	8b 00                	mov    (%eax),%eax
  801de6:	85 c0                	test   %eax,%eax
  801de8:	0f 84 9d 00 00 00    	je     801e8b <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801dee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801df1:	89 d0                	mov    %edx,%eax
  801df3:	01 c0                	add    %eax,%eax
  801df5:	01 d0                	add    %edx,%eax
  801df7:	c1 e0 02             	shl    $0x2,%eax
  801dfa:	05 44 30 80 00       	add    $0x803044,%eax
  801dff:	8b 00                	mov    (%eax),%eax
  801e01:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801e04:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e07:	c1 e0 0c             	shl    $0xc,%eax
  801e0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801e0d:	83 ec 08             	sub    $0x8,%esp
  801e10:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e13:	ff 75 f0             	pushl  -0x10(%ebp)
  801e16:	e8 64 02 00 00       	call   80207f <sys_freeMem>
  801e1b:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801e1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801e25:	eb 57                	jmp    801e7e <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801e27:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e2d:	01 c2                	add    %eax,%edx
  801e2f:	89 d0                	mov    %edx,%eax
  801e31:	01 c0                	add    %eax,%eax
  801e33:	01 d0                	add    %edx,%eax
  801e35:	c1 e0 02             	shl    $0x2,%eax
  801e38:	05 48 30 80 00       	add    $0x803048,%eax
  801e3d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801e43:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e49:	01 c2                	add    %eax,%edx
  801e4b:	89 d0                	mov    %edx,%eax
  801e4d:	01 c0                	add    %eax,%eax
  801e4f:	01 d0                	add    %edx,%eax
  801e51:	c1 e0 02             	shl    $0x2,%eax
  801e54:	05 40 30 80 00       	add    $0x803040,%eax
  801e59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801e5f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e65:	01 c2                	add    %eax,%edx
  801e67:	89 d0                	mov    %edx,%eax
  801e69:	01 c0                	add    %eax,%eax
  801e6b:	01 d0                	add    %edx,%eax
  801e6d:	c1 e0 02             	shl    $0x2,%eax
  801e70:	05 44 30 80 00       	add    $0x803044,%eax
  801e75:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801e7b:	ff 45 f4             	incl   -0xc(%ebp)
  801e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e81:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801e84:	7c a1                	jl     801e27 <free+0x94>
  801e86:	eb 04                	jmp    801e8c <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801e88:	90                   	nop
  801e89:	eb 01                	jmp    801e8c <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801e8b:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801e8c:	c9                   	leave  
  801e8d:	c3                   	ret    

00801e8e <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801e8e:	55                   	push   %ebp
  801e8f:	89 e5                	mov    %esp,%ebp
  801e91:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801e94:	83 ec 04             	sub    $0x4,%esp
  801e97:	68 d8 2d 80 00       	push   $0x802dd8
  801e9c:	68 ae 00 00 00       	push   $0xae
  801ea1:	68 af 2d 80 00       	push   $0x802daf
  801ea6:	e8 4f ed ff ff       	call   800bfa <_panic>

00801eab <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801eb1:	83 ec 04             	sub    $0x4,%esp
  801eb4:	68 f8 2d 80 00       	push   $0x802df8
  801eb9:	68 ca 00 00 00       	push   $0xca
  801ebe:	68 af 2d 80 00       	push   $0x802daf
  801ec3:	e8 32 ed ff ff       	call   800bfa <_panic>

00801ec8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
  801ecb:	57                   	push   %edi
  801ecc:	56                   	push   %esi
  801ecd:	53                   	push   %ebx
  801ece:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eda:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801edd:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ee0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ee3:	cd 30                	int    $0x30
  801ee5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ee8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801eeb:	83 c4 10             	add    $0x10,%esp
  801eee:	5b                   	pop    %ebx
  801eef:	5e                   	pop    %esi
  801ef0:	5f                   	pop    %edi
  801ef1:	5d                   	pop    %ebp
  801ef2:	c3                   	ret    

00801ef3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ef3:	55                   	push   %ebp
  801ef4:	89 e5                	mov    %esp,%ebp
  801ef6:	83 ec 04             	sub    $0x4,%esp
  801ef9:	8b 45 10             	mov    0x10(%ebp),%eax
  801efc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801eff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f03:	8b 45 08             	mov    0x8(%ebp),%eax
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	52                   	push   %edx
  801f0b:	ff 75 0c             	pushl  0xc(%ebp)
  801f0e:	50                   	push   %eax
  801f0f:	6a 00                	push   $0x0
  801f11:	e8 b2 ff ff ff       	call   801ec8 <syscall>
  801f16:	83 c4 18             	add    $0x18,%esp
}
  801f19:	90                   	nop
  801f1a:	c9                   	leave  
  801f1b:	c3                   	ret    

00801f1c <sys_cgetc>:

int
sys_cgetc(void)
{
  801f1c:	55                   	push   %ebp
  801f1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 01                	push   $0x1
  801f2b:	e8 98 ff ff ff       	call   801ec8 <syscall>
  801f30:	83 c4 18             	add    $0x18,%esp
}
  801f33:	c9                   	leave  
  801f34:	c3                   	ret    

00801f35 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801f35:	55                   	push   %ebp
  801f36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801f38:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	50                   	push   %eax
  801f44:	6a 05                	push   $0x5
  801f46:	e8 7d ff ff ff       	call   801ec8 <syscall>
  801f4b:	83 c4 18             	add    $0x18,%esp
}
  801f4e:	c9                   	leave  
  801f4f:	c3                   	ret    

00801f50 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f50:	55                   	push   %ebp
  801f51:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 02                	push   $0x2
  801f5f:	e8 64 ff ff ff       	call   801ec8 <syscall>
  801f64:	83 c4 18             	add    $0x18,%esp
}
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 03                	push   $0x3
  801f78:	e8 4b ff ff ff       	call   801ec8 <syscall>
  801f7d:	83 c4 18             	add    $0x18,%esp
}
  801f80:	c9                   	leave  
  801f81:	c3                   	ret    

00801f82 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 04                	push   $0x4
  801f91:	e8 32 ff ff ff       	call   801ec8 <syscall>
  801f96:	83 c4 18             	add    $0x18,%esp
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <sys_env_exit>:


void sys_env_exit(void)
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 06                	push   $0x6
  801faa:	e8 19 ff ff ff       	call   801ec8 <syscall>
  801faf:	83 c4 18             	add    $0x18,%esp
}
  801fb2:	90                   	nop
  801fb3:	c9                   	leave  
  801fb4:	c3                   	ret    

00801fb5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801fb5:	55                   	push   %ebp
  801fb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801fb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	52                   	push   %edx
  801fc5:	50                   	push   %eax
  801fc6:	6a 07                	push   $0x7
  801fc8:	e8 fb fe ff ff       	call   801ec8 <syscall>
  801fcd:	83 c4 18             	add    $0x18,%esp
}
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
  801fd5:	56                   	push   %esi
  801fd6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801fd7:	8b 75 18             	mov    0x18(%ebp),%esi
  801fda:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801fdd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fe0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe6:	56                   	push   %esi
  801fe7:	53                   	push   %ebx
  801fe8:	51                   	push   %ecx
  801fe9:	52                   	push   %edx
  801fea:	50                   	push   %eax
  801feb:	6a 08                	push   $0x8
  801fed:	e8 d6 fe ff ff       	call   801ec8 <syscall>
  801ff2:	83 c4 18             	add    $0x18,%esp
}
  801ff5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ff8:	5b                   	pop    %ebx
  801ff9:	5e                   	pop    %esi
  801ffa:	5d                   	pop    %ebp
  801ffb:	c3                   	ret    

00801ffc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ffc:	55                   	push   %ebp
  801ffd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801fff:	8b 55 0c             	mov    0xc(%ebp),%edx
  802002:	8b 45 08             	mov    0x8(%ebp),%eax
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	52                   	push   %edx
  80200c:	50                   	push   %eax
  80200d:	6a 09                	push   $0x9
  80200f:	e8 b4 fe ff ff       	call   801ec8 <syscall>
  802014:	83 c4 18             	add    $0x18,%esp
}
  802017:	c9                   	leave  
  802018:	c3                   	ret    

00802019 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	ff 75 0c             	pushl  0xc(%ebp)
  802025:	ff 75 08             	pushl  0x8(%ebp)
  802028:	6a 0a                	push   $0xa
  80202a:	e8 99 fe ff ff       	call   801ec8 <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
}
  802032:	c9                   	leave  
  802033:	c3                   	ret    

00802034 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802034:	55                   	push   %ebp
  802035:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 0b                	push   $0xb
  802043:	e8 80 fe ff ff       	call   801ec8 <syscall>
  802048:	83 c4 18             	add    $0x18,%esp
}
  80204b:	c9                   	leave  
  80204c:	c3                   	ret    

0080204d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80204d:	55                   	push   %ebp
  80204e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 0c                	push   $0xc
  80205c:	e8 67 fe ff ff       	call   801ec8 <syscall>
  802061:	83 c4 18             	add    $0x18,%esp
}
  802064:	c9                   	leave  
  802065:	c3                   	ret    

00802066 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802066:	55                   	push   %ebp
  802067:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 0d                	push   $0xd
  802075:	e8 4e fe ff ff       	call   801ec8 <syscall>
  80207a:	83 c4 18             	add    $0x18,%esp
}
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	ff 75 0c             	pushl  0xc(%ebp)
  80208b:	ff 75 08             	pushl  0x8(%ebp)
  80208e:	6a 11                	push   $0x11
  802090:	e8 33 fe ff ff       	call   801ec8 <syscall>
  802095:	83 c4 18             	add    $0x18,%esp
	return;
  802098:	90                   	nop
}
  802099:	c9                   	leave  
  80209a:	c3                   	ret    

0080209b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80209b:	55                   	push   %ebp
  80209c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	ff 75 0c             	pushl  0xc(%ebp)
  8020a7:	ff 75 08             	pushl  0x8(%ebp)
  8020aa:	6a 12                	push   $0x12
  8020ac:	e8 17 fe ff ff       	call   801ec8 <syscall>
  8020b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b4:	90                   	nop
}
  8020b5:	c9                   	leave  
  8020b6:	c3                   	ret    

008020b7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8020b7:	55                   	push   %ebp
  8020b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 0e                	push   $0xe
  8020c6:	e8 fd fd ff ff       	call   801ec8 <syscall>
  8020cb:	83 c4 18             	add    $0x18,%esp
}
  8020ce:	c9                   	leave  
  8020cf:	c3                   	ret    

008020d0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8020d0:	55                   	push   %ebp
  8020d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	ff 75 08             	pushl  0x8(%ebp)
  8020de:	6a 0f                	push   $0xf
  8020e0:	e8 e3 fd ff ff       	call   801ec8 <syscall>
  8020e5:	83 c4 18             	add    $0x18,%esp
}
  8020e8:	c9                   	leave  
  8020e9:	c3                   	ret    

008020ea <sys_scarce_memory>:

void sys_scarce_memory()
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 10                	push   $0x10
  8020f9:	e8 ca fd ff ff       	call   801ec8 <syscall>
  8020fe:	83 c4 18             	add    $0x18,%esp
}
  802101:	90                   	nop
  802102:	c9                   	leave  
  802103:	c3                   	ret    

00802104 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802104:	55                   	push   %ebp
  802105:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	6a 00                	push   $0x0
  80210f:	6a 00                	push   $0x0
  802111:	6a 14                	push   $0x14
  802113:	e8 b0 fd ff ff       	call   801ec8 <syscall>
  802118:	83 c4 18             	add    $0x18,%esp
}
  80211b:	90                   	nop
  80211c:	c9                   	leave  
  80211d:	c3                   	ret    

0080211e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80211e:	55                   	push   %ebp
  80211f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	6a 15                	push   $0x15
  80212d:	e8 96 fd ff ff       	call   801ec8 <syscall>
  802132:	83 c4 18             	add    $0x18,%esp
}
  802135:	90                   	nop
  802136:	c9                   	leave  
  802137:	c3                   	ret    

00802138 <sys_cputc>:


void
sys_cputc(const char c)
{
  802138:	55                   	push   %ebp
  802139:	89 e5                	mov    %esp,%ebp
  80213b:	83 ec 04             	sub    $0x4,%esp
  80213e:	8b 45 08             	mov    0x8(%ebp),%eax
  802141:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802144:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	50                   	push   %eax
  802151:	6a 16                	push   $0x16
  802153:	e8 70 fd ff ff       	call   801ec8 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
}
  80215b:	90                   	nop
  80215c:	c9                   	leave  
  80215d:	c3                   	ret    

0080215e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 17                	push   $0x17
  80216d:	e8 56 fd ff ff       	call   801ec8 <syscall>
  802172:	83 c4 18             	add    $0x18,%esp
}
  802175:	90                   	nop
  802176:	c9                   	leave  
  802177:	c3                   	ret    

00802178 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802178:	55                   	push   %ebp
  802179:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80217b:	8b 45 08             	mov    0x8(%ebp),%eax
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	ff 75 0c             	pushl  0xc(%ebp)
  802187:	50                   	push   %eax
  802188:	6a 18                	push   $0x18
  80218a:	e8 39 fd ff ff       	call   801ec8 <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	c9                   	leave  
  802193:	c3                   	ret    

00802194 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802194:	55                   	push   %ebp
  802195:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802197:	8b 55 0c             	mov    0xc(%ebp),%edx
  80219a:	8b 45 08             	mov    0x8(%ebp),%eax
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	52                   	push   %edx
  8021a4:	50                   	push   %eax
  8021a5:	6a 1b                	push   $0x1b
  8021a7:	e8 1c fd ff ff       	call   801ec8 <syscall>
  8021ac:	83 c4 18             	add    $0x18,%esp
}
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 00                	push   $0x0
  8021be:	6a 00                	push   $0x0
  8021c0:	52                   	push   %edx
  8021c1:	50                   	push   %eax
  8021c2:	6a 19                	push   $0x19
  8021c4:	e8 ff fc ff ff       	call   801ec8 <syscall>
  8021c9:	83 c4 18             	add    $0x18,%esp
}
  8021cc:	90                   	nop
  8021cd:	c9                   	leave  
  8021ce:	c3                   	ret    

008021cf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8021cf:	55                   	push   %ebp
  8021d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	52                   	push   %edx
  8021df:	50                   	push   %eax
  8021e0:	6a 1a                	push   $0x1a
  8021e2:	e8 e1 fc ff ff       	call   801ec8 <syscall>
  8021e7:	83 c4 18             	add    $0x18,%esp
}
  8021ea:	90                   	nop
  8021eb:	c9                   	leave  
  8021ec:	c3                   	ret    

008021ed <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8021ed:	55                   	push   %ebp
  8021ee:	89 e5                	mov    %esp,%ebp
  8021f0:	83 ec 04             	sub    $0x4,%esp
  8021f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8021f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8021f9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8021fc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802200:	8b 45 08             	mov    0x8(%ebp),%eax
  802203:	6a 00                	push   $0x0
  802205:	51                   	push   %ecx
  802206:	52                   	push   %edx
  802207:	ff 75 0c             	pushl  0xc(%ebp)
  80220a:	50                   	push   %eax
  80220b:	6a 1c                	push   $0x1c
  80220d:	e8 b6 fc ff ff       	call   801ec8 <syscall>
  802212:	83 c4 18             	add    $0x18,%esp
}
  802215:	c9                   	leave  
  802216:	c3                   	ret    

00802217 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802217:	55                   	push   %ebp
  802218:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80221a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80221d:	8b 45 08             	mov    0x8(%ebp),%eax
  802220:	6a 00                	push   $0x0
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	52                   	push   %edx
  802227:	50                   	push   %eax
  802228:	6a 1d                	push   $0x1d
  80222a:	e8 99 fc ff ff       	call   801ec8 <syscall>
  80222f:	83 c4 18             	add    $0x18,%esp
}
  802232:	c9                   	leave  
  802233:	c3                   	ret    

00802234 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802237:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80223a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223d:	8b 45 08             	mov    0x8(%ebp),%eax
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	51                   	push   %ecx
  802245:	52                   	push   %edx
  802246:	50                   	push   %eax
  802247:	6a 1e                	push   $0x1e
  802249:	e8 7a fc ff ff       	call   801ec8 <syscall>
  80224e:	83 c4 18             	add    $0x18,%esp
}
  802251:	c9                   	leave  
  802252:	c3                   	ret    

00802253 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802253:	55                   	push   %ebp
  802254:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802256:	8b 55 0c             	mov    0xc(%ebp),%edx
  802259:	8b 45 08             	mov    0x8(%ebp),%eax
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	52                   	push   %edx
  802263:	50                   	push   %eax
  802264:	6a 1f                	push   $0x1f
  802266:	e8 5d fc ff ff       	call   801ec8 <syscall>
  80226b:	83 c4 18             	add    $0x18,%esp
}
  80226e:	c9                   	leave  
  80226f:	c3                   	ret    

00802270 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802270:	55                   	push   %ebp
  802271:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802273:	6a 00                	push   $0x0
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 20                	push   $0x20
  80227f:	e8 44 fc ff ff       	call   801ec8 <syscall>
  802284:	83 c4 18             	add    $0x18,%esp
}
  802287:	c9                   	leave  
  802288:	c3                   	ret    

00802289 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802289:	55                   	push   %ebp
  80228a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  80228c:	8b 45 08             	mov    0x8(%ebp),%eax
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	ff 75 10             	pushl  0x10(%ebp)
  802296:	ff 75 0c             	pushl  0xc(%ebp)
  802299:	50                   	push   %eax
  80229a:	6a 21                	push   $0x21
  80229c:	e8 27 fc ff ff       	call   801ec8 <syscall>
  8022a1:	83 c4 18             	add    $0x18,%esp
}
  8022a4:	c9                   	leave  
  8022a5:	c3                   	ret    

008022a6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8022a6:	55                   	push   %ebp
  8022a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8022a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ac:	6a 00                	push   $0x0
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	50                   	push   %eax
  8022b5:	6a 22                	push   $0x22
  8022b7:	e8 0c fc ff ff       	call   801ec8 <syscall>
  8022bc:	83 c4 18             	add    $0x18,%esp
}
  8022bf:	90                   	nop
  8022c0:	c9                   	leave  
  8022c1:	c3                   	ret    

008022c2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8022c2:	55                   	push   %ebp
  8022c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8022c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 00                	push   $0x0
  8022d0:	50                   	push   %eax
  8022d1:	6a 23                	push   $0x23
  8022d3:	e8 f0 fb ff ff       	call   801ec8 <syscall>
  8022d8:	83 c4 18             	add    $0x18,%esp
}
  8022db:	90                   	nop
  8022dc:	c9                   	leave  
  8022dd:	c3                   	ret    

008022de <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8022de:	55                   	push   %ebp
  8022df:	89 e5                	mov    %esp,%ebp
  8022e1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8022e4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022e7:	8d 50 04             	lea    0x4(%eax),%edx
  8022ea:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022ed:	6a 00                	push   $0x0
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	52                   	push   %edx
  8022f4:	50                   	push   %eax
  8022f5:	6a 24                	push   $0x24
  8022f7:	e8 cc fb ff ff       	call   801ec8 <syscall>
  8022fc:	83 c4 18             	add    $0x18,%esp
	return result;
  8022ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802302:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802305:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802308:	89 01                	mov    %eax,(%ecx)
  80230a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80230d:	8b 45 08             	mov    0x8(%ebp),%eax
  802310:	c9                   	leave  
  802311:	c2 04 00             	ret    $0x4

00802314 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802314:	55                   	push   %ebp
  802315:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802317:	6a 00                	push   $0x0
  802319:	6a 00                	push   $0x0
  80231b:	ff 75 10             	pushl  0x10(%ebp)
  80231e:	ff 75 0c             	pushl  0xc(%ebp)
  802321:	ff 75 08             	pushl  0x8(%ebp)
  802324:	6a 13                	push   $0x13
  802326:	e8 9d fb ff ff       	call   801ec8 <syscall>
  80232b:	83 c4 18             	add    $0x18,%esp
	return ;
  80232e:	90                   	nop
}
  80232f:	c9                   	leave  
  802330:	c3                   	ret    

00802331 <sys_rcr2>:
uint32 sys_rcr2()
{
  802331:	55                   	push   %ebp
  802332:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 00                	push   $0x0
  80233e:	6a 25                	push   $0x25
  802340:	e8 83 fb ff ff       	call   801ec8 <syscall>
  802345:	83 c4 18             	add    $0x18,%esp
}
  802348:	c9                   	leave  
  802349:	c3                   	ret    

0080234a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80234a:	55                   	push   %ebp
  80234b:	89 e5                	mov    %esp,%ebp
  80234d:	83 ec 04             	sub    $0x4,%esp
  802350:	8b 45 08             	mov    0x8(%ebp),%eax
  802353:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802356:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80235a:	6a 00                	push   $0x0
  80235c:	6a 00                	push   $0x0
  80235e:	6a 00                	push   $0x0
  802360:	6a 00                	push   $0x0
  802362:	50                   	push   %eax
  802363:	6a 26                	push   $0x26
  802365:	e8 5e fb ff ff       	call   801ec8 <syscall>
  80236a:	83 c4 18             	add    $0x18,%esp
	return ;
  80236d:	90                   	nop
}
  80236e:	c9                   	leave  
  80236f:	c3                   	ret    

00802370 <rsttst>:
void rsttst()
{
  802370:	55                   	push   %ebp
  802371:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802373:	6a 00                	push   $0x0
  802375:	6a 00                	push   $0x0
  802377:	6a 00                	push   $0x0
  802379:	6a 00                	push   $0x0
  80237b:	6a 00                	push   $0x0
  80237d:	6a 28                	push   $0x28
  80237f:	e8 44 fb ff ff       	call   801ec8 <syscall>
  802384:	83 c4 18             	add    $0x18,%esp
	return ;
  802387:	90                   	nop
}
  802388:	c9                   	leave  
  802389:	c3                   	ret    

0080238a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80238a:	55                   	push   %ebp
  80238b:	89 e5                	mov    %esp,%ebp
  80238d:	83 ec 04             	sub    $0x4,%esp
  802390:	8b 45 14             	mov    0x14(%ebp),%eax
  802393:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802396:	8b 55 18             	mov    0x18(%ebp),%edx
  802399:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80239d:	52                   	push   %edx
  80239e:	50                   	push   %eax
  80239f:	ff 75 10             	pushl  0x10(%ebp)
  8023a2:	ff 75 0c             	pushl  0xc(%ebp)
  8023a5:	ff 75 08             	pushl  0x8(%ebp)
  8023a8:	6a 27                	push   $0x27
  8023aa:	e8 19 fb ff ff       	call   801ec8 <syscall>
  8023af:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b2:	90                   	nop
}
  8023b3:	c9                   	leave  
  8023b4:	c3                   	ret    

008023b5 <chktst>:
void chktst(uint32 n)
{
  8023b5:	55                   	push   %ebp
  8023b6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8023b8:	6a 00                	push   $0x0
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	ff 75 08             	pushl  0x8(%ebp)
  8023c3:	6a 29                	push   $0x29
  8023c5:	e8 fe fa ff ff       	call   801ec8 <syscall>
  8023ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8023cd:	90                   	nop
}
  8023ce:	c9                   	leave  
  8023cf:	c3                   	ret    

008023d0 <inctst>:

void inctst()
{
  8023d0:	55                   	push   %ebp
  8023d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8023d3:	6a 00                	push   $0x0
  8023d5:	6a 00                	push   $0x0
  8023d7:	6a 00                	push   $0x0
  8023d9:	6a 00                	push   $0x0
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 2a                	push   $0x2a
  8023df:	e8 e4 fa ff ff       	call   801ec8 <syscall>
  8023e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8023e7:	90                   	nop
}
  8023e8:	c9                   	leave  
  8023e9:	c3                   	ret    

008023ea <gettst>:
uint32 gettst()
{
  8023ea:	55                   	push   %ebp
  8023eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8023ed:	6a 00                	push   $0x0
  8023ef:	6a 00                	push   $0x0
  8023f1:	6a 00                	push   $0x0
  8023f3:	6a 00                	push   $0x0
  8023f5:	6a 00                	push   $0x0
  8023f7:	6a 2b                	push   $0x2b
  8023f9:	e8 ca fa ff ff       	call   801ec8 <syscall>
  8023fe:	83 c4 18             	add    $0x18,%esp
}
  802401:	c9                   	leave  
  802402:	c3                   	ret    

00802403 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802403:	55                   	push   %ebp
  802404:	89 e5                	mov    %esp,%ebp
  802406:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802409:	6a 00                	push   $0x0
  80240b:	6a 00                	push   $0x0
  80240d:	6a 00                	push   $0x0
  80240f:	6a 00                	push   $0x0
  802411:	6a 00                	push   $0x0
  802413:	6a 2c                	push   $0x2c
  802415:	e8 ae fa ff ff       	call   801ec8 <syscall>
  80241a:	83 c4 18             	add    $0x18,%esp
  80241d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802420:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802424:	75 07                	jne    80242d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802426:	b8 01 00 00 00       	mov    $0x1,%eax
  80242b:	eb 05                	jmp    802432 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80242d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802432:	c9                   	leave  
  802433:	c3                   	ret    

00802434 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802434:	55                   	push   %ebp
  802435:	89 e5                	mov    %esp,%ebp
  802437:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80243a:	6a 00                	push   $0x0
  80243c:	6a 00                	push   $0x0
  80243e:	6a 00                	push   $0x0
  802440:	6a 00                	push   $0x0
  802442:	6a 00                	push   $0x0
  802444:	6a 2c                	push   $0x2c
  802446:	e8 7d fa ff ff       	call   801ec8 <syscall>
  80244b:	83 c4 18             	add    $0x18,%esp
  80244e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802451:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802455:	75 07                	jne    80245e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802457:	b8 01 00 00 00       	mov    $0x1,%eax
  80245c:	eb 05                	jmp    802463 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80245e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802463:	c9                   	leave  
  802464:	c3                   	ret    

00802465 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802465:	55                   	push   %ebp
  802466:	89 e5                	mov    %esp,%ebp
  802468:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80246b:	6a 00                	push   $0x0
  80246d:	6a 00                	push   $0x0
  80246f:	6a 00                	push   $0x0
  802471:	6a 00                	push   $0x0
  802473:	6a 00                	push   $0x0
  802475:	6a 2c                	push   $0x2c
  802477:	e8 4c fa ff ff       	call   801ec8 <syscall>
  80247c:	83 c4 18             	add    $0x18,%esp
  80247f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802482:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802486:	75 07                	jne    80248f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802488:	b8 01 00 00 00       	mov    $0x1,%eax
  80248d:	eb 05                	jmp    802494 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80248f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802494:	c9                   	leave  
  802495:	c3                   	ret    

00802496 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802496:	55                   	push   %ebp
  802497:	89 e5                	mov    %esp,%ebp
  802499:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80249c:	6a 00                	push   $0x0
  80249e:	6a 00                	push   $0x0
  8024a0:	6a 00                	push   $0x0
  8024a2:	6a 00                	push   $0x0
  8024a4:	6a 00                	push   $0x0
  8024a6:	6a 2c                	push   $0x2c
  8024a8:	e8 1b fa ff ff       	call   801ec8 <syscall>
  8024ad:	83 c4 18             	add    $0x18,%esp
  8024b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8024b3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8024b7:	75 07                	jne    8024c0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8024b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8024be:	eb 05                	jmp    8024c5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8024c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024c5:	c9                   	leave  
  8024c6:	c3                   	ret    

008024c7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8024c7:	55                   	push   %ebp
  8024c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8024ca:	6a 00                	push   $0x0
  8024cc:	6a 00                	push   $0x0
  8024ce:	6a 00                	push   $0x0
  8024d0:	6a 00                	push   $0x0
  8024d2:	ff 75 08             	pushl  0x8(%ebp)
  8024d5:	6a 2d                	push   $0x2d
  8024d7:	e8 ec f9 ff ff       	call   801ec8 <syscall>
  8024dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8024df:	90                   	nop
}
  8024e0:	c9                   	leave  
  8024e1:	c3                   	ret    
  8024e2:	66 90                	xchg   %ax,%ax

008024e4 <__udivdi3>:
  8024e4:	55                   	push   %ebp
  8024e5:	57                   	push   %edi
  8024e6:	56                   	push   %esi
  8024e7:	53                   	push   %ebx
  8024e8:	83 ec 1c             	sub    $0x1c,%esp
  8024eb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024ef:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024f3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024f7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8024fb:	89 ca                	mov    %ecx,%edx
  8024fd:	89 f8                	mov    %edi,%eax
  8024ff:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802503:	85 f6                	test   %esi,%esi
  802505:	75 2d                	jne    802534 <__udivdi3+0x50>
  802507:	39 cf                	cmp    %ecx,%edi
  802509:	77 65                	ja     802570 <__udivdi3+0x8c>
  80250b:	89 fd                	mov    %edi,%ebp
  80250d:	85 ff                	test   %edi,%edi
  80250f:	75 0b                	jne    80251c <__udivdi3+0x38>
  802511:	b8 01 00 00 00       	mov    $0x1,%eax
  802516:	31 d2                	xor    %edx,%edx
  802518:	f7 f7                	div    %edi
  80251a:	89 c5                	mov    %eax,%ebp
  80251c:	31 d2                	xor    %edx,%edx
  80251e:	89 c8                	mov    %ecx,%eax
  802520:	f7 f5                	div    %ebp
  802522:	89 c1                	mov    %eax,%ecx
  802524:	89 d8                	mov    %ebx,%eax
  802526:	f7 f5                	div    %ebp
  802528:	89 cf                	mov    %ecx,%edi
  80252a:	89 fa                	mov    %edi,%edx
  80252c:	83 c4 1c             	add    $0x1c,%esp
  80252f:	5b                   	pop    %ebx
  802530:	5e                   	pop    %esi
  802531:	5f                   	pop    %edi
  802532:	5d                   	pop    %ebp
  802533:	c3                   	ret    
  802534:	39 ce                	cmp    %ecx,%esi
  802536:	77 28                	ja     802560 <__udivdi3+0x7c>
  802538:	0f bd fe             	bsr    %esi,%edi
  80253b:	83 f7 1f             	xor    $0x1f,%edi
  80253e:	75 40                	jne    802580 <__udivdi3+0x9c>
  802540:	39 ce                	cmp    %ecx,%esi
  802542:	72 0a                	jb     80254e <__udivdi3+0x6a>
  802544:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802548:	0f 87 9e 00 00 00    	ja     8025ec <__udivdi3+0x108>
  80254e:	b8 01 00 00 00       	mov    $0x1,%eax
  802553:	89 fa                	mov    %edi,%edx
  802555:	83 c4 1c             	add    $0x1c,%esp
  802558:	5b                   	pop    %ebx
  802559:	5e                   	pop    %esi
  80255a:	5f                   	pop    %edi
  80255b:	5d                   	pop    %ebp
  80255c:	c3                   	ret    
  80255d:	8d 76 00             	lea    0x0(%esi),%esi
  802560:	31 ff                	xor    %edi,%edi
  802562:	31 c0                	xor    %eax,%eax
  802564:	89 fa                	mov    %edi,%edx
  802566:	83 c4 1c             	add    $0x1c,%esp
  802569:	5b                   	pop    %ebx
  80256a:	5e                   	pop    %esi
  80256b:	5f                   	pop    %edi
  80256c:	5d                   	pop    %ebp
  80256d:	c3                   	ret    
  80256e:	66 90                	xchg   %ax,%ax
  802570:	89 d8                	mov    %ebx,%eax
  802572:	f7 f7                	div    %edi
  802574:	31 ff                	xor    %edi,%edi
  802576:	89 fa                	mov    %edi,%edx
  802578:	83 c4 1c             	add    $0x1c,%esp
  80257b:	5b                   	pop    %ebx
  80257c:	5e                   	pop    %esi
  80257d:	5f                   	pop    %edi
  80257e:	5d                   	pop    %ebp
  80257f:	c3                   	ret    
  802580:	bd 20 00 00 00       	mov    $0x20,%ebp
  802585:	89 eb                	mov    %ebp,%ebx
  802587:	29 fb                	sub    %edi,%ebx
  802589:	89 f9                	mov    %edi,%ecx
  80258b:	d3 e6                	shl    %cl,%esi
  80258d:	89 c5                	mov    %eax,%ebp
  80258f:	88 d9                	mov    %bl,%cl
  802591:	d3 ed                	shr    %cl,%ebp
  802593:	89 e9                	mov    %ebp,%ecx
  802595:	09 f1                	or     %esi,%ecx
  802597:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80259b:	89 f9                	mov    %edi,%ecx
  80259d:	d3 e0                	shl    %cl,%eax
  80259f:	89 c5                	mov    %eax,%ebp
  8025a1:	89 d6                	mov    %edx,%esi
  8025a3:	88 d9                	mov    %bl,%cl
  8025a5:	d3 ee                	shr    %cl,%esi
  8025a7:	89 f9                	mov    %edi,%ecx
  8025a9:	d3 e2                	shl    %cl,%edx
  8025ab:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025af:	88 d9                	mov    %bl,%cl
  8025b1:	d3 e8                	shr    %cl,%eax
  8025b3:	09 c2                	or     %eax,%edx
  8025b5:	89 d0                	mov    %edx,%eax
  8025b7:	89 f2                	mov    %esi,%edx
  8025b9:	f7 74 24 0c          	divl   0xc(%esp)
  8025bd:	89 d6                	mov    %edx,%esi
  8025bf:	89 c3                	mov    %eax,%ebx
  8025c1:	f7 e5                	mul    %ebp
  8025c3:	39 d6                	cmp    %edx,%esi
  8025c5:	72 19                	jb     8025e0 <__udivdi3+0xfc>
  8025c7:	74 0b                	je     8025d4 <__udivdi3+0xf0>
  8025c9:	89 d8                	mov    %ebx,%eax
  8025cb:	31 ff                	xor    %edi,%edi
  8025cd:	e9 58 ff ff ff       	jmp    80252a <__udivdi3+0x46>
  8025d2:	66 90                	xchg   %ax,%ax
  8025d4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025d8:	89 f9                	mov    %edi,%ecx
  8025da:	d3 e2                	shl    %cl,%edx
  8025dc:	39 c2                	cmp    %eax,%edx
  8025de:	73 e9                	jae    8025c9 <__udivdi3+0xe5>
  8025e0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025e3:	31 ff                	xor    %edi,%edi
  8025e5:	e9 40 ff ff ff       	jmp    80252a <__udivdi3+0x46>
  8025ea:	66 90                	xchg   %ax,%ax
  8025ec:	31 c0                	xor    %eax,%eax
  8025ee:	e9 37 ff ff ff       	jmp    80252a <__udivdi3+0x46>
  8025f3:	90                   	nop

008025f4 <__umoddi3>:
  8025f4:	55                   	push   %ebp
  8025f5:	57                   	push   %edi
  8025f6:	56                   	push   %esi
  8025f7:	53                   	push   %ebx
  8025f8:	83 ec 1c             	sub    $0x1c,%esp
  8025fb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8025ff:	8b 74 24 34          	mov    0x34(%esp),%esi
  802603:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802607:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80260b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80260f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802613:	89 f3                	mov    %esi,%ebx
  802615:	89 fa                	mov    %edi,%edx
  802617:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80261b:	89 34 24             	mov    %esi,(%esp)
  80261e:	85 c0                	test   %eax,%eax
  802620:	75 1a                	jne    80263c <__umoddi3+0x48>
  802622:	39 f7                	cmp    %esi,%edi
  802624:	0f 86 a2 00 00 00    	jbe    8026cc <__umoddi3+0xd8>
  80262a:	89 c8                	mov    %ecx,%eax
  80262c:	89 f2                	mov    %esi,%edx
  80262e:	f7 f7                	div    %edi
  802630:	89 d0                	mov    %edx,%eax
  802632:	31 d2                	xor    %edx,%edx
  802634:	83 c4 1c             	add    $0x1c,%esp
  802637:	5b                   	pop    %ebx
  802638:	5e                   	pop    %esi
  802639:	5f                   	pop    %edi
  80263a:	5d                   	pop    %ebp
  80263b:	c3                   	ret    
  80263c:	39 f0                	cmp    %esi,%eax
  80263e:	0f 87 ac 00 00 00    	ja     8026f0 <__umoddi3+0xfc>
  802644:	0f bd e8             	bsr    %eax,%ebp
  802647:	83 f5 1f             	xor    $0x1f,%ebp
  80264a:	0f 84 ac 00 00 00    	je     8026fc <__umoddi3+0x108>
  802650:	bf 20 00 00 00       	mov    $0x20,%edi
  802655:	29 ef                	sub    %ebp,%edi
  802657:	89 fe                	mov    %edi,%esi
  802659:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80265d:	89 e9                	mov    %ebp,%ecx
  80265f:	d3 e0                	shl    %cl,%eax
  802661:	89 d7                	mov    %edx,%edi
  802663:	89 f1                	mov    %esi,%ecx
  802665:	d3 ef                	shr    %cl,%edi
  802667:	09 c7                	or     %eax,%edi
  802669:	89 e9                	mov    %ebp,%ecx
  80266b:	d3 e2                	shl    %cl,%edx
  80266d:	89 14 24             	mov    %edx,(%esp)
  802670:	89 d8                	mov    %ebx,%eax
  802672:	d3 e0                	shl    %cl,%eax
  802674:	89 c2                	mov    %eax,%edx
  802676:	8b 44 24 08          	mov    0x8(%esp),%eax
  80267a:	d3 e0                	shl    %cl,%eax
  80267c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802680:	8b 44 24 08          	mov    0x8(%esp),%eax
  802684:	89 f1                	mov    %esi,%ecx
  802686:	d3 e8                	shr    %cl,%eax
  802688:	09 d0                	or     %edx,%eax
  80268a:	d3 eb                	shr    %cl,%ebx
  80268c:	89 da                	mov    %ebx,%edx
  80268e:	f7 f7                	div    %edi
  802690:	89 d3                	mov    %edx,%ebx
  802692:	f7 24 24             	mull   (%esp)
  802695:	89 c6                	mov    %eax,%esi
  802697:	89 d1                	mov    %edx,%ecx
  802699:	39 d3                	cmp    %edx,%ebx
  80269b:	0f 82 87 00 00 00    	jb     802728 <__umoddi3+0x134>
  8026a1:	0f 84 91 00 00 00    	je     802738 <__umoddi3+0x144>
  8026a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8026ab:	29 f2                	sub    %esi,%edx
  8026ad:	19 cb                	sbb    %ecx,%ebx
  8026af:	89 d8                	mov    %ebx,%eax
  8026b1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8026b5:	d3 e0                	shl    %cl,%eax
  8026b7:	89 e9                	mov    %ebp,%ecx
  8026b9:	d3 ea                	shr    %cl,%edx
  8026bb:	09 d0                	or     %edx,%eax
  8026bd:	89 e9                	mov    %ebp,%ecx
  8026bf:	d3 eb                	shr    %cl,%ebx
  8026c1:	89 da                	mov    %ebx,%edx
  8026c3:	83 c4 1c             	add    $0x1c,%esp
  8026c6:	5b                   	pop    %ebx
  8026c7:	5e                   	pop    %esi
  8026c8:	5f                   	pop    %edi
  8026c9:	5d                   	pop    %ebp
  8026ca:	c3                   	ret    
  8026cb:	90                   	nop
  8026cc:	89 fd                	mov    %edi,%ebp
  8026ce:	85 ff                	test   %edi,%edi
  8026d0:	75 0b                	jne    8026dd <__umoddi3+0xe9>
  8026d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8026d7:	31 d2                	xor    %edx,%edx
  8026d9:	f7 f7                	div    %edi
  8026db:	89 c5                	mov    %eax,%ebp
  8026dd:	89 f0                	mov    %esi,%eax
  8026df:	31 d2                	xor    %edx,%edx
  8026e1:	f7 f5                	div    %ebp
  8026e3:	89 c8                	mov    %ecx,%eax
  8026e5:	f7 f5                	div    %ebp
  8026e7:	89 d0                	mov    %edx,%eax
  8026e9:	e9 44 ff ff ff       	jmp    802632 <__umoddi3+0x3e>
  8026ee:	66 90                	xchg   %ax,%ax
  8026f0:	89 c8                	mov    %ecx,%eax
  8026f2:	89 f2                	mov    %esi,%edx
  8026f4:	83 c4 1c             	add    $0x1c,%esp
  8026f7:	5b                   	pop    %ebx
  8026f8:	5e                   	pop    %esi
  8026f9:	5f                   	pop    %edi
  8026fa:	5d                   	pop    %ebp
  8026fb:	c3                   	ret    
  8026fc:	3b 04 24             	cmp    (%esp),%eax
  8026ff:	72 06                	jb     802707 <__umoddi3+0x113>
  802701:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802705:	77 0f                	ja     802716 <__umoddi3+0x122>
  802707:	89 f2                	mov    %esi,%edx
  802709:	29 f9                	sub    %edi,%ecx
  80270b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80270f:	89 14 24             	mov    %edx,(%esp)
  802712:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802716:	8b 44 24 04          	mov    0x4(%esp),%eax
  80271a:	8b 14 24             	mov    (%esp),%edx
  80271d:	83 c4 1c             	add    $0x1c,%esp
  802720:	5b                   	pop    %ebx
  802721:	5e                   	pop    %esi
  802722:	5f                   	pop    %edi
  802723:	5d                   	pop    %ebp
  802724:	c3                   	ret    
  802725:	8d 76 00             	lea    0x0(%esi),%esi
  802728:	2b 04 24             	sub    (%esp),%eax
  80272b:	19 fa                	sbb    %edi,%edx
  80272d:	89 d1                	mov    %edx,%ecx
  80272f:	89 c6                	mov    %eax,%esi
  802731:	e9 71 ff ff ff       	jmp    8026a7 <__umoddi3+0xb3>
  802736:	66 90                	xchg   %ax,%ax
  802738:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80273c:	72 ea                	jb     802728 <__umoddi3+0x134>
  80273e:	89 d9                	mov    %ebx,%ecx
  802740:	e9 62 ff ff ff       	jmp    8026a7 <__umoddi3+0xb3>
