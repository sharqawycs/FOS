
obj/user/tst_worstfit:     file format elf32-i386


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
  800031:	e8 f3 0b 00 00       	call   800c29 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 40 08 00 00    	sub    $0x840,%esp
	int Mega = 1024*1024;
  800043:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  80004a:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)

	int count = 0;
  800051:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
	int totalNumberOfTests = 11;
  800058:	c7 45 d4 0b 00 00 00 	movl   $0xb,-0x2c(%ebp)

	//Make sure that the heap size is 512 MB
	int numOf2MBsInHeap = (USER_HEAP_MAX - USER_HEAP_START) / (2*Mega);
  80005f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800062:	01 c0                	add    %eax,%eax
  800064:	89 c7                	mov    %eax,%edi
  800066:	b8 00 00 00 20       	mov    $0x20000000,%eax
  80006b:	ba 00 00 00 00       	mov    $0x0,%edx
  800070:	f7 f7                	div    %edi
  800072:	89 45 d0             	mov    %eax,-0x30(%ebp)
	assert(numOf2MBsInHeap == 256);
  800075:	81 7d d0 00 01 00 00 	cmpl   $0x100,-0x30(%ebp)
  80007c:	74 16                	je     800094 <_main+0x5c>
  80007e:	68 80 28 80 00       	push   $0x802880
  800083:	68 97 28 80 00       	push   $0x802897
  800088:	6a 11                	push   $0x11
  80008a:	68 ac 28 80 00       	push   $0x8028ac
  80008f:	e8 97 0c 00 00       	call   800d2b <_panic>




	sys_set_uheap_strategy(UHP_PLACE_WORSTFIT);
  800094:	83 ec 0c             	sub    $0xc,%esp
  800097:	6a 04                	push   $0x4
  800099:	e8 5a 25 00 00       	call   8025f8 <sys_set_uheap_strategy>
  80009e:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  8000a1:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8000a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000ac:	eb 29                	jmp    8000d7 <_main+0x9f>
		{
			if (myEnv->__uptr_pws[i].empty)
  8000ae:	a1 20 40 80 00       	mov    0x804020,%eax
  8000b3:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8000b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8000bc:	89 d0                	mov    %edx,%eax
  8000be:	01 c0                	add    %eax,%eax
  8000c0:	01 d0                	add    %edx,%eax
  8000c2:	c1 e0 02             	shl    $0x2,%eax
  8000c5:	01 c8                	add    %ecx,%eax
  8000c7:	8a 40 04             	mov    0x4(%eax),%al
  8000ca:	84 c0                	test   %al,%al
  8000cc:	74 06                	je     8000d4 <_main+0x9c>
			{
				fullWS = 0;
  8000ce:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  8000d2:	eb 12                	jmp    8000e6 <_main+0xae>
	sys_set_uheap_strategy(UHP_PLACE_WORSTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8000d4:	ff 45 f0             	incl   -0x10(%ebp)
  8000d7:	a1 20 40 80 00       	mov    0x804020,%eax
  8000dc:	8b 50 74             	mov    0x74(%eax),%edx
  8000df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000e2:	39 c2                	cmp    %eax,%edx
  8000e4:	77 c8                	ja     8000ae <_main+0x76>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  8000e6:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  8000ea:	74 14                	je     800100 <_main+0xc8>
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	68 c0 28 80 00       	push   $0x8028c0
  8000f4:	6a 23                	push   $0x23
  8000f6:	68 ac 28 80 00       	push   $0x8028ac
  8000fb:	e8 2b 0c 00 00       	call   800d2b <_panic>
	}

	int freeFrames ;
	int usedDiskPages;

	cprintf("This test has %d tests. A pass message will be displayed after each one.\n", totalNumberOfTests);
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	ff 75 d4             	pushl  -0x2c(%ebp)
  800106:	68 dc 28 80 00       	push   $0x8028dc
  80010b:	e8 cf 0e 00 00       	call   800fdf <cprintf>
  800110:	83 c4 10             	add    $0x10,%esp

	//[0] Make sure there're available places in the WS
	int w = 0 ;
  800113:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int requiredNumOfEmptyWSLocs = 2;
  80011a:	c7 45 cc 02 00 00 00 	movl   $0x2,-0x34(%ebp)
	int numOfEmptyWSLocs = 0;
  800121:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for (w = 0 ; w < myEnv->page_WS_max_size; w++)
  800128:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80012f:	eb 26                	jmp    800157 <_main+0x11f>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
  800131:	a1 20 40 80 00       	mov    0x804020,%eax
  800136:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  80013c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80013f:	89 d0                	mov    %edx,%eax
  800141:	01 c0                	add    %eax,%eax
  800143:	01 d0                	add    %edx,%eax
  800145:	c1 e0 02             	shl    $0x2,%eax
  800148:	01 c8                	add    %ecx,%eax
  80014a:	8a 40 04             	mov    0x4(%eax),%al
  80014d:	3c 01                	cmp    $0x1,%al
  80014f:	75 03                	jne    800154 <_main+0x11c>
			numOfEmptyWSLocs++;
  800151:	ff 45 e8             	incl   -0x18(%ebp)

	//[0] Make sure there're available places in the WS
	int w = 0 ;
	int requiredNumOfEmptyWSLocs = 2;
	int numOfEmptyWSLocs = 0;
	for (w = 0 ; w < myEnv->page_WS_max_size; w++)
  800154:	ff 45 ec             	incl   -0x14(%ebp)
  800157:	a1 20 40 80 00       	mov    0x804020,%eax
  80015c:	8b 50 74             	mov    0x74(%eax),%edx
  80015f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800162:	39 c2                	cmp    %eax,%edx
  800164:	77 cb                	ja     800131 <_main+0xf9>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
			numOfEmptyWSLocs++;
	}
	if (numOfEmptyWSLocs < requiredNumOfEmptyWSLocs)
  800166:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800169:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  80016c:	7d 14                	jge    800182 <_main+0x14a>
		panic("Insufficient number of WS empty locations! please increase the PAGE_WS_MAX_SIZE");
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 28 29 80 00       	push   $0x802928
  800176:	6a 35                	push   $0x35
  800178:	68 ac 28 80 00       	push   $0x8028ac
  80017d:	e8 a9 0b 00 00       	call   800d2b <_panic>

	void* ptr_allocations[512] = {0};
  800182:	8d 95 c0 f7 ff ff    	lea    -0x840(%ebp),%edx
  800188:	b9 00 02 00 00       	mov    $0x200,%ecx
  80018d:	b8 00 00 00 00       	mov    $0x0,%eax
  800192:	89 d7                	mov    %edx,%edi
  800194:	f3 ab                	rep stos %eax,%es:(%edi)
	int i;

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
  800196:	e8 ca 1f 00 00       	call   802165 <sys_calculate_free_frames>
  80019b:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80019e:	e8 45 20 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8001a3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	for(i = 0; i< 256;i++)
  8001a6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8001ad:	eb 20                	jmp    8001cf <_main+0x197>
	{
		ptr_allocations[i] = malloc(2*Mega);
  8001af:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001b2:	01 c0                	add    %eax,%eax
  8001b4:	83 ec 0c             	sub    $0xc,%esp
  8001b7:	50                   	push   %eax
  8001b8:	e8 e6 1b 00 00       	call   801da3 <malloc>
  8001bd:	83 c4 10             	add    $0x10,%esp
  8001c0:	89 c2                	mov    %eax,%edx
  8001c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001c5:	89 94 85 c0 f7 ff ff 	mov    %edx,-0x840(%ebp,%eax,4)
	int i;

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
	usedDiskPages = sys_pf_calculate_allocated_pages();
	for(i = 0; i< 256;i++)
  8001cc:	ff 45 e4             	incl   -0x1c(%ebp)
  8001cf:	81 7d e4 ff 00 00 00 	cmpl   $0xff,-0x1c(%ebp)
  8001d6:	7e d7                	jle    8001af <_main+0x177>
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
  8001d8:	8b 85 c0 f7 ff ff    	mov    -0x840(%ebp),%eax
  8001de:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8001e3:	75 4e                	jne    800233 <_main+0x1fb>
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001e5:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
  8001eb:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8001f0:	75 41                	jne    800233 <_main+0x1fb>
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001f2:	8b 85 e0 f7 ff ff    	mov    -0x820(%ebp),%eax
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001f8:	3d 00 00 00 81       	cmp    $0x81000000,%eax
  8001fd:	75 34                	jne    800233 <_main+0x1fb>
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[100] != 0x8C800000 ||
  8001ff:	8b 85 50 f9 ff ff    	mov    -0x6b0(%ebp),%eax
	}

	// randomly check the addresses of the allocation
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  800205:	3d 00 00 80 8c       	cmp    $0x8c800000,%eax
  80020a:	75 27                	jne    800233 <_main+0x1fb>
			(uint32)ptr_allocations[100] != 0x8C800000 ||
			(uint32)ptr_allocations[150] != 0x92C00000 ||
  80020c:	8b 85 18 fa ff ff    	mov    -0x5e8(%ebp),%eax

	// randomly check the addresses of the allocation
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[100] != 0x8C800000 ||
  800212:	3d 00 00 c0 92       	cmp    $0x92c00000,%eax
  800217:	75 1a                	jne    800233 <_main+0x1fb>
			(uint32)ptr_allocations[150] != 0x92C00000 ||
			(uint32)ptr_allocations[200] != 0x99000000 ||
  800219:	8b 85 e0 fa ff ff    	mov    -0x520(%ebp),%eax
	// randomly check the addresses of the allocation
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[100] != 0x8C800000 ||
			(uint32)ptr_allocations[150] != 0x92C00000 ||
  80021f:	3d 00 00 00 99       	cmp    $0x99000000,%eax
  800224:	75 0d                	jne    800233 <_main+0x1fb>
			(uint32)ptr_allocations[200] != 0x99000000 ||
			(uint32)ptr_allocations[255] != 0x9FE00000)
  800226:	8b 85 bc fb ff ff    	mov    -0x444(%ebp),%eax
	if( (uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[100] != 0x8C800000 ||
			(uint32)ptr_allocations[150] != 0x92C00000 ||
			(uint32)ptr_allocations[200] != 0x99000000 ||
  80022c:	3d 00 00 e0 9f       	cmp    $0x9fe00000,%eax
  800231:	74 14                	je     800247 <_main+0x20f>
			(uint32)ptr_allocations[255] != 0x9FE00000)
		panic("Wrong allocation, Check fitting strategy is working correctly");
  800233:	83 ec 04             	sub    $0x4,%esp
  800236:	68 78 29 80 00       	push   $0x802978
  80023b:	6a 4a                	push   $0x4a
  80023d:	68 ac 28 80 00       	push   $0x8028ac
  800242:	e8 e4 0a 00 00       	call   800d2b <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800247:	e8 9c 1f 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  80024c:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80024f:	89 c2                	mov    %eax,%edx
  800251:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800254:	c1 e0 09             	shl    $0x9,%eax
  800257:	85 c0                	test   %eax,%eax
  800259:	79 05                	jns    800260 <_main+0x228>
  80025b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800260:	c1 f8 0c             	sar    $0xc,%eax
  800263:	39 c2                	cmp    %eax,%edx
  800265:	74 14                	je     80027b <_main+0x243>
  800267:	83 ec 04             	sub    $0x4,%esp
  80026a:	68 b6 29 80 00       	push   $0x8029b6
  80026f:	6a 4c                	push   $0x4c
  800271:	68 ac 28 80 00       	push   $0x8028ac
  800276:	e8 b0 0a 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != (512*Mega)/(1024*PAGE_SIZE) ) panic("Wrong allocation");
  80027b:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  80027e:	e8 e2 1e 00 00       	call   802165 <sys_calculate_free_frames>
  800283:	29 c3                	sub    %eax,%ebx
  800285:	89 da                	mov    %ebx,%edx
  800287:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80028a:	c1 e0 09             	shl    $0x9,%eax
  80028d:	85 c0                	test   %eax,%eax
  80028f:	79 05                	jns    800296 <_main+0x25e>
  800291:	05 ff ff 3f 00       	add    $0x3fffff,%eax
  800296:	c1 f8 16             	sar    $0x16,%eax
  800299:	39 c2                	cmp    %eax,%edx
  80029b:	74 14                	je     8002b1 <_main+0x279>
  80029d:	83 ec 04             	sub    $0x4,%esp
  8002a0:	68 d3 29 80 00       	push   $0x8029d3
  8002a5:	6a 4d                	push   $0x4d
  8002a7:	68 ac 28 80 00       	push   $0x8028ac
  8002ac:	e8 7a 0a 00 00       	call   800d2b <_panic>

	// Make memory holes.
	freeFrames = sys_calculate_free_frames() ;
  8002b1:	e8 af 1e 00 00       	call   802165 <sys_calculate_free_frames>
  8002b6:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8002b9:	e8 2a 1f 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8002be:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	free(ptr_allocations[0]);		// Hole 1 = 2 M
  8002c1:	8b 85 c0 f7 ff ff    	mov    -0x840(%ebp),%eax
  8002c7:	83 ec 0c             	sub    $0xc,%esp
  8002ca:	50                   	push   %eax
  8002cb:	e8 f4 1b 00 00       	call   801ec4 <free>
  8002d0:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[2]);		// Hole 2 = 4 M
  8002d3:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8002d9:	83 ec 0c             	sub    $0xc,%esp
  8002dc:	50                   	push   %eax
  8002dd:	e8 e2 1b 00 00       	call   801ec4 <free>
  8002e2:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[3]);
  8002e5:	8b 85 cc f7 ff ff    	mov    -0x834(%ebp),%eax
  8002eb:	83 ec 0c             	sub    $0xc,%esp
  8002ee:	50                   	push   %eax
  8002ef:	e8 d0 1b 00 00       	call   801ec4 <free>
  8002f4:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[10]);		// Hole 3 = 6 M
  8002f7:	8b 85 e8 f7 ff ff    	mov    -0x818(%ebp),%eax
  8002fd:	83 ec 0c             	sub    $0xc,%esp
  800300:	50                   	push   %eax
  800301:	e8 be 1b 00 00       	call   801ec4 <free>
  800306:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[12]);
  800309:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
  80030f:	83 ec 0c             	sub    $0xc,%esp
  800312:	50                   	push   %eax
  800313:	e8 ac 1b 00 00       	call   801ec4 <free>
  800318:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[11]);
  80031b:	8b 85 ec f7 ff ff    	mov    -0x814(%ebp),%eax
  800321:	83 ec 0c             	sub    $0xc,%esp
  800324:	50                   	push   %eax
  800325:	e8 9a 1b 00 00       	call   801ec4 <free>
  80032a:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[100]);		// Hole 4 = 10 M
  80032d:	8b 85 50 f9 ff ff    	mov    -0x6b0(%ebp),%eax
  800333:	83 ec 0c             	sub    $0xc,%esp
  800336:	50                   	push   %eax
  800337:	e8 88 1b 00 00       	call   801ec4 <free>
  80033c:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[104]);
  80033f:	8b 85 60 f9 ff ff    	mov    -0x6a0(%ebp),%eax
  800345:	83 ec 0c             	sub    $0xc,%esp
  800348:	50                   	push   %eax
  800349:	e8 76 1b 00 00       	call   801ec4 <free>
  80034e:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[103]);
  800351:	8b 85 5c f9 ff ff    	mov    -0x6a4(%ebp),%eax
  800357:	83 ec 0c             	sub    $0xc,%esp
  80035a:	50                   	push   %eax
  80035b:	e8 64 1b 00 00       	call   801ec4 <free>
  800360:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[102]);
  800363:	8b 85 58 f9 ff ff    	mov    -0x6a8(%ebp),%eax
  800369:	83 ec 0c             	sub    $0xc,%esp
  80036c:	50                   	push   %eax
  80036d:	e8 52 1b 00 00       	call   801ec4 <free>
  800372:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[101]);
  800375:	8b 85 54 f9 ff ff    	mov    -0x6ac(%ebp),%eax
  80037b:	83 ec 0c             	sub    $0xc,%esp
  80037e:	50                   	push   %eax
  80037f:	e8 40 1b 00 00       	call   801ec4 <free>
  800384:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[200]);		// Hole 5 = 8 M
  800387:	8b 85 e0 fa ff ff    	mov    -0x520(%ebp),%eax
  80038d:	83 ec 0c             	sub    $0xc,%esp
  800390:	50                   	push   %eax
  800391:	e8 2e 1b 00 00       	call   801ec4 <free>
  800396:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[201]);
  800399:	8b 85 e4 fa ff ff    	mov    -0x51c(%ebp),%eax
  80039f:	83 ec 0c             	sub    $0xc,%esp
  8003a2:	50                   	push   %eax
  8003a3:	e8 1c 1b 00 00       	call   801ec4 <free>
  8003a8:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[202]);
  8003ab:	8b 85 e8 fa ff ff    	mov    -0x518(%ebp),%eax
  8003b1:	83 ec 0c             	sub    $0xc,%esp
  8003b4:	50                   	push   %eax
  8003b5:	e8 0a 1b 00 00       	call   801ec4 <free>
  8003ba:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[203]);
  8003bd:	8b 85 ec fa ff ff    	mov    -0x514(%ebp),%eax
  8003c3:	83 ec 0c             	sub    $0xc,%esp
  8003c6:	50                   	push   %eax
  8003c7:	e8 f8 1a 00 00       	call   801ec4 <free>
  8003cc:	83 c4 10             	add    $0x10,%esp

	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 15*(2*Mega)/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  8003cf:	e8 14 1e 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8003d4:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  8003d7:	89 d1                	mov    %edx,%ecx
  8003d9:	29 c1                	sub    %eax,%ecx
  8003db:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003de:	89 d0                	mov    %edx,%eax
  8003e0:	01 c0                	add    %eax,%eax
  8003e2:	01 d0                	add    %edx,%eax
  8003e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003eb:	01 d0                	add    %edx,%eax
  8003ed:	01 c0                	add    %eax,%eax
  8003ef:	85 c0                	test   %eax,%eax
  8003f1:	79 05                	jns    8003f8 <_main+0x3c0>
  8003f3:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003f8:	c1 f8 0c             	sar    $0xc,%eax
  8003fb:	39 c1                	cmp    %eax,%ecx
  8003fd:	74 14                	je     800413 <_main+0x3db>
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 e4 29 80 00       	push   $0x8029e4
  800407:	6a 63                	push   $0x63
  800409:	68 ac 28 80 00       	push   $0x8028ac
  80040e:	e8 18 09 00 00       	call   800d2b <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  800413:	e8 4d 1d 00 00       	call   802165 <sys_calculate_free_frames>
  800418:	89 c2                	mov    %eax,%edx
  80041a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80041d:	39 c2                	cmp    %eax,%edx
  80041f:	74 14                	je     800435 <_main+0x3fd>
  800421:	83 ec 04             	sub    $0x4,%esp
  800424:	68 20 2a 80 00       	push   $0x802a20
  800429:	6a 64                	push   $0x64
  80042b:	68 ac 28 80 00       	push   $0x8028ac
  800430:	e8 f6 08 00 00       	call   800d2b <_panic>

	// Test worst fit
	//[WORST FIT Case]
	freeFrames = sys_calculate_free_frames() ;
  800435:	e8 2b 1d 00 00       	call   802165 <sys_calculate_free_frames>
  80043a:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80043d:	e8 a6 1d 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800442:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	void* tempAddress = malloc(Mega);		// Use Hole 4 -> Hole 4 = 9 M
  800445:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800448:	83 ec 0c             	sub    $0xc,%esp
  80044b:	50                   	push   %eax
  80044c:	e8 52 19 00 00       	call   801da3 <malloc>
  800451:	83 c4 10             	add    $0x10,%esp
  800454:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x8C800000)
  800457:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80045a:	3d 00 00 80 8c       	cmp    $0x8c800000,%eax
  80045f:	74 14                	je     800475 <_main+0x43d>
		panic("Worst Fit not working correctly");
  800461:	83 ec 04             	sub    $0x4,%esp
  800464:	68 60 2a 80 00       	push   $0x802a60
  800469:	6a 6c                	push   $0x6c
  80046b:	68 ac 28 80 00       	push   $0x8028ac
  800470:	e8 b6 08 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800475:	e8 6e 1d 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  80047a:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80047d:	89 c2                	mov    %eax,%edx
  80047f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800482:	85 c0                	test   %eax,%eax
  800484:	79 05                	jns    80048b <_main+0x453>
  800486:	05 ff 0f 00 00       	add    $0xfff,%eax
  80048b:	c1 f8 0c             	sar    $0xc,%eax
  80048e:	39 c2                	cmp    %eax,%edx
  800490:	74 14                	je     8004a6 <_main+0x46e>
  800492:	83 ec 04             	sub    $0x4,%esp
  800495:	68 b6 29 80 00       	push   $0x8029b6
  80049a:	6a 6d                	push   $0x6d
  80049c:	68 ac 28 80 00       	push   $0x8028ac
  8004a1:	e8 85 08 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8004a6:	e8 ba 1c 00 00       	call   802165 <sys_calculate_free_frames>
  8004ab:	89 c2                	mov    %eax,%edx
  8004ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8004b0:	39 c2                	cmp    %eax,%edx
  8004b2:	74 14                	je     8004c8 <_main+0x490>
  8004b4:	83 ec 04             	sub    $0x4,%esp
  8004b7:	68 d3 29 80 00       	push   $0x8029d3
  8004bc:	6a 6e                	push   $0x6e
  8004be:	68 ac 28 80 00       	push   $0x8028ac
  8004c3:	e8 63 08 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  8004c8:	ff 45 d8             	incl   -0x28(%ebp)
  8004cb:	83 ec 08             	sub    $0x8,%esp
  8004ce:	ff 75 d8             	pushl  -0x28(%ebp)
  8004d1:	68 80 2a 80 00       	push   $0x802a80
  8004d6:	e8 04 0b 00 00       	call   800fdf <cprintf>
  8004db:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 82 1c 00 00       	call   802165 <sys_calculate_free_frames>
  8004e3:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 fd 1c 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8004eb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(4 * Mega);			// Use Hole 4 -> Hole 4 = 5 M
  8004ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004f1:	c1 e0 02             	shl    $0x2,%eax
  8004f4:	83 ec 0c             	sub    $0xc,%esp
  8004f7:	50                   	push   %eax
  8004f8:	e8 a6 18 00 00       	call   801da3 <malloc>
  8004fd:	83 c4 10             	add    $0x10,%esp
  800500:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x8C900000)
  800503:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800506:	3d 00 00 90 8c       	cmp    $0x8c900000,%eax
  80050b:	74 14                	je     800521 <_main+0x4e9>
		panic("Worst Fit not working correctly");
  80050d:	83 ec 04             	sub    $0x4,%esp
  800510:	68 60 2a 80 00       	push   $0x802a60
  800515:	6a 75                	push   $0x75
  800517:	68 ac 28 80 00       	push   $0x8028ac
  80051c:	e8 0a 08 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800521:	e8 c2 1c 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800526:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800529:	89 c2                	mov    %eax,%edx
  80052b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80052e:	c1 e0 02             	shl    $0x2,%eax
  800531:	85 c0                	test   %eax,%eax
  800533:	79 05                	jns    80053a <_main+0x502>
  800535:	05 ff 0f 00 00       	add    $0xfff,%eax
  80053a:	c1 f8 0c             	sar    $0xc,%eax
  80053d:	39 c2                	cmp    %eax,%edx
  80053f:	74 14                	je     800555 <_main+0x51d>
  800541:	83 ec 04             	sub    $0x4,%esp
  800544:	68 b6 29 80 00       	push   $0x8029b6
  800549:	6a 76                	push   $0x76
  80054b:	68 ac 28 80 00       	push   $0x8028ac
  800550:	e8 d6 07 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800555:	e8 0b 1c 00 00       	call   802165 <sys_calculate_free_frames>
  80055a:	89 c2                	mov    %eax,%edx
  80055c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80055f:	39 c2                	cmp    %eax,%edx
  800561:	74 14                	je     800577 <_main+0x53f>
  800563:	83 ec 04             	sub    $0x4,%esp
  800566:	68 d3 29 80 00       	push   $0x8029d3
  80056b:	6a 77                	push   $0x77
  80056d:	68 ac 28 80 00       	push   $0x8028ac
  800572:	e8 b4 07 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800577:	ff 45 d8             	incl   -0x28(%ebp)
  80057a:	83 ec 08             	sub    $0x8,%esp
  80057d:	ff 75 d8             	pushl  -0x28(%ebp)
  800580:	68 80 2a 80 00       	push   $0x802a80
  800585:	e8 55 0a 00 00       	call   800fdf <cprintf>
  80058a:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  80058d:	e8 d3 1b 00 00       	call   802165 <sys_calculate_free_frames>
  800592:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800595:	e8 4e 1c 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  80059a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(6*Mega); 			   // Use Hole 5 -> Hole 5 = 2 M
  80059d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a0:	89 d0                	mov    %edx,%eax
  8005a2:	01 c0                	add    %eax,%eax
  8005a4:	01 d0                	add    %edx,%eax
  8005a6:	01 c0                	add    %eax,%eax
  8005a8:	83 ec 0c             	sub    $0xc,%esp
  8005ab:	50                   	push   %eax
  8005ac:	e8 f2 17 00 00       	call   801da3 <malloc>
  8005b1:	83 c4 10             	add    $0x10,%esp
  8005b4:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x99000000)
  8005b7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8005ba:	3d 00 00 00 99       	cmp    $0x99000000,%eax
  8005bf:	74 14                	je     8005d5 <_main+0x59d>
		panic("Worst Fit not working correctly");
  8005c1:	83 ec 04             	sub    $0x4,%esp
  8005c4:	68 60 2a 80 00       	push   $0x802a60
  8005c9:	6a 7e                	push   $0x7e
  8005cb:	68 ac 28 80 00       	push   $0x8028ac
  8005d0:	e8 56 07 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  6*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  8005d5:	e8 0e 1c 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8005da:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8005dd:	89 c1                	mov    %eax,%ecx
  8005df:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005e2:	89 d0                	mov    %edx,%eax
  8005e4:	01 c0                	add    %eax,%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	01 c0                	add    %eax,%eax
  8005ea:	85 c0                	test   %eax,%eax
  8005ec:	79 05                	jns    8005f3 <_main+0x5bb>
  8005ee:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005f3:	c1 f8 0c             	sar    $0xc,%eax
  8005f6:	39 c1                	cmp    %eax,%ecx
  8005f8:	74 14                	je     80060e <_main+0x5d6>
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	68 b6 29 80 00       	push   $0x8029b6
  800602:	6a 7f                	push   $0x7f
  800604:	68 ac 28 80 00       	push   $0x8028ac
  800609:	e8 1d 07 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80060e:	e8 52 1b 00 00       	call   802165 <sys_calculate_free_frames>
  800613:	89 c2                	mov    %eax,%edx
  800615:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800618:	39 c2                	cmp    %eax,%edx
  80061a:	74 17                	je     800633 <_main+0x5fb>
  80061c:	83 ec 04             	sub    $0x4,%esp
  80061f:	68 d3 29 80 00       	push   $0x8029d3
  800624:	68 80 00 00 00       	push   $0x80
  800629:	68 ac 28 80 00       	push   $0x8028ac
  80062e:	e8 f8 06 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800633:	ff 45 d8             	incl   -0x28(%ebp)
  800636:	83 ec 08             	sub    $0x8,%esp
  800639:	ff 75 d8             	pushl  -0x28(%ebp)
  80063c:	68 80 2a 80 00       	push   $0x802a80
  800641:	e8 99 09 00 00       	call   800fdf <cprintf>
  800646:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  800649:	e8 17 1b 00 00       	call   802165 <sys_calculate_free_frames>
  80064e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800651:	e8 92 1b 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800656:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(5*Mega); 			   // Use Hole 3 -> Hole 3 = 1 M
  800659:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80065c:	89 d0                	mov    %edx,%eax
  80065e:	c1 e0 02             	shl    $0x2,%eax
  800661:	01 d0                	add    %edx,%eax
  800663:	83 ec 0c             	sub    $0xc,%esp
  800666:	50                   	push   %eax
  800667:	e8 37 17 00 00       	call   801da3 <malloc>
  80066c:	83 c4 10             	add    $0x10,%esp
  80066f:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x81400000)
  800672:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800675:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  80067a:	74 17                	je     800693 <_main+0x65b>
		panic("Worst Fit not working correctly");
  80067c:	83 ec 04             	sub    $0x4,%esp
  80067f:	68 60 2a 80 00       	push   $0x802a60
  800684:	68 87 00 00 00       	push   $0x87
  800689:	68 ac 28 80 00       	push   $0x8028ac
  80068e:	e8 98 06 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800693:	e8 50 1b 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800698:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80069b:	89 c1                	mov    %eax,%ecx
  80069d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006a0:	89 d0                	mov    %edx,%eax
  8006a2:	c1 e0 02             	shl    $0x2,%eax
  8006a5:	01 d0                	add    %edx,%eax
  8006a7:	85 c0                	test   %eax,%eax
  8006a9:	79 05                	jns    8006b0 <_main+0x678>
  8006ab:	05 ff 0f 00 00       	add    $0xfff,%eax
  8006b0:	c1 f8 0c             	sar    $0xc,%eax
  8006b3:	39 c1                	cmp    %eax,%ecx
  8006b5:	74 17                	je     8006ce <_main+0x696>
  8006b7:	83 ec 04             	sub    $0x4,%esp
  8006ba:	68 b6 29 80 00       	push   $0x8029b6
  8006bf:	68 88 00 00 00       	push   $0x88
  8006c4:	68 ac 28 80 00       	push   $0x8028ac
  8006c9:	e8 5d 06 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8006ce:	e8 92 1a 00 00       	call   802165 <sys_calculate_free_frames>
  8006d3:	89 c2                	mov    %eax,%edx
  8006d5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8006d8:	39 c2                	cmp    %eax,%edx
  8006da:	74 17                	je     8006f3 <_main+0x6bb>
  8006dc:	83 ec 04             	sub    $0x4,%esp
  8006df:	68 d3 29 80 00       	push   $0x8029d3
  8006e4:	68 89 00 00 00       	push   $0x89
  8006e9:	68 ac 28 80 00       	push   $0x8028ac
  8006ee:	e8 38 06 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  8006f3:	ff 45 d8             	incl   -0x28(%ebp)
  8006f6:	83 ec 08             	sub    $0x8,%esp
  8006f9:	ff 75 d8             	pushl  -0x28(%ebp)
  8006fc:	68 80 2a 80 00       	push   $0x802a80
  800701:	e8 d9 08 00 00       	call   800fdf <cprintf>
  800706:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  800709:	e8 57 1a 00 00       	call   802165 <sys_calculate_free_frames>
  80070e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800711:	e8 d2 1a 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800716:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(4*Mega); 			   // Use Hole 4 -> Hole 4 = 1 M
  800719:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80071c:	c1 e0 02             	shl    $0x2,%eax
  80071f:	83 ec 0c             	sub    $0xc,%esp
  800722:	50                   	push   %eax
  800723:	e8 7b 16 00 00       	call   801da3 <malloc>
  800728:	83 c4 10             	add    $0x10,%esp
  80072b:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x8CD00000)
  80072e:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800731:	3d 00 00 d0 8c       	cmp    $0x8cd00000,%eax
  800736:	74 17                	je     80074f <_main+0x717>
		panic("Worst Fit not working correctly");
  800738:	83 ec 04             	sub    $0x4,%esp
  80073b:	68 60 2a 80 00       	push   $0x802a60
  800740:	68 90 00 00 00       	push   $0x90
  800745:	68 ac 28 80 00       	push   $0x8028ac
  80074a:	e8 dc 05 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  80074f:	e8 94 1a 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800754:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800757:	89 c2                	mov    %eax,%edx
  800759:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80075c:	c1 e0 02             	shl    $0x2,%eax
  80075f:	85 c0                	test   %eax,%eax
  800761:	79 05                	jns    800768 <_main+0x730>
  800763:	05 ff 0f 00 00       	add    $0xfff,%eax
  800768:	c1 f8 0c             	sar    $0xc,%eax
  80076b:	39 c2                	cmp    %eax,%edx
  80076d:	74 17                	je     800786 <_main+0x74e>
  80076f:	83 ec 04             	sub    $0x4,%esp
  800772:	68 b6 29 80 00       	push   $0x8029b6
  800777:	68 91 00 00 00       	push   $0x91
  80077c:	68 ac 28 80 00       	push   $0x8028ac
  800781:	e8 a5 05 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800786:	e8 da 19 00 00       	call   802165 <sys_calculate_free_frames>
  80078b:	89 c2                	mov    %eax,%edx
  80078d:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800790:	39 c2                	cmp    %eax,%edx
  800792:	74 17                	je     8007ab <_main+0x773>
  800794:	83 ec 04             	sub    $0x4,%esp
  800797:	68 d3 29 80 00       	push   $0x8029d3
  80079c:	68 92 00 00 00       	push   $0x92
  8007a1:	68 ac 28 80 00       	push   $0x8028ac
  8007a6:	e8 80 05 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  8007ab:	ff 45 d8             	incl   -0x28(%ebp)
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 d8             	pushl  -0x28(%ebp)
  8007b4:	68 80 2a 80 00       	push   $0x802a80
  8007b9:	e8 21 08 00 00       	call   800fdf <cprintf>
  8007be:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  8007c1:	e8 9f 19 00 00       	call   802165 <sys_calculate_free_frames>
  8007c6:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8007c9:	e8 1a 1a 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8007ce:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(2 * Mega); 			// Use Hole 2 -> Hole 2 = 2 M
  8007d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d4:	01 c0                	add    %eax,%eax
  8007d6:	83 ec 0c             	sub    $0xc,%esp
  8007d9:	50                   	push   %eax
  8007da:	e8 c4 15 00 00       	call   801da3 <malloc>
  8007df:	83 c4 10             	add    $0x10,%esp
  8007e2:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x80400000)
  8007e5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8007e8:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8007ed:	74 17                	je     800806 <_main+0x7ce>
		panic("Worst Fit not working correctly");
  8007ef:	83 ec 04             	sub    $0x4,%esp
  8007f2:	68 60 2a 80 00       	push   $0x802a60
  8007f7:	68 99 00 00 00       	push   $0x99
  8007fc:	68 ac 28 80 00       	push   $0x8028ac
  800801:	e8 25 05 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800806:	e8 dd 19 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  80080b:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80080e:	89 c2                	mov    %eax,%edx
  800810:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800813:	01 c0                	add    %eax,%eax
  800815:	85 c0                	test   %eax,%eax
  800817:	79 05                	jns    80081e <_main+0x7e6>
  800819:	05 ff 0f 00 00       	add    $0xfff,%eax
  80081e:	c1 f8 0c             	sar    $0xc,%eax
  800821:	39 c2                	cmp    %eax,%edx
  800823:	74 17                	je     80083c <_main+0x804>
  800825:	83 ec 04             	sub    $0x4,%esp
  800828:	68 b6 29 80 00       	push   $0x8029b6
  80082d:	68 9a 00 00 00       	push   $0x9a
  800832:	68 ac 28 80 00       	push   $0x8028ac
  800837:	e8 ef 04 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80083c:	e8 24 19 00 00       	call   802165 <sys_calculate_free_frames>
  800841:	89 c2                	mov    %eax,%edx
  800843:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800846:	39 c2                	cmp    %eax,%edx
  800848:	74 17                	je     800861 <_main+0x829>
  80084a:	83 ec 04             	sub    $0x4,%esp
  80084d:	68 d3 29 80 00       	push   $0x8029d3
  800852:	68 9b 00 00 00       	push   $0x9b
  800857:	68 ac 28 80 00       	push   $0x8028ac
  80085c:	e8 ca 04 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800861:	ff 45 d8             	incl   -0x28(%ebp)
  800864:	83 ec 08             	sub    $0x8,%esp
  800867:	ff 75 d8             	pushl  -0x28(%ebp)
  80086a:	68 80 2a 80 00       	push   $0x802a80
  80086f:	e8 6b 07 00 00       	call   800fdf <cprintf>
  800874:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  800877:	e8 e9 18 00 00       	call   802165 <sys_calculate_free_frames>
  80087c:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80087f:	e8 64 19 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800884:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(1*Mega + 512*kilo);    // Use Hole 1 -> Hole 1 = 0.5 M
  800887:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80088a:	c1 e0 09             	shl    $0x9,%eax
  80088d:	89 c2                	mov    %eax,%edx
  80088f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800892:	01 d0                	add    %edx,%eax
  800894:	83 ec 0c             	sub    $0xc,%esp
  800897:	50                   	push   %eax
  800898:	e8 06 15 00 00       	call   801da3 <malloc>
  80089d:	83 c4 10             	add    $0x10,%esp
  8008a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x80000000)
  8008a3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8008a6:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8008ab:	74 17                	je     8008c4 <_main+0x88c>
		panic("Worst Fit not working correctly");
  8008ad:	83 ec 04             	sub    $0x4,%esp
  8008b0:	68 60 2a 80 00       	push   $0x802a60
  8008b5:	68 a2 00 00 00       	push   $0xa2
  8008ba:	68 ac 28 80 00       	push   $0x8028ac
  8008bf:	e8 67 04 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (1*Mega + 512*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  8008c4:	e8 1f 19 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  8008c9:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8008cc:	89 c2                	mov    %eax,%edx
  8008ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008d1:	c1 e0 09             	shl    $0x9,%eax
  8008d4:	89 c1                	mov    %eax,%ecx
  8008d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d9:	01 c8                	add    %ecx,%eax
  8008db:	85 c0                	test   %eax,%eax
  8008dd:	79 05                	jns    8008e4 <_main+0x8ac>
  8008df:	05 ff 0f 00 00       	add    $0xfff,%eax
  8008e4:	c1 f8 0c             	sar    $0xc,%eax
  8008e7:	39 c2                	cmp    %eax,%edx
  8008e9:	74 17                	je     800902 <_main+0x8ca>
  8008eb:	83 ec 04             	sub    $0x4,%esp
  8008ee:	68 b6 29 80 00       	push   $0x8029b6
  8008f3:	68 a3 00 00 00       	push   $0xa3
  8008f8:	68 ac 28 80 00       	push   $0x8028ac
  8008fd:	e8 29 04 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800902:	e8 5e 18 00 00       	call   802165 <sys_calculate_free_frames>
  800907:	89 c2                	mov    %eax,%edx
  800909:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80090c:	39 c2                	cmp    %eax,%edx
  80090e:	74 17                	je     800927 <_main+0x8ef>
  800910:	83 ec 04             	sub    $0x4,%esp
  800913:	68 d3 29 80 00       	push   $0x8029d3
  800918:	68 a4 00 00 00       	push   $0xa4
  80091d:	68 ac 28 80 00       	push   $0x8028ac
  800922:	e8 04 04 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800927:	ff 45 d8             	incl   -0x28(%ebp)
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 d8             	pushl  -0x28(%ebp)
  800930:	68 80 2a 80 00       	push   $0x802a80
  800935:	e8 a5 06 00 00       	call   800fdf <cprintf>
  80093a:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  80093d:	e8 23 18 00 00       	call   802165 <sys_calculate_free_frames>
  800942:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800945:	e8 9e 18 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  80094a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(512*kilo); 			   // Use Hole 2 -> Hole 2 = 1.5 M
  80094d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800950:	c1 e0 09             	shl    $0x9,%eax
  800953:	83 ec 0c             	sub    $0xc,%esp
  800956:	50                   	push   %eax
  800957:	e8 47 14 00 00       	call   801da3 <malloc>
  80095c:	83 c4 10             	add    $0x10,%esp
  80095f:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x80600000)
  800962:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800965:	3d 00 00 60 80       	cmp    $0x80600000,%eax
  80096a:	74 17                	je     800983 <_main+0x94b>
		panic("Worst Fit not working correctly");
  80096c:	83 ec 04             	sub    $0x4,%esp
  80096f:	68 60 2a 80 00       	push   $0x802a60
  800974:	68 ab 00 00 00       	push   $0xab
  800979:	68 ac 28 80 00       	push   $0x8028ac
  80097e:	e8 a8 03 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  800983:	e8 60 18 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800988:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  80098b:	89 c2                	mov    %eax,%edx
  80098d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800990:	c1 e0 09             	shl    $0x9,%eax
  800993:	85 c0                	test   %eax,%eax
  800995:	79 05                	jns    80099c <_main+0x964>
  800997:	05 ff 0f 00 00       	add    $0xfff,%eax
  80099c:	c1 f8 0c             	sar    $0xc,%eax
  80099f:	39 c2                	cmp    %eax,%edx
  8009a1:	74 17                	je     8009ba <_main+0x982>
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	68 b6 29 80 00       	push   $0x8029b6
  8009ab:	68 ac 00 00 00       	push   $0xac
  8009b0:	68 ac 28 80 00       	push   $0x8028ac
  8009b5:	e8 71 03 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8009ba:	e8 a6 17 00 00       	call   802165 <sys_calculate_free_frames>
  8009bf:	89 c2                	mov    %eax,%edx
  8009c1:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8009c4:	39 c2                	cmp    %eax,%edx
  8009c6:	74 17                	je     8009df <_main+0x9a7>
  8009c8:	83 ec 04             	sub    $0x4,%esp
  8009cb:	68 d3 29 80 00       	push   $0x8029d3
  8009d0:	68 ad 00 00 00       	push   $0xad
  8009d5:	68 ac 28 80 00       	push   $0x8028ac
  8009da:	e8 4c 03 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  8009df:	ff 45 d8             	incl   -0x28(%ebp)
  8009e2:	83 ec 08             	sub    $0x8,%esp
  8009e5:	ff 75 d8             	pushl  -0x28(%ebp)
  8009e8:	68 80 2a 80 00       	push   $0x802a80
  8009ed:	e8 ed 05 00 00       	call   800fdf <cprintf>
  8009f2:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  8009f5:	e8 6b 17 00 00       	call   802165 <sys_calculate_free_frames>
  8009fa:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8009fd:	e8 e6 17 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800a02:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(kilo); 			   // Use Hole 5 -> Hole 5 = 2 M - K
  800a05:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a08:	83 ec 0c             	sub    $0xc,%esp
  800a0b:	50                   	push   %eax
  800a0c:	e8 92 13 00 00       	call   801da3 <malloc>
  800a11:	83 c4 10             	add    $0x10,%esp
  800a14:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x99600000)
  800a17:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800a1a:	3d 00 00 60 99       	cmp    $0x99600000,%eax
  800a1f:	74 17                	je     800a38 <_main+0xa00>
		panic("Worst Fit not working correctly");
  800a21:	83 ec 04             	sub    $0x4,%esp
  800a24:	68 60 2a 80 00       	push   $0x802a60
  800a29:	68 b4 00 00 00       	push   $0xb4
  800a2e:	68 ac 28 80 00       	push   $0x8028ac
  800a33:	e8 f3 02 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  800a38:	e8 ab 17 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800a3d:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800a40:	89 c2                	mov    %eax,%edx
  800a42:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a45:	c1 e0 02             	shl    $0x2,%eax
  800a48:	85 c0                	test   %eax,%eax
  800a4a:	79 05                	jns    800a51 <_main+0xa19>
  800a4c:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a51:	c1 f8 0c             	sar    $0xc,%eax
  800a54:	39 c2                	cmp    %eax,%edx
  800a56:	74 17                	je     800a6f <_main+0xa37>
  800a58:	83 ec 04             	sub    $0x4,%esp
  800a5b:	68 b6 29 80 00       	push   $0x8029b6
  800a60:	68 b5 00 00 00       	push   $0xb5
  800a65:	68 ac 28 80 00       	push   $0x8028ac
  800a6a:	e8 bc 02 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800a6f:	e8 f1 16 00 00       	call   802165 <sys_calculate_free_frames>
  800a74:	89 c2                	mov    %eax,%edx
  800a76:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800a79:	39 c2                	cmp    %eax,%edx
  800a7b:	74 17                	je     800a94 <_main+0xa5c>
  800a7d:	83 ec 04             	sub    $0x4,%esp
  800a80:	68 d3 29 80 00       	push   $0x8029d3
  800a85:	68 b6 00 00 00       	push   $0xb6
  800a8a:	68 ac 28 80 00       	push   $0x8028ac
  800a8f:	e8 97 02 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800a94:	ff 45 d8             	incl   -0x28(%ebp)
  800a97:	83 ec 08             	sub    $0x8,%esp
  800a9a:	ff 75 d8             	pushl  -0x28(%ebp)
  800a9d:	68 80 2a 80 00       	push   $0x802a80
  800aa2:	e8 38 05 00 00       	call   800fdf <cprintf>
  800aa7:	83 c4 10             	add    $0x10,%esp

	freeFrames = sys_calculate_free_frames() ;
  800aaa:	e8 b6 16 00 00       	call   802165 <sys_calculate_free_frames>
  800aaf:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab2:	e8 31 17 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800ab7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(2*Mega - 4*kilo); 		// Use Hole 5 -> Hole 5 = 0
  800aba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800abd:	01 c0                	add    %eax,%eax
  800abf:	89 c2                	mov    %eax,%edx
  800ac1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ac4:	29 d0                	sub    %edx,%eax
  800ac6:	01 c0                	add    %eax,%eax
  800ac8:	83 ec 0c             	sub    $0xc,%esp
  800acb:	50                   	push   %eax
  800acc:	e8 d2 12 00 00       	call   801da3 <malloc>
  800ad1:	83 c4 10             	add    $0x10,%esp
  800ad4:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x99601000)
  800ad7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800ada:	3d 00 10 60 99       	cmp    $0x99601000,%eax
  800adf:	74 17                	je     800af8 <_main+0xac0>
		panic("Worst Fit not working correctly");
  800ae1:	83 ec 04             	sub    $0x4,%esp
  800ae4:	68 60 2a 80 00       	push   $0x802a60
  800ae9:	68 bd 00 00 00       	push   $0xbd
  800aee:	68 ac 28 80 00       	push   $0x8028ac
  800af3:	e8 33 02 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (2*Mega - 4*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  800af8:	e8 eb 16 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800afd:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  800b00:	89 c2                	mov    %eax,%edx
  800b02:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b05:	01 c0                	add    %eax,%eax
  800b07:	89 c1                	mov    %eax,%ecx
  800b09:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b0c:	29 c8                	sub    %ecx,%eax
  800b0e:	01 c0                	add    %eax,%eax
  800b10:	85 c0                	test   %eax,%eax
  800b12:	79 05                	jns    800b19 <_main+0xae1>
  800b14:	05 ff 0f 00 00       	add    $0xfff,%eax
  800b19:	c1 f8 0c             	sar    $0xc,%eax
  800b1c:	39 c2                	cmp    %eax,%edx
  800b1e:	74 17                	je     800b37 <_main+0xaff>
  800b20:	83 ec 04             	sub    $0x4,%esp
  800b23:	68 b6 29 80 00       	push   $0x8029b6
  800b28:	68 be 00 00 00       	push   $0xbe
  800b2d:	68 ac 28 80 00       	push   $0x8028ac
  800b32:	e8 f4 01 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800b37:	e8 29 16 00 00       	call   802165 <sys_calculate_free_frames>
  800b3c:	89 c2                	mov    %eax,%edx
  800b3e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800b41:	39 c2                	cmp    %eax,%edx
  800b43:	74 17                	je     800b5c <_main+0xb24>
  800b45:	83 ec 04             	sub    $0x4,%esp
  800b48:	68 d3 29 80 00       	push   $0x8029d3
  800b4d:	68 bf 00 00 00       	push   $0xbf
  800b52:	68 ac 28 80 00       	push   $0x8028ac
  800b57:	e8 cf 01 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800b5c:	ff 45 d8             	incl   -0x28(%ebp)
  800b5f:	83 ec 08             	sub    $0x8,%esp
  800b62:	ff 75 d8             	pushl  -0x28(%ebp)
  800b65:	68 80 2a 80 00       	push   $0x802a80
  800b6a:	e8 70 04 00 00       	call   800fdf <cprintf>
  800b6f:	83 c4 10             	add    $0x10,%esp

	// Check that worst fit returns null in case all holes are not free
	freeFrames = sys_calculate_free_frames() ;
  800b72:	e8 ee 15 00 00       	call   802165 <sys_calculate_free_frames>
  800b77:	89 45 c8             	mov    %eax,-0x38(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800b7a:	e8 69 16 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800b7f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	tempAddress = malloc(4*Mega); 		//No Suitable hole
  800b82:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b85:	c1 e0 02             	shl    $0x2,%eax
  800b88:	83 ec 0c             	sub    $0xc,%esp
  800b8b:	50                   	push   %eax
  800b8c:	e8 12 12 00 00       	call   801da3 <malloc>
  800b91:	83 c4 10             	add    $0x10,%esp
  800b94:	89 45 c0             	mov    %eax,-0x40(%ebp)
	if((uint32)tempAddress != 0x0)
  800b97:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800b9a:	85 c0                	test   %eax,%eax
  800b9c:	74 17                	je     800bb5 <_main+0xb7d>
		panic("Worst Fit not working correctly");
  800b9e:	83 ec 04             	sub    $0x4,%esp
  800ba1:	68 60 2a 80 00       	push   $0x802a60
  800ba6:	68 c7 00 00 00       	push   $0xc7
  800bab:	68 ac 28 80 00       	push   $0x8028ac
  800bb0:	e8 76 01 00 00       	call   800d2b <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800bb5:	e8 2e 16 00 00       	call   8021e8 <sys_pf_calculate_allocated_pages>
  800bba:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  800bbd:	74 17                	je     800bd6 <_main+0xb9e>
  800bbf:	83 ec 04             	sub    $0x4,%esp
  800bc2:	68 b6 29 80 00       	push   $0x8029b6
  800bc7:	68 c8 00 00 00       	push   $0xc8
  800bcc:	68 ac 28 80 00       	push   $0x8028ac
  800bd1:	e8 55 01 00 00       	call   800d2b <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800bd6:	e8 8a 15 00 00       	call   802165 <sys_calculate_free_frames>
  800bdb:	89 c2                	mov    %eax,%edx
  800bdd:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800be0:	39 c2                	cmp    %eax,%edx
  800be2:	74 17                	je     800bfb <_main+0xbc3>
  800be4:	83 ec 04             	sub    $0x4,%esp
  800be7:	68 d3 29 80 00       	push   $0x8029d3
  800bec:	68 c9 00 00 00       	push   $0xc9
  800bf1:	68 ac 28 80 00       	push   $0x8028ac
  800bf6:	e8 30 01 00 00       	call   800d2b <_panic>
	cprintf("Test %d Passed \n", ++count);
  800bfb:	ff 45 d8             	incl   -0x28(%ebp)
  800bfe:	83 ec 08             	sub    $0x8,%esp
  800c01:	ff 75 d8             	pushl  -0x28(%ebp)
  800c04:	68 80 2a 80 00       	push   $0x802a80
  800c09:	e8 d1 03 00 00       	call   800fdf <cprintf>
  800c0e:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test Worst Fit completed successfully.\n");
  800c11:	83 ec 0c             	sub    $0xc,%esp
  800c14:	68 94 2a 80 00       	push   $0x802a94
  800c19:	e8 c1 03 00 00       	call   800fdf <cprintf>
  800c1e:	83 c4 10             	add    $0x10,%esp

	return;
  800c21:	90                   	nop
}
  800c22:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c25:	5b                   	pop    %ebx
  800c26:	5f                   	pop    %edi
  800c27:	5d                   	pop    %ebp
  800c28:	c3                   	ret    

00800c29 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800c2f:	e8 66 14 00 00       	call   80209a <sys_getenvindex>
  800c34:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800c37:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c3a:	89 d0                	mov    %edx,%eax
  800c3c:	01 c0                	add    %eax,%eax
  800c3e:	01 d0                	add    %edx,%eax
  800c40:	c1 e0 02             	shl    $0x2,%eax
  800c43:	01 d0                	add    %edx,%eax
  800c45:	c1 e0 06             	shl    $0x6,%eax
  800c48:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800c4d:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800c52:	a1 20 40 80 00       	mov    0x804020,%eax
  800c57:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800c5d:	84 c0                	test   %al,%al
  800c5f:	74 0f                	je     800c70 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800c61:	a1 20 40 80 00       	mov    0x804020,%eax
  800c66:	05 f4 02 00 00       	add    $0x2f4,%eax
  800c6b:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800c70:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c74:	7e 0a                	jle    800c80 <libmain+0x57>
		binaryname = argv[0];
  800c76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c79:	8b 00                	mov    (%eax),%eax
  800c7b:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800c80:	83 ec 08             	sub    $0x8,%esp
  800c83:	ff 75 0c             	pushl  0xc(%ebp)
  800c86:	ff 75 08             	pushl  0x8(%ebp)
  800c89:	e8 aa f3 ff ff       	call   800038 <_main>
  800c8e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800c91:	e8 9f 15 00 00       	call   802235 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c96:	83 ec 0c             	sub    $0xc,%esp
  800c99:	68 e8 2a 80 00       	push   $0x802ae8
  800c9e:	e8 3c 03 00 00       	call   800fdf <cprintf>
  800ca3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800ca6:	a1 20 40 80 00       	mov    0x804020,%eax
  800cab:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800cb1:	a1 20 40 80 00       	mov    0x804020,%eax
  800cb6:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800cbc:	83 ec 04             	sub    $0x4,%esp
  800cbf:	52                   	push   %edx
  800cc0:	50                   	push   %eax
  800cc1:	68 10 2b 80 00       	push   $0x802b10
  800cc6:	e8 14 03 00 00       	call   800fdf <cprintf>
  800ccb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800cce:	a1 20 40 80 00       	mov    0x804020,%eax
  800cd3:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800cd9:	83 ec 08             	sub    $0x8,%esp
  800cdc:	50                   	push   %eax
  800cdd:	68 35 2b 80 00       	push   $0x802b35
  800ce2:	e8 f8 02 00 00       	call   800fdf <cprintf>
  800ce7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800cea:	83 ec 0c             	sub    $0xc,%esp
  800ced:	68 e8 2a 80 00       	push   $0x802ae8
  800cf2:	e8 e8 02 00 00       	call   800fdf <cprintf>
  800cf7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800cfa:	e8 50 15 00 00       	call   80224f <sys_enable_interrupt>

	// exit gracefully
	exit();
  800cff:	e8 19 00 00 00       	call   800d1d <exit>
}
  800d04:	90                   	nop
  800d05:	c9                   	leave  
  800d06:	c3                   	ret    

00800d07 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800d07:	55                   	push   %ebp
  800d08:	89 e5                	mov    %esp,%ebp
  800d0a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800d0d:	83 ec 0c             	sub    $0xc,%esp
  800d10:	6a 00                	push   $0x0
  800d12:	e8 4f 13 00 00       	call   802066 <sys_env_destroy>
  800d17:	83 c4 10             	add    $0x10,%esp
}
  800d1a:	90                   	nop
  800d1b:	c9                   	leave  
  800d1c:	c3                   	ret    

00800d1d <exit>:

void
exit(void)
{
  800d1d:	55                   	push   %ebp
  800d1e:	89 e5                	mov    %esp,%ebp
  800d20:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800d23:	e8 a4 13 00 00       	call   8020cc <sys_env_exit>
}
  800d28:	90                   	nop
  800d29:	c9                   	leave  
  800d2a:	c3                   	ret    

00800d2b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800d2b:	55                   	push   %ebp
  800d2c:	89 e5                	mov    %esp,%ebp
  800d2e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800d31:	8d 45 10             	lea    0x10(%ebp),%eax
  800d34:	83 c0 04             	add    $0x4,%eax
  800d37:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800d3a:	a1 30 40 80 00       	mov    0x804030,%eax
  800d3f:	85 c0                	test   %eax,%eax
  800d41:	74 16                	je     800d59 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800d43:	a1 30 40 80 00       	mov    0x804030,%eax
  800d48:	83 ec 08             	sub    $0x8,%esp
  800d4b:	50                   	push   %eax
  800d4c:	68 4c 2b 80 00       	push   $0x802b4c
  800d51:	e8 89 02 00 00       	call   800fdf <cprintf>
  800d56:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800d59:	a1 00 40 80 00       	mov    0x804000,%eax
  800d5e:	ff 75 0c             	pushl  0xc(%ebp)
  800d61:	ff 75 08             	pushl  0x8(%ebp)
  800d64:	50                   	push   %eax
  800d65:	68 51 2b 80 00       	push   $0x802b51
  800d6a:	e8 70 02 00 00       	call   800fdf <cprintf>
  800d6f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800d72:	8b 45 10             	mov    0x10(%ebp),%eax
  800d75:	83 ec 08             	sub    $0x8,%esp
  800d78:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7b:	50                   	push   %eax
  800d7c:	e8 f3 01 00 00       	call   800f74 <vcprintf>
  800d81:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d84:	83 ec 08             	sub    $0x8,%esp
  800d87:	6a 00                	push   $0x0
  800d89:	68 6d 2b 80 00       	push   $0x802b6d
  800d8e:	e8 e1 01 00 00       	call   800f74 <vcprintf>
  800d93:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d96:	e8 82 ff ff ff       	call   800d1d <exit>

	// should not return here
	while (1) ;
  800d9b:	eb fe                	jmp    800d9b <_panic+0x70>

00800d9d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
  800da0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800da3:	a1 20 40 80 00       	mov    0x804020,%eax
  800da8:	8b 50 74             	mov    0x74(%eax),%edx
  800dab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dae:	39 c2                	cmp    %eax,%edx
  800db0:	74 14                	je     800dc6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800db2:	83 ec 04             	sub    $0x4,%esp
  800db5:	68 70 2b 80 00       	push   $0x802b70
  800dba:	6a 26                	push   $0x26
  800dbc:	68 bc 2b 80 00       	push   $0x802bbc
  800dc1:	e8 65 ff ff ff       	call   800d2b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800dc6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800dcd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800dd4:	e9 c2 00 00 00       	jmp    800e9b <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	01 d0                	add    %edx,%eax
  800de8:	8b 00                	mov    (%eax),%eax
  800dea:	85 c0                	test   %eax,%eax
  800dec:	75 08                	jne    800df6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800dee:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800df1:	e9 a2 00 00 00       	jmp    800e98 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800df6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dfd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800e04:	eb 69                	jmp    800e6f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800e06:	a1 20 40 80 00       	mov    0x804020,%eax
  800e0b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800e11:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e14:	89 d0                	mov    %edx,%eax
  800e16:	01 c0                	add    %eax,%eax
  800e18:	01 d0                	add    %edx,%eax
  800e1a:	c1 e0 02             	shl    $0x2,%eax
  800e1d:	01 c8                	add    %ecx,%eax
  800e1f:	8a 40 04             	mov    0x4(%eax),%al
  800e22:	84 c0                	test   %al,%al
  800e24:	75 46                	jne    800e6c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e26:	a1 20 40 80 00       	mov    0x804020,%eax
  800e2b:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800e31:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e34:	89 d0                	mov    %edx,%eax
  800e36:	01 c0                	add    %eax,%eax
  800e38:	01 d0                	add    %edx,%eax
  800e3a:	c1 e0 02             	shl    $0x2,%eax
  800e3d:	01 c8                	add    %ecx,%eax
  800e3f:	8b 00                	mov    (%eax),%eax
  800e41:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800e44:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800e47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e4c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800e4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e51:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	01 c8                	add    %ecx,%eax
  800e5d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e5f:	39 c2                	cmp    %eax,%edx
  800e61:	75 09                	jne    800e6c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800e63:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800e6a:	eb 12                	jmp    800e7e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e6c:	ff 45 e8             	incl   -0x18(%ebp)
  800e6f:	a1 20 40 80 00       	mov    0x804020,%eax
  800e74:	8b 50 74             	mov    0x74(%eax),%edx
  800e77:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800e7a:	39 c2                	cmp    %eax,%edx
  800e7c:	77 88                	ja     800e06 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800e7e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800e82:	75 14                	jne    800e98 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800e84:	83 ec 04             	sub    $0x4,%esp
  800e87:	68 c8 2b 80 00       	push   $0x802bc8
  800e8c:	6a 3a                	push   $0x3a
  800e8e:	68 bc 2b 80 00       	push   $0x802bbc
  800e93:	e8 93 fe ff ff       	call   800d2b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e98:	ff 45 f0             	incl   -0x10(%ebp)
  800e9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e9e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800ea1:	0f 8c 32 ff ff ff    	jl     800dd9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800ea7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800eae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800eb5:	eb 26                	jmp    800edd <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800eb7:	a1 20 40 80 00       	mov    0x804020,%eax
  800ebc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ec2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ec5:	89 d0                	mov    %edx,%eax
  800ec7:	01 c0                	add    %eax,%eax
  800ec9:	01 d0                	add    %edx,%eax
  800ecb:	c1 e0 02             	shl    $0x2,%eax
  800ece:	01 c8                	add    %ecx,%eax
  800ed0:	8a 40 04             	mov    0x4(%eax),%al
  800ed3:	3c 01                	cmp    $0x1,%al
  800ed5:	75 03                	jne    800eda <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800ed7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800eda:	ff 45 e0             	incl   -0x20(%ebp)
  800edd:	a1 20 40 80 00       	mov    0x804020,%eax
  800ee2:	8b 50 74             	mov    0x74(%eax),%edx
  800ee5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ee8:	39 c2                	cmp    %eax,%edx
  800eea:	77 cb                	ja     800eb7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800eec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eef:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ef2:	74 14                	je     800f08 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800ef4:	83 ec 04             	sub    $0x4,%esp
  800ef7:	68 1c 2c 80 00       	push   $0x802c1c
  800efc:	6a 44                	push   $0x44
  800efe:	68 bc 2b 80 00       	push   $0x802bbc
  800f03:	e8 23 fe ff ff       	call   800d2b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800f08:	90                   	nop
  800f09:	c9                   	leave  
  800f0a:	c3                   	ret    

00800f0b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800f0b:	55                   	push   %ebp
  800f0c:	89 e5                	mov    %esp,%ebp
  800f0e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800f11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f14:	8b 00                	mov    (%eax),%eax
  800f16:	8d 48 01             	lea    0x1(%eax),%ecx
  800f19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1c:	89 0a                	mov    %ecx,(%edx)
  800f1e:	8b 55 08             	mov    0x8(%ebp),%edx
  800f21:	88 d1                	mov    %dl,%cl
  800f23:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f26:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2d:	8b 00                	mov    (%eax),%eax
  800f2f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800f34:	75 2c                	jne    800f62 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800f36:	a0 24 40 80 00       	mov    0x804024,%al
  800f3b:	0f b6 c0             	movzbl %al,%eax
  800f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f41:	8b 12                	mov    (%edx),%edx
  800f43:	89 d1                	mov    %edx,%ecx
  800f45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f48:	83 c2 08             	add    $0x8,%edx
  800f4b:	83 ec 04             	sub    $0x4,%esp
  800f4e:	50                   	push   %eax
  800f4f:	51                   	push   %ecx
  800f50:	52                   	push   %edx
  800f51:	e8 ce 10 00 00       	call   802024 <sys_cputs>
  800f56:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800f59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800f62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f65:	8b 40 04             	mov    0x4(%eax),%eax
  800f68:	8d 50 01             	lea    0x1(%eax),%edx
  800f6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800f71:	90                   	nop
  800f72:	c9                   	leave  
  800f73:	c3                   	ret    

00800f74 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800f74:	55                   	push   %ebp
  800f75:	89 e5                	mov    %esp,%ebp
  800f77:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f7d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f84:	00 00 00 
	b.cnt = 0;
  800f87:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f8e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f91:	ff 75 0c             	pushl  0xc(%ebp)
  800f94:	ff 75 08             	pushl  0x8(%ebp)
  800f97:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f9d:	50                   	push   %eax
  800f9e:	68 0b 0f 80 00       	push   $0x800f0b
  800fa3:	e8 11 02 00 00       	call   8011b9 <vprintfmt>
  800fa8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800fab:	a0 24 40 80 00       	mov    0x804024,%al
  800fb0:	0f b6 c0             	movzbl %al,%eax
  800fb3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800fb9:	83 ec 04             	sub    $0x4,%esp
  800fbc:	50                   	push   %eax
  800fbd:	52                   	push   %edx
  800fbe:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800fc4:	83 c0 08             	add    $0x8,%eax
  800fc7:	50                   	push   %eax
  800fc8:	e8 57 10 00 00       	call   802024 <sys_cputs>
  800fcd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800fd0:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800fd7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800fdd:	c9                   	leave  
  800fde:	c3                   	ret    

00800fdf <cprintf>:

int cprintf(const char *fmt, ...) {
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
  800fe2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800fe5:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800fec:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	83 ec 08             	sub    $0x8,%esp
  800ff8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ffb:	50                   	push   %eax
  800ffc:	e8 73 ff ff ff       	call   800f74 <vcprintf>
  801001:	83 c4 10             	add    $0x10,%esp
  801004:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801007:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80100a:	c9                   	leave  
  80100b:	c3                   	ret    

0080100c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80100c:	55                   	push   %ebp
  80100d:	89 e5                	mov    %esp,%ebp
  80100f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801012:	e8 1e 12 00 00       	call   802235 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801017:	8d 45 0c             	lea    0xc(%ebp),%eax
  80101a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80101d:	8b 45 08             	mov    0x8(%ebp),%eax
  801020:	83 ec 08             	sub    $0x8,%esp
  801023:	ff 75 f4             	pushl  -0xc(%ebp)
  801026:	50                   	push   %eax
  801027:	e8 48 ff ff ff       	call   800f74 <vcprintf>
  80102c:	83 c4 10             	add    $0x10,%esp
  80102f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801032:	e8 18 12 00 00       	call   80224f <sys_enable_interrupt>
	return cnt;
  801037:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	53                   	push   %ebx
  801040:	83 ec 14             	sub    $0x14,%esp
  801043:	8b 45 10             	mov    0x10(%ebp),%eax
  801046:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801049:	8b 45 14             	mov    0x14(%ebp),%eax
  80104c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80104f:	8b 45 18             	mov    0x18(%ebp),%eax
  801052:	ba 00 00 00 00       	mov    $0x0,%edx
  801057:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80105a:	77 55                	ja     8010b1 <printnum+0x75>
  80105c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80105f:	72 05                	jb     801066 <printnum+0x2a>
  801061:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801064:	77 4b                	ja     8010b1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801066:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801069:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80106c:	8b 45 18             	mov    0x18(%ebp),%eax
  80106f:	ba 00 00 00 00       	mov    $0x0,%edx
  801074:	52                   	push   %edx
  801075:	50                   	push   %eax
  801076:	ff 75 f4             	pushl  -0xc(%ebp)
  801079:	ff 75 f0             	pushl  -0x10(%ebp)
  80107c:	e8 93 15 00 00       	call   802614 <__udivdi3>
  801081:	83 c4 10             	add    $0x10,%esp
  801084:	83 ec 04             	sub    $0x4,%esp
  801087:	ff 75 20             	pushl  0x20(%ebp)
  80108a:	53                   	push   %ebx
  80108b:	ff 75 18             	pushl  0x18(%ebp)
  80108e:	52                   	push   %edx
  80108f:	50                   	push   %eax
  801090:	ff 75 0c             	pushl  0xc(%ebp)
  801093:	ff 75 08             	pushl  0x8(%ebp)
  801096:	e8 a1 ff ff ff       	call   80103c <printnum>
  80109b:	83 c4 20             	add    $0x20,%esp
  80109e:	eb 1a                	jmp    8010ba <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8010a0:	83 ec 08             	sub    $0x8,%esp
  8010a3:	ff 75 0c             	pushl  0xc(%ebp)
  8010a6:	ff 75 20             	pushl  0x20(%ebp)
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	ff d0                	call   *%eax
  8010ae:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8010b1:	ff 4d 1c             	decl   0x1c(%ebp)
  8010b4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8010b8:	7f e6                	jg     8010a0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8010ba:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8010bd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8010c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c8:	53                   	push   %ebx
  8010c9:	51                   	push   %ecx
  8010ca:	52                   	push   %edx
  8010cb:	50                   	push   %eax
  8010cc:	e8 53 16 00 00       	call   802724 <__umoddi3>
  8010d1:	83 c4 10             	add    $0x10,%esp
  8010d4:	05 94 2e 80 00       	add    $0x802e94,%eax
  8010d9:	8a 00                	mov    (%eax),%al
  8010db:	0f be c0             	movsbl %al,%eax
  8010de:	83 ec 08             	sub    $0x8,%esp
  8010e1:	ff 75 0c             	pushl  0xc(%ebp)
  8010e4:	50                   	push   %eax
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	ff d0                	call   *%eax
  8010ea:	83 c4 10             	add    $0x10,%esp
}
  8010ed:	90                   	nop
  8010ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8010f1:	c9                   	leave  
  8010f2:	c3                   	ret    

008010f3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010f6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010fa:	7e 1c                	jle    801118 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	8b 00                	mov    (%eax),%eax
  801101:	8d 50 08             	lea    0x8(%eax),%edx
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	89 10                	mov    %edx,(%eax)
  801109:	8b 45 08             	mov    0x8(%ebp),%eax
  80110c:	8b 00                	mov    (%eax),%eax
  80110e:	83 e8 08             	sub    $0x8,%eax
  801111:	8b 50 04             	mov    0x4(%eax),%edx
  801114:	8b 00                	mov    (%eax),%eax
  801116:	eb 40                	jmp    801158 <getuint+0x65>
	else if (lflag)
  801118:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80111c:	74 1e                	je     80113c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	8b 00                	mov    (%eax),%eax
  801123:	8d 50 04             	lea    0x4(%eax),%edx
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	89 10                	mov    %edx,(%eax)
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	8b 00                	mov    (%eax),%eax
  801130:	83 e8 04             	sub    $0x4,%eax
  801133:	8b 00                	mov    (%eax),%eax
  801135:	ba 00 00 00 00       	mov    $0x0,%edx
  80113a:	eb 1c                	jmp    801158 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	8b 00                	mov    (%eax),%eax
  801141:	8d 50 04             	lea    0x4(%eax),%edx
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	89 10                	mov    %edx,(%eax)
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8b 00                	mov    (%eax),%eax
  80114e:	83 e8 04             	sub    $0x4,%eax
  801151:	8b 00                	mov    (%eax),%eax
  801153:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801158:	5d                   	pop    %ebp
  801159:	c3                   	ret    

0080115a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80115d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801161:	7e 1c                	jle    80117f <getint+0x25>
		return va_arg(*ap, long long);
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	8b 00                	mov    (%eax),%eax
  801168:	8d 50 08             	lea    0x8(%eax),%edx
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	89 10                	mov    %edx,(%eax)
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	8b 00                	mov    (%eax),%eax
  801175:	83 e8 08             	sub    $0x8,%eax
  801178:	8b 50 04             	mov    0x4(%eax),%edx
  80117b:	8b 00                	mov    (%eax),%eax
  80117d:	eb 38                	jmp    8011b7 <getint+0x5d>
	else if (lflag)
  80117f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801183:	74 1a                	je     80119f <getint+0x45>
		return va_arg(*ap, long);
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
  801188:	8b 00                	mov    (%eax),%eax
  80118a:	8d 50 04             	lea    0x4(%eax),%edx
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	89 10                	mov    %edx,(%eax)
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8b 00                	mov    (%eax),%eax
  801197:	83 e8 04             	sub    $0x4,%eax
  80119a:	8b 00                	mov    (%eax),%eax
  80119c:	99                   	cltd   
  80119d:	eb 18                	jmp    8011b7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	8b 00                	mov    (%eax),%eax
  8011a4:	8d 50 04             	lea    0x4(%eax),%edx
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	89 10                	mov    %edx,(%eax)
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8b 00                	mov    (%eax),%eax
  8011b1:	83 e8 04             	sub    $0x4,%eax
  8011b4:	8b 00                	mov    (%eax),%eax
  8011b6:	99                   	cltd   
}
  8011b7:	5d                   	pop    %ebp
  8011b8:	c3                   	ret    

008011b9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8011b9:	55                   	push   %ebp
  8011ba:	89 e5                	mov    %esp,%ebp
  8011bc:	56                   	push   %esi
  8011bd:	53                   	push   %ebx
  8011be:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011c1:	eb 17                	jmp    8011da <vprintfmt+0x21>
			if (ch == '\0')
  8011c3:	85 db                	test   %ebx,%ebx
  8011c5:	0f 84 af 03 00 00    	je     80157a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8011cb:	83 ec 08             	sub    $0x8,%esp
  8011ce:	ff 75 0c             	pushl  0xc(%ebp)
  8011d1:	53                   	push   %ebx
  8011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d5:	ff d0                	call   *%eax
  8011d7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011da:	8b 45 10             	mov    0x10(%ebp),%eax
  8011dd:	8d 50 01             	lea    0x1(%eax),%edx
  8011e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	0f b6 d8             	movzbl %al,%ebx
  8011e8:	83 fb 25             	cmp    $0x25,%ebx
  8011eb:	75 d6                	jne    8011c3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8011ed:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8011f1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8011f8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8011ff:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801206:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80120d:	8b 45 10             	mov    0x10(%ebp),%eax
  801210:	8d 50 01             	lea    0x1(%eax),%edx
  801213:	89 55 10             	mov    %edx,0x10(%ebp)
  801216:	8a 00                	mov    (%eax),%al
  801218:	0f b6 d8             	movzbl %al,%ebx
  80121b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80121e:	83 f8 55             	cmp    $0x55,%eax
  801221:	0f 87 2b 03 00 00    	ja     801552 <vprintfmt+0x399>
  801227:	8b 04 85 b8 2e 80 00 	mov    0x802eb8(,%eax,4),%eax
  80122e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801230:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801234:	eb d7                	jmp    80120d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801236:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80123a:	eb d1                	jmp    80120d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80123c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801243:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801246:	89 d0                	mov    %edx,%eax
  801248:	c1 e0 02             	shl    $0x2,%eax
  80124b:	01 d0                	add    %edx,%eax
  80124d:	01 c0                	add    %eax,%eax
  80124f:	01 d8                	add    %ebx,%eax
  801251:	83 e8 30             	sub    $0x30,%eax
  801254:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801257:	8b 45 10             	mov    0x10(%ebp),%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80125f:	83 fb 2f             	cmp    $0x2f,%ebx
  801262:	7e 3e                	jle    8012a2 <vprintfmt+0xe9>
  801264:	83 fb 39             	cmp    $0x39,%ebx
  801267:	7f 39                	jg     8012a2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801269:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80126c:	eb d5                	jmp    801243 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80126e:	8b 45 14             	mov    0x14(%ebp),%eax
  801271:	83 c0 04             	add    $0x4,%eax
  801274:	89 45 14             	mov    %eax,0x14(%ebp)
  801277:	8b 45 14             	mov    0x14(%ebp),%eax
  80127a:	83 e8 04             	sub    $0x4,%eax
  80127d:	8b 00                	mov    (%eax),%eax
  80127f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801282:	eb 1f                	jmp    8012a3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801284:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801288:	79 83                	jns    80120d <vprintfmt+0x54>
				width = 0;
  80128a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801291:	e9 77 ff ff ff       	jmp    80120d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801296:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80129d:	e9 6b ff ff ff       	jmp    80120d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8012a2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8012a3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012a7:	0f 89 60 ff ff ff    	jns    80120d <vprintfmt+0x54>
				width = precision, precision = -1;
  8012ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8012b3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8012ba:	e9 4e ff ff ff       	jmp    80120d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8012bf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8012c2:	e9 46 ff ff ff       	jmp    80120d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8012c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ca:	83 c0 04             	add    $0x4,%eax
  8012cd:	89 45 14             	mov    %eax,0x14(%ebp)
  8012d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8012d3:	83 e8 04             	sub    $0x4,%eax
  8012d6:	8b 00                	mov    (%eax),%eax
  8012d8:	83 ec 08             	sub    $0x8,%esp
  8012db:	ff 75 0c             	pushl  0xc(%ebp)
  8012de:	50                   	push   %eax
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	ff d0                	call   *%eax
  8012e4:	83 c4 10             	add    $0x10,%esp
			break;
  8012e7:	e9 89 02 00 00       	jmp    801575 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8012ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ef:	83 c0 04             	add    $0x4,%eax
  8012f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8012f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8012f8:	83 e8 04             	sub    $0x4,%eax
  8012fb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8012fd:	85 db                	test   %ebx,%ebx
  8012ff:	79 02                	jns    801303 <vprintfmt+0x14a>
				err = -err;
  801301:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801303:	83 fb 64             	cmp    $0x64,%ebx
  801306:	7f 0b                	jg     801313 <vprintfmt+0x15a>
  801308:	8b 34 9d 00 2d 80 00 	mov    0x802d00(,%ebx,4),%esi
  80130f:	85 f6                	test   %esi,%esi
  801311:	75 19                	jne    80132c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801313:	53                   	push   %ebx
  801314:	68 a5 2e 80 00       	push   $0x802ea5
  801319:	ff 75 0c             	pushl  0xc(%ebp)
  80131c:	ff 75 08             	pushl  0x8(%ebp)
  80131f:	e8 5e 02 00 00       	call   801582 <printfmt>
  801324:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801327:	e9 49 02 00 00       	jmp    801575 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80132c:	56                   	push   %esi
  80132d:	68 ae 2e 80 00       	push   $0x802eae
  801332:	ff 75 0c             	pushl  0xc(%ebp)
  801335:	ff 75 08             	pushl  0x8(%ebp)
  801338:	e8 45 02 00 00       	call   801582 <printfmt>
  80133d:	83 c4 10             	add    $0x10,%esp
			break;
  801340:	e9 30 02 00 00       	jmp    801575 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801345:	8b 45 14             	mov    0x14(%ebp),%eax
  801348:	83 c0 04             	add    $0x4,%eax
  80134b:	89 45 14             	mov    %eax,0x14(%ebp)
  80134e:	8b 45 14             	mov    0x14(%ebp),%eax
  801351:	83 e8 04             	sub    $0x4,%eax
  801354:	8b 30                	mov    (%eax),%esi
  801356:	85 f6                	test   %esi,%esi
  801358:	75 05                	jne    80135f <vprintfmt+0x1a6>
				p = "(null)";
  80135a:	be b1 2e 80 00       	mov    $0x802eb1,%esi
			if (width > 0 && padc != '-')
  80135f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801363:	7e 6d                	jle    8013d2 <vprintfmt+0x219>
  801365:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801369:	74 67                	je     8013d2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80136b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80136e:	83 ec 08             	sub    $0x8,%esp
  801371:	50                   	push   %eax
  801372:	56                   	push   %esi
  801373:	e8 0c 03 00 00       	call   801684 <strnlen>
  801378:	83 c4 10             	add    $0x10,%esp
  80137b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80137e:	eb 16                	jmp    801396 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801380:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801384:	83 ec 08             	sub    $0x8,%esp
  801387:	ff 75 0c             	pushl  0xc(%ebp)
  80138a:	50                   	push   %eax
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	ff d0                	call   *%eax
  801390:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801393:	ff 4d e4             	decl   -0x1c(%ebp)
  801396:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80139a:	7f e4                	jg     801380 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80139c:	eb 34                	jmp    8013d2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80139e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8013a2:	74 1c                	je     8013c0 <vprintfmt+0x207>
  8013a4:	83 fb 1f             	cmp    $0x1f,%ebx
  8013a7:	7e 05                	jle    8013ae <vprintfmt+0x1f5>
  8013a9:	83 fb 7e             	cmp    $0x7e,%ebx
  8013ac:	7e 12                	jle    8013c0 <vprintfmt+0x207>
					putch('?', putdat);
  8013ae:	83 ec 08             	sub    $0x8,%esp
  8013b1:	ff 75 0c             	pushl  0xc(%ebp)
  8013b4:	6a 3f                	push   $0x3f
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	ff d0                	call   *%eax
  8013bb:	83 c4 10             	add    $0x10,%esp
  8013be:	eb 0f                	jmp    8013cf <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8013c0:	83 ec 08             	sub    $0x8,%esp
  8013c3:	ff 75 0c             	pushl  0xc(%ebp)
  8013c6:	53                   	push   %ebx
  8013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ca:	ff d0                	call   *%eax
  8013cc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8013cf:	ff 4d e4             	decl   -0x1c(%ebp)
  8013d2:	89 f0                	mov    %esi,%eax
  8013d4:	8d 70 01             	lea    0x1(%eax),%esi
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	0f be d8             	movsbl %al,%ebx
  8013dc:	85 db                	test   %ebx,%ebx
  8013de:	74 24                	je     801404 <vprintfmt+0x24b>
  8013e0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013e4:	78 b8                	js     80139e <vprintfmt+0x1e5>
  8013e6:	ff 4d e0             	decl   -0x20(%ebp)
  8013e9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013ed:	79 af                	jns    80139e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013ef:	eb 13                	jmp    801404 <vprintfmt+0x24b>
				putch(' ', putdat);
  8013f1:	83 ec 08             	sub    $0x8,%esp
  8013f4:	ff 75 0c             	pushl  0xc(%ebp)
  8013f7:	6a 20                	push   $0x20
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	ff d0                	call   *%eax
  8013fe:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801401:	ff 4d e4             	decl   -0x1c(%ebp)
  801404:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801408:	7f e7                	jg     8013f1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80140a:	e9 66 01 00 00       	jmp    801575 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80140f:	83 ec 08             	sub    $0x8,%esp
  801412:	ff 75 e8             	pushl  -0x18(%ebp)
  801415:	8d 45 14             	lea    0x14(%ebp),%eax
  801418:	50                   	push   %eax
  801419:	e8 3c fd ff ff       	call   80115a <getint>
  80141e:	83 c4 10             	add    $0x10,%esp
  801421:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801424:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801427:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80142a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80142d:	85 d2                	test   %edx,%edx
  80142f:	79 23                	jns    801454 <vprintfmt+0x29b>
				putch('-', putdat);
  801431:	83 ec 08             	sub    $0x8,%esp
  801434:	ff 75 0c             	pushl  0xc(%ebp)
  801437:	6a 2d                	push   $0x2d
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	ff d0                	call   *%eax
  80143e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801441:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801444:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801447:	f7 d8                	neg    %eax
  801449:	83 d2 00             	adc    $0x0,%edx
  80144c:	f7 da                	neg    %edx
  80144e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801451:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801454:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80145b:	e9 bc 00 00 00       	jmp    80151c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801460:	83 ec 08             	sub    $0x8,%esp
  801463:	ff 75 e8             	pushl  -0x18(%ebp)
  801466:	8d 45 14             	lea    0x14(%ebp),%eax
  801469:	50                   	push   %eax
  80146a:	e8 84 fc ff ff       	call   8010f3 <getuint>
  80146f:	83 c4 10             	add    $0x10,%esp
  801472:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801475:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801478:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80147f:	e9 98 00 00 00       	jmp    80151c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801484:	83 ec 08             	sub    $0x8,%esp
  801487:	ff 75 0c             	pushl  0xc(%ebp)
  80148a:	6a 58                	push   $0x58
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	ff d0                	call   *%eax
  801491:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801494:	83 ec 08             	sub    $0x8,%esp
  801497:	ff 75 0c             	pushl  0xc(%ebp)
  80149a:	6a 58                	push   $0x58
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	ff d0                	call   *%eax
  8014a1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8014a4:	83 ec 08             	sub    $0x8,%esp
  8014a7:	ff 75 0c             	pushl  0xc(%ebp)
  8014aa:	6a 58                	push   $0x58
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	ff d0                	call   *%eax
  8014b1:	83 c4 10             	add    $0x10,%esp
			break;
  8014b4:	e9 bc 00 00 00       	jmp    801575 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8014b9:	83 ec 08             	sub    $0x8,%esp
  8014bc:	ff 75 0c             	pushl  0xc(%ebp)
  8014bf:	6a 30                	push   $0x30
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	ff d0                	call   *%eax
  8014c6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8014c9:	83 ec 08             	sub    $0x8,%esp
  8014cc:	ff 75 0c             	pushl  0xc(%ebp)
  8014cf:	6a 78                	push   $0x78
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	ff d0                	call   *%eax
  8014d6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8014d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014dc:	83 c0 04             	add    $0x4,%eax
  8014df:	89 45 14             	mov    %eax,0x14(%ebp)
  8014e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e5:	83 e8 04             	sub    $0x4,%eax
  8014e8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8014ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8014f4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8014fb:	eb 1f                	jmp    80151c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8014fd:	83 ec 08             	sub    $0x8,%esp
  801500:	ff 75 e8             	pushl  -0x18(%ebp)
  801503:	8d 45 14             	lea    0x14(%ebp),%eax
  801506:	50                   	push   %eax
  801507:	e8 e7 fb ff ff       	call   8010f3 <getuint>
  80150c:	83 c4 10             	add    $0x10,%esp
  80150f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801512:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801515:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80151c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801520:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801523:	83 ec 04             	sub    $0x4,%esp
  801526:	52                   	push   %edx
  801527:	ff 75 e4             	pushl  -0x1c(%ebp)
  80152a:	50                   	push   %eax
  80152b:	ff 75 f4             	pushl  -0xc(%ebp)
  80152e:	ff 75 f0             	pushl  -0x10(%ebp)
  801531:	ff 75 0c             	pushl  0xc(%ebp)
  801534:	ff 75 08             	pushl  0x8(%ebp)
  801537:	e8 00 fb ff ff       	call   80103c <printnum>
  80153c:	83 c4 20             	add    $0x20,%esp
			break;
  80153f:	eb 34                	jmp    801575 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801541:	83 ec 08             	sub    $0x8,%esp
  801544:	ff 75 0c             	pushl  0xc(%ebp)
  801547:	53                   	push   %ebx
  801548:	8b 45 08             	mov    0x8(%ebp),%eax
  80154b:	ff d0                	call   *%eax
  80154d:	83 c4 10             	add    $0x10,%esp
			break;
  801550:	eb 23                	jmp    801575 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801552:	83 ec 08             	sub    $0x8,%esp
  801555:	ff 75 0c             	pushl  0xc(%ebp)
  801558:	6a 25                	push   $0x25
  80155a:	8b 45 08             	mov    0x8(%ebp),%eax
  80155d:	ff d0                	call   *%eax
  80155f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801562:	ff 4d 10             	decl   0x10(%ebp)
  801565:	eb 03                	jmp    80156a <vprintfmt+0x3b1>
  801567:	ff 4d 10             	decl   0x10(%ebp)
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	48                   	dec    %eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	3c 25                	cmp    $0x25,%al
  801572:	75 f3                	jne    801567 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801574:	90                   	nop
		}
	}
  801575:	e9 47 fc ff ff       	jmp    8011c1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80157a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80157b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80157e:	5b                   	pop    %ebx
  80157f:	5e                   	pop    %esi
  801580:	5d                   	pop    %ebp
  801581:	c3                   	ret    

00801582 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801588:	8d 45 10             	lea    0x10(%ebp),%eax
  80158b:	83 c0 04             	add    $0x4,%eax
  80158e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801591:	8b 45 10             	mov    0x10(%ebp),%eax
  801594:	ff 75 f4             	pushl  -0xc(%ebp)
  801597:	50                   	push   %eax
  801598:	ff 75 0c             	pushl  0xc(%ebp)
  80159b:	ff 75 08             	pushl  0x8(%ebp)
  80159e:	e8 16 fc ff ff       	call   8011b9 <vprintfmt>
  8015a3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8015a6:	90                   	nop
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	8b 40 08             	mov    0x8(%eax),%eax
  8015b2:	8d 50 01             	lea    0x1(%eax),%edx
  8015b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8015bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015be:	8b 10                	mov    (%eax),%edx
  8015c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c3:	8b 40 04             	mov    0x4(%eax),%eax
  8015c6:	39 c2                	cmp    %eax,%edx
  8015c8:	73 12                	jae    8015dc <sprintputch+0x33>
		*b->buf++ = ch;
  8015ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cd:	8b 00                	mov    (%eax),%eax
  8015cf:	8d 48 01             	lea    0x1(%eax),%ecx
  8015d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d5:	89 0a                	mov    %ecx,(%edx)
  8015d7:	8b 55 08             	mov    0x8(%ebp),%edx
  8015da:	88 10                	mov    %dl,(%eax)
}
  8015dc:	90                   	nop
  8015dd:	5d                   	pop    %ebp
  8015de:	c3                   	ret    

008015df <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
  8015e2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8015eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	01 d0                	add    %edx,%eax
  8015f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801600:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801604:	74 06                	je     80160c <vsnprintf+0x2d>
  801606:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80160a:	7f 07                	jg     801613 <vsnprintf+0x34>
		return -E_INVAL;
  80160c:	b8 03 00 00 00       	mov    $0x3,%eax
  801611:	eb 20                	jmp    801633 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801613:	ff 75 14             	pushl  0x14(%ebp)
  801616:	ff 75 10             	pushl  0x10(%ebp)
  801619:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80161c:	50                   	push   %eax
  80161d:	68 a9 15 80 00       	push   $0x8015a9
  801622:	e8 92 fb ff ff       	call   8011b9 <vprintfmt>
  801627:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80162a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80162d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801630:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801633:	c9                   	leave  
  801634:	c3                   	ret    

00801635 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801635:	55                   	push   %ebp
  801636:	89 e5                	mov    %esp,%ebp
  801638:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80163b:	8d 45 10             	lea    0x10(%ebp),%eax
  80163e:	83 c0 04             	add    $0x4,%eax
  801641:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801644:	8b 45 10             	mov    0x10(%ebp),%eax
  801647:	ff 75 f4             	pushl  -0xc(%ebp)
  80164a:	50                   	push   %eax
  80164b:	ff 75 0c             	pushl  0xc(%ebp)
  80164e:	ff 75 08             	pushl  0x8(%ebp)
  801651:	e8 89 ff ff ff       	call   8015df <vsnprintf>
  801656:	83 c4 10             	add    $0x10,%esp
  801659:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80165c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801667:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80166e:	eb 06                	jmp    801676 <strlen+0x15>
		n++;
  801670:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801673:	ff 45 08             	incl   0x8(%ebp)
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	84 c0                	test   %al,%al
  80167d:	75 f1                	jne    801670 <strlen+0xf>
		n++;
	return n;
  80167f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801682:	c9                   	leave  
  801683:	c3                   	ret    

00801684 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801684:	55                   	push   %ebp
  801685:	89 e5                	mov    %esp,%ebp
  801687:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80168a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801691:	eb 09                	jmp    80169c <strnlen+0x18>
		n++;
  801693:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801696:	ff 45 08             	incl   0x8(%ebp)
  801699:	ff 4d 0c             	decl   0xc(%ebp)
  80169c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016a0:	74 09                	je     8016ab <strnlen+0x27>
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	84 c0                	test   %al,%al
  8016a9:	75 e8                	jne    801693 <strnlen+0xf>
		n++;
	return n;
  8016ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
  8016b3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8016bc:	90                   	nop
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8d 50 01             	lea    0x1(%eax),%edx
  8016c3:	89 55 08             	mov    %edx,0x8(%ebp)
  8016c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016cc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016cf:	8a 12                	mov    (%edx),%dl
  8016d1:	88 10                	mov    %dl,(%eax)
  8016d3:	8a 00                	mov    (%eax),%al
  8016d5:	84 c0                	test   %al,%al
  8016d7:	75 e4                	jne    8016bd <strcpy+0xd>
		/* do nothing */;
	return ret;
  8016d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016f1:	eb 1f                	jmp    801712 <strncpy+0x34>
		*dst++ = *src;
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	8d 50 01             	lea    0x1(%eax),%edx
  8016f9:	89 55 08             	mov    %edx,0x8(%ebp)
  8016fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ff:	8a 12                	mov    (%edx),%dl
  801701:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801703:	8b 45 0c             	mov    0xc(%ebp),%eax
  801706:	8a 00                	mov    (%eax),%al
  801708:	84 c0                	test   %al,%al
  80170a:	74 03                	je     80170f <strncpy+0x31>
			src++;
  80170c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80170f:	ff 45 fc             	incl   -0x4(%ebp)
  801712:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801715:	3b 45 10             	cmp    0x10(%ebp),%eax
  801718:	72 d9                	jb     8016f3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80171a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
  801722:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80172b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80172f:	74 30                	je     801761 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801731:	eb 16                	jmp    801749 <strlcpy+0x2a>
			*dst++ = *src++;
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8d 50 01             	lea    0x1(%eax),%edx
  801739:	89 55 08             	mov    %edx,0x8(%ebp)
  80173c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801742:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801745:	8a 12                	mov    (%edx),%dl
  801747:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801749:	ff 4d 10             	decl   0x10(%ebp)
  80174c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801750:	74 09                	je     80175b <strlcpy+0x3c>
  801752:	8b 45 0c             	mov    0xc(%ebp),%eax
  801755:	8a 00                	mov    (%eax),%al
  801757:	84 c0                	test   %al,%al
  801759:	75 d8                	jne    801733 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801761:	8b 55 08             	mov    0x8(%ebp),%edx
  801764:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801767:	29 c2                	sub    %eax,%edx
  801769:	89 d0                	mov    %edx,%eax
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801770:	eb 06                	jmp    801778 <strcmp+0xb>
		p++, q++;
  801772:	ff 45 08             	incl   0x8(%ebp)
  801775:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801778:	8b 45 08             	mov    0x8(%ebp),%eax
  80177b:	8a 00                	mov    (%eax),%al
  80177d:	84 c0                	test   %al,%al
  80177f:	74 0e                	je     80178f <strcmp+0x22>
  801781:	8b 45 08             	mov    0x8(%ebp),%eax
  801784:	8a 10                	mov    (%eax),%dl
  801786:	8b 45 0c             	mov    0xc(%ebp),%eax
  801789:	8a 00                	mov    (%eax),%al
  80178b:	38 c2                	cmp    %al,%dl
  80178d:	74 e3                	je     801772 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	8a 00                	mov    (%eax),%al
  801794:	0f b6 d0             	movzbl %al,%edx
  801797:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179a:	8a 00                	mov    (%eax),%al
  80179c:	0f b6 c0             	movzbl %al,%eax
  80179f:	29 c2                	sub    %eax,%edx
  8017a1:	89 d0                	mov    %edx,%eax
}
  8017a3:	5d                   	pop    %ebp
  8017a4:	c3                   	ret    

008017a5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8017a8:	eb 09                	jmp    8017b3 <strncmp+0xe>
		n--, p++, q++;
  8017aa:	ff 4d 10             	decl   0x10(%ebp)
  8017ad:	ff 45 08             	incl   0x8(%ebp)
  8017b0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8017b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017b7:	74 17                	je     8017d0 <strncmp+0x2b>
  8017b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bc:	8a 00                	mov    (%eax),%al
  8017be:	84 c0                	test   %al,%al
  8017c0:	74 0e                	je     8017d0 <strncmp+0x2b>
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 10                	mov    (%eax),%dl
  8017c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ca:	8a 00                	mov    (%eax),%al
  8017cc:	38 c2                	cmp    %al,%dl
  8017ce:	74 da                	je     8017aa <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8017d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017d4:	75 07                	jne    8017dd <strncmp+0x38>
		return 0;
  8017d6:	b8 00 00 00 00       	mov    $0x0,%eax
  8017db:	eb 14                	jmp    8017f1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	8a 00                	mov    (%eax),%al
  8017e2:	0f b6 d0             	movzbl %al,%edx
  8017e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e8:	8a 00                	mov    (%eax),%al
  8017ea:	0f b6 c0             	movzbl %al,%eax
  8017ed:	29 c2                	sub    %eax,%edx
  8017ef:	89 d0                	mov    %edx,%eax
}
  8017f1:	5d                   	pop    %ebp
  8017f2:	c3                   	ret    

008017f3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017f3:	55                   	push   %ebp
  8017f4:	89 e5                	mov    %esp,%ebp
  8017f6:	83 ec 04             	sub    $0x4,%esp
  8017f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017ff:	eb 12                	jmp    801813 <strchr+0x20>
		if (*s == c)
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	8a 00                	mov    (%eax),%al
  801806:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801809:	75 05                	jne    801810 <strchr+0x1d>
			return (char *) s;
  80180b:	8b 45 08             	mov    0x8(%ebp),%eax
  80180e:	eb 11                	jmp    801821 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801810:	ff 45 08             	incl   0x8(%ebp)
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	84 c0                	test   %al,%al
  80181a:	75 e5                	jne    801801 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80181c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801821:	c9                   	leave  
  801822:	c3                   	ret    

00801823 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801823:	55                   	push   %ebp
  801824:	89 e5                	mov    %esp,%ebp
  801826:	83 ec 04             	sub    $0x4,%esp
  801829:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80182f:	eb 0d                	jmp    80183e <strfind+0x1b>
		if (*s == c)
  801831:	8b 45 08             	mov    0x8(%ebp),%eax
  801834:	8a 00                	mov    (%eax),%al
  801836:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801839:	74 0e                	je     801849 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80183b:	ff 45 08             	incl   0x8(%ebp)
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	84 c0                	test   %al,%al
  801845:	75 ea                	jne    801831 <strfind+0xe>
  801847:	eb 01                	jmp    80184a <strfind+0x27>
		if (*s == c)
			break;
  801849:	90                   	nop
	return (char *) s;
  80184a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
  801852:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80185b:	8b 45 10             	mov    0x10(%ebp),%eax
  80185e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801861:	eb 0e                	jmp    801871 <memset+0x22>
		*p++ = c;
  801863:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801866:	8d 50 01             	lea    0x1(%eax),%edx
  801869:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80186c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80186f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801871:	ff 4d f8             	decl   -0x8(%ebp)
  801874:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801878:	79 e9                	jns    801863 <memset+0x14>
		*p++ = c;

	return v;
  80187a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
  801882:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801885:	8b 45 0c             	mov    0xc(%ebp),%eax
  801888:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801891:	eb 16                	jmp    8018a9 <memcpy+0x2a>
		*d++ = *s++;
  801893:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801896:	8d 50 01             	lea    0x1(%eax),%edx
  801899:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80189c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80189f:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018a2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8018a5:	8a 12                	mov    (%edx),%dl
  8018a7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8018a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018af:	89 55 10             	mov    %edx,0x10(%ebp)
  8018b2:	85 c0                	test   %eax,%eax
  8018b4:	75 dd                	jne    801893 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018b9:	c9                   	leave  
  8018ba:	c3                   	ret    

008018bb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8018bb:	55                   	push   %ebp
  8018bc:	89 e5                	mov    %esp,%ebp
  8018be:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8018c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8018cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018d3:	73 50                	jae    801925 <memmove+0x6a>
  8018d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018db:	01 d0                	add    %edx,%eax
  8018dd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018e0:	76 43                	jbe    801925 <memmove+0x6a>
		s += n;
  8018e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8018e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018eb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018ee:	eb 10                	jmp    801900 <memmove+0x45>
			*--d = *--s;
  8018f0:	ff 4d f8             	decl   -0x8(%ebp)
  8018f3:	ff 4d fc             	decl   -0x4(%ebp)
  8018f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018f9:	8a 10                	mov    (%eax),%dl
  8018fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018fe:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801900:	8b 45 10             	mov    0x10(%ebp),%eax
  801903:	8d 50 ff             	lea    -0x1(%eax),%edx
  801906:	89 55 10             	mov    %edx,0x10(%ebp)
  801909:	85 c0                	test   %eax,%eax
  80190b:	75 e3                	jne    8018f0 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80190d:	eb 23                	jmp    801932 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80190f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801912:	8d 50 01             	lea    0x1(%eax),%edx
  801915:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801918:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80191b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80191e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801921:	8a 12                	mov    (%edx),%dl
  801923:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801925:	8b 45 10             	mov    0x10(%ebp),%eax
  801928:	8d 50 ff             	lea    -0x1(%eax),%edx
  80192b:	89 55 10             	mov    %edx,0x10(%ebp)
  80192e:	85 c0                	test   %eax,%eax
  801930:	75 dd                	jne    80190f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801932:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
  80193a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801943:	8b 45 0c             	mov    0xc(%ebp),%eax
  801946:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801949:	eb 2a                	jmp    801975 <memcmp+0x3e>
		if (*s1 != *s2)
  80194b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80194e:	8a 10                	mov    (%eax),%dl
  801950:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801953:	8a 00                	mov    (%eax),%al
  801955:	38 c2                	cmp    %al,%dl
  801957:	74 16                	je     80196f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801959:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80195c:	8a 00                	mov    (%eax),%al
  80195e:	0f b6 d0             	movzbl %al,%edx
  801961:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801964:	8a 00                	mov    (%eax),%al
  801966:	0f b6 c0             	movzbl %al,%eax
  801969:	29 c2                	sub    %eax,%edx
  80196b:	89 d0                	mov    %edx,%eax
  80196d:	eb 18                	jmp    801987 <memcmp+0x50>
		s1++, s2++;
  80196f:	ff 45 fc             	incl   -0x4(%ebp)
  801972:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801975:	8b 45 10             	mov    0x10(%ebp),%eax
  801978:	8d 50 ff             	lea    -0x1(%eax),%edx
  80197b:	89 55 10             	mov    %edx,0x10(%ebp)
  80197e:	85 c0                	test   %eax,%eax
  801980:	75 c9                	jne    80194b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801982:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801987:	c9                   	leave  
  801988:	c3                   	ret    

00801989 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801989:	55                   	push   %ebp
  80198a:	89 e5                	mov    %esp,%ebp
  80198c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80198f:	8b 55 08             	mov    0x8(%ebp),%edx
  801992:	8b 45 10             	mov    0x10(%ebp),%eax
  801995:	01 d0                	add    %edx,%eax
  801997:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80199a:	eb 15                	jmp    8019b1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	8a 00                	mov    (%eax),%al
  8019a1:	0f b6 d0             	movzbl %al,%edx
  8019a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a7:	0f b6 c0             	movzbl %al,%eax
  8019aa:	39 c2                	cmp    %eax,%edx
  8019ac:	74 0d                	je     8019bb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8019ae:	ff 45 08             	incl   0x8(%ebp)
  8019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019b7:	72 e3                	jb     80199c <memfind+0x13>
  8019b9:	eb 01                	jmp    8019bc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8019bb:	90                   	nop
	return (void *) s;
  8019bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
  8019c4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8019c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8019ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019d5:	eb 03                	jmp    8019da <strtol+0x19>
		s++;
  8019d7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	8a 00                	mov    (%eax),%al
  8019df:	3c 20                	cmp    $0x20,%al
  8019e1:	74 f4                	je     8019d7 <strtol+0x16>
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	8a 00                	mov    (%eax),%al
  8019e8:	3c 09                	cmp    $0x9,%al
  8019ea:	74 eb                	je     8019d7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	8a 00                	mov    (%eax),%al
  8019f1:	3c 2b                	cmp    $0x2b,%al
  8019f3:	75 05                	jne    8019fa <strtol+0x39>
		s++;
  8019f5:	ff 45 08             	incl   0x8(%ebp)
  8019f8:	eb 13                	jmp    801a0d <strtol+0x4c>
	else if (*s == '-')
  8019fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fd:	8a 00                	mov    (%eax),%al
  8019ff:	3c 2d                	cmp    $0x2d,%al
  801a01:	75 0a                	jne    801a0d <strtol+0x4c>
		s++, neg = 1;
  801a03:	ff 45 08             	incl   0x8(%ebp)
  801a06:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801a0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a11:	74 06                	je     801a19 <strtol+0x58>
  801a13:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801a17:	75 20                	jne    801a39 <strtol+0x78>
  801a19:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1c:	8a 00                	mov    (%eax),%al
  801a1e:	3c 30                	cmp    $0x30,%al
  801a20:	75 17                	jne    801a39 <strtol+0x78>
  801a22:	8b 45 08             	mov    0x8(%ebp),%eax
  801a25:	40                   	inc    %eax
  801a26:	8a 00                	mov    (%eax),%al
  801a28:	3c 78                	cmp    $0x78,%al
  801a2a:	75 0d                	jne    801a39 <strtol+0x78>
		s += 2, base = 16;
  801a2c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801a30:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801a37:	eb 28                	jmp    801a61 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801a39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a3d:	75 15                	jne    801a54 <strtol+0x93>
  801a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a42:	8a 00                	mov    (%eax),%al
  801a44:	3c 30                	cmp    $0x30,%al
  801a46:	75 0c                	jne    801a54 <strtol+0x93>
		s++, base = 8;
  801a48:	ff 45 08             	incl   0x8(%ebp)
  801a4b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801a52:	eb 0d                	jmp    801a61 <strtol+0xa0>
	else if (base == 0)
  801a54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a58:	75 07                	jne    801a61 <strtol+0xa0>
		base = 10;
  801a5a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801a61:	8b 45 08             	mov    0x8(%ebp),%eax
  801a64:	8a 00                	mov    (%eax),%al
  801a66:	3c 2f                	cmp    $0x2f,%al
  801a68:	7e 19                	jle    801a83 <strtol+0xc2>
  801a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6d:	8a 00                	mov    (%eax),%al
  801a6f:	3c 39                	cmp    $0x39,%al
  801a71:	7f 10                	jg     801a83 <strtol+0xc2>
			dig = *s - '0';
  801a73:	8b 45 08             	mov    0x8(%ebp),%eax
  801a76:	8a 00                	mov    (%eax),%al
  801a78:	0f be c0             	movsbl %al,%eax
  801a7b:	83 e8 30             	sub    $0x30,%eax
  801a7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a81:	eb 42                	jmp    801ac5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	8a 00                	mov    (%eax),%al
  801a88:	3c 60                	cmp    $0x60,%al
  801a8a:	7e 19                	jle    801aa5 <strtol+0xe4>
  801a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8f:	8a 00                	mov    (%eax),%al
  801a91:	3c 7a                	cmp    $0x7a,%al
  801a93:	7f 10                	jg     801aa5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a95:	8b 45 08             	mov    0x8(%ebp),%eax
  801a98:	8a 00                	mov    (%eax),%al
  801a9a:	0f be c0             	movsbl %al,%eax
  801a9d:	83 e8 57             	sub    $0x57,%eax
  801aa0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801aa3:	eb 20                	jmp    801ac5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa8:	8a 00                	mov    (%eax),%al
  801aaa:	3c 40                	cmp    $0x40,%al
  801aac:	7e 39                	jle    801ae7 <strtol+0x126>
  801aae:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab1:	8a 00                	mov    (%eax),%al
  801ab3:	3c 5a                	cmp    $0x5a,%al
  801ab5:	7f 30                	jg     801ae7 <strtol+0x126>
			dig = *s - 'A' + 10;
  801ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aba:	8a 00                	mov    (%eax),%al
  801abc:	0f be c0             	movsbl %al,%eax
  801abf:	83 e8 37             	sub    $0x37,%eax
  801ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ac8:	3b 45 10             	cmp    0x10(%ebp),%eax
  801acb:	7d 19                	jge    801ae6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801acd:	ff 45 08             	incl   0x8(%ebp)
  801ad0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ad3:	0f af 45 10          	imul   0x10(%ebp),%eax
  801ad7:	89 c2                	mov    %eax,%edx
  801ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801adc:	01 d0                	add    %edx,%eax
  801ade:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801ae1:	e9 7b ff ff ff       	jmp    801a61 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801ae6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801ae7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801aeb:	74 08                	je     801af5 <strtol+0x134>
		*endptr = (char *) s;
  801aed:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af0:	8b 55 08             	mov    0x8(%ebp),%edx
  801af3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801af5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801af9:	74 07                	je     801b02 <strtol+0x141>
  801afb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801afe:	f7 d8                	neg    %eax
  801b00:	eb 03                	jmp    801b05 <strtol+0x144>
  801b02:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801b05:	c9                   	leave  
  801b06:	c3                   	ret    

00801b07 <ltostr>:

void
ltostr(long value, char *str)
{
  801b07:	55                   	push   %ebp
  801b08:	89 e5                	mov    %esp,%ebp
  801b0a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801b0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801b14:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801b1b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b1f:	79 13                	jns    801b34 <ltostr+0x2d>
	{
		neg = 1;
  801b21:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801b28:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b2b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801b2e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801b31:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801b34:	8b 45 08             	mov    0x8(%ebp),%eax
  801b37:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801b3c:	99                   	cltd   
  801b3d:	f7 f9                	idiv   %ecx
  801b3f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801b42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b45:	8d 50 01             	lea    0x1(%eax),%edx
  801b48:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b4b:	89 c2                	mov    %eax,%edx
  801b4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b50:	01 d0                	add    %edx,%eax
  801b52:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b55:	83 c2 30             	add    $0x30,%edx
  801b58:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801b5a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b5d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b62:	f7 e9                	imul   %ecx
  801b64:	c1 fa 02             	sar    $0x2,%edx
  801b67:	89 c8                	mov    %ecx,%eax
  801b69:	c1 f8 1f             	sar    $0x1f,%eax
  801b6c:	29 c2                	sub    %eax,%edx
  801b6e:	89 d0                	mov    %edx,%eax
  801b70:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801b73:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b76:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b7b:	f7 e9                	imul   %ecx
  801b7d:	c1 fa 02             	sar    $0x2,%edx
  801b80:	89 c8                	mov    %ecx,%eax
  801b82:	c1 f8 1f             	sar    $0x1f,%eax
  801b85:	29 c2                	sub    %eax,%edx
  801b87:	89 d0                	mov    %edx,%eax
  801b89:	c1 e0 02             	shl    $0x2,%eax
  801b8c:	01 d0                	add    %edx,%eax
  801b8e:	01 c0                	add    %eax,%eax
  801b90:	29 c1                	sub    %eax,%ecx
  801b92:	89 ca                	mov    %ecx,%edx
  801b94:	85 d2                	test   %edx,%edx
  801b96:	75 9c                	jne    801b34 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ba2:	48                   	dec    %eax
  801ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801ba6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801baa:	74 3d                	je     801be9 <ltostr+0xe2>
		start = 1 ;
  801bac:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801bb3:	eb 34                	jmp    801be9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801bb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bbb:	01 d0                	add    %edx,%eax
  801bbd:	8a 00                	mov    (%eax),%al
  801bbf:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801bc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc8:	01 c2                	add    %eax,%edx
  801bca:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bd0:	01 c8                	add    %ecx,%eax
  801bd2:	8a 00                	mov    (%eax),%al
  801bd4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801bd6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bdc:	01 c2                	add    %eax,%edx
  801bde:	8a 45 eb             	mov    -0x15(%ebp),%al
  801be1:	88 02                	mov    %al,(%edx)
		start++ ;
  801be3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801be6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bef:	7c c4                	jl     801bb5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801bf1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801bf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bf7:	01 d0                	add    %edx,%eax
  801bf9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801bfc:	90                   	nop
  801bfd:	c9                   	leave  
  801bfe:	c3                   	ret    

00801bff <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
  801c02:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801c05:	ff 75 08             	pushl  0x8(%ebp)
  801c08:	e8 54 fa ff ff       	call   801661 <strlen>
  801c0d:	83 c4 04             	add    $0x4,%esp
  801c10:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801c13:	ff 75 0c             	pushl  0xc(%ebp)
  801c16:	e8 46 fa ff ff       	call   801661 <strlen>
  801c1b:	83 c4 04             	add    $0x4,%esp
  801c1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801c21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801c28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c2f:	eb 17                	jmp    801c48 <strcconcat+0x49>
		final[s] = str1[s] ;
  801c31:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c34:	8b 45 10             	mov    0x10(%ebp),%eax
  801c37:	01 c2                	add    %eax,%edx
  801c39:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3f:	01 c8                	add    %ecx,%eax
  801c41:	8a 00                	mov    (%eax),%al
  801c43:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801c45:	ff 45 fc             	incl   -0x4(%ebp)
  801c48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c4b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c4e:	7c e1                	jl     801c31 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801c50:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801c57:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801c5e:	eb 1f                	jmp    801c7f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801c60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c63:	8d 50 01             	lea    0x1(%eax),%edx
  801c66:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801c69:	89 c2                	mov    %eax,%edx
  801c6b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c6e:	01 c2                	add    %eax,%edx
  801c70:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801c73:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c76:	01 c8                	add    %ecx,%eax
  801c78:	8a 00                	mov    (%eax),%al
  801c7a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c7c:	ff 45 f8             	incl   -0x8(%ebp)
  801c7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c82:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c85:	7c d9                	jl     801c60 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c87:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c8a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c8d:	01 d0                	add    %edx,%eax
  801c8f:	c6 00 00             	movb   $0x0,(%eax)
}
  801c92:	90                   	nop
  801c93:	c9                   	leave  
  801c94:	c3                   	ret    

00801c95 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c95:	55                   	push   %ebp
  801c96:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c98:	8b 45 14             	mov    0x14(%ebp),%eax
  801c9b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ca1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ca4:	8b 00                	mov    (%eax),%eax
  801ca6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cad:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb0:	01 d0                	add    %edx,%eax
  801cb2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801cb8:	eb 0c                	jmp    801cc6 <strsplit+0x31>
			*string++ = 0;
  801cba:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbd:	8d 50 01             	lea    0x1(%eax),%edx
  801cc0:	89 55 08             	mov    %edx,0x8(%ebp)
  801cc3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc9:	8a 00                	mov    (%eax),%al
  801ccb:	84 c0                	test   %al,%al
  801ccd:	74 18                	je     801ce7 <strsplit+0x52>
  801ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd2:	8a 00                	mov    (%eax),%al
  801cd4:	0f be c0             	movsbl %al,%eax
  801cd7:	50                   	push   %eax
  801cd8:	ff 75 0c             	pushl  0xc(%ebp)
  801cdb:	e8 13 fb ff ff       	call   8017f3 <strchr>
  801ce0:	83 c4 08             	add    $0x8,%esp
  801ce3:	85 c0                	test   %eax,%eax
  801ce5:	75 d3                	jne    801cba <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cea:	8a 00                	mov    (%eax),%al
  801cec:	84 c0                	test   %al,%al
  801cee:	74 5a                	je     801d4a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801cf0:	8b 45 14             	mov    0x14(%ebp),%eax
  801cf3:	8b 00                	mov    (%eax),%eax
  801cf5:	83 f8 0f             	cmp    $0xf,%eax
  801cf8:	75 07                	jne    801d01 <strsplit+0x6c>
		{
			return 0;
  801cfa:	b8 00 00 00 00       	mov    $0x0,%eax
  801cff:	eb 66                	jmp    801d67 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801d01:	8b 45 14             	mov    0x14(%ebp),%eax
  801d04:	8b 00                	mov    (%eax),%eax
  801d06:	8d 48 01             	lea    0x1(%eax),%ecx
  801d09:	8b 55 14             	mov    0x14(%ebp),%edx
  801d0c:	89 0a                	mov    %ecx,(%edx)
  801d0e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d15:	8b 45 10             	mov    0x10(%ebp),%eax
  801d18:	01 c2                	add    %eax,%edx
  801d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d1f:	eb 03                	jmp    801d24 <strsplit+0x8f>
			string++;
  801d21:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d24:	8b 45 08             	mov    0x8(%ebp),%eax
  801d27:	8a 00                	mov    (%eax),%al
  801d29:	84 c0                	test   %al,%al
  801d2b:	74 8b                	je     801cb8 <strsplit+0x23>
  801d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d30:	8a 00                	mov    (%eax),%al
  801d32:	0f be c0             	movsbl %al,%eax
  801d35:	50                   	push   %eax
  801d36:	ff 75 0c             	pushl  0xc(%ebp)
  801d39:	e8 b5 fa ff ff       	call   8017f3 <strchr>
  801d3e:	83 c4 08             	add    $0x8,%esp
  801d41:	85 c0                	test   %eax,%eax
  801d43:	74 dc                	je     801d21 <strsplit+0x8c>
			string++;
	}
  801d45:	e9 6e ff ff ff       	jmp    801cb8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801d4a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801d4b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d4e:	8b 00                	mov    (%eax),%eax
  801d50:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d57:	8b 45 10             	mov    0x10(%ebp),%eax
  801d5a:	01 d0                	add    %edx,%eax
  801d5c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801d62:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
  801d6c:	83 ec 18             	sub    $0x18,%esp
  801d6f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d72:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801d75:	83 ec 04             	sub    $0x4,%esp
  801d78:	68 10 30 80 00       	push   $0x803010
  801d7d:	6a 17                	push   $0x17
  801d7f:	68 2f 30 80 00       	push   $0x80302f
  801d84:	e8 a2 ef ff ff       	call   800d2b <_panic>

00801d89 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d89:	55                   	push   %ebp
  801d8a:	89 e5                	mov    %esp,%ebp
  801d8c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801d8f:	83 ec 04             	sub    $0x4,%esp
  801d92:	68 3b 30 80 00       	push   $0x80303b
  801d97:	6a 2f                	push   $0x2f
  801d99:	68 2f 30 80 00       	push   $0x80302f
  801d9e:	e8 88 ef ff ff       	call   800d2b <_panic>

00801da3 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801da3:	55                   	push   %ebp
  801da4:	89 e5                	mov    %esp,%ebp
  801da6:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801da9:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801db0:	8b 55 08             	mov    0x8(%ebp),%edx
  801db3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801db6:	01 d0                	add    %edx,%eax
  801db8:	48                   	dec    %eax
  801db9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801dbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801dbf:	ba 00 00 00 00       	mov    $0x0,%edx
  801dc4:	f7 75 ec             	divl   -0x14(%ebp)
  801dc7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801dca:	29 d0                	sub    %edx,%eax
  801dcc:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd2:	c1 e8 0c             	shr    $0xc,%eax
  801dd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801dd8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ddf:	e9 c8 00 00 00       	jmp    801eac <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801de4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801deb:	eb 27                	jmp    801e14 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801ded:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801df3:	01 c2                	add    %eax,%edx
  801df5:	89 d0                	mov    %edx,%eax
  801df7:	01 c0                	add    %eax,%eax
  801df9:	01 d0                	add    %edx,%eax
  801dfb:	c1 e0 02             	shl    $0x2,%eax
  801dfe:	05 48 40 80 00       	add    $0x804048,%eax
  801e03:	8b 00                	mov    (%eax),%eax
  801e05:	85 c0                	test   %eax,%eax
  801e07:	74 08                	je     801e11 <malloc+0x6e>
            	i += j;
  801e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e0c:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801e0f:	eb 0b                	jmp    801e1c <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801e11:	ff 45 f0             	incl   -0x10(%ebp)
  801e14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e17:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e1a:	72 d1                	jb     801ded <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801e1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e1f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e22:	0f 85 81 00 00 00    	jne    801ea9 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801e28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e2b:	05 00 00 08 00       	add    $0x80000,%eax
  801e30:	c1 e0 0c             	shl    $0xc,%eax
  801e33:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801e36:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e3d:	eb 1f                	jmp    801e5e <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801e3f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e45:	01 c2                	add    %eax,%edx
  801e47:	89 d0                	mov    %edx,%eax
  801e49:	01 c0                	add    %eax,%eax
  801e4b:	01 d0                	add    %edx,%eax
  801e4d:	c1 e0 02             	shl    $0x2,%eax
  801e50:	05 48 40 80 00       	add    $0x804048,%eax
  801e55:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801e5b:	ff 45 f0             	incl   -0x10(%ebp)
  801e5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e61:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e64:	72 d9                	jb     801e3f <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801e66:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e69:	89 d0                	mov    %edx,%eax
  801e6b:	01 c0                	add    %eax,%eax
  801e6d:	01 d0                	add    %edx,%eax
  801e6f:	c1 e0 02             	shl    $0x2,%eax
  801e72:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  801e78:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e7b:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801e7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801e80:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801e83:	89 c8                	mov    %ecx,%eax
  801e85:	01 c0                	add    %eax,%eax
  801e87:	01 c8                	add    %ecx,%eax
  801e89:	c1 e0 02             	shl    $0x2,%eax
  801e8c:	05 44 40 80 00       	add    $0x804044,%eax
  801e91:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801e93:	83 ec 08             	sub    $0x8,%esp
  801e96:	ff 75 08             	pushl  0x8(%ebp)
  801e99:	ff 75 e0             	pushl  -0x20(%ebp)
  801e9c:	e8 2b 03 00 00       	call   8021cc <sys_allocateMem>
  801ea1:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801ea4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ea7:	eb 19                	jmp    801ec2 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801ea9:	ff 45 f4             	incl   -0xc(%ebp)
  801eac:	a1 04 40 80 00       	mov    0x804004,%eax
  801eb1:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801eb4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801eb7:	0f 83 27 ff ff ff    	jae    801de4 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801ebd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ec2:	c9                   	leave  
  801ec3:	c3                   	ret    

00801ec4 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801ec4:	55                   	push   %ebp
  801ec5:	89 e5                	mov    %esp,%ebp
  801ec7:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801eca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801ece:	0f 84 e5 00 00 00    	je     801fb9 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801eda:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801edd:	05 00 00 00 80       	add    $0x80000000,%eax
  801ee2:	c1 e8 0c             	shr    $0xc,%eax
  801ee5:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801ee8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801eeb:	89 d0                	mov    %edx,%eax
  801eed:	01 c0                	add    %eax,%eax
  801eef:	01 d0                	add    %edx,%eax
  801ef1:	c1 e0 02             	shl    $0x2,%eax
  801ef4:	05 40 40 80 00       	add    $0x804040,%eax
  801ef9:	8b 00                	mov    (%eax),%eax
  801efb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801efe:	0f 85 b8 00 00 00    	jne    801fbc <free+0xf8>
  801f04:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f07:	89 d0                	mov    %edx,%eax
  801f09:	01 c0                	add    %eax,%eax
  801f0b:	01 d0                	add    %edx,%eax
  801f0d:	c1 e0 02             	shl    $0x2,%eax
  801f10:	05 48 40 80 00       	add    $0x804048,%eax
  801f15:	8b 00                	mov    (%eax),%eax
  801f17:	85 c0                	test   %eax,%eax
  801f19:	0f 84 9d 00 00 00    	je     801fbc <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801f1f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f22:	89 d0                	mov    %edx,%eax
  801f24:	01 c0                	add    %eax,%eax
  801f26:	01 d0                	add    %edx,%eax
  801f28:	c1 e0 02             	shl    $0x2,%eax
  801f2b:	05 44 40 80 00       	add    $0x804044,%eax
  801f30:	8b 00                	mov    (%eax),%eax
  801f32:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801f35:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801f38:	c1 e0 0c             	shl    $0xc,%eax
  801f3b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801f3e:	83 ec 08             	sub    $0x8,%esp
  801f41:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f44:	ff 75 f0             	pushl  -0x10(%ebp)
  801f47:	e8 64 02 00 00       	call   8021b0 <sys_freeMem>
  801f4c:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801f4f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801f56:	eb 57                	jmp    801faf <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801f58:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f5e:	01 c2                	add    %eax,%edx
  801f60:	89 d0                	mov    %edx,%eax
  801f62:	01 c0                	add    %eax,%eax
  801f64:	01 d0                	add    %edx,%eax
  801f66:	c1 e0 02             	shl    $0x2,%eax
  801f69:	05 48 40 80 00       	add    $0x804048,%eax
  801f6e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801f74:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f7a:	01 c2                	add    %eax,%edx
  801f7c:	89 d0                	mov    %edx,%eax
  801f7e:	01 c0                	add    %eax,%eax
  801f80:	01 d0                	add    %edx,%eax
  801f82:	c1 e0 02             	shl    $0x2,%eax
  801f85:	05 40 40 80 00       	add    $0x804040,%eax
  801f8a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801f90:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801f93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f96:	01 c2                	add    %eax,%edx
  801f98:	89 d0                	mov    %edx,%eax
  801f9a:	01 c0                	add    %eax,%eax
  801f9c:	01 d0                	add    %edx,%eax
  801f9e:	c1 e0 02             	shl    $0x2,%eax
  801fa1:	05 44 40 80 00       	add    $0x804044,%eax
  801fa6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801fac:	ff 45 f4             	incl   -0xc(%ebp)
  801faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801fb2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801fb5:	7c a1                	jl     801f58 <free+0x94>
  801fb7:	eb 04                	jmp    801fbd <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801fb9:	90                   	nop
  801fba:	eb 01                	jmp    801fbd <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801fbc:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801fbd:	c9                   	leave  
  801fbe:	c3                   	ret    

00801fbf <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801fbf:	55                   	push   %ebp
  801fc0:	89 e5                	mov    %esp,%ebp
  801fc2:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801fc5:	83 ec 04             	sub    $0x4,%esp
  801fc8:	68 58 30 80 00       	push   $0x803058
  801fcd:	68 ae 00 00 00       	push   $0xae
  801fd2:	68 2f 30 80 00       	push   $0x80302f
  801fd7:	e8 4f ed ff ff       	call   800d2b <_panic>

00801fdc <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801fdc:	55                   	push   %ebp
  801fdd:	89 e5                	mov    %esp,%ebp
  801fdf:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801fe2:	83 ec 04             	sub    $0x4,%esp
  801fe5:	68 78 30 80 00       	push   $0x803078
  801fea:	68 ca 00 00 00       	push   $0xca
  801fef:	68 2f 30 80 00       	push   $0x80302f
  801ff4:	e8 32 ed ff ff       	call   800d2b <_panic>

00801ff9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ff9:	55                   	push   %ebp
  801ffa:	89 e5                	mov    %esp,%ebp
  801ffc:	57                   	push   %edi
  801ffd:	56                   	push   %esi
  801ffe:	53                   	push   %ebx
  801fff:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802002:	8b 45 08             	mov    0x8(%ebp),%eax
  802005:	8b 55 0c             	mov    0xc(%ebp),%edx
  802008:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80200b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80200e:	8b 7d 18             	mov    0x18(%ebp),%edi
  802011:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802014:	cd 30                	int    $0x30
  802016:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802019:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80201c:	83 c4 10             	add    $0x10,%esp
  80201f:	5b                   	pop    %ebx
  802020:	5e                   	pop    %esi
  802021:	5f                   	pop    %edi
  802022:	5d                   	pop    %ebp
  802023:	c3                   	ret    

00802024 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802024:	55                   	push   %ebp
  802025:	89 e5                	mov    %esp,%ebp
  802027:	83 ec 04             	sub    $0x4,%esp
  80202a:	8b 45 10             	mov    0x10(%ebp),%eax
  80202d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802030:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802034:	8b 45 08             	mov    0x8(%ebp),%eax
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	52                   	push   %edx
  80203c:	ff 75 0c             	pushl  0xc(%ebp)
  80203f:	50                   	push   %eax
  802040:	6a 00                	push   $0x0
  802042:	e8 b2 ff ff ff       	call   801ff9 <syscall>
  802047:	83 c4 18             	add    $0x18,%esp
}
  80204a:	90                   	nop
  80204b:	c9                   	leave  
  80204c:	c3                   	ret    

0080204d <sys_cgetc>:

int
sys_cgetc(void)
{
  80204d:	55                   	push   %ebp
  80204e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 01                	push   $0x1
  80205c:	e8 98 ff ff ff       	call   801ff9 <syscall>
  802061:	83 c4 18             	add    $0x18,%esp
}
  802064:	c9                   	leave  
  802065:	c3                   	ret    

00802066 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802066:	55                   	push   %ebp
  802067:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802069:	8b 45 08             	mov    0x8(%ebp),%eax
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	50                   	push   %eax
  802075:	6a 05                	push   $0x5
  802077:	e8 7d ff ff ff       	call   801ff9 <syscall>
  80207c:	83 c4 18             	add    $0x18,%esp
}
  80207f:	c9                   	leave  
  802080:	c3                   	ret    

00802081 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802081:	55                   	push   %ebp
  802082:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 02                	push   $0x2
  802090:	e8 64 ff ff ff       	call   801ff9 <syscall>
  802095:	83 c4 18             	add    $0x18,%esp
}
  802098:	c9                   	leave  
  802099:	c3                   	ret    

0080209a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80209a:	55                   	push   %ebp
  80209b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 03                	push   $0x3
  8020a9:	e8 4b ff ff ff       	call   801ff9 <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 04                	push   $0x4
  8020c2:	e8 32 ff ff ff       	call   801ff9 <syscall>
  8020c7:	83 c4 18             	add    $0x18,%esp
}
  8020ca:	c9                   	leave  
  8020cb:	c3                   	ret    

008020cc <sys_env_exit>:


void sys_env_exit(void)
{
  8020cc:	55                   	push   %ebp
  8020cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 06                	push   $0x6
  8020db:	e8 19 ff ff ff       	call   801ff9 <syscall>
  8020e0:	83 c4 18             	add    $0x18,%esp
}
  8020e3:	90                   	nop
  8020e4:	c9                   	leave  
  8020e5:	c3                   	ret    

008020e6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8020e6:	55                   	push   %ebp
  8020e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8020e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	52                   	push   %edx
  8020f6:	50                   	push   %eax
  8020f7:	6a 07                	push   $0x7
  8020f9:	e8 fb fe ff ff       	call   801ff9 <syscall>
  8020fe:	83 c4 18             	add    $0x18,%esp
}
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
  802106:	56                   	push   %esi
  802107:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802108:	8b 75 18             	mov    0x18(%ebp),%esi
  80210b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80210e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802111:	8b 55 0c             	mov    0xc(%ebp),%edx
  802114:	8b 45 08             	mov    0x8(%ebp),%eax
  802117:	56                   	push   %esi
  802118:	53                   	push   %ebx
  802119:	51                   	push   %ecx
  80211a:	52                   	push   %edx
  80211b:	50                   	push   %eax
  80211c:	6a 08                	push   $0x8
  80211e:	e8 d6 fe ff ff       	call   801ff9 <syscall>
  802123:	83 c4 18             	add    $0x18,%esp
}
  802126:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802129:	5b                   	pop    %ebx
  80212a:	5e                   	pop    %esi
  80212b:	5d                   	pop    %ebp
  80212c:	c3                   	ret    

0080212d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80212d:	55                   	push   %ebp
  80212e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802130:	8b 55 0c             	mov    0xc(%ebp),%edx
  802133:	8b 45 08             	mov    0x8(%ebp),%eax
  802136:	6a 00                	push   $0x0
  802138:	6a 00                	push   $0x0
  80213a:	6a 00                	push   $0x0
  80213c:	52                   	push   %edx
  80213d:	50                   	push   %eax
  80213e:	6a 09                	push   $0x9
  802140:	e8 b4 fe ff ff       	call   801ff9 <syscall>
  802145:	83 c4 18             	add    $0x18,%esp
}
  802148:	c9                   	leave  
  802149:	c3                   	ret    

0080214a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80214a:	55                   	push   %ebp
  80214b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	ff 75 0c             	pushl  0xc(%ebp)
  802156:	ff 75 08             	pushl  0x8(%ebp)
  802159:	6a 0a                	push   $0xa
  80215b:	e8 99 fe ff ff       	call   801ff9 <syscall>
  802160:	83 c4 18             	add    $0x18,%esp
}
  802163:	c9                   	leave  
  802164:	c3                   	ret    

00802165 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802165:	55                   	push   %ebp
  802166:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 0b                	push   $0xb
  802174:	e8 80 fe ff ff       	call   801ff9 <syscall>
  802179:	83 c4 18             	add    $0x18,%esp
}
  80217c:	c9                   	leave  
  80217d:	c3                   	ret    

0080217e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80217e:	55                   	push   %ebp
  80217f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 0c                	push   $0xc
  80218d:	e8 67 fe ff ff       	call   801ff9 <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80219a:	6a 00                	push   $0x0
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 0d                	push   $0xd
  8021a6:	e8 4e fe ff ff       	call   801ff9 <syscall>
  8021ab:	83 c4 18             	add    $0x18,%esp
}
  8021ae:	c9                   	leave  
  8021af:	c3                   	ret    

008021b0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8021b0:	55                   	push   %ebp
  8021b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	ff 75 0c             	pushl  0xc(%ebp)
  8021bc:	ff 75 08             	pushl  0x8(%ebp)
  8021bf:	6a 11                	push   $0x11
  8021c1:	e8 33 fe ff ff       	call   801ff9 <syscall>
  8021c6:	83 c4 18             	add    $0x18,%esp
	return;
  8021c9:	90                   	nop
}
  8021ca:	c9                   	leave  
  8021cb:	c3                   	ret    

008021cc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8021cc:	55                   	push   %ebp
  8021cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	ff 75 0c             	pushl  0xc(%ebp)
  8021d8:	ff 75 08             	pushl  0x8(%ebp)
  8021db:	6a 12                	push   $0x12
  8021dd:	e8 17 fe ff ff       	call   801ff9 <syscall>
  8021e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e5:	90                   	nop
}
  8021e6:	c9                   	leave  
  8021e7:	c3                   	ret    

008021e8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8021e8:	55                   	push   %ebp
  8021e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	6a 0e                	push   $0xe
  8021f7:	e8 fd fd ff ff       	call   801ff9 <syscall>
  8021fc:	83 c4 18             	add    $0x18,%esp
}
  8021ff:	c9                   	leave  
  802200:	c3                   	ret    

00802201 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802201:	55                   	push   %ebp
  802202:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	ff 75 08             	pushl  0x8(%ebp)
  80220f:	6a 0f                	push   $0xf
  802211:	e8 e3 fd ff ff       	call   801ff9 <syscall>
  802216:	83 c4 18             	add    $0x18,%esp
}
  802219:	c9                   	leave  
  80221a:	c3                   	ret    

0080221b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80221b:	55                   	push   %ebp
  80221c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80221e:	6a 00                	push   $0x0
  802220:	6a 00                	push   $0x0
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	6a 00                	push   $0x0
  802228:	6a 10                	push   $0x10
  80222a:	e8 ca fd ff ff       	call   801ff9 <syscall>
  80222f:	83 c4 18             	add    $0x18,%esp
}
  802232:	90                   	nop
  802233:	c9                   	leave  
  802234:	c3                   	ret    

00802235 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802235:	55                   	push   %ebp
  802236:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 14                	push   $0x14
  802244:	e8 b0 fd ff ff       	call   801ff9 <syscall>
  802249:	83 c4 18             	add    $0x18,%esp
}
  80224c:	90                   	nop
  80224d:	c9                   	leave  
  80224e:	c3                   	ret    

0080224f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80224f:	55                   	push   %ebp
  802250:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 15                	push   $0x15
  80225e:	e8 96 fd ff ff       	call   801ff9 <syscall>
  802263:	83 c4 18             	add    $0x18,%esp
}
  802266:	90                   	nop
  802267:	c9                   	leave  
  802268:	c3                   	ret    

00802269 <sys_cputc>:


void
sys_cputc(const char c)
{
  802269:	55                   	push   %ebp
  80226a:	89 e5                	mov    %esp,%ebp
  80226c:	83 ec 04             	sub    $0x4,%esp
  80226f:	8b 45 08             	mov    0x8(%ebp),%eax
  802272:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802275:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	50                   	push   %eax
  802282:	6a 16                	push   $0x16
  802284:	e8 70 fd ff ff       	call   801ff9 <syscall>
  802289:	83 c4 18             	add    $0x18,%esp
}
  80228c:	90                   	nop
  80228d:	c9                   	leave  
  80228e:	c3                   	ret    

0080228f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80228f:	55                   	push   %ebp
  802290:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	6a 17                	push   $0x17
  80229e:	e8 56 fd ff ff       	call   801ff9 <syscall>
  8022a3:	83 c4 18             	add    $0x18,%esp
}
  8022a6:	90                   	nop
  8022a7:	c9                   	leave  
  8022a8:	c3                   	ret    

008022a9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8022a9:	55                   	push   %ebp
  8022aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8022ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	ff 75 0c             	pushl  0xc(%ebp)
  8022b8:	50                   	push   %eax
  8022b9:	6a 18                	push   $0x18
  8022bb:	e8 39 fd ff ff       	call   801ff9 <syscall>
  8022c0:	83 c4 18             	add    $0x18,%esp
}
  8022c3:	c9                   	leave  
  8022c4:	c3                   	ret    

008022c5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8022c5:	55                   	push   %ebp
  8022c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ce:	6a 00                	push   $0x0
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 00                	push   $0x0
  8022d4:	52                   	push   %edx
  8022d5:	50                   	push   %eax
  8022d6:	6a 1b                	push   $0x1b
  8022d8:	e8 1c fd ff ff       	call   801ff9 <syscall>
  8022dd:	83 c4 18             	add    $0x18,%esp
}
  8022e0:	c9                   	leave  
  8022e1:	c3                   	ret    

008022e2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022e2:	55                   	push   %ebp
  8022e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 00                	push   $0x0
  8022ef:	6a 00                	push   $0x0
  8022f1:	52                   	push   %edx
  8022f2:	50                   	push   %eax
  8022f3:	6a 19                	push   $0x19
  8022f5:	e8 ff fc ff ff       	call   801ff9 <syscall>
  8022fa:	83 c4 18             	add    $0x18,%esp
}
  8022fd:	90                   	nop
  8022fe:	c9                   	leave  
  8022ff:	c3                   	ret    

00802300 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802300:	55                   	push   %ebp
  802301:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802303:	8b 55 0c             	mov    0xc(%ebp),%edx
  802306:	8b 45 08             	mov    0x8(%ebp),%eax
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	52                   	push   %edx
  802310:	50                   	push   %eax
  802311:	6a 1a                	push   $0x1a
  802313:	e8 e1 fc ff ff       	call   801ff9 <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
}
  80231b:	90                   	nop
  80231c:	c9                   	leave  
  80231d:	c3                   	ret    

0080231e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80231e:	55                   	push   %ebp
  80231f:	89 e5                	mov    %esp,%ebp
  802321:	83 ec 04             	sub    $0x4,%esp
  802324:	8b 45 10             	mov    0x10(%ebp),%eax
  802327:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80232a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80232d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802331:	8b 45 08             	mov    0x8(%ebp),%eax
  802334:	6a 00                	push   $0x0
  802336:	51                   	push   %ecx
  802337:	52                   	push   %edx
  802338:	ff 75 0c             	pushl  0xc(%ebp)
  80233b:	50                   	push   %eax
  80233c:	6a 1c                	push   $0x1c
  80233e:	e8 b6 fc ff ff       	call   801ff9 <syscall>
  802343:	83 c4 18             	add    $0x18,%esp
}
  802346:	c9                   	leave  
  802347:	c3                   	ret    

00802348 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802348:	55                   	push   %ebp
  802349:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80234b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80234e:	8b 45 08             	mov    0x8(%ebp),%eax
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	52                   	push   %edx
  802358:	50                   	push   %eax
  802359:	6a 1d                	push   $0x1d
  80235b:	e8 99 fc ff ff       	call   801ff9 <syscall>
  802360:	83 c4 18             	add    $0x18,%esp
}
  802363:	c9                   	leave  
  802364:	c3                   	ret    

00802365 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802365:	55                   	push   %ebp
  802366:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802368:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80236b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80236e:	8b 45 08             	mov    0x8(%ebp),%eax
  802371:	6a 00                	push   $0x0
  802373:	6a 00                	push   $0x0
  802375:	51                   	push   %ecx
  802376:	52                   	push   %edx
  802377:	50                   	push   %eax
  802378:	6a 1e                	push   $0x1e
  80237a:	e8 7a fc ff ff       	call   801ff9 <syscall>
  80237f:	83 c4 18             	add    $0x18,%esp
}
  802382:	c9                   	leave  
  802383:	c3                   	ret    

00802384 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802384:	55                   	push   %ebp
  802385:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80238a:	8b 45 08             	mov    0x8(%ebp),%eax
  80238d:	6a 00                	push   $0x0
  80238f:	6a 00                	push   $0x0
  802391:	6a 00                	push   $0x0
  802393:	52                   	push   %edx
  802394:	50                   	push   %eax
  802395:	6a 1f                	push   $0x1f
  802397:	e8 5d fc ff ff       	call   801ff9 <syscall>
  80239c:	83 c4 18             	add    $0x18,%esp
}
  80239f:	c9                   	leave  
  8023a0:	c3                   	ret    

008023a1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8023a1:	55                   	push   %ebp
  8023a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8023a4:	6a 00                	push   $0x0
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 00                	push   $0x0
  8023aa:	6a 00                	push   $0x0
  8023ac:	6a 00                	push   $0x0
  8023ae:	6a 20                	push   $0x20
  8023b0:	e8 44 fc ff ff       	call   801ff9 <syscall>
  8023b5:	83 c4 18             	add    $0x18,%esp
}
  8023b8:	c9                   	leave  
  8023b9:	c3                   	ret    

008023ba <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8023ba:	55                   	push   %ebp
  8023bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8023bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 00                	push   $0x0
  8023c4:	ff 75 10             	pushl  0x10(%ebp)
  8023c7:	ff 75 0c             	pushl  0xc(%ebp)
  8023ca:	50                   	push   %eax
  8023cb:	6a 21                	push   $0x21
  8023cd:	e8 27 fc ff ff       	call   801ff9 <syscall>
  8023d2:	83 c4 18             	add    $0x18,%esp
}
  8023d5:	c9                   	leave  
  8023d6:	c3                   	ret    

008023d7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8023d7:	55                   	push   %ebp
  8023d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8023da:	8b 45 08             	mov    0x8(%ebp),%eax
  8023dd:	6a 00                	push   $0x0
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 00                	push   $0x0
  8023e5:	50                   	push   %eax
  8023e6:	6a 22                	push   $0x22
  8023e8:	e8 0c fc ff ff       	call   801ff9 <syscall>
  8023ed:	83 c4 18             	add    $0x18,%esp
}
  8023f0:	90                   	nop
  8023f1:	c9                   	leave  
  8023f2:	c3                   	ret    

008023f3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8023f3:	55                   	push   %ebp
  8023f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8023f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	6a 00                	push   $0x0
  802401:	50                   	push   %eax
  802402:	6a 23                	push   $0x23
  802404:	e8 f0 fb ff ff       	call   801ff9 <syscall>
  802409:	83 c4 18             	add    $0x18,%esp
}
  80240c:	90                   	nop
  80240d:	c9                   	leave  
  80240e:	c3                   	ret    

0080240f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80240f:	55                   	push   %ebp
  802410:	89 e5                	mov    %esp,%ebp
  802412:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802415:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802418:	8d 50 04             	lea    0x4(%eax),%edx
  80241b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80241e:	6a 00                	push   $0x0
  802420:	6a 00                	push   $0x0
  802422:	6a 00                	push   $0x0
  802424:	52                   	push   %edx
  802425:	50                   	push   %eax
  802426:	6a 24                	push   $0x24
  802428:	e8 cc fb ff ff       	call   801ff9 <syscall>
  80242d:	83 c4 18             	add    $0x18,%esp
	return result;
  802430:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802433:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802436:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802439:	89 01                	mov    %eax,(%ecx)
  80243b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80243e:	8b 45 08             	mov    0x8(%ebp),%eax
  802441:	c9                   	leave  
  802442:	c2 04 00             	ret    $0x4

00802445 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802445:	55                   	push   %ebp
  802446:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802448:	6a 00                	push   $0x0
  80244a:	6a 00                	push   $0x0
  80244c:	ff 75 10             	pushl  0x10(%ebp)
  80244f:	ff 75 0c             	pushl  0xc(%ebp)
  802452:	ff 75 08             	pushl  0x8(%ebp)
  802455:	6a 13                	push   $0x13
  802457:	e8 9d fb ff ff       	call   801ff9 <syscall>
  80245c:	83 c4 18             	add    $0x18,%esp
	return ;
  80245f:	90                   	nop
}
  802460:	c9                   	leave  
  802461:	c3                   	ret    

00802462 <sys_rcr2>:
uint32 sys_rcr2()
{
  802462:	55                   	push   %ebp
  802463:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802465:	6a 00                	push   $0x0
  802467:	6a 00                	push   $0x0
  802469:	6a 00                	push   $0x0
  80246b:	6a 00                	push   $0x0
  80246d:	6a 00                	push   $0x0
  80246f:	6a 25                	push   $0x25
  802471:	e8 83 fb ff ff       	call   801ff9 <syscall>
  802476:	83 c4 18             	add    $0x18,%esp
}
  802479:	c9                   	leave  
  80247a:	c3                   	ret    

0080247b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80247b:	55                   	push   %ebp
  80247c:	89 e5                	mov    %esp,%ebp
  80247e:	83 ec 04             	sub    $0x4,%esp
  802481:	8b 45 08             	mov    0x8(%ebp),%eax
  802484:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802487:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80248b:	6a 00                	push   $0x0
  80248d:	6a 00                	push   $0x0
  80248f:	6a 00                	push   $0x0
  802491:	6a 00                	push   $0x0
  802493:	50                   	push   %eax
  802494:	6a 26                	push   $0x26
  802496:	e8 5e fb ff ff       	call   801ff9 <syscall>
  80249b:	83 c4 18             	add    $0x18,%esp
	return ;
  80249e:	90                   	nop
}
  80249f:	c9                   	leave  
  8024a0:	c3                   	ret    

008024a1 <rsttst>:
void rsttst()
{
  8024a1:	55                   	push   %ebp
  8024a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8024a4:	6a 00                	push   $0x0
  8024a6:	6a 00                	push   $0x0
  8024a8:	6a 00                	push   $0x0
  8024aa:	6a 00                	push   $0x0
  8024ac:	6a 00                	push   $0x0
  8024ae:	6a 28                	push   $0x28
  8024b0:	e8 44 fb ff ff       	call   801ff9 <syscall>
  8024b5:	83 c4 18             	add    $0x18,%esp
	return ;
  8024b8:	90                   	nop
}
  8024b9:	c9                   	leave  
  8024ba:	c3                   	ret    

008024bb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8024bb:	55                   	push   %ebp
  8024bc:	89 e5                	mov    %esp,%ebp
  8024be:	83 ec 04             	sub    $0x4,%esp
  8024c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8024c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8024c7:	8b 55 18             	mov    0x18(%ebp),%edx
  8024ca:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8024ce:	52                   	push   %edx
  8024cf:	50                   	push   %eax
  8024d0:	ff 75 10             	pushl  0x10(%ebp)
  8024d3:	ff 75 0c             	pushl  0xc(%ebp)
  8024d6:	ff 75 08             	pushl  0x8(%ebp)
  8024d9:	6a 27                	push   $0x27
  8024db:	e8 19 fb ff ff       	call   801ff9 <syscall>
  8024e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8024e3:	90                   	nop
}
  8024e4:	c9                   	leave  
  8024e5:	c3                   	ret    

008024e6 <chktst>:
void chktst(uint32 n)
{
  8024e6:	55                   	push   %ebp
  8024e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8024e9:	6a 00                	push   $0x0
  8024eb:	6a 00                	push   $0x0
  8024ed:	6a 00                	push   $0x0
  8024ef:	6a 00                	push   $0x0
  8024f1:	ff 75 08             	pushl  0x8(%ebp)
  8024f4:	6a 29                	push   $0x29
  8024f6:	e8 fe fa ff ff       	call   801ff9 <syscall>
  8024fb:	83 c4 18             	add    $0x18,%esp
	return ;
  8024fe:	90                   	nop
}
  8024ff:	c9                   	leave  
  802500:	c3                   	ret    

00802501 <inctst>:

void inctst()
{
  802501:	55                   	push   %ebp
  802502:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802504:	6a 00                	push   $0x0
  802506:	6a 00                	push   $0x0
  802508:	6a 00                	push   $0x0
  80250a:	6a 00                	push   $0x0
  80250c:	6a 00                	push   $0x0
  80250e:	6a 2a                	push   $0x2a
  802510:	e8 e4 fa ff ff       	call   801ff9 <syscall>
  802515:	83 c4 18             	add    $0x18,%esp
	return ;
  802518:	90                   	nop
}
  802519:	c9                   	leave  
  80251a:	c3                   	ret    

0080251b <gettst>:
uint32 gettst()
{
  80251b:	55                   	push   %ebp
  80251c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80251e:	6a 00                	push   $0x0
  802520:	6a 00                	push   $0x0
  802522:	6a 00                	push   $0x0
  802524:	6a 00                	push   $0x0
  802526:	6a 00                	push   $0x0
  802528:	6a 2b                	push   $0x2b
  80252a:	e8 ca fa ff ff       	call   801ff9 <syscall>
  80252f:	83 c4 18             	add    $0x18,%esp
}
  802532:	c9                   	leave  
  802533:	c3                   	ret    

00802534 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802534:	55                   	push   %ebp
  802535:	89 e5                	mov    %esp,%ebp
  802537:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80253a:	6a 00                	push   $0x0
  80253c:	6a 00                	push   $0x0
  80253e:	6a 00                	push   $0x0
  802540:	6a 00                	push   $0x0
  802542:	6a 00                	push   $0x0
  802544:	6a 2c                	push   $0x2c
  802546:	e8 ae fa ff ff       	call   801ff9 <syscall>
  80254b:	83 c4 18             	add    $0x18,%esp
  80254e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802551:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802555:	75 07                	jne    80255e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802557:	b8 01 00 00 00       	mov    $0x1,%eax
  80255c:	eb 05                	jmp    802563 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80255e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802563:	c9                   	leave  
  802564:	c3                   	ret    

00802565 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802565:	55                   	push   %ebp
  802566:	89 e5                	mov    %esp,%ebp
  802568:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80256b:	6a 00                	push   $0x0
  80256d:	6a 00                	push   $0x0
  80256f:	6a 00                	push   $0x0
  802571:	6a 00                	push   $0x0
  802573:	6a 00                	push   $0x0
  802575:	6a 2c                	push   $0x2c
  802577:	e8 7d fa ff ff       	call   801ff9 <syscall>
  80257c:	83 c4 18             	add    $0x18,%esp
  80257f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802582:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802586:	75 07                	jne    80258f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802588:	b8 01 00 00 00       	mov    $0x1,%eax
  80258d:	eb 05                	jmp    802594 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80258f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802594:	c9                   	leave  
  802595:	c3                   	ret    

00802596 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802596:	55                   	push   %ebp
  802597:	89 e5                	mov    %esp,%ebp
  802599:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80259c:	6a 00                	push   $0x0
  80259e:	6a 00                	push   $0x0
  8025a0:	6a 00                	push   $0x0
  8025a2:	6a 00                	push   $0x0
  8025a4:	6a 00                	push   $0x0
  8025a6:	6a 2c                	push   $0x2c
  8025a8:	e8 4c fa ff ff       	call   801ff9 <syscall>
  8025ad:	83 c4 18             	add    $0x18,%esp
  8025b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8025b3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8025b7:	75 07                	jne    8025c0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8025b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8025be:	eb 05                	jmp    8025c5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8025c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025c5:	c9                   	leave  
  8025c6:	c3                   	ret    

008025c7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8025c7:	55                   	push   %ebp
  8025c8:	89 e5                	mov    %esp,%ebp
  8025ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025cd:	6a 00                	push   $0x0
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 00                	push   $0x0
  8025d5:	6a 00                	push   $0x0
  8025d7:	6a 2c                	push   $0x2c
  8025d9:	e8 1b fa ff ff       	call   801ff9 <syscall>
  8025de:	83 c4 18             	add    $0x18,%esp
  8025e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8025e4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8025e8:	75 07                	jne    8025f1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8025ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8025ef:	eb 05                	jmp    8025f6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8025f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025f6:	c9                   	leave  
  8025f7:	c3                   	ret    

008025f8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8025f8:	55                   	push   %ebp
  8025f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8025fb:	6a 00                	push   $0x0
  8025fd:	6a 00                	push   $0x0
  8025ff:	6a 00                	push   $0x0
  802601:	6a 00                	push   $0x0
  802603:	ff 75 08             	pushl  0x8(%ebp)
  802606:	6a 2d                	push   $0x2d
  802608:	e8 ec f9 ff ff       	call   801ff9 <syscall>
  80260d:	83 c4 18             	add    $0x18,%esp
	return ;
  802610:	90                   	nop
}
  802611:	c9                   	leave  
  802612:	c3                   	ret    
  802613:	90                   	nop

00802614 <__udivdi3>:
  802614:	55                   	push   %ebp
  802615:	57                   	push   %edi
  802616:	56                   	push   %esi
  802617:	53                   	push   %ebx
  802618:	83 ec 1c             	sub    $0x1c,%esp
  80261b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80261f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802623:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802627:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80262b:	89 ca                	mov    %ecx,%edx
  80262d:	89 f8                	mov    %edi,%eax
  80262f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802633:	85 f6                	test   %esi,%esi
  802635:	75 2d                	jne    802664 <__udivdi3+0x50>
  802637:	39 cf                	cmp    %ecx,%edi
  802639:	77 65                	ja     8026a0 <__udivdi3+0x8c>
  80263b:	89 fd                	mov    %edi,%ebp
  80263d:	85 ff                	test   %edi,%edi
  80263f:	75 0b                	jne    80264c <__udivdi3+0x38>
  802641:	b8 01 00 00 00       	mov    $0x1,%eax
  802646:	31 d2                	xor    %edx,%edx
  802648:	f7 f7                	div    %edi
  80264a:	89 c5                	mov    %eax,%ebp
  80264c:	31 d2                	xor    %edx,%edx
  80264e:	89 c8                	mov    %ecx,%eax
  802650:	f7 f5                	div    %ebp
  802652:	89 c1                	mov    %eax,%ecx
  802654:	89 d8                	mov    %ebx,%eax
  802656:	f7 f5                	div    %ebp
  802658:	89 cf                	mov    %ecx,%edi
  80265a:	89 fa                	mov    %edi,%edx
  80265c:	83 c4 1c             	add    $0x1c,%esp
  80265f:	5b                   	pop    %ebx
  802660:	5e                   	pop    %esi
  802661:	5f                   	pop    %edi
  802662:	5d                   	pop    %ebp
  802663:	c3                   	ret    
  802664:	39 ce                	cmp    %ecx,%esi
  802666:	77 28                	ja     802690 <__udivdi3+0x7c>
  802668:	0f bd fe             	bsr    %esi,%edi
  80266b:	83 f7 1f             	xor    $0x1f,%edi
  80266e:	75 40                	jne    8026b0 <__udivdi3+0x9c>
  802670:	39 ce                	cmp    %ecx,%esi
  802672:	72 0a                	jb     80267e <__udivdi3+0x6a>
  802674:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802678:	0f 87 9e 00 00 00    	ja     80271c <__udivdi3+0x108>
  80267e:	b8 01 00 00 00       	mov    $0x1,%eax
  802683:	89 fa                	mov    %edi,%edx
  802685:	83 c4 1c             	add    $0x1c,%esp
  802688:	5b                   	pop    %ebx
  802689:	5e                   	pop    %esi
  80268a:	5f                   	pop    %edi
  80268b:	5d                   	pop    %ebp
  80268c:	c3                   	ret    
  80268d:	8d 76 00             	lea    0x0(%esi),%esi
  802690:	31 ff                	xor    %edi,%edi
  802692:	31 c0                	xor    %eax,%eax
  802694:	89 fa                	mov    %edi,%edx
  802696:	83 c4 1c             	add    $0x1c,%esp
  802699:	5b                   	pop    %ebx
  80269a:	5e                   	pop    %esi
  80269b:	5f                   	pop    %edi
  80269c:	5d                   	pop    %ebp
  80269d:	c3                   	ret    
  80269e:	66 90                	xchg   %ax,%ax
  8026a0:	89 d8                	mov    %ebx,%eax
  8026a2:	f7 f7                	div    %edi
  8026a4:	31 ff                	xor    %edi,%edi
  8026a6:	89 fa                	mov    %edi,%edx
  8026a8:	83 c4 1c             	add    $0x1c,%esp
  8026ab:	5b                   	pop    %ebx
  8026ac:	5e                   	pop    %esi
  8026ad:	5f                   	pop    %edi
  8026ae:	5d                   	pop    %ebp
  8026af:	c3                   	ret    
  8026b0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8026b5:	89 eb                	mov    %ebp,%ebx
  8026b7:	29 fb                	sub    %edi,%ebx
  8026b9:	89 f9                	mov    %edi,%ecx
  8026bb:	d3 e6                	shl    %cl,%esi
  8026bd:	89 c5                	mov    %eax,%ebp
  8026bf:	88 d9                	mov    %bl,%cl
  8026c1:	d3 ed                	shr    %cl,%ebp
  8026c3:	89 e9                	mov    %ebp,%ecx
  8026c5:	09 f1                	or     %esi,%ecx
  8026c7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8026cb:	89 f9                	mov    %edi,%ecx
  8026cd:	d3 e0                	shl    %cl,%eax
  8026cf:	89 c5                	mov    %eax,%ebp
  8026d1:	89 d6                	mov    %edx,%esi
  8026d3:	88 d9                	mov    %bl,%cl
  8026d5:	d3 ee                	shr    %cl,%esi
  8026d7:	89 f9                	mov    %edi,%ecx
  8026d9:	d3 e2                	shl    %cl,%edx
  8026db:	8b 44 24 08          	mov    0x8(%esp),%eax
  8026df:	88 d9                	mov    %bl,%cl
  8026e1:	d3 e8                	shr    %cl,%eax
  8026e3:	09 c2                	or     %eax,%edx
  8026e5:	89 d0                	mov    %edx,%eax
  8026e7:	89 f2                	mov    %esi,%edx
  8026e9:	f7 74 24 0c          	divl   0xc(%esp)
  8026ed:	89 d6                	mov    %edx,%esi
  8026ef:	89 c3                	mov    %eax,%ebx
  8026f1:	f7 e5                	mul    %ebp
  8026f3:	39 d6                	cmp    %edx,%esi
  8026f5:	72 19                	jb     802710 <__udivdi3+0xfc>
  8026f7:	74 0b                	je     802704 <__udivdi3+0xf0>
  8026f9:	89 d8                	mov    %ebx,%eax
  8026fb:	31 ff                	xor    %edi,%edi
  8026fd:	e9 58 ff ff ff       	jmp    80265a <__udivdi3+0x46>
  802702:	66 90                	xchg   %ax,%ax
  802704:	8b 54 24 08          	mov    0x8(%esp),%edx
  802708:	89 f9                	mov    %edi,%ecx
  80270a:	d3 e2                	shl    %cl,%edx
  80270c:	39 c2                	cmp    %eax,%edx
  80270e:	73 e9                	jae    8026f9 <__udivdi3+0xe5>
  802710:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802713:	31 ff                	xor    %edi,%edi
  802715:	e9 40 ff ff ff       	jmp    80265a <__udivdi3+0x46>
  80271a:	66 90                	xchg   %ax,%ax
  80271c:	31 c0                	xor    %eax,%eax
  80271e:	e9 37 ff ff ff       	jmp    80265a <__udivdi3+0x46>
  802723:	90                   	nop

00802724 <__umoddi3>:
  802724:	55                   	push   %ebp
  802725:	57                   	push   %edi
  802726:	56                   	push   %esi
  802727:	53                   	push   %ebx
  802728:	83 ec 1c             	sub    $0x1c,%esp
  80272b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80272f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802733:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802737:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80273b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80273f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802743:	89 f3                	mov    %esi,%ebx
  802745:	89 fa                	mov    %edi,%edx
  802747:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80274b:	89 34 24             	mov    %esi,(%esp)
  80274e:	85 c0                	test   %eax,%eax
  802750:	75 1a                	jne    80276c <__umoddi3+0x48>
  802752:	39 f7                	cmp    %esi,%edi
  802754:	0f 86 a2 00 00 00    	jbe    8027fc <__umoddi3+0xd8>
  80275a:	89 c8                	mov    %ecx,%eax
  80275c:	89 f2                	mov    %esi,%edx
  80275e:	f7 f7                	div    %edi
  802760:	89 d0                	mov    %edx,%eax
  802762:	31 d2                	xor    %edx,%edx
  802764:	83 c4 1c             	add    $0x1c,%esp
  802767:	5b                   	pop    %ebx
  802768:	5e                   	pop    %esi
  802769:	5f                   	pop    %edi
  80276a:	5d                   	pop    %ebp
  80276b:	c3                   	ret    
  80276c:	39 f0                	cmp    %esi,%eax
  80276e:	0f 87 ac 00 00 00    	ja     802820 <__umoddi3+0xfc>
  802774:	0f bd e8             	bsr    %eax,%ebp
  802777:	83 f5 1f             	xor    $0x1f,%ebp
  80277a:	0f 84 ac 00 00 00    	je     80282c <__umoddi3+0x108>
  802780:	bf 20 00 00 00       	mov    $0x20,%edi
  802785:	29 ef                	sub    %ebp,%edi
  802787:	89 fe                	mov    %edi,%esi
  802789:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80278d:	89 e9                	mov    %ebp,%ecx
  80278f:	d3 e0                	shl    %cl,%eax
  802791:	89 d7                	mov    %edx,%edi
  802793:	89 f1                	mov    %esi,%ecx
  802795:	d3 ef                	shr    %cl,%edi
  802797:	09 c7                	or     %eax,%edi
  802799:	89 e9                	mov    %ebp,%ecx
  80279b:	d3 e2                	shl    %cl,%edx
  80279d:	89 14 24             	mov    %edx,(%esp)
  8027a0:	89 d8                	mov    %ebx,%eax
  8027a2:	d3 e0                	shl    %cl,%eax
  8027a4:	89 c2                	mov    %eax,%edx
  8027a6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027aa:	d3 e0                	shl    %cl,%eax
  8027ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  8027b0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027b4:	89 f1                	mov    %esi,%ecx
  8027b6:	d3 e8                	shr    %cl,%eax
  8027b8:	09 d0                	or     %edx,%eax
  8027ba:	d3 eb                	shr    %cl,%ebx
  8027bc:	89 da                	mov    %ebx,%edx
  8027be:	f7 f7                	div    %edi
  8027c0:	89 d3                	mov    %edx,%ebx
  8027c2:	f7 24 24             	mull   (%esp)
  8027c5:	89 c6                	mov    %eax,%esi
  8027c7:	89 d1                	mov    %edx,%ecx
  8027c9:	39 d3                	cmp    %edx,%ebx
  8027cb:	0f 82 87 00 00 00    	jb     802858 <__umoddi3+0x134>
  8027d1:	0f 84 91 00 00 00    	je     802868 <__umoddi3+0x144>
  8027d7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8027db:	29 f2                	sub    %esi,%edx
  8027dd:	19 cb                	sbb    %ecx,%ebx
  8027df:	89 d8                	mov    %ebx,%eax
  8027e1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8027e5:	d3 e0                	shl    %cl,%eax
  8027e7:	89 e9                	mov    %ebp,%ecx
  8027e9:	d3 ea                	shr    %cl,%edx
  8027eb:	09 d0                	or     %edx,%eax
  8027ed:	89 e9                	mov    %ebp,%ecx
  8027ef:	d3 eb                	shr    %cl,%ebx
  8027f1:	89 da                	mov    %ebx,%edx
  8027f3:	83 c4 1c             	add    $0x1c,%esp
  8027f6:	5b                   	pop    %ebx
  8027f7:	5e                   	pop    %esi
  8027f8:	5f                   	pop    %edi
  8027f9:	5d                   	pop    %ebp
  8027fa:	c3                   	ret    
  8027fb:	90                   	nop
  8027fc:	89 fd                	mov    %edi,%ebp
  8027fe:	85 ff                	test   %edi,%edi
  802800:	75 0b                	jne    80280d <__umoddi3+0xe9>
  802802:	b8 01 00 00 00       	mov    $0x1,%eax
  802807:	31 d2                	xor    %edx,%edx
  802809:	f7 f7                	div    %edi
  80280b:	89 c5                	mov    %eax,%ebp
  80280d:	89 f0                	mov    %esi,%eax
  80280f:	31 d2                	xor    %edx,%edx
  802811:	f7 f5                	div    %ebp
  802813:	89 c8                	mov    %ecx,%eax
  802815:	f7 f5                	div    %ebp
  802817:	89 d0                	mov    %edx,%eax
  802819:	e9 44 ff ff ff       	jmp    802762 <__umoddi3+0x3e>
  80281e:	66 90                	xchg   %ax,%ax
  802820:	89 c8                	mov    %ecx,%eax
  802822:	89 f2                	mov    %esi,%edx
  802824:	83 c4 1c             	add    $0x1c,%esp
  802827:	5b                   	pop    %ebx
  802828:	5e                   	pop    %esi
  802829:	5f                   	pop    %edi
  80282a:	5d                   	pop    %ebp
  80282b:	c3                   	ret    
  80282c:	3b 04 24             	cmp    (%esp),%eax
  80282f:	72 06                	jb     802837 <__umoddi3+0x113>
  802831:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802835:	77 0f                	ja     802846 <__umoddi3+0x122>
  802837:	89 f2                	mov    %esi,%edx
  802839:	29 f9                	sub    %edi,%ecx
  80283b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80283f:	89 14 24             	mov    %edx,(%esp)
  802842:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802846:	8b 44 24 04          	mov    0x4(%esp),%eax
  80284a:	8b 14 24             	mov    (%esp),%edx
  80284d:	83 c4 1c             	add    $0x1c,%esp
  802850:	5b                   	pop    %ebx
  802851:	5e                   	pop    %esi
  802852:	5f                   	pop    %edi
  802853:	5d                   	pop    %ebp
  802854:	c3                   	ret    
  802855:	8d 76 00             	lea    0x0(%esi),%esi
  802858:	2b 04 24             	sub    (%esp),%eax
  80285b:	19 fa                	sbb    %edi,%edx
  80285d:	89 d1                	mov    %edx,%ecx
  80285f:	89 c6                	mov    %eax,%esi
  802861:	e9 71 ff ff ff       	jmp    8027d7 <__umoddi3+0xb3>
  802866:	66 90                	xchg   %ax,%ax
  802868:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80286c:	72 ea                	jb     802858 <__umoddi3+0x134>
  80286e:	89 d9                	mov    %ebx,%ecx
  802870:	e9 62 ff ff ff       	jmp    8027d7 <__umoddi3+0xb3>
